-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.knife_machete_inspect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 3.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.85 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://80771716293563", 0.75, 1 + 0.1 * math.random(), true, 10);
end;