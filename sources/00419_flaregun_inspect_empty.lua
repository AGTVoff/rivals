-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.flaregun_inspect_empty
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 2.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 1, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 0.5, 2, true, 10);
end;