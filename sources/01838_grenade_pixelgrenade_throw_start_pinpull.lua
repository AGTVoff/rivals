-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.grenade_pixelgrenade_throw_start_pinpull
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650838003", 2, 1.5, true, 10);
end;