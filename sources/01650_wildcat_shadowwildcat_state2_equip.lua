-- Instance: ReplicatedStorage .Modules.AnimationLibrary.EffectCallbacks.wildcat_shadowwildcat_state2_equip
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://103973278699608", 1, 1 + 0.1 * math.random(), true, 5);
end;