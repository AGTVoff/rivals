-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.grenade_fizzbomb_throw_start
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://130511754869111", 1.5, 1 + 0.1 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://119684878895970", 1, 1 + 0.1 * math.random(), true, 10);
end;