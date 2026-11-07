-- Instance: StarterPlayer.StarterPlayerScripts.Modules.ClientReplicatedClasses.Enemies.ClientGiantAcidicGargoyle
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local ClientEnemy = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy);
local AcidExplosionParticles = Players.LocalPlayer.PlayerScripts.Assets.Misc.AcidExplosionParticles;
local u1 = setmetatable({}, ClientEnemy);
u1.__index = u1;

function u1.new(...) -- Line: 15
    -- upvalues: ClientEnemy (copy), u1 (copy)
    local v2 = ClientEnemy.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(p4, p5, ...) -- Line: 27
    -- upvalues: Utility (copy), CameraController (copy), AcidExplosionParticles (copy), BetterDebris (copy), ClientEnemy (copy)
    if p5 == "FutileIntro" then
        if not p4:IsRendered() then
            return;
        end;

        p4:_PlayAnimation("rbxassetid://122946493954520");
        wait(7.45);
        Utility:CreateSound("rbxassetid://129922197154277", 1.5, 0.875 + 0.25 * math.random(), p4.RootPart, true, 10);
        CameraController:ShakeOnce(50, 10, 0.1, 0.4, Vector3.new(0.25, 0.25, 0), Vector3.new(0, 0, 0));

        return;
    end;

    if p5 == "AcidSlam" then
        if not p4:IsRendered() then
            return;
        end;

        wait(... - 0.55);
        p4:_PlayAnimation("rbxassetid://85325408755364");
        wait(0.55);
        Utility:CreateSound("rbxassetid://129922197154277", 1.5, 0.875 + 0.25 * math.random(), p4.RootPart, true, 10);
        CameraController:ShakeOnce(50, 10, 0.1, 0.4, Vector3.new(0.25, 0.25, 0), Vector3.new(0, 0, 0));

        return;
    end;

    if p5 ~= "AcidExplosion" then
        ClientEnemy.ReplicateFromServer(p4, p5, ...);

        return;
    end;

    if not p4:IsRendered() then
        return;
    end;

    local v6, v7 = ...;
    local v8 = AcidExplosionParticles:Clone();
    v8.CFrame = CFrame.new(v6) + Vector3.new(0, 1, 0) * v7 * 0.4;
    v8.Parent = workspace;
    BetterDebris:AddItem(v8, 10);

    for _, descendant in pairs(v8:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(descendant, v7 / 4);
        end;
    end;

    Utility:PlayParticles(v8);
    Utility:CreateSound("rbxassetid://79150386787758", 1, 1 + 0.1 * math.random(), v8, true, 10);
    Utility:CreateSound("rbxassetid://125902611007483", 0.8, 1 + 0.1 * math.random(), v8, true, 10);
end;

function u1._Init(p9) -- Line: 84
end;

return u1;