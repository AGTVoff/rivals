-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.gunblade_batblade_attack_blade_onhit
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.38 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96886470957330", 0.875, 1.25 + 0.125 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://122106573913822", 2, 1.25 + 0.125 * math.random(), true, 10);
end;