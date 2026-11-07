-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.handgun_gingerbreadhandgun_shoot1
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://13110197302", "rbxassetid://13110197220" };

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    p2:CreateSound(u1[math.random(#u1)], 0.875, 1 + 0.2 * math.random(), true, 5);
    p2:CreateSound("rbxassetid://103022841301405", 1, 1 + 0.2 * math.random(), true, 5);
end;