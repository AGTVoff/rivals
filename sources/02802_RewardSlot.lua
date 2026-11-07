-- Instance: StarterPlayer.StarterPlayerScripts.Modules.RewardSlot
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local CosmeticSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("CosmeticSlot"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local RewardBubble = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("RewardBubble");
local RewardSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("RewardSlot");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 22
    -- upvalues: u1 (copy), CosmeticLibrary (copy), RewardSlot (copy)
    local v5 = setmetatable({}, u1);
    v5.RewardData = p2;
    v5.CosmeticInfo = CosmeticLibrary.Cosmetics[v5.RewardData.Name];
    v5.RewardInfo = CosmeticLibrary.Rewards[v5.RewardData.Name];
    v5.Frame = RewardSlot:Clone();
    v5.CosmeticSlot = nil;
    v5._ignore_button_effects = p3;
    v5._is_locked = p4;
    v5._key_slot_frame = nil;
    v5._bubble_hash = 0;
    v5._bubble_frame = nil;
    v5._bubble_reward_slot = nil;
    v5._bubble_connections = {};
    v5._bubble_auto_close_delay = nil;
    v5._on_click_callback = nil;
    v5:_Init();

    return v5;
end;

function u1.GetRewardBubbleTitle(p6) -- Line: 50
    -- upvalues: Utility (copy), CosmeticLibrary (copy)
    local v7 = p6.RewardData.Quantity or 1;
    local v8 = p6.RewardInfo and p6.RewardInfo.BubbleTitle;

    if not v8 then
        if p6.RewardInfo and p6.RewardInfo.Type == "Weapon" then
            if p6:_IsUnreleasedWeapon() then
                return "COMING SOON";
            end;

            v8 = p6.RewardInfo.DisplayName or (p6.RewardInfo and (p6.RewardInfo.PrioritizeNameOverQuantity and v7 == 1) and p6.RewardInfo.DisplayName or p6.RewardInfo and "×" .. Utility:PrettyNumber(v7) .. " " .. (v7 ~= 1 and p6.RewardInfo.DisplayNamePlural or p6.RewardInfo.DisplayName) or p6.RewardData.Name .. " " .. CosmeticLibrary.Cosmetics[p6.RewardData.Name].Type);
        else
            v8 = p6.RewardInfo and (p6.RewardInfo.PrioritizeNameOverQuantity and v7 == 1) and p6.RewardInfo.DisplayName or p6.RewardInfo and "×" .. Utility:PrettyNumber(v7) .. " " .. (v7 ~= 1 and p6.RewardInfo.DisplayNamePlural or p6.RewardInfo.DisplayName) or p6.RewardData.Name .. " " .. CosmeticLibrary.Cosmetics[p6.RewardData.Name].Type;
        end;
    end;

    return v8;
end;

function u1.GetRewardBubbleDescription(p9) -- Line: 60
    -- upvalues: Utility (copy), ShopLibrary (copy), ItemLibrary (copy)
    local v10 = p9.RewardInfo and p9.RewardInfo.BubbleDescription or p9.RewardInfo and p9.RewardInfo.Type == "Lootbox" and (p9.RewardData.Weapon and (p9.RewardData.Weapon ~= "IsRandom" and p9.RewardData.Weapon ~= "IsUniversal") and "Contains special items for " .. p9.RewardData.Weapon .. "!" or p9.RewardInfo.LootboxDescription) or p9.RewardInfo and p9.RewardInfo.Type == "Weapon" and (p9:_IsUnreleasedWeapon() and "in " .. Utility:TimeFormat2(ShopLibrary:GetTimeUntilWeaponRelease(p9.RewardData.Name)) .. "!" or ItemLibrary.Items[p9.RewardData.Name].Status .. " Weapon");

    if not v10 then
        if p9.RewardData.Weapon == "IsUniversal" then
            return "Given to all weapons forever!";
        end;

        if p9.RewardData.Weapon == "IsRandom" then
            return "Given to a random weapon!";
        end;

        v10 = p9.RewardData.Weapon and "Given to " .. p9.RewardData.Weapon .. "!" or (p9.CosmeticInfo and p9.CosmeticInfo.Description or "???");
    end;

    return v10;
end;

function u1.SetParent(p11, p12) -- Line: 71
    p11.Frame.Parent = p12;
end;

function u1.SetInteractable(p13, p14) -- Line: 75
    p13.Frame.Reward.Interactable = p14;

    if p13.CosmeticSlot then
        p13.CosmeticSlot:SetInteractable(p14);
    end;
end;

function u1.SetWeapon(p15, p16) -- Line: 83
    -- upvalues: ItemLibrary (copy), WeaponStatusHandler (copy)
    if p15.CosmeticSlot then
        return p15.CosmeticSlot:SetWeapon(p16);
    end;

    if p16 == "IsRandom" and (p15.RewardInfo and p15.RewardInfo.Type == "Lootbox") then
        p16 = nil;
    end;

    if not p16 then
        p15.Frame.Reward.Weapon.Visible = false;

        return;
    end;

    local v17 = ItemLibrary.Items[p16];
    local v18 = ItemLibrary.ViewModels[p16];
    local v19 = p16 == "IsUniversal" and true or p16 == "IsRandom";
    local v20;

    if p16 == "IsUniversal" then
        v20 = ItemLibrary.UNIVERSAL_WEAPON_ICON;
    elseif p16 == "IsRandom" then
        v20 = ItemLibrary.RANDOM_WEAPON_ICON;
    else
        v20 = not v18 and "" or (v18.ImageCentered or v18.Image);
    end;

    p15.Frame.Reward.Weapon.Visible = true;
    p15.Frame.Reward.Weapon.Container.IconCanvas.Icon.Image = v20;
    p15.Frame.Reward.Weapon.Container.IconCanvas.Icon.ImageTransparency = v19 and 0.25 or 0;
    p15.Frame.Reward.Weapon.Container.IconCanvas.Icon.Size = v19 and UDim2.new(0.7, 0, 0.7, 0) or UDim2.new(4, 0, 4, 0);
    WeaponStatusHandler:ApplyItemStatusToBackground(p15.Frame.Reward.Weapon.Container.Background, p15.Frame.Reward.Weapon.Container.Outline.UIStroke, v17 and v17.Status or "Standard");
end;

function u1.OnClick(p21, p22) -- Line: 112
    p21._on_click_callback = p22;
end;

function u1.EnableOwnedLogic(p23, p24) -- Line: 116
    if p23.CosmeticSlot then
        p23.CosmeticSlot:EnableOwnedLogic(p24);
    end;
end;

function u1.HideWeaponVisual(p25) -- Line: 122
    p25.Frame.Reward.Weapon.Visible = false;

    if p25.CosmeticSlot then
        p25.CosmeticSlot.Frame.Button.Weapon.Visible = false;
    end;
end;

function u1.HideBackground(p26) -- Line: 130
    if p26.CosmeticSlot then
        p26.CosmeticSlot:HideBackground();
    end;
end;

function u1.ZoomOutViewportFrame(p27) -- Line: 136
    if p27.CosmeticSlot then
        p27.CosmeticSlot:ZoomOutViewportFrame();
    end;
end;

function u1.UseHighResolutionImage(p28) -- Line: 142
    if p28.RewardInfo then
        p28.Frame.Reward.Icon.Image = p28.RewardInfo.ImageHighResolution or p28.RewardInfo.Image;
    end;

    if p28.CosmeticSlot then
        p28.CosmeticSlot:UseHighResolutionImage();
    end;
end;

function u1.SetNameText(p29, p30) -- Line: 152
    p29.Frame.Reward.Title.Text = p30;

    if p29.CosmeticSlot then
        p29.CosmeticSlot.Frame.Button.Title.Text = p30;
    end;
end;

function u1.LockedImage(p31) -- Line: 160
    p31.Frame.Reward.Icon.ImageColor3 = Color3.fromRGB(0, 0, 0);
    p31.Frame.Reward.Icon.ImageTransparency = 0.5;

    if p31.CosmeticSlot then
        p31.CosmeticSlot.Frame.Button.Icon.ImageColor3 = Color3.fromRGB(0, 0, 0);
        p31.CosmeticSlot.Frame.Button.Icon.ImageTransparency = 0.5;
    end;
end;

function u1.InvertNameText(p32) -- Line: 170
    if p32.RewardInfo and p32.RewardInfo.Type == "Weapon" then
        p32.Frame.Reward.Title.Visible = false;

        return;
    end;

    p32.Frame.Reward.Title.TextColor3 = Color3.fromRGB(0, 0, 0);
    p32.Frame.Reward.Title.UIStroke.Enabled = false;
end;

function u1.SetBubbleAutoCloseDelay(p33, p34) -- Line: 179
    p33._bubble_auto_close_delay = p34;
end;

function u1.CloseBubble(p35) -- Line: 183
    -- upvalues: RunService (copy)
    p35._bubble_hash = p35._bubble_hash + 1;

    for _, v in pairs(p35._bubble_connections) do
        v:Disconnect();
    end;

    p35._bubble_connections = {};
    p35._open_bubble_upwards = nil;

    if p35._bubble_frame then
        p35._bubble_frame:Destroy();
        p35._bubble_frame = nil;
    end;

    if p35._bubble_reward_slot then
        p35._bubble_reward_slot:Destroy();
        p35._bubble_reward_slot = nil;
    end;

    RunService:UnbindFromRenderStep("RewardSlotOpenBubble");
end;

function u1.OpenBubble(u36, p37, p38) -- Line: 206
    -- upvalues: RewardBubble (copy), UILibrary (copy), u1 (copy), ItemLibrary (copy), WeaponStatusHandler (copy), GuiService (copy), UserInputService (copy), Players (copy), RunService (copy)
    u36:CloseBubble();
    u36._open_bubble_upwards = p37;
    u36._bubble_hash = u36._bubble_hash + 1;
    local _bubble_hash = u36._bubble_hash;
    local v39 = p38 or 1;
    local UDim2_new_ret = UDim2.new(RewardBubble.Size.X.Scale * v39, RewardBubble.Size.X.Offset * v39, RewardBubble.Size.Y.Scale * v39, RewardBubble.Size.Y.Offset * v39);
    local UDim2_new_ret2 = UDim2.new(UDim2_new_ret.X.Scale / 2, UDim2_new_ret.X.Offset / 2, UDim2_new_ret.Y.Scale / 2, UDim2_new_ret.Y.Offset / 2);
    u36._bubble_frame = RewardBubble:Clone();
    u36._bubble_frame.Title.Text = u36:GetRewardBubbleTitle();
    u36._bubble_frame.Description.Text = u36:GetRewardBubbleDescription();
    u36._bubble_frame.Size = UDim2_new_ret2;
    u36._bubble_frame.Parent = UILibrary:GetTo("MainFrame");
    u36._bubble_frame:TweenSize(UDim2_new_ret, "Out", "Back", 0.25, true);
    u36._bubble_reward_slot = u1.new(u36.RewardData, true);
    u36._bubble_reward_slot:OnClick(function() -- Line: 225
    end);
    u36._bubble_reward_slot:InvertNameText();
    u36._bubble_reward_slot:SetParent(u36._bubble_frame.Reward);

    if u36:_IsUnreleasedWeapon() then
        u36._bubble_reward_slot:LockedImage();
    end;

    if u36.RewardInfo and u36.RewardInfo.Type == "Weapon" then
        local v40 = ItemLibrary.Items[u36.RewardInfo.DisplayName] and ItemLibrary.Items[u36.RewardInfo.DisplayName].Status;
        WeaponStatusHandler:ApplyItemStatusToText(u36._bubble_frame.Title, v40);
        WeaponStatusHandler:ApplyItemStatusToText(u36._bubble_frame.Description, v40);
    elseif u36.RewardData and u36.RewardData.Weapon then
        WeaponStatusHandler:ApplyItemStatusToText(u36._bubble_frame.Description, ItemLibrary.Items[u36.RewardData.Weapon] and ItemLibrary.Items[u36.RewardData.Weapon].Status);
    elseif u36.RewardInfo and u36.RewardInfo.NameStatus then
        WeaponStatusHandler:ApplyItemStatusToText(u36._bubble_frame.Title, u36.RewardInfo.NameStatus);
    end;

    local _bubble_connections = u36._bubble_connections;
    local PropertyChangedSignal = GuiService:GetPropertyChangedSignal("MenuIsOpen");
    table.insert(_bubble_connections, PropertyChangedSignal:Connect(function() -- Line: 243
        -- upvalues: GuiService (ref), u36 (copy)
        if GuiService.MenuIsOpen then
            u36:CloseBubble();
        end;
    end));
    table.insert(u36._bubble_connections, UserInputService.InputBegan:Connect(function(p41) -- Line: 249
        -- upvalues: u36 (copy)
        if p41.UserInputType == Enum.UserInputType.MouseButton1 or (p41.KeyCode == Enum.KeyCode.Return or (p41.UserInputType == Enum.UserInputType.Touch or (p41.KeyCode == Enum.KeyCode.ButtonA or p41.KeyCode == Enum.KeyCode.ButtonB))) then
            u36:CloseBubble();
        end;
    end));
    table.insert(u36._bubble_connections, u36.Frame.AncestryChanged:Connect(function() -- Line: 255
        -- upvalues: u36 (copy), Players (ref)
        if not (u36.Frame:IsDescendantOf(workspace) or (not Players.LocalPlayer:FindFirstChild("PlayerGui") or u36.Frame:IsDescendantOf(Players.LocalPlayer.PlayerGui))) then
            u36:CloseBubble();
        end;
    end));
    local _bubble_connections2 = u36._bubble_connections;
    local PropertyChangedSignal2 = u36.Frame:GetPropertyChangedSignal("AbsolutePosition");
    table.insert(_bubble_connections2, PropertyChangedSignal2:Connect(function() -- Line: 261
        -- upvalues: u36 (copy)
        u36:_UpdateBubblePosition();
    end));
    local _bubble_connections3 = u36._bubble_connections;
    local PropertyChangedSignal3 = u36.Frame:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(_bubble_connections3, PropertyChangedSignal3:Connect(function() -- Line: 265
        -- upvalues: u36 (copy)
        u36:_UpdateBubblePosition();
    end));
    RunService:BindToRenderStep("RewardSlotOpenBubble", Enum.RenderPriority.Camera.Value - 1, function() -- Line: 269
        -- upvalues: u36 (copy)
        u36:_UpdateBubblePosition();
    end);
    u36:_UpdateBubblePosition();

    if u36._bubble_auto_close_delay then
        task.delay(u36._bubble_auto_close_delay, function() -- Line: 276
            -- upvalues: u36 (copy), _bubble_hash (copy), UDim2_new_ret2 (copy)
            if u36._bubble_hash ~= _bubble_hash then
                return;
            end;

            u36._bubble_frame:TweenSize(UDim2_new_ret2, "In", "Quint", 0.25, true);
            wait(0.25);

            if u36._bubble_hash ~= _bubble_hash then
                return;
            end;

            u36:CloseBubble();
        end);
    end;
end;

function u1.Destroy(p42) -- Line: 294
    p42:CloseBubble();
    p42.Frame:Destroy();

    if p42.CosmeticSlot then
        p42.CosmeticSlot:Destroy();
    end;
end;

function u1._IsUnreleasedWeapon(p43) -- Line: 307
    -- upvalues: ShopLibrary (copy)
    local RewardInfo = p43.RewardInfo;

    if RewardInfo then
        if p43.RewardInfo.Type == "Weapon" then
            RewardInfo = not table.find(ShopLibrary:GetReleasedOwnableWeapons(), p43.RewardData.Name);
        else
            RewardInfo = false;
        end;
    end;

    return RewardInfo;
end;

function u1._OnClick(p44) -- Line: 311
    if p44._on_click_callback then
        return p44._on_click_callback();
    end;

    p44:OpenBubble();
end;

function u1._GetLayerCollector(p45) -- Line: 319
    local Parent = p45.Frame.Parent;

    while Parent and not Parent:IsA("LayerCollector") do
        Parent = Parent.Parent;
    end;

    return Parent;
end;

function u1._UpdateBubblePosition(p46) -- Line: 329
    -- upvalues: UILibrary (copy)
    if not p46._bubble_frame.Parent then
        return;
    end;

    local v47 = p46:_GetLayerCollector();
    local v48;

    if v47 then
        v48 = v47:IsA("SurfaceGui");
    else
        v48 = v47;
    end;

    local v49, v50;

    if v48 then
        local v51 = v47.Adornee or v47.Parent;

        if v51:IsA("BasePart") then
            local v52 = workspace.CurrentCamera:WorldToScreenPoint(v51.Position);

            if v52.Z < 0 then
                v49 = -p46._bubble_frame.AbsoluteSize * 10;
            else
                v49 = UILibrary:ScreenPointToPosition(v52);
            end;
        else
            v49 = Vector2.new();
        end;

        v50 = Vector2.new();
    else
        v49 = p46.Frame.AbsolutePosition;
        v50 = p46.Frame.AbsoluteSize;
    end;

    local v53 = v49 - p46._bubble_frame.Parent.AbsolutePosition;
    local v54;

    if p46._open_bubble_upwards == true then
        v54 = false;
    else
        v54 = p46._open_bubble_upwards == false and true or v53.Y + v50.Y / 2 < p46._bubble_frame.Parent.AbsoluteSize.Y / 2;
    end;

    p46._bubble_frame.Position = UDim2.new(0, math.clamp(v53.X + v50.X / 2, p46._bubble_frame.AbsoluteSize.X / 2 + 10, p46._bubble_frame.Parent.AbsoluteSize.X - p46._bubble_frame.AbsoluteSize.X / 2 - 10), v48 and 0 or (v54 and 0.02 or -0.02), v53.Y + (not v54 and 0 or v50.Y));
    local _bubble_frame = p46._bubble_frame;
    local v55;

    if v54 then
        v55 = Vector2.new(0.5, 0);
    else
        v55 = Vector2.new(0.5, 1);
    end;

    _bubble_frame.AnchorPoint = v55;
    p46._bubble_frame.Arrow.Position = UDim2.new(0, math.clamp(v53.X + v50.X / 2 - (p46._bubble_frame.AbsolutePosition.X - p46._bubble_frame.Parent.AbsolutePosition.X), p46._bubble_frame.Arrow.AbsoluteSize.X * 0.875 + 10, p46._bubble_frame.AbsoluteSize.X - p46._bubble_frame.Arrow.AbsoluteSize.X * 0.875 - 10), v54 and 0 or 1, v54 and 2 or -2);
end;

function u1._Setup(u56) -- Line: 379
    -- upvalues: CosmeticSlot (copy), ItemLibrary (copy), Utility (copy), WeaponStatusHandler (copy), ButtonEffect (copy)
    if u56.CosmeticInfo then
        u56.CosmeticSlot = CosmeticSlot.new(u56.RewardData.Name, u56._is_locked, u56._ignore_button_effects);
        u56.CosmeticSlot:SetQuantity(u56.RewardData.Quantity);
        u56.CosmeticSlot.Frame.Parent = u56.Frame;
        u56.CosmeticSlot.Frame.Button.MouseButton1Click:Connect(function() -- Line: 385
            -- upvalues: u56 (copy)
            u56:_OnClick();
        end);
    elseif u56.RewardInfo then
        local v57 = ItemLibrary.Items[u56.RewardData.Name];
        local v58;

        if u56.RewardInfo.Type == "Weapon" then
            v58 = true;
        else
            v58 = u56.RewardInfo.PrioritizeNameOverQuantity and (u56.RewardData.Quantity or 1) == 1;
        end;

        u56.Frame.Reward.Visible = true;
        u56.Frame.Reward.Title.Text = v58 and u56.RewardInfo.DisplayName or "×" .. Utility:PrettyNumber(u56.RewardData.Quantity or 1);
        u56.Frame.Reward.Title.Size = v58 and UDim2.new(0.9, 0, 0.2, 0) or UDim2.new(0.9, 0, 0.4, 0);
        u56.Frame.Reward.Icon.Image = u56.RewardInfo.Image;
        u56.Frame.Reward.Icon.Size = UDim2.new(u56.RewardInfo.ImageScale, 0, u56.RewardInfo.ImageScale, 0);
        local NameStatus = u56.RewardInfo.NameStatus;

        if NameStatus then
            v57 = NameStatus;
        elseif v57 then
            v57 = v57.Status;
        end;

        WeaponStatusHandler:ApplyItemStatusToText(u56.Frame.Reward.Title, v57);
        u56.Frame.Reward.MouseButton1Click:Connect(function() -- Line: 400
            -- upvalues: u56 (copy)
            u56:_OnClick();
        end);

        if not u56._ignore_button_effects then
            ButtonEffect:Add(u56.Frame.Reward);
        end;
    else
        warn("reward_data = {");

        for i, v in pairs(u56.RewardData) do
            warn("\t", i, v);
        end;

        warn("}");
        assert(false, u56.RewardData.Name);
    end;

    u56:SetWeapon(u56.RewardData.Weapon);
end;

function u1._Init(p59) -- Line: 420
    p59:_Setup();
end;

return u1;