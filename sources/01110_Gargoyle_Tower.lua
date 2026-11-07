-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.Maps.Gargoyle Tower
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local BaseTower = require(Players.LocalPlayer.PlayerScripts.Modules.Maps:WaitForChild("BaseTower"));
local u1 = {
    CameraAnimationID = "rbxassetid://91304936355794",
    MinibossAnimationID = "rbxassetid://110702524889355",
    PlayersAnimationIDs = { "rbxassetid://72779372805547", "rbxassetid://85372225938107", "rbxassetid://76166033125093", "rbxassetid://72705430483246" },
    FOVMarkers = { { 0, 27, true } }
};
local u2 = {
    CameraAnimationID = "rbxassetid://140630537896995",
    MinibossAnimationID = "rbxassetid://119161985796057",
    PlayersAnimationIDs = { "rbxassetid://73765092682746", "rbxassetid://128251419280478", "rbxassetid://87644263623750", "rbxassetid://81457379942058" },
    FOVMarkers = {
        { 0, 30, true },
        { 3.117, 30, true },
        { 5.217, 60 },
        {
            9.342,
            60,
            nil,
            Enum.EasingStyle.Linear
        },
        { 14.333, 40 }
    }
};
local u3 = {
    Solo = {
        CameraAnimationID = "rbxassetid://76004085070158",
        PlayersAnimationIDs = { "rbxassetid://128423516380583" },
        FOVMarkers = { { 0, 30 } }
    },
    Team = {
        CameraAnimationID = "rbxassetid://74541276024086",
        PlayersAnimationIDs = { "rbxassetid://87817454386868", "rbxassetid://85214705237146", "rbxassetid://85463328453593", "rbxassetid://83557814004483" },
        FOVMarkers = { { 0, 30 } }
    }
};
local u4 = {
    CameraAnimationID = "rbxassetid://82721596198038",
    BossAnimationID = "rbxassetid://82940353328327",
    DestructionAnimationID = "rbxassetid://108906257884198",
    PlayersAnimationIDs = { "rbxassetid://132478476724070", "rbxassetid://87448134299264", "rbxassetid://125622174653361", "rbxassetid://115710864051370" },
    FOVMarkers = { { 0, 50, true }, { 4.017, 65, true }, { 19.333, 20, true }, { 20.7, 20, true }, { 21.533, 20 }, { 22.367, 20, true }, { 23.567, 50 }, { 24.533, 45, true } }
};
local u5 = {
    CameraAnimationID = "rbxassetid://124109678261806",
    BossAnimationID = "rbxassetid://137814878872905",
    PlayersAnimationIDs = { "rbxassetid://73225171387600", "rbxassetid://93554947024541", "rbxassetid://124961338872440", "rbxassetid://106248403628647" },
    FOVMarkers = { { 0, 60 } }
};
local u6 = { "rbxassetid://105037817494559", "rbxassetid://85895097625020", "rbxassetid://107999335264095", "rbxassetid://72483809453170", "rbxassetid://129922197154277", "rbxassetid://113975047764762", "rbxassetid://119857994193720", "rbxassetid://128361063555965", "rbxassetid://79367345974451", "rbxassetid://130623066255489", "rbxassetid://89602387965260", "rbxassetid://134885608230805", "rbxassetid://104718122128210", "rbxassetid://134852748577803", "rbxassetid://85095991853139" };
local u7 = setmetatable({}, BaseTower);
u7.__index = u7;

function u7.new(...) -- Line: 79
    -- upvalues: BaseTower (copy), u7 (copy)
    local v8 = BaseTower.new(...);
    local v9 = setmetatable(v8, u7);
    v9._cutscenes_folder = v9.Model:WaitForChild("Cutscenes");
    v9._cutscene_floor10_folder = v9._cutscenes_folder:WaitForChild("Floor10");
    v9._cutscene_floor10_camera_rig_animation_controller = v9._cutscene_floor10_folder:WaitForChild("CameraRig"):WaitForChild("AnimationController");
    v9._cutscene_floor17_folder = v9._cutscenes_folder:WaitForChild("Floor17");
    v9._cutscene_floor17_camera_rig_animation_controller = v9._cutscene_floor17_folder:WaitForChild("CameraRig"):WaitForChild("AnimationController");
    v9._cutscene_floor17_destruction_rig_animation_controller = v9._cutscene_floor17_folder:WaitForChild("DestructionRig"):WaitForChild("AnimationController");
    v9._use_custom_scoreboard_display = false;
    v9._triggers_found = {};
    v9:_Init();

    return v9;
end;

function u7.GetScoreboardDisplay(p10, ...) -- Line: 100
    -- upvalues: BaseTower (copy)
    if p10._use_custom_scoreboard_display then
        return p10.Name .. "   •   Floor 0";
    end;

    return BaseTower.GetScoreboardDisplay(p10, ...);
end;

function u7.Update(p11, p12) -- Line: 108
    -- upvalues: Utility (copy), CollectionService (copy)
    local v13 = Utility:AngleBetweenVectors(workspace.CurrentCamera.CFrame.LookVector, Vector3.new(0, 1, 0)) / 1.5707963267948966;
    local math_clamp_ret = math.clamp(v13, 0, 1);

    for _, v in pairs(CollectionService:GetTagged("GargoyleTowerRain")) do
        if v:IsDescendantOf(p11.Model) then
            local Lines = v:FindFirstChild("Lines");
            local Dots = v:FindFirstChild("Dots");

            if Lines then
                Lines.LocalTransparencyModifier = 1 - math_clamp_ret;
            end;

            if Dots then
                Dots.LocalTransparencyModifier = math_clamp_ret;
            end;
        end;
    end;
end;

function u7.ReplicateFromServer(p14, p15, ...) -- Line: 129
    -- upvalues: BaseTower (copy)
    if p15 == "GargoyleTowerPlayCutsceneFloor10MinibossReveal" then
        if not p14:IsRendered() then
            return;
        end;

        p14:_PlayCutsceneFloor10MinibossReveal(...);

        return;
    end;

    if p15 == "GargoyleTowerPlayCutsceneFloor10MinibossDeath" then
        if not p14:IsRendered() then
            return;
        end;

        p14:_PlayCutsceneFloor10MinibossDeath(...);

        return;
    end;

    if p15 == "GargoyleTowerPlayCutsceneFloor17Intro" then
        if not p14:IsRendered() then
            return;
        end;

        p14:_PlayCutsceneFloor17Intro(...);

        return;
    end;

    if p15 == "GargoyleTowerPlayCutsceneFloor17BossReveal" then
        if not p14:IsRendered() then
            return;
        end;

        p14:_PlayCutsceneFloor17BossReveal(...);

        return;
    end;

    if p15 ~= "GargoyleTowerPlayCutsceneFloor17Falling" then
        BaseTower.ReplicateFromServer(p14, p15, ...);

        return;
    end;

    if not p14:IsRendered() then
        return;
    end;

    p14:_PlayCutsceneFloor17Falling(...);
end;

function u7._PlayCutsceneFloor10MinibossDeath(u16, p17, u18) -- Line: 169
    -- upvalues: u2 (copy)
    for _, v in pairs(u18:GetPlayingAnimationTracks()) do
        v:Stop(0);
    end;

    u16.CutsceneLogic:PlayCutscene(p17, function(p19) -- Line: 174, Name: init_callback
        -- upvalues: u16 (copy), u18 (copy)
        u16.CutsceneLogic:PlayAnimation(u18, u16.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor10MinibossDeathMiniboss"), function(p20) -- Line: 175
            -- upvalues: u16 (ref)
            wait(2);
            u16:CreateSound("rbxassetid://85095991853139", 2 + 0.25 * math.random(), 0.7 + 0.1 * math.random(), script, true);
            u16:CreateSound("rbxassetid://85095991853139", 3 + 0.25 * math.random(), 1.25 + 0.1 * math.random(), script, true);
            wait(2);
            u16:CreateSound("rbxassetid://104718122128210", 1 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            wait(0.825);
            u16:CreateSound("rbxassetid://104718122128210", 1.25 + 0.25 * math.random(), 1.5 + 0.2 * math.random(), script, true);
        end);
    end, function(p21) -- Line: 186, Name: renderstep_callback
    end, u16._cutscene_floor10_camera_rig_animation_controller, u16.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor10MinibossDeathCamera"), u2.FOVMarkers, #u2.PlayersAnimationIDs, "GargoyleTowerFloor10MinibossDeathPlayer", false);
end;

function u7._PlayCutsceneFloor10MinibossReveal(u22, p23, u24) -- Line: 205
    -- upvalues: u1 (copy)
    task.spawn(function() -- Line: 206
        -- upvalues: u22 (copy)
        u22.Model.Cutscenes.Floor10["Giant Gargoyle Statue"]:Destroy();
    end);
    u22.CutsceneLogic:PlayCutscene(p23, function(p25) -- Line: 210, Name: init_callback
        -- upvalues: u22 (copy), u24 (copy)
        u22.CutsceneLogic:PlayAnimation(u24, u22.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor10MinibossRevealMiniboss"), function(p26) -- Line: 211
            -- upvalues: u22 (ref)
            wait(6.8);
            u22:CreateSound("rbxassetid://134852748577803", 3 + 0.2 * math.random(), 0.3 + 0.05 * math.random(), script, true);
            wait(8.5);
            u22:CreateSound("rbxassetid://79367345974451", 0.6 + 0.2 * math.random(), 1.25 + 0.2 * math.random(), script, true);
            u22:CreateSound("rbxassetid://130623066255489", 0.6 + 0.2 * math.random(), 1.25 + 0.2 * math.random(), script, true);
            u22:CreateSound("rbxassetid://89602387965260", 0.6 + 0.2 * math.random(), 1.25 + 0.2 * math.random(), script, true);
            wait(3.42);
            u22:CreateSound("rbxassetid://72483809453170", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            wait(1.4);
            u22:CreateSound("rbxassetid://104718122128210", 0.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            wait(1);
            u22:CreateSound("rbxassetid://85095991853139", 2.5 + 0.25 * math.random(), 0.7 + 0.1 * math.random(), script, true);
        end);
    end, function(p27) -- Line: 227, Name: renderstep_callback
    end, u22._cutscene_floor10_camera_rig_animation_controller, u22.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor10MinibossRevealCamera"), u1.FOVMarkers, #u1.PlayersAnimationIDs, "GargoyleTowerFloor10MinibossRevealPlayer", false);
end;

function u7._ShouldUseSoloCutsceneAnimations(p28) -- Line: 246
    local v29 = 0;

    for _, v in pairs(p28.ClientDuel:GetFighters()) do
        v29 = v29 + (v:IsAlive() and 1 or 0);
    end;

    return v29 <= 1;
end;

function u7._PlayCutsceneFloor17Intro(p30, u31) -- Line: 256
    -- upvalues: Lighting (copy), BetterDebris (copy), Utility (copy), u3 (copy)
    local v32 = p30:_ShouldUseSoloCutsceneAnimations() and "Solo" or "Team";
    p30.CutsceneLogic:PlayCutscene(u31, function(p33) -- Line: 259, Name: init_callback
        -- upvalues: Lighting (ref), BetterDebris (ref), u31 (copy), Utility (ref)
        task.delay(25, function() -- Line: 260
            -- upvalues: Lighting (ref), BetterDebris (ref), u31 (ref), Utility (ref)
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Name = "GargoyleTowerCutsceneFloor17Intro";
            ColorCorrectionEffect.Parent = Lighting;
            BetterDebris:AddItem(ColorCorrectionEffect, u31 - 25);
            Utility:RenderstepForLoop(0, 100, 2, function(p34) -- Line: 266
                -- upvalues: ColorCorrectionEffect (copy)
                ColorCorrectionEffect.Brightness = 0 + -1 * (p34 / 100) ^ 4;
            end);
        end);
    end, function(p35) -- Line: 274, Name: renderstep_callback
    end, p30._cutscene_floor17_camera_rig_animation_controller, p30.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor17Intro" .. v32 .. "Camera"), u3[v32].FOVMarkers, #u3[v32].PlayersAnimationIDs, "GargoyleTowerFloor17Intro" .. v32 .. "Player", false);
end;

function u7._PlayCutsceneFloor17BossReveal(u36, u37, u38) -- Line: 293
    -- upvalues: Lighting (copy), BetterDebris (copy), Utility (copy), u4 (copy)
    task.spawn(function() -- Line: 294
        -- upvalues: u36 (copy)
        u36.Model.Cutscenes.Floor17["Giant Acidic Gargoyle Statue"]:Destroy();
    end);
    u36.CutsceneLogic:PlayCutscene(u37, function(u39) -- Line: 298, Name: init_callback
        -- upvalues: u36 (copy), u38 (copy), u37 (copy), Lighting (ref), BetterDebris (ref), Utility (ref)
        u36.CutsceneLogic:PlayAnimation(u38, u36.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor17BossRevealBoss"), function(p40) -- Line: 299
            -- upvalues: u36 (ref)
            wait(8.5);
            u36:CreateSound("rbxassetid://79367345974451", 0.8 + 0.2 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            u36:CreateSound("rbxassetid://130623066255489", 0.8 + 0.2 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            u36:CreateSound("rbxassetid://89602387965260", 0.8 + 0.2 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            wait(9.75);
            u36:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            wait(0.75);
            u36:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            wait(0.33);
            u36:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            wait(0.42);
            u36:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            wait(0.5);
            u36:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            wait(1.25);
            u36:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            wait(0.83);
            u36:CreateSound("rbxassetid://128361063555965", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            wait(1.33);
            u36:CreateSound("rbxassetid://128361063555965", 2.25 + 0.25 * math.random(), 1.25 + 0.2 * math.random(), script, true);
        end);
        u36.CutsceneLogic:PlayAnimation(u36._cutscene_floor17_destruction_rig_animation_controller, u36.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor17BossRevealDestruction"), function(p41) -- Line: 322
            -- upvalues: u36 (ref)
            wait(13.65);
            u36:CreateSound("rbxassetid://105037817494559", 1, 1, script, true);
            u36:CreateSound("rbxassetid://85895097625020", 1, 0.75, script, true);
            wait(11.35);
            u36:CreateSound("rbxassetid://107999335264095", 0.75, 1, script, true);
            u36:CreateSound("rbxassetid://107999335264095", 1, 0.75, script, true);
        end);
        task.delay(13.65, function() -- Line: 331
            -- upvalues: u39 (copy), u36 (ref)
            if u39 ~= u36.CutsceneLogic:GetCutsceneHash() then
                return;
            end;

            u36._cutscene_floor17_folder.Roof.Broken.Transparency = u36._cutscene_floor17_folder.Roof.Unbroken.Transparency;
            u36._cutscene_floor17_folder.Roof.Unbroken.Transparency = 1;
            local v42 = {};

            for _, descendant in pairs(u36.Model.Extra:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    v42[descendant] = { "TimeScale", descendant.TimeScale };
                    descendant.TimeScale = descendant.TimeScale * 0.1;
                elseif descendant:IsA("Beam") then
                    v42[descendant] = { "TextureSpeed", descendant.TextureSpeed };
                    descendant.TextureSpeed = descendant.TextureSpeed * 0.1;
                end;
            end;

            wait(4.35);

            for i, v in pairs(v42) do
                i[v[1]] = v[2];
            end;
        end);
        task.delay(u37 - 2, function() -- Line: 359
            -- upvalues: Lighting (ref), BetterDebris (ref), Utility (ref)
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Name = "GargoyleTowerCutsceneFloor17BossReveal";
            ColorCorrectionEffect.Parent = Lighting;
            BetterDebris:AddItem(ColorCorrectionEffect, 10);
            Utility:RenderstepForLoop(0, 100, 2, function(p43) -- Line: 365
                -- upvalues: ColorCorrectionEffect (copy)
                ColorCorrectionEffect.Brightness = 0 + -1 * (p43 / 100) ^ 4;
            end);
            wait(2);
            Utility:RenderstepForLoop(0, 100, 2, function(p44) -- Line: 373
                -- upvalues: ColorCorrectionEffect (copy)
                ColorCorrectionEffect.Brightness = -1 + 1 * (1 - (1 - p44 / 100) ^ 4);
            end);
            ColorCorrectionEffect:Destroy();
        end);
    end, function(p45) -- Line: 383, Name: renderstep_callback
    end, u36._cutscene_floor17_camera_rig_animation_controller, u36.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor17BossRevealCamera"), u4.FOVMarkers, #u4.PlayersAnimationIDs, "GargoyleTowerFloor17BossRevealPlayer", false);
end;

function u7._PlayCutsceneFloor17Falling(u46, u47, u48) -- Line: 402
    -- upvalues: Lighting (copy), BetterDebris (copy), Utility (copy), u5 (copy)
    u46._use_custom_scoreboard_display = true;
    u46.CutsceneLogic:PlayCutscene(u47, function(p49) -- Line: 405, Name: init_callback
        -- upvalues: u46 (copy), u48 (copy), u47 (copy), Lighting (ref), BetterDebris (ref), Utility (ref)
        u46.CutsceneLogic:PlayAnimation(u48, u46.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor17FallingBoss"), function(p50) -- Line: 406
            -- upvalues: u46 (ref)
            local v51 = { 0.55, 1.3, 1.9, 2.45, 2.95, 3.45, 3.95, 4.3, 4.7, 5.1, 5.5, 5.9, 6.3, 6.7, 7.1 };

            for i, v in pairs(v51) do
                wait(v - (v51[i - 1] or 0));
                u46:CreateSound("rbxassetid://72483809453170", 1.5 - 1 * i / 18, 0.9 + 0.2 * math.random(), script, true);
            end;
        end);
        task.delay(u47 - 0.75, function() -- Line: 415
            -- upvalues: Lighting (ref), BetterDebris (ref), u46 (ref), Utility (ref)
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Name = "GargoyleTowerCutsceneFloor17Falling";
            ColorCorrectionEffect.Brightness = -1;
            ColorCorrectionEffect.Parent = Lighting;
            BetterDebris:AddItem(ColorCorrectionEffect, 10);
            u46:CreateSound("rbxassetid://72483809453170", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            u46:CreateSound("rbxassetid://129922197154277", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            u46:CreateSound("rbxassetid://113975047764762", 1.5 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true);
            wait(1);
            Utility:RenderstepForLoop(0, 100, 0.5, function(p52) -- Line: 428
                -- upvalues: ColorCorrectionEffect (copy)
                local v53 = p52 / 100;
                ColorCorrectionEffect.Brightness = -1 + 1 * (math.sin(12.566370614359172 * v53) * 0.125 + v53);
            end);
            ColorCorrectionEffect:Destroy();
        end);
    end, function(p54) -- Line: 439, Name: renderstep_callback
    end, u46._cutscene_floor17_camera_rig_animation_controller, u46.CutsceneLogic:GetPreloadedAnimation("GargoyleTowerFloor17FallingCamera"), u5.FOVMarkers, #u5.PlayersAnimationIDs, "GargoyleTowerFloor17FallingPlayer", false);
end;

function u7._Floor17LeverTriggerAdded(u55, u56) -- Line: 458
    -- upvalues: Utility (copy)
    if u55._triggers_found[u56] or not u56:IsDescendantOf(u55.Model) then
        return;
    end;

    u55._triggers_found[u56] = true;
    local u57 = false;

    local function check() -- Line: 467
        -- upvalues: u57 (ref), u56 (copy), u55 (copy), Utility (ref)
        if u57 or not u56:GetAttribute("Triggered") then
            return;
        end;

        u57 = true;
        u55.Model.Cutscenes.Floor17.Lever:PivotTo(u55.Model.Cutscenes.Floor17.Lever:GetPivot() * CFrame.Angles(-1.1344640137963142, 0, 0));
        u55.Model.Cutscenes.Floor17.Lever.Particles:Destroy();
        u55:CreateSound("rbxassetid://119857994193720", 1.25, 1, script, true);
        local u58 = {};

        for _, child in pairs(u55.Model.Cutscenes.Floor17.AcidTubes:GetChildren()) do
            table.insert(u58, { child, child.Size, child.CFrame });
        end;

        Utility:RenderstepForLoop(0, 100, 0.1, function(p59) -- Line: 484
            -- upvalues: u58 (copy)
            local v60 = 1 - p59 / 100;

            for _, v in pairs(u58) do
                v[1].Size = v[2] * Vector3.new(v60, 1, 1);
                v[1].CFrame = v[3] * CFrame.new(v[2].X / 2 - v[1].Size.X / 2, 0, 0);
            end;
        end);

        for _, v in pairs(u58) do
            v[1].Transparency = 1;
        end;
    end;

    u56:GetAttributeChangedSignal("Triggered"):Connect(check);
    check();
end;

function u7._Floor15GateTriggerAdded(u61, u62) -- Line: 502
    if u61._triggers_found[u62] or not u62:IsDescendantOf(u61.Model) then
        return;
    end;

    u61._triggers_found[u62] = true;
    local u63 = false;

    local function v64() -- Line: 511
        -- upvalues: u63 (ref), u62 (copy), u61 (copy)
        if u63 or not u62:GetAttribute("Triggered") then
            return;
        end;

        u63 = true;
        u61.Model.Floors["15"].Important.Gates:PivotTo(u61.Model.Floors["15"].Important.Gates:GetPivot() + Vector3.new(0, 20, 0));
        u61:CreateSound("rbxassetid://134885608230805", 2, 1, script, true);
    end;

    u62:GetAttributeChangedSignal("Triggered"):Connect(v64);
    v64();
end;

function u7._Floor11EntranceParticlesAdded(p65, p66) -- Line: 526
    -- upvalues: Utility (copy)
    if not p66:IsDescendantOf(p65.Model) then
        return;
    end;

    task.delay(0, Utility.PlayParticles, Utility, p66);
    p65:CreateSound("rbxassetid://72483809453170", 1.5, 0.9 + 0.2 * math.random(), script, true);
end;

function u7._Setup(p67) -- Line: 535
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u4 (copy), u5 (copy), u6 (copy)
    p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor10MinibossRevealCamera", u1.CameraAnimationID);
    p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor10MinibossRevealMiniboss", u1.MinibossAnimationID);

    for i, v in pairs(u1.PlayersAnimationIDs) do
        p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor10MinibossRevealPlayer" .. i, v);
    end;

    p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor10MinibossDeathCamera", u2.CameraAnimationID);
    p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor10MinibossDeathMiniboss", u2.MinibossAnimationID);

    for i, v in pairs(u2.PlayersAnimationIDs) do
        p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor10MinibossDeathPlayer" .. i, v);
    end;

    p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17IntroSoloCamera", u3.Solo.CameraAnimationID);

    for i, v in pairs(u3.Solo.PlayersAnimationIDs) do
        p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17IntroSoloPlayer" .. i, v);
    end;

    p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17IntroTeamCamera", u3.Team.CameraAnimationID);

    for i, v in pairs(u3.Team.PlayersAnimationIDs) do
        p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17IntroTeamPlayer" .. i, v);
    end;

    p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17BossRevealCamera", u4.CameraAnimationID);
    p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17BossRevealBoss", u4.BossAnimationID);
    p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17BossRevealDestruction", u4.DestructionAnimationID);

    for i, v in pairs(u4.PlayersAnimationIDs) do
        p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17BossRevealPlayer" .. i, v);
    end;

    p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17FallingCamera", u5.CameraAnimationID);
    p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17FallingBoss", u5.BossAnimationID);

    for i, v in pairs(u5.PlayersAnimationIDs) do
        p67.CutsceneLogic:PreloadAnimation("GargoyleTowerFloor17FallingPlayer" .. i, v);
    end;

    p67.CutsceneLogic:PreloadCutsceneSoundIDs(u6);
end;

function u7._Init(u68) -- Line: 587
    -- upvalues: CollectionService (copy)
    local _connections = u68._connections;
    local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal("GargoyleTowerFloor17LeverTrigger");
    table.insert(_connections, InstanceAddedSignal:Connect(function(p69) -- Line: 588
        -- upvalues: u68 (copy)
        u68:_Floor17LeverTriggerAdded(p69);
    end));
    local _connections2 = u68._connections;
    local InstanceAddedSignal2 = CollectionService:GetInstanceAddedSignal("GargoyleTowerFloor15GateTrigger");
    table.insert(_connections2, InstanceAddedSignal2:Connect(function(p70) -- Line: 592
        -- upvalues: u68 (copy)
        u68:_Floor15GateTriggerAdded(p70);
    end));
    local _connections3 = u68._connections;
    local InstanceAddedSignal3 = CollectionService:GetInstanceAddedSignal("GargoyleTowerFloor11EntranceParticles");
    table.insert(_connections3, InstanceAddedSignal3:Connect(function(p71) -- Line: 596
        -- upvalues: u68 (copy)
        u68:_Floor11EntranceParticlesAdded(p71);
    end));

    for _, v in pairs(CollectionService:GetTagged("GargoyleTowerFloor17LeverTrigger")) do
        task.defer(u68._Floor17LeverTriggerAdded, u68, v);
    end;

    for _, v in pairs(CollectionService:GetTagged("GargoyleTowerFloor15GateTrigger")) do
        task.defer(u68._Floor15GateTriggerAdded, u68, v);
    end;

    for _, v in pairs(CollectionService:GetTagged("GargoyleTowerFloor11EntranceParticles")) do
        task.defer(u68._Floor11EntranceParticlesAdded, u68, v);
    end;

    u68:_Setup();
    u68.ClientDuel:SetReplicate("DuelMusic", "GargoyleTower");
end;

return u7;