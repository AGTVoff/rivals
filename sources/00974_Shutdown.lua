-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.Functions.Shutdown
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Shutdown = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Shutdown);

return function(p1) -- Line: 5
    -- upvalues: Shutdown (copy)
    Shutdown:Enable(p1);
end;