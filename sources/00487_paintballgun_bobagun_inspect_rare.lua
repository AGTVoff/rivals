-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.paintballgun_bobagun_inspect_rare
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.75 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://140497591831738", 1, 1, true, 10);
end;