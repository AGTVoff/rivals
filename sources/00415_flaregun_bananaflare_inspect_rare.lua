-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.flaregun_bananaflare_inspect_rare
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://18128896162", 0.5, 1 + 0.25 * math.random(), true, 10);
end;