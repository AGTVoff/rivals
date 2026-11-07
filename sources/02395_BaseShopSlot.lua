-- Instance: StarterPlayer.StarterPlayerScripts.Modules.BaseShopSlot
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local CurrencyLibrary = require(ReplicatedStorage.Modules.CurrencyLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 13
    -- upvalues: u1 (copy), CosmeticLibrary (copy), PlayerDataController (copy)
    local v4 = setmetatable({}, u1);
    v4.ShopEntry = p2;
    v4.FirstRewardData = v4.ShopEntry.Rewards[1];
    v4.IsOwned = CosmeticLibrary:OwnsCosmetic(PlayerDataController:Get("CosmeticInventory"), v4.FirstRewardData.Name, v4.FirstRewardData.Weapon);
    local Weapon = v4.FirstRewardData.Weapon;

    if Weapon then
        if v4.FirstRewardData.Weapon == "IsRandom" or v4.FirstRewardData.Weapon == "IsUniversal" then
            Weapon = false;
        else
            Weapon = not PlayerDataController:GetWeaponData(v4.FirstRewardData.Weapon);
        end;
    end;

    v4.IsLockedRaw = Weapon;
    v4.IsLocked = p3 or false;
    v4:_Init();

    return v4;
end;

function u1.OnClick(p5, p6) -- Line: 31
    assert(false, "Not implemented");
end;

function u1.Destroy(p7) -- Line: 35
end;

function u1._GetLowestQuantityProductID(p8) -- Line: 43
    if not p8.ShopEntry.ProductIDs then
        return nil;
    end;

    local v9 = {};

    for i, v in pairs(p8.ShopEntry.ProductIDs) do
        table.insert(v9, { v, i });
    end;

    table.sort(v9, function(p10, p11) -- Line: 54
        return p10[1] < p11[1];
    end);

    return v9[1][2];
end;

function u1._SetupBuyButton(p12, p13, p14) -- Line: 61
    -- upvalues: CosmeticLibrary (copy), CurrencyLibrary (copy), Utility (copy), MonetizationController (copy)
    local v15 = CosmeticLibrary.Cosmetics[p12.FirstRewardData.Name];
    local v16 = CurrencyLibrary.Info[p12.ShopEntry.MainCurrency];
    local v17 = p12.ShopEntry.Prices[p12.ShopEntry.MainCurrency];
    local v18 = p12:_GetLowestQuantityProductID();

    if p14 then
        p14.Visible = p12.IsOwned;
    end;

    p13.Visible = not p12.IsOwned;
    p13.Limited.Visible = false;
    p13.Locked.Visible = not p13.Limited.Visible and p12.IsLocked;
    p13.Price.Visible = not p13.Limited.Visible and (not p12.IsLocked and p12.ShopEntry.MainCurrency) and v17 > 0;
    p13.Free.Visible = not p13.Limited.Visible and (not p12.IsLocked and p12.ShopEntry.MainCurrency) and v17 == 0;
    p13.Robux.Visible = not p13.Limited.Visible and (not p12.IsLocked and v18);
    p13.Size = v15 and UDim2.new(0.5, 0, 0.25, 0) or UDim2.new(0.625, 0, 0.3125, 0);

    if p13.Price.Visible then
        p13.Price.Value.Text = Utility:PrettyNumber(v17);
        p13.Price.Value.Icon.Image = v16.ImageFlatOutline;
        p13.Price.Value.Icon.ImageLabel.Image = v16.ImageFlat;
        p13.Price.Background.ImageColor3 = v16.Color;
        p13.Price.Background.UIGradient.Color = v16.ColorGradient;
    end;

    if v18 then
        MonetizationController:SetRobuxText(p13.Robux.Value, v18, Enum.InfoType.Product);
    end;

    for _, v in pairs({ "Locked", "Price", "Free", "Robux", "Limited" }) do
        if not p13[v].Visible then
            p13[v]:Destroy();
        end;
    end;

    if p13:FindFirstChild("Price") then
        local Value = p13.Price.Value;
        local Icon = Value.Icon;

        local function update() -- Line: 101
            -- upvalues: Icon (copy), Value (copy)
            Icon.Position = UDim2.new(0.5, Value.TextBounds.X / 2, 0.5, 0);
        end;

        Value:GetPropertyChangedSignal("TextBounds"):Connect(update);
        p13.AncestryChanged:Connect(update);
        Icon.Position = UDim2.new(0.5, Value.TextBounds.X / 2, 0.5, 0);
    end;
end;

function u1._Init(p19) -- Line: 111
end;

return u1;