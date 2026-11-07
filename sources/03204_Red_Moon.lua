-- Instance: StarterPlayer.StarterPlayerScripts.Modules.WrapGroupObjects.Red Moon
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._started = 0;
    v3._clouds = {};
    v3._slow_clouds = {};
    v3._rain_1 = {};
    v3._rain_2 = {};
    v3._moon_glow = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 27
    p4._started = p4._started + p5;
    local _started = p4._started;
    local v6 = -_started / 10;
    local v7 = _started / 1.5;

    for _, v in p4._clouds do
        v.OffsetStudsU = v6 / 2 % v.StudsPerTileU;
    end;

    for _, v in p4._slow_clouds do
        v.OffsetStudsU = v6 / 3.141592653589793 % v.StudsPerTileU;
    end;

    for _, v in p4._rain_1 do
        v.OffsetStudsU = v.StudsPerTileU - v7 % v.StudsPerTileU;
        v.OffsetStudsV = v.StudsPerTileV - v7 * 2 % v.StudsPerTileV;
    end;

    for _, v in p4._rain_2 do
        v.OffsetStudsU = v7 % v.StudsPerTileU;
        v.OffsetStudsV = v.StudsPerTileV - v7 * 2 % v.StudsPerTileV;
    end;

    local v8 = math.sin(_started * 1.5 * 2) / 2 + 0.5;

    for _, v in p4._moon_glow do
        v.Transparency = math.lerp(0.482, 0.262, v8);
    end;
end;

function u1._Setup(p9) -- Line: 64
    for _, v in pairs(p9.ExtraObjects) do
        if v:IsA("Texture") and v.Name == "Clouds" then
            table.insert(p9._clouds, v);
        elseif v:IsA("Texture") and v.Name == "SlowClouds" then
            table.insert(p9._slow_clouds, v);
        elseif v:IsA("Texture") and v.Name == "Rain1" then
            table.insert(p9._rain_1, v);
        elseif v:IsA("Texture") and v.Name == "Rain2" then
            table.insert(p9._rain_2, v);
        elseif v:IsA("Texture") and v.Name == "MoonGlow" then
            table.insert(p9._moon_glow, v);
        end;
    end;
end;

function u1._Init(p10) -- Line: 80
    p10:_Setup();
end;

return u1;