-- Instance: StarterPlayer.StarterPlayerScripts.Modules.ClientReplicatedClasses.Enemies.ClientShockerZombie
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientEnemy = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc.ShockerZombieZapEffect.Attachment;
local u1 = { "rbxassetid://95537657751620", "rbxassetid://79660414273289" };
local u2 = setmetatable({}, ClientEnemy);
u2.__index = u2;

function u2.new(...) -- Line: 14
    -- upvalues: ClientEnemy (copy), u2 (copy)
    local v3 = ClientEnemy.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.ReplicateFromServer(p5, p6, ...) -- Line: 26
    -- upvalues: Utility (copy), u1 (copy), BetterDebris (copy), Attachment (copy), ClientEnemy (copy)
    if p6 == "DinkEffect" then
        if not p5:IsRendered() then
            return;
        end;

        Utility:CreateSound(u1[math.random(1, #u1)], 0.625 + 0.25 * math.random(), 1 + 0.5 * math.random(), p5.RootPart, true, 10);
        local v7 = p5.Model:FindFirstChild("Head") and p5.Model.Head:FindFirstChild("DinkVFX");
        Utility:PlayParticles(v7);

        return;
    end;

    if p6 ~= "ShockerZombieZap" then
        ClientEnemy.ReplicateFromServer(p5, p6, ...);

        return;
    end;

    if not p5:IsRendered() then
        return;
    end;

    local v8 = ...;

    if not v8 then
        return;
    end;

    Utility:CreateSound("rbxassetid://125973620031504", 0.375, 1 + 0.25 * math.random(), v8, true, 10);
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = v8;
    BetterDebris:AddItem(Attachment2, 0.2);
    local v9 = Attachment:Clone();
    v9.Beam1.Attachment1 = Attachment2;
    v9.Beam2.Attachment1 = Attachment2;
    v9.Parent = p5.Model.Appearance.Head.ContainsParticles:FindFirstChild("ZapStart");
    BetterDebris:AddItem(v9, 0.2);
end;

function u2._Init(p10) -- Line: 65
end;

return u2;