-- Instance: StarterPlayer.StarterPlayerScripts.Modules.Pages.PatchNotes
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
require(ReplicatedStorage.Modules.CosmeticLibrary);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local PatchNoteBalancingOverviewSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteBalancingOverviewSlot");
local PatchNoteContentSummarySlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteContentSummarySlot");
local PatchNoteBalanceChangeSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteBalanceChangeSlot");
local PatchNoteViewMoreButton = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteViewMoreButton");
local PatchNoteThumbnailSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteThumbnailSlot");
local ViewPatchNotesSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ViewPatchNotesSlot");
local PatchNoteChangeSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteChangeSlot");
local PatchNotesSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNotesSlot");
local PatchNotes = Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PatchNotes");
local u1 = { "Release", "FreezeRay", "Matchmaking", "Cosmetics", "NewMaps", "Gamemodes", "2024SpookyEvent", "Weapons", "2024FestiveEvent", "BridgeMap", "Ranked", "TheHunt", "Cosmetics2", "Gamemodes2", "Emotes", "Season1", "2025SpookyEvent", "2025FestiveEvent", "LaborOfLove", "Lucky", "Season3", "2026SummerEvent", "WildcatRelease", "RIA26", "2026SpookyEvent" };
local u2 = {
    { Color3.fromRGB(100, 255, 50), "rbxassetid://72868042131575" },
    { Color3.fromRGB(255, 50, 50), "rbxassetid://129990470163489" },
    { Color3.fromRGB(166, 166, 166), "rbxassetid://125168324521437" }
};
local u3 = {
    Title = {
        Weight = 600,
        Transparency = 0,
        Size = 1.5,
        Spaces = 3,
        Prefix = "",
        NewLine = 2
    },
    Header = {
        Weight = 500,
        Transparency = 0.125,
        Size = 0.875,
        Spaces = 9,
        Prefix = "",
        NewLine = 0.5
    },
    Description = {
        Weight = 400,
        Transparency = 0.25,
        Size = 0.75,
        Spaces = 12,
        Prefix = "• ",
        NewLine = nil
    },
    Description2 = {
        Weight = 400,
        Transparency = 0.5,
        Size = 0.75,
        Spaces = 18,
        Prefix = "▪  ",
        NewLine = nil
    }
};
local u4 = setmetatable({}, Page);
u4.__index = u4;

function u4._new() -- Line: 50
    -- upvalues: Page (copy), u4 (copy)
    local v5 = Page.new(script.Name);
    local v6 = setmetatable(v5, u4);
    v6.PageContainer = v6.PageFrame:WaitForChild("Container");
    v6.CloseButton = v6.PageContainer:WaitForChild("Close");
    v6.List = v6.PageContainer:WaitForChild("List");
    v6.Container = v6.List:WaitForChild("Container");
    v6.Layout = v6.Container:WaitForChild("Layout");
    v6.ViewMoreButton = v6.PageContainer:WaitForChild("ViewMore");
    v6.ViewMoreList = v6.PageContainer:WaitForChild("ViewMoreList");
    v6.ViewMoreContainer = v6.ViewMoreList:WaitForChild("Container");
    v6.ViewMoreLayout = v6.ViewMoreContainer:WaitForChild("Layout");
    v6._current_patch_notes_slot = nil;
    v6._elements = {};
    v6:_Init();

    return v6;
end;

function u4.SetViewMoreListVisible(p7, p8) -- Line: 75
    p7.ViewMoreList.Visible = p8;
    p7.ViewMoreList.CanvasPosition = Vector2.zero;
    p7.List.Visible = not p8;
    p7.List.CanvasPosition = Vector2.zero;
    p7.ViewMoreButton.Visible = not p8;
end;

function u4.ScrollTo(p9, p10, p11) -- Line: 83
    -- upvalues: TweenService (copy), BetterDebris (copy), Utility (copy)
    if not p10 then
        return;
    end;

    TweenService:Create(p9.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        CanvasPosition = Vector2.new(0, p10.AbsolutePosition.Y - p9.Container.AbsolutePosition.Y)
    }):Play();
    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = p11 or Color3.fromRGB(255, 255, 255);
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0);
    Frame.Size = UDim2.new(1, 0, 20, 0);
    Frame.Parent = p10;
    Frame:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quint", 0.5, true);
    BetterDebris:AddItem(Frame, 3);
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.125, 0),
        NumberSequenceKeypoint.new(0.875, 0),
        NumberSequenceKeypoint.new(1, 1)
    });
    UIGradient.Parent = Frame;
    task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 1, function(p12) -- Line: 103
        -- upvalues: Frame (copy)
        Frame.BackgroundTransparency = 0 + 1 * (p12 / 100) ^ 4;
    end);
end;

function u4.Open(u13, ...) -- Line: 110
    -- upvalues: Page (copy), u1 (copy), RunService (copy)
    Page.Open(u13, ...);
    u13:_UpdateSize();
    u13:SetViewMoreListVisible(false);
    task.defer(u13._Generate, u13, u1[#u1]);
    local _is_open_hash = u13._is_open_hash;
    task.delay(0.5, function() -- Line: 118
        -- upvalues: u13 (copy), _is_open_hash (copy), RunService (ref)
        for _, v in pairs(u13._elements) do
            if _is_open_hash ~= u13._is_open_hash then
                return;
            end;

            pcall(function() -- Line: 124
                -- upvalues: v (copy)
                v[1].Parent = v[2];
            end);
            RunService.RenderStepped:Wait();
        end;
    end);
end;

function u4.Close(p14, ...) -- Line: 133
    -- upvalues: Page (copy)
    for _, v in pairs(p14._elements) do
        v[1].Parent = nil;
    end;

    Page.Close(p14, ...);
end;

function u4._Generate(u15, p16) -- Line: 145
    -- upvalues: PatchNotes (copy), PatchNotesSlot (copy), ReplicatedStorage (copy), ButtonEffect (copy), u1 (copy), PlayerDataController (copy), Signal (copy), PatchNoteViewMoreButton (copy), RunService (copy), PatchNoteBalancingOverviewSlot (copy), u2 (copy), ItemLibrary (copy), PatchNoteBalanceChangeSlot (copy), PatchNoteContentSummarySlot (copy), RewardSlot (copy), PatchNoteThumbnailSlot (copy), u3 (copy), PatchNoteChangeSlot (copy), WeaponStatusHandler (copy)
    if u15._current_patch_notes_slot then
        u15._current_patch_notes_slot:Destroy();
        u15._current_patch_notes_slot = nil;
    end;

    u15._elements = {};
    local u17 = require(PatchNotes:WaitForChild(p16));
    local u18 = PatchNotesSlot:Clone();
    u18.LayoutOrder = 1;
    u18.Container.Thumbnail.Image = u17.Image or "";
    u18.Container.Thumbnail.Visible = u18.Container.Thumbnail.Image ~= "";
    u18.Container.Details.Title.Text = u17.Title;
    u18.Container.Details.Changes.Date.Text = u17.Date;
    u18.Parent = u15.Container;
    u15._current_patch_notes_slot = u18;
    u18.Container.Details.Changes.CodeButton.Button.MouseButton1Click:Connect(function() -- Line: 164
        -- upvalues: u18 (copy), ReplicatedStorage (ref), u17 (copy)
        u18.Container.Details.Changes.CodeButton.Visible = false;
        ReplicatedStorage.Remotes.Data.RedeemCode:InvokeServer(string.lower(u17.Code));
    end);
    u18.Container.Details.Changes.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 169
        -- upvalues: u18 (copy)
        u18.Size = UDim2.new(1, 0, 0, u18.Container.Details.Changes.AbsolutePosition.Y - u18.AbsolutePosition.Y + u18.Container.Details.Changes.Layout.AbsoluteContentSize.Y);
    end);
    ButtonEffect:Add(u18.Container.Details.Changes.CodeButton.Button);

    if u17.Code and p16 == u1[#u1] then
        local CodeButton = u18.Container.Details.Changes.CodeButton;
        task.delay(20, function() -- Line: 178
            -- upvalues: CodeButton (copy), PlayerDataController (ref), u17 (copy)
            CodeButton.Visible = not PlayerDataController:Get("RedeemedCodes")[string.lower(u17.Code)];
        end);
    end;

    local u19 = Signal.new();
    local u20 = true;
    local u21 = nil;
    local u22 = 0;
    local u23 = {};
    local u24 = false;
    local u25 = {};
    local u26 = 0;

    local function new_layout_order() -- Line: 192
        -- upvalues: u26 (ref)
        u26 = u26 + 1;

        return u26;
    end;

    local function register_element(p27) -- Line: 197
        -- upvalues: u15 (copy), u18 (copy)
        p27.Parent = u15._is_open and u18.Container.Details.Changes or nil;
        table.insert(u15._elements, { p27, u18.Container.Details.Changes });
    end;

    local function add_to_collapsed_list(p28, p29, p30) -- Line: 202
        -- upvalues: u23 (ref), u22 (ref), PatchNoteViewMoreButton (ref), u20 (ref), u19 (copy), ButtonEffect (ref), RunService (ref)
        if u23 then
            p28.Visible = false;
            table.insert(u23, p28);

            if p29 then
                p29.Visible = false;
                table.insert(u23, p29);
            end;
        else
            if u22 == 10 then
                local UIGradient = Instance.new("UIGradient");
                UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 1) });
                UIGradient.Rotation = 90;
                UIGradient.Parent = p28;
                local u31 = {};
                u23 = u31;
                local u32 = PatchNoteViewMoreButton:Clone();
                u32.Parent = p28;

                local function expand() -- Line: 223
                    -- upvalues: u20 (ref), u31 (copy), UIGradient (copy), u32 (copy)
                    if u20 then
                        return;
                    end;

                    for _, v in pairs(u31) do
                        v.Visible = true;
                    end;

                    UIGradient:Destroy();
                    u32:Destroy();
                end;

                u32.MouseButton1Click:Connect(expand);
                u19:Connect(expand);
                ButtonEffect:Add(u32);
                RunService.RenderStepped:Wait();

                return;
            end;

            u22 = u22 + (p30 or 1);
        end;
    end;

    local function generate_balancing_overview(p33) -- Line: 247
        -- upvalues: u24 (ref), PatchNoteBalancingOverviewSlot (ref), u26 (ref), u2 (ref), ItemLibrary (ref), PatchNoteBalanceChangeSlot (ref), u19 (copy), u15 (copy), u25 (copy), ButtonEffect (ref), u18 (copy)
        u24 = true;
        local u34 = PatchNoteBalancingOverviewSlot:Clone();
        u26 = u26 + 1;
        u34.LayoutOrder = u26;

        for i = 1, 3 do
            local u35 = u2[i];
            local _ = i;

            for _, v in pairs(p33[i + 1] or {}) do
                assert(ItemLibrary.ViewModels[v], v);
                local v36 = PatchNoteBalanceChangeSlot:Clone();
                v36.Button.Label.Icon.Image = u35[2];
                v36.Button.Label.Icon.ImageColor3 = u35[1];
                v36.Button.Background.BackgroundColor3 = u35[1];
                v36.Button.Background.UIStroke.Color = u35[1];
                v36.Button.Graphic.Picture.Image = ItemLibrary.ViewModels[v].ImageCentered or ItemLibrary.Items[v].Image;
                v36.Parent = u34.Slots;
                v36.Button.MouseButton1Click:Connect(function() -- Line: 268
                    -- upvalues: u19 (ref), u15 (ref), u25 (ref), v (copy), u35 (copy)
                    u19:Fire();
                    task.defer(u15.ScrollTo, u15, u25[v], u35[1]);
                end);
                ButtonEffect:Add(v36.Button);
            end;
        end;

        u34.Parent = u15._is_open and u18.Container.Details.Changes or nil;
        table.insert(u15._elements, { u34, u18.Container.Details.Changes });
        local Layout = u34.Slots.Layout;
        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 281, Name: update
            -- upvalues: u34 (copy), Layout (copy)
            u34.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
        end);
        u34.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
    end;

    local function generate_content_summary(p37) -- Line: 289
        -- upvalues: PatchNoteContentSummarySlot (ref), u26 (ref), RewardSlot (ref), u24 (ref), ItemLibrary (ref), u25 (copy), add_to_collapsed_list (copy), u15 (copy), u18 (copy)
        local v38 = p37[3];

        for i = 1, math.ceil(#v38 / 7) do
            local u39 = PatchNoteContentSummarySlot:Clone();
            u26 = u26 + 1;
            u39.LayoutOrder = u26;
            u39.Slots.Layout.HorizontalAlignment = Enum.HorizontalAlignment[p37[2] or "Center"];
            local _ = i;

            for i2 = (i - 1) * 7 + 1, i * 7 do
                local v40 = v38[i2];
                local v41;

                if v40 then
                    local v42 = typeof(v40) ~= "table" and {
                        Name = v40
                    } or v40;
                    local v43 = RewardSlot.new(v42);
                    v43.Frame.LayoutOrder = i2;
                    v43:SetParent(u39.Slots);

                    if u24 and ItemLibrary.Items[v42.Name] then
                        u25[v42.Name] = u39;
                        v41 = i2;
                    else
                        v41 = i2;
                    end;
                else
                    v41 = i2;
                end;
            end;

            add_to_collapsed_list(u39, nil, 3);
            u39.Parent = u15._is_open and u18.Container.Details.Changes or nil;
            table.insert(u15._elements, { u39, u18.Container.Details.Changes });
            local Layout = u39.Slots.Layout;
            Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 320, Name: update
                -- upvalues: u39 (copy), Layout (copy)
                u39.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
            end);
            u39.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
        end;
    end;

    local function generate_thumbnail(p44) -- Line: 329
        -- upvalues: PatchNoteThumbnailSlot (ref), u26 (ref), add_to_collapsed_list (copy), u15 (copy), u18 (copy)
        local v45 = p44[2];
        local v46 = p44[3];
        local v47 = PatchNoteThumbnailSlot:Clone();
        u26 = u26 + 1;
        v47.LayoutOrder = u26;
        v47.Thumbnail.Image = v45;
        v47.Title.Text = v46;
        v47.Title.AutoLocalize = false;
        add_to_collapsed_list(v47);
        v47.Parent = u15._is_open and u18.Container.Details.Changes or nil;
        table.insert(u15._elements, { v47, u18.Container.Details.Changes });
    end;

    local function generate_text(p48) -- Line: 343
        -- upvalues: u3 (ref), u21 (ref), u22 (ref), u23 (ref), PatchNoteChangeSlot (ref), u26 (ref), u15 (copy), u18 (copy), u24 (ref), ItemLibrary (ref), WeaponStatusHandler (ref), u25 (copy), add_to_collapsed_list (copy)
        local v49 = p48[1];
        local v50 = p48[2];
        local v51 = u3[v49];
        assert(v51 ~= nil, v49, p48);

        if v49 == "Title" then
            u21 = p48;
            u22 = 0;
            u23 = nil;
        end;

        local v52;

        if v51.NewLine then
            v52 = PatchNoteChangeSlot:Clone();
            u26 = u26 + 1;
            v52.LayoutOrder = u26;
            v52.Text = "";
            v52.Size = UDim2.new(v52.Size.X.Scale, 0, v52.Size.Y.Scale * v51.NewLine, 0);
            v52.AutoLocalize = false;
            v52.Parent = u15._is_open and u18.Container.Details.Changes or nil;
            table.insert(u15._elements, { v52, u18.Container.Details.Changes });
        else
            v52 = nil;
        end;

        local v53 = PatchNoteChangeSlot:Clone();
        u26 = u26 + 1;
        v53.LayoutOrder = u26;
        v53.Text = string.format("%s%s<font weight=\"%s\">%s</font>", string.rep(" ", v51.Spaces), v51.Prefix, v51.Weight, v50);
        v53.TextTransparency = v51.Transparency;
        v53.Size = UDim2.new(v53.Size.X.Scale, 0, v53.Size.Y.Scale * math.ceil(#v50 / 80) * v51.Size, 0);
        v53.AutoLocalize = false;
        v53.Parent = u15._is_open and u18.Container.Details.Changes or nil;
        table.insert(u15._elements, { v53, u18.Container.Details.Changes });

        if u24 and (v49 == "Header" and ItemLibrary.Items[v50]) then
            WeaponStatusHandler:ApplyItemStatusToText(v53, ItemLibrary.Items[v50].Status);
            u25[v50] = v53;
        end;

        add_to_collapsed_list(v53, v52);
    end;

    local function generate(p54) -- Line: 383
        -- upvalues: generate_thumbnail (copy), generate_balancing_overview (copy), generate_content_summary (copy), generate_text (copy)
        local v55 = p54[1];

        if v55 == "Thumbnail" then
            return generate_thumbnail(p54);
        end;

        if v55 == "BalancingOverview" then
            return generate_balancing_overview(p54);
        end;

        if v55 == "ContentSummary" then
            return generate_content_summary(p54);
        end;

        return generate_text(p54);
    end;

    for _, v in pairs(u17.Changes) do
        if typeof(v[1]) == "function" then
            for _, v2 in pairs(v[1](select(2, table.unpack(v)))) do
                local v56 = v2[1];

                if v56 == "Thumbnail" then
                    local v57 = v2[2];
                    local v58 = v2[3];
                    local v59 = PatchNoteThumbnailSlot:Clone();
                    u26 = u26 + 1;
                    v59.LayoutOrder = u26;
                    v59.Thumbnail.Image = v57;
                    v59.Title.Text = v58;
                    v59.Title.AutoLocalize = false;
                    add_to_collapsed_list(v59);
                    local v60;

                    if u15._is_open then
                        v60 = u18.Container.Details.Changes or nil;
                    else
                        v60 = nil;
                    end;

                    v59.Parent = v60;
                    table.insert(u15._elements, { v59, u18.Container.Details.Changes });
                elseif v56 == "BalancingOverview" then
                    generate_balancing_overview(v2);
                elseif v56 == "ContentSummary" then
                    generate_content_summary(v2);
                else
                    generate_text(v2);
                end;
            end;
        else
            local v61 = v[1];

            if v61 == "Thumbnail" then
                local v62 = v[2];
                local v63 = v[3];
                local v64 = PatchNoteThumbnailSlot:Clone();
                u26 = u26 + 1;
                v64.LayoutOrder = u26;
                v64.Thumbnail.Image = v62;
                v64.Title.Text = v63;
                v64.Title.AutoLocalize = false;
                add_to_collapsed_list(v64);
                local v65;

                if u15._is_open then
                    v65 = u18.Container.Details.Changes or nil;
                else
                    v65 = nil;
                end;

                v64.Parent = v65;
                table.insert(u15._elements, { v64, u18.Container.Details.Changes });
            elseif v61 == "BalancingOverview" then
                generate_balancing_overview(v);
            elseif v61 == "ContentSummary" then
                generate_content_summary(v);
            else
                generate_text(v);
            end;
        end;
    end;

    u20 = false;
    u15.ViewMoreButton.Visible = true;
end;

function u4._UpdateList(p66) -- Line: 411
    p66.CloseButton.Position = UDim2.new(0.975, 0, 0.0225, p66.PageFrame.AbsoluteSize.Y * 0.125);
    p66.ViewMoreButton.Position = p66.CloseButton.Position + UDim2.new(0, 0, 0.05, 0);
    p66.List.Position = UDim2.new(0.5, 9, 0, p66.PageFrame.AbsoluteSize.Y * 0.125);
    p66.List.Size = UDim2.new(0.85, 0, 0, p66.PageFrame.AbsoluteSize.Y * 0.75);
    p66.List.CanvasSize = UDim2.new(0, 0, 0, p66.Layout.AbsoluteContentSize.Y);
    p66.ViewMoreList.Position = UDim2.new(0.5, 9, 0, p66.PageFrame.AbsoluteSize.Y * 0.125);
    p66.ViewMoreList.Size = UDim2.new(0.85, 0, 0, p66.PageFrame.AbsoluteSize.Y * 0.75);
    p66.ViewMoreList.CanvasSize = UDim2.new(0, 0, 0, p66.ViewMoreLayout.AbsoluteContentSize.Y);
end;

function u4._UpdateSize(p67) -- Line: 422
    -- upvalues: UILibrary (copy)
    p67.PageContainer.Size = UDim2.new(0, math.min(1000, UILibrary.MainGui.AbsoluteSize.X * 0.875), 1, 0);
end;

function u4._SetupViewMoreSlots(u68) -- Line: 426
    -- upvalues: u1 (copy), PatchNotes (copy), ViewPatchNotesSlot (copy), Utility (copy), ButtonEffect (copy)
    for i, v in pairs(u1) do
        local v69 = require(PatchNotes:WaitForChild(v));
        local u70 = ViewPatchNotesSlot:Clone();
        u70.Button.Title.Text = v69.Title;
        u70.Button.Subtitle.Text = v69.Subtitle or v69.Date;
        u70.Button.Thumbnail.Image = v69.Image;
        u70.LayoutOrder = -i;
        u70.Parent = u68.ViewMoreContainer;
        u70.Button.MouseButton1Click:Connect(function() -- Line: 437
            -- upvalues: u68 (copy), v (copy)
            u68:SetViewMoreListVisible(false);
            task.defer(u68._Generate, u68, v);
        end);
        local Color3_fromRGB_ret = Color3.fromRGB(64, 64, 64);
        local Color3_fromRGB_ret2 = Color3.fromRGB(255, 255, 255);

        local function set(p71) -- Line: 446
            -- upvalues: u70 (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy)
            u70.Button.Thumbnail.ImageTransparency = 0.375 - 0.375 * p71;
            u70.Button.Thumbnail.ImageColor3 = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, p71);
            u70.Button.Stroke.Size = UDim2.new(1, 2 - 8 * p71, 1, 2 - 8 * p71);
            u70.Button.Stroke.UIStroke.Thickness = 4 * p71;
        end;

        u70.Button.Thumbnail.ImageTransparency = 0.375;
        u70.Button.Thumbnail.ImageColor3 = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, 0);
        u70.Button.Stroke.Size = UDim2.new(1, 2, 1, 2);
        u70.Button.Stroke.UIStroke.Thickness = 0;
        local u72 = 0;
        local u73 = 0;

        local function tween(p74) -- Line: 458
            -- upvalues: u72 (ref), Utility (ref), u73 (ref), set (copy)
            u72 = u72 + 1;
            local u75 = u72;
            Utility:RenderstepForLoop(u73, p74, 0.15 * (p74 < u73 and -1 or 1), function(p76) -- Line: 462
                -- upvalues: u75 (copy), u72 (ref), u73 (ref), set (ref)
                if u75 ~= u72 then
                    return true;
                end;

                u73 = p76;
                set(1 - (1 - u73) ^ 3);
            end);
        end;

        u70.Button.MouseLeave:Connect(function() -- Line: 472
            -- upvalues: u72 (ref), Utility (ref), u73 (ref), set (copy)
            u72 = u72 + 1;
            local u77 = u72;
            Utility:RenderstepForLoop(u73, 0, 0.15 * (u73 > 0 and -1 or 1), function(p78) -- Line: 462
                -- upvalues: u77 (copy), u72 (ref), u73 (ref), set (ref)
                if u77 ~= u72 then
                    return true;
                end;

                u73 = p78;
                set(1 - (1 - u73) ^ 3);
            end);
        end);
        u70.Button.SelectionLost:Connect(function() -- Line: 476
            -- upvalues: u72 (ref), Utility (ref), u73 (ref), set (copy)
            u72 = u72 + 1;
            local u79 = u72;
            Utility:RenderstepForLoop(u73, 0, 0.15 * (u73 > 0 and -1 or 1), function(p80) -- Line: 462
                -- upvalues: u79 (copy), u72 (ref), u73 (ref), set (ref)
                if u79 ~= u72 then
                    return true;
                end;

                u73 = p80;
                set(1 - (1 - u73) ^ 3);
            end);
        end);
        u70.Button.MouseEnter:Connect(function() -- Line: 480
            -- upvalues: u72 (ref), Utility (ref), u73 (ref), set (copy)
            u72 = u72 + 1;
            local u81 = u72;
            Utility:RenderstepForLoop(u73, 1, 0.15 * (u73 > 1 and -1 or 1), function(p82) -- Line: 462
                -- upvalues: u81 (copy), u72 (ref), u73 (ref), set (ref)
                if u81 ~= u72 then
                    return true;
                end;

                u73 = p82;
                set(1 - (1 - u73) ^ 3);
            end);
        end);
        u70.Button.SelectionGained:Connect(function() -- Line: 484
            -- upvalues: u72 (ref), Utility (ref), u73 (ref), set (copy)
            u72 = u72 + 1;
            local u83 = u72;
            Utility:RenderstepForLoop(u73, 1, 0.15 * (u73 > 1 and -1 or 1), function(p84) -- Line: 462
                -- upvalues: u83 (copy), u72 (ref), u73 (ref), set (ref)
                if u83 ~= u72 then
                    return true;
                end;

                u73 = p84;
                set(1 - (1 - u73) ^ 3);
            end);
        end);
        ButtonEffect:Add(u70.Button, nil, {
            ReleaseRatio = 0.975,
            HoverRatio = 0.975
        });
    end;
end;

function u4._Init(u85) -- Line: 492
    -- upvalues: PlayerDataController (copy), CONSTANTS (copy), ReplicatedStorage (copy), UILibrary (copy), ButtonEffect (copy)
    u85.CloseButton.MouseButton1Click:Connect(function() -- Line: 493
        -- upvalues: PlayerDataController (ref), CONSTANTS (ref), ReplicatedStorage (ref), u85 (copy)
        if PlayerDataController:Get("LastPatchNotesVersion") ~= CONSTANTS.GAME_VERSION then
            ReplicatedStorage.Remotes.Misc.ViewedPatchNotes:FireServer();
        end;

        u85:CloseRequest();
    end);
    u85.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 501
        -- upvalues: u85 (copy)
        u85:_UpdateList();
    end);
    u85.ViewMoreLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 505
        -- upvalues: u85 (copy)
        u85:_UpdateList();
    end);
    u85.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 509
        -- upvalues: u85 (copy)
        u85:_UpdateList();
    end);
    u85.ViewMoreButton.MouseButton1Click:Connect(function() -- Line: 513
        -- upvalues: u85 (copy)
        u85:SetViewMoreListVisible(true);
    end);
    UILibrary.MainGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 517
        -- upvalues: u85 (copy)
        u85:_UpdateSize();
    end);
    u85:_SetupViewMoreSlots();
    u85:_UpdateSize();
    u85:_UpdateList();
    u85:SetViewMoreListVisible(false);
    ButtonEffect:Add(u85.CloseButton);
    ButtonEffect:Add(u85.ViewMoreButton);
end;

return u4._new();