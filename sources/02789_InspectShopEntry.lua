-- Instance: StarterPlayer.StarterPlayerScripts.Modules.Prompts.InspectShopEntry
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local CurrencyLibrary = require(ReplicatedStorage.Modules.CurrencyLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local ShopController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ShopController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local ShopEntryBuyButton = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ShopEntryBuyButton");
local u1 = setmetatable({}, Prompt);
u1.__index = u1;

function u1.new(p2) -- Line: 21
    -- upvalues: Prompt (copy), u1 (copy), Signal (copy), ShopController (copy)
    local v3 = Prompt.new(script.Name);
    local v4 = setmetatable(v3, u1);
    v4.InspectCurrencyPage = Signal.new();
    v4.Title = v4.PromptFrame:WaitForChild("Title");
    v4.LimitedFrame = v4.PromptFrame:WaitForChild("Limited");
    v4.Container = v4.PromptFrame:WaitForChild("Container");
    v4.LockedText = v4.PromptFrame:WaitForChild("Locked");
    v4.DisabledText = v4.PromptFrame:WaitForChild("Disabled");
    v4.CloseButton = v4.PromptFrame:WaitForChild("Close");
    v4.ViewContentsButton = v4.PromptFrame:WaitForChild("ViewContents");
    v4.ButtonsFrame = v4.PromptFrame:WaitForChild("Buttons");
    v4.AreYouSureTitle = v4.ButtonsFrame:WaitForChild("AreYouSure");
    v4.Name = p2;
    v4.ShopEntry = ShopController:GetShopEntry(p2);
    v4._close_on_purchase = v4.ShopEntry.EntryType == "Daily";
    v4._reward_slots = {};
    v4._update_text_bounds = {};
    v4._robux_buy_buttons = {};
    v4:_Init();

    return v4;
end;

function u1.Destroy(p5) -- Line: 53
    -- upvalues: Prompt (copy)
    for _, v in pairs(p5._reward_slots) do
        v:Destroy();
    end;

    p5.InspectCurrencyPage:Destroy();
    Prompt.Destroy(p5);
end;

function u1._Update(p6) -- Line: 67
    -- upvalues: PlayerDataController (copy), CosmeticLibrary (copy), ComplianceController (copy)
    local v7 = PlayerDataController:Get("CosmeticInventory");
    local v8 = p6.ShopEntry.Rewards[1];
    local v9 = CosmeticLibrary.Cosmetics[v8.Name];
    local v10;

    if v9 then
        v10 = CosmeticLibrary.Types[v9.Type];
    else
        v10 = v9;
    end;

    local v11 = CosmeticLibrary.Rewards[v8.Name];
    local v12 = CosmeticLibrary:OwnsCosmetic(v7, v8.Name, v8.Weapon);
    local Weapon = v8.Weapon;

    if Weapon then
        if v8.Weapon == "IsRandom" or v8.Weapon == "IsUniversal" then
            Weapon = false;
        else
            Weapon = not PlayerDataController:GetWeaponData(v8.Weapon);
        end;
    end;

    local v13;

    if v10 and v10.IsWeaponCosmetic then
        v13 = (v8.Weapon == "IsRandom" and "Random" or (v8.Weapon == "IsUniversal" and "Universal" or v8.Weapon)) .. " " .. v9.Type;
    elseif v9 then
        v13 = v9.Type;
    else
        v13 = v8.Name;
    end;

    p6.Title.Text = v13;
    p6.LockedText.Visible = v12 or Weapon;
    p6.LockedText.Text = v12 and "Unavailable\nYou already own this" or (Weapon and ("Unavailable\nYou don\'t own " .. (v8.Weapon or "") or "") or "");
    local DisabledText = p6.DisabledText;
    local v14 = not p6.LockedText.Visible;

    if v14 then
        if v11 then
            if v11.Type == "Lootbox" then
                v14 = ComplianceController:ArePaidRandomItemsRestricted();
            else
                v14 = false;
            end;
        else
            v14 = v11;
        end;
    end;

    DisabledText.Visible = v14;
    local v15;

    if v11 and v11.Type == "Lootbox" then
        v15 = true;
    else
        v15 = v10 and v10.IsWeaponCosmetic and v8.Weapon == "IsRandom";
    end;

    p6.ViewContentsButton.Visible = v15;
    p6.ButtonsFrame.Visible = not p6.DisabledText.Visible and not p6.LockedText.Visible;
    p6.AreYouSureTitle.Visible = false;

    for _, v in pairs(p6._robux_buy_buttons) do
        v.Visible = not v12 and not Weapon;
    end;
end;

function u1._Setup(u16) -- Line: 91
    -- upvalues: CurrencyLibrary (copy), PlayerDataController (copy), ShopEntryBuyButton (copy), Utility (copy), ButtonEffect (copy), MonetizationController (copy), ShopController (copy), RewardSlot (copy)
    u16.LimitedFrame.Visible = u16.ShopEntry.IsLimited;

    for i, v in pairs(u16.ShopEntry.Prices) do
        local u17 = CurrencyLibrary.Info[i];

        if not u17.OnlyDisplayBuyButtonAboveZeroBalance or PlayerDataController:Get(i) > 0 then
            local u18 = ShopEntryBuyButton:Clone();
            u18.LayoutOrder = u17.OrderIndex;
            u18.Robux.Visible = false;
            u18.Free.Visible = v == 0;
            u18.Currency.Visible = v > 0;
            u18.Currency.Value.Text = Utility:PrettyNumber(v);
            u18.Currency.Value.Icon.Image = u17.ImageFlatOutline;
            u18.Currency.Value.Icon.ImageLabel.Image = u17.ImageFlat;
            u18.Currency.Background.ImageColor3 = u17.Color;
            u18.Currency.Background.UIGradient.Color = u17.ColorGradient;
            u18.Parent = u16.ButtonsFrame;
            ButtonEffect:Add(u18);
            u18.MouseButton1Click:Connect(function() -- Line: 114
                -- upvalues: PlayerDataController (ref), u17 (copy), v (copy), MonetizationController (ref), i (copy), u16 (copy), Utility (ref), u18 (copy), ShopController (ref)
                if PlayerDataController:Get(u17.DataName) < v then
                    if not MonetizationController:PromptCurrencyBundlePurchase(v, i) then
                        Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

                        return;
                    end;

                    u16.InspectCurrencyPage:Fire();
                    u16:CloseRequest();

                    return;
                end;

                if u17.NeedsAreYouSurePrompt and not u16.AreYouSureTitle.Visible then
                    for _, child in pairs(u16.ButtonsFrame:GetChildren()) do
                        if child:IsA("GuiBase2d") then
                            child.Visible = false;
                        end;
                    end;

                    u18.Visible = true;
                    u16.AreYouSureTitle.Visible = true;

                    return;
                end;

                Utility:CreateSound("rbxassetid://18210861148", 1, 1, script, true, 5);
                ShopController:PurchaseShopEntry(u16.Name, i);
                u16:_Update();

                if u16._close_on_purchase then
                    u16:CloseRequest();
                end;
            end);
            local Value = u18.Currency.Value;
            local Icon = Value.Icon;

            local function update() -- Line: 151
                -- upvalues: Icon (copy), Value (copy)
                Icon.Position = UDim2.new(0.5, Value.TextBounds.X / 2, 0.5, 0);
            end;

            Value:GetPropertyChangedSignal("TextBounds"):Connect(update);
            u18.AncestryChanged:Connect(update);
            Icon.Position = UDim2.new(0.5, Value.TextBounds.X / 2, 0.5, 0);
        end;
    end;

    for i, v in pairs(u16.ShopEntry.ProductIDs or {}) do
        local v19 = ShopEntryBuyButton:Clone();
        v19.LayoutOrder = 9999 + v;
        v19.Free.Visible = false;
        v19.Currency.Visible = false;
        v19.Robux.Visible = true;
        v19.Robux.Title.Text = "Buy ×" .. v;
        v19.Robux.Title.Visible = v ~= 1;
        local Value = v19.Robux.Value;
        local v20;

        if v == 1 then
            v20 = UDim2.new(0.5, 0, 0.5, 0);
        else
            v20 = UDim2.new(0.5, 0, 0.625, 0);
        end;

        Value.Position = v20;
        v19.Parent = u16.ButtonsFrame;
        table.insert(u16._robux_buy_buttons, v19);
        ButtonEffect:Add(v19);
        MonetizationController:SetRobuxText(v19.Robux.Value, i, Enum.InfoType.Product);
        v19.MouseButton1Click:Connect(function() -- Line: 174
            -- upvalues: u16 (copy), ShopController (ref), v (copy)
            if u16._close_on_purchase then
                u16:CloseRequest();
            end;

            ShopController:PurchaseShopEntry(u16.Name, nil, v);
        end);
    end;

    for i, v in pairs(u16.ShopEntry.Rewards) do
        local v21 = RewardSlot.new(v);
        v21.Frame.LayoutOrder = i;
        v21:SetParent(u16.Container);
        table.insert(u16._reward_slots, v21);
    end;
end;

function u1._Init(u22) -- Line: 193
    -- upvalues: PlayerDataController (copy), ButtonEffect (copy)
    u22.CloseButton.MouseButton1Click:Connect(function() -- Line: 194
        -- upvalues: u22 (copy)
        u22:CloseRequest();
    end);
    u22.ViewContentsButton.MouseButton1Click:Connect(function() -- Line: 198
        -- upvalues: u22 (copy)
        u22.OpenPrompt:Fire("InspectLootbox", u22.ShopEntry.Rewards[1].Name, u22.ShopEntry.Rewards[1].Weapon, "InspectShopEntry", u22.Name);
    end);
    local _connections = u22._connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("CosmeticInventory");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 202
        -- upvalues: u22 (copy)
        u22:_Update();
    end));
    local _connections2 = u22._connections;
    local DataChangedSignal2 = PlayerDataController:GetDataChangedSignal("WeaponInventory");
    table.insert(_connections2, DataChangedSignal2:Connect(function() -- Line: 206
        -- upvalues: u22 (copy)
        u22:_Update();
    end));
    u22:_Setup();
    u22:_Update();
    ButtonEffect:Add(u22.CloseButton);
    ButtonEffect:Add(u22.ViewContentsButton);
end;

return u1;