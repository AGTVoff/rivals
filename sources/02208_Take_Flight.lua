-- Instance: ReplicatedStorage .Modules.Emotes.Take Flight
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = setmetatable({}, Emote);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: Emote (copy), u1 (copy)
    local v2 = Emote.new(nil, script.Name, ...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(u4, ...) -- Line: 23
    -- upvalues: Emote (copy)
    Emote.PlayClient(u4, ...);
    u4:_SetupProp(script.WingsProp);
    u4:_PlayAnimation("rbxassetid://93066817376368");
    u4:_InternalThread(function() -- Line: 28
        -- upvalues: u4 (copy)
        while true do
            wait(0.25);
            u4:CreateSound("rbxassetid://128361063555965", 0.8 + 0.2 * math.random(), 0.9 + 0.2 * math.random(), nil, true, 5);
            wait(0.85);
            u4:CreateSound("rbxassetid://128361063555965", 0.8 + 0.2 * math.random(), 0.9 + 0.2 * math.random(), nil, true, 5);
            wait(0.55);
        end;
    end);
end;

function u1._Init(p5) -- Line: 43
end;

return u1;