-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.Functions.TracerEffect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TracerEffect = require(Players.LocalPlayer.PlayerScripts.Modules.TracerEffect);

return function(...) -- Line: 5
    -- upvalues: TracerEffect (copy)
    TracerEffect:Play(...);
end;