-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.spray_spraybottle_equip
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.15 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://98906484629283", 1.5, 1 + 0.2 * math.random(), true, 5);
end;