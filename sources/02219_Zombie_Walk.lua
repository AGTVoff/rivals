-- Instance: ReplicatedStorage .Modules.Emotes.Zombie Walk
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Emote = require(ReplicatedStorage.Modules.Emote);
local u1 = { "rbxassetid://72355887565329", "rbxassetid://85536457035481", "rbxassetid://74879924699654", "rbxassetid://72451632738218", "rbxassetid://131835698918357" };
local u2 = setmetatable({}, Emote);
u2.__index = u2;

function u2.new(...) -- Line: 11
    -- upvalues: Emote (copy), u2 (copy)
    local v3 = Emote.new(nil, script.Name, ...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2.PlayClient(p5, ...) -- Line: 23
    -- upvalues: Emote (copy), u1 (copy)
    Emote.PlayClient(p5, ...);
    p5:_PlayAnimation(u1[Random.new(p5._seed):NextInteger(1, #u1)], nil, nil, nil, 8);
end;

function u2._Init(p6) -- Line: 32
end;

return u2;