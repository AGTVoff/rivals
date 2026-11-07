-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.UserInterface.Equipment.Scene
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local FinisherPlayer = require(script:WaitForChild("FinisherPlayer"));
local EmotePlayer = require(script:WaitForChild("EmotePlayer"));
local UnlockModel = require(script:WaitForChild("UnlockModel"));
local EquipmentScenes = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("EquipmentScenes");
local u1 = { "Default", "Green Screen", "Pink Screen", "Blue Screen" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 19
    -- upvalues: u2 (copy), EquipmentScenes (copy), EventLibrary (copy), FinisherPlayer (copy), EmotePlayer (copy), UnlockModel (copy)
    local v4 = setmetatable({}, u2);
    v4.Equipment = p3;
    v4.Model = (EquipmentScenes:FindFirstChild(EventLibrary.LOBBY_VISUALS_PROFILE) or EquipmentScenes:WaitForChild("Default")):Clone();
    v4.FinisherPlayer = FinisherPlayer.new(v4);
    v4.EmotePlayer = EmotePlayer.new(v4);
    v4.UnlockModel = UnlockModel.new(v4);
    v4._textures_deleted = false;
    v4._backgrounds_folder = v4.Model:WaitForChild("Backgrounds");
    v4._hide_career_folder = v4._backgrounds_folder:WaitForChild("Default"):WaitForChild("HideCareer");
    v4._backgrounds = {};
    v4._dof = Instance.new("DepthOfFieldEffect");
    v4:_Init();

    return v4;
end;

function u2.GetCFrame(p5) -- Line: 43
    return p5.Model.Primary.CFrame;
end;

function u2.GetHumanoidCFrame(p6) -- Line: 47
    return p6.FinisherPlayer:GetHumanoidCFrame();
end;

function u2.OnOpen(p7, ...) -- Line: 51
    p7.Model.Parent = p7.Equipment.IsOpen and workspace or nil;
    p7:_UpdateDOF();
    p7.UnlockModel:OnOpen(...);
end;

function u2.OnCustomizingStateChanged(p8, ...) -- Line: 58
    p8.FinisherPlayer:OnCustomizingStateChanged(...);
    p8.EmotePlayer:OnCustomizingStateChanged(...);
end;

function u2.OnStateChanged(p9, ...) -- Line: 63
    p9.FinisherPlayer:OnStateChanged(...);
    p9.EmotePlayer:OnStateChanged(...);
    p9.UnlockModel:OnStateChanged(...);
end;

function u2._UpdateTextures(p10) -- Line: 73
    -- upvalues: PlayerDataController (copy), Utility (copy)
    if p10._textures_deleted or not PlayerDataController:GetSetting("Textures Disabled") then
        return;
    end;

    p10._textures_deleted = true;
    Utility:DisableTextures(p10.Model);
end;

function u2._UpdateDOF(p11) -- Line: 82
    -- upvalues: Lighting (copy)
    local _dof = p11._dof;
    local v12;

    if p11.Equipment.IsOpen and p11.Equipment:IsOpenEffectDone() ~= p11.Equipment.Camera:IsClosing() then
        v12 = Lighting or nil;
    else
        v12 = nil;
    end;

    _dof.Parent = v12;
end;

function u2._UpdateCareerFolder(p13) -- Line: 86
    local v14 = p13.Equipment:IsCareerPageOpen();
    local CustomizingType = p13.Equipment:GetCustomizingType();
    local v15;

    if v14 or (CustomizingType == "Finisher" and true or CustomizingType == "Emote") then
        v15 = nil;
    else
        v15 = p13._backgrounds.Default or nil;
    end;

    p13._hide_career_folder.Parent = v15;
end;

function u2._UpdateBackgroundFolder(p16) -- Line: 94
    -- upvalues: PlayerDataController (copy)
    local Setting = PlayerDataController:GetSetting("Equipment Background");

    for i, v in pairs(p16._backgrounds) do
        local v17;

        if i == Setting then
            v17 = p16._backgrounds_folder or nil;
        else
            v17 = nil;
        end;

        v.Parent = v17;
    end;
end;

function u2._Setup(p18) -- Line: 102
    -- upvalues: u1 (copy)
    for _, v in pairs(u1) do
        p18._backgrounds[v] = p18._backgrounds_folder:WaitForChild(v);
    end;

    p18._dof.FarIntensity = 0.75;
    p18._dof.FocusDistance = 0.05;
    p18._dof.InFocusRadius = 15;
    p18._dof.NearIntensity = 0;
    p18._dof.Name = "Equipment";
end;

function u2._Init(u19) -- Line: 114
    -- upvalues: PlayerDataController (copy)
    u19.Equipment.CareerPageOpened:Connect(function() -- Line: 115
        -- upvalues: u19 (copy)
        u19:_UpdateCareerFolder();
    end);
    u19.Equipment.CustomizingChanged:Connect(function() -- Line: 119
        -- upvalues: u19 (copy)
        u19:_UpdateCareerFolder();
    end);
    u19.Equipment.FinishedOpenEffect:Connect(function() -- Line: 123
        -- upvalues: u19 (copy)
        u19:_UpdateDOF();
    end);
    PlayerDataController:GetSettingChangedSignal("Equipment Background"):Connect(function() -- Line: 127
        -- upvalues: u19 (copy)
        u19:_UpdateBackgroundFolder();
    end);
    PlayerDataController:GetSettingChangedSignal("Textures Disabled"):Connect(function() -- Line: 131
        -- upvalues: u19 (copy)
        u19:_UpdateTextures();
    end);
    u19:_Setup();
    u19:_UpdateTextures();
    u19:_UpdateCareerFolder();
    u19:_UpdateBackgroundFolder();
end;

return u2;