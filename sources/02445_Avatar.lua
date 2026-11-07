-- Instance: StarterPlayer.StarterPlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientFighterCharacter.Avatar
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local DebugState = require(Players.LocalPlayer.PlayerScripts.Controllers.DebugController.DebugState);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local CameraController = require(Players.LocalPlayer.PlayerScripts.Controllers.CameraController);
local DefaultHeadMesh = Players.LocalPlayer.PlayerScripts.Assets.Misc.DefaultHeadMesh;
local u1 = { "rbxassetid://6686307858", "https://assetdelivery.roblox.com/v1/asset/?id=16673245747" };
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 15
    -- upvalues: u2 (copy), DefaultHeadMesh (copy)
    local v4 = setmetatable({}, u2);
    v4.ClientFighterCharacter = p3;
    v4._neck_rig_attachment = nil;
    v4._hat_attachment = nil;
    v4._is_head_too_big = nil;
    v4._is_custom_head_blacklisted = nil;
    v4._default_head_mesh = DefaultHeadMesh:Clone();
    v4._default_head_face = v4._default_head_mesh.Decal;
    v4._default_head_weld = nil;
    v4._accessory_meshes = {};
    v4._already_checked_accessory = {};
    v4._deleted_face_controls = false;
    v4._is_translucent = false;
    v4:_Init();

    return v4;
end;

function u2.SetTranslucent(p5, p6) -- Line: 41
    if p6 == p5._is_translucent then
        return;
    end;

    p5._is_translucent = p6;
    p5:_UpdateDefaultHead();
end;

function u2.Update(p7, p8, p9) -- Line: 50
end;

function u2.Destroy(p10) -- Line: 54
    p10._default_head_mesh:Destroy();
end;

function u2._IsLocalPlayer(p11) -- Line: 62
    return p11.ClientFighterCharacter.ClientFighter.IsLocalPlayer;
end;

function u2._IsInTransparencyContext(p12) -- Line: 70
    -- upvalues: DebugState (copy)
    local v13 = not p12:_IsLocalPlayer() and p12.ClientFighterCharacter.ClientFighter:Get("IsInDuel") and not DebugState:Get("DisableTransparentHats");

    return v13;
end;

function u2._IsHeadSizeDimensionTooBig(p14, p15) -- Line: 78
    local v16 = p15 / (p14.ClientFighterCharacter:Get("Scale") or 1) - 1;

    return math.abs(v16) > 0.25;
end;

function u2._DeleteFaceControls(u17) -- Line: 82
    if u17._deleted_face_controls or not u17.ClientFighterCharacter.ClientFighter:Get("IsInDuel") then
        return;
    end;

    u17._deleted_face_controls = true;
    task.spawn(function() -- Line: 89
        -- upvalues: u17 (copy)
        local v18;

        while true do
            v18 = u17.ClientFighterCharacter.Head:FindFirstChildOfClass("FaceControls");

            if v18 then
                break;
            end;

            u17.ClientFighterCharacter.Head.ChildAdded:Wait();
        end;

        task.defer(v18.Destroy, v18);
    end);
end;

function u2._UpdateDefaultHead(p19) -- Line: 106
    -- upvalues: DefaultHeadMesh (copy)
    if not p19.ClientFighterCharacter:IsAlive() then
        return;
    end;

    if p19._is_translucent or (p19.ClientFighterCharacter.ClientFighter:Get("IsHiddenByEmotes") or p19.ClientFighterCharacter.ClientFighter:Get("IsHiddenByCutscene")) then
        p19._default_head_mesh.Transparency = 1;
        p19._default_head_face.Transparency = 1;

        return;
    end;

    local v20 = p19:_IsInTransparencyContext() and (p19._is_custom_head_blacklisted or (p19:_IsHeadSizeDimensionTooBig(p19.ClientFighterCharacter.Head.Size.X) or p19:_IsHeadSizeDimensionTooBig(p19.ClientFighterCharacter.Head.Size.Y) or (p19:_IsHeadSizeDimensionTooBig(p19.ClientFighterCharacter.Head.Size.Z) or p19:_IsHeadSizeDimensionTooBig((math.abs(p19._hat_attachment.WorldPosition.Y - p19._neck_rig_attachment.WorldPosition.Y))))));
    local v21 = v20 == p19._is_head_too_big;
    p19._is_head_too_big = v20;
    local v22 = p19.ClientFighterCharacter.ClientFighter:IsActuallyFirstPerson();
    p19.ClientFighterCharacter.Head.LocalTransparencyModifier = v22 and 1 or (p19._is_head_too_big and 1 or 0);
    p19._default_head_mesh.Transparency = v22 and 1 or (p19._is_head_too_big and 0 or 1);
    p19._default_head_face.Transparency = p19._default_head_mesh.Transparency;
    p19._default_head_weld.Enabled = false;
    p19._default_head_mesh.Size = DefaultHeadMesh.Size * (p19.ClientFighterCharacter:Get("Scale") or 1);
    p19._default_head_mesh.CFrame = p19._neck_rig_attachment.WorldCFrame * CFrame.new(0, p19._default_head_mesh.Size.Y / 2, 0);
    p19._default_head_weld.Enabled = true;

    if not v21 then
        p19:_BulkUpdateAccessoryMeshes();
    end;
end;

function u2._BulkUpdateAccessoryMeshes(p23) -- Line: 146
    for i in pairs(p23._accessory_meshes) do
        p23:_UpdateAccessoryMesh(i);
    end;
end;

function u2._UpdateAccessoryMesh(p24, p25) -- Line: 152
    local v26 = p24._accessory_meshes[p25];

    if not v26 then
        return;
    end;

    local v27 = 3 * (p24.ClientFighterCharacter:Get("Scale") or 1);
    local v28 = p24._is_head_too_big and not p24._is_custom_head_blacklisted and 0.875 or (((v27 < p25.Size.X or v27 < p25.Size.Y) and true or v27 < p25.Size.Z) and p24:_IsInTransparencyContext() and 0.875 or 0);
    p25.Transparency = v26.OriginalTransparency + (1 - v26.OriginalTransparency) * v28;
end;

function u2._AccessoryMeshAdded(u29, u30) -- Line: 168
    if not u30:IsA("BasePart") then
        return;
    end;

    u29._accessory_meshes[u30] = u29._accessory_meshes[u30] or {
        OriginalTransparency = u30.Transparency
    };
    u30:GetPropertyChangedSignal("Size"):Connect(function() -- Line: 175
        -- upvalues: u29 (copy), u30 (copy)
        u29:_UpdateAccessoryMesh(u30);
    end);
    u29:_UpdateAccessoryMesh(u30);
end;

function u2._AccessoryAdded(u31, p32) -- Line: 182
    if not p32:IsA("Accessory") or u31._already_checked_accessory[p32] then
        return;
    end;

    if u31:_IsLocalPlayer() then
        return;
    end;

    u31._already_checked_accessory[p32] = true;
    p32.ChildAdded:Connect(function(p33) -- Line: 193
        -- upvalues: u31 (copy)
        u31:_AccessoryMeshAdded(p33);
    end);

    for _, child in pairs(p32:GetChildren()) do
        u31:_AccessoryMeshAdded(child);
    end;
end;

function u2._SetupAsync(u34) -- Line: 202
    -- upvalues: u1 (copy), DebugState (copy), CameraController (copy), SpectateController (copy)
    u34.ClientFighterCharacter:WaitUntilIsInWorld();
    u34._neck_rig_attachment = u34.ClientFighterCharacter.Head:WaitForChild("NeckRigAttachment");
    u34._hat_attachment = u34.ClientFighterCharacter.Head:WaitForChild("HatAttachment");
    u34._is_custom_head_blacklisted = table.find(u1, u34.ClientFighterCharacter.Head.MeshId);
    u34._default_head_mesh.Color = u34.ClientFighterCharacter.Head.Color;
    u34._default_head_mesh.Parent = u34.ClientFighterCharacter.Head;
    u34._default_head_weld = Instance.new("WeldConstraint");
    u34._default_head_weld.Part0 = u34.ClientFighterCharacter.Head;
    u34._default_head_weld.Part1 = u34._default_head_mesh;
    u34._default_head_weld.Parent = u34._default_head_mesh;
    u34.ClientFighterCharacter:GetDataChangedSignal("Scale"):Connect(function() -- Line: 218
        -- upvalues: u34 (copy)
        u34:_UpdateDefaultHead();
    end);
    u34.ClientFighterCharacter.Head:GetPropertyChangedSignal("Size"):Connect(function() -- Line: 222
        -- upvalues: u34 (copy)
        u34:_UpdateDefaultHead();
    end);
    u34.ClientFighterCharacter.Head:GetPropertyChangedSignal("Transparency"):Connect(function() -- Line: 226
        -- upvalues: u34 (copy)
        u34:_UpdateDefaultHead();
    end);
    u34.ClientFighterCharacter.Head:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function() -- Line: 230
        -- upvalues: u34 (copy)
        u34:_UpdateDefaultHead();
    end);
    u34._default_head_mesh:GetPropertyChangedSignal("Transparency"):Connect(function() -- Line: 234
        -- upvalues: u34 (copy)
        u34:_UpdateDefaultHead();
    end);
    u34._default_head_mesh:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function() -- Line: 238
        -- upvalues: u34 (copy)
        u34:_UpdateDefaultHead();
    end);
    u34.ClientFighterCharacter.Model.ChildAdded:Connect(function(p35) -- Line: 242
        -- upvalues: u34 (copy)
        if not u34.ClientFighterCharacter:IsAlive() then
            return;
        end;

        u34:_AccessoryAdded(p35);
    end);
    u34.ClientFighterCharacter:AddConnection(DebugState:GetDataChangedSignal("DisableTransparentHats"):Connect(function() -- Line: 250
        -- upvalues: u34 (copy)
        u34:_BulkUpdateAccessoryMeshes();
        u34:_UpdateDefaultHead();
    end));
    u34.ClientFighterCharacter:AddConnection(u34.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 255
        -- upvalues: u34 (copy)
        u34:_BulkUpdateAccessoryMeshes();
        u34:_UpdateDefaultHead();
        u34:_DeleteFaceControls();
    end));
    u34.ClientFighterCharacter:AddConnection(u34.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsSpectating"):Connect(function() -- Line: 261
        -- upvalues: u34 (copy)
        u34:_UpdateDefaultHead();
    end));
    u34.ClientFighterCharacter:AddConnection(u34.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsHiddenByEmotes"):Connect(function() -- Line: 265
        -- upvalues: u34 (copy)
        u34:_UpdateDefaultHead();
    end));
    u34.ClientFighterCharacter:AddConnection(u34.ClientFighterCharacter.ClientFighter:GetDataChangedSignal("IsHiddenByCutscene"):Connect(function() -- Line: 269
        -- upvalues: u34 (copy)
        u34:_UpdateDefaultHead();
    end));
    u34.ClientFighterCharacter:AddConnection(CameraController.StateChanged:Connect(function() -- Line: 273
        -- upvalues: u34 (copy)
        u34:_UpdateDefaultHead();
    end));
    u34.ClientFighterCharacter:AddConnection(SpectateController.SubjectEmoteStatusChanged:Connect(function() -- Line: 277
        -- upvalues: u34 (copy)
        u34:_UpdateDefaultHead();
    end));

    for _, child in pairs(u34.ClientFighterCharacter.Model:GetChildren()) do
        u34:_AccessoryAdded(child);
    end;

    u34:_UpdateDefaultHead();
    u34:_DeleteFaceControls();
end;

function u2._Init(p36) -- Line: 289
    task.spawn(p36._SetupAsync, p36);
end;

return u2;