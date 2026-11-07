-- Instance: ReplicatedStorage .Modules.AnimationLibrary.EffectCallbacks.sniper_eventhorizon_reload_empty
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.38 / p2) then
        return;
    end;

    p1:PlayReloadStartParticles();

    if not p1:_AnimationWait(script.Name, p3, 0.75 / p2) then
        return;
    end;

    p1:PlayReloadFinishParticles();
end;