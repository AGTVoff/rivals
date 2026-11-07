-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.slingshot_harp_inspect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 3.6 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://106485622539697", 1, 1 + 0.1 * math.random(), true, 5);
end;