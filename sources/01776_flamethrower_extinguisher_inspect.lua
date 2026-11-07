-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.flamethrower_extinguisher_inspect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.7 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://137260230649042", 0.75, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://137260230649042", 0.875, 1.25, true, 10);
end;