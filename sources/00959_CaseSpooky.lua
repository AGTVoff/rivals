-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.Functions.LootboxEffect.CaseSpooky
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);

return function(p1) -- Line: 5
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://18184524463", 0.8, 1, p1.HumanoidRootPart, true);
    wait(0.75);
    Utility:CreateSound("rbxassetid://18184524463", 0.9, 1.1, p1.HumanoidRootPart, true);
    wait(0.65);
end;