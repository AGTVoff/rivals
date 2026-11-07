-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.CosmeticSlot
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("StaticModel"):WaitForChild("StaticViewModel"));
local CosmeticViewportFrame = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("CosmeticViewportFrame"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local EmoteViewportFrame = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("EmoteViewportFrame"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local CosmeticSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CosmeticSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 21
    -- upvalues: u1 (copy), CosmeticLibrary (copy), CosmeticSlot (copy)
    local v5 = setmetatable({}, u1);
    v5.Name = p2;
    v5.Info = CosmeticLibrary.Cosmetics[v5.Name];
    v5.IsLocked = p3;
    v5.Frame = CosmeticSlot:Clone();
    v5._destroyed = false;
    v5._cleanup = {};
    v5._owned_connections = {};
    v5._ignore_button_effects = p4;
    v5._quantity = 1;
    v5._name_text_override = nil;
    v5._emote_viewport_frame = nil;
    v5._cosmetic_viewport_frame = nil;
    v5._owned_gradients = {};
    v5:_Init();

    return v5;
end;

function u1.SetWeapon(p6, p7) -- Line: 48
    -- upvalues: ItemLibrary (copy), WeaponStatusHandler (copy)
    local v8 = ItemLibrary.Items[p7];
    local v9 = ItemLibrary.ViewModels[p7];
    local v10 = p7 == "IsUniversal" and true or p7 == "IsRandom";
    local v11;

    if p7 == "IsUniversal" then
        v11 = ItemLibrary.UNIVERSAL_WEAPON_ICON;
    elseif p7 == "IsRandom" then
        v11 = ItemLibrary.RANDOM_WEAPON_ICON;
    else
        v11 = not v9 and "" or (v9.ImageCentered or v9.Image);
    end;

    p6.Frame.Button.Weapon.Visible = not p6.IsLocked and p7;
    p6.Frame.Button.Weapon.Container.IconCanvas.Icon.Image = v11;
    p6.Frame.Button.Weapon.Container.IconCanvas.Icon.ImageTransparency = v10 and 0.25 or 0;
    p6.Frame.Button.Weapon.Container.IconCanvas.Icon.Size = v10 and UDim2.new(0.75, 0, 1, 0) or UDim2.new(4, 0, 4, 0);
    WeaponStatusHandler:ApplyItemStatusToBackground(p6.Frame.Button.Weapon.Container.Background, p6.Frame.Button.Weapon.Container.Outline.UIStroke, v8 and v8.Status or "Standard");
end;

function u1.SetQuantity(p12, p13) -- Line: 66
    p12._quantity = p13 or 1;
    p12:_UpdateNameText();
end;

function u1.SetInteractable(p14, p15) -- Line: 71
    p14.Frame.Button.Interactable = p15;
end;

function u1.EnableOwnedLogic(u16, p17) -- Line: 75
    -- upvalues: PlayerDataController (copy)
    for _, v in pairs(u16._owned_connections) do
        v:Disconnect();
    end;

    u16._owned_connections = {};
    u16:_UpdateOwned(false);

    if not p17 then
        return;
    end;

    local _owned_connections = u16._owned_connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("CosmeticInventory");
    table.insert(_owned_connections, DataChangedSignal:Connect(function() -- Line: 87
        -- upvalues: u16 (copy)
        u16:_UpdateOwned();
    end));
    u16:_UpdateOwned();
end;

function u1.OverrideNameText(p18, p19) -- Line: 94
    p18._name_text_override = p19;
    p18:_UpdateNameText();
end;

function u1.UseHighResolutionImage(p20) -- Line: 99
    -- upvalues: CONSTANTS (copy), ItemLibrary (copy)
    p20.Frame.Button.Icon.Image = CONSTANTS.COSMETIC_IMAGES[p20.Name] or ItemLibrary.ViewModels[p20.Name] and ItemLibrary.ViewModels[p20.Name].ImageHighResolution or p20.Info.Image;
end;

function u1.HideBackground(p21) -- Line: 103
    p21.Frame.Button.Background.Visible = false;

    if p21._cosmetic_viewport_frame then
        p21._cosmetic_viewport_frame.Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    end;

    if p21._emote_viewport_frame then
        p21._emote_viewport_frame.Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    end;
end;

function u1.ZoomOutViewportFrame(p22) -- Line: 115
    if p22._cosmetic_viewport_frame then
        p22._cosmetic_viewport_frame:ZoomOut();
    end;

    if p22._emote_viewport_frame then
        p22._emote_viewport_frame:ZoomOut();
    end;
end;

function u1.Destroy(u23) -- Line: 125
    if u23._destroyed then
        return;
    end;

    u23._destroyed = true;
    pcall(function() -- Line: 132
        -- upvalues: u23 (copy)
        u23.Frame:Destroy();
    end);

    for _, v in pairs(u23._owned_connections) do
        v:Disconnect();
    end;

    for _, v in pairs(u23._cleanup) do
        v:Destroy();
    end;

    if u23._cosmetic_viewport_frame then
        u23._cosmetic_viewport_frame:Destroy();
    end;

    if u23._emote_viewport_frame then
        u23._emote_viewport_frame:Destroy();
    end;
end;

function u1._UpdateOwned(p24, p25) -- Line: 157
    -- upvalues: CosmeticLibrary (copy), PlayerDataController (copy)
    for _, v in pairs(p24._owned_gradients) do
        v:Destroy();
    end;

    p24._owned_gradients = {};

    if p25 == nil then
        p25 = CosmeticLibrary:OwnsCosmeticForSomething(PlayerDataController:Get("CosmeticInventory"), p24.Name);
    end;

    p24.Frame.Button.Owned.Visible = p25;

    if p25 then
        local v26 = {};
        v26[1], v26[2], v26[3] = p24.Frame.Button.Icon, p24._emote_viewport_frame and p24._emote_viewport_frame.Frame, p24._cosmetic_viewport_frame and p24._cosmetic_viewport_frame.Frame;

        for _, v in pairs(v26) do
            if v then
                local UIGradient = Instance.new("UIGradient");
                UIGradient.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0));
                UIGradient.Parent = v;
                table.insert(p24._owned_gradients, UIGradient);
            end;
        end;
    end;
end;

function u1._UpdateNameText(p27) -- Line: 182
    -- upvalues: Utility (copy)
    p27.Frame.Button.Title.Size = (p27._name_text_override or (p27._quantity == 1 or p27._quantity == 0)) and UDim2.new(0.9, 0, 0.2, 0) or UDim2.new(0.9, 0, 0.4, 0);
    p27.Frame.Button.Title.Text = p27._name_text_override or (p27.Name == "RANDOM_COSMETIC" and "Random" or (p27.Name == "NONE_COSMETIC" and "None" or ((p27._quantity == 1 or p27._quantity == 0) and p27.Name or "×" .. Utility:PrettyNumber(p27._quantity))));
end;

function u1._Setup(p28) -- Line: 191
    -- upvalues: CosmeticLibrary (copy), CONSTANTS (copy), ButtonEffect (copy), EmoteViewportFrame (copy), CosmeticViewportFrame (copy)
    local v29 = p28.Info and CosmeticLibrary.Rarities[p28.Info.Rarity].Color or Color3.fromRGB(0, 0, 0);
    p28.Frame.Button.Icon.ZIndex = p28.Info and (p28.Info.Type == "Skin" and not p28.IsLocked) and 3 or p28.Frame.Button.Icon.ZIndex;
    p28.Frame.Button.Icon.Size = (p28.Name == "RANDOM_COSMETIC" or p28.Name == "NONE_COSMETIC") and UDim2.new(0.45, 0, 0.45, 0) or UDim2.new(0.75 * p28.Info.ImageScale, 0, 0.75 * p28.Info.ImageScale, 0);
    p28.Frame.Button.Icon.Image = CONSTANTS.COSMETIC_IMAGES[p28.Name] or p28.Info.Image;
    p28.Frame.Button.Icon.ImageTransparency = (p28.Name == "RANDOM_COSMETIC" or p28.Name == "NONE_COSMETIC") and 0.875 or (p28.IsLocked and 0.5 or 0);
    p28.Frame.Button.Icon.ImageColor3 = p28.IsLocked and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
    p28.Frame.Button.Title.TextTransparency = p28.IsLocked and 0.5 or 0;
    p28.Frame.Button.Locked.Visible = p28.IsLocked;
    p28.Frame.Button.Background.UIStroke.Color = v29;
    p28.Frame.Button.Background.BackgroundColor3 = v29;

    if not p28._ignore_button_effects then
        ButtonEffect:Add(p28.Frame.Button);
    end;

    if not (p28.IsLocked and p28.Info) then
        if p28.Info then
            if p28.Info.Type == "Emote" then
                p28._emote_viewport_frame = EmoteViewportFrame.new(p28.Name);
                p28._emote_viewport_frame.Frame.ZIndex = p28.IsLocked and 0 or 1;
                p28._emote_viewport_frame:SetParent(p28.Frame.Button);
                p28._emote_viewport_frame:SetLocked(p28.IsLocked);

                return;
            end;

            p28._cosmetic_viewport_frame = CosmeticViewportFrame.new(p28.Name, p28.IsLocked);
            p28._cosmetic_viewport_frame.Frame.BackgroundColor3 = v29;
            p28._cosmetic_viewport_frame.Frame.Parent = p28.Frame.Button;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0, 8);
            UICorner.Parent = p28._cosmetic_viewport_frame.Frame;
        end;

        return;
    end;

    p28.Frame.Button.Icon.ZIndex = 1;
    p28.Frame.Button.Icon.Size = UDim2.new(0.6, 0, 0.6, 0);
    p28.Frame.Button.Icon.Image = CosmeticLibrary.Types[p28.Info.Type].Image;
    p28.Frame.Button.Icon.ImageTransparency = 0.5;
    p28.Frame.Button.Icon.ImageColor3 = Color3.fromRGB(0, 0, 0);
end;

function u1._Init(u30) -- Line: 232
    u30.Frame.Destroying:Connect(function() -- Line: 233
        -- upvalues: u30 (copy)
        u30:Destroy();
    end);
    u30:_Setup();
    u30:_UpdateNameText();
    u30:SetWeapon(nil);
    u30:SetQuantity(nil);
    u30:EnableOwnedLogic(false);
end;

return u1;