-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.Functions.PartyRequest
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Requests = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Lobby.Requests);

return function(...) -- Line: 5
    -- upvalues: Requests (copy)
    Requests:PartyRequest(...);
end;