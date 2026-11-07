-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.slingshot_slingshotula_shoot1
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxasset://sounds//Rubber band sling shot.mp3", 1, 1 + 0.375 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://122106573913822", 2, 3 + 0.5 * math.random(), true, 10);
end;