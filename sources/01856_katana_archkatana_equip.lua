-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.katana_archkatana_equip
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://118906938239363", 1, 0.9 + 0.2 * math.random(), true, 10);
end;