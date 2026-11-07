-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.medkit_icecream_inspect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 2.85 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://122265646069920", 0.875, 1 + 0.2 * math.random(), true, 5);
end;