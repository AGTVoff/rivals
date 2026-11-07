-- Instance: Players .NebulaHub_049.PlayerScripts.Controllers.TimerController
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 9
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.TimerUpdated = Signal.new();
    v2._finish_times = {};
    v2._step_callbacks = {};
    v2:_Init();

    return v2;
end;

function u1.GetTimeRemaining(p3, p4) -- Line: 26
    if not p3._finish_times[p4] then
        return -1;
    end;

    local v5 = p3._finish_times[p4] - tick();
    local math_ceil_ret = math.ceil(v5);

    return math.max(0, math_ceil_ret);
end;

function u1.GetTimeRemainingFormatted(p6, p7) -- Line: 30
    -- upvalues: Utility (copy)
    local TimeRemaining = p6:GetTimeRemaining(p7);

    return TimeRemaining == -1 and "• • •" or Utility:TimeFormat2(TimeRemaining);
end;

function u1.SetTimeRemaining(p8, p9, p10) -- Line: 36
    p8._finish_times[p9] = tick() + p10;
    p8.TimerUpdated:Fire(p9);
end;

function u1.OnStep(p11, p12, p13, p14) -- Line: 41
    p11._step_callbacks[p12] = p13 and p14 and { p13, p14 } or nil;
    p11:_Step(p12);
end;

function u1._Step(p15, p16) -- Line: 50
    local v17 = p15._step_callbacks[p16];

    if not v17 then
        return;
    end;

    local v18 = v17[2];
    local TimeRemaining = p15:GetTimeRemaining(v17[1]);
    local success, result = pcall(v18, TimeRemaining, p15:GetTimeRemainingFormatted(v17[1]));

    if not success then
        warn("ON STEP CALLBACK ERRORED:", result);
    end;
end;

function u1._StepLoop(p19) -- Line: 64
    while true do
        for i in pairs(p19._step_callbacks) do
            p19:_Step(i);
        end;

        wait(1);
    end;
end;

function u1._FetchTimers(p20) -- Line: 74
    -- upvalues: ReplicatedStorage (copy)
    p20:SetTimeRemaining("TaskRefresh", ReplicatedStorage.Remotes.Misc.RequestTaskRefreshTimeRemaining:InvokeServer());
    p20:SetTimeRemaining("AdventCalendar", ReplicatedStorage.Remotes.Misc.RequestAdventCalendarTimeRemaining:InvokeServer());
end;

function u1._Init(u21) -- Line: 79
    -- upvalues: ReplicatedStorage (copy)
    ReplicatedStorage.Remotes.Misc.UpdateTaskRefreshTimeRemaining.OnClientEvent:Connect(function(p22) -- Line: 80
        -- upvalues: u21 (copy)
        u21:SetTimeRemaining("TaskRefresh", p22);
    end);
    ReplicatedStorage.Remotes.Misc.UpdateAdventCalendarTimeRemaining.OnClientEvent:Connect(function(p23) -- Line: 84
        -- upvalues: u21 (copy)
        u21:SetTimeRemaining("AdventCalendar", p23);
    end);
    task.spawn(u21._StepLoop, u21);
    task.spawn(u21._FetchTimers, u21);
end;

return u1._new();