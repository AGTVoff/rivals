-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.daggers_keynais_reload
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://96253147006478", 0.3, 2.5 + 0.5 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.3, 2.5 + 0.5 * math.random(), true, 10);
end;