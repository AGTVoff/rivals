-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.medkit_laptop_use_quick
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://107901458751913", 1.5, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://134279576638277", 1.25, 2, true, 10);
end;