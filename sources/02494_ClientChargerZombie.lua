-- Instance: StarterPlayer.StarterPlayerScripts.Modules.ClientReplicatedClasses.Enemies.ClientChargerZombie
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientEnemy = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy);
local u1 = { "rbxassetid://95537657751620", "rbxassetid://79660414273289" };
local u2 = setmetatable({}, ClientEnemy);
u2.__index = u2;

function u2.new(...) -- Line: 13
    -- upvalues: ClientEnemy (copy), u2 (copy)
    local v3 = ClientEnemy.new(...);
    local v4 = setmetatable(v3, u2);
    v4._charge_hash = 0;
    v4._charge_animation_tracks = {};
    v4:_Init();

    return v4;
end;

function u2.ReplicateFromServer(u5, p6, ...) -- Line: 28
    -- upvalues: Utility (copy), u1 (copy), ClientEnemy (copy)
    if p6 ~= "ChargerZombieChargeStart" then
        if p6 == "ChargerZombieChargeImpact" then
            if not u5:IsRendered() then
                return;
            end;

            u5._charge_hash = u5._charge_hash + 1;
            u5:_StopChargingAnimationTracks();
            u5:_PlayAnimation("rbxassetid://102061691949401", 0);

            return;
        end;

        if p6 ~= "DinkEffect" then
            ClientEnemy.ReplicateFromServer(u5, p6, ...);

            return;
        end;

        if not u5:IsRendered() then
            return;
        end;

        Utility:CreateSound(u1[math.random(1, #u1)], 0.625 + 0.25 * math.random(), 1 + 0.5 * math.random(), u5.RootPart, true, 10);
        local v7 = u5.Model:FindFirstChild("Head") and u5.Model.Head:FindFirstChild("DinkVFX");
        Utility:PlayParticles(v7);

        return;
    end;

    if not u5:IsRendered() then
        return;
    end;

    local u8 = ...;
    u5._charge_hash = u5._charge_hash + 1;
    local _charge_hash = u5._charge_hash;
    table.insert(u5._charge_animation_tracks, u5:_PlayAnimation("rbxassetid://89451767520037", 0));
    task.spawn(function() -- Line: 41
        -- upvalues: u5 (copy), _charge_hash (copy), Utility (ref)
        wait(0.4);

        if u5._charge_hash ~= _charge_hash then
            return;
        end;

        Utility:CreateSound("rbxassetid://104718122128210", 0.5, 0.75 + 0.125 * math.random(), u5.RootPart, true, 10);
        Utility:CreateSound("rbxassetid://129922197154277", 1, 0.875 + 0.25 * math.random(), u5.RootPart, true, 10);
        wait(3.05);

        if u5._charge_hash ~= _charge_hash then
            return;
        end;

        table.insert(u5._charge_animation_tracks, u5:_PlayAnimation("rbxassetid://81364239879886", 0));
    end);
    task.spawn(function() -- Line: 60
        -- upvalues: u8 (copy), Utility (ref), u5 (copy)
        wait(0.6);

        for i = 0, u8 - 0.6, 0.2 do
            Utility:CreateSound("rbxassetid://76804323076444", 0.75 + 0.25 * math.random(), 0.875 + 0.25 * math.random(), u5.RootPart, true, 10);
            wait(0.2);
            local _ = i;
        end;
    end);
    wait(u8);

    if u5._charge_hash ~= _charge_hash then
        return;
    end;

    u5._charge_hash = u5._charge_hash + 1;
    u5:_StopChargingAnimationTracks();
    u5:_PlayAnimation("rbxassetid://114972482950857");
end;

function u2.Destroy(p9) -- Line: 101
    -- upvalues: ClientEnemy (copy)
    p9._charge_hash = p9._charge_hash + 1;
    ClientEnemy.Destroy(p9);
end;

function u2._StopChargingAnimationTracks(p10) -- Line: 110
    for _, v in pairs(p10._charge_animation_tracks) do
        v:Stop();
    end;

    p10._charge_animation_tracks = {};
end;

function u2._Init(p11) -- Line: 118
end;

return u2;