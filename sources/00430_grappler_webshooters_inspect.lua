-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.grappler_webshooters_inspect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local u1 = { 2.11, 2.25, 2.41, 2.85, 3.09, 3.14, 3.44 };

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    for i, v in pairs(u1) do
        wait(v - (u1[i - 1] or 0));
        p2:CreateSound("rbxassetid://100300369951636", 0.75 + 0.75 * math.random(), 0.9 + 0.6 * math.random(), true, 10);
    end;
end;