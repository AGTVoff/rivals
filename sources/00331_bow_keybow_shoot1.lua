-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.bow_keybow_shoot1
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://13677205703", "rbxassetid://13677205578", "rbxassetid://13677205647" };

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    p2:CreateSound(u1[math.random(#u1)], 3, 0.95 + 0.1 * math.random(), true, 10);
    p2:CreateSound("rbxassetid://110122962237431", 0.75, 1.5 + 0.25 * math.random(), true, 5);
end;