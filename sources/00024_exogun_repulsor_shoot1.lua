-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.exogun_repulsor_shoot1
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://85840257279125", 1, 0.9 + 0.35 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://93945588254405", 0.75, 1 + 0.25 * math.random(), true, 5);
end;