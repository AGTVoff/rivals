-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.ViewModels.Grappler.Web Shooters
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Grappler = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Grappler);
local u1 = setmetatable({}, Grappler);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Grappler (copy), u1 (copy)
    local v2 = Grappler.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayShootSounds(p4) -- Line: 20
    p4:CreateSound("rbxassetid://100300369951636", 1.25, 1 + 0.1 * math.random(), true, 10);
    p4:CreateSound("rbxassetid://131248992892383", 1.25, 1 + 0.1 * math.random(), true, 10);
end;

function u1.PlayPullSounds(p5) -- Line: 25
    p5:CreateSound("rbxassetid://97538682393106", 1.25, 1 + 0.1 * math.random(), true, 10);
end;

function u1._Init(p6) -- Line: 33
end;

return u1;