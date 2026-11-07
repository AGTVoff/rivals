-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.sniper_reload
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455229044", 1, 1.1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.92 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455229188", 1, 1.1, true, 10);
end;