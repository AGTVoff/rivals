-- Instance: ReplicatedStorage .Modules.Finishers.Become Bat
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Finisher = require(ReplicatedStorage.Modules.Finisher);
local u1 = { 0.542, 0.867, 1.117, 1.383, 1.691, 2, 2.275, 2.575, 2.891 };
local u2 = setmetatable({}, Finisher);
u2.__index = u2;

function u2.new(...) -- Line: 10
    -- upvalues: Finisher (copy), u2 (copy)
    local v3 = Finisher.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayServer(u5) -- Line: 22
    -- upvalues: u1 (copy)
    u5:_SetupProp(script.WingsProp);
    local v6 = u5._is_humanoid and u5._subject.RootPart or u5._subject;
    local v7 = u5._subject.Parent and u5._subject.Parent:FindFirstChild("UpperTorso");
    v6.Anchored = true;
    local v8;

    if u5._is_humanoid then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://126992668612776";
        local v9;
        v9, v8 = pcall(u5._subject.LoadAnimation, u5._subject, Animation);

        if v9 then
            v8:Play(0);
        end;
    else
        v8 = nil;
    end;

    u5:CreateSound("rbxassetid://113079133719959", 1 + 0.25 * math.random(), 1.5 + 0.25 * math.random(), nil, true, 5);
    u5:_InternalThread(task.spawn, function() -- Line: 47
        -- upvalues: u1 (ref), u5 (copy)
        for i, v in pairs(u1) do
            wait(v - (u1[i - 1] or 0));
            u5:CreateSound("rbxassetid://103418064116555", 0.75 + 0.25 * math.random(), 1 + 0.25 * math.random(), nil, true, 5);
        end;
    end);
    wait(3);
    local _ = v7.Position;

    if v8 then
        v8:Stop(0);
    end;

    v6.Anchored = false;
    u5:_Ragdoll();
    u5:_AnchorModel();
end;

function u2._Init(p10) -- Line: 72
end;

return u2;