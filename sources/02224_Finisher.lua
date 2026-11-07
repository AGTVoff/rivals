-- Instance: ReplicatedStorage .Modules.Finisher
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerStorage = game:GetService("ServerStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local TestLibrary = require(ReplicatedStorage.Modules.TestLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = CONSTANTS.IS_SERVER and require(ServerStorage.Services.CollisionsService);

if CONSTANTS.IS_CLIENT then
    require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
end;

local u2 = CONSTANTS.IS_CLIENT and require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local TestAttribute = TestLibrary:GetTestAttribute("StudioPing");
local IS_STUDIO = CONSTANTS.IS_STUDIO;
local u3 = {};
u3.__index = u3;

function u3.new(p4, p5, p6) -- Line: 21
    -- upvalues: u3 (copy)
    local v7;

    if typeof(p4) == "Instance" then
        v7 = p4:IsA("Humanoid") or p4:IsA("BasePart");
    else
        v7 = false;
    end;

    assert(v7, "Argument 1 invalid, expected a Humanoid or BasePart");
    local v8 = setmetatable({}, u3);
    v8._subject = p4;
    v8._is_humanoid = v8._subject:IsA("Humanoid");
    v8._is_final_finisher = p5;
    v8._eliminator = p6;
    v8._anchor_model_hash = 0;
    v8._destroy_these = {};
    v8._connections = {};
    v8._threads = {};
    v8._destroyed = false;
    v8._serial = nil;
    v8._seed = math.random(1, 1000000);
    v8._original_collision_groups = {};
    v8._ragdolled = false;
    v8:_Init();

    return v8;
end;

function u3.CreateSound(p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19) -- Line: 49
    -- upvalues: Utility (copy)
    if not p13 then
        p13 = p9._is_humanoid and p9._subject.RootPart;
    end;

    local v20 = Utility:CreateSound(p10, p11, p12, p13, p14, p15, p16, p17, p9:_GetSoundGroup(), p19);
    table.insert(p9._destroy_these, v20);

    return v20;
end;

function u3.Simulate(u21, u22) -- Line: 58
    -- upvalues: IS_STUDIO (copy), TestAttribute (copy)
    local BindableEvent = Instance.new("BindableEvent");
    table.insert(u21._destroy_these, BindableEvent);
    local u23 = 0;
    task.spawn(function() -- Line: 64
        -- upvalues: u21 (copy), u22 (copy), IS_STUDIO (ref), u23 (ref), BindableEvent (copy)
        local success, result = pcall(u21.PlayServer, u21, true);

        if not success and u22 then
            u22(result);
        end;

        if not success and IS_STUDIO then
            error(result);
        end;

        u23 = u23 + 1;
        BindableEvent:Fire();
    end);
    task.spawn(function() -- Line: 79
        -- upvalues: TestAttribute (ref), u21 (copy), u22 (copy), IS_STUDIO (ref), u23 (ref), BindableEvent (copy)
        if TestAttribute and TestAttribute > 0 then
            wait(TestAttribute / 1000);
        end;

        local success, result = pcall(u21.PlayClient, u21, true);

        if not success and u22 then
            u22(result);
        end;

        if not success and IS_STUDIO then
            error(result);
        end;

        u23 = u23 + 1;
        BindableEvent:Fire();
    end);

    while u23 < 2 do
        BindableEvent.Event:Wait();
    end;
end;

function u3.PlayServer(p24, p25) -- Line: 103
end;

function u3.PlayClient(p26, p27) -- Line: 107
end;

function u3.SetSerial(p28, p29) -- Line: 111
    p28._serial = p29;
end;

function u3.Serialize(p30) -- Line: 115
    return {
        Seed = p30._seed
    };
end;

function u3.Destroy(p31) -- Line: 123
    p31._destroyed = true;

    for _, v in pairs(p31._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p31._destroy_these) do
        v:Destroy();
    end;

    for _, v in pairs(p31._threads) do
        pcall(task.cancel, v);
    end;
end;

function u3._SetupProp(p32, u33) -- Line: 143
    if p32._is_humanoid then
        local function get_motor6d(p34) -- Line: 148
            -- upvalues: u33 (copy)
            for _, child in pairs(u33:GetChildren()) do
                if child.Name == p34 and child:IsA("Motor6D") then
                    return child;
                end;
            end;
        end;

        local v35 = {};

        for _, child in pairs(u33:GetChildren()) do
            if child:IsA("BasePart") then
                local v36 = child:Clone();
                table.insert(p32._destroy_these, v36);
                local v37 = get_motor6d(v36.Name):Clone();
                table.insert(p32._destroy_these, v37);
                v37.Part1 = v36;
                v37.Part0 = p32._subject.RootPart;
                v37:SetAttribute("IgnoreWhenRagdolling", true);
                v37.Parent = p32._subject.RootPart;

                local function format(p38) -- Line: 174
                    if not p38:IsA("BasePart") then
                        return;
                    end;

                    p38.CanCollide = false;
                    p38.CanTouch = false;
                    p38.CanQuery = false;
                    p38.Massless = true;
                end;

                for _, descendant in pairs(v36:GetDescendants()) do
                    if descendant:IsA("BasePart") then
                        descendant.CanCollide = false;
                        descendant.CanTouch = false;
                        descendant.CanQuery = false;
                        descendant.Massless = true;
                    end;
                end;

                if v36:IsA("BasePart") then
                    v36.CanCollide = false;
                    v36.CanTouch = false;
                    v36.CanQuery = false;
                    v36.Massless = true;
                end;

                v36:PivotTo(p32._subject.RootPart.CFrame);
                v36.Parent = p32._subject.Parent;

                for _, descendant in pairs(v36:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:SetAttribute("IgnoreVisibilityCheck", true);
                    end;
                end;

                table.insert(v35, v36);
            end;
        end;

        return table.unpack(v35);
    end;
end;

function u3._GetSoundGroup(p39) -- Line: 206
    -- upvalues: u2 (copy)
    local v40;

    if typeof(p39._eliminator) == "Instance" then
        v40 = p39._eliminator;
    else
        v40 = false;
    end;

    return v40 and v40 ~= (u2 and u2.CurrentSubject and u2.CurrentSubject.Player) and "FinisherFromOthers" or "Finisher";
end;

function u3._GetGroundPosition(p41, p42, p43) -- Line: 213
    -- upvalues: Utility (copy)
    return Utility:Raycast(p42, p42 + Vector3.new(0, -100, 0), 100, p43, Enum.RaycastFilterType.Exclude).Position;
end;

function u3._HideBody(p44, p45) -- Line: 217
    for _, v in pairs(p44:_GetObjects(true)) do
        if not (p45 and table.find(p45, v)) then
            if v:IsA("BasePart") then
                v.Transparency = 1;
                v.Size = Vector3.new(0, 0, 0);
            elseif v ~= p44._subject then
                v:Destroy();
            end;
        end;
    end;
end;

function u3._GetObjects(p46, p47) -- Line: 232
    return p46._is_humanoid and (not p46._subject.Parent and {} or p46._subject.Parent[p47 and "GetDescendants" or "GetChildren"](p46._subject.Parent)) or { p46._subject };
end;

function u3._SetAnimationConstraintsEnabled(p48, p49) -- Line: 236
    p48._are_animation_constraints_enabled = p49;

    for _, descendant in pairs(p48._subject.Parent:GetDescendants()) do
        if descendant:IsA("AnimationConstraint") then
            descendant.Enabled = p48._are_animation_constraints_enabled;
        end;
    end;
end;

function u3._IsBodyMotor6D(p50, p51) -- Line: 246
    local v52 = p51:IsA("Motor6D") and not p51:GetAttribute("IgnoreWhenRagdolling");

    return v52;
end;

function u3._BreakJoints(u53) -- Line: 250
    if not (u53._is_humanoid and u53._subject.Parent) then
        return;
    end;

    for _, descendant in pairs(u53._subject.Parent:GetDescendants()) do
        if u53:_IsBodyMotor6D(descendant) then
            descendant.Part0 = nil;
            descendant.Part1 = nil;
            descendant:Destroy();
        elseif descendant:IsA("MeshPart") then
            descendant.AssemblyLinearVelocity = u53._subject.RootPart.AssemblyLinearVelocity;
            descendant.AssemblyAngularVelocity = u53._subject.RootPart.AssemblyAngularVelocity;

            if descendant.Name == "Head" and descendant.Parent == u53._subject.Parent then
                descendant.CanCollide = true;
            end;
        end;
    end;

    u53._subject.Parent.DescendantAdded:Connect(function(p54) -- Line: 270
        -- upvalues: u53 (copy)
        if not u53:_IsBodyMotor6D(p54) then
            return;
        end;

        p54.Part0 = nil;
        p54.Part1 = nil;
        task.defer(p54.Destroy, p54);
    end);
end;

function u3._AnchorModel(u55, p56, p57) -- Line: 281
    -- upvalues: u1 (copy)
    u55._anchor_model_hash = u55._anchor_model_hash + 1;
    local _anchor_model_hash = u55._anchor_model_hash;

    if not u55._is_humanoid then
        return;
    end;

    local v58 = p56 or 3;
    local u59 = p57 == nil and true or p57;

    local function anchor() -- Line: 292
        -- upvalues: u55 (copy), _anchor_model_hash (copy), u1 (ref), u59 (copy)
        if not u55._subject.Parent or _anchor_model_hash ~= u55._anchor_model_hash then
            return;
        end;

        for _, descendant in pairs(u55._subject.Parent:GetDescendants()) do
            if descendant:IsA("BasePart") then
                if u1 then
                    u1:ClearSetDescendantsLogic(descendant, true);
                end;

                u55._original_collision_groups[descendant] = u55._original_collision_groups[descendant] or descendant.CollisionGroup;
                descendant.CollisionGroup = u59 and "Noclip" or (u55._original_collision_groups[descendant] or descendant.CollisionGroup);
                descendant.Anchored = u59;
            end;
        end;
    end;

    if v58 <= 0 then
        task.spawn(anchor);

        return;
    end;

    task.delay(v58 or 3, anchor);
end;

function u3._Ragdoll(u60) -- Line: 319
    if not (u60._is_humanoid and u60._subject.Parent) then
        return;
    end;

    u60._ragdolled = true;
    u60:_SetAnimationConstraintsEnabled(false);

    for _, descendant in pairs(u60._subject.Parent:GetDescendants()) do
        if u60:_IsBodyMotor6D(descendant) then
            local Attachment = Instance.new("Attachment");
            Attachment.CFrame = descendant.C0;
            Attachment.Name = descendant.Name .. " - A0";
            Attachment.Parent = descendant.Part0;
            local Attachment2 = Instance.new("Attachment");
            Attachment2.CFrame = descendant.C1;
            Attachment2.Name = descendant.Name .. " - A1";
            Attachment2.Parent = descendant.Part1;
            local BallSocketConstraint = Instance.new("BallSocketConstraint");
            BallSocketConstraint.Attachment0 = Attachment;
            BallSocketConstraint.Attachment1 = Attachment2;
            BallSocketConstraint.Name = "RagdollBSC";
            BallSocketConstraint.LimitsEnabled = true;
            BallSocketConstraint.TwistLimitsEnabled = true;
            BallSocketConstraint.MaxFrictionTorque = 10;
            BallSocketConstraint.Parent = descendant.Part0;
            descendant:Destroy();
        end;
    end;

    u60._subject.Parent.DescendantAdded:Connect(function(p61) -- Line: 354
        -- upvalues: u60 (copy)
        if u60:_IsBodyMotor6D(p61) then
            task.defer(p61.Destroy, p61);
        end;
    end);
end;

function u3._InternalThread(p62, u63, ...) -- Line: 361
    -- upvalues: IS_STUDIO (copy)
    local u64 = nil;

    if IS_STUDIO then
        u64 = u63(...);
    else
        pcall(function(...) -- Line: 367
            -- upvalues: u64 (ref), u63 (copy)
            u64 = u63(...);
        end, ...);
    end;

    table.insert(p62._threads, u64);

    return u64;
end;

function u3._Setup(u65) -- Line: 377
    -- upvalues: CONSTANTS (copy)
    if not (u65._is_humanoid and CONSTANTS.IS_SERVER) then
        return;
    end;

    for _, descendant in pairs(u65._subject.Parent:GetDescendants()) do
        if descendant:IsA("AnimationConstraint") then
            descendant:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 385
                -- upvalues: descendant (copy), u65 (copy)
                descendant.Enabled = u65._are_animation_constraints_enabled;
            end);
        end;
    end;

    for _, child in pairs(u65._subject:GetChildren()) do
        if child:IsA("NumberValue") then
            task.defer(child.Destroy, child);
        end;
    end;
end;

function u3._Init(u66) -- Line: 399
    u66._subject.Destroying:Connect(function() -- Line: 400
        -- upvalues: u66 (copy)
        u66:Destroy();
    end);
    u66:_Setup();
    u66:_SetAnimationConstraintsEnabled(true);
end;

return u3;