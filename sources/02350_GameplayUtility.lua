-- Instance: ReplicatedStorage .Modules.GameplayUtility
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local ServerStorage = game:GetService("ServerStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local AttackWarning = ReplicatedStorage.Assets.Misc.AttackWarning;
local Maps = ReplicatedStorage.Assets.Temp.Maps;
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 21
    -- upvalues: u1 (copy), Maps (copy)
    local v2 = setmetatable({}, u1);
    v2.TEMP_MAPS_FOLDER = Maps;
    v2.OOB_DEFAULT_WARN_DELAY = 1;
    v2.OOB_DEFAULT_KILL_DELAY = 4;
    v2:_Init();

    return v2;
end;

function u1.IsThingInWorkspace(p3, p4) -- Line: 37
    -- upvalues: Maps (copy)
    return p4:IsDescendantOf(workspace) or p4:IsDescendantOf(Maps);
end;

function u1.IsEntity(p5, p6) -- Line: 42
    -- upvalues: CollectionService (copy)
    while p6 and p6 ~= workspace do
        if CollectionService:HasTag(p6, "Entity") then
            return p6;
        end;

        p6 = p6.Parent;
    end;

    return false;
end;

function u1.GetEnvironmentID(p7, p8) -- Line: 54
    while p8 and p8:IsDescendantOf(workspace) do
        local Attribute = p8:GetAttribute("EnvironmentID");

        if Attribute then
            return Attribute;
        end;

        p8 = p8.Parent;
    end;

    return nil;
end;

function u1.GetSmokeCloudBetweenPoints(p9, p10, p11) -- Line: 68
    -- upvalues: CollectionService (copy), Utility (copy)
    for _, v in pairs(CollectionService:GetTagged("SmokeCloud")) do
        if Utility:SphereLineIntersection(v.Position, v.Size.X / 2, p10, p11) then
            return v;
        end;
    end;
end;

function u1.GetSmokeCloudsInSphere(p12, p13, p14, p15, p16) -- Line: 76
    -- upvalues: CollectionService (copy), Utility (copy)
    local v17 = p14 or 0;
    local v18 = {};

    for _, v in pairs(CollectionService:GetTagged("SmokeCloud")) do
        if (p13 - v.Position).Magnitude <= v.Size.X / 2 + v17 and not (p15 and (p16 and p16 < Utility:AngleBetweenVectors(p15, v.Position - p13))) then
            table.insert(v18, v);
        end;
    end;

    return v18;
end;

function u1.GetEquippedItems(p19, p20, p21, p22) -- Line: 95
    if not p20 then
        return {};
    end;

    local v23 = nil;
    local v24 = nil;

    for i, v in pairs(p21) do
        if v:Get("ObjectID") == p20 then
            v24 = i;
            v23 = v;
            break;
        end;
    end;

    if not v23 then
        return {};
    end;

    local v25 = {};

    for i = v24, v24 + (p22 or 0) do
        v25[p21[(i - 1) % #p21 + 1]] = true;
        local _ = i;
    end;

    return v25;
end;

function u1.AttackWarningEffect(p26, p27, p28, p29, p30, p31) -- Line: 125
    -- upvalues: AttackWarning (copy), BetterDebris (copy)
    local v32 = p30 or Color3.fromRGB(255, 0, 0);
    local v33 = AttackWarning:Clone();
    v33:ScaleTo(v33:GetScale() * p28 / 8);
    v33:PivotTo(CFrame.new(p27) * CFrame.Angles(0, math.random() * 3.141592653589793 * 2, 0));
    v33.Primary.Bottom.Circle.ImageColor3 = v32;
    v33.Primary.Bottom.Icon.ImageColor3 = v32;
    v33.Primary.Bottom.Icon.Image = p31 or v33.Primary.Bottom.Icon.Image;
    v33.Primary.Top.Progress.ImageColor3 = v32;
    v33.Primary.Top.Icon.ImageColor3 = v32;
    v33.Primary.Top.Icon.Image = p31 or v33.Primary.Top.Icon.Image;
    v33.Parent = workspace;
    BetterDebris:AddItem(v33, p29);
    v33.Primary.Top.Progress:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", p29, true);
end;

function u1.KnockbackTaggedParts(p34, p35, p36, p37, p38, p39, p40, p41) -- Line: 143
    -- upvalues: CollectionService (copy), Utility (copy)
    local v42 = "RaycastWhitelist" .. (p35 or "");
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    OverlapParams_new_ret.FilterDescendantsInstances = CollectionService:GetTagged("Knockbackable");

    for _, v in pairs(workspace:GetPartBoundsInRadius(p36, p37, OverlapParams_new_ret)) do
        if not (v.Anchored or (v.Position:FuzzyEq(p36) or p40 and (p41 and p41 < Utility:AngleBetweenVectors(p40, v.Position - p36)))) and v:HasTag(v42) then
            if v:HasTag("TrowelBrick") then
                v.CustomPhysicalProperties = PhysicalProperties.new(0.1, v.CurrentPhysicalProperties.Friction, v.CurrentPhysicalProperties.Elasticity);
            end;

            v.Velocity = p39 or (v.Position - p36).Unit * p38 * (1 - (v.Position - p36).Magnitude / p37);
        end;
    end;
end;

function u1.GetRaycastRedirection(p43, p44, p45, u46, u47, p48) -- Line: 167
    -- upvalues: Utility (copy)
    if p48 <= 0 then
        return u46;
    end;

    local u49 = {};
    p43:GetEntitiesWithinSphere(p44, p45, u47, 128, false, nil, nil, nil, function(p50) -- Line: 174
        -- upvalues: u47 (copy), Utility (ref), u46 (copy), u49 (copy)
        local LookVector = CFrame.new(u47, p50.RootPart.Position).LookVector;
        local v51 = {
            Entity = p50,
            LookDir = LookVector,
            Angle = Utility:AngleBetweenVectors(u46, LookVector)
        };
        table.insert(u49, v51);
    end);
    table.sort(u49, function(p52, p53) -- Line: 185
        return p52.Angle < p53.Angle;
    end);

    if u49[1] and u49[1].Angle < p48 then
        u46 = u49[1].LookDir or u46;
    end;

    return u46;
end;

function u1.SwitchingWeaponsMakesSense(p54, p55, p56) -- Line: 192
    -- upvalues: ItemLibrary (copy), ShopLibrary (copy), CONSTANTS (copy)
    local v57 = {};

    for i, _ in pairs(ItemLibrary.Classes) do
        v57[i] = {};
    end;

    for _, v in pairs(ShopLibrary:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET)) do
        local _ = ItemLibrary.Items[v].Class;
        local v58 = v;

        for i, v2 in pairs(ItemLibrary.Classes) do
            if p54:CanUseWeapon(p55, p56, v58, v2.Slot) then
                table.insert(v57[i], v58);

                if #v57[i] > 1 then
                    return true;
                end;
            end;
        end;
    end;

    return false;
end;

function u1.CanUseWeapon(p59, p60, p61, p62, p63) -- Line: 216
    -- upvalues: ShopLibrary (copy), CONSTANTS (copy), ItemLibrary (copy)
    if not (p62 and (p60 and p61)) then
        return false;
    end;

    local v64 = p60:Get("WeaponPool");
    local v65 = p60:Get("WeaponPoolFilterType");
    local v66;

    if v64 then
        if v65 == "Whitelist" then
            v66 = table.find(v64, p62);
        else
            v66 = false;
        end;
    else
        v66 = v64;
    end;

    if not (table.find(ShopLibrary:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET), p62) or v66) then
        return false;
    end;

    if not (p61:GetWeaponData(p62) or (p60:Get("IsInShootingRange") or p60:Get("CanUseLockedWeapons") or (p59:_CanUseWeaponFromFFlag(p62) or table.find(p60:Get("FreeWeaponTrials") or {}, p62)))) then
        return false;
    end;

    if v64 then
        if v65 == "Whitelist" and not table.find(v64, p62) then
            return false;
        end;

        if v65 == "Blacklist" and table.find(v64, p62) then
            return false;
        end;
    end;

    return not (p63 and (ItemLibrary.SlotToClass[p63].Name ~= ItemLibrary.Items[p62].Class and not p60:Get("WeaponClassRestrictionDisabled")));
end;

function u1.GetSpread(p67, p68, p69, p70, p71, p72, p73, p74) -- Line: 260
    local math_min_ret = math.min(p70 and p69 and p69 or 1, p71 and 0.75 or 1);
    local v75 = math.rad(p68) * math_min_ret;

    if p74 and (p73 and (p73 > 1 and p72 == 1)) then
        return CFrame.identity;
    end;

    if not (p74 and (p73 and (p73 > 1 and p72 ~= nil))) then
        return CFrame.Angles(0, 0, 6.283185307179586 * math.random()) * CFrame.Angles(v75 * math.random(), 0, 0);
    end;

    local v76 = v75 / 0.75;

    if p72 % 2 == 0 then
        return CFrame.Angles(0, 0, 6.283185307179586 / (p73 - 1) * p72) * CFrame.Angles(v76 / 2 / 2, 0, 0);
    end;

    return CFrame.Angles(0, 0, 6.283185307179586 / (p73 - 1) * p72) * CFrame.Angles(v76 / 2, 0, 0);
end;

function u1.IsInWhitelist(p77, p78, p79) -- Line: 284
    for _, v in pairs(p79) do
        if p78 == v or v:IsA("Instance") and p78:IsDescendantOf(v) then
            return true;
        end;
    end;

    return false;
end;

function u1.GetMousePositionFromCameraData(p80, p81, p82, p83, p84, p85, p86, p87) -- Line: 294
    -- upvalues: CONSTANTS (copy)
    if p85 then
        p85 = p85.CFrame * (p86 or CFrame.identity);
    end;

    if p85 then
        p84 = CFrame.new(p84.Position, p85.Position) or p84;
    end;

    local v88 = p84 * (p87 or CFrame.identity);
    local _, v89 = p80:GetEntitiesFromRaycast(p81, p82, v88.Position, v88.LookVector, CONSTANTS.MAX_RAYCAST_DISTANCE);

    return v89.Position;
end;

function u1.GetMouseLocationFromCameraData(p90, p91, p92, p93, p94, p95, p96, p97) -- Line: 303
    -- upvalues: u1 (copy), Utility (copy)
    local RaycastWhitelist = u1:GetRaycastWhitelist(p95, p97);

    if p93 then
        p93 = p93.CFrame * (p94 or CFrame.identity);
    end;

    if p93 then
        p92 = CFrame.new(p92.Position, p93.Position) or p92;
    end;

    local v98 = nil;

    for i = 1, 10 do
        local v99 = Utility:Raycast(p92.Position, p92.Position + p92.LookVector, p96, RaycastWhitelist, Enum.RaycastFilterType.Include);
        v98 = Utility:Raycast(p91.Position, v99.Position, p96, RaycastWhitelist, Enum.RaycastFilterType.Include);

        if not v98.Instance or v98.Instance.Transparency < 0.99 then
            break;
        end;

        table.insert(RaycastWhitelist, v98.Instance);
        local _ = i;
    end;

    return v98;
end;

function u1.GetRaycastWhitelist(p100, p101, p102, p103, p104) -- Line: 325
    -- upvalues: CollectionService (copy)
    local v105 = p104 and {} or CollectionService:GetTagged("RaycastWhitelist" .. (p101 or ""));

    if not p102 then
        return v105;
    end;

    local v106 = {};
    local v107 = p103 or {};

    for _, v in pairs(CollectionService:GetTagged("Entity")) do
        local EntityFromModel = p100:GetEntityFromModel(v);

        if not (v107[EntityFromModel] or (not p102:IsValidTarget(EntityFromModel) or EntityFromModel:Get("EnvironmentID") ~= p101)) then
            for _, v2 in pairs(EntityFromModel:GetHitboxes(p102.GrabSmallHitboxes)) do
                table.insert(v105, v2);
                v106[v2] = EntityFromModel;
            end;
        end;
    end;

    return v105, v106;
end;

function u1.GetEntityFromModel(p108, p109) -- Line: 351
    -- upvalues: CONSTANTS (copy), ServerStorage (copy), Players (copy)
    if CONSTANTS.IS_SERVER then
        local FighterService = require(ServerStorage.Services.FighterService);
        local EnemyService = require(ServerStorage.Services.EnemyService);
        local Fighter = FighterService:GetFighter(p109);

        return Fighter and Fighter.Entity or EnemyService:GetEnemy(p109);
    end;

    if CONSTANTS.IS_CLIENT then
        local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
        local EnemyController = require(Players.LocalPlayer.PlayerScripts.Controllers.EnemyController);
        local Fighter = FighterController:GetFighter(p109);

        return Fighter and Fighter.Entity or EnemyController:GetEnemy(p109);
    end;
end;

function u1.GetEntityFromTouch(p110, p111, p112, p113) -- Line: 368
    local EntityFromModel = p110:GetEntityFromModel((p110:IsEntity(p113)));

    if EntityFromModel and (EntityFromModel:Get("EnvironmentID") == p111 and p112:IsValidTarget(EntityFromModel)) then
        return EntityFromModel;
    end;
end;

function u1.GetEntitiesWithinSphere(p114, p115, p116, p117, p118, p119, p120, p121, p122, p123, p124) -- Line: 383
    -- upvalues: BetterDebris (copy), Utility (copy)
    if p124 then
        local v125 = tonumber(p124) or (tonumber(false) or 30);
        local Part = Instance.new("Part");
        Part.Color = Color3.fromRGB(255, 0, 0);
        Part.Material = Enum.Material.ForceField;
        Part.CanTouch = false;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        Part.Anchored = true;
        Part.Shape = Enum.PartType.Ball;
        Part.Size = Vector3.new(1, 1, 1) * p118 * 2;
        Part.CFrame = CFrame.new(p117);
        Part.Parent = workspace;
        BetterDebris:AddItem(Part, v125);
        local Part2 = Instance.new("Part");
        Part2.Color = Color3.fromRGB(255, 0, 0);
        Part2.Material = Enum.Material.Neon;
        Part2.CanTouch = false;
        Part2.CanCollide = false;
        Part2.CanQuery = false;
        Part2.CastShadow = false;
        Part2.Anchored = true;
        Part2.Shape = Enum.PartType.Ball;
        Part2.Size = Vector3.new(0.1, 0.1, 0.1);
        Part2.CFrame = CFrame.new(p117);
        Part2.Parent = workspace;
        BetterDebris:AddItem(Part2, v125);
    end;

    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    OverlapParams_new_ret.FilterDescendantsInstances = p114:GetRaycastWhitelist(p115, p116, nil, true);
    local v126 = not p119 and p114:GetRaycastWhitelist(p115);
    local v127 = not p119 and Enum.RaycastFilterType.Include;
    local v128 = {};

    for _, v in pairs(workspace:GetPartBoundsInRadius(p117, p118, OverlapParams_new_ret)) do
        local v129 = v:GetAttribute("IsAssemblyRootPart") and v and v or (v.AssemblyRootPart or v);

        if not (v128[v129] or p120 and (p121 and ((p122 or 3) < (v.Position - p117).Magnitude and p121 < Utility:AngleBetweenVectors(p120, v.Position - p117)))) then
            local EntityFromTouch = p114:GetEntityFromTouch(p115, p116, v);

            if EntityFromTouch and (not v128[EntityFromTouch] and (EntityFromTouch:IsAlive() and (p119 or not Utility:Raycast(p117, v.Position, (p117 - v.Position).Magnitude, v126, v127).Instance))) then
                v128[EntityFromTouch] = true;
                v128[v129] = true;
                task.spawn(p123, EntityFromTouch, v);
            end;
        end;
    end;
end;

function u1.GetEntitiesFromPoint(p130, p131, p132, p133, p134) -- Line: 454
    local u135 = {};
    p130:GetEntitiesWithinSphere(p131, p132, p133, p134 or 0, nil, nil, nil, nil, function(p136, p137) -- Line: 457
        -- upvalues: u135 (copy)
        table.insert(u135, {
            Entity = p136,
            Hitbox = p137
        });
    end);

    return u135;
end;

function u1.GetEntitiesFromRaycast(p138, p139, p140, p141, p142, p143, p144, p145, p146, p147) -- Line: 468
    -- upvalues: Utility (copy), BetterDebris (copy)
    local v148 = p146 and Utility:CloneTable(p146, true) or {};
    local v149 = p145 or 0;
    local v150 = 1;
    local v151 = p144 or 0;
    local u152 = {};
    local u153 = nil;
    local v154 = nil;

    while v150 <= 1 + v149 do
        local RaycastWhitelist, v155 = p138:GetRaycastWhitelist(p139, p140, v148);
        local RaycastParams_new_ret = RaycastParams.new();
        RaycastParams_new_ret.FilterDescendantsInstances = RaycastWhitelist;
        RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
        RaycastParams_new_ret.IgnoreWater = true;
        local v156;

        if v151 > 0 then
            v156 = workspace:Spherecast(p141, v151, p142 * p143, RaycastParams_new_ret);
        else
            v156 = workspace:Raycast(p141, p142 * p143, RaycastParams_new_ret);
        end;

        v154 = Utility:MakeSafeRaycastResult(v156, p141, p142, p143);
        local v157 = v155[v154.Instance];
        u153 = u153 or v154;

        if not v157 then
            break;
        end;

        table.insert(u152, {
            IsFromPoint = nil,
            Entity = v157,
            Hitbox = v154.Instance,
            RaycastResult = v154
        });
        v148[v157] = true;

        if v157.Model:GetAttribute("PierceThrough") then
            v149 = v149 + 1;
        end;

        v150 = v150 + 1;
    end;

    p138:GetEntitiesWithinSphere(p139, p140, p141, v151, nil, nil, nil, nil, function(p158, p159) -- Line: 517
        -- upvalues: u152 (copy), u153 (ref)
        table.insert(u152, {
            IsFromPoint = true,
            Entity = p158,
            Hitbox = p159,
            RaycastResult = u153
        });
    end);

    if v154 and p147 then
        local Magnitude = (v154.Position - p141).Magnitude;
        local Part = Instance.new("Part");
        Part.Color = Color3.fromRGB(255, 0, 0);
        Part.Material = Enum.Material.ForceField;
        Part.CanTouch = false;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        Part.Anchored = true;
        Part.Size = Vector3.new(0.1, 0.1, Magnitude);
        Part.CFrame = CFrame.new(p141, v154.Position) * CFrame.new(0, 0, -Magnitude / 2);
        Part.Parent = workspace;
        BetterDebris:AddItem(Part, 10);
    end;

    return u152, v154;
end;

function u1.GetJumpPadPlacement(p160, p161, p162, p163, p164, p165, p166) -- Line: 540
    -- upvalues: Utility (copy), CONSTANTS (copy), u1 (copy)
    local RaycastWhitelist = p160:GetRaycastWhitelist(p161);

    if p165 then
        p165 = p165.CFrame * (p166 or CFrame.identity);
    end;

    local v167;

    if p165 then
        v167 = CFrame.new(p164.Position, p165.Position) or p164;
    else
        v167 = p164;
    end;

    if v167 ~= v167 then
        v167 = CFrame.new(p164.Position);
    end;

    local v168 = Utility:Raycast(v167.Position, v167.Position + v167.LookVector * CONSTANTS.MAX_RAYCAST_DISTANCE, CONSTANTS.MAX_RAYCAST_DISTANCE, RaycastWhitelist, Enum.RaycastFilterType.Include);
    local v169 = Utility:Raycast(p163.Position, p163.Position + (v168.Position - p163.Position).Unit * p162, p162, RaycastWhitelist, Enum.RaycastFilterType.Include);

    if v169.Instance and not (v169.Instance:HasTag("Barrier") or (Utility:IsWithinTaggedParts("Barrier", v169.Position) or u1:IsWithinOOBPart(v169.Position))) then
        return v169, CFrame.new(v169.Position, v169.Position + v169.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(p163.Position * Vector3.new(1, 0, 1), v169.Position * Vector3.new(1, 0, 1)).Rotation * CFrame.Angles(1.5707963267948966, 0, 0);
    end;

    return v169, nil;
end;

function u1.GetSubspaceTripminePlacement(p170, p171, p172, p173) -- Line: 563
    local v174 = p172:FuzzyEq(p173) and p172 and p172 or p173 + (p172 - p173).Unit * math.min(p171, (p172 - p173).Magnitude);
    local v175 = v174:FuzzyEq(p173) and CFrame.identity or CFrame.new(v174 * Vector3.new(1, 0, 1), p173 * Vector3.new(1, 0, 1));

    return CFrame.new(v174) * v175.Rotation;
end;

function u1.GetOOBWarnDelay(p176, p177) -- Line: 571
    local v178 = p177 or p176.OOB_DEFAULT_WARN_DELAY;

    return v178 == -1 and (1 / 0) or v178;
end;

function u1.GetOOBKillDelay(p179, p180) -- Line: 576
    local v181 = p180 or p179.OOB_DEFAULT_KILL_DELAY;

    return v181 == -1 and (1 / 0) or v181;
end;

function u1.IsWithinOOBPart(u182, p183, p184) -- Line: 581
    -- upvalues: Utility (copy)
    if Utility:IsWithinTaggedParts("OutOfBoundsSafePart", p183) then
        return nil;
    end;

    local v185 = Utility:IsWithinTaggedParts("OutOfBoundsPart", p183, p184, true);
    table.sort(v185, function(p186, p187) -- Line: 590
        -- upvalues: u182 (copy)
        return u182:GetOOBWarnDelay(p186:GetAttribute("WarnDelay")) + u182:GetOOBKillDelay(p186:GetAttribute("KillDelay")) < u182:GetOOBWarnDelay(p187:GetAttribute("WarnDelay")) + u182:GetOOBKillDelay(p187:GetAttribute("KillDelay"));
    end);

    return v185[1];
end;

function u1._CanUseWeaponFromFFlag(p188, u189) -- Line: 604
    -- upvalues: CONSTANTS (copy), ServerStorage (copy), Players (copy), ItemLibrary (copy)
    local success, result = pcall(function() -- Line: 606
        -- upvalues: CONSTANTS (ref), ServerStorage (ref), Players (ref), ItemLibrary (ref), u189 (copy)
        local v190;

        if CONSTANTS.IS_SERVER then
            v190 = require(ServerStorage.Services.FFlagService);
        else
            v190 = require(Players.LocalPlayer.PlayerScripts.Controllers.FFlagController);
        end;

        return v190:GetFFlag("FreeToUse" .. ItemLibrary.Items[u189].Status .. "Weapons");
    end);

    if not success then
        warn("Failed to fetch FreeWeapons FFlag");
    end;

    return success and result;
end;

function u1._Init(p191) -- Line: 620
end;

return u1._new();