-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.Pages.Settings.Inspect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SettingsLibrary = require(ReplicatedStorage.Modules.SettingsLibrary);
local InputLibrary = require(ReplicatedStorage.Modules.InputLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local SettingsController = require(Players.LocalPlayer.PlayerScripts.Controllers.SettingsController);
local Crosshair = require(Players.LocalPlayer.PlayerScripts.Modules.Crosshair);
local MobileButton = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MobileButton");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 19
    -- upvalues: u1 (copy), Crosshair (copy), MobileButton (copy)
    local v3 = setmetatable({}, u1);
    v3.Page = p2;
    v3.Frame = v3.Page.Container:WaitForChild("Inspect");
    v3.ServerDescriptionText = v3.Frame:WaitForChild("ServerDescription");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.DescriptionFrame = v3.Container:WaitForChild("Description");
    v3.DescriptionText = v3.DescriptionFrame:WaitForChild("Description");
    v3.DescriptionInvisibleText = v3.DescriptionFrame:WaitForChild("InvisibleDescription");
    v3.DescriptionTitleContainer = v3.DescriptionFrame:WaitForChild("TitleContainer");
    v3.DescriptionTitleIcon = v3.DescriptionTitleContainer:WaitForChild("Icon");
    v3.DescriptionTitleText = v3.DescriptionTitleContainer:WaitForChild("Title");
    v3.MapFrame = v3.Container:WaitForChild("Map");
    v3.MapContainer = v3.MapFrame:WaitForChild("Container");
    v3.MapBackground = v3.MapContainer:WaitForChild("Background");
    v3.MapCurrent = v3.MapBackground:WaitForChild("Current");
    v3.MapNext = v3.MapBackground:WaitForChild("Next");
    v3._current_settings_info = nil;
    v3._map_hash = 0;
    v3._map_num = 0;
    v3._crosshair = Crosshair.new();
    v3._mobile_button = MobileButton:Clone();
    v3._mobile_input_name_connections = {};
    v3._current_mobile_input_name = nil;
    v3:_Init();

    return v3;
end;

function u1.Inspect(u4, p5) -- Line: 55
    -- upvalues: PlayerDataController (copy)
    if p5 == u4._current_settings_info or p5 and p5.InputType == "Divider" then
        return;
    end;

    for _, v in pairs(u4._mobile_input_name_connections) do
        v:Disconnect();
    end;

    u4._mobile_input_name_connections = {};
    u4._current_settings_info = p5;
    u4._current_mobile_input_name = u4:_GetMobileInputNameFromSettingsName(u4._current_settings_info and u4._current_settings_info.Name) or (u4._current_mobile_input_name or "mobile_shoot");
    u4.DescriptionFrame.Visible = u4._current_settings_info ~= nil;
    u4:_UpdateMapVisibility();
    u4:_UpdateMobileButton();

    if not u4._current_settings_info then
        return;
    end;

    u4.DescriptionTitleIcon.Image = u4._current_settings_info.Image;
    u4.DescriptionTitleIcon.Visible = u4.DescriptionTitleIcon.Image ~= "";
    u4.DescriptionTitleText.Text = u4._current_settings_info.DisplayName;
    u4.DescriptionInvisibleText.Text = u4._current_settings_info.Description;

    if not u4._current_mobile_input_name then
        return;
    end;

    local _mobile_input_name_connections = u4._mobile_input_name_connections;
    local SettingChangedSignal = PlayerDataController:GetSettingChangedSignal("MobileButton " .. u4._current_mobile_input_name .. " Enabled");
    table.insert(_mobile_input_name_connections, SettingChangedSignal:Connect(function() -- Line: 85
        -- upvalues: u4 (copy)
        u4:_UpdateMobileButton();
    end));
    local _mobile_input_name_connections2 = u4._mobile_input_name_connections;
    local SettingChangedSignal2 = PlayerDataController:GetSettingChangedSignal("Mobile Buttons Transparency");
    table.insert(_mobile_input_name_connections2, SettingChangedSignal2:Connect(function() -- Line: 89
        -- upvalues: u4 (copy)
        u4:_UpdateMobileButton();
    end));
    local _mobile_input_name_connections3 = u4._mobile_input_name_connections;
    local SettingChangedSignal3 = PlayerDataController:GetSettingChangedSignal("MobileButton " .. u4._current_mobile_input_name .. " Transparency");
    table.insert(_mobile_input_name_connections3, SettingChangedSignal3:Connect(function() -- Line: 93
        -- upvalues: u4 (copy)
        u4:_UpdateMobileButton();
    end));
    table.insert(u4._mobile_input_name_connections, PlayerDataController.SettingsSliderChanged:Connect(function(p6, p7) -- Line: 97
        -- upvalues: u4 (copy)
        u4:_UpdateMobileButton({
            [p6] = p7
        });
    end));
end;

function u1.SetVisible(p8, p9) -- Line: 102
    p8.Frame.Visible = p9;
end;

function u1.SetPage(p10, p11) -- Line: 106
    p10:Inspect(nil);
    p10:SetVisible(p11 ~= "Hotkeys");
    p10._crosshair:SetVisible(p11 == "Crosshair");
    p10:_UpdateMapVisibility();
    p10:_UpdateMobileButton();
end;

function u1.Open(p12) -- Line: 114
    p12._map_hash = p12._map_hash + 1;
    task.spawn(p12._PlayMapEffect, p12);
    p12:_UpdateServerDescription();
end;

function u1.Close(p13) -- Line: 120
    p13._map_hash = p13._map_hash + 1;
    p13:Inspect(nil);
end;

function u1._UpdateServerDescription(p14) -- Line: 129
    -- upvalues: Utility (copy), ServerOsTime (copy)
    local ServerDescriptionText = p14.ServerDescriptionText;
    local game_PlaceVersion = game.PlaceVersion;
    local v15 = ServerOsTime:Get() - (workspace:GetAttribute("ServerStartTime") or 0);
    ServerDescriptionText.Text = "Version " .. game_PlaceVersion .. " • " .. Utility:TimeFormat2((math.floor(v15)));
end;

function u1._GetMobileInputNameFromSettingsName(p16, p17) -- Line: 133
    if not p17 or string.sub(p17, 1, 13) ~= "MobileButton " then
        return nil;
    end;

    local string_sub_ret = string.sub(p17, 14, #p17);
    local string_find_ret = string.find(string_sub_ret, " ");

    if string_find_ret then
        return string.sub(string_sub_ret, 1, string_find_ret - 1);
    end;

    return nil;
end;

function u1._UpdateMobileButton(p18, p19) -- Line: 150
    -- upvalues: SettingsController (copy), PlayerDataController (copy), InputLibrary (copy)
    local v20;

    if p18.Page.CurrentPage == "Touch" then
        v20 = p18._current_mobile_input_name ~= nil;
    else
        v20 = false;
    end;

    p18._mobile_button.Visible = v20;

    if not p18._mobile_button.Visible then
        return;
    end;

    local MobileButtonSetting = SettingsController:GetMobileButtonSetting(p18._current_mobile_input_name, "Mobile Buttons Transparency", "Transparency", p19);
    local Setting = PlayerDataController:GetSetting("MobileButton " .. p18._current_mobile_input_name .. " Enabled");
    local Image = InputLibrary.MobileButtons[p18._current_mobile_input_name].Image;
    p18._mobile_button.Invisible.Visible = not Setting;
    p18._mobile_button.IconContainer.ImageTransparency = math.clamp(MobileButtonSetting * 2, 0, 1) * 1 + 0;
    p18._mobile_button.IconContainer.Icon.ImageTransparency = math.clamp(MobileButtonSetting, 0, 1);
    p18._mobile_button.IconContainer.Icon.Image = Image;
end;

function u1._UpdateMapVisibility(p21) -- Line: 167
    local v22;

    if p21.Page.CurrentPage == "Crosshair" then
        v22 = true;
    elseif p21.Page.CurrentPage == "Touch" then
        v22 = p21._current_mobile_input_name;
    else
        v22 = false;
    end;

    p21.MapFrame.Visible = v22;
end;

function u1._GetMapImage(p23, p24) -- Line: 171
    -- upvalues: DuelLibrary (copy)
    return DuelLibrary.Maps[DuelLibrary.MapOrder[(p24 - 1) % #DuelLibrary.MapOrder + 1]].Image;
end;

function u1._PlayMapEffect(p25) -- Line: 175
    p25._map_hash = p25._map_hash + 1;
    local _map_hash = p25._map_hash;

    while true do
        p25._map_num = p25._map_num + 1;
        p25.MapNext.Image = p25:_GetMapImage(p25._map_num + 1);
        p25.MapCurrent.Image = p25:_GetMapImage(p25._map_num);
        p25.MapCurrent.Position = UDim2.new(0.625, 0, 0.5, 0);
        p25.MapCurrent:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25, true);
        wait(5);

        if _map_hash ~= p25._map_hash then
            break;
        end;

        p25.MapCurrent:TweenPosition(UDim2.new(0.375, 0, 0.5, 0), "In", "Quint", 0.25, true);
        wait(0.25);

        if _map_hash ~= p25._map_hash then
            return;
        end;
    end;
end;

function u1._UpdateCrosshairAppearance(p26, p27) -- Line: 202
    -- upvalues: SettingsLibrary (copy), PlayerDataController (copy)
    p26._crosshair:SetAppearance(SettingsLibrary:GenerateCrosshairAppearance(PlayerDataController, p27));
    p26._crosshair:SetSpacing(p26._crosshair:GetAppearanceSpacing());
end;

function u1._UpdateText(p28) -- Line: 207
    p28.DescriptionText.Text = p28.DescriptionInvisibleText.Text;
    p28.DescriptionText.Size = UDim2.new(0.9, 0, p28.DescriptionInvisibleText.Size.Y.Scale * math.ceil(p28.DescriptionInvisibleText.TextBounds.X / p28.DescriptionText.AbsoluteSize.X), 0);
end;

function u1._Setup(p29) -- Line: 212
    p29._crosshair:SetParent(p29.MapContainer);
    p29._mobile_button.Parent = p29.MapContainer;
    p29._mobile_button.AnchorPoint = Vector2.new(0.5, 0.5);
    p29._mobile_button.Position = UDim2.new(0.5, 0, 0.5, 0);
    p29._mobile_button.Size = UDim2.new(0.5, 0, 0.5, 0);
    p29._mobile_button.Resize.Visible = false;
end;

function u1._Init(u30) -- Line: 221
    -- upvalues: PlayerDataController (copy), SettingsLibrary (copy)
    u30.DescriptionInvisibleText:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 222
        -- upvalues: u30 (copy)
        u30:_UpdateText();
    end);
    u30.DescriptionInvisibleText:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 226
        -- upvalues: u30 (copy)
        u30:_UpdateText();
    end);
    u30.DescriptionInvisibleText:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 230
        -- upvalues: u30 (copy)
        u30:_UpdateText();
    end);
    u30.DescriptionInvisibleText:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 234
        -- upvalues: u30 (copy)
        u30:_UpdateText();
    end);
    u30.DescriptionText:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 238
        -- upvalues: u30 (copy)
        u30:_UpdateText();
    end);
    PlayerDataController.SettingsSliderChanged:Connect(function(p31, p32) -- Line: 242
        -- upvalues: u30 (copy)
        u30:_UpdateCrosshairAppearance({
            [p31] = p32
        });
    end);

    for i, v in pairs(SettingsLibrary.Info) do
        if v.Section == "Crosshair" then
            PlayerDataController:GetSettingChangedSignal(i):Connect(function() -- Line: 248
                -- upvalues: u30 (copy)
                u30:_UpdateCrosshairAppearance();
            end);
        end;
    end;

    u30:_Setup();
    u30:_UpdateText();
    u30:_UpdateCrosshairAppearance();
end;

return u1;