-- Instance: StarterPlayer.StarterPlayerScripts.Modules.Pages.EventOverview
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local EventController = require(Players.LocalPlayer.PlayerScripts.Controllers.EventController);
local ShopController = require(Players.LocalPlayer.PlayerScripts.Controllers.ShopController);
local MatchmakingQueueSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseMatchmakingQueueSlot"):WaitForChild("MatchmakingQueueSlot"));
local ShopSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseShopSlot"):WaitForChild("ShopSlot"));
local AdventCalendarSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("AdventCalendarSlot"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Pages = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Pages"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local TaskSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("TaskSlot"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 25
    -- upvalues: Page (copy), u1 (copy), PromptSystem (copy), AdventCalendarSlot (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.PromptsFrame = v3.PageFrame:WaitForChild("Prompts");
    v3.LockedFrame = v3.PageFrame:WaitForChild("Locked");
    v3.LockedDescriptionText = v3.LockedFrame:WaitForChild("Description");
    v3.List = v3.PageFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.HeaderFrame = v3.Container:WaitForChild("Header");
    v3.HeaderPicture = v3.HeaderFrame:WaitForChild("Picture");
    v3.HeaderTitleText = v3.HeaderFrame:WaitForChild("Title");
    v3.HeaderCountdownText = v3.HeaderFrame:WaitForChild("Countdown");
    v3.EventTasksFrame = v3.Container:WaitForChild("EventTasks");
    v3.EventTasksLockedFrame = v3.EventTasksFrame:WaitForChild("Locked");
    v3.EventTasksLockedDescription = v3.EventTasksLockedFrame:WaitForChild("Description");
    v3.EventTasksUnlockedFrame = v3.EventTasksFrame:WaitForChild("Unlocked");
    v3.EventTasksContainer = v3.EventTasksUnlockedFrame:WaitForChild("Container");
    v3.EventTasksTitleText = v3.EventTasksContainer:WaitForChild("Title");
    v3.EventTasksSlotsFrame = v3.EventTasksContainer:WaitForChild("Slots");
    v3.EventTasksSlotsLayout = v3.EventTasksSlotsFrame:WaitForChild("Layout");
    v3.RushFrame = v3.EventTasksUnlockedFrame:WaitForChild("Rush");
    v3.RushContainer = v3.RushFrame:WaitForChild("Container");
    v3.RushTitleText = v3.RushContainer:WaitForChild("Title");
    v3.RushProgressFrame = v3.RushContainer:WaitForChild("Progress");
    v3.RushProgressBar = v3.RushProgressFrame:WaitForChild("Bar");
    v3.RushProgressCompleted = v3.RushProgressFrame:WaitForChild("Completed");
    v3.RushProgressText = v3.RushProgressFrame:WaitForChild("Title");
    v3.ShopEntriesFrame = v3.Container:WaitForChild("ShopEntries");
    v3.ShopEntriesContainer = v3.ShopEntriesFrame:WaitForChild("Container");
    v3.ShopEntriesTitleText = v3.ShopEntriesContainer:WaitForChild("Title");
    v3.ShopEntriesSlotsFrame = v3.ShopEntriesContainer:WaitForChild("Slots");
    v3.ShopEntriesSlotsLayout = v3.ShopEntriesSlotsFrame:WaitForChild("Layout");
    v3.AdventCalendarFrame = v3.Container:WaitForChild("AdventCalendar");
    v3.SkinBundleFrame = v3.Container:WaitForChild("SkinBundle");
    v3.SkinBundleContainer = v3.SkinBundleFrame:WaitForChild("Container");
    v3.SkinBundleRewardsFrame = v3.SkinBundleContainer:WaitForChild("Rewards");
    v3.PromptSystem = PromptSystem.new(v3.PromptsFrame);
    v3.AdventCalendarSlot = AdventCalendarSlot.new(v3.AdventCalendarFrame);
    v3._open_connections = {};
    v3._task_slots = {};
    v3._shop_slots = {};
    v3:_Init();

    return v3;
end;

function u1.Open(u4, ...) -- Line: 80
    -- upvalues: Page (copy), PlayerDataController (copy)
    Page.Open(u4, ...);
    u4.AdventCalendarSlot:SetEnabled(true);
    local _open_connections = u4._open_connections;
    local DataChangedSignal = PlayerDataController:GetDataChangedSignal("Tasks");
    table.insert(_open_connections, DataChangedSignal:Connect(function() -- Line: 85
        -- upvalues: u4 (copy)
        u4:_GenerateTasks();
    end));
    local _open_connections2 = u4._open_connections;
    local DataChangedSignal2 = PlayerDataController:GetDataChangedSignal("EventTasks");
    table.insert(_open_connections2, DataChangedSignal2:Connect(function() -- Line: 89
        -- upvalues: u4 (copy)
        u4:_GenerateTasks();
    end));
    local _open_connections3 = u4._open_connections;
    local DataChangedSignal3 = PlayerDataController:GetDataChangedSignal("CosmeticInventory");
    table.insert(_open_connections3, DataChangedSignal3:Connect(function() -- Line: 93
        -- upvalues: u4 (copy)
        u4:_GenerateShopEntries();
    end));
    local _open_connections4 = u4._open_connections;
    local DataChangedSignal4 = PlayerDataController:GetDataChangedSignal("WeaponInventory");
    table.insert(_open_connections4, DataChangedSignal4:Connect(function() -- Line: 97
        -- upvalues: u4 (copy)
        u4:_GenerateShopEntries();
    end));
    local _open_connections5 = u4._open_connections;
    local DataChangedSignal5 = PlayerDataController:GetDataChangedSignal("EventCurrencyRushProgress");
    table.insert(_open_connections5, DataChangedSignal5:Connect(function() -- Line: 101
        -- upvalues: u4 (copy)
        u4:_UpdateRush();
    end));
    local _open_connections6 = u4._open_connections;
    local DataChangedSignal6 = PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed");
    table.insert(_open_connections6, DataChangedSignal6:Connect(function() -- Line: 105
        -- upvalues: u4 (copy)
        u4:_UpdateLocked();
    end));
    task.spawn(function() -- Line: 109
        -- upvalues: u4 (copy)
        while u4._is_open_hash == u4._is_open_hash do
            u4:_UpdateCountdown();
            wait(1);
        end;
    end);
    u4:_UpdateRush();
    u4:_UpdateCountdown();
    u4:_UpdateLocked();
    u4:_GenerateTasks();
    u4:_GenerateShopEntries();
end;

function u1.Close(p5, ...) -- Line: 125
    -- upvalues: Page (copy)
    p5.AdventCalendarSlot:SetEnabled(false);
    Page.Close(p5, ...);
end;

function u1._UpdateLayouts(p6) -- Line: 134
    p6.List.CanvasSize = UDim2.new(0, 0, 0, p6.Layout.AbsoluteContentSize.Y);
    p6.ShopEntriesFrame.Size = UDim2.new(1, 0, 0, p6.ShopEntriesContainer.AbsoluteSize.Y * 0.3 + p6.ShopEntriesSlotsLayout.AbsoluteContentSize.Y);
    local EventTasksFrame = p6.EventTasksFrame;
    local v7;

    if p6.EventTasksLockedFrame.Visible then
        v7 = UDim2.new(1, 0, 0.075, 0);
    else
        v7 = UDim2.new(1, 0, 0, p6.EventTasksContainer.AbsoluteSize.Y * 0.2 + p6.EventTasksSlotsLayout.AbsoluteContentSize.Y + p6.RushFrame.AbsoluteSize.Y);
    end;

    EventTasksFrame.Size = v7;
end;

function u1._UpdateLocked(p8) -- Line: 141
    -- upvalues: EventLibrary (copy), PlayerDataController (copy)
    local v9 = EventLibrary.NUM_GAMES_NEEDED_TO_PARTICIPATE - PlayerDataController:GetStatistic("StatisticDuelsPlayed");
    p8.List.Visible = v9 <= 0;
    p8.LockedFrame.Visible = v9 > 0;
    p8.LockedDescriptionText.Text = "Play " .. v9 .. " more duels to gain access!";
end;

function u1._UpdateCountdown(p10) -- Line: 149
    -- upvalues: EventController (copy), Utility (copy)
    local TimeRemaining = EventController:GetTimeRemaining();
    p10.HeaderCountdownText.Text = TimeRemaining and TimeRemaining == 0 and "Ending any minute now!" or (TimeRemaining and (TimeRemaining > 0 and "Ending in " .. Utility:TimeFormat2(TimeRemaining)) or "Here for a limited time only!");
end;

function u1._UpdateRush(p11) -- Line: 157
    -- upvalues: PlayerDataController (copy), EventLibrary (copy)
    local v12 = PlayerDataController:Get("EventCurrencyRushProgress");
    local math_clamp_ret = math.clamp(v12 / EventLibrary.CURRENCY_RUSH_DAILY_LIMIT, 0, 1);
    p11.RushProgressText.Text = math_clamp_ret < 1 and v12 .. " / " .. EventLibrary.CURRENCY_RUSH_DAILY_LIMIT or "";
    p11.RushProgressCompleted.Visible = math_clamp_ret >= 1;
    p11.RushProgressBar.Size = UDim2.new(math_clamp_ret, 0, 1, 2);
    p11.RushProgressBar.BackgroundColor3 = math_clamp_ret < 1 and EventLibrary.EVENT_DETAILS.CURRENCY_COLOR or Color3.fromRGB(100, 255, 50);
end;

function u1._GenerateTasks(p13, p14) -- Line: 167
    -- upvalues: PlayerDataController (copy), TaskSlot (copy)
    for _, v in pairs(p13._task_slots) do
        v:Destroy();
    end;

    p13._task_slots = {};
    p13.EventTasksLockedFrame.Visible = not PlayerDataController:AreTasksCompleted();
    p13.EventTasksUnlockedFrame.Visible = not p13.EventTasksLockedFrame.Visible;
    local v15 = PlayerDataController:Get("EventTasks");

    for _, v in pairs(v15 or {}) do
        local v16 = TaskSlot.new(v);
        v16:SetParent(p13.EventTasksSlotsFrame);
        table.insert(p13._task_slots, v16);
    end;

    p13:_UpdateLayouts();
end;

function u1._GenerateShopEntries(u17) -- Line: 188
    -- upvalues: EventLibrary (copy), ShopSlot (copy), ShopController (copy)
    for _, v in pairs(u17._shop_slots) do
        v:Destroy();
    end;

    u17._shop_slots = {};

    for _, v in pairs(EventLibrary.IS_ACTIVE and EventLibrary.SHOP_ENTRIES_OVERVIEW or {}) do
        local u18 = ShopSlot.new(ShopController:GetShopEntry(v));
        u18.Frame.Parent = u17.ShopEntriesSlotsFrame;
        table.insert(u17._shop_slots, u18);
        u18.RewardSlot:OnClick(function() -- Line: 200
            -- upvalues: u18 (copy), u17 (copy)
            if u18.IsLocked or u18.IsOwned then
                return;
            end;

            u17.PromptSystem:Open("InspectShopEntry", u18.ShopEntry.EntryName);
        end);
    end;
end;

function u1._Setup(u19) -- Line: 210
    -- upvalues: EventLibrary (copy), MatchmakingQueueSlot (copy), MonetizationLibrary (copy), CosmeticLibrary (copy), ComplianceController (copy), RewardSlot (copy), ShopController (copy)
    u19.HeaderPicture.Image = EventLibrary.EVENT_DETAILS.OVERVIEW_BANNER_IMAGE;
    u19.HeaderTitleText.Text = string.upper(EventLibrary.EVENT_NAME or "???") .. " EVENT";
    u19.EventTasksTitleText.Text = "Earn " .. EventLibrary.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. "!";
    u19.ShopEntriesTitleText.Text = "Spend " .. EventLibrary.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. "!";
    u19.RushTitleText.Text = string.upper(EventLibrary.EVENT_DETAILS.CURRENCY_NAME) .. " RUSH — Earn ×" .. EventLibrary.CURRENCY_RUSH_MULTIPLIER .. " " .. EventLibrary.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. " every day!";
    u19.EventTasksLockedDescription.Text = "Complete your Daily Tasks to start earning " .. EventLibrary.EVENT_DETAILS.CURRENCY_NAME_PLURAL .. "!";
    u19.SkinBundleFrame.Visible = EventLibrary.SKIN_BUNDLE_NAME ~= nil;

    for i, v in pairs(EventLibrary.LTM_QUEUENAMES or {}) do
        local Frame = Instance.new("Frame");
        Frame.Name = v;
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.Size = UDim2.new(0.995, 0, 0.2, 0);
        Frame.BackgroundTransparency = 1;
        Frame.LayoutOrder = 10 + i;
        Frame.Parent = u19.Container;
        MatchmakingQueueSlot.new(v, Frame).QueueStatus:Connect(function(p20) -- Line: 230
            -- upvalues: u19 (copy)
            if p20 == "Success" then
                u19:CloseRequest();

                return;
            end;

            u19.PromptSystem:Open("ErrorMessage", "Whoops!", p20 or "Server failed to respond, please try again");
        end);
    end;

    if EventLibrary.SKIN_BUNDLE_NAME then
        for i, v in pairs(MonetizationLibrary.Bundles[EventLibrary.SKIN_BUNDLE_NAME].RewardsWithIndividualProductIDs) do
            if v[1] then
                local v21 = v[3];
                local v22 = CosmeticLibrary.Rewards[v21.Name];

                if not (v22 and (v22.Type == "Lootbox" and ComplianceController:ArePaidRandomItemsRestricted())) then
                    local v23 = RewardSlot.new(v21);
                    v23.Frame.LayoutOrder = i;
                    v23:SetInteractable(false);
                    v23:SetNameText("");
                    v23:HideWeaponVisual();
                    v23:SetParent(u19.SkinBundleRewardsFrame);
                end;
            end;
        end;
    end;

    ShopController:GetDailyShop();
end;

function u1._Init(u24) -- Line: 266
    -- upvalues: Pages (copy), EventLibrary (copy), ButtonEffect (copy)
    u24.CloseButton.MouseButton1Click:Connect(function() -- Line: 267
        -- upvalues: u24 (copy)
        u24:CloseRequest();
    end);
    u24.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 271
        -- upvalues: u24 (copy)
        u24:_UpdateLayouts();
    end);
    u24.EventTasksSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 275
        -- upvalues: u24 (copy)
        u24:_UpdateLayouts();
    end);
    u24.ShopEntriesSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 279
        -- upvalues: u24 (copy)
        u24:_UpdateLayouts();
    end);
    u24.SkinBundleContainer.MouseButton1Click:Connect(function() -- Line: 283
        -- upvalues: Pages (ref), EventLibrary (ref)
        Pages.PageSystem:OpenPage("Shop");
        Pages.PageSystem:WaitForPage("Shop"):InspectSkinBundle(EventLibrary.SKIN_BUNDLE_NAME);
    end);
    u24.PromptSystem.PromptAdded:Connect(function(p25) -- Line: 288
        -- upvalues: u24 (copy), Pages (ref)
        u24.List.CanvasPosition = Vector2.new(0, 0);

        if p25.InspectCurrencyPage then
            p25.InspectCurrencyPage:Connect(function() -- Line: 292
                -- upvalues: Pages (ref)
                Pages.PageSystem:OpenPage("Shop");
                Pages.PageSystem:WaitForPage("Shop"):SetPage("Currency");
            end);
        end;
    end);
    u24:_Setup();
    u24:_UpdateRush();
    u24:_UpdateCountdown();
    u24:_UpdateLocked();
    u24:_UpdateLayouts();
    u24:_GenerateTasks();
    u24:_GenerateShopEntries();
    ButtonEffect:Add(u24.CloseButton);
    ButtonEffect:Add(u24.SkinBundleContainer, nil, {
        HoverRatio = 1.025,
        ReleaseRatio = 1.025
    });
end;

return u1._new();