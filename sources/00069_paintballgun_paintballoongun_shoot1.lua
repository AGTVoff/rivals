-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.paintballgun_paintballoongun_shoot1
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxasset://sounds//paintball.wav", 0.875, 1 + 0.1 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://17803360572", 1, 3 + 0.3 * math.random(), true, 10);
end;