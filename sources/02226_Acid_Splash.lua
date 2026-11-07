-- Instance: ReplicatedStorage .Modules.Finishers.Acid Splash
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Ragdoll = require(ReplicatedStorage.Modules.Finishers.Ragdoll);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = setmetatable({}, Ragdoll);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: Ragdoll (copy), u1 (copy)
    local v2 = Ragdoll.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayClient(p4, ...) -- Line: 21
    -- upvalues: Ragdoll (copy), Utility (copy)
    Ragdoll.PlayClient(p4, ...);

    for _, v in pairs(p4:_GetObjects(true)) do
        if v:IsA("BasePart") then
            v.Color = Color3.fromRGB(255, 255, 255);
            v.Material = Enum.Material.SmoothPlastic;
            v.MaterialVariant = "";

            if v:IsA("MeshPart") then
                v.TextureID = "";
            end;
        elseif v:IsA("ParticleEmitter") or (v:IsA("Beam") or (v:IsA("Trail") or (v:IsA("Texture") or (v:IsA("Decal") or (v:IsA("Clothing") or (v:IsA("ShirtGraphic") or v:IsA("Accessory"))))))) then
            v:Destroy();
        end;
    end;

    local v5 = script.Particles.Attachment:Clone();
    v5.Parent = p4._is_humanoid and p4._subject.RootPart or p4._subject;
    table.insert(p4._destroy_these, v5);
    Utility:PlayParticles(v5);

    if p4._is_humanoid then
        local v6 = script.Face:Clone();
        local v7 = p4._subject.Parent and p4._subject.Parent:FindFirstChild("Head");
        v6.Parent = v7;
        table.insert(p4._destroy_these, v6);
    end;

    p4:CreateSound("rbxassetid://79150386787758", 1.5, 1 + 0.1 * math.random(), nil, true, 5);
    p4:CreateSound("rbxassetid://125902611007483", 1.25, 1 + 0.1 * math.random(), nil, true, 5);
end;

function u1._Init(p8) -- Line: 58
end;

return u1;