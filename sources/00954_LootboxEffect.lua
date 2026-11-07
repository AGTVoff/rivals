-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.Functions.LootboxEffect
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("LootboxCollectParticles"):WaitForChild("Attachment");
local UnboxEffect = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Misc"):WaitForChild("UnboxEffect");
local Lootboxes = Players.LocalPlayer.PlayerScripts.Assets:WaitForChild("Lootboxes");
local u1 = {
    Common = { "rbxassetid://18182950485", 0.5 },
    Rare = { "rbxassetid://18182950836", 0.375 },
    Legendary = { "rbxassetid://18182950182", 0.375 },
    Mythical = { "rbxassetid://115151712865765", 0.5 },
    Standard = { "rbxassetid://18182950485", 0.5 },
    Prime = { "rbxassetid://18182950182", 0.375 }
};
local u2 = 0;

return function(p3, p4, p5, p6, u7, p8, p9, p10) -- Line: 28
    -- upvalues: CosmeticLibrary (copy), u2 (ref), Lootboxes (copy), BetterDebris (copy), Utility (copy), CONSTANTS (copy), UnboxEffect (copy), Players (copy), RewardSlot (copy), ItemLibrary (copy), u1 (copy), TweenService (copy), Attachment (copy)
    local v11 = p5[1] and CosmeticLibrary.Cosmetics[p5[1].RewardData.Name];
    local v12 = p5[1] and CosmeticLibrary.Rewards[p5[1].RewardData.Name];
    local u13 = CosmeticLibrary.Rewards[p4];

    if p6 and p6 > 0 then
        wait(p6);
    end;

    u2 = u2 + 1;
    local v14 = u2 * 3.141592653589793 * 2 / 8 + math.floor((u2 - 1) / 8) * 3.141592653589793 / 8;
    local v15 = math.floor(u2 - 1) * 5;
    local v16 = v14 + math.rad(v15);
    local v17 = math.floor((u2 % 64 - 1) / 8) * 1;
    local u18 = Lootboxes[p4]:Clone();
    local v19 = u18:FindFirstChild("HumanoidRootPart") or u18:FindFirstChild("RootPart");

    for _, descendant in pairs(u18:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Anchored = false;
        end;
    end;

    if u13.SoundProfile == "PrizeWheel" then
        if not v11 or v11.Type ~= "Skin" then
            u18.wheel.Slices:PivotTo(u18.wheel.Slices:GetPivot() * CFrame.Angles(0, 0, 1.0471975511965976 * Random.new(p10):NextInteger(1, 5)));
        end;

        for _, child in pairs(u18.wheel.Slices:GetChildren()) do
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = child;
            WeldConstraint.Part1 = u18.wheel;
            WeldConstraint.Parent = child;
        end;
    end;

    v19.Anchored = true;
    u18.Parent = workspace;
    BetterDebris:AddItem(u18, 15);
    Utility:CreateSound("rbxassetid://18183233381", 0.5, 1 + 0.25 * math.random(), v19, true);
    local u20 = CFrame.new(p3) * CFrame.Angles(0, v16, 0);
    local u21 = CFrame.new(p3) * CFrame.Angles(0, v16, 0) * CFrame.new(0, -3, v17 + 7);
    Utility:RenderstepForLoop(0, 100, 2, function(p22) -- Line: 76
        -- upvalues: u20 (copy), u21 (copy), u18 (copy)
        local v23 = p22 / 100;
        local v24 = math.cos(9.42477796076938 * (v23 + 0.25)) * (v23 - 1) / 0.707;
        local math_abs_ret = math.abs(v24);
        local v25 = u20:Lerp(u21, 1 - (1 - v23) ^ 5);
        u18:PivotTo(CFrame.new(v25.X, u21.Y + (u20.Y - u21.Y) * math_abs_ret, v25.Z) * v25.Rotation);
    end);
    BetterDebris:AddItem(u18, u18.Animation:GetAttribute("Duration"));
    task.spawn(CONSTANTS.IS_STUDIO and task.defer or pcall, function() -- Line: 88
        -- upvalues: u18 (copy), u13 (copy)
        u18.AnimationController:LoadAnimation(u18.Animation):Play();
        require(script[u13.SoundProfile])(u18);
    end);
    wait(u18.Animation:GetAttribute("RevealDelay"));
    local u26 = UnboxEffect:Clone();
    u26.CFrame = u21 + Vector3.new(0, 8, 0);
    u26.Parent = workspace;
    BetterDebris:AddItem(u26, 15);
    local BillboardGui = u26.BillboardGui;
    BillboardGui.Adornee = u26;
    BillboardGui.Parent = Players.LocalPlayer.PlayerGui;
    BetterDebris:AddItem(BillboardGui, 15);

    for _, v in pairs(p5) do
        local v27 = RewardSlot.new(v.RewardData, true);
        v27:SetInteractable(false);
        v27:SetParent(BillboardGui.Container);
    end;

    BillboardGui.Container.Size = UDim2.new(0.25, 0, 0.25, 0);
    BillboardGui.Container.Position = UDim2.new(0.5, 0, 0.75, 0);
    BillboardGui.Container:TweenSizeAndPosition(UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.5, true);
    local v28 = nil;
    local v29 = nil;

    if v11 then
        v28 = v11.Rarity;
        v29 = CosmeticLibrary.Rarities[v11.Rarity].Color;
    elseif v12 then
        local v30 = ItemLibrary.Items[v12.Name];
        v28 = v30 and v30.Status or "Standard";
        v29 = ItemLibrary.Statuses[v28].Color;
    end;

    if v28 and v29 then
        u26.Trail.Color = ColorSequence.new(v29);
        local v31 = u1[v28];

        if v31 then
            Utility:CreateSound(v31[1], v31[2] * (p8 == Players.LocalPlayer and 1 or 0.5), 1, u26, true);
        end;
    end;

    local Container = BillboardGui.Container;
    wait(4);

    if Container:IsDescendantOf(workspace) then
        Container:TweenSize(UDim2.new(0, 0, 0, 0), "In", "Back", 1, true);
    end;

    if not u7 then
        return;
    end;

    local CFrame2 = u26.CFrame;
    Utility:RenderstepForLoop(0, 100, 1.9, function(p32) -- Line: 153
        -- upvalues: TweenService (ref), u26 (copy), CFrame2 (copy), u7 (copy)
        local Value = TweenService:GetValue(p32 / 100, Enum.EasingStyle.Quint, Enum.EasingDirection.In);
        u26.CFrame = CFrame2:Lerp(u7.CFrame, Value);
    end);
    local v33 = Attachment:Clone();
    v33.Parent = u7;

    for _, child in pairs(v33:GetChildren()) do
        child:SetAttribute("IgnoreVisibilityCheck", true);
        child.Color = v29 and ColorSequence.new(v29) or child.Color;
    end;

    Utility:PlayParticles(v33);
    Utility:CreateSound("rbxassetid://109954155299965", 0.75, 1 + 0.25 * math.random(), u7, true);
    u26:Destroy();
    BillboardGui:Destroy();
end;