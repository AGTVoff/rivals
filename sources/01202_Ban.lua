-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.Prompts.Ban
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ModerationLibrary = require(ReplicatedStorage.Modules.ModerationLibrary);
local SettingsInfo = require(ReplicatedStorage.Modules.SettingsInfo);
require(ReplicatedStorage.Modules.BanLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local Dropdown = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Settings"):WaitForChild("Dropdown"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local Prompt = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Prompt"));
local u1 = { "Exploiting", "Exploiting - Movement Cheats", "Exploiting - Aim Cheats", "Exploiting - Vision Cheats", "Requesting Exploits", "Playing With Exploiters", "Fake Reporting", "Farming", "Abusing Minor Bugs", "Harassment / Hate Speech", "Ban Evasion", "Custom" };
local u2 = { "Permanent", "1 day", "3 days", "7 days", "14 days", "30 days", "90 days", "180 days", "365 days", "Custom" };
local u3 = setmetatable({}, Prompt);
u3.__index = u3;

function u3.new(p4) -- Line: 26
    -- upvalues: Prompt (copy), u3 (copy), Dropdown (copy), SettingsInfo (copy), u1 (copy), u2 (copy)
    local v5 = Prompt.new(script.Name);
    local v6 = setmetatable(v5, u3);
    v6.CloseButton = v6.PromptFrame:WaitForChild("Close");
    v6.ConfirmButton = v6.PromptFrame:WaitForChild("Confirm");
    v6.TitleText = v6.PromptFrame:WaitForChild("Title");
    v6.RestrictionNotice = v6.PromptFrame:WaitForChild("RestrictionNotice");
    v6.DetailsFrame = v6.PromptFrame:WaitForChild("Details");
    v6.ReasonFrame = v6.DetailsFrame:WaitForChild("Reason");
    v6.ReasonDropdownFrame = v6.ReasonFrame:WaitForChild("Dropdown");
    v6.ReasonCustomFrame = v6.DetailsFrame:WaitForChild("ReasonCustom");
    v6.ReasonCustomBox = v6.ReasonCustomFrame:WaitForChild("Input"):WaitForChild("Box");
    v6.DurationFrame = v6.DetailsFrame:WaitForChild("Duration");
    v6.DurationDropdownFrame = v6.DurationFrame:WaitForChild("Dropdown");
    v6.DurationCustomFrame = v6.DetailsFrame:WaitForChild("DurationCustom");
    v6.DurationCustomBox = v6.DurationCustomFrame:WaitForChild("Input"):WaitForChild("Box");
    v6.WarnFrame = v6.DetailsFrame:WaitForChild("Warn");
    v6.WarnContainer = v6.WarnFrame:WaitForChild("Container");
    v6.WarnButton = v6.WarnContainer:WaitForChild("Button");
    v6.WarnButtonEmpty = v6.WarnButton:WaitForChild("Empty");
    v6.WarnButtonFilled = v6.WarnButton:WaitForChild("Filled");
    v6.CasualLBsFrame = v6.DetailsFrame:WaitForChild("CasualLBs");
    v6.CasualLBsContainer = v6.CasualLBsFrame:WaitForChild("Container");
    v6.CasualLBsButton = v6.CasualLBsContainer:WaitForChild("Button");
    v6.CasualLBsButtonEmpty = v6.CasualLBsButton:WaitForChild("Empty");
    v6.CasualLBsButtonFilled = v6.CasualLBsButton:WaitForChild("Filled");
    v6.CompLBsFrame = v6.DetailsFrame:WaitForChild("CompLBs");
    v6.CompLBsContainer = v6.CompLBsFrame:WaitForChild("Container");
    v6.CompLBsButton = v6.CompLBsContainer:WaitForChild("Button");
    v6.CompLBsButtonEmpty = v6.CompLBsButton:WaitForChild("Empty");
    v6.CompLBsButtonFilled = v6.CompLBsButton:WaitForChild("Filled");
    v6.ReasonDropdown = Dropdown.new(SettingsInfo.new("", "", "", "", "", "Dropdown", u1[1], u1));
    v6.DurationDropdown = Dropdown.new(SettingsInfo.new("", "", "", "", "", "Dropdown", u2[1], u2));
    v6._ban_data = p4;
    v6:_Init();

    return v6;
end;

function u3.Confirm(p7) -- Line: 72
    -- upvalues: ModerationLibrary (copy), PlayerDataController (copy), ReplicatedStorage (copy)
    local v8;

    if p7.ReasonDropdown.Value == "Custom" then
        v8 = p7.ReasonCustomBox.Text;
    else
        v8 = p7.ReasonDropdown.Value;
    end;

    local v9 = p7:_GetBanDurationInteger();

    if not v9 then
        return;
    end;

    if #v8 < 5 or #v8 > 100 then
        return;
    end;

    if ModerationLibrary:CanWarnTemplate(PlayerDataController:Get("PermissionsRoles")) then
        local _ = p7.WarnButtonFilled.Visible;
    end;

    local v10;

    if ModerationLibrary:CanRestrict(PlayerDataController:Get("PermissionsRoles")) then
        v10 = {};
        v10.RestrictedFromCasualLeaderboards = p7.CasualLBsButtonFilled.Visible or p7._ban_data.Restrictions and p7._ban_data.Restrictions.RestrictedFromCasualLeaderboards;
        v10.RestrictedFromCompetitiveLeaderboards = p7.CompLBsButtonFilled.Visible or p7._ban_data.Restrictions and p7._ban_data.Restrictions.RestrictedFromCompetitiveLeaderboards;
    else
        v10 = nil;
    end;

    ReplicatedStorage.Remotes.Moderator.Ban:FireServer(p7._ban_data.Name, v9, v8, p7.WarnButtonFilled.Visible, v10);
    task.defer(p7.CloseRequest, p7);
end;

function u3.Destroy(p11) -- Line: 99
    -- upvalues: Prompt (copy)
    p11.ReasonDropdown:Destroy();
    p11.DurationDropdown:Destroy();
    Prompt.Destroy(p11);
end;

function u3._GetBanDurationInteger(p12) -- Line: 109
    if p12.DurationDropdown.Value == "Custom" then
        return tonumber(p12.DurationCustomBox.Text);
    end;

    if p12.DurationDropdown.Value == "Permanent" then
        return -1;
    end;

    local Value = p12.DurationDropdown.Value;
    local v13 = string.find(p12.DurationDropdown.Value, " ") - 1;
    local string_sub_ret = string.sub(Value, 1, v13);

    return tonumber(string_sub_ret);
end;

function u3._SetCasualLBsRestriction(p14, p15) -- Line: 115
    p14.CasualLBsButtonFilled.Visible = p15;
    p14.CasualLBsButtonEmpty.Visible = not p15;
end;

function u3._SetCompLBsRestriction(p16, p17) -- Line: 120
    p16.CompLBsButtonFilled.Visible = p17;
    p16.CompLBsButtonEmpty.Visible = not p17;
end;

function u3._SetWarn(p18, p19) -- Line: 125
    p18.WarnButtonFilled.Visible = p19;
    p18.WarnButtonEmpty.Visible = not p19;
end;

function u3._AutomaticallyCheckBoxes(p20) -- Line: 130
    local v21 = p20:_GetBanDurationInteger();
    local v22 = not v21 and 0 or (v21 == -1 and (1 / 0) or v21);
    p20:_SetCasualLBsRestriction(v22 >= 3);
    p20:_SetCompLBsRestriction(v22 >= 7);
end;

function u3._Update(p23) -- Line: 138
    local Value = p23.DurationDropdown.Value;
    p23.ReasonCustomFrame.Visible = p23.ReasonDropdown.Value == "Custom";
    p23.DurationFrame.Visible = true;
    p23.DurationCustomFrame.Visible = Value == "Custom";
end;

function u3._FormatSettingSlot(p24, p25) -- Line: 147
    p25.SettingFrame.Size = UDim2.new(1, 0, 1, 0);
    p25.SettingFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
    p25.SettingFrame.SizeConstraint = Enum.SizeConstraint.RelativeXY;
    p25.ControlsFrame.Size = UDim2.new(1, 0, 1, 0);
    p25.ControlsFrame.SizeConstraint = Enum.SizeConstraint.RelativeXY;
    p25.DropdownContainer.Size = UDim2.new(1, 0, 1, 0);
    p25.Background.Visible = false;
    p25.DetailsResetButton.Size = UDim2.new(0, 0, 0, 0);
end;

function u3._Setup(p26) -- Line: 158
    -- upvalues: ModerationLibrary (copy), PlayerDataController (copy)
    p26.TitleText.Text = "@" .. p26._ban_data.Name;
    p26.ReasonDropdown.SettingFrame.Parent = p26.ReasonDropdownFrame;
    p26.DurationDropdown.SettingFrame.Parent = p26.DurationDropdownFrame;
    p26.WarnFrame.Visible = ModerationLibrary:CanWarnTemplate(PlayerDataController:Get("PermissionsRoles"));
    p26.CasualLBsFrame.Visible = ModerationLibrary:CanRestrict(PlayerDataController:Get("PermissionsRoles"));
    p26.CompLBsFrame.Visible = ModerationLibrary:CanRestrict(PlayerDataController:Get("PermissionsRoles"));
    p26.RestrictionNotice.Visible = ModerationLibrary:CanRestrict(PlayerDataController:Get("PermissionsRoles"));
end;

function u3._Init(u27) -- Line: 168
    -- upvalues: ButtonEffect (copy)
    u27.CloseButton.MouseButton1Click:Connect(function() -- Line: 169
        -- upvalues: u27 (copy)
        u27:CloseRequest();
    end);
    u27.ConfirmButton.MouseButton1Click:Connect(function() -- Line: 173
        -- upvalues: u27 (copy)
        u27:Confirm();
    end);
    u27.DurationCustomBox.FocusLost:Connect(function() -- Line: 177
        -- upvalues: u27 (copy)
        if u27.DurationCustomBox.Text ~= "" then
            local DurationCustomBox = u27.DurationCustomBox;
            local v28;

            if tonumber(u27.DurationCustomBox.Text) then
                local v29 = tonumber(u27.DurationCustomBox.Text);
                local math_floor_ret = math.floor(v29);
                v28 = math.clamp(math_floor_ret, 1, 999) or "";
            else
                v28 = "";
            end;

            DurationCustomBox.Text = v28;
        end;

        u27:_AutomaticallyCheckBoxes();
    end);
    u27.ReasonDropdown.Replicate:Connect(function() -- Line: 185
        -- upvalues: u27 (copy)
        u27:_Update();
    end);
    u27.DurationDropdown.Replicate:Connect(function() -- Line: 189
        -- upvalues: u27 (copy)
        u27:_Update();
        u27:_AutomaticallyCheckBoxes();
    end);
    u27.WarnButton.MouseButton1Click:Connect(function() -- Line: 194
        -- upvalues: u27 (copy)
        u27:_SetWarn(not u27.WarnButtonFilled.Visible);
    end);
    u27.CasualLBsButton.MouseButton1Click:Connect(function() -- Line: 198
        -- upvalues: u27 (copy)
        u27:_SetCasualLBsRestriction(not u27.CasualLBsButtonFilled.Visible);
    end);
    u27.CompLBsButton.MouseButton1Click:Connect(function() -- Line: 202
        -- upvalues: u27 (copy)
        u27:_SetCasualLBsRestriction(not u27.CompLBsButtonFilled.Visible);
    end);
    u27:_Setup();
    u27:_FormatSettingSlot(u27.ReasonDropdown);
    u27:_FormatSettingSlot(u27.DurationDropdown);
    u27:_Update();
    u27:_AutomaticallyCheckBoxes();
    u27:_SetWarn(true);
    ButtonEffect:Add(u27.CloseButton);
    ButtonEffect:Add(u27.ConfirmButton);
    ButtonEffect:Add(u27.WarnButton);
    ButtonEffect:Add(u27.CasualLBsButton);
    ButtonEffect:Add(u27.CompLBsButton);
end;

return u3;