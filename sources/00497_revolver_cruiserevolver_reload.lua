-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.revolver_cruiserevolver_reload
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://134815282110155", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    for i = 1, 7 do
        p1:CreateSound("rbxassetid://134815282110155", 1, i * 0.05 + 1, true, 10);

        if not p1:_AnimationWait(script.Name, p3, 0.1285714285714286 / p2) then
            return;
        end;

        local _ = i;
    end;
end;