-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.shotgun_reload_empty_finish2
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.56 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13515046921", 1, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.19 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13515046988", 1, 1.25, true, 10);
end;