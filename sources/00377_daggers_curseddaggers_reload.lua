-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.daggers_curseddaggers_reload
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://83017428892049", 0.75, 0.95 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://99837158417289", 0.875, 1.25, true, 10);
    p1:CreateSound("rbxassetid://83017428892049", 0.75, 1.1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://99837158417289", 0.5, 1.5, true, 10);
end;