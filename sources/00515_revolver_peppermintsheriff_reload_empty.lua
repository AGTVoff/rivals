-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.revolver_peppermintsheriff_reload_empty
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1, 2.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14240944327", 1, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1, 1.75, true, 10);
end;