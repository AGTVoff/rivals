-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.medkit_bucketofcandy_use_quick
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://92333760834779", 1, 1, true, 10);
end;