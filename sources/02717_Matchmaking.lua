-- Instance: StarterPlayer.StarterPlayerScripts.Modules.Pages.Matchmaking
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local RotatingQueueLibrary = require(ReplicatedStorage.Modules.RotatingQueueLibrary);
require(ReplicatedStorage.Modules.CosmeticLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local LeaderboardController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("LeaderboardController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ArcadeController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ArcadeController"));
local MatchmakingQueueSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseMatchmakingQueueSlot"):WaitForChild("MatchmakingQueueSlot"));
local BaseMatchmakingQueueSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseMatchmakingQueueSlot"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RankIcon"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("MatchmakingQueueSlot");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 28
    -- upvalues: Page (copy), u1 (copy), PromptSystem (copy), BaseMatchmakingQueueSlot (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.PromptsFrame = v3.PageFrame:WaitForChild("Prompts");
    v3.PageContainer = v3.PageFrame:WaitForChild("Container");
    v3.CloseButton = v3.PageContainer:WaitForChild("Close");
    v3.List = v3.PageContainer:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.CenterDuelsFrame = v3.Container:WaitForChild("CenterDuels");
    v3.DuelsFrame = v3.Container:WaitForChild("Duels");
    v3.DuelsContainer = v3.DuelsFrame:WaitForChild("Container");
    v3.DuelsContainerCloseButton = v3.DuelsContainer:WaitForChild("Close");
    v3.QueuesFrame = v3.DuelsContainer:WaitForChild("Queues");
    v3.RankedFrame = v3.DuelsContainer:WaitForChild("Ranked");
    v3.RankedButton = v3.RankedFrame:WaitForChild("Button");
    v3.RankedThumbnail = v3.RankedButton:WaitForChild("Thumbnail");
    v3.RankedLockedFrame = v3.RankedButton:WaitForChild("Locked");
    v3.RankedLockedText = v3.RankedLockedFrame:WaitForChild("Description");
    v3.RankedUnlockedFrame = v3.RankedButton:WaitForChild("Unlocked");
    v3.RankedIconContainer = v3.RankedUnlockedFrame:WaitForChild("IconContainer");
    v3.RankedSeasonText = v3.RankedUnlockedFrame:WaitForChild("Season");
    v3.RankedRankText = v3.RankedUnlockedFrame:WaitForChild("Rank");
    v3.RankedELOText = v3.RankedUnlockedFrame:WaitForChild("ELO");
    v3.AprilFoolsFrame = v3.Container:WaitForChild("AprilFools");
    v3.AprilFoolsContainer = v3.AprilFoolsFrame:WaitForChild("Container");
    v3.AprilFoolsSlotsFrame = v3.AprilFoolsContainer:WaitForChild("Slots");
    v3.AprilFoolsSlotsLayout = v3.AprilFoolsSlotsFrame:WaitForChild("Layout");
    v3.ArcadeServersFrame = v3.Container:WaitForChild("ArcadeServers");
    v3.ArcadeServersContainer = v3.ArcadeServersFrame:WaitForChild("Container");
    v3.ArcadeServersHeaderInfoButton = v3.ArcadeServersContainer:WaitForChild("Header"):WaitForChild("Info");
    v3.ArcadeServersHeaderInfoBubble = v3.ArcadeServersHeaderInfoButton:WaitForChild("Bubble");
    v3.ArcadeServersHeaderInfoBubbleTitle = v3.ArcadeServersHeaderInfoBubble:WaitForChild("Title");
    v3.ArcadeServersHeaderInfoBubbleBackground = v3.ArcadeServersHeaderInfoBubble:WaitForChild("Background");
    v3.RotatingFrame = v3.Container:WaitForChild("Rotating");
    v3.RotatingContainer = v3.RotatingFrame:WaitForChild("Container");
    v3.RotatingHeaderFrame = v3.RotatingContainer:WaitForChild("Header");
    v3.RotatingHeaderTitle = v3.RotatingHeaderFrame:WaitForChild("Title");
    v3.RotatingHeaderNewReleaseFrame = v3.RotatingHeaderFrame:WaitForChild("NewRelease");
    v3.RotatingSlotsFrame = v3.RotatingContainer:WaitForChild("Slots");
    v3.RotatingSlotsLayout = v3.RotatingSlotsFrame:WaitForChild("Layout");
    v3.EventFrame = v3.Container:WaitForChild("Event");
    v3.EventContainer = v3.EventFrame:WaitForChild("Container");
    v3.EventHeaderFrame = v3.EventContainer:WaitForChild("Header");
    v3.EventHeaderIcon = v3.EventHeaderFrame:WaitForChild("Icon");
    v3.EventRewardsFrame = v3.EventHeaderFrame:WaitForChild("Rewards");
    v3.EventSlotsFrame = v3.EventContainer:WaitForChild("Slots");
    v3.EventSlotsLayout = v3.EventSlotsFrame:WaitForChild("Layout");
    v3.PromptSystem = PromptSystem.new(v3.PromptsFrame);
    v3.RankedSlot = BaseMatchmakingQueueSlot.new(v3.RankedFrame);
    v3._matchmaking_queue_slots = {};
    v3._rotating_matchmaking_queue_slots = {};
    v3._rotating_batch_containers = {};
    v3._rank_icon = nil;
    v3:_Init();

    return v3;
end;

function u1.ScrollTo(u4, p5, p6) -- Line: 94
    -- upvalues: TweenService (copy)
    local u7;

    if p5 == "Arcade" then
        u7 = u4.ArcadeServersFrame;
    elseif p5 == "Rotating" then
        u7 = u4.RotatingFrame;
    elseif p5 == "Event" then
        u7 = u4.EventFrame;
    else
        u7 = nil;
    end;

    if not u7 then
        return;
    end;

    task.delay(p6 or 0, function() -- Line: 104
        -- upvalues: TweenService (ref), u4 (copy), u7 (copy)
        TweenService:Create(u4.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            CanvasPosition = Vector2.new(0, u7.AbsolutePosition.Y - u4.Container.AbsolutePosition.Y)
        }):Play();
    end);
end;

function u1.Open(p8, ...) -- Line: 109
    -- upvalues: Page (copy)
    Page.Open(p8, ...);
    p8.List.CanvasPosition = Vector2.zero;
    task.defer(p8._GenerateRotatingLoop, p8);
end;

function u1._UpdateLayouts(p9) -- Line: 119
    p9.RotatingFrame.Size = UDim2.new(1, 0, 0.1, p9.RotatingSlotsLayout.AbsoluteContentSize.Y);
    p9.EventFrame.Size = UDim2.new(1, 0, 0.11, p9.EventSlotsLayout.AbsoluteContentSize.Y);
    p9.AprilFoolsFrame.Size = UDim2.new(1, 0, 0.1, p9.AprilFoolsSlotsLayout.AbsoluteContentSize.Y);
    p9.ArcadeServersHeaderInfoBubbleBackground.Size = UDim2.new(0.04, p9.ArcadeServersHeaderInfoBubbleTitle.TextBounds.X, 1, 0);
end;

function u1._UpdateArcadeServerHeaderInfo(p10) -- Line: 126
    p10.ArcadeServersHeaderInfoButton.Visible = true;
end;

function u1._UpdateLocked(p11) -- Line: 130
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy)
    local v12 = PlayerDataController:Get("Level") < SeasonLibrary.CurrentSeason.LevelRequirement;
    p11.RankedLockedFrame.Visible = v12;
    p11.RankedUnlockedFrame.Visible = not v12;
end;

function u1._UpdateELO(p13) -- Line: 137
    -- upvalues: SeasonLibrary (copy), PlayerDataController (copy), Players (copy), Utility (copy), RankIcon (copy)
    if p13._rank_icon then
        p13._rank_icon:Destroy();
        p13._rank_icon = nil;
    end;

    local _ = SeasonLibrary.CurrentSeason.RankProfile;
    local v14 = PlayerDataController:Get("Seasons")[SeasonLibrary.CurrentSeason.Name];

    if v14 then
        v14 = v14.RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];
    end;

    if not v14 then
        return;
    end;

    local Rank = SeasonLibrary:GetRank(v14.CurrentELO, Players.LocalPlayer.UserId);
    p13.RankedRankText.Text = Rank;
    local RankedELOText = p13.RankedELOText;
    local v15;

    if v14.CurrentELO then
        v15 = Utility:PrettyNumber(v14.CurrentELO) .. " ELO";
    else
        v15 = v14.DuelsPlayed .. " / " .. SeasonLibrary.CurrentSeason.RankProfile.NumPlacementDuels;
    end;

    RankedELOText.Text = v15;

    if v14.CurrentELO then
        p13._rank_icon = RankIcon.new(v14.CurrentELO, Players.LocalPlayer.UserId);
        p13._rank_icon:SetParent(p13.RankedIconContainer);
    end;
end;

function u1._UpdateList(p16) -- Line: 162
    p16.CloseButton.Position = UDim2.new(0.975, 0, 0.0225, p16.PageFrame.AbsoluteSize.Y * 0.125);
    p16.List.Position = UDim2.new(0.5, 9, 0, p16.PageFrame.AbsoluteSize.Y * 0.125);
    p16.List.Size = UDim2.new(0.85, 0, 0, p16.PageFrame.AbsoluteSize.Y * 0.75);
    p16.List.CanvasSize = UDim2.new(0, 0, 0, p16.Layout.AbsoluteContentSize.Y);
end;

function u1._UpdateOnboarding(p17) -- Line: 169
    -- upvalues: PlayerDataController (copy), Utility (copy), DuelLibrary (copy)
    local Statistic = PlayerDataController:GetStatistic("StatisticDuelsPlayed");
    p17.RotatingFrame.Visible = Statistic >= 3;
    p17.ArcadeServersFrame.Visible = Statistic >= 4;
    local AprilFoolsFrame = p17.AprilFoolsFrame;
    local v18;

    if Statistic >= 10 then
        v18 = Utility:IsAprilFoolsGamemodesEnabled() and DuelLibrary.APRIL_FOOLS_QUEUES and #DuelLibrary.APRIL_FOOLS_QUEUES > 0;
    else
        v18 = false;
    end;

    AprilFoolsFrame.Visible = v18;
    p17.CenterDuelsFrame.Visible = Statistic < 3;
    p17.DuelsContainerCloseButton.Visible = p17.CenterDuelsFrame.Visible;
    p17.CloseButton.Visible = not p17.CenterDuelsFrame.Visible;
end;

function u1._UpdateBeginnerQueue(p19) -- Line: 180
    -- upvalues: CONSTANTS (copy), PlayerDataController (copy)
    local v20 = p19._matchmaking_queue_slots[CONSTANTS.BEGINNER_QUEUE_NAME];

    if not v20 then
        p19.RankedFrame.Visible = true;

        return;
    end;

    local v21 = PlayerDataController:GetStatistic("StatisticDuelsWon") < CONSTANTS.BEGINNER_QUEUE_WINS;
    v20.Frame.Visible = v21;
    p19.RankedFrame.Visible = not v21;
    p19.QueuesFrame.Position = not v21 and UDim2.new(0.7, 0, 0.2, 0) or UDim2.new(1, 0, 0.2, 0);
end;

function u1._RespondToQueueStatus(p22, p23) -- Line: 195
    if p23 == "Success" then
        p22.Closed:Fire();

        return;
    end;

    p22.PromptSystem:Open("ErrorMessage", "Whoops!", p23 or "Server failed to respond, please try again");
end;

function u1._GenerateQueues(u24, p25, p26, p27, p28, p29, p30) -- Line: 203
    -- upvalues: MatchmakingQueueSlot (copy)
    if p27 then
        for _, v in pairs(p27) do
            v:Destroy();
        end;

        table.clear(p27);
    end;

    local v31 = p29 and 1 or 2;
    local v32 = p27 or {};

    for i = 1, math.ceil(#p26 / v31) do
        local Frame = Instance.new("Frame");
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.Size = UDim2.new(1, 0, 1, 0);
        Frame.BackgroundTransparency = 1;
        Frame.Parent = p25;
        table.insert(v32, Frame);
        local UIListLayout = Instance.new("UIListLayout");
        UIListLayout.Padding = UDim.new(0.005, 0);
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top;
        UIListLayout.Parent = Frame;
        local v33 = p26[v31 * (i - 1) + 1 + 1] and v31 and v31 or 1;
        local v34 = i;

        for i2 = 1, v33 do
            local v35 = p26[v31 * (v34 - 1) + i2];
            local v36;

            if p30 then
                if i2 == 1 then
                    v36 = 1 - p30;
                else
                    v36 = p30;
                end;
            else
                v36 = 1 / v33;
            end;

            local Frame2 = Instance.new("Frame");
            Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
            Frame2.Size = UDim2.new(v36 - UIListLayout.Padding.Scale * v36 * (v33 - 1), 0, (p29 or (v34 <= 1 or v33 ~= 1)) and 1 or 0.75, 0);
            Frame2.BackgroundTransparency = 1;
            Frame2.Parent = Frame;
            local v37 = MatchmakingQueueSlot.new(v35, Frame2);
            v37.QueueStatus:Connect(function(p38) -- Line: 244
                -- upvalues: u24 (copy)
                u24:_RespondToQueueStatus(p38);
            end);
            u24._matchmaking_queue_slots[v35] = v37;
            local v39;

            if p28 then
                p28(v35, Frame2, v37);
                v39 = i2;
            else
                v39 = i2;
            end;
        end;
    end;
end;

function u1._GenerateRotating(u40) -- Line: 257
    -- upvalues: RotatingQueueLibrary (copy)
    for _, v in pairs(u40._rotating_matchmaking_queue_slots) do
        v.Container:Destroy();
        v.MatchmakingQueueSlot:Destroy();
    end;

    u40:_GenerateQueues(u40.RotatingSlotsFrame, RotatingQueueLibrary:GetCurrent().QueueNames, u40._rotating_batch_containers, function(p41, p42, p43) -- Line: 263, Name: callback
        -- upvalues: u40 (copy)
        u40._rotating_matchmaking_queue_slots[p41] = {
            Container = p42,
            MatchmakingQueueSlot = p43
        };
    end);
end;

function u1._GenerateRotatingLoop(p44) -- Line: 270
    -- upvalues: RotatingQueueLibrary (copy), Utility (copy)
    local v45 = nil;

    while p44._is_open and p44._is_open_hash == p44._is_open_hash do
        local Cycle = RotatingQueueLibrary:GetCycle();

        if Cycle == v45 then
            Cycle = v45;
        else
            p44:_GenerateRotating();
        end;

        local RotatingHeaderTitle = p44.RotatingHeaderTitle;
        local TimeUntilNext = RotatingQueueLibrary:GetTimeUntilNext();
        RotatingHeaderTitle.Text = "New gamemodes in " .. Utility:TimeFormat2((math.ceil(TimeUntilNext)));
        p44.RotatingHeaderNewReleaseFrame.Visible = RotatingQueueLibrary:IsNewRelease();
        wait(1);
        v45 = Cycle;
    end;
end;

function u1._GenerateQueueSlot(u46, p47) -- Line: 289
    -- upvalues: Utility (copy), MatchmakingQueueSlot (copy), CONSTANTS (copy)
    local v48 = Utility:WaitForChildRecursive(u46.Container, p47, 2);

    if not v48 then
        return;
    end;

    local v49 = MatchmakingQueueSlot.new(p47, v48);
    v49.QueueStatus:Connect(function(p50) -- Line: 298
        -- upvalues: u46 (copy)
        u46:_RespondToQueueStatus(p50);
    end);
    u46._matchmaking_queue_slots[p47] = v49;

    if p47 == CONSTANTS.BEGINNER_QUEUE_NAME then
        u46:_UpdateBeginnerQueue();
    end;
end;

function u1._Setup(p51) -- Line: 309
    -- upvalues: SeasonLibrary (copy), EventLibrary (copy), CONSTANTS (copy), DuelLibrary (copy), RewardSlot (copy), BaseMatchmakingQueueSlot (copy), ArcadeController (copy)
    p51.RankedLockedText.Text = "Unlocked at\nLevel " .. SeasonLibrary.CurrentSeason.LevelRequirement;
    p51.RankedSeasonText.Text = "Season " .. SeasonLibrary.CurrentSeason.Version;
    p51.RankedThumbnail.Image = SeasonLibrary.CurrentSeason.ThumbnailRankedCoverPhoto;
    p51.EventHeaderIcon.Image = EventLibrary.EVENT_DETAILS and EventLibrary.EVENT_DETAILS.LTM_HEADER_ICON or p51.EventHeaderIcon.Image;
    p51.ArcadeServersHeaderInfoBubbleTitle.Text = string.format("You must be Level %s+ to earn XP from Arcade Servers\nThis includes Career XP, Weapon XP, & Task progress", CONSTANTS.LEVEL_REQUIRED_FOR_REWARDS_FROM_ARCADE_SERVERS);

    for _, v in pairs(DuelLibrary.MatchmakingQueueOrder) do
        task.defer(p51._GenerateQueueSlot, p51, v);
    end;

    if DuelLibrary.APRIL_FOOLS_QUEUES and #DuelLibrary.APRIL_FOOLS_QUEUES > 0 then
        p51:_GenerateQueues(p51.AprilFoolsSlotsFrame, DuelLibrary.APRIL_FOOLS_QUEUES);
    end;

    p51.EventFrame.Visible = EventLibrary.IS_ACTIVE and EventLibrary.LTM_QUEUENAMES and #EventLibrary.LTM_QUEUENAMES > 0;
    p51.EventRewardsFrame.Visible = EventLibrary.LTM_QUEUES_REWARDS_DISPLAYED and #EventLibrary.LTM_QUEUES_REWARDS_DISPLAYED > 0;

    if p51.EventFrame.Visible then
        p51:_GenerateQueues(p51.EventSlotsFrame, EventLibrary.LTM_QUEUENAMES, nil, nil, EventLibrary.LTM_QUEUES_SMART_TILING_DISABLED, EventLibrary.LTM_QUEUES_SMART_TILING_X_SIZE_MULTIPLIER);

        for _, v in pairs(EventLibrary.LTM_QUEUES_REWARDS_DISPLAYED) do
            local v52 = RewardSlot.new({
                Name = v
            });
            v52:EnableOwnedLogic(true);
            v52:SetParent(p51.EventRewardsFrame);
        end;
    end;

    for _, v in pairs(DuelLibrary.ArcadeModeOrder) do
        local v53 = DuelLibrary.ArcadeModes[v];
        local v54 = p51.ArcadeServersContainer:WaitForChild(v);
        v54:WaitForChild("Button"):WaitForChild("Title").Text = v53.DisplayName;
        v54:WaitForChild("Button"):WaitForChild("Description").Text = v53.Description;
        v54:WaitForChild("Button"):WaitForChild("Thumbnail").Image = v53.Thumbnail;
        BaseMatchmakingQueueSlot.new(v54).Clicked:Connect(function() -- Line: 352
            -- upvalues: ArcadeController (ref), v (copy)
            ArcadeController:ToArcadeServer(v);
        end);
    end;
end;

function u1._Init(u55) -- Line: 358
    -- upvalues: PlayerDataController (copy), SeasonLibrary (copy), Utility (copy), LeaderboardController (copy), ButtonEffect (copy)
    u55.CloseButton.MouseButton1Click:Connect(function() -- Line: 359
        -- upvalues: u55 (copy)
        u55:CloseRequest();
    end);
    u55.DuelsContainerCloseButton.MouseButton1Click:Connect(function() -- Line: 363
        -- upvalues: u55 (copy)
        u55:CloseRequest();
    end);
    u55.ArcadeServersHeaderInfoButton.MouseButton1Click:Connect(function() -- Line: 367
        -- upvalues: u55 (copy)
        u55.ArcadeServersHeaderInfoBubble.Visible = not u55.ArcadeServersHeaderInfoBubble.Visible;
    end);
    u55.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 371
        -- upvalues: u55 (copy)
        u55:_UpdateList();
    end);
    u55.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 375
        -- upvalues: u55 (copy)
        u55:_UpdateList();
    end);
    u55.RankedSlot.Clicked:Connect(function() -- Line: 379
        -- upvalues: PlayerDataController (ref), SeasonLibrary (ref), u55 (copy), Utility (ref)
        if PlayerDataController:Get("Level") >= SeasonLibrary.CurrentSeason.LevelRequirement then
            u55.OpenPage:Fire("Ranked");

            return;
        end;

        Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);
    end);
    u55.RotatingSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 387
        -- upvalues: u55 (copy)
        u55:_UpdateLayouts();
    end);
    u55.EventSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 391
        -- upvalues: u55 (copy)
        u55:_UpdateLayouts();
    end);
    u55.AprilFoolsSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 395
        -- upvalues: u55 (copy)
        u55:_UpdateLayouts();
    end);
    u55.ArcadeServersHeaderInfoBubbleTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 399
        -- upvalues: u55 (copy)
        u55:_UpdateLayouts();
    end);
    PlayerDataController:GetDataChangedSignal("StatisticDuelsPlayed"):Connect(function() -- Line: 403
        -- upvalues: u55 (copy)
        u55:_UpdateOnboarding();
    end);
    PlayerDataController:GetDataChangedSignal("StatisticDuelsWon"):Connect(function() -- Line: 407
        -- upvalues: u55 (copy)
        u55:_UpdateBeginnerQueue();
    end);
    PlayerDataController:GetDataChangedSignal("Level"):Connect(function() -- Line: 411
        -- upvalues: u55 (copy)
        u55:_UpdateLocked();
        u55:_UpdateArcadeServerHeaderInfo();
    end);
    PlayerDataController:GetDataChangedSignal("Seasons"):Connect(function() -- Line: 416
        -- upvalues: u55 (copy)
        u55:_UpdateELO();
    end);
    LeaderboardController:GetLeaderboardRefreshedSignal("Highest ELO"):Connect(function() -- Line: 420
        -- upvalues: u55 (copy)
        u55:_UpdateELO();
    end);
    u55:_Setup();
    u55:_UpdateList();
    u55:_UpdateOnboarding();
    u55:_UpdateELO();
    u55:_UpdateLocked();
    u55:_UpdateLayouts();
    u55:_UpdateArcadeServerHeaderInfo();
    ButtonEffect:Add(u55.CloseButton);
    ButtonEffect:Add(u55.DuelsContainerCloseButton);
    ButtonEffect:Add(u55.ArcadeServersHeaderInfoButton);
end;

return u1._new();