-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.chainsaw_megadrill_inspect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.6 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17247639614", 0.875, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 2.9 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17247639614", 0.75, 0.8 + 0.1 * math.random(), true, 10);
end;