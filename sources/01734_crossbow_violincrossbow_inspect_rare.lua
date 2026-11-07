-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.crossbow_violincrossbow_inspect_rare
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.75 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://103864728645343", 1, 1, true, 10);
end;