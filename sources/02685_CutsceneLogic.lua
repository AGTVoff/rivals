-- Instance: StarterPlayer.StarterPlayerScripts.Modules.Maps.BaseTower.CutsceneLogic
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local ContentProvider = game:GetService("ContentProvider");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local SoundLibrary = require(ReplicatedStorage.Modules.SoundLibrary);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local StaticViewModel = require(Players.LocalPlayer.PlayerScripts.Modules.StaticModel.StaticViewModel);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 16
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.BaseTower = p2;
    v3._preloaded_sounds = {};
    v3._preloaded_animations = {};
    v3._cutscene_hash = 0;
    v3._cutscene_renderstep_id = nil;
    v3._cutscene_animation_tracks = {};
    v3._cutscene_cleanup = {};
    v3._cutscene_threads = {};
    v3._cutscene_hidden_duelers = {};
    v3:_Init();

    return v3;
end;

function u1.GetCutsceneHash(p4) -- Line: 39
    return p4._cutscene_hash;
end;

function u1.GetPreloadedAnimation(p5, p6) -- Line: 43
    return p5._preloaded_animations[p6];
end;

function u1.PreloadAnimation(p7, p8, p9) -- Line: 47
    -- upvalues: ContentProvider (copy)
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p9;
    p7._preloaded_animations[p8] = Animation;
    task.spawn(pcall, ContentProvider.PreloadAsync, ContentProvider, { Animation });
end;

function u1.PlayAnimation(p10, p11, p12, p13) -- Line: 54
    if not p11 then
        return;
    end;

    local success, result = pcall(p11.LoadAnimation, p11, p12);

    if not success then
        warn("Animation " .. p12.AnimationId .. " failed to animate, error:", result);

        return;
    end;

    result:Play(0);
    table.insert(p10._cutscene_animation_tracks, result);
    table.insert(p10._cutscene_threads, task.spawn(p13, result));
end;

function u1.StopCutscene(p14) -- Line: 70
    -- upvalues: RunService (copy)
    p14._cutscene_hash = p14._cutscene_hash + 1;

    for _, v in pairs(p14._cutscene_animation_tracks) do
        v:Stop(0);
        v:Destroy();
    end;

    for _, v in pairs(p14._cutscene_cleanup) do
        v:Destroy();
    end;

    for _, v in pairs(p14._cutscene_threads) do
        pcall(task.cancel, v);
    end;

    for i in pairs(p14._cutscene_hidden_duelers) do
        i:SetReplicate("IsHiddenByCutscene", nil);
    end;

    p14._cutscene_animation_tracks = {};
    p14._cutscene_cleanup = {};
    p14._cutscene_threads = {};
    p14._cutscene_hidden_duelers = {};

    if p14._cutscene_renderstep_id then
        RunService:UnbindFromRenderStep(p14._cutscene_renderstep_id);
        p14._cutscene_renderstep_id = nil;
    end;
end;

function u1.PlayCutscene(u15, p16, p17, p18, p19, p20, u21, p22, u23, p24) -- Line: 101
    -- upvalues: HttpService (copy), StaticViewModel (copy), UserInputService (copy), TweenService (copy), RunService (copy), CameraController (copy)
    u15:StopCutscene();
    u15._cutscene_renderstep_id = "ZombieTowerCutscene" .. HttpService:GenerateGUID(false);
    u15._cutscene_hash = u15._cutscene_hash + 1;
    local _cutscene_hash = u15._cutscene_hash;

    if p17 then
        table.insert(u15._cutscene_threads, task.spawn(p17, _cutscene_hash, u15._cutscene_cleanup, u15._cutscene_animation_tracks));
    end;

    local HumanoidRootPart = p19.Parent.HumanoidRootPart;
    local v25 = {};
    local u26 = {};
    local u27 = {};
    local u28 = { p18 };

    for _, v in pairs(u15.BaseTower.ClientDuel.Duelers) do
        if v.ClientFighter then
            v.ClientFighter:SetReplicate("IsHiddenByCutscene", true);
            u15._cutscene_hidden_duelers[v.ClientFighter] = true;

            if v.ClientFighter:IsAlive() and #v25 < p22 then
                table.insert(v25, v);
            end;
        end;
    end;

    if #v25 == 0 then
        return;
    end;

    table.sort(v25, function(p29, p30) -- Line: 138
        return p29.Player.UserId < p30.Player.UserId;
    end);

    for i, v in pairs(v25) do
        local CharacterModelForCutscene = v:GetCharacterModelForCutscene();
        CharacterModelForCutscene.Name = "CutscenePlayer" .. i;
        CharacterModelForCutscene:SetPrimaryPartCFrame(HumanoidRootPart.CFrame);
        CharacterModelForCutscene.Parent = p19.Parent.Parent;
        table.insert(u26, CharacterModelForCutscene);
        table.insert(u15._cutscene_cleanup, CharacterModelForCutscene);

        if p24 then
            local v31 = v.ClientFighter.EquippedItem and v.ClientFighter.EquippedItem:GetViewModelDetails();
            local v32;

            if v31 then
                v32 = StaticViewModel.new(v31.ViewModelName);
            else
                v32 = v31;
            end;

            if v32 then
                if v32:HasGripAttachment() then
                    v32:DeleteAnimationContextSubModels();
                    v32:SetWrap(v31.Wrap);
                    v32:SetCharm(v31.Charm);
                    v32:ScaleTo(i == 1 and 1.5 or 1.25);
                    v32:InitializeGrip();
                    v32:SetParent(CharacterModelForCutscene);
                    table.insert(u15._cutscene_cleanup, v32);
                    u27[v32] = CharacterModelForCutscene;
                else
                    task.defer(v32.Destroy, v32);
                end;
            end;
        end;

        local success, result = pcall(function() -- Line: 170
            -- upvalues: CharacterModelForCutscene (copy), u15 (copy), u23 (copy), i (copy)
            local v33 = CharacterModelForCutscene.Humanoid:LoadAnimation(u15:GetPreloadedAnimation(u23 .. i));
            v33:Play(0);
            table.insert(u15._cutscene_animation_tracks, v33);
        end);

        if not success then
            warn("Player " .. i .. " failed to animate, error:", result);
            CharacterModelForCutscene.Parent = nil;
        end;
    end;

    table.insert(u28, function(p34) -- Line: 182
        -- upvalues: u26 (copy), HumanoidRootPart (copy), u27 (copy)
        for _, v in pairs(u26) do
            v:SetPrimaryPartCFrame(HumanoidRootPart.CFrame);
        end;

        for i, v in pairs(u27) do
            i:GripPivotTo(v);
        end;
    end);
    local Cam = p19.Parent:FindFirstChild("Cam");

    if not Cam then
        return;
    end;

    u15:PlayAnimation(p19, p20, function(p35) -- Line: 201
        -- upvalues: u21 (copy), u28 (copy), UserInputService (ref), Cam (copy), TweenService (ref), RunService (ref), _cutscene_hash (copy), u15 (copy)
        local u36 = u21[1][2];
        table.insert(u28, function(p37) -- Line: 204
            -- upvalues: UserInputService (ref), u36 (ref), Cam (ref)
            UserInputService.MouseIconEnabled = true;
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
            workspace.CurrentCamera.FieldOfView = u36;
            workspace.CurrentCamera.CFrame = Cam.CFrame;
        end);
        local v38 = 0;

        for i, v in pairs(u21) do
            local v39 = u21[math.max(1, i - 1)][2];
            local _, v40, v41, v42, v43 = table.unpack(v);
            local v44 = v[1] - v38;

            if v41 then
                v38 = v38 + wait(v44);
                u36 = v40;
            else
                local v45 = tick();

                while tick() < v45 + v44 do
                    if v44 == 0 then
                        u36 = v40;
                    else
                        u36 = v39 + (v40 - v39) * TweenService:GetValue((tick() - v45) / v44, v42 or Enum.EasingStyle.Quad, v43 or Enum.EasingDirection.InOut);
                    end;

                    v38 = v38 + RunService.RenderStepped:Wait();

                    if _cutscene_hash ~= u15._cutscene_hash then
                        return;
                    end;
                end;
            end;
        end;
    end);
    RunService:BindToRenderStep(u15._cutscene_renderstep_id, CameraController:GetRenderstepPriority() + 1, function(p46) -- Line: 239
        -- upvalues: u15 (copy), u28 (copy)
        if not u15.BaseTower.ClientDuel:Get("IsSpectating") then
            return;
        end;

        for _, v in pairs(u28) do
            v(p46);
        end;
    end);
    wait(p16);

    if _cutscene_hash ~= u15._cutscene_hash then
        return;
    end;

    u15:StopCutscene();
end;

function u1.PreloadCutsceneSoundIDs(p47, p48) -- Line: 259
    -- upvalues: SoundLibrary (copy)
    for _, v in pairs(SoundLibrary:PreloadSounds(p48)) do
        table.insert(p47._preloaded_sounds, v);
    end;
end;

function u1.Destroy(p49) -- Line: 265
    for _, v in pairs(p49._preloaded_sounds) do
        v:Destroy();
    end;

    for _, v in pairs(p49._preloaded_animations) do
        v:Destroy();
    end;

    p49:StopCutscene();
end;

function u1._Init(p50) -- Line: 281
end;

return u1;