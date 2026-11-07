-- Instance: StarterPlayer.StarterPlayerScripts.Modules.InsetButtonsBar.InsetBarButton
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local InsetBarButton = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("InsetBarButton");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5, p6, p7, p8) -- Line: 14
    -- upvalues: u1 (copy), Signal (copy), InsetBarButton (copy)
    local v9 = setmetatable({}, u1);
    v9.Clicked = Signal.new();
    v9.Entered = Signal.new();
    v9.Name = p2;
    v9.Frame = InsetBarButton:Clone();
    v9._screen_gui_connections = {};
    v9._display_name = p3;
    v9._visual = p4;
    v9._visual_position = p5;
    v9._visual_size = p6;
    v9._visual_color = p7;
    v9._is_mirrored = p8;
    v9._bubble_frame = v9.Frame.Button.OnHover.Bubble;
    v9._bubble_effect_hash = 0;
    v9._bubble_effect_playing = false;
    v9._original_icon_size = nil;
    v9._screen_gui = nil;
    v9:_Init();

    return v9;
end;

function u1.SetParent(p10, p11) -- Line: 45
    p10.Frame.Parent = p11;
end;

function u1.SetMirrored(p12, p13) -- Line: 49
    if p13 == p12._is_mirrored then
        return;
    end;

    p12._is_mirrored = p13;
    p12:_UpdateMirrored();
end;

function u1.Enter(p14) -- Line: 58
    if p14._bubble_effect_playing then
        return;
    end;

    p14.Frame.Button.OnHover.Visible = true;
    p14._bubble_frame.Visible = true;
    p14.Entered:Fire();
end;

function u1.Leave(p15) -- Line: 68
    if p15._bubble_effect_playing then
        return;
    end;

    p15.Frame.Button.OnHover.Visible = false;
    p15._bubble_frame.Visible = false;
end;

function u1.SetBubbleText(p16, p17) -- Line: 77
    p16._bubble_frame.Container.Title.Text = p17;
end;

function u1.PlayJiggleEffect(p18) -- Line: 81
    p18.Frame.Button.Icon.Size = UDim2.new(p18._original_icon_size.X.Scale * 1.5, p18._original_icon_size.X.Offset * 1.5, p18._original_icon_size.Y.Scale * 1.5, p18._original_icon_size.Y.Offset * 1.5);
    p18.Frame.Button.Icon:TweenSize(p18._original_icon_size, "Out", "Back", 0.25, true);
end;

function u1.PlayBubbleEffect(u19, p20) -- Line: 92
    -- upvalues: Players (copy)
    u19._bubble_effect_hash = u19._bubble_effect_hash + 1;
    local _bubble_effect_hash = u19._bubble_effect_hash;

    if not p20 then
        u19:_DisableBubbleEffect();

        return;
    end;

    u19._bubble_effect_playing = true;
    u19.Frame.Button.OnHover.Visible = true;
    u19._bubble_frame.Container.Visible = true;
    u19._bubble_frame.Container.Title.Text = p20;
    task.delay(3, function() -- Line: 106
        -- upvalues: _bubble_effect_hash (copy), u19 (copy), Players (ref)
        wait(3);

        if _bubble_effect_hash ~= u19._bubble_effect_hash or not u19.Frame:IsDescendantOf(Players) then
            return;
        end;

        u19:_DisableBubbleEffect();
    end);
end;

function u1.Destroy(u21) -- Line: 117
    for _, v in pairs(u21._screen_gui_connections) do
        v:Disconnect();
    end;

    u21._screen_gui_connections = {};
    u21.Clicked:Destroy();
    u21.Entered:Destroy();
    pcall(function() -- Line: 127
        -- upvalues: u21 (copy)
        u21.Frame:Destroy();
    end);
end;

function u1._GetScreenGui(p22) -- Line: 136
    -- upvalues: Players (copy)
    local Frame = p22.Frame;

    while Frame and Frame ~= Players.LocalPlayer do
        Frame = Frame.Parent;

        if Frame and Frame:IsA("ScreenGui") then
            return Frame;
        end;
    end;

    return nil;
end;

function u1._VerifyScreenGui(u23) -- Line: 150
    for _, v in pairs(u23._screen_gui_connections) do
        v:Disconnect();
    end;

    u23._screen_gui_connections = {};
    u23._screen_gui = u23:_GetScreenGui();
    u23._bubble_frame.Parent = u23._screen_gui;

    if not u23._screen_gui then
        return;
    end;

    local _screen_gui_connections = u23._screen_gui_connections;
    local PropertyChangedSignal = u23._screen_gui:GetPropertyChangedSignal("AbsolutePosition");
    table.insert(_screen_gui_connections, PropertyChangedSignal:Connect(function() -- Line: 163
        -- upvalues: u23 (copy)
        u23:_UpdateBubble();
    end));
    u23:_UpdateBubble();
end;

function u1._DisableBubbleEffect(p24) -- Line: 170
    p24:_ResetBubbleVisibility();
    p24._bubble_effect_playing = false;
    p24:Leave();
end;

function u1._ResetBubbleVisibility(p25) -- Line: 176
    p25._bubble_frame.Container.Visible = p25._display_name ~= nil;
end;

function u1._UpdateBubble(p26) -- Line: 180
    if not p26._screen_gui then
        return;
    end;

    p26._bubble_frame.Container.Background.Size = UDim2.new(0.25, p26._bubble_frame.Container.Title.TextBounds.X, 1, 0);
    p26._bubble_frame.Position = UDim2.new(0, p26.Frame.Button.OnHover.AbsolutePosition.X - p26._screen_gui.AbsolutePosition.X + p26.Frame.Button.OnHover.AbsoluteSize.X / 2, 0, p26.Frame.Button.OnHover.AbsolutePosition.Y + p26.Frame.Button.OnHover.AbsoluteSize.Y - p26._screen_gui.AbsolutePosition.Y);
    p26._bubble_frame.Size = UDim2.new(0, p26.Frame.Button.OnHover.AbsoluteSize.X, 0, p26.Frame.Button.OnHover.AbsoluteSize.Y);
end;

function u1._UpdateBubbleContainer(p27) -- Line: 190
    local v28 = 1;

    for i = 1, #p27._bubble_frame.Container.Title.Text do
        local v29;

        if string.sub(p27._bubble_frame.Container.Title.Text, i, i) == "\n" then
            v28 = v28 + 1;
            v29 = i;
        else
            v29 = i;
        end;
    end;

    p27._bubble_frame.Container.Size = UDim2.new(3.25, 0, v28 * 0.75, 0);
    p27._bubble_frame.Container.Arrow.Size = UDim2.new(0.5 / v28, 0, 0.5 / v28, 0);
    p27:_UpdateBubble();
end;

function u1._UpdateMirrored(p30) -- Line: 204
    p30._bubble_frame.Container.Title.AnchorPoint = p30._is_mirrored and Vector2.new(1, 0.5) or Vector2.new(0, 0.5);
    p30._bubble_frame.Container.Title.Position = p30._is_mirrored and UDim2.new(0.875, 0, 0.5, 0) or UDim2.new(0.125, 0, 0.5, 0);
    p30._bubble_frame.Container.Title.TextXAlignment = p30._is_mirrored and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left;
    p30._bubble_frame.Container.Background.AnchorPoint = p30._is_mirrored and Vector2.new(1, 0.5) or Vector2.new(0, 0.5);
    p30._bubble_frame.Container.Background.Position = p30._is_mirrored and UDim2.new(1, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0);
    p30._bubble_frame.Container.Arrow.Position = p30._is_mirrored and UDim2.new(0.75, 0, 0, 2) or UDim2.new(0.25, 0, 0, 2);
    p30._bubble_frame.Container.AnchorPoint = p30._is_mirrored and Vector2.new(0.75, 0) or Vector2.new(0.25, 0);
end;

function u1._Setup(p31) -- Line: 214
    local v32;

    if typeof(p31._visual) == "string" and #p31._visual >= 13 then
        v32 = string.sub(p31._visual, 1, 13) == "rbxassetid://";
    else
        v32 = false;
    end;

    p31.Frame.Button.Icon.Image = v32 and (p31._visual or "") or "";
    p31.Frame.Button.Icon.Position = p31._visual_position or UDim2.new(0.5, 0, 0.5, 0);
    p31.Frame.Button.Icon.Size = p31._visual_size or UDim2.new(0.5, 0, 0.5, 0);
    p31.Frame.Button.Title.Position = p31._visual_position or UDim2.new(0.5, 0, 0.5, 0);
    p31.Frame.Button.Title.Size = p31._visual_size or UDim2.new(0.5, 0, 0.5, 0);
    p31.Frame.Button.Title.Text = v32 and "" or (p31._visual or "");
    p31.Frame.Button.Title.TextColor3 = p31._visual_color;
    p31.Frame.Button.Icon.ImageColor3 = p31._visual_color;
    p31.Frame.Button.OnHover.Visible = false;
    p31.Frame.Button.OnHover.BackgroundTransparency = 0.75;
    p31._bubble_frame.Container.Title.Text = p31._display_name or "";
    p31._bubble_frame.ZIndex = 999;
    p31._bubble_frame.Parent = nil;
    p31._original_icon_size = p31.Frame.Button.Icon.Size;
end;

function u1._Init(u33) -- Line: 235
    -- upvalues: ButtonEffect (copy)
    u33.Frame.AncestryChanged:Connect(function() -- Line: 236
        -- upvalues: u33 (copy)
        u33:_VerifyScreenGui();
    end);
    u33.Frame.Destroying:Connect(function() -- Line: 240
        -- upvalues: u33 (copy)
        u33:Destroy();
    end);
    u33.Frame.Button.MouseButton1Click:Connect(function() -- Line: 244
        -- upvalues: u33 (copy)
        u33.Clicked:Fire();
    end);
    u33.Frame.MouseEnter:Connect(function() -- Line: 248
        -- upvalues: u33 (copy)
        u33:Enter();
    end);
    u33.Frame.MouseLeave:Connect(function() -- Line: 252
        -- upvalues: u33 (copy)
        u33:Leave();
    end);
    u33.Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 256
        -- upvalues: u33 (copy)
        u33:_UpdateBubble();
    end);
    u33.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 260
        -- upvalues: u33 (copy)
        u33:_UpdateBubble();
    end);
    u33.Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 264
        -- upvalues: u33 (copy)
        u33:Leave();
    end);
    u33.Frame.Button.OnHover:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 268
        -- upvalues: u33 (copy)
        u33:_UpdateBubble();
    end);
    u33.Frame.Button.OnHover:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 272
        -- upvalues: u33 (copy)
        u33:_UpdateBubble();
    end);
    u33._bubble_frame.Container.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 276
        -- upvalues: u33 (copy)
        u33:_UpdateBubble();
    end);
    u33._bubble_frame.Container.Title:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 280
        -- upvalues: u33 (copy)
        u33:_UpdateBubbleContainer();
    end);
    u33:_Setup();
    u33:_UpdateMirrored();
    u33:_UpdateBubble();
    u33:_ResetBubbleVisibility();
    u33:_UpdateBubbleContainer();
    u33:_VerifyScreenGui();
    u33:Leave();
    ButtonEffect:Add(u33.Frame.Button, true);
end;

return u1;