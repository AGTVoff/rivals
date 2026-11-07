-- Instance: StarterPlayer.StarterPlayerScripts.Modules.ClientReplicatedClasses.Enemies.ClientStoredMonster
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientCustomEntity = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientCustomEntity);
local u1 = setmetatable({}, ClientCustomEntity);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: ClientCustomEntity (copy), u1 (copy)
    local v2 = ClientCustomEntity.new(...);
    local v3 = setmetatable(v2, u1);
    v3._original_cframe_before_shaking = nil;
    v3._death_vfx = v3.Model:FindFirstChild("DeathVFX", true);
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(p4, p5, ...) -- Line: 27
    -- upvalues: RunService (copy), ClientCustomEntity (copy)
    if p5 == "StoredMonsterDieOnPresence" then
        if not p4:IsRendered() then
            return;
        end;

        local Pivot = p4.Model:GetPivot();
        local Random_new_ret = Random.new();
        local v6 = tick();
        p4._original_cframe_before_shaking = p4.RootPart.CFrame;
        local v7 = ...;

        while not p4._destroyed and p4.RootPart:IsDescendantOf(workspace) do
            local v8 = (tick() - v6) / v7;
            local math_min_ret = math.min(1, v8);
            local v9 = Random_new_ret:NextUnitVector() * Vector3.new(1, 0, 1) * math_min_ret ^ 4;
            p4.Model:PivotTo(Pivot + v9);
            RunService.RenderStepped:Wait();
        end;
    else
        ClientCustomEntity.ReplicateFromServer(p4, p5, ...);
    end;
end;

function u1._PlayDeathVFX(p10) -- Line: 57
    -- upvalues: BetterDebris (copy), Utility (copy)
    if not p10._death_vfx then
        return;
    end;

    local Part = Instance.new("Part");
    Part.CFrame = p10._original_cframe_before_shaking or p10.RootPart.CFrame;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0, 0, 0);
    Part.Parent = workspace;
    BetterDebris:AddItem(Part, 10);
    p10._death_vfx.Parent = Part;
    Utility:PlayParticles(p10._death_vfx);
end;

function u1._Init(u11) -- Line: 77
    u11.Died:Connect(function() -- Line: 78
        -- upvalues: u11 (copy)
        u11:_PlayDeathVFX();
    end);
end;

return u1;