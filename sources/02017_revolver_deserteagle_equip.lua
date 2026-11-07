-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.revolver_deserteagle_equip
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.15 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158610792", 1, 1, true, 10);
end;