-- Instance: ReplicatedStorage .Modules.PlayerDataUtility
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Signal = require(ReplicatedStorage.Modules.Signal);
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local StatisticsLibrary = require(ReplicatedStorage.Modules.StatisticsLibrary);
local SettingsLibrary = require(ReplicatedStorage.Modules.SettingsLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:_Init();

    return v2;
end;

function u1.GetRobuxSpent(p3, p4, p5, p6) -- Line: 25
    -- upvalues: MonetizationLibrary (copy)
    local v7 = 0;

    for _, v in pairs(p4 or {}) do
        v7 = v7 + (v.CurrencySpent or 0);
    end;

    for i, v in pairs(p5 or {}) do
        v7 = v7 + (v and (MonetizationLibrary.Gamepasses[i] and MonetizationLibrary.Gamepasses[i].StaticRobuxPrice) or 0);
    end;

    for _, v in pairs(p6 or {}) do
        v7 = v7 + (v.CurrencySpentTotal or 0);
    end;

    return v7;
end;

function u1.GetSetting(p8, p9, p10, p11) -- Line: 43
    -- upvalues: SettingsLibrary (copy)
    local v12 = SettingsLibrary:DoesExist(p10);
    assert(v12, p10);

    return p9:Get("Settings")[p11 or p9:Get("SettingsProfile")][p10];
end;

function u1.GetSettingChangedSignal(u13, u14, p15) -- Line: 49
    -- upvalues: SettingsLibrary (copy), Signal (copy)
    local v16 = SettingsLibrary:DoesExist(p15);
    assert(v16, p15);

    if not next(u14._setting_changed_events) then
        local u17 = u14:Get("SettingsProfile");

        local function update_bulk(p18) -- Line: 55
            -- upvalues: u14 (copy), u13 (copy), u17 (ref)
            local v19 = u14:Get("SettingsProfile");

            for i, v in pairs(u14._setting_changed_events) do
                local v20;

                if p18 then
                    v20 = u13:GetSetting(u14, i, u17);
                else
                    v20 = nil;
                end;

                local v21;

                if p18 then
                    v21 = u13:GetSetting(u14, i, v19);
                else
                    v21 = nil;
                end;

                if p18 then
                    local v22;

                    if typeof(v20) == "number" and typeof(v21) == "number" then
                        v22 = math.abs(v20 - v21) < 0.001;
                    else
                        v22 = v20 == v21;
                    end;

                    if not v22 then
                        v:FireDeferred();
                    end;
                else
                    v:FireDeferred();
                end;
            end;

            u17 = v19;
        end;

        u14:GetDataChangedSignal("SettingsProfile"):Connect(function() -- Line: 76
            -- upvalues: update_bulk (copy)
            update_bulk(true);
        end);
        u14:GetDataChangedSignal("Settings"):Connect(function() -- Line: 80
            -- upvalues: update_bulk (copy)
            update_bulk();
        end);
    end;

    if not u14._setting_changed_events[p15] then
        u14._setting_changed_events[p15] = Signal.new();
    end;

    return u14._setting_changed_events[p15];
end;

function u1.SetSetting(p23, p24, p25, p26, p27) -- Line: 92
    -- upvalues: SettingsLibrary (copy)
    local v28 = SettingsLibrary:DoesExist(p25);
    assert(v28, p25);
    p24:Get("Settings")[p27 or p24:Get("SettingsProfile")][p25] = p26;

    if p24.ReplicateToClient then
        p24.ReplicateToClient:Fire("SettingChanged", p25, p26, p27);
    end;

    if p24._setting_changed_events[p25] then
        p24._setting_changed_events[p25]:Fire(p26, p25);
    end;
end;

function u1.IsNosniyGamesTeamMemberRaw(p29, p30) -- Line: 106
    -- upvalues: CONSTANTS (copy)
    if p30 then
        p30 = table.find(p30, CONSTANTS.TEAM_GROUP_ROLE_ID);
    end;

    return p30;
end;

function u1.IsNosniyGamesTeamMember(p31, p32) -- Line: 110
    return p31:IsNosniyGamesTeamMemberRaw(p32:Get("GroupRoleIDs"));
end;

function u1.GetWeaponData(p33, p34, p35) -- Line: 114
    for i, v in pairs(p34:Get("WeaponInventory")) do
        if v.Name == p35 then
            return v, i;
        end;
    end;
end;

function u1.HasGamepass(p36, p37, p38) -- Line: 122
    return p37:Get("Gamepasses")[p38];
end;

function u1.AreTasksCompleted(p39, p40, p41) -- Line: 126
    for _, v in pairs(p40:Get(p41 or "Tasks")) do
        if not v.Completed then
            return false;
        end;
    end;

    return true;
end;

function u1.GetUnlockedWeapons(p42, p43, p44) -- Line: 136
    local v45 = {};

    for _, v in pairs(p43:Get("WeaponInventory")) do
        v45[v.Name] = true;
    end;

    if not p44 then
        for i in pairs(p43:Get("FreeWeaponUnlockCheck")) do
            v45[i] = true;
        end;
    end;

    return v45;
end;

function u1.GetStatistic(p46, p47, p48) -- Line: 152
    -- upvalues: StatisticsLibrary (copy)
    local v49 = StatisticsLibrary.Info[p48];

    if not v49 then
        local v50 = "Invalid statistic_name: " .. tostring(p48) .. ". Did you forget to put \"Statistic\" before the string?";
        assert(false, v50);
    end;

    return p47:Get(p48) or v49.DefaultValue;
end;

function u1.GetDirectoryStatistic(p51, u52, u53, u54, p55, p56) -- Line: 162
    -- upvalues: StatisticsLibrary (copy)
    local u57 = StatisticsLibrary.Info[p55];

    if not u57 then
        local v58 = "Invalid statistic_name: " .. tostring(p55) .. ". Did you forget to put \"Statistic\" before the string?";
        assert(false, v58);
    end;

    local u59 = 0;

    local function add(p60) -- Line: 171
        -- upvalues: u52 (copy), u53 (copy), u54 (copy), u57 (copy), u59 (ref)
        local v61 = u52:Get(u53);
        local v62 = v61[u54] and v61[u54][p60] or u57.DefaultValue;

        if u57.ValueType == "number" then
            v62 = u59 + v62;
        end;

        u59 = v62;
    end;

    local v63 = u52:Get(u53);
    local v64 = v63[u54] and v63[u54][p55] or u57.DefaultValue;

    if u57.ValueType == "number" then
        u59 = u59 + v64;
    else
        u59 = v64;
    end;

    for _, v in pairs(p56 or {}) do
        local v65 = u52:Get(u53);
        local v66 = v65[u54] and v65[u54][v] or u57.DefaultValue;

        if u57.ValueType == "number" then
            u59 = u59 + v66;
        else
            u59 = v66;
        end;
    end;

    return u59;
end;

function u1.GetSeasonInfo(p67, p68, p69) -- Line: 186
    -- upvalues: SeasonLibrary (copy)
    local v70 = p68:Get("Seasons")[p69];

    if v70 then
        v70 = v70.RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];
    end;

    local v71;

    if v70 then
        v71 = v70.CurrentELO;
    else
        v71 = v70;
    end;

    return v71, v70 and v70.Metadata and v70.Metadata.FinalLeaderboardRank;
end;

function u1.GetWeaponStatistic(p72, p73, ...) -- Line: 195
    return p72:GetDirectoryStatistic(p73, "WeaponStatistics", ...);
end;

function u1.GetMapStatistic(p74, p75, ...) -- Line: 199
    return p74:GetDirectoryStatistic(p75, "MapStatistics", ...);
end;

function u1._Init(p76) -- Line: 207
end;

return u1._new();