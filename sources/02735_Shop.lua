-- Instance: StarterPlayer.StarterPlayerScripts.Modules.Pages.Shop
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
require(ReplicatedStorage.Modules.EventLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ComplianceController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local ShopController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ShopController"));
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local Spotlight = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Spotlight"));
local ShopSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseShopSlot"):WaitForChild("ShopSlot"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local BundleSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BundleSlot"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local BottomTabs = require(script:WaitForChild("BottomTabs"));
local Pages = require(script:WaitForChild("Pages"));
local Tabs = require(script:WaitForChild("Tabs"));
local u1 = { "rpg_bundle", "energy_bundle", "starter_bundle", "medkit_bundle", "exogun_bundle", "heavyduty_bundle", "classic_bundle", "standardweapons_bundle" };
local u2 = { "Home", "Bundles", "Skins", "Daily", "Currency", "Ranked", "Rewards", "Gifting", "Weapons" };
local u3 = setmetatable({}, Page);
u3.__index = u3;

function u3._new() -- Line: 31
    -- upvalues: Page (copy), u3 (copy), Signal (copy), u1 (copy), u2 (copy), PromptSystem (copy), Tabs (copy), Pages (copy), BottomTabs (copy)
    local v4 = Page.new(script.Name);
    local v5 = setmetatable(v4, u3);
    v5.CurrentPageChanged = Signal.new();
    v5.PageContainer = v5.PageFrame:WaitForChild("Container");
    v5.PromptsFrame = v5.PageContainer:WaitForChild("Prompts");
    v5.WaitingFrame = v5.PageContainer:WaitForChild("Waiting");
    v5.DotsFrame = v5.WaitingFrame:WaitForChild("Dots");
    v5.List = v5.PageContainer:WaitForChild("List");
    v5.Container = v5.List:WaitForChild("Container");
    v5.BUNDLE_NAMES = u1;
    v5.PAGE_NAMES = u2;
    v5.HidePartyDisplay = true;
    v5.CurrentPage = nil;
    v5.PromptSystem = PromptSystem.new(v5.PromptsFrame);
    v5.Tabs = Tabs.new(v5);
    v5.Pages = Pages.new(v5);
    v5.BottomTabs = BottomTabs.new(v5);
    v5._open_animation_disabled = true;
    v5._setup_finished = false;
    v5._setup_finished_event_internal = Signal.new();
    v5._bundle_slots = {};
    v5:_Init();

    return v5;
end;

function u3.SetPage(p6, p7) -- Line: 67
    -- upvalues: Spotlight (copy), Equipment (copy)
    Spotlight:ChangeSubject(nil);

    if p7 == "Weapons" then
        Equipment:Open(true);
        p6:CloseRequest();

        return;
    end;

    if p7 == "Gifting" then
        p6.OpenPage:Fire("Gifting");

        return;
    end;

    if p7 == "Rewards" then
        p6.OpenPage:Fire("Rewards");

        return;
    end;

    if p7 == "BattlePass" then
        p6.OpenPage:Fire("BattlePass");

        return;
    end;

    p6.CurrentPage = p7;
    p6.CurrentPageChanged:Fire(p6.CurrentPage);
end;

function u3.InspectSkinBundle(u8, u9) -- Line: 89
    u8:SetPage("Skins");
    task.delay(0.5, function() -- Line: 92
        -- upvalues: u8 (copy), u9 (copy)
        u8.Pages.Components.Skins:Inspect(u9);
    end);
end;

function u3.InspectShopEntry(p10, p11) -- Line: 97
    if p11 then
        p10.PromptSystem:Open("InspectShopEntry", p11);
    end;
end;

function u3.InspectBundle(u12, u13, p14) -- Line: 103
    if not u13 then
        return;
    end;

    task.defer(function() -- Line: 108
        -- upvalues: u12 (copy), u13 (copy)
        if not u12._setup_finished then
            u12._setup_finished_event_internal:Wait();
        end;

        u12.PromptSystem:Open("InspectBundle", u13);
    end);
end;

function u3.CreateShopSlot(u15, p16, p17, p18, ...) -- Line: 117
    -- upvalues: Utility (copy), ShopController (copy), ShopSlot (copy), CosmeticLibrary (copy), ComplianceController (copy)
    local v19 = Utility:CloneTable(ShopController:GetShopEntry(p18));

    if p17 then
        p17.BackgroundTransparency = 1;
    end;

    for _, v in pairs(v19.Rewards) do
        local v20 = CosmeticLibrary.Rewards[v.Name];

        if v20 and v20.Type == "Lootbox" then
            ComplianceController:ArePaidRandomItemsRestricted();
        end;
    end;

    local u21 = (p16 or ShopSlot).new(v19, ...);
    u21.Frame.Parent = p17;
    u21:OnClick(function() -- Line: 136
        -- upvalues: u21 (copy), u15 (copy)
        if u21.IsLocked or u21.IsOwned then
            return;
        end;

        u15:InspectShopEntry(u21.ShopEntry.EntryName);
    end);

    return u21;
end;

function u3.CreateBundleSlot(u22, p23) -- Line: 147
    -- upvalues: BundleSlot (copy), ControlsController (copy)
    local u24 = BundleSlot.new(p23);
    u22._bundle_slots[p23] = u24;
    u24.Tapped:Connect(function() -- Line: 151
        -- upvalues: ControlsController (ref), u22 (copy), u24 (copy)
        if ControlsController.CurrentControls == "Touch" then
            u22:InspectBundle(u24.Name);

            return;
        end;

        u24:PurchaseRequest();
    end);

    return u24;
end;

function u3.Open(p25, ...) -- Line: 163
    -- upvalues: Page (copy), Utility (copy)
    Page.Open(p25, ...);
    p25.Tabs:Open();
    p25.Pages:Open();
    p25.BottomTabs:Open();
    Utility:CreateSound("rbxassetid://18100002432", 1.25, 1, script, true, 5);
end;

function u3.Close(p26, ...) -- Line: 171
    -- upvalues: Page (copy)
    Page.Close(p26, ...);
    p26.Tabs:Close();
    p26.Pages:Close();
    p26.BottomTabs:Close();
end;

function u3._CheckScrollDownToLoginRewards(u27) -- Line: 182
    -- upvalues: PlayerDataController (copy), TweenService (copy)
    if u27.CurrentPage ~= "Daily" or PlayerDataController:Get("ClaimedLoginRewardToday") then
        return;
    end;

    local Frame = u27.Pages.Components.Daily.LoginRewards.Frame;
    task.delay(0.15, function() -- Line: 189
        -- upvalues: TweenService (ref), u27 (copy), Frame (copy)
        TweenService:Create(u27.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            CanvasPosition = Vector2.new(0, Frame.AbsolutePosition.Y - u27.Container.AbsolutePosition.Y)
        }):Play();
    end);
end;

function u3._UpdatePromptContext(p28) -- Line: 194
    p28.List.Visible = not p28.PromptSystem.CurrentPrompt;
end;

function u3._UpdateScale(p29) -- Line: 198
    local v30 = p29.CurrentPage == "Home" and 0.9 or 1;
    p29.List.Size = UDim2.new(1 / v30, 18, 1, 0);
    p29.Container.Size = UDim2.new(v30 * 1, -8, v30 * 1, -8);
end;

function u3._UpdateCanvasSize(p31) -- Line: 205
    -- upvalues: UILibrary (copy)
    local ComponentFrame = p31.Pages:GetComponentFrame(p31.CurrentPage);
    p31.List.Size = UDim2.new(1, 18, 0, (math.min(p31.PageFrame.AbsoluteSize.Y, UILibrary.MainGui.AbsolutePosition.Y + UILibrary.MainGui.AbsoluteSize.Y - p31.List.AbsolutePosition.Y - 20)));
    p31.List.CanvasSize = ComponentFrame and UDim2.new(0, 0, 0, ComponentFrame.AbsolutePosition.Y + ComponentFrame.AbsoluteSize.Y - p31.Container.AbsolutePosition.Y) or UDim2.new(0, 0, 0, 0);
end;

function u3._UpdateSize(p32) -- Line: 212
    -- upvalues: GuiService (copy)
    p32.PageContainer.Size = UDim2.new(1, 0, 1, -GuiService.TopbarInset.Height);
end;

function u3._Setup(u33) -- Line: 216
    u33.DotsFrame:AddTag("UILoadingDots");
    u33.WaitingFrame.Visible = true;
    u33.Tabs.Frame.Visible = false;
    u33.Pages.Frame.Visible = false;
    u33.BottomTabs.Frame.Visible = false;
    task.delay(0.25, function() -- Line: 224
        -- upvalues: u33 (copy)
        u33.DotsFrame:RemoveTag("UILoadingDots");
        u33.WaitingFrame.Visible = false;
        u33.Tabs.Frame.Visible = true;
        u33.Pages.Frame.Visible = true;
        u33.BottomTabs.Frame.Visible = true;
        u33.Tabs:Setup();
        u33.Pages:Setup();
        u33.BottomTabs:Setup();
        u33:SetPage(u33.CurrentPage or "Home");
        u33._setup_finished = true;
        u33._setup_finished_event_internal:Fire();
    end);
end;

function u3._Init(u34) -- Line: 243
    -- upvalues: Spotlight (copy), UILibrary (copy), GuiService (copy)
    u34.PromptSystem.PromptAdded:Connect(function(p35) -- Line: 244
        -- upvalues: u34 (copy)
        u34.List.CanvasPosition = Vector2.new(0, 0);
        u34:_UpdatePromptContext();

        if p35.InspectCurrencyPage then
            p35.InspectCurrencyPage:Connect(function() -- Line: 249
                -- upvalues: u34 (ref)
                u34:SetPage("Currency");
            end);
        end;
    end);
    u34.PromptSystem.PromptRemoved:Connect(function() -- Line: 255
        -- upvalues: u34 (copy)
        u34:_UpdatePromptContext();
    end);
    u34.OpenChanged:Connect(function() -- Line: 259
        -- upvalues: Spotlight (ref)
        Spotlight:ChangeSubject(nil);
    end);
    u34.CurrentPageChanged:Connect(function() -- Line: 263
        -- upvalues: u34 (copy)
        u34:_CheckScrollDownToLoginRewards();
        u34:_UpdateCanvasSize();
        u34:_UpdateScale();
    end);
    u34.List:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 269
        -- upvalues: u34 (copy)
        u34:_UpdateCanvasSize();
    end);
    u34.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 273
        -- upvalues: u34 (copy)
        u34:_UpdateCanvasSize();
    end);
    u34.Container:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 277
        -- upvalues: u34 (copy)
        u34:_UpdateCanvasSize();
    end);
    u34.Pages.UpdateCanvasSize:Connect(function() -- Line: 281
        -- upvalues: u34 (copy)
        u34:_UpdateCanvasSize();
    end);
    UILibrary.MainGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 285
        -- upvalues: u34 (copy)
        u34:_UpdateCanvasSize();
    end);
    UILibrary.MainGui:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 289
        -- upvalues: u34 (copy)
        u34:_UpdateCanvasSize();
    end);
    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(function() -- Line: 293
        -- upvalues: u34 (copy)
        u34:_UpdateSize();
    end);
    u34:_Setup();
    u34:_UpdateSize();
    u34:_UpdateScale();
    u34:_UpdateCanvasSize();
    u34:_UpdatePromptContext();
end;

return u3._new();