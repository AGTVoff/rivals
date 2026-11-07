-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.molotov_shipinabottle_lob_finish
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.125 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14522189766", 2, 1 + 0.25 * math.random(), true, 10);
end;