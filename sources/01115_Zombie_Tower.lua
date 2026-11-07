-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.Maps.Zombie Tower
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local BaseTower = require(Players.LocalPlayer.PlayerScripts.Modules.Maps:WaitForChild("BaseTower"));
local ChickenTrojanExplosionEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ChickenTrojanExplosionEffect");
local u1 = { "rbxassetid://98587858115094", "rbxassetid://72483809453170", "rbxassetid://129922197154277", "rbxassetid://113975047764762", "rbxassetid://121368500414901" };
local u2 = { "rbxassetid://116380542394210", "rbxassetid://125379277208360", "rbxassetid://96610433230092", "rbxassetid://122643453923681", "rbxassetid://94468135009167", "rbxassetid://133107467882960", "rbxassetid://122210005572726", "rbxassetid://102260065267741" };
local u3 = { { 0, 24 }, { 9.97, 24 }, { 10.53, 17 }, { 10.87, 17 }, { 11.62, 30 }, { 11.83, 30 }, { 12.55, 17 }, { 13.03, 30 }, { 16.52, 30 }, { 17.53, 10 }, { 19.12, 30, true }, { 22.9, 50 }, { 23.4, 20 }, { 24.58, 50 }, { 26.02, 35 } };
local u4 = setmetatable({}, BaseTower);
u4.__index = u4;

function u4.new(...) -- Line: 41
    -- upvalues: BaseTower (copy), u4 (copy)
    local v5 = BaseTower.new(...);
    local v6 = setmetatable(v5, u4);
    v6:_Init();

    return v6;
end;

function u4.ReplicateFromServer(p7, p8, ...) -- Line: 53
    -- upvalues: BaseTower (copy)
    if p8 == "ChickenTrojanEffect" then
        if not p7:IsRendered() then
            return;
        end;

        p7:_ChickenTrojanEffect(...);

        return;
    end;

    if p8 ~= "GiantChombieCutscene" then
        BaseTower.ReplicateFromServer(p7, p8, ...);

        return;
    end;

    if not p7:IsRendered() then
        return;
    end;

    p7:_PlayCutscene(...);
end;

function u4._PlayCutscene(u9, u10, u11, p12) -- Line: 75
    -- upvalues: Utility (copy), u3 (copy), u2 (copy)
    u9.CutsceneLogic:PlayCutscene(p12, function(p13) -- Line: 76, Name: init_callback
        -- upvalues: u9 (copy), u10 (copy), Utility (ref), u11 (copy)
        u9.CutsceneLogic:PlayAnimation(u10, u9.CutsceneLogic:GetPreloadedAnimation("GiantChombieHumanoid"), function(p14) -- Line: 77
            -- upvalues: Utility (ref), u11 (ref), u9 (ref)
            task.delay(23.1, Utility.PlayParticles, Utility, u11:WaitForChild("SlamParticles"));
            wait(1.25);
            u9:CreateSound("rbxassetid://72483809453170", 0.35, 0.675, script, true, 10);
            wait(3.2);
            u9:CreateSound("rbxassetid://72483809453170", 0.6, 0.7, script, true, 10);
            wait(2.15);
            u9:CreateSound("rbxassetid://72483809453170", 0.65, 0.725, script, true, 10);
            wait(1.4);
            u9:CreateSound("rbxassetid://72483809453170", 0.7, 0.75, script, true, 10);
            wait(1.5);
            u9:CreateSound("rbxassetid://72483809453170", 0.75, 0.775, script, true, 10);
            wait(3.45);
            u9:CreateSound("rbxassetid://72483809453170", 1.5, 0.8, script, true, 10);
            wait(2.3);
            u9:CreateSound("rbxassetid://72483809453170", 0.3, 0.75, script, true, 10);
            wait(2);
            u9:CreateSound("rbxassetid://72483809453170", 0.25, 1, script, true, 10);
            wait(3.85);
            u9:CreateSound("rbxassetid://98587858115094", 1, 1, script, true, 10);
            wait(2);
            u9:CreateSound("rbxassetid://72483809453170", 1.25 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true, 10);
            u9:CreateSound("rbxassetid://129922197154277", 1.25 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true, 10);
            u9:CreateSound("rbxassetid://113975047764762", 1.25 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), script, true, 10);
            wait(1.8);
            u9:CreateSound("rbxassetid://121368500414901", 1.5, 0.875, script, true, 10);
        end);
    end, function(p15) -- Line: 106, Name: renderstep_callback
    end, u11:WaitForChild("CameraRig"):WaitForChild("AnimationController"), u9.CutsceneLogic:GetPreloadedAnimation("GiantChombieCamera"), u3, #u2, "GiantChombiePlayer", true);
end;

function u4._ChickenTrojanEffect(p16, p17, p18, p19) -- Line: 125
    -- upvalues: ChickenTrojanExplosionEffect (copy), BetterDebris (copy), Utility (copy)
    local v20 = tick() + p18;

    while tick() < v20 do
        local v21 = ChickenTrojanExplosionEffect:Clone();
        local CFrame_new_ret = CFrame.new(p17);
        local v22 = math.random() - 0.5;
        local v23 = math.random() - 0.5;
        local v24 = math.random() - 0.5;
        v21.CFrame = CFrame_new_ret + Vector3.new(v22, v23, v24) * 12;
        v21.Parent = workspace;
        BetterDebris:AddItem(v21, 5);
        Utility:ScaleParticleEmitter(v21, 0.5 + 0.75 * math.random());
        Utility:PlayParticles(v21);
        p16:CreateSound("rbxassetid://97884024654711", 0.875 + 0.25 * math.random(), 1 + 0.25 * math.random(), v21, true, 5);
        wait(p19 or 0.2);
    end;
end;

function u4._Setup(p25) -- Line: 142
    -- upvalues: u2 (copy), u1 (copy)
    for i, v in pairs(u2) do
        p25.CutsceneLogic:PreloadAnimation("GiantChombiePlayer" .. i, v);
    end;

    p25.CutsceneLogic:PreloadAnimation("GiantChombieHumanoid", "rbxassetid://80790358034810");
    p25.CutsceneLogic:PreloadAnimation("GiantChombieCamera", "rbxassetid://85660296117721");
    p25.CutsceneLogic:PreloadCutsceneSoundIDs(u1);
end;

function u4._Init(p26) -- Line: 152
    p26:_Setup();
    p26.ClientDuel:SetReplicate("DuelMusic", "ZombieTower");
end;

return u4;