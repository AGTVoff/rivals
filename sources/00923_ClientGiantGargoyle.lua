-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.ClientReplicatedClasses.Enemies.ClientGiantGargoyle
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local ClientEnemy = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy);
local u1 = setmetatable({}, ClientEnemy);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: ClientEnemy (copy), u1 (copy)
    local v2 = ClientEnemy.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(u4, p5, ...) -- Line: 23
    -- upvalues: Utility (copy), CameraController (copy), ClientEnemy (copy)
    if p5 == "FlightIntro" then
        if not u4:IsRendered() then
            return;
        end;

        u4:_PlayAnimation("rbxassetid://91697782514164");

        return;
    end;

    if p5 ~= "ClawAttack" then
        ClientEnemy.ReplicateFromServer(u4, p5, ...);

        return;
    end;

    if not u4:IsRendered() then
        return;
    end;

    u4:_PlayAnimation("rbxassetid://83924855123571");
    task.delay(0.7, function() -- Line: 39
        -- upvalues: Utility (ref), u4 (copy)
        Utility:CreateSound("rbxassetid://128361063555965", 2.25 + 0.25 * math.random(), 1.25 + 0.2 * math.random(), u4.RootPart, true, 10);
    end);
    wait((...));
    Utility:CreateSound("rbxassetid://134852748577803", 2, 0.75 + 0.25 * math.random(), u4.RootPart, true, 10);
    CameraController:ShakeOnce(25, 10, 0.1, 0.4, Vector3.new(0.25, 0.25, 0), Vector3.new(0, 0, 0));
end;

function u1._Init(p6) -- Line: 56
end;

return u1;