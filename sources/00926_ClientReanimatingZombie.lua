-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.ClientReplicatedClasses.Enemies.ClientReanimatingZombie
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientEnemy = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy);
local u1 = { "rbxassetid://135005054893837", "rbxassetid://131160196025684" };
local u2 = setmetatable({}, ClientEnemy);
u2.__index = u2;

function u2.new(...) -- Line: 14
    -- upvalues: ClientEnemy (copy), u2 (copy)
    local v3 = ClientEnemy.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.ReplicateFromServer(u5, p6, ...) -- Line: 26
    -- upvalues: Utility (copy), u1 (copy), ClientEnemy (copy)
    if p6 ~= "ZombieReanimation" then
        ClientEnemy.ReplicateFromServer(u5, p6, ...);

        return;
    end;

    if not u5:IsRendered() then
        return;
    end;

    local v7 = u5:_PlayAnimation("rbxassetid://116248625896064", 0);
    local v8 = u5:_PlayAnimation("rbxassetid://80790379621135", 0);
    local v9 = u5:_PlayAnimation("rbxassetid://106390578093849", 0);
    v8:Stop(0);
    v9:Stop(0);
    wait(2.4);
    v7:Stop(0);
    v8:Play(0);
    wait(... - 2.4 - 3.4);
    v8:Stop(0);
    v9:Play(0);
    task.spawn(function() -- Line: 51
        -- upvalues: Utility (ref), u5 (copy), u1 (ref)
        wait(1.65);
        Utility:CreateSound("rbxassetid://87428186485980", 0.75 + 0.25 * math.random(), 1 + 0.25 * math.random(), u5.RootPart, true, 10);
        wait(1);
        Utility:CreateSound(u1[math.random(#u1)], 0.75 + 0.25 * math.random(), 1 + 0.25 * math.random(), u5.RootPart, true, 10);
    end);
    wait(3.4);
    v9:Stop(0);
end;

function u2._Init(p10) -- Line: 71
end;

return u2;