-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.ViewModels.BaseDaggers.Cursed Daggers
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseDaggers = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.BaseDaggers);
local u1 = setmetatable({}, BaseDaggers);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseDaggers (copy), u1 (copy)
    local v2 = BaseDaggers.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayHitmarkerSound(p4, p5, p6) -- Line: 20
    -- upvalues: BaseDaggers (copy)
    BaseDaggers.PlayHitmarkerSound(p4, p5, p6);
    p4:_CreateHitmarkerSound("rbxassetid://96571931025850", 1.25 / p6, 1 + 0.25 * math.random(), script, true, 1);

    if p5 then
        p4:_CreateHitmarkerSound("rbxassetid://106523082492142", 1 / p6, 1.75 + 0.25 * math.random(), script, true, 1);
    end;
end;

function u1._Init(p7) -- Line: 33
    p7:_RegisterAmmoVisual(p7.ItemModel:WaitForChild("LeftBody"):WaitForChild("MeshPart1"), 1);
    p7:_RegisterAmmoVisual(p7.ItemModel:WaitForChild("LeftBody"):WaitForChild("MeshPart2"), 1);
    p7:_RegisterAmmoVisual(p7.ItemModel:WaitForChild("LeftBody"):WaitForChild("MeshPart3"), 1);
    p7:_RegisterAmmoVisual(p7.ItemModel:WaitForChild("LeftBody"):WaitForChild("MeshPart4"), 1);
    p7:_RegisterAmmoVisual(p7.ItemModel:WaitForChild("LeftBody"):WaitForChild("MeshPart5"), 1);
    p7:_RegisterAmmoVisual(p7.ItemModel:WaitForChild("RightBody"):WaitForChild("MeshPart1"), 2);
    p7:_RegisterAmmoVisual(p7.ItemModel:WaitForChild("RightBody"):WaitForChild("MeshPart2"), 2);
    p7:_RegisterAmmoVisual(p7.ItemModel:WaitForChild("RightBody"):WaitForChild("MeshPart3"), 2);
    p7:_RegisterAmmoVisual(p7.ItemModel:WaitForChild("RightBody"):WaitForChild("MeshPart4"), 2);
    p7:_RegisterAmmoVisual(p7.ItemModel:WaitForChild("RightBody"):WaitForChild("MeshPart5"), 2);
end;

return u1;