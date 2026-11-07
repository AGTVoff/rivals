-- Instance: StarterPlayer.StarterPlayerScripts.Modules.ViewModels.Wildcat.Shadow Wildcat
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local WrapController = require(Players.LocalPlayer.PlayerScripts.Controllers.WrapController);
local Wildcat = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Wildcat);
local Attachment = Players.LocalPlayer.PlayerScripts.Assets.Misc.ShadowPoofEffect.Attachment;
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(255, 255, 255));
local u1 = setmetatable({}, Wildcat);
u1.__index = u1;

function u1.new(...) -- Line: 15
    -- upvalues: Wildcat (copy), u1 (copy)
    local v2 = Wildcat.new(...);
    local v3 = setmetatable(v2, u1);
    v3._state2_primary_part = v3.ItemModel:WaitForChild("ReloadWildcat"):WaitForChild("ReloadWildcatPrimary");
    v3._state1_primary_part = v3.ItemModel:WaitForChild("Body"):WaitForChild("BodyPrimary");
    v3._reparented_attachments = { v3._state1_primary_part:WaitForChild("_aim_lookat"), v3._state1_primary_part:WaitForChild("_aim_position"), v3._state1_primary_part:WaitForChild("_muzzle") };
    v3:_Init();

    return v3;
end;

function u1.GetFriendlyTracerColor(p4) -- Line: 31
    -- upvalues: ColorSequence_new_ret (copy)
    return ColorSequence_new_ret;
end;

function u1.PlayShadowPoofParticles(p5, p6, p7) -- Line: 35
    -- upvalues: Attachment (copy), BetterDebris (copy), Utility (copy), WrapController (copy)
    local v8;

    if p6 == 1 then
        v8 = p5._state1_primary_part;
    else
        v8 = p5._state2_primary_part;
    end;

    local v9 = Attachment:Clone();

    if p7 then
        v9.Parent = v8;
    else
        v9.Parent = p5.Model.HumanoidRootPart;
        v9.WorldCFrame = v8.CFrame * Attachment.CFrame;
    end;

    BetterDebris:AddItem(v9, 5);
    Utility:PlayParticles(v9);
    WrapController:ApplyWrap(WrapController:RecordOriginalWrapProperties(v9), p5.ClientItem:GetWrap(), true);
end;

function u1._UpdateAttachmentParents(p10) -- Line: 55
    local v11;

    if p10.ClientItem:Get("NumReloadsSoFar") % 2 + 1 == 1 then
        v11 = p10._state1_primary_part;
    else
        v11 = p10._state2_primary_part;
    end;

    for _, v in pairs(p10._reparented_attachments) do
        v.Parent = v11;
    end;
end;

function u1._Init(u12) -- Line: 64
    u12.ClientItem:GetDataChangedSignal("NumReloadsSoFar"):Connect(function() -- Line: 65
        -- upvalues: u12 (copy)
        u12:_UpdateAttachmentParents();
    end);
    task.defer(u12._UpdateAttachmentParents, u12);
end;

return u1;