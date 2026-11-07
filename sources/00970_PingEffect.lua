-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.Functions.PingEffect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local PingEffect = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.PingEffect);

return function(...) -- Line: 5
    -- upvalues: PingEffect (copy)
    PingEffect:Play(...);
end;