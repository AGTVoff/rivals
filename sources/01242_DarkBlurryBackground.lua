-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.UserInterface.DarkBlurryBackground
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local MobileInputs = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.MobileInputs);
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Pages);
local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
local Color3_fromRGB_ret2 = Color3.fromRGB(220, 220, 220);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 21
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._blur = Instance.new("BlurEffect");
    v2._colorcorrection = Instance.new("ColorCorrectionEffect");
    v2._last_blur_enabled = nil;
    v2._last_cc_enabled = nil;
    v2._tween_hash = 0;
    v2._current_duel = nil;
    v2._current_duel_connections = {};
    v2:_Init();

    return v2;
end;

function u1._Tween(u3, p4, p5, p6, p7) -- Line: 47
    -- upvalues: Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Utility (copy)
    local v8 = p4 or false;
    local v9 = p4 or false;

    if v8 == u3._last_blur_enabled and v9 == u3._last_cc_enabled then
        return;
    end;

    u3._last_blur_enabled = v8;
    u3._last_cc_enabled = v9;
    u3._tween_last = p4;
    u3._tween_hash = u3._tween_hash + 1;
    local _tween_hash = u3._tween_hash;
    local Size = u3._blur.Size;
    local Brightness = u3._colorcorrection.Brightness;
    local TintColor = u3._colorcorrection.TintColor;
    local u10 = v8 and (p5 and 60 or 24 or 0) or 0;
    local u11 = v9 and (p6 and 0 or -0.1 or 0) or 0;
    local u12;

    if v9 then
        if p6 then
            u12 = Color3_fromRGB_ret;
        else
            u12 = Color3_fromRGB_ret2;
        end;

        if not u12 then
            u12 = Color3_fromRGB_ret;
        end;
    else
        u12 = Color3_fromRGB_ret;
    end;

    task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, p7 and 100 or 4, function(p13) -- Line: 69
        -- upvalues: _tween_hash (copy), u3 (copy), Size (copy), u10 (copy), Brightness (copy), u11 (copy), TintColor (copy), u12 (copy)
        if _tween_hash ~= u3._tween_hash then
            return true;
        end;

        local v14 = 1 - (1 - p13 / 100) ^ 3;
        u3._blur.Size = Size + (u10 - Size) * v14;
        u3._colorcorrection.Brightness = Brightness + (u11 - Brightness) * v14;
        u3._colorcorrection.TintColor = TintColor:Lerp(u12, v14);
    end);
end;

function u1._Update(p15) -- Line: 82
    -- upvalues: Pages (copy), MobileInputs (copy)
    local v16 = Pages.PageSystem.CurrentPage and Pages.PageSystem.CurrentPage.UseDarkBlurryBackground;
    local v17 = p15._current_duel and (p15._current_duel.DuelInterface.Scoreboard:IsOpen() or (p15._current_duel.DuelInterface.FinalResults.CurrentPage == "Summary" and true or p15._current_duel.DuelInterface.Voting:IsOpen()));
    p15:_Tween(v16 or (v17 or MobileInputs.EditorEnabled), MobileInputs.EditorEnabled, MobileInputs.EditorEnabled);
end;

function u1._VerifyClientDuel(u18) -- Line: 98
    -- upvalues: SpectateController (copy)
    for _, v in pairs(u18._current_duel_connections) do
        v:Disconnect();
    end;

    u18._current_duel_connections = {};
    u18._current_duel = SpectateController.CurrentDuelSubject;
    u18:_Update();

    if not u18._current_duel then
        return;
    end;

    local _current_duel_connections = u18._current_duel_connections;
    local PropertyChangedSignal = u18._current_duel.DuelInterface.Frame:GetPropertyChangedSignal("Visible");
    table.insert(_current_duel_connections, PropertyChangedSignal:Connect(function() -- Line: 111
        -- upvalues: u18 (copy)
        u18:_Update();
    end));
    table.insert(u18._current_duel_connections, u18._current_duel.DuelInterface.Scoreboard.VisibilityChanged:Connect(function() -- Line: 115
        -- upvalues: u18 (copy)
        u18:_Update();
    end));
    table.insert(u18._current_duel_connections, u18._current_duel.DuelInterface.FinalResults.PageChanged:Connect(function() -- Line: 119
        -- upvalues: u18 (copy)
        u18:_Update();
    end));
    table.insert(u18._current_duel_connections, u18._current_duel.DuelInterface.Voting.VisibilityChanged:Connect(function() -- Line: 123
        -- upvalues: u18 (copy)
        u18:_Update();
    end));
end;

function u1._Setup(p19) -- Line: 128
    -- upvalues: Lighting (copy)
    p19._blur.Name = "DarkBlurryBackground";
    p19._blur.Parent = Lighting;
    p19._colorcorrection.Name = "DarkBlurryBackground";
    p19._colorcorrection.Parent = Lighting;
end;

function u1._Init(u20) -- Line: 136
    -- upvalues: SpectateController (copy), Pages (copy), MobileInputs (copy)
    SpectateController.DuelSubjectChanged:Connect(function() -- Line: 137
        -- upvalues: u20 (copy)
        u20:_VerifyClientDuel();
    end);
    Pages.PageSystem.PagesActivity:Connect(function() -- Line: 141
        -- upvalues: u20 (copy)
        u20:_Update();
    end);
    MobileInputs.EditorEnabledChanged:Connect(function() -- Line: 145
        -- upvalues: u20 (copy)
        u20:_Update();
    end);
    u20:_Setup();
    task.defer(u20._Tween, u20, false, nil, nil, true);
    task.defer(u20._Update, u20);
    task.defer(u20._VerifyClientDuel, u20);
end;

return u1._new();