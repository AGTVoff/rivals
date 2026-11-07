-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.Maps.BaseTower
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientMap = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientDuel.ClientMap);
local CutsceneLogic = require(script:WaitForChild("CutsceneLogic"));
local ZombieTowerLadderGui = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ZombieTowerLadderGui");
local u1 = setmetatable({}, ClientMap);
u1.__index = u1;

function u1.new(...) -- Line: 16
    -- upvalues: ClientMap (copy), u1 (copy), CutsceneLogic (copy), ZombieTowerLadderGui (copy)
    local v2 = ClientMap.new(...);
    local v3 = setmetatable(v2, u1);
    v3.CutsceneLogic = CutsceneLogic.new(v3);
    v3._floors_folder = v3.Model:WaitForChild("Floors");
    v3._spectating_thread = nil;
    v3._flashing_red_enemies_connection = nil;
    v3._ladder_guide_bbg = ZombieTowerLadderGui:Clone();
    v3._active_enemy_humanoids = {};
    v3:_Init();

    return v3;
end;

function u1.GetFloorNumberFromPosition(p4, p5) -- Line: 36
    -- upvalues: Utility (copy)
    local v6 = p5 or workspace.CurrentCamera.CFrame.Position;

    for _, child in pairs(p4._floors_folder:GetChildren()) do
        local v7 = child;

        for _, v in pairs(child:FindFirstChild("Important") and (child.Important:GetChildren() or {}) or {}) do
            if v.Name == "Volume" and Utility:IsWithinPart(v, v6) then
                return tonumber(v7.Name);
            end;
        end;
    end;
end;

function u1.GetScoreboardDisplay(p8) -- Line: 48
    local FloorNumberFromPosition = p8:GetFloorNumberFromPosition();

    return p8.Name .. (not FloorNumberFromPosition and "" or "   •   Floor " .. FloorNumberFromPosition);
end;

function u1.ReplicateFromServer(p9, p10, ...) -- Line: 55
    -- upvalues: ClientMap (copy)
    if p10 ~= "StopCutsceneNow" then
        ClientMap.ReplicateFromServer(p9, p10, ...);

        return;
    end;

    if not p9:IsRendered() then
        return;
    end;

    p9.CutsceneLogic:StopCutscene();
end;

function u1.Destroy(p11) -- Line: 67
    -- upvalues: ClientMap (copy)
    if p11._spectating_thread then
        task.cancel(p11._spectating_thread);
        p11._spectating_thread = nil;
    end;

    if p11._flashing_red_enemies_connection then
        p11._flashing_red_enemies_connection:Disconnect();
        p11._flashing_red_enemies_connection = nil;
    end;

    p11.CutsceneLogic:Destroy();
    ClientMap.Destroy(p11);
end;

function u1._FloorAdded(u12, p13) -- Line: 87
    local MobGroups = p13:WaitForChild("MobGroups");

    local function humanoid_added(u14) -- Line: 90
        -- upvalues: u12 (copy)
        local u15 = {
            StartFlashingRed = 0,
            Highlight = nil
        };
        u14.HealthChanged:Connect(function() -- Line: 96, Name: reset
            -- upvalues: u15 (copy)
            u15.StartFlashingRed = tick() + 60;

            if u15.Highlight then
                u15.Highlight:Destroy();
                u15.Highlight = nil;
            end;
        end);
        u15.StartFlashingRed = tick() + 60;

        if u15.Highlight then
            u15.Highlight:Destroy();
            u15.Highlight = nil;
        end;

        u12._active_enemy_humanoids[u14] = u15;
        u14.Destroying:Connect(function() -- Line: 110
            -- upvalues: u12 (ref), u14 (copy)
            u12._active_enemy_humanoids[u14] = nil;
        end);
    end;

    local function object_value_added(u16) -- Line: 115
        -- upvalues: humanoid_added (copy)
        local u17 = false;

        local function check() -- Line: 118
            -- upvalues: u17 (ref), u16 (copy), humanoid_added (ref)
            if u17 then
                return;
            end;

            if not u16.Value then
                return;
            end;

            u17 = true;
            task.spawn(humanoid_added, u16.Value);
        end;

        u16:GetPropertyChangedSignal("Value"):Connect(check);

        if not u17 and u16.Value then
            u17 = true;
            task.spawn(humanoid_added, u16.Value);
        end;
    end;

    local function mob_group_added(p18) -- Line: 135
        -- upvalues: object_value_added (copy)
        local EntityHumanoidObjectValues = p18:WaitForChild("EntityHumanoidObjectValues", 3);

        if not EntityHumanoidObjectValues then
            return;
        end;

        EntityHumanoidObjectValues.ChildAdded:Connect(object_value_added);

        for _, child in pairs(EntityHumanoidObjectValues:GetChildren()) do
            task.spawn(object_value_added, child);
        end;
    end;

    MobGroups.ChildAdded:Connect(mob_group_added);

    for _, child in pairs(MobGroups:GetChildren()) do
        task.spawn(mob_group_added, child);
    end;

    if (tonumber(p13.Name) or 0) > 2 then
        task.delay(1, u12.CreateSound, u12, "rbxassetid://1843115730", 2, 1, p13:WaitForChild("Important"):WaitForChild("Entrance"), true, 10, 400, 400);
    end;
end;

function u1._UpdateLadderGuide(p19) -- Line: 161
end;

function u1._UpdateLightingChange(p20) -- Line: 174
    -- upvalues: Utility (copy)
    local LightingParts = p20.Model:FindFirstChild("LightingParts");
    local v21 = nil;

    for _, v in pairs(LightingParts and LightingParts:GetChildren() or {}) do
        if Utility:IsWithinPart(v, workspace.CurrentCamera.CFrame.Position) then
            v21 = v;
            break;
        end;
    end;

    local v22 = v21 and v21:GetAttribute("LightingProfileOverride") or nil;

    if v22 ~= p20:Get("LightingProfileOverride") then
        p20:SetReplicate("LightingProfileOverride", v22);
    end;
end;

function u1._VerifySpectatingThread(u23) -- Line: 192
    if u23._spectating_thread then
        task.cancel(u23._spectating_thread);
        u23._spectating_thread = nil;
    end;

    if not u23.ClientDuel:Get("IsSpectating") then
        return;
    end;

    u23._spectating_thread = task.spawn(function() -- Line: 202
        -- upvalues: u23 (copy)
        while true do
            u23:_UpdateLightingChange();
            u23:_UpdateLadderGuide();
            wait(1);
        end;
    end);
end;

function u1._VerifyFlashingRedEnemiesConnection(u24) -- Line: 211
    -- upvalues: RunService (copy)
    if u24._flashing_red_enemies_connection then
        u24._flashing_red_enemies_connection:Disconnect();
        u24._flashing_red_enemies_connection = nil;
    end;

    if u24._destroyed or not u24.ClientDuel:Get("IsSpectating") then
        return;
    end;

    u24._flashing_red_enemies_connection = RunService.RenderStepped:Connect(function() -- Line: 221
        -- upvalues: u24 (copy)
        local v25 = 3.141592653589793 * tick();
        local math_sin_ret = math.sin(v25);
        local math_max_ret = math.max(0, math_sin_ret);

        for i, v in pairs(u24._active_enemy_humanoids) do
            if tick() >= v.StartFlashingRed then
                if not v.Highlight then
                    v.Highlight = Instance.new("Highlight");
                    v.Highlight.FillColor = Color3.fromRGB(255, 0, 0);
                    v.Highlight.OutlineColor = Color3.fromRGB(255, 0, 0);
                    v.Highlight.Adornee = i.Parent;
                    v.Highlight.Name = "FlashingRed";
                    v.Highlight.Parent = i;
                end;

                v.Highlight.OutlineTransparency = math_max_ret * 1 + 0;
                v.Highlight.FillTransparency = math_max_ret * 0.125 + 0.875;
            end;
        end;
    end);
end;

function u1._Init(u26) -- Line: 244
    u26._floors_folder.ChildAdded:Connect(function(p27) -- Line: 245
        -- upvalues: u26 (copy)
        u26:_FloorAdded(p27);
    end);
    local _connections = u26._connections;
    local DataChangedSignal = u26.ClientDuel:GetDataChangedSignal("IsSpectating");
    table.insert(_connections, DataChangedSignal:Connect(function() -- Line: 249
        -- upvalues: u26 (copy)
        task.spawn(u26._VerifySpectatingThread, u26);
        u26:_VerifyFlashingRedEnemiesConnection();
    end));

    for _, child in pairs(u26._floors_folder:GetChildren()) do
        task.spawn(u26._FloorAdded, u26, child);
    end;

    u26:_Setup();
    u26:_VerifyFlashingRedEnemiesConnection();
    task.spawn(u26._VerifySpectatingThread, u26);
end;

return u1;