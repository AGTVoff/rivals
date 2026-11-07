-- Instance: StarterPlayer.StarterPlayerScripts.Modules.ViewModels.Permafrost.Xenofrost
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Permafrost = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Permafrost);
local XenofrostExplosionEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("XenofrostExplosionEffect");
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(138, 255, 48));
local u1 = setmetatable({}, Permafrost);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: Permafrost (copy), u1 (copy)
    local v2 = Permafrost.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 26
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.ExplosionEffect(p5, p6, p7) -- Line: 30
    -- upvalues: XenofrostExplosionEffect (copy), BetterDebris (copy), Utility (copy)
    local v8 = XenofrostExplosionEffect:Clone();
    v8.CFrame = CFrame.new(p6);
    v8.Parent = workspace;
    BetterDebris:AddItem(v8, 5);
    Utility:CreateSound("rbxassetid://18429092842", 0.4, 1 + 0.2 * math.random(), v8, true, 10);
    Utility:CreateSound("rbxassetid://88982903431410", 0.75, 1.25 + 0.25 * math.random(), v8, true, 5);

    for _, child in pairs(v8.Attachment:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            Utility:ScaleParticleEmitter(child, p7 / 4);
        end;
    end;

    Utility:PlayParticles(v8.Attachment);
end;

function u1._Init(p9) -- Line: 52
end;

return u1;