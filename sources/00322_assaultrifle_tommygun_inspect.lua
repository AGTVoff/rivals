-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.assaultrifle_tommygun_inspect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.45 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.375, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.7 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.25, true, 10);
end;