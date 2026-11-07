-- Instance: ReplicatedStorage .Modules.AnimationLibrary.EffectCallbacks.wildcat_shadowwildcat_state1_equip
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:PlayShadowPoofParticles(1, true);

    if not p1:_AnimationWait(script.Name, p3, 0.13 / p2) then
        return;
    end;

    p1:PlayShadowPoofParticles(2, true);
end;