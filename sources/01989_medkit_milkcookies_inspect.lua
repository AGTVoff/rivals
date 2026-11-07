-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.medkit_milkcookies_inspect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.85 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 0.5, 1.25, true, 10);
    p1:CreateSound("rbxassetid://13160326139", 0.5, 1, true, 10);
end;