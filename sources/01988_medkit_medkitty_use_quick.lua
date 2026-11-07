-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.medkit_medkitty_use_quick
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://134160823775126", 1.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://85750875050391", 1.25, 1, true, 10);
end;