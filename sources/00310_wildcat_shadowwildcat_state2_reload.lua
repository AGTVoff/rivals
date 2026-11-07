-- Instance: ReplicatedStorage .Modules.AnimationLibrary.EffectCallbacks.wildcat_shadowwildcat_state2_reload
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:PlayShadowPoofParticles(2);

    if not p1:_AnimationWait(script.Name, p3, 1.2 / p2) then
        return;
    end;

    p1:PlayShadowPoofParticles(1, true);

    if not p1:_AnimationWait(script.Name, p3, 0.12 / p2) then
        return;
    end;

    p1:PlayShadowPoofParticles(2, true);
end;