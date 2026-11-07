-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.ClientReplicatedClasses.Enemies.ClientChombie
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local Spring = require(ReplicatedStorage.Modules.Spring);
local ClientEnemy = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy);
local ChombieEgg = Players.LocalPlayer.PlayerScripts.Assets.Misc.ChombieEgg;
local u1 = setmetatable({}, ClientEnemy);
u1.__index = u1;

function u1.new(...) -- Line: 14
    -- upvalues: ClientEnemy (copy), u1 (copy)
    local v2 = ClientEnemy.new(...);
    local v3 = setmetatable(v2, u1);
    v3._current_egg_thread = nil;
    v3._current_egg_model = nil;
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(p4, p5, ...) -- Line: 29
    -- upvalues: ClientEnemy (copy)
    if p5 ~= "ChombieEggPhase" then
        ClientEnemy.ReplicateFromServer(p4, p5, ...);

        return;
    end;

    if not p4:IsRendered() then
        return;
    end;

    p4._current_egg_thread = task.spawn(p4._EggPhase, p4, ...);
end;

function u1.Destroy(p6) -- Line: 41
    -- upvalues: ClientEnemy (copy)
    if p6._current_egg_thread then
        pcall(task.cancel, p6._current_egg_thread);
    end;

    ClientEnemy.Destroy(p6);
end;

function u1._BrokenEggEffect(p7) -- Line: 53
    -- upvalues: Utility (copy)
    if p7._current_egg_thread then
        pcall(task.cancel, p7._current_egg_thread);
    end;

    if not p7._current_egg_model then
        return;
    end;

    p7._current_egg_model:ScaleTo(p7._current_egg_model:GetScale() * 0.75);
    p7._current_egg_model.Full.Transparency = 1;
    p7._current_egg_model.Broken.Transparency = 0;
    Utility:CreateSound("rbxassetid://99730126765749", 1, 1 + 0.125 * math.random(), p7.RootPart, true, 10);
    wait(2);
    p7._current_egg_model.Broken.Anchored = false;
end;

function u1._EggPhase(p8, u9) -- Line: 73
    -- upvalues: ChombieEgg (copy), Spring (copy), RunService (copy), Utility (copy)
    local v10 = {};

    for _, descendant in pairs(p8.Model:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            descendant.LocalTransparencyModifier = 1;
            v10[descendant] = true;
        end;
    end;

    p8._current_egg_model = ChombieEgg:Clone();
    p8._current_egg_model.Parent = p8.Model;
    local u11 = Spring.new(0, 0.75, 10);
    local Scale = p8._current_egg_model:GetScale();
    local CFrame_identity = CFrame.identity;
    local u12 = 1;
    local u13 = 0;
    local u14 = tick();
    task.spawn(function() -- Line: 93
        -- upvalues: u14 (copy), u9 (copy), u13 (ref), u11 (copy), CFrame_identity (ref), u12 (ref)
        wait(1);

        while tick() < u14 + u9 - 0.5 do
            u13 = tick();
            u11.Value = 1;
            CFrame_identity = CFrame.Angles(0, 6.283185307179586 * math.random(), 0);
            u12 = -u12;
            local l_wait = wait;
            local v15 = (u14 + u9 - tick()) * 0.25;
            l_wait((math.min(1, v15)));
        end;
    end);

    while tick() < u14 + u9 do
        local v16 = (tick() - u14) / u9;
        local math_clamp_ret = math.clamp(v16, 0, 1);
        local v17 = (tick() - u13) / 0.5;
        local math_clamp_ret2 = math.clamp(v17, 0, 1);
        local v18 = (tick() - u14) / 1;
        local v19 = 1 - (1 - math.clamp(v18, 0, 1)) ^ 4;
        local v20 = p8.RootPart.CFrame * CFrame.new(0, -3, 0);
        local v21 = CFrame_identity * CFrame.Angles(0, 6.283185307179586 * math_clamp_ret2 * u12, 0);
        local CFrame_Angles_ret = CFrame.Angles(0, 0, 0.6108652381980153 * u11.Value);
        local v22 = Random.new():NextUnitVector() * 1 * math_clamp_ret ^ 8;
        p8._current_egg_model:ScaleTo(Scale * v19);
        p8._current_egg_model:PivotTo(v20 * v21 * CFrame_Angles_ret * v21:Inverse() + v22);
        RunService.RenderStepped:Wait();
    end;

    for i in pairs(v10) do
        i.LocalTransparencyModifier = 0;
    end;

    Utility:CreateSound("rbxassetid://94881601487773", 1, 1 + 0.125 * math.random(), p8.RootPart, true, 10);
    p8._current_egg_model:Destroy();
    p8._current_egg_model = nil;
end;

function u1._Init(u23) -- Line: 133
    u23.Died:Connect(function() -- Line: 134
        -- upvalues: u23 (copy)
        u23:_BrokenEggEffect();
    end);
end;

return u1;