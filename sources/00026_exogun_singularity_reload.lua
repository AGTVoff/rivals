-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.exogun_singularity_reload
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17672502879", 0.875, 0.875, true, 10);
end;