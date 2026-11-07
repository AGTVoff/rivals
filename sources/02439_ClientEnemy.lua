-- Instance: StarterPlayer.StarterPlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity.ClientEnemy
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
require(ReplicatedStorage.Modules.SoundLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientHumanoidEntity = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientEntity.ClientHumanoidEntity);
local Particles = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("ZombieSpawnEffect"):WaitForChild("Particles");
local u1 = setmetatable({}, ClientHumanoidEntity);
u1.__index = u1;

function u1.new(...) -- Line: 16
    -- upvalues: ClientHumanoidEntity (copy), u1 (copy)
    local v2 = ClientHumanoidEntity.new(...);
    local v3 = setmetatable(v2, u1);
    v3._run_track = nil;
    v3._idle_track = nil;
    v3._death_animation_override = false;
    v3._death_sound_override = false;
    v3:_Init();

    return v3;
end;

function u1.ReplicateFromServer(p4, p5, ...) -- Line: 33
    -- upvalues: Particles (copy), BetterDebris (copy), Utility (copy), ClientHumanoidEntity (copy)
    if p5 ~= "ZombieSpawn" then
        ClientHumanoidEntity.ReplicateFromServer(p4, p5, ...);

        return;
    end;

    p4:_PlayAnimation("ZombieSpawn");
    p4:_CreateSound("rbxassetid://109012456164853", 0.5 + 1 * math.random(), 0.875 + 0.25 * math.random());
    local v6 = Particles:Clone();
    v6.Parent = p4.Model:FindFirstChild("Head") or (p4.Model:FindFirstChild("UpperTorso") or p4.RootPart);
    BetterDebris:AddItem(v6, 10);
    Utility:PlayParticles(v6);
    wait(0.5);
    v6.LockedToPart = false;
end;

function u1._DelayedVisibility(p7) -- Line: 55
    local v8 = {};

    for _, descendant in pairs(p7.Model:GetDescendants()) do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
            table.insert(v8, descendant);
        end;
    end;

    for _, v in pairs(v8) do
        v.LocalTransparencyModifier = 1;
    end;

    wait(0.2);

    for _, v in pairs(v8) do
        v.LocalTransparencyModifier = 0;
    end;
end;

function u1._LoadAnimation(p9, p10) -- Line: 75
    if p10 then
        return p9.Humanoid:LoadAnimation(p9:_CreateAnimation(p10));
    end;

    return nil;
end;

function u1._VerifyIdleTrack(p11) -- Line: 79
    if p11._idle_track then
        p11._idle_track:Stop(0);
        p11._idle_track:Destroy();
        p11._idle_track = nil;
    end;

    if not p11:IsAlive() then
        return;
    end;

    p11._idle_track = p11:_LoadAnimation(p11:Get("IdleAnimation"));

    if not p11._idle_track then
        return;
    end;

    p11._idle_track:Play();
end;

function u1._VerifyRunTrack(p12) -- Line: 99
    if p12._run_track then
        p12._run_track:Stop(0);
        p12._run_track:Destroy();
        p12._run_track = nil;
    end;

    if not p12:IsAlive() then
        return;
    end;

    p12._run_track = p12:_LoadAnimation(p12:Get("RunAnimation"));

    if not p12._run_track then
        return;
    end;

    p12._run_track:AdjustWeight(0, 0);
end;

function u1._VerifyTracks(p13) -- Line: 119
    task.spawn(p13._VerifyRunTrack, p13);
    task.spawn(p13._VerifyIdleTrack, p13);
end;

function u1._Init(u14) -- Line: 124
    u14:GetDataChangedSignal("RunAnimation"):Connect(function() -- Line: 125
        -- upvalues: u14 (copy)
        u14:_VerifyRunTrack();
    end);
    u14:GetDataChangedSignal("IdleAnimation"):Connect(function() -- Line: 129
        -- upvalues: u14 (copy)
        u14:_VerifyIdleTrack();
    end);
    u14.Died:Connect(function() -- Line: 133
        -- upvalues: u14 (copy)
        u14:_VerifyTracks();
        local _ = u14._death_sound_override;
        local _ = u14._death_animation_override;
    end);

    if u14.Humanoid then
        u14.Humanoid.Running:Connect(function(p15) -- Line: 157
            -- upvalues: u14 (copy)
            if not (u14._run_track and u14:IsAlive()) then
                return;
            end;

            if not u14._run_track.IsPlaying then
                u14._run_track:Play();
            end;

            u14._run_track:AdjustWeight(p15 >= 0.5 and 1 or 0);
            u14._run_track:AdjustSpeed(p15 * 1.25 / 16 / (u14.RootPart.Size.Y / 2));
        end);
    end;

    u14:_VerifyTracks();
    task.defer(u14._DelayedVisibility, u14);
end;

return u1;