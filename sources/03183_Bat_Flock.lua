-- Instance: StarterPlayer.StarterPlayerScripts.Modules.WrapGroupObjects.Bat Flock
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = { "rbxassetid://101762638470251", "rbxassetid://126383304317897", "rbxassetid://74045498632198", "rbxassetid://126383304317897" };
local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u2 = setmetatable({}, WrapGroupObject);
u2.__index = u2;

function u2.new(...) -- Line: 18
    -- upvalues: WrapGroupObject (copy), u2 (copy)
    local v3 = WrapGroupObject.new(...);
    local v4 = setmetatable(v3, u2);
    v4._started = 0;
    v4._flashes = {};
    v4._bats = {};
    v4._last_strike = 0;
    v4._next_strike = 0;
    v4._current_frame = 0;
    v4._last_update = 0;
    v4:_Init();

    return v4;
end;

function u2.Update(p5, p6) -- Line: 38
    -- upvalues: u1 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    p5._started = p5._started + p6;
    local _started = p5._started;

    for _, v in p5._bats do
        v.OffsetStudsU = _started % v.StudsPerTileU;
        v.OffsetStudsV = _started * 2 % v.StudsPerTileV;
    end;

    if p5._last_update + 0.05 <= _started then
        p5._last_update = _started;
        p5._current_frame = p5._current_frame + 1;

        if p5._current_frame > #u1 then
            p5._current_frame = 1;
        end;

        for _, v in p5._bats do
            v.Texture = u1[p5._current_frame];
        end;
    end;

    if _started < p5._next_strike then
        return;
    end;

    p5._next_strike = _started + Random.new(p5._started):NextNumber(1.1, 2.1);
    p5._last_strike = _started;

    for _, v in p5._bats do
        local v7 = Random.new():NextNumber(-v.StudsPerTileU, v.StudsPerTileU);
        local v8 = Random.new():NextNumber(-v.StudsPerTileV, v.StudsPerTileV);
        v.OffsetStudsU = v7;
        v.OffsetStudsV = v8;
    end;

    for _, v in p5._flashes do
        v.Transparency = 0;
        local v9 = TweenService:Create(v, TweenInfo_new_ret, {
            Transparency = 1
        });
        v9:Play();
        table.insert(p5._tweens, v9);
    end;
end;

function u2._Setup(p10) -- Line: 87
    -- upvalues: u1 (copy)
    for _, v in pairs(p10.ExtraObjects) do
        if v:IsA("Texture") and v.Name == "Flash" then
            table.insert(p10._flashes, v);
        elseif v:IsA("Texture") and v.Name == "Bats" then
            table.insert(p10._bats, v);
        end;
    end;

    if p10.Object:IsA("BasePart") then
        for _, v in pairs(u1) do
            local Texture = Instance.new("Texture");
            Texture.Texture = v;
            Texture.Transparency = 1;
            Texture.Face = Enum.NormalId.Front;
            Texture.Name = "PreloadedTextureBatFlock";
            Texture.Parent = p10.Object;
        end;
    end;
end;

function u2._Init(p11) -- Line: 108
    p11:_Setup();
end;

return u2;