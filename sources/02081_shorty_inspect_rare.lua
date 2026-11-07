-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.shorty_inspect_rare
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 2.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.75, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.1666666666666667 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 1.5, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.75 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1, 1.5, true, 10);
end;