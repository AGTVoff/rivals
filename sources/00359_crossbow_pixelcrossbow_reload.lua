-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.crossbow_pixelcrossbow_reload
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.85 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650837861", 0.75, 0.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://84676580117737", 0.5, 0.625, true, 10);
end;