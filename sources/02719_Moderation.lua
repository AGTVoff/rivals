-- Instance: StarterPlayer.StarterPlayerScripts.Modules.Pages.Moderation
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserService = game:GetService("UserService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local PermissionsLibrary = require(ReplicatedStorage.Modules.PermissionsLibrary);
local ModerationLibrary = require(ReplicatedStorage.Modules.ModerationLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local BanLibrary = require(ReplicatedStorage.Modules.BanLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local DropdownSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("DropdownSlot"));
local RankIcon = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RankIcon"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local u1 = {
    { "permission_moderation_modpanel_access" },
    { "permission_moderation_modpanel_viewbanned_full", "permission_moderation_modpanel_viewactions_full", "permission_moderation_modpanel_viewdata_limited", "permission_moderation_modpanel_viewdata_most", "permission_moderation_modpanel_viewdata_full" },
    { "permission_moderation_modpanel_teleport_full" },
    { "permission_moderation_modpanel_warn_template", "permission_moderation_modpanel_warn_custom" },
    { "permission_moderation_modpanel_evict_limited", "permission_moderation_modpanel_evict_full" },
    { "permission_moderation_modpanel_moderate_limited", "permission_moderation_modpanel_moderate_most", "permission_moderation_modpanel_moderate_full", "permission_moderation_modpanel_unban" },
    { "permission_moderation_modpanel_restrict" },
    { "permission_moderation_modpanel_removelbs_limited", "permission_moderation_modpanel_investigate_full" },
    { "permission_moderation_modpanel_pardon_limited", "permission_moderation_modpanel_pardon_full" },
    { "permission_moderation_modpanel_lock" }
};
local u2 = setmetatable({}, Page);
u2.__index = u2;

function u2._new() -- Line: 66
    -- upvalues: Page (copy), u2 (copy), PromptSystem (copy)
    local v3 = Page.new(script.Name);
    local v4 = setmetatable(v3, u2);
    v4.PromptsFrame = v4.PageFrame:WaitForChild("Prompts");
    v4.PageContainer = v4.PageFrame:WaitForChild("Container");
    v4.CloseButton = v4.PageContainer:WaitForChild("Close");
    v4.List = v4.PageContainer:WaitForChild("List");
    v4.Container = v4.List:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4.HeaderFrame = v4.Container:WaitForChild("Header");
    v4.InfoButton = v4.HeaderFrame:WaitForChild("Info");
    v4.InfoButtonBubble = v4.InfoButton:WaitForChild("Bubble");
    v4.InfoButtonBubbleTitle = v4.InfoButtonBubble:WaitForChild("Title");
    v4.InfoButtonBubbleBackground = v4.InfoButtonBubble:WaitForChild("Background");
    v4.PowersButton = v4.HeaderFrame:WaitForChild("Powers");
    v4.PowersButtonBubble = v4.PowersButton:WaitForChild("Bubble");
    v4.PowersButtonBubbleTitle = v4.PowersButtonBubble:WaitForChild("Container"):WaitForChild("Title");
    v4.LookupFrame = v4.Container:WaitForChild("Lookup");
    v4.LookupBox = v4.LookupFrame:WaitForChild("Box");
    v4.LookupButton = v4.LookupFrame:WaitForChild("Button");
    v4.LookupDropdownButton = v4.LookupFrame:WaitForChild("Dropdown");
    v4.DropdownReferenceFrame = v4.LookupFrame:WaitForChild("DropdownReference");
    v4.InvestigateFrame = v4.Container:WaitForChild("Investigate");
    v4.InvestigateContainer = v4.InvestigateFrame:WaitForChild("Container");
    v4.InvestigateWinStreaksFrame = v4.InvestigateContainer:WaitForChild("Top100WinStreaks");
    v4.InvestigateWinStreaksButton = v4.InvestigateWinStreaksFrame:WaitForChild("Button");
    v4.InvestigateTrueWinStreaksFrame = v4.InvestigateContainer:WaitForChild("Top100TrueWinStreaks");
    v4.InvestigateTrueWinStreaksButton = v4.InvestigateTrueWinStreaksFrame:WaitForChild("Button");
    v4.PlayerFrame = v4.Container:WaitForChild("Player");
    v4.PlayerWaitingFrame = v4.PlayerFrame:WaitForChild("Waiting");
    v4.PlayerWaitingDotsFrame = v4.PlayerWaitingFrame:WaitForChild("Dots");
    v4.PlayerLoadedFrame = v4.PlayerFrame:WaitForChild("Loaded");
    v4.PlayerLoadedActionsFrame = v4.PlayerLoadedFrame:WaitForChild("Actions");
    v4.PlayerLoadedInformationFrame = v4.PlayerLoadedFrame:WaitForChild("Information");
    v4.PlayerLoadedInformationPicture = v4.PlayerLoadedInformationFrame:WaitForChild("Picture"):WaitForChild("Picture");
    v4.PromptSystem = PromptSystem.new(v4.PromptsFrame);
    v4._ban_data = nil;
    v4._result_data = nil;
    v4._player_data = nil;
    v4._player_metadata = nil;
    v4._is_this_dude_banned = false;
    v4._ban_data_hash = 0;
    v4._lookup_disabled = false;
    v4._player_data_debounce = false;
    v4._last_rank_icon = nil;
    v4._dropdown_slot = nil;
    v4._cached_players = {};
    v4:_Init();

    return v4;
end;

function u2.SetBanData(u5, p6, p7, p8) -- Line: 125
    -- upvalues: BanLibrary (copy), ServerOsTime (copy), SeasonLibrary (copy), CONSTANTS (copy), Utility (copy), RankIcon (copy), UserService (copy)
    local v9 = not p7 or typeof(p7) == "table";
    local v10 = "Argument 1 invalid, expected a table or nil, got " .. tostring(p7);
    assert(v9, v10);
    local v11 = not p8 or typeof(p8) == "table";
    local v12 = "Argument 2 invalid, expected a table or nil, got " .. tostring(p8);
    assert(v11, v12);

    if not p6 then
        local v13;

        if p7 then
            v13 = p7.UserID;
        else
            v13 = p7;
        end;

        if v13 ~= (u5._ban_data and u5._ban_data.UserID) then
            return;
        end;
    end;

    u5._ban_data = p7;
    u5._result_data = p8;
    local v14;

    if u5._result_data then
        v14 = u5._result_data.RawData or nil;
    else
        v14 = nil;
    end;

    u5._player_data = v14;
    local v15;

    if u5._result_data then
        v15 = u5._result_data.Metadata or nil;
    else
        v15 = nil;
    end;

    u5._player_metadata = v15;
    u5._is_this_dude_banned = nil;
    u5._ban_data_hash = u5._ban_data_hash + 1;
    u5.PlayerLoadedFrame.Visible = u5._ban_data ~= nil;

    if u5._last_rank_icon then
        u5._last_rank_icon:Destroy();
        u5._last_rank_icon = nil;
    end;

    if not u5._ban_data then
        return;
    end;

    local _ban_data_hash = u5._ban_data_hash;
    local v16 = BanLibrary:IsBanned(u5._ban_data);
    local v17;

    if v16 then
        local v18 = v16.EndTime - ServerOsTime:GetRounded();
        v17 = math.max(0, v18);
    else
        v17 = v16;
    end;

    local v19 = u5._player_data and u5._player_data.RedFlags and u5._player_data.RedFlags[#u5._player_data.RedFlags];
    local v20 = u5._player_data and u5._player_data.SessionID ~= nil;
    local v21 = u5._player_data and u5._player_data.Level;
    local v22 = u5._player_data and u5._player_data.StatisticDuelsWinStreak;
    local v23 = u5._player_data and u5._player_data.LastKnownControls;
    local v24 = u5._player_data and (u5._player_data.Seasons and u5._player_data.Seasons[SeasonLibrary.CurrentSeason.Name]) and u5._player_data.Seasons[SeasonLibrary.CurrentSeason.Name].RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];
    local v25;

    if v24 then
        v25 = v24.CurrentELO;
    else
        v25 = v24;
    end;

    local v26;

    if v24 then
        v26 = SeasonLibrary:GetHighestELOLeaderboardRanking(v25, u5._ban_data.UserID);
    else
        v26 = v24;
    end;

    local v27;

    if v24 then
        v27 = SeasonLibrary:GetRank(v25, u5._ban_data.UserID, v26);
    else
        v27 = v24;
    end;

    if v27 then
        v27 = SeasonLibrary.CurrentSeason.RankProfile.Ranks[v27];
    end;

    local v28 = u5._ban_data.BanLocked and "🔒" or "";
    local v29 = u5._ban_data.Restrictions and u5._ban_data.Restrictions.RestrictedFromCasualLeaderboards;
    local v30 = u5._ban_data.Restrictions and u5._ban_data.Restrictions.RestrictedFromCompetitiveLeaderboards;
    local v31 = 0;
    local v32 = 0;

    for _, v in pairs(u5._ban_data.BanHistory) do
        if BanLibrary:IsBanLogAWarning(v) then
            v31 = v31 + 1;
        end;

        if BanLibrary:IsBanLogABan(v) then
            v32 = v32 + 1;
        end;
    end;

    u5._is_this_dude_banned = v16 ~= nil;
    u5.PlayerLoadedInformationPicture.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, (tostring(u5._ban_data.UserID)));
    u5:_SetInformationFrameVisible("ELO", v24);
    u5:_SetInformationFrameText("ELO", (v25 and (Utility:PrettyNumber(v25) or "N/A") or "N/A") .. " " .. (v27 and v27.DisplayName or "N/A") .. " " .. (v26 and " #" .. v26 or ""));
    u5:_SetInformationFrameVisible("Level", v21);
    u5:_SetInformationFrameText("Level", v21 and Utility:PrettyNumber(v21) or "");
    local v33;

    if v22 then
        v33 = v22 > 0;
    else
        v33 = v22;
    end;

    u5:_SetInformationFrameVisible("WinStreak", v33);
    u5:_SetInformationFrameText("WinStreak", v22 and (v22 > 0 and Utility:PrettyNumber(v22)) or "");
    u5:_SetInformationFrameVisible("Controls", v23);
    u5:_SetInformationFrameText("Controls", v23 or "");
    u5:_SetInformationFrameText("Username", "@" .. u5._ban_data.Name);
    u5:_SetInformationFrameText("DisplayName", "• • •");
    u5:_SetInformationFrameText("UserID", "#" .. tostring(u5._ban_data.UserID));
    u5:_SetInformationFrameText("Online", v20 and "🟢 Online" or "🔴 Offline");
    u5:_SetInformationFrameText("Lock", u5._ban_data.BanLocked and "Locked" or "Not locked", u5._ban_data.BanLocked and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50));
    u5:_SetInformationFrameText("Status", v28 .. (v16 and ("Banned [" .. (v16.Duration and v16.Duration >= BanLibrary.PERMANENT_BAN_DURATION and "Permanent" or Utility:TimeFormat2(v17)) .. "]" or "Not banned") or "Not banned"), v16 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50));
    u5:_SetInformationFrameText("History", v28 .. (v16 and "🚨 " .. v16.Reason or (v32 > 0 and ("Banned " .. v32 .. " time" .. (v32 == 1 and "" or "s") or "No ban history") or "No ban history")), v16 and Color3.fromRGB(255, 50, 50) or (v32 > 0 and Color3.fromRGB(255, 150, 0) or Color3.fromRGB(100, 255, 50)));
    u5:_SetInformationFrameText("Flags", v28 .. (v19 and (tostring(v19.Reason) or "Not flagged") or "Not flagged"), v19 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50));
    u5:_SetInformationFrameText("CasualLBs", v28 .. (v29 and "Restricted" or "Not restricted"), v29 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50));
    u5:_SetInformationFrameText("CompLBs", v28 .. (v30 and "Restricted" or "Not restricted"), v30 and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 50));
    u5:_SetInformationFrameText("Warnings", v28 .. (v31 > 0 and (v31 .. " warning" .. (v31 == 1 and "" or "s") or "No warnings") or "No warnings"), v31 > 0 and Color3.fromRGB(255, 150, 0) or Color3.fromRGB(100, 255, 50));

    if v24 then
        u5._last_rank_icon = RankIcon.new(v25, u5._ban_data.UserID);
        u5._last_rank_icon:SetParent(u5.PlayerRank);
    end;

    task.spawn(function() -- Line: 209
        -- upvalues: UserService (ref), u5 (copy), _ban_data_hash (copy)
        local UserInfosByUserIdsAsync = UserService:GetUserInfosByUserIdsAsync({ u5._ban_data.UserID });

        if _ban_data_hash ~= u5._ban_data_hash then
            return;
        end;

        if not (UserInfosByUserIdsAsync[1] and UserInfosByUserIdsAsync[1].DisplayName) then
            return;
        end;

        u5:_SetInformationFrameText("DisplayName", UserInfosByUserIdsAsync[1].DisplayName);
    end);
    u5:_UpdatePermissions();
end;

function u2.Open(u34, ...) -- Line: 226
    -- upvalues: Page (copy), ReplicatedStorage (copy)
    Page.Open(u34, ...);
    task.spawn(function() -- Line: 229
        -- upvalues: u34 (copy), ReplicatedStorage (ref)
        u34._cached_players = ReplicatedStorage.Remotes.Moderator.RequestCachedPlayers:InvokeServer() or u34._cached_players;
    end);
end;

function u2._SetActionButtonVisible(p35, p36, p37) -- Line: 238
    p35.PlayerLoadedActionsFrame:WaitForChild(p36).Visible = p37;
end;

function u2._SetInformationFrameText(p38, p39, p40, p41) -- Line: 242
    p38.PlayerLoadedInformationFrame:WaitForChild(p39):WaitForChild("Value").Text = p40;
    p38.PlayerLoadedInformationFrame:WaitForChild(p39):WaitForChild("Value").TextColor3 = p41 or Color3.fromRGB(255, 255, 255);
end;

function u2._SetInformationFrameVisible(p42, p43, p44) -- Line: 247
    p42.PlayerLoadedInformationFrame:WaitForChild(p43).Visible = p44;
end;

function u2._UpdatePowersButtonBubble(p45) -- Line: 251
    -- upvalues: PlayerDataController (copy), u1 (copy), PermissionsLibrary (copy)
    local v46 = PlayerDataController:Get("PermissionsRoles");
    local v47 = "";

    for i, v in pairs(u1) do
        if i > 1 then
            v47 = v47 .. "\n\n";
        end;

        for i2, v2 in pairs(v) do
            if i2 > 1 then
                v47 = v47 .. "\n";
            end;

            v47 = v47 .. string.format("%s %s", PermissionsLibrary:HasPermission(v2, v46) and "✅" or "🟥", PermissionsLibrary.Permissions[v2].Description);
        end;
    end;

    p45.PowersButtonBubbleTitle.Text = v47;
end;

function u2._UpdatePermissions(p48) -- Line: 272
    -- upvalues: PlayerDataController (copy), ModerationLibrary (copy)
    local v49 = PlayerDataController:Get("PermissionsRoles");
    local v50 = p48._ban_data and p48._ban_data.BanLocked;

    for _, v in pairs({ "Status", "CasualLBs", "CompLBs", "Flags", "History" }) do
        p48:_SetInformationFrameVisible(v, ModerationLibrary:CanViewBanStatusAndLogs(v49));
    end;

    p48.InvestigateFrame.Visible = ModerationLibrary:CanUseInvestigativeCommands(v49);
    p48:_SetActionButtonVisible("ViewLogs", ModerationLibrary:CanViewBanStatusAndLogs(v49));
    p48:_SetActionButtonVisible("ViewData", ModerationLibrary:CanViewData(v49));
    p48:_SetActionButtonVisible("ViewActions", ModerationLibrary:CanViewActionHistory(v49));
    p48:_SetActionButtonVisible("Lock", ModerationLibrary:CanManageBanLocks(v49));
    local v51 = not v50 and ModerationLibrary:CanEvict(v49);
    p48:_SetActionButtonVisible("Kick", v51);
    local v52 = not v50;

    if v52 then
        if p48._is_this_dude_banned then
            v52 = ModerationLibrary:CanUnban(v49);
        else
            v52 = ModerationLibrary:CanBan(v49);
        end;
    end;

    p48:_SetActionButtonVisible("Moderate", v52);
    local v53 = not v50 and ModerationLibrary:CanRemoveFromLeaderboards(v49);
    p48:_SetActionButtonVisible("Wipe", v53);
    local v54 = not v50 and ModerationLibrary:CanPardon(v49) and (p48._player_data and p48._player_data.RedFlags) and p48._player_data.RedFlags[#p48._player_data.RedFlags];
    p48:_SetActionButtonVisible("Pardon", v54);
    local v55 = not v50 and ModerationLibrary:CanRestrict(v49);
    p48:_SetActionButtonVisible("Restrict", v55);
    local v56 = not v50 and ModerationLibrary:CanWarnCustom(v49);
    p48:_SetActionButtonVisible("Warn", v56);
    p48:_UpdatePowersButtonBubble();
end;

function u2._UpdateLayouts(p57) -- Line: 295
    p57.InfoButtonBubbleBackground.Size = UDim2.new(0.0375, p57.InfoButtonBubbleTitle.TextBounds.X, 1, 0);
    p57.CloseButton.Position = UDim2.new(0.9, 0, 0.0225, p57.PageFrame.AbsoluteSize.Y * 0.125);
    p57.List.Position = UDim2.new(0.5, 9, 0, p57.PageFrame.AbsoluteSize.Y * 0.125);
    p57.List.Size = UDim2.new(0.7, 0, 0, p57.PageFrame.AbsoluteSize.Y * 0.75);
    p57.List.CanvasSize = UDim2.new(0, 0, 0, p57.Layout.AbsoluteContentSize.Y);
end;

function u2._PlayersLookupDropdown(u58) -- Line: 303
    -- upvalues: Utility (copy), Players (copy), DropdownSlot (copy)
    if u58._dropdown_slot then
        u58._dropdown_slot:Cancel();
        u58._dropdown_slot = nil;
    end;

    local v59 = Utility:CloneTable(u58._cached_players);

    for _, v in pairs(Players:GetPlayers()) do
        local v60 = string.upper(v.DisplayName) .. " (@" .. string.upper(v.Name) .. ")";

        if not table.find(v59, v60) then
            table.insert(v59, v60);
        end;
    end;

    table.sort(v59, function(p61, p62) -- Line: 319
        -- upvalues: Utility (ref)
        return Utility:StringLessThan(p61, p62);
    end);
    u58._dropdown_slot = DropdownSlot.new(u58.DropdownReferenceFrame, v59);
    u58._dropdown_slot.Selected:Connect(function(p63) -- Line: 325
        -- upvalues: u58 (copy)
        u58._dropdown_slot = nil;

        if not p63 then
            return;
        end;

        local LookupBox = u58.LookupBox;
        local v64 = string.find(p63, "@") + 1;
        LookupBox.Text = string.sub(p63, v64, #p63 - 1);
        task.defer(u58._FetchBanData, u58);
    end);
end;

function u2._FetchPlayerData(u65) -- Line: 337
    -- upvalues: ReplicatedStorage (copy)
    if u65._player_data_debounce then
        return;
    end;

    u65._player_data_debounce = true;
    local success, result = pcall(function() -- Line: 344
        -- upvalues: ReplicatedStorage (ref), u65 (copy)
        return ReplicatedStorage.Remotes.Moderator.RequestPlayerData:InvokeServer(u65._ban_data.Name);
    end);
    u65._player_data_debounce = false;

    if not success then
        u65.PromptSystem:Open("ErrorMessage", "Whoops!", "Something went wrong while fetching their data, error:", (tostring(result)));

        return;
    end;

    if result then
        u65.PromptSystem:Open("ViewPlayerData", u65._ban_data.Name, result);

        return;
    end;

    u65.PromptSystem:Open("ErrorMessage", "Whoops!", "This player has never played RIVALS before!");
end;

function u2._RawFetchBanData(p66, p67) -- Line: 359
    -- upvalues: ReplicatedStorage (copy)
    if p66._lookup_disabled then
        return;
    end;

    p66:SetBanData(true, nil, nil);

    if not p67 or #p67 == 0 then
        return;
    end;

    p66._lookup_disabled = true;
    p66.PlayerWaitingFrame.Visible = true;
    p66.PlayerWaitingDotsFrame:AddTag("UILoadingDots");
    local v68 = ReplicatedStorage.Remotes.Moderator.RequestPlayer:InvokeServer(p67) or {};
    p66:SetBanData(true, table.unpack(v68));
    p66._lookup_disabled = false;
    p66.PlayerWaitingFrame.Visible = false;
    p66.PlayerWaitingDotsFrame:RemoveTag("UILoadingDots");
end;

function u2._FetchBanData(p69) -- Line: 381
    p69:_RawFetchBanData(p69.LookupBox.Text);
end;

function u2._SetupActionButton(p70, p71, p72) -- Line: 385
    -- upvalues: ButtonEffect (copy)
    local Button = p70.PlayerLoadedActionsFrame:WaitForChild(p71):WaitForChild("Button");
    local Title = Button:WaitForChild("Title");
    local Description = Button:WaitForChild("Description");
    local Icon = Button:WaitForChild("Icon");
    local Background = Button:WaitForChild("Background");
    local UIGradient = Background:WaitForChild("UIGradient");
    local ImageColor3 = Background.ImageColor3;
    Button.MouseEnter:Connect(function() -- Line: 396, Name: enter
        -- upvalues: Background (copy), Title (copy), Description (copy), Icon (copy), UIGradient (copy)
        Background.ImageColor3 = Color3.fromRGB(255, 255, 255);
        Background.ImageTransparency = 0;
        Background.Size = UDim2.new(0.725, 0, 1, 0);
        Title.TextColor3 = Color3.fromRGB(0, 0, 0);
        Description.TextColor3 = Color3.fromRGB(0, 0, 0);
        Icon.ImageColor3 = Color3.fromRGB(0, 0, 0);
        UIGradient.Enabled = false;
    end);

    local function leave() -- Line: 408
        -- upvalues: Background (copy), ImageColor3 (copy), Title (copy), Description (copy), Icon (copy), UIGradient (copy)
        Background.ImageColor3 = ImageColor3;
        Background.ImageTransparency = 0.5;
        Background.Size = UDim2.new(1, 0, 1, 0);
        Title.TextColor3 = Color3.fromRGB(255, 255, 255);
        Description.TextColor3 = Color3.fromRGB(255, 255, 255);
        Icon.ImageColor3 = Color3.fromRGB(255, 255, 255);
        UIGradient.Enabled = true;
    end;

    Button.MouseLeave:Connect(leave);
    leave();
    Button.MouseButton1Click:Connect(p72);
    ButtonEffect:Add(Button, true);
end;

function u2._Init(u73) -- Line: 425
    -- upvalues: ReplicatedStorage (copy), PlayerDataController (copy), ButtonEffect (copy)
    u73.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 426
        -- upvalues: u73 (copy)
        u73:_UpdateLayouts();
    end);
    u73.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 430
        -- upvalues: u73 (copy)
        u73:_UpdateLayouts();
    end);
    u73.InfoButtonBubbleTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 434
        -- upvalues: u73 (copy)
        u73:_UpdateLayouts();
    end);
    u73.CloseButton.MouseButton1Click:Connect(function() -- Line: 438
        -- upvalues: u73 (copy)
        u73:CloseRequest();
    end);
    u73.InvestigateWinStreaksButton.MouseButton1Click:Connect(function() -- Line: 442
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.Moderator.CheckTop100Streaks:FireServer();
    end);
    u73.InvestigateTrueWinStreaksButton.MouseButton1Click:Connect(function() -- Line: 446
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.Moderator.CheckTop100TrueStreaks:FireServer();
    end);
    u73.LookupButton.MouseButton1Click:Connect(function() -- Line: 450
        -- upvalues: u73 (copy)
        u73:_FetchBanData();
    end);
    u73.LookupDropdownButton.MouseButton1Click:Connect(function() -- Line: 454
        -- upvalues: u73 (copy)
        u73:_PlayersLookupDropdown();
    end);
    u73.InfoButton.MouseButton1Click:Connect(function() -- Line: 458
        -- upvalues: u73 (copy)
        u73.InfoButtonBubble.Visible = not u73.InfoButtonBubble.Visible;
    end);
    u73.PowersButton.MouseButton1Click:Connect(function() -- Line: 462
        -- upvalues: u73 (copy)
        u73.PowersButtonBubble.Visible = not u73.PowersButtonBubble.Visible;
    end);
    u73:_SetupActionButton("Moderate", function() -- Line: 466
        -- upvalues: u73 (copy)
        if u73._is_this_dude_banned then
            u73.PromptSystem:Open("Unban", u73._ban_data);

            return;
        end;

        u73.PromptSystem:Open("Ban", u73._ban_data);
    end);
    u73:_SetupActionButton("ViewLogs", function() -- Line: 474
        -- upvalues: u73 (copy)
        u73.PromptSystem:Open("InspectBanLogs", u73._ban_data);
    end);
    u73:_SetupActionButton("Join", function() -- Line: 478
        -- upvalues: ReplicatedStorage (ref), u73 (copy)
        ReplicatedStorage.Remotes.Moderator.Join:FireServer(u73._ban_data.Name);
    end);
    u73:_SetupActionButton("Kick", function() -- Line: 482
        -- upvalues: u73 (copy)
        u73.PromptSystem:Open("Kick", u73._ban_data);
    end);
    u73:_SetupActionButton("ViewData", function() -- Line: 486
        -- upvalues: u73 (copy)
        if u73._result_data then
            u73.PromptSystem:Open("ViewPlayerData", u73._ban_data.Name, u73._result_data);

            return;
        end;

        u73:_FetchPlayerData();
    end);
    u73:_SetupActionButton("Pardon", function() -- Line: 494
        -- upvalues: u73 (copy)
        u73.PromptSystem:Open("Pardon", u73._ban_data);
    end);
    u73:_SetupActionButton("Lock", function() -- Line: 498
        -- upvalues: ReplicatedStorage (ref), u73 (copy)
        ReplicatedStorage.Remotes.Moderator.LockBans:FireServer(u73._ban_data.Name);
    end);
    u73:_SetupActionButton("ViewActions", function() -- Line: 502
        -- upvalues: u73 (copy)
        u73.PromptSystem:Open("InspectActionLogs", u73._ban_data);
    end);
    u73:_SetupActionButton("Wipe", function() -- Line: 506
        -- upvalues: ReplicatedStorage (ref), u73 (copy)
        ReplicatedStorage.Remotes.Moderator.RemoveFromLeaderboards:FireServer(u73._ban_data.Name);
    end);
    u73:_SetupActionButton("Restrict", function() -- Line: 510
        -- upvalues: u73 (copy)
        u73.PromptSystem:Open("Restrict", u73._ban_data);
    end);
    u73:_SetupActionButton("Warn", function() -- Line: 514
        -- upvalues: u73 (copy)
        u73.PromptSystem:Open("Warn", u73._ban_data);
    end);
    PlayerDataController:GetDataChangedSignal("PermissionsRoles"):Connect(function() -- Line: 518
        -- upvalues: u73 (copy)
        u73:_UpdatePermissions();
    end);
    ReplicatedStorage.Remotes.Moderator.UpdateBanData.OnClientEvent:Connect(function(p74) -- Line: 522
        -- upvalues: u73 (copy)
        u73:SetBanData(false, p74, u73._result_data);
    end);
    u73:_UpdateLayouts();
    u73:_UpdatePermissions();
    u73:SetBanData(true, nil, nil);
    ButtonEffect:Add(u73.CloseButton);
    ButtonEffect:Add(u73.InvestigateWinStreaksButton);
    ButtonEffect:Add(u73.InvestigateTrueWinStreaksButton);
    ButtonEffect:Add(u73.LookupButton);
    ButtonEffect:Add(u73.LookupDropdownButton);
    ButtonEffect:Add(u73.InfoButton);
    ButtonEffect:Add(u73.PowersButton);
end;

return u2._new();