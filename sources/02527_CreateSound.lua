-- Instance: StarterPlayer.StarterPlayerScripts.Modules.Functions.CreateSound
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);

return function(...) -- Line: 5
    -- upvalues: Utility (copy)
    Utility:CreateSound(...);
end;