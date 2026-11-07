-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.warpstone_warpeye_inspect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://111876623538044", 1, 1 + 0.1 * math.random(), true, 10);
end;