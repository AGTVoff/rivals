-- Instance: ReplicatedStorage .Modules.StatisticsLibrary
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local u1 = {
    Info = {},
    Order = {},
    Items = {},
    Maps = {},
    CareerStatistics = {}
};
u1.STATISTICS_DIRECTORY_INFO = {
    { "WeaponStatistics", u1.Items },
    { "MapStatistics", u1.Maps }
};

function u1.GetStatisticsDirectoryInfo(p2, p3) -- Line: 20
    for i, v in pairs(p2.STATISTICS_DIRECTORY_INFO) do
        local table_unpack_ret, _ = table.unpack(v);

        if table_unpack_ret == p3 then
            return v, i;
        end;
    end;
end;

function u1.GetPercent(p4, p5, p6) -- Line: 30
    return p5 == 0 and -1 or p6 / p5;
end;

function u1.GetCareerStatistics(p7, p8) -- Line: 34
    -- upvalues: u1 (copy)
    local v9 = {};
    local v10 = {};
    local v11 = {};

    for i, v in pairs(u1.Items) do
        local v12 = i;

        for _, v2 in pairs(v.DataNames) do
            v9[v2] = true;
            v10[v2] = v10[v2] or (p8[v12] or nil);
        end;
    end;

    for i, _ in pairs(u1.Info) do
        if not v9[i] then
            v11[i] = true;
        end;
    end;

    local v13 = {};

    for i in pairs(v10) do
        table.insert(v13, i);
    end;

    for i in pairs(v11) do
        table.insert(v13, i);
    end;

    for i = #v13, 1, -1 do
        local v14;

        if u1.Info[v13[i]].IsCareerStatistic then
            v14 = i;
        else
            table.remove(v13, i);
            v14 = i;
        end;
    end;

    table.sort(v13, function(p15, p16) -- Line: 72
        -- upvalues: u1 (ref)
        return u1.Info[p15].Index < u1.Info[p16].Index;
    end);

    return v13;
end;

local function pretty_number_tostring(p17) -- Line: 80
    -- upvalues: Utility (copy)
    return Utility:PrettyNumber((math.floor(p17 + 0.5)));
end;

local function percent_tostring(p18) -- Line: 84
    return p18 == -1 and "N/A" or math.floor(p18 * 1000) / 10 .. "%";
end;

local function playtime_tostring(p19) -- Line: 88
    -- upvalues: Utility (copy)
    return Utility:TimeFormat2(p19 < 60 and p19 and p19 or math.floor(p19 / 60) * 60, nil, true);
end;

local function playtime_precise_tostring(p20) -- Line: 92
    return string.format("%.3f", p20) .. "s";
end;

local function raw_value(p21) -- Line: 96
    return p21;
end;

local function add_statistic(p22, p23, p24, p25, p26, p27, p28, p29, p30) -- Line: 104
    -- upvalues: u1 (copy), pretty_number_tostring (copy)
    local v31;

    if p26 == true or not p26 then
        v31 = nil;
    else
        v31 = "Statistic" .. p26 or nil;
    end;

    local v32;

    if v31 then
        v32 = u1.Info[v31];
    else
        v32 = v31;
    end;

    local v33 = p28 or 0;
    local v34 = {
        Index = #u1.Order + 1,
        IsCareerStatistic = p22,
        OnlyDisplayAboveZero = p23,
        DataName = "Statistic" .. p24,
        DisplayName = p25,
        FullDisplayName = p29 or (v32 and (v32.FullDisplayName .. " " or "") or "") .. p25,
        IsStatisticFolder = p26 == true,
        ParentDataName = v31,
        DefaultValue = v33,
        ValueType = typeof(v33),
        TostringFunction = p30 or pretty_number_tostring,
        Image = p27 or (v32 and v32.Image or "")
    };
    u1.Info[v34.DataName] = v34;
    table.insert(u1.Order, v34.DataName);
end;

local v36 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticJoinedTime",
    DisplayName = "Joined",
    FullDisplayName = "Joined",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = -1,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = function(p35) -- Line: 100, Name: date_tostring
        return p35 and (p35 > 0 and DateTime.fromUnixTimestamp(p35):FormatLocalTime("ll", "en-us")) or "???";
    end or pretty_number_tostring
};
u1.Info[v36.DataName] = v36;
table.insert(u1.Order, v36.DataName);
local v37 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticPlaytime",
    DisplayName = "Playtime",
    FullDisplayName = "Playtime",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://17156089790",
    Index = #u1.Order + 1,
    TostringFunction = playtime_tostring or pretty_number_tostring
};
u1.Info[v37.DataName] = v37;
table.insert(u1.Order, v37.DataName);
local StatisticPlaytime = u1.Info.StatisticPlaytime;
local v38 = {
    IsCareerStatistic = nil,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticPlaytimeUnequipped",
    DisplayName = "while unequipped",
    IsStatisticFolder = false,
    ParentDataName = "StatisticPlaytime",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticPlaytime and (StatisticPlaytime.FullDisplayName .. " " or "") or "") .. "while unequipped",
    TostringFunction = playtime_tostring or pretty_number_tostring,
    Image = StatisticPlaytime and StatisticPlaytime.Image or ""
};
u1.Info[v38.DataName] = v38;
table.insert(u1.Order, v38.DataName);
local v39 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticTasksCompleted",
    DisplayName = "Tasks Completed",
    FullDisplayName = "Tasks Completed",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v39.DataName] = v39;
table.insert(u1.Order, v39.DataName);
local v40 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticContractsCompleted",
    DisplayName = "Contracts Completed",
    FullDisplayName = "Contracts Completed",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v40.DataName] = v40;
table.insert(u1.Order, v40.DataName);
local v41 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticFavoriteWeapon",
    DisplayName = "Most Played Weapon",
    FullDisplayName = "Most Played Weapon",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = "N/A",
    ValueType = "string",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = raw_value or pretty_number_tostring
};
u1.Info[v41.DataName] = v41;
table.insert(u1.Order, v41.DataName);
local StatisticFavoriteWeapon = u1.Info.StatisticFavoriteWeapon;
local v42 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticFavoriteWeaponPrimary",
    DisplayName = "primary",
    IsStatisticFolder = false,
    ParentDataName = "StatisticFavoriteWeapon",
    DefaultValue = "N/A",
    ValueType = "string",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticFavoriteWeapon and (StatisticFavoriteWeapon.FullDisplayName .. " " or "") or "") .. "primary",
    TostringFunction = raw_value or pretty_number_tostring,
    Image = StatisticFavoriteWeapon and StatisticFavoriteWeapon.Image or ""
};
u1.Info[v42.DataName] = v42;
table.insert(u1.Order, v42.DataName);
local StatisticFavoriteWeapon2 = u1.Info.StatisticFavoriteWeapon;
local v43 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticFavoriteWeaponSecondary",
    DisplayName = "secondary",
    IsStatisticFolder = false,
    ParentDataName = "StatisticFavoriteWeapon",
    DefaultValue = "N/A",
    ValueType = "string",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticFavoriteWeapon2 and (StatisticFavoriteWeapon2.FullDisplayName .. " " or "") or "") .. "secondary",
    TostringFunction = raw_value or pretty_number_tostring,
    Image = StatisticFavoriteWeapon2 and StatisticFavoriteWeapon2.Image or ""
};
u1.Info[v43.DataName] = v43;
table.insert(u1.Order, v43.DataName);
local StatisticFavoriteWeapon3 = u1.Info.StatisticFavoriteWeapon;
local v44 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticFavoriteWeaponMelee",
    DisplayName = "melee",
    IsStatisticFolder = false,
    ParentDataName = "StatisticFavoriteWeapon",
    DefaultValue = "N/A",
    ValueType = "string",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticFavoriteWeapon3 and (StatisticFavoriteWeapon3.FullDisplayName .. " " or "") or "") .. "melee",
    TostringFunction = raw_value or pretty_number_tostring,
    Image = StatisticFavoriteWeapon3 and StatisticFavoriteWeapon3.Image or ""
};
u1.Info[v44.DataName] = v44;
table.insert(u1.Order, v44.DataName);
local StatisticFavoriteWeapon4 = u1.Info.StatisticFavoriteWeapon;
local v45 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticFavoriteWeaponUtility",
    DisplayName = "utility",
    IsStatisticFolder = false,
    ParentDataName = "StatisticFavoriteWeapon",
    DefaultValue = "N/A",
    ValueType = "string",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticFavoriteWeapon4 and (StatisticFavoriteWeapon4.FullDisplayName .. " " or "") or "") .. "utility",
    TostringFunction = raw_value or pretty_number_tostring,
    Image = StatisticFavoriteWeapon4 and StatisticFavoriteWeapon4.Image or ""
};
u1.Info[v45.DataName] = v45;
table.insert(u1.Order, v45.DataName);
local v46 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticFavoriteMap",
    DisplayName = "Most Played Map",
    FullDisplayName = "Most Played Map",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = "N/A",
    ValueType = "string",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = raw_value or pretty_number_tostring
};
u1.Info[v46.DataName] = v46;
table.insert(u1.Order, v46.DataName);
local StatisticFavoriteMap = u1.Info.StatisticFavoriteMap;
local v47 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticFavoriteMap2",
    DisplayName = "2nd",
    IsStatisticFolder = false,
    ParentDataName = "StatisticFavoriteMap",
    DefaultValue = "N/A",
    ValueType = "string",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticFavoriteMap and (StatisticFavoriteMap.FullDisplayName .. " " or "") or "") .. "2nd",
    TostringFunction = raw_value or pretty_number_tostring,
    Image = StatisticFavoriteMap and StatisticFavoriteMap.Image or ""
};
u1.Info[v47.DataName] = v47;
table.insert(u1.Order, v47.DataName);
local StatisticFavoriteMap2 = u1.Info.StatisticFavoriteMap;
local v48 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticFavoriteMap3",
    DisplayName = "3rd",
    IsStatisticFolder = false,
    ParentDataName = "StatisticFavoriteMap",
    DefaultValue = "N/A",
    ValueType = "string",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticFavoriteMap2 and (StatisticFavoriteMap2.FullDisplayName .. " " or "") or "") .. "3rd",
    TostringFunction = raw_value or pretty_number_tostring,
    Image = StatisticFavoriteMap2 and StatisticFavoriteMap2.Image or ""
};
u1.Info[v48.DataName] = v48;
table.insert(u1.Order, v48.DataName);
local StatisticFavoriteMap3 = u1.Info.StatisticFavoriteMap;
local v49 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticFavoriteMap4",
    DisplayName = "4th",
    IsStatisticFolder = false,
    ParentDataName = "StatisticFavoriteMap",
    DefaultValue = "N/A",
    ValueType = "string",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticFavoriteMap3 and (StatisticFavoriteMap3.FullDisplayName .. " " or "") or "") .. "4th",
    TostringFunction = raw_value or pretty_number_tostring,
    Image = StatisticFavoriteMap3 and StatisticFavoriteMap3.Image or ""
};
u1.Info[v49.DataName] = v49;
table.insert(u1.Order, v49.DataName);
local v50 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsPlayed",
    DisplayName = "Duels Played",
    FullDisplayName = "Duels Played",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v50.DataName] = v50;
table.insert(u1.Order, v50.DataName);
local StatisticDuelsPlayed = u1.Info.StatisticDuelsPlayed;
local v51 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsWon",
    DisplayName = "wins",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDuelsPlayed and (StatisticDuelsPlayed.FullDisplayName .. " " or "") or "") .. "wins",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDuelsPlayed and StatisticDuelsPlayed.Image or ""
};
u1.Info[v51.DataName] = v51;
table.insert(u1.Order, v51.DataName);
local StatisticDuelsPlayed2 = u1.Info.StatisticDuelsPlayed;
local v52 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsLost",
    DisplayName = "losses",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDuelsPlayed2 and (StatisticDuelsPlayed2.FullDisplayName .. " " or "") or "") .. "losses",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDuelsPlayed2 and StatisticDuelsPlayed2.Image or ""
};
u1.Info[v52.DataName] = v52;
table.insert(u1.Order, v52.DataName);
local StatisticDuelsPlayed3 = u1.Info.StatisticDuelsPlayed;
local v53 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsWinPercent",
    DisplayName = "win %",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDuelsPlayed",
    DefaultValue = -1,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDuelsPlayed3 and (StatisticDuelsPlayed3.FullDisplayName .. " " or "") or "") .. "win %",
    TostringFunction = percent_tostring or pretty_number_tostring,
    Image = StatisticDuelsPlayed3 and StatisticDuelsPlayed3.Image or ""
};
u1.Info[v53.DataName] = v53;
table.insert(u1.Order, v53.DataName);
local StatisticDuelsPlayed4 = u1.Info.StatisticDuelsPlayed;
local v54 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsWonFlawless",
    DisplayName = "flawless wins",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDuelsPlayed4 and (StatisticDuelsPlayed4.FullDisplayName .. " " or "") or "") .. "flawless wins",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDuelsPlayed4 and StatisticDuelsPlayed4.Image or ""
};
u1.Info[v54.DataName] = v54;
table.insert(u1.Order, v54.DataName);
local StatisticDuelsPlayed5 = u1.Info.StatisticDuelsPlayed;
local v55 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsLostFlawless",
    DisplayName = "flawless losses",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDuelsPlayed5 and (StatisticDuelsPlayed5.FullDisplayName .. " " or "") or "") .. "flawless losses",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDuelsPlayed5 and StatisticDuelsPlayed5.Image or ""
};
u1.Info[v55.DataName] = v55;
table.insert(u1.Order, v55.DataName);
local StatisticDuelsPlayed6 = u1.Info.StatisticDuelsPlayed;
local v56 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsWonSuddenDeath",
    DisplayName = "sudden death wins",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDuelsPlayed6 and (StatisticDuelsPlayed6.FullDisplayName .. " " or "") or "") .. "sudden death wins",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDuelsPlayed6 and StatisticDuelsPlayed6.Image or ""
};
u1.Info[v56.DataName] = v56;
table.insert(u1.Order, v56.DataName);
local StatisticDuelsPlayed7 = u1.Info.StatisticDuelsPlayed;
local v57 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsLostSuddenDeath",
    DisplayName = "sudden death losses",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDuelsPlayed7 and (StatisticDuelsPlayed7.FullDisplayName .. " " or "") or "") .. "sudden death losses",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDuelsPlayed7 and StatisticDuelsPlayed7.Image or ""
};
u1.Info[v57.DataName] = v57;
table.insert(u1.Order, v57.DataName);
local StatisticDuelsPlayed8 = u1.Info.StatisticDuelsPlayed;
local v58 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsWinStreak",
    DisplayName = "current win streak",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDuelsPlayed8 and (StatisticDuelsPlayed8.FullDisplayName .. " " or "") or "") .. "current win streak",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDuelsPlayed8 and StatisticDuelsPlayed8.Image or ""
};
u1.Info[v58.DataName] = v58;
table.insert(u1.Order, v58.DataName);
local StatisticDuelsPlayed9 = u1.Info.StatisticDuelsPlayed;
local v59 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsWinStreakHighest",
    DisplayName = "highest ever win streak",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDuelsPlayed9 and (StatisticDuelsPlayed9.FullDisplayName .. " " or "") or "") .. "highest ever win streak",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDuelsPlayed9 and StatisticDuelsPlayed9.Image or ""
};
u1.Info[v59.DataName] = v59;
table.insert(u1.Order, v59.DataName);
local StatisticDuelsPlayed10 = u1.Info.StatisticDuelsPlayed;
local v60 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsWinStreaksTaken",
    DisplayName = "highest win streak ended",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDuelsPlayed10 and (StatisticDuelsPlayed10.FullDisplayName .. " " or "") or "") .. "highest win streak ended",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDuelsPlayed10 and StatisticDuelsPlayed10.Image or ""
};
u1.Info[v60.DataName] = v60;
table.insert(u1.Order, v60.DataName);
local StatisticDuelsPlayed11 = u1.Info.StatisticDuelsPlayed;
local v61 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsWinStreaksTakenTotal",
    DisplayName = "total win streaks ended",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDuelsPlayed11 and (StatisticDuelsPlayed11.FullDisplayName .. " " or "") or "") .. "total win streaks ended",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDuelsPlayed11 and StatisticDuelsPlayed11.Image or ""
};
u1.Info[v61.DataName] = v61;
table.insert(u1.Order, v61.DataName);
local StatisticDuelsPlayed12 = u1.Info.StatisticDuelsPlayed;
local v62 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDuelsMVPs",
    DisplayName = "MVPs",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDuelsPlayed12 and (StatisticDuelsPlayed12.FullDisplayName .. " " or "") or "") .. "MVPs",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDuelsPlayed12 and StatisticDuelsPlayed12.Image or ""
};
u1.Info[v62.DataName] = v62;
table.insert(u1.Order, v62.DataName);
local v63 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticRoundsPlayed",
    DisplayName = "Rounds Played",
    FullDisplayName = "Rounds Played",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v63.DataName] = v63;
table.insert(u1.Order, v63.DataName);
local _ = u1.Info.StatisticRoundsPlayed;
local v64 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticRoundsWon",
    DisplayName = "wins",
    FullDisplayName = "Rounds Won",
    IsStatisticFolder = false,
    ParentDataName = "StatisticRoundsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://100786023219923",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v64.DataName] = v64;
table.insert(u1.Order, v64.DataName);
local StatisticRoundsPlayed = u1.Info.StatisticRoundsPlayed;
local v65 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticRoundsLost",
    DisplayName = "losses",
    IsStatisticFolder = false,
    ParentDataName = "StatisticRoundsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticRoundsPlayed and (StatisticRoundsPlayed.FullDisplayName .. " " or "") or "") .. "losses",
    TostringFunction = pretty_number_tostring,
    Image = StatisticRoundsPlayed and StatisticRoundsPlayed.Image or ""
};
u1.Info[v65.DataName] = v65;
table.insert(u1.Order, v65.DataName);
local StatisticRoundsPlayed2 = u1.Info.StatisticRoundsPlayed;
local v66 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticRoundsWinPercent",
    DisplayName = "win %",
    IsStatisticFolder = false,
    ParentDataName = "StatisticRoundsPlayed",
    DefaultValue = -1,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticRoundsPlayed2 and (StatisticRoundsPlayed2.FullDisplayName .. " " or "") or "") .. "win %",
    TostringFunction = percent_tostring or pretty_number_tostring,
    Image = StatisticRoundsPlayed2 and StatisticRoundsPlayed2.Image or ""
};
u1.Info[v66.DataName] = v66;
table.insert(u1.Order, v66.DataName);
local v67 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticRankedDuelsPlayed",
    DisplayName = "Ranked Duels Played",
    FullDisplayName = "Ranked Duels Played",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v67.DataName] = v67;
table.insert(u1.Order, v67.DataName);
local StatisticRankedDuelsPlayed = u1.Info.StatisticRankedDuelsPlayed;
local v68 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticRankedDuelsWon",
    DisplayName = "ranked wins",
    IsStatisticFolder = false,
    ParentDataName = "StatisticRankedDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticRankedDuelsPlayed and (StatisticRankedDuelsPlayed.FullDisplayName .. " " or "") or "") .. "ranked wins",
    TostringFunction = pretty_number_tostring,
    Image = StatisticRankedDuelsPlayed and StatisticRankedDuelsPlayed.Image or ""
};
u1.Info[v68.DataName] = v68;
table.insert(u1.Order, v68.DataName);
local StatisticRankedDuelsPlayed2 = u1.Info.StatisticRankedDuelsPlayed;
local v69 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticRankedDuelsLost",
    DisplayName = "ranked losses",
    IsStatisticFolder = false,
    ParentDataName = "StatisticRankedDuelsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticRankedDuelsPlayed2 and (StatisticRankedDuelsPlayed2.FullDisplayName .. " " or "") or "") .. "ranked losses",
    TostringFunction = pretty_number_tostring,
    Image = StatisticRankedDuelsPlayed2 and StatisticRankedDuelsPlayed2.Image or ""
};
u1.Info[v69.DataName] = v69;
table.insert(u1.Order, v69.DataName);
local StatisticRankedDuelsPlayed3 = u1.Info.StatisticRankedDuelsPlayed;
local v70 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticRankedDuelsWinPercent",
    DisplayName = "ranked win %",
    IsStatisticFolder = false,
    ParentDataName = "StatisticRankedDuelsPlayed",
    DefaultValue = -1,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticRankedDuelsPlayed3 and (StatisticRankedDuelsPlayed3.FullDisplayName .. " " or "") or "") .. "ranked win %",
    TostringFunction = percent_tostring or pretty_number_tostring,
    Image = StatisticRankedDuelsPlayed3 and StatisticRankedDuelsPlayed3.Image or ""
};
u1.Info[v70.DataName] = v70;
table.insert(u1.Order, v70.DataName);
local v71 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticRankedRoundsPlayed",
    DisplayName = "Ranked Rounds Played",
    FullDisplayName = "Ranked Rounds Played",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v71.DataName] = v71;
table.insert(u1.Order, v71.DataName);
local StatisticRankedRoundsPlayed = u1.Info.StatisticRankedRoundsPlayed;
local v72 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticRankedRoundsWon",
    DisplayName = "ranked wins",
    FullDisplayName = "Ranked Rounds Won",
    IsStatisticFolder = false,
    ParentDataName = "StatisticRankedRoundsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring,
    Image = StatisticRankedRoundsPlayed and StatisticRankedRoundsPlayed.Image or ""
};
u1.Info[v72.DataName] = v72;
table.insert(u1.Order, v72.DataName);
local StatisticRankedRoundsPlayed2 = u1.Info.StatisticRankedRoundsPlayed;
local v73 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticRankedRoundsLost",
    DisplayName = "ranked losses",
    IsStatisticFolder = false,
    ParentDataName = "StatisticRankedRoundsPlayed",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticRankedRoundsPlayed2 and (StatisticRankedRoundsPlayed2.FullDisplayName .. " " or "") or "") .. "ranked losses",
    TostringFunction = pretty_number_tostring,
    Image = StatisticRankedRoundsPlayed2 and StatisticRankedRoundsPlayed2.Image or ""
};
u1.Info[v73.DataName] = v73;
table.insert(u1.Order, v73.DataName);
local StatisticRankedRoundsPlayed3 = u1.Info.StatisticRankedRoundsPlayed;
local v74 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticRankedRoundsWinPercent",
    DisplayName = "ranked win %",
    IsStatisticFolder = false,
    ParentDataName = "StatisticRankedRoundsPlayed",
    DefaultValue = -1,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticRankedRoundsPlayed3 and (StatisticRankedRoundsPlayed3.FullDisplayName .. " " or "") or "") .. "ranked win %",
    TostringFunction = percent_tostring or pretty_number_tostring,
    Image = StatisticRankedRoundsPlayed3 and StatisticRankedRoundsPlayed3.Image or ""
};
u1.Info[v74.DataName] = v74;
table.insert(u1.Order, v74.DataName);
local v75 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageDealt",
    DisplayName = "Damage Dealt",
    FullDisplayName = "Damage Dealt",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://18404346057",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v75.DataName] = v75;
table.insert(u1.Order, v75.DataName);
local StatisticDamageDealt = u1.Info.StatisticDamageDealt;
local v76 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageDealtSliding",
    DisplayName = "while sliding",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDamageDealt",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDamageDealt and (StatisticDamageDealt.FullDisplayName .. " " or "") or "") .. "while sliding",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDamageDealt and StatisticDamageDealt.Image or ""
};
u1.Info[v76.DataName] = v76;
table.insert(u1.Order, v76.DataName);
local StatisticDamageDealt2 = u1.Info.StatisticDamageDealt;
local v77 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageDealtCrouching",
    DisplayName = "while crouching",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDamageDealt",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDamageDealt2 and (StatisticDamageDealt2.FullDisplayName .. " " or "") or "") .. "while crouching",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDamageDealt2 and StatisticDamageDealt2.Image or ""
};
u1.Info[v77.DataName] = v77;
table.insert(u1.Order, v77.DataName);
local StatisticDamageDealt3 = u1.Info.StatisticDamageDealt;
local v78 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageDealtAirborne",
    DisplayName = "while airborne",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDamageDealt",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDamageDealt3 and (StatisticDamageDealt3.FullDisplayName .. " " or "") or "") .. "while airborne",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDamageDealt3 and StatisticDamageDealt3.Image or ""
};
u1.Info[v78.DataName] = v78;
table.insert(u1.Order, v78.DataName);
local StatisticDamageDealt4 = u1.Info.StatisticDamageDealt;
local v79 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageDealtBlinded",
    DisplayName = "while blinded",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDamageDealt",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDamageDealt4 and (StatisticDamageDealt4.FullDisplayName .. " " or "") or "") .. "while blinded",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDamageDealt4 and StatisticDamageDealt4.Image or ""
};
u1.Info[v79.DataName] = v79;
table.insert(u1.Order, v79.DataName);
local StatisticDamageDealt5 = u1.Info.StatisticDamageDealt;
local v80 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageDealtDead",
    DisplayName = "while dead",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDamageDealt",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDamageDealt5 and (StatisticDamageDealt5.FullDisplayName .. " " or "") or "") .. "while dead",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDamageDealt5 and StatisticDamageDealt5.Image or ""
};
u1.Info[v80.DataName] = v80;
table.insert(u1.Order, v80.DataName);
local StatisticDamageDealt6 = u1.Info.StatisticDamageDealt;
local v81 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageDealtNoscope",
    DisplayName = "while noscoping",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDamageDealt",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDamageDealt6 and (StatisticDamageDealt6.FullDisplayName .. " " or "") or "") .. "while noscoping",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDamageDealt6 and StatisticDamageDealt6.Image or ""
};
u1.Info[v81.DataName] = v81;
table.insert(u1.Order, v81.DataName);
local StatisticDamageDealt7 = u1.Info.StatisticDamageDealt;
local v82 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageDealtDashing",
    DisplayName = "while dashing",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDamageDealt",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDamageDealt7 and (StatisticDamageDealt7.FullDisplayName .. " " or "") or "") .. "while dashing",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDamageDealt7 and StatisticDamageDealt7.Image or ""
};
u1.Info[v82.DataName] = v82;
table.insert(u1.Order, v82.DataName);
local StatisticDamageDealt8 = u1.Info.StatisticDamageDealt;
local v83 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageDealtDeflecting",
    DisplayName = "from deflecting",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDamageDealt",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDamageDealt8 and (StatisticDamageDealt8.FullDisplayName .. " " or "") or "") .. "from deflecting",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDamageDealt8 and StatisticDamageDealt8.Image or ""
};
u1.Info[v83.DataName] = v83;
table.insert(u1.Order, v83.DataName);
local StatisticDamageDealt9 = u1.Info.StatisticDamageDealt;
local v84 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageDealtBouncing",
    DisplayName = "after a bounce",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDamageDealt",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDamageDealt9 and (StatisticDamageDealt9.FullDisplayName .. " " or "") or "") .. "after a bounce",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDamageDealt9 and StatisticDamageDealt9.Image or ""
};
u1.Info[v84.DataName] = v84;
table.insert(u1.Order, v84.DataName);
local StatisticDamageDealt10 = u1.Info.StatisticDamageDealt;
local v85 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageDealtGunMode",
    DisplayName = "in gun mode",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDamageDealt",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDamageDealt10 and (StatisticDamageDealt10.FullDisplayName .. " " or "") or "") .. "in gun mode",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDamageDealt10 and StatisticDamageDealt10.Image or ""
};
u1.Info[v85.DataName] = v85;
table.insert(u1.Order, v85.DataName);
local StatisticDamageDealt11 = u1.Info.StatisticDamageDealt;
local v86 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageDealtBladeMode",
    DisplayName = "in blade mode",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDamageDealt",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDamageDealt11 and (StatisticDamageDealt11.FullDisplayName .. " " or "") or "") .. "in blade mode",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDamageDealt11 and StatisticDamageDealt11.Image or ""
};
u1.Info[v86.DataName] = v86;
table.insert(u1.Order, v86.DataName);
local v87 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEliminations",
    DisplayName = "Eliminations",
    FullDisplayName = "Eliminations",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://17736790660",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v87.DataName] = v87;
table.insert(u1.Order, v87.DataName);
local StatisticEliminations = u1.Info.StatisticEliminations;
local v88 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEliminationsSliding",
    DisplayName = "while sliding",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEliminations",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEliminations and (StatisticEliminations.FullDisplayName .. " " or "") or "") .. "while sliding",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEliminations and StatisticEliminations.Image or ""
};
u1.Info[v88.DataName] = v88;
table.insert(u1.Order, v88.DataName);
local StatisticEliminations2 = u1.Info.StatisticEliminations;
local v89 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEliminationsCrouching",
    DisplayName = "while crouching",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEliminations",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEliminations2 and (StatisticEliminations2.FullDisplayName .. " " or "") or "") .. "while crouching",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEliminations2 and StatisticEliminations2.Image or ""
};
u1.Info[v89.DataName] = v89;
table.insert(u1.Order, v89.DataName);
local StatisticEliminations3 = u1.Info.StatisticEliminations;
local v90 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEliminationsAirborne",
    DisplayName = "while airborne",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEliminations",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEliminations3 and (StatisticEliminations3.FullDisplayName .. " " or "") or "") .. "while airborne",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEliminations3 and StatisticEliminations3.Image or ""
};
u1.Info[v90.DataName] = v90;
table.insert(u1.Order, v90.DataName);
local StatisticEliminations4 = u1.Info.StatisticEliminations;
local v91 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEliminationsBlinded",
    DisplayName = "while blinded",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEliminations",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEliminations4 and (StatisticEliminations4.FullDisplayName .. " " or "") or "") .. "while blinded",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEliminations4 and StatisticEliminations4.Image or ""
};
u1.Info[v91.DataName] = v91;
table.insert(u1.Order, v91.DataName);
local StatisticEliminations5 = u1.Info.StatisticEliminations;
local v92 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEliminationsDead",
    DisplayName = "while dead",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEliminations",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEliminations5 and (StatisticEliminations5.FullDisplayName .. " " or "") or "") .. "while dead",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEliminations5 and StatisticEliminations5.Image or ""
};
u1.Info[v92.DataName] = v92;
table.insert(u1.Order, v92.DataName);
local StatisticEliminations6 = u1.Info.StatisticEliminations;
local v93 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEliminationsNoscope",
    DisplayName = "while noscoping",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEliminations",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEliminations6 and (StatisticEliminations6.FullDisplayName .. " " or "") or "") .. "while noscoping",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEliminations6 and StatisticEliminations6.Image or ""
};
u1.Info[v93.DataName] = v93;
table.insert(u1.Order, v93.DataName);
local StatisticEliminations7 = u1.Info.StatisticEliminations;
local v94 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEliminationsDashing",
    DisplayName = "while dashing",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEliminations",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEliminations7 and (StatisticEliminations7.FullDisplayName .. " " or "") or "") .. "while dashing",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEliminations7 and StatisticEliminations7.Image or ""
};
u1.Info[v94.DataName] = v94;
table.insert(u1.Order, v94.DataName);
local StatisticEliminations8 = u1.Info.StatisticEliminations;
local v95 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEliminationsDeflecting",
    DisplayName = "from deflecting",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEliminations",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEliminations8 and (StatisticEliminations8.FullDisplayName .. " " or "") or "") .. "from deflecting",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEliminations8 and StatisticEliminations8.Image or ""
};
u1.Info[v95.DataName] = v95;
table.insert(u1.Order, v95.DataName);
local StatisticEliminations9 = u1.Info.StatisticEliminations;
local v96 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEliminationsBouncing",
    DisplayName = "after a bounce",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEliminations",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEliminations9 and (StatisticEliminations9.FullDisplayName .. " " or "") or "") .. "after a bounce",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEliminations9 and StatisticEliminations9.Image or ""
};
u1.Info[v96.DataName] = v96;
table.insert(u1.Order, v96.DataName);
local StatisticEliminations10 = u1.Info.StatisticEliminations;
local v97 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEliminationsGunMode",
    DisplayName = "in gun mode",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEliminations",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEliminations10 and (StatisticEliminations10.FullDisplayName .. " " or "") or "") .. "in gun mode",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEliminations10 and StatisticEliminations10.Image or ""
};
u1.Info[v97.DataName] = v97;
table.insert(u1.Order, v97.DataName);
local StatisticEliminations11 = u1.Info.StatisticEliminations;
local v98 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEliminationsBladeMode",
    DisplayName = "in blade mode",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEliminations",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEliminations11 and (StatisticEliminations11.FullDisplayName .. " " or "") or "") .. "in blade mode",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEliminations11 and StatisticEliminations11.Image or ""
};
u1.Info[v98.DataName] = v98;
table.insert(u1.Order, v98.DataName);
local v99 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDeaths",
    DisplayName = "Deaths",
    FullDisplayName = "Deaths",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v99.DataName] = v99;
table.insert(u1.Order, v99.DataName);
local StatisticDeaths = u1.Info.StatisticDeaths;
local v101 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDeathsRatio",
    DisplayName = "eliminations ratio",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDeaths",
    DefaultValue = -1,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDeaths and (StatisticDeaths.FullDisplayName .. " " or "") or "") .. "eliminations ratio",
    TostringFunction = function(p100) -- Line: 194
        return p100 == -1 and "N/A" or string.format("%.2f", p100);
    end or pretty_number_tostring,
    Image = StatisticDeaths and StatisticDeaths.Image or ""
};
u1.Info[v101.DataName] = v101;
table.insert(u1.Order, v101.DataName);
local v102 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticAssists",
    DisplayName = "Assists",
    FullDisplayName = "Assists",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v102.DataName] = v102;
table.insert(u1.Order, v102.DataName);
local StatisticAssists = u1.Info.StatisticAssists;
local v103 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticAssistsDead",
    DisplayName = "while dead",
    IsStatisticFolder = false,
    ParentDataName = "StatisticAssists",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticAssists and (StatisticAssists.FullDisplayName .. " " or "") or "") .. "while dead",
    TostringFunction = pretty_number_tostring,
    Image = StatisticAssists and StatisticAssists.Image or ""
};
u1.Info[v103.DataName] = v103;
table.insert(u1.Order, v103.DataName);
local v104 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDamageReceived",
    DisplayName = "Damage Received",
    FullDisplayName = "Damage Received",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v104.DataName] = v104;
table.insert(u1.Order, v104.DataName);
local v105 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticHealsReceived",
    DisplayName = "Heals Received",
    FullDisplayName = "Heals Received",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v105.DataName] = v105;
table.insert(u1.Order, v105.DataName);
local v106 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticHealsGiven",
    DisplayName = "Heals Given",
    FullDisplayName = "Heals Given",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://102083156692899",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v106.DataName] = v106;
table.insert(u1.Order, v106.DataName);
local StatisticHealsGiven = u1.Info.StatisticHealsGiven;
local v107 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticHealsGivenTeammates",
    DisplayName = "to teammates",
    IsStatisticFolder = false,
    ParentDataName = "StatisticHealsGiven",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticHealsGiven and (StatisticHealsGiven.FullDisplayName .. " " or "") or "") .. "to teammates",
    TostringFunction = pretty_number_tostring,
    Image = StatisticHealsGiven and StatisticHealsGiven.Image or ""
};
u1.Info[v107.DataName] = v107;
table.insert(u1.Order, v107.DataName);
local v108 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticUses",
    DisplayName = "Uses",
    FullDisplayName = "Uses",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v108.DataName] = v108;
table.insert(u1.Order, v108.DataName);
local StatisticUses = u1.Info.StatisticUses;
local v109 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticUsesQuick",
    DisplayName = "quick uses",
    IsStatisticFolder = false,
    ParentDataName = "StatisticUses",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticUses and (StatisticUses.FullDisplayName .. " " or "") or "") .. "quick uses",
    TostringFunction = pretty_number_tostring,
    Image = StatisticUses and StatisticUses.Image or ""
};
u1.Info[v109.DataName] = v109;
table.insert(u1.Order, v109.DataName);
local StatisticUses2 = u1.Info.StatisticUses;
local v110 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticUsesHits",
    DisplayName = "hits",
    IsStatisticFolder = false,
    ParentDataName = "StatisticUses",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticUses2 and (StatisticUses2.FullDisplayName .. " " or "") or "") .. "hits",
    TostringFunction = pretty_number_tostring,
    Image = StatisticUses2 and StatisticUses2.Image or ""
};
u1.Info[v110.DataName] = v110;
table.insert(u1.Order, v110.DataName);
local StatisticUses3 = u1.Info.StatisticUses;
local v111 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticUsesHitPercent",
    DisplayName = "hit %",
    IsStatisticFolder = false,
    ParentDataName = "StatisticUses",
    DefaultValue = -1,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticUses3 and (StatisticUses3.FullDisplayName .. " " or "") or "") .. "hit %",
    TostringFunction = percent_tostring or pretty_number_tostring,
    Image = StatisticUses3 and StatisticUses3.Image or ""
};
u1.Info[v111.DataName] = v111;
table.insert(u1.Order, v111.DataName);
local StatisticUses4 = u1.Info.StatisticUses;
local v112 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticUsesCriticalHits",
    DisplayName = "critical hits",
    IsStatisticFolder = false,
    ParentDataName = "StatisticUses",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticUses4 and (StatisticUses4.FullDisplayName .. " " or "") or "") .. "critical hits",
    TostringFunction = pretty_number_tostring,
    Image = StatisticUses4 and StatisticUses4.Image or ""
};
u1.Info[v112.DataName] = v112;
table.insert(u1.Order, v112.DataName);
local StatisticUses5 = u1.Info.StatisticUses;
local v113 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticUsesCriticalHitPercent",
    DisplayName = "critical hit %",
    IsStatisticFolder = false,
    ParentDataName = "StatisticUses",
    DefaultValue = -1,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticUses5 and (StatisticUses5.FullDisplayName .. " " or "") or "") .. "critical hit %",
    TostringFunction = percent_tostring or pretty_number_tostring,
    Image = StatisticUses5 and StatisticUses5.Image or ""
};
u1.Info[v113.DataName] = v113;
table.insert(u1.Order, v113.DataName);
local StatisticUses6 = u1.Info.StatisticUses;
local v114 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticUsesHitsSelf",
    DisplayName = "self hits",
    IsStatisticFolder = false,
    ParentDataName = "StatisticUses",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticUses6 and (StatisticUses6.FullDisplayName .. " " or "") or "") .. "self hits",
    TostringFunction = pretty_number_tostring,
    Image = StatisticUses6 and StatisticUses6.Image or ""
};
u1.Info[v114.DataName] = v114;
table.insert(u1.Order, v114.DataName);
local StatisticUses7 = u1.Info.StatisticUses;
local v115 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticUsesHitsDirect",
    DisplayName = "direct hits",
    IsStatisticFolder = false,
    ParentDataName = "StatisticUses",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticUses7 and (StatisticUses7.FullDisplayName .. " " or "") or "") .. "direct hits",
    TostringFunction = pretty_number_tostring,
    Image = StatisticUses7 and StatisticUses7.Image or ""
};
u1.Info[v115.DataName] = v115;
table.insert(u1.Order, v115.DataName);
local v116 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticInspects",
    DisplayName = "Inspects",
    FullDisplayName = "Inspects",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v116.DataName] = v116;
table.insert(u1.Order, v116.DataName);
local StatisticInspects = u1.Info.StatisticInspects;
local v117 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticInspectsAfterElimination",
    DisplayName = "after an elimination",
    IsStatisticFolder = false,
    ParentDataName = "StatisticInspects",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticInspects and (StatisticInspects.FullDisplayName .. " " or "") or "") .. "after an elimination",
    TostringFunction = pretty_number_tostring,
    Image = StatisticInspects and StatisticInspects.Image or ""
};
u1.Info[v117.DataName] = v117;
table.insert(u1.Order, v117.DataName);
local v118 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticAmmoUsed",
    DisplayName = "Ammo Used",
    FullDisplayName = "Ammo Used",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v118.DataName] = v118;
table.insert(u1.Order, v118.DataName);
local v119 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticReloads",
    DisplayName = "Reloads",
    FullDisplayName = "Reloads",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v119.DataName] = v119;
table.insert(u1.Order, v119.DataName);
local v120 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticAirblasts",
    DisplayName = "Airblasts",
    FullDisplayName = "Airblasts",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v120.DataName] = v120;
table.insert(u1.Order, v120.DataName);
local StatisticAirblasts = u1.Info.StatisticAirblasts;
local v121 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticAirblastsHits",
    DisplayName = "players blasted",
    IsStatisticFolder = false,
    ParentDataName = "StatisticAirblasts",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticAirblasts and (StatisticAirblasts.FullDisplayName .. " " or "") or "") .. "players blasted",
    TostringFunction = pretty_number_tostring,
    Image = StatisticAirblasts and StatisticAirblasts.Image or ""
};
u1.Info[v121.DataName] = v121;
table.insert(u1.Order, v121.DataName);
local StatisticAirblasts2 = u1.Info.StatisticAirblasts;
local v122 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticAirblastsSmokesCleared",
    DisplayName = "smokes blasted",
    IsStatisticFolder = false,
    ParentDataName = "StatisticAirblasts",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticAirblasts2 and (StatisticAirblasts2.FullDisplayName .. " " or "") or "") .. "smokes blasted",
    TostringFunction = pretty_number_tostring,
    Image = StatisticAirblasts2 and StatisticAirblasts2.Image or ""
};
u1.Info[v122.DataName] = v122;
table.insert(u1.Order, v122.DataName);
local v123 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDashes",
    DisplayName = "Dashes",
    FullDisplayName = "Dashes",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v123.DataName] = v123;
table.insert(u1.Order, v123.DataName);
local v124 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticWallsBuilt",
    DisplayName = "Walls Built",
    FullDisplayName = "Walls Built",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v124.DataName] = v124;
table.insert(u1.Order, v124.DataName);
local StatisticWallsBuilt = u1.Info.StatisticWallsBuilt;
local v125 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticWallsBuiltBricksLayed",
    DisplayName = "bricks layed",
    IsStatisticFolder = false,
    ParentDataName = "StatisticWallsBuilt",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticWallsBuilt and (StatisticWallsBuilt.FullDisplayName .. " " or "") or "") .. "bricks layed",
    TostringFunction = pretty_number_tostring,
    Image = StatisticWallsBuilt and StatisticWallsBuilt.Image or ""
};
u1.Info[v125.DataName] = v125;
table.insert(u1.Order, v125.DataName);
local v126 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDeflects",
    DisplayName = "Deflects",
    FullDisplayName = "Deflects",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v126.DataName] = v126;
table.insert(u1.Order, v126.DataName);
local StatisticDeflects = u1.Info.StatisticDeflects;
local v127 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDeflectsHits",
    DisplayName = "hits",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDeflects",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDeflects and (StatisticDeflects.FullDisplayName .. " " or "") or "") .. "hits",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDeflects and StatisticDeflects.Image or ""
};
u1.Info[v127.DataName] = v127;
table.insert(u1.Order, v127.DataName);
local StatisticDeflects2 = u1.Info.StatisticDeflects;
local v128 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticDeflectsCriticalHits",
    DisplayName = "critical hits",
    IsStatisticFolder = false,
    ParentDataName = "StatisticDeflects",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticDeflects2 and (StatisticDeflects2.FullDisplayName .. " " or "") or "") .. "critical hits",
    TostringFunction = pretty_number_tostring,
    Image = StatisticDeflects2 and StatisticDeflects2.Image or ""
};
u1.Info[v128.DataName] = v128;
table.insert(u1.Order, v128.DataName);
local v129 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticExtinguishes",
    DisplayName = "Extinguishes",
    FullDisplayName = "Extinguishes",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v129.DataName] = v129;
table.insert(u1.Order, v129.DataName);
local StatisticExtinguishes = u1.Info.StatisticExtinguishes;
local v130 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticExtinguishesPlayers",
    DisplayName = "players",
    IsStatisticFolder = false,
    ParentDataName = "StatisticExtinguishes",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticExtinguishes and (StatisticExtinguishes.FullDisplayName .. " " or "") or "") .. "players",
    TostringFunction = pretty_number_tostring,
    Image = StatisticExtinguishes and StatisticExtinguishes.Image or ""
};
u1.Info[v130.DataName] = v130;
table.insert(u1.Order, v130.DataName);
local StatisticExtinguishes2 = u1.Info.StatisticExtinguishes;
local v131 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticExtinguishesMolotovs",
    DisplayName = "molotovs",
    IsStatisticFolder = false,
    ParentDataName = "StatisticExtinguishes",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticExtinguishes2 and (StatisticExtinguishes2.FullDisplayName .. " " or "") or "") .. "molotovs",
    TostringFunction = pretty_number_tostring,
    Image = StatisticExtinguishes2 and StatisticExtinguishes2.Image or ""
};
u1.Info[v131.DataName] = v131;
table.insert(u1.Order, v131.DataName);
local StatisticExtinguishes3 = u1.Info.StatisticExtinguishes;
local v132 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticExtinguishesFlareGuns",
    DisplayName = "flare guns",
    IsStatisticFolder = false,
    ParentDataName = "StatisticExtinguishes",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticExtinguishes3 and (StatisticExtinguishes3.FullDisplayName .. " " or "") or "") .. "flare guns",
    TostringFunction = pretty_number_tostring,
    Image = StatisticExtinguishes3 and StatisticExtinguishes3.Image or ""
};
u1.Info[v132.DataName] = v132;
table.insert(u1.Order, v132.DataName);
local StatisticExtinguishes4 = u1.Info.StatisticExtinguishes;
local v133 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticExtinguishesFlamethrowers",
    DisplayName = "flamethrowers",
    IsStatisticFolder = false,
    ParentDataName = "StatisticExtinguishes",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticExtinguishes4 and (StatisticExtinguishes4.FullDisplayName .. " " or "") or "") .. "flamethrowers",
    TostringFunction = pretty_number_tostring,
    Image = StatisticExtinguishes4 and StatisticExtinguishes4.Image or ""
};
u1.Info[v133.DataName] = v133;
table.insert(u1.Order, v133.DataName);
local v134 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticBlinds",
    DisplayName = "Players Blinded",
    FullDisplayName = "Players Blinded",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://17814211801",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v134.DataName] = v134;
table.insert(u1.Order, v134.DataName);
local StatisticBlinds = u1.Info.StatisticBlinds;
local v135 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticBlindsSelf",
    DisplayName = "self blinded",
    IsStatisticFolder = false,
    ParentDataName = "StatisticBlinds",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticBlinds and (StatisticBlinds.FullDisplayName .. " " or "") or "") .. "self blinded",
    TostringFunction = pretty_number_tostring,
    Image = StatisticBlinds and StatisticBlinds.Image or ""
};
u1.Info[v135.DataName] = v135;
table.insert(u1.Order, v135.DataName);
local StatisticBlinds2 = u1.Info.StatisticBlinds;
local v136 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticBlindsEnemies",
    DisplayName = "enemies blinded",
    FullDisplayName = "Enemies Blinded",
    IsStatisticFolder = false,
    ParentDataName = "StatisticBlinds",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring,
    Image = StatisticBlinds2 and StatisticBlinds2.Image or ""
};
u1.Info[v136.DataName] = v136;
table.insert(u1.Order, v136.DataName);
local StatisticBlinds3 = u1.Info.StatisticBlinds;
local v137 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticBlindsTeammates",
    DisplayName = "teammates blinded",
    IsStatisticFolder = false,
    ParentDataName = "StatisticBlinds",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticBlinds3 and (StatisticBlinds3.FullDisplayName .. " " or "") or "") .. "teammates blinded",
    TostringFunction = pretty_number_tostring,
    Image = StatisticBlinds3 and StatisticBlinds3.Image or ""
};
u1.Info[v137.DataName] = v137;
table.insert(u1.Order, v137.DataName);
local v138 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticSmokeds",
    DisplayName = "Players Smoked",
    FullDisplayName = "Players Smoked",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://18387088796",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v138.DataName] = v138;
table.insert(u1.Order, v138.DataName);
local StatisticSmokeds = u1.Info.StatisticSmokeds;
local v139 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticSmokedsSelf",
    DisplayName = "self smoked",
    IsStatisticFolder = false,
    ParentDataName = "StatisticSmokeds",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticSmokeds and (StatisticSmokeds.FullDisplayName .. " " or "") or "") .. "self smoked",
    TostringFunction = pretty_number_tostring,
    Image = StatisticSmokeds and StatisticSmokeds.Image or ""
};
u1.Info[v139.DataName] = v139;
table.insert(u1.Order, v139.DataName);
local StatisticSmokeds2 = u1.Info.StatisticSmokeds;
local v140 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticSmokedsEnemies",
    DisplayName = "enemies smoked",
    FullDisplayName = "Enemies Smoked",
    IsStatisticFolder = false,
    ParentDataName = "StatisticSmokeds",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring,
    Image = StatisticSmokeds2 and StatisticSmokeds2.Image or ""
};
u1.Info[v140.DataName] = v140;
table.insert(u1.Order, v140.DataName);
local StatisticSmokeds3 = u1.Info.StatisticSmokeds;
local v141 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticSmokedsTeammates",
    DisplayName = "teammates smoked",
    IsStatisticFolder = false,
    ParentDataName = "StatisticSmokeds",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticSmokeds3 and (StatisticSmokeds3.FullDisplayName .. " " or "") or "") .. "teammates smoked",
    TostringFunction = pretty_number_tostring,
    Image = StatisticSmokeds3 and StatisticSmokeds3.Image or ""
};
u1.Info[v141.DataName] = v141;
table.insert(u1.Order, v141.DataName);
local v142 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticFreezes",
    DisplayName = "Players Frozen",
    FullDisplayName = "Players Frozen",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://18428668944",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v142.DataName] = v142;
table.insert(u1.Order, v142.DataName);
local StatisticFreezes = u1.Info.StatisticFreezes;
local v143 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticFreezesSelf",
    DisplayName = "self freezes",
    IsStatisticFolder = false,
    ParentDataName = "StatisticFreezes",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticFreezes and (StatisticFreezes.FullDisplayName .. " " or "") or "") .. "self freezes",
    TostringFunction = pretty_number_tostring,
    Image = StatisticFreezes and StatisticFreezes.Image or ""
};
u1.Info[v143.DataName] = v143;
table.insert(u1.Order, v143.DataName);
local StatisticFreezes2 = u1.Info.StatisticFreezes;
local v144 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticFreezesEnemies",
    DisplayName = "enemies frozen",
    FullDisplayName = "Enemies Frozen",
    IsStatisticFolder = false,
    ParentDataName = "StatisticFreezes",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring,
    Image = StatisticFreezes2 and StatisticFreezes2.Image or ""
};
u1.Info[v144.DataName] = v144;
table.insert(u1.Order, v144.DataName);
local v145 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEmpowers",
    DisplayName = "Players Empowered",
    FullDisplayName = "Players Empowered",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://86874311663826",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v145.DataName] = v145;
table.insert(u1.Order, v145.DataName);
local StatisticEmpowers = u1.Info.StatisticEmpowers;
local v146 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEmpowersSelf",
    DisplayName = "self empowers",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEmpowers",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEmpowers and (StatisticEmpowers.FullDisplayName .. " " or "") or "") .. "self empowers",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEmpowers and StatisticEmpowers.Image or ""
};
u1.Info[v146.DataName] = v146;
table.insert(u1.Order, v146.DataName);
local StatisticEmpowers2 = u1.Info.StatisticEmpowers;
local v147 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticEmpowersTeammates",
    DisplayName = "teammates empowered",
    IsStatisticFolder = false,
    ParentDataName = "StatisticEmpowers",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticEmpowers2 and (StatisticEmpowers2.FullDisplayName .. " " or "") or "") .. "teammates empowered",
    TostringFunction = pretty_number_tostring,
    Image = StatisticEmpowers2 and StatisticEmpowers2.Image or ""
};
u1.Info[v147.DataName] = v147;
table.insert(u1.Order, v147.DataName);
local v148 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticAbsorbs",
    DisplayName = "Damage Absorbed",
    FullDisplayName = "Damage Absorbed",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://106392169866153",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v148.DataName] = v148;
table.insert(u1.Order, v148.DataName);
local StatisticAbsorbs = u1.Info.StatisticAbsorbs;
local v149 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticAbsorbsBehind",
    DisplayName = "from behind",
    IsStatisticFolder = false,
    ParentDataName = "StatisticAbsorbs",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticAbsorbs and (StatisticAbsorbs.FullDisplayName .. " " or "") or "") .. "from behind",
    TostringFunction = pretty_number_tostring,
    Image = StatisticAbsorbs and StatisticAbsorbs.Image or ""
};
u1.Info[v149.DataName] = v149;
table.insert(u1.Order, v149.DataName);
local v150 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticBounces",
    DisplayName = "Players Bounced",
    FullDisplayName = "Players Bounced",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://18436038478",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v150.DataName] = v150;
table.insert(u1.Order, v150.DataName);
local StatisticBounces = u1.Info.StatisticBounces;
local v151 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticBouncesSelf",
    DisplayName = "self bounces",
    IsStatisticFolder = false,
    ParentDataName = "StatisticBounces",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticBounces and (StatisticBounces.FullDisplayName .. " " or "") or "") .. "self bounces",
    TostringFunction = pretty_number_tostring,
    Image = StatisticBounces and StatisticBounces.Image or ""
};
u1.Info[v151.DataName] = v151;
table.insert(u1.Order, v151.DataName);
local StatisticBounces2 = u1.Info.StatisticBounces;
local v152 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticBouncesTeammates",
    DisplayName = "teammates bounced",
    IsStatisticFolder = false,
    ParentDataName = "StatisticBounces",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticBounces2 and (StatisticBounces2.FullDisplayName .. " " or "") or "") .. "teammates bounced",
    TostringFunction = pretty_number_tostring,
    Image = StatisticBounces2 and StatisticBounces2.Image or ""
};
u1.Info[v152.DataName] = v152;
table.insert(u1.Order, v152.DataName);
local StatisticBounces3 = u1.Info.StatisticBounces;
local v153 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticBouncesEnemies",
    DisplayName = "enemies bounced",
    IsStatisticFolder = false,
    ParentDataName = "StatisticBounces",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticBounces3 and (StatisticBounces3.FullDisplayName .. " " or "") or "") .. "enemies bounced",
    TostringFunction = pretty_number_tostring,
    Image = StatisticBounces3 and StatisticBounces3.Image or ""
};
u1.Info[v153.DataName] = v153;
table.insert(u1.Order, v153.DataName);
local v154 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticVortexesSpawned",
    DisplayName = "Vortexes Spawned",
    FullDisplayName = "Vortexes Spawned",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v154.DataName] = v154;
table.insert(u1.Order, v154.DataName);
local v155 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticPortalsSpawned",
    DisplayName = "Portals Spawned",
    FullDisplayName = "Portals Spawned",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://76793585944473",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v155.DataName] = v155;
table.insert(u1.Order, v155.DataName);
local v156 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticWarps",
    DisplayName = "Warps",
    FullDisplayName = "Warps",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://17735783844",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v156.DataName] = v156;
table.insert(u1.Order, v156.DataName);
local v157 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticLeaps",
    DisplayName = "Leaps",
    FullDisplayName = "Leaps",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v157.DataName] = v157;
table.insert(u1.Order, v157.DataName);
local v158 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticSlams",
    DisplayName = "Slams",
    FullDisplayName = "Slams",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v158.DataName] = v158;
table.insert(u1.Order, v158.DataName);
local StatisticSlams = u1.Info.StatisticSlams;
local v159 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticSlamsHits",
    DisplayName = "hits",
    IsStatisticFolder = false,
    ParentDataName = "StatisticSlams",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticSlams and (StatisticSlams.FullDisplayName .. " " or "") or "") .. "hits",
    TostringFunction = pretty_number_tostring,
    Image = StatisticSlams and StatisticSlams.Image or ""
};
u1.Info[v159.DataName] = v159;
table.insert(u1.Order, v159.DataName);
local v160 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticHooks",
    DisplayName = "Hooks",
    FullDisplayName = "Hooks",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "rbxassetid://101933751328343",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v160.DataName] = v160;
table.insert(u1.Order, v160.DataName);
local StatisticHooks = u1.Info.StatisticHooks;
local v161 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticHooksEnvironment",
    DisplayName = "environment",
    IsStatisticFolder = false,
    ParentDataName = "StatisticHooks",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticHooks and (StatisticHooks.FullDisplayName .. " " or "") or "") .. "environment",
    TostringFunction = pretty_number_tostring,
    Image = StatisticHooks and StatisticHooks.Image or ""
};
u1.Info[v161.DataName] = v161;
table.insert(u1.Order, v161.DataName);
local StatisticHooks2 = u1.Info.StatisticHooks;
local v162 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticHooksEnemies",
    DisplayName = "enemies",
    FullDisplayName = "Enemies Hooked",
    IsStatisticFolder = false,
    ParentDataName = "StatisticHooks",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring,
    Image = StatisticHooks2 and StatisticHooks2.Image or ""
};
u1.Info[v162.DataName] = v162;
table.insert(u1.Order, v162.DataName);
local v163 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticThrows",
    DisplayName = "Throws",
    FullDisplayName = "Throws",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v163.DataName] = v163;
table.insert(u1.Order, v163.DataName);
local StatisticThrows = u1.Info.StatisticThrows;
local v164 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticThrowsPierces",
    DisplayName = "enemies pierced",
    IsStatisticFolder = false,
    ParentDataName = "StatisticThrows",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticThrows and (StatisticThrows.FullDisplayName .. " " or "") or "") .. "enemies pierced",
    TostringFunction = pretty_number_tostring,
    Image = StatisticThrows and StatisticThrows.Image or ""
};
u1.Info[v164.DataName] = v164;
table.insert(u1.Order, v164.DataName);
local StatisticThrows2 = u1.Info.StatisticThrows;
local v165 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticThrowsWalls",
    DisplayName = "walls hit",
    IsStatisticFolder = false,
    ParentDataName = "StatisticThrows",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticThrows2 and (StatisticThrows2.FullDisplayName .. " " or "") or "") .. "walls hit",
    TostringFunction = pretty_number_tostring,
    Image = StatisticThrows2 and StatisticThrows2.Image or ""
};
u1.Info[v165.DataName] = v165;
table.insert(u1.Order, v165.DataName);
local v166 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticPaintGrenades",
    DisplayName = "Paint Grenades",
    FullDisplayName = "Paint Grenades",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v166.DataName] = v166;
table.insert(u1.Order, v166.DataName);
local StatisticPaintGrenades = u1.Info.StatisticPaintGrenades;
local v167 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticPaintGrenadesHits",
    DisplayName = "hits",
    IsStatisticFolder = false,
    ParentDataName = "StatisticPaintGrenades",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticPaintGrenades and (StatisticPaintGrenades.FullDisplayName .. " " or "") or "") .. "hits",
    TostringFunction = pretty_number_tostring,
    Image = StatisticPaintGrenades and StatisticPaintGrenades.Image or ""
};
u1.Info[v167.DataName] = v167;
table.insert(u1.Order, v167.DataName);
local v168 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticBackstabs",
    DisplayName = "Backstabs",
    FullDisplayName = "Backstabs",
    IsStatisticFolder = false,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v168.DataName] = v168;
table.insert(u1.Order, v168.DataName);
local v169 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = nil,
    DataName = "StatisticZombies",
    DisplayName = "Monsters",
    FullDisplayName = "Monsters",
    IsStatisticFolder = true,
    ParentDataName = nil,
    DefaultValue = 0,
    ValueType = "number",
    Image = "",
    Index = #u1.Order + 1,
    TostringFunction = pretty_number_tostring
};
u1.Info[v169.DataName] = v169;
table.insert(u1.Order, v169.DataName);
local StatisticZombies = u1.Info.StatisticZombies;
local v170 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = true,
    DataName = "StatisticZombiesDamageDealt",
    DisplayName = "damage dealt",
    IsStatisticFolder = false,
    ParentDataName = "StatisticZombies",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticZombies and (StatisticZombies.FullDisplayName .. " " or "") or "") .. "damage dealt",
    TostringFunction = pretty_number_tostring,
    Image = StatisticZombies and StatisticZombies.Image or ""
};
u1.Info[v170.DataName] = v170;
table.insert(u1.Order, v170.DataName);
local StatisticZombies2 = u1.Info.StatisticZombies;
local v171 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = true,
    DataName = "StatisticZombiesEliminations",
    DisplayName = "eliminations",
    IsStatisticFolder = false,
    ParentDataName = "StatisticZombies",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticZombies2 and (StatisticZombies2.FullDisplayName .. " " or "") or "") .. "eliminations",
    TostringFunction = pretty_number_tostring,
    Image = StatisticZombies2 and StatisticZombies2.Image or ""
};
u1.Info[v171.DataName] = v171;
table.insert(u1.Order, v171.DataName);
local StatisticZombies3 = u1.Info.StatisticZombies;
local v172 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = true,
    DataName = "StatisticZombieTowerCompletions",
    DisplayName = "Zombie Tower wins",
    IsStatisticFolder = false,
    ParentDataName = "StatisticZombies",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticZombies3 and (StatisticZombies3.FullDisplayName .. " " or "") or "") .. "Zombie Tower wins",
    TostringFunction = pretty_number_tostring,
    Image = StatisticZombies3 and StatisticZombies3.Image or ""
};
u1.Info[v172.DataName] = v172;
table.insert(u1.Order, v172.DataName);
local StatisticZombies4 = u1.Info.StatisticZombies;
local v173 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = true,
    DataName = "StatisticZombieTowerSpeedrun",
    DisplayName = "Zombie Tower speedrun",
    IsStatisticFolder = false,
    ParentDataName = "StatisticZombies",
    DefaultValue = -1,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticZombies4 and (StatisticZombies4.FullDisplayName .. " " or "") or "") .. "Zombie Tower speedrun",
    TostringFunction = playtime_precise_tostring or pretty_number_tostring,
    Image = StatisticZombies4 and StatisticZombies4.Image or ""
};
u1.Info[v173.DataName] = v173;
table.insert(u1.Order, v173.DataName);
local StatisticZombies5 = u1.Info.StatisticZombies;
local v174 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = true,
    DataName = "StatisticGargoyleTowerCompletions",
    DisplayName = "Gargoyle Tower wins",
    IsStatisticFolder = false,
    ParentDataName = "StatisticZombies",
    DefaultValue = 0,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticZombies5 and (StatisticZombies5.FullDisplayName .. " " or "") or "") .. "Gargoyle Tower wins",
    TostringFunction = pretty_number_tostring,
    Image = StatisticZombies5 and StatisticZombies5.Image or ""
};
u1.Info[v174.DataName] = v174;
table.insert(u1.Order, v174.DataName);
local StatisticZombies6 = u1.Info.StatisticZombies;
local v175 = {
    IsCareerStatistic = true,
    OnlyDisplayAboveZero = true,
    DataName = "StatisticGargoyleTowerSpeedrun",
    DisplayName = "Gargoyle Tower speedrun",
    IsStatisticFolder = false,
    ParentDataName = "StatisticZombies",
    DefaultValue = -1,
    ValueType = "number",
    Index = #u1.Order + 1,
    FullDisplayName = (StatisticZombies6 and (StatisticZombies6.FullDisplayName .. " " or "") or "") .. "Gargoyle Tower speedrun",
    TostringFunction = playtime_precise_tostring or pretty_number_tostring,
    Image = StatisticZombies6 and StatisticZombies6.Image or ""
};
u1.Info[v175.DataName] = v175;
table.insert(u1.Order, v175.DataName);

local function add_item(p176, p177, p178) -- Line: 270
    -- upvalues: u1 (copy)
    local v179 = {};

    for _, v in pairs(p177) do
        table.insert(v179, "Statistic" .. v);
    end;

    u1.Items[p176] = {
        DataNames = v179,
        Descriptions = p178
    };
end;

add_item(
    "MISSING_WEAPON",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "Note to self" } }
);
add_item(
    "Flare Gun",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Shoots a fireball that constantly burns nearby enemies" } }
);
add_item(
    "Assault Rifle",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "A standard rifle useful in all scenarios" } }
);
add_item(
    "Handgun",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "A reliable sidearm useful in all scenarios" } }
);
add_item(
    "Burst Rifle",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Hit and run with this three-round burst rifle" } }
);
add_item(
    "Sniper",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "DamageDealtNoscope", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "EliminationsNoscope", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Long ranged rifle that can deal devastating damage" } }
);
add_item(
    "RPG",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHitsSelf", "UsesHits", "UsesHitPercent", "UsesHitsDirect", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "A powerful explosive launcher" } }
);
add_item(
    "Shorty",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "A quick sidearm that can be deadly up close" } }
);
add_item(
    "Shotgun",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "Deadly up close" } }
);
add_item(
    "Bow",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Projectile weapon that rewards accuracy" }, { 2, "Charge up your arrows to deal heavy damage" }, { 1, "Allows you to double jump" } }
);
add_item(
    "Uzi",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Light enemies up with this automatic sidearm" }, { 1, "Slightly inaccurate" } }
);
add_item(
    "Revolver",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "A slow but powerful handgun" }, { 2, "Fan the hammer to unload the entire chamber" } }
);
add_item(
    "Paintball Gun",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "PaintGrenades", "PaintGrenadesHits", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Splatter your enemies screens with this colorful rifle" } }
);
add_item(
    "Slingshot",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "DamageDealtBouncing", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "EliminationsBouncing", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "Unleash a barrage of bouncy balls" } }
);
add_item(
    "Grenade Launcher",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHitsSelf", "UsesHits", "UsesHitPercent", "UsesHitsDirect", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Quickly rain explosives on your enemies" }, { 2, "Switch between impact grenades and bouncy grenades" } }
);
add_item(
    "Minigun",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "Probably dangerous" } }
);
add_item(
    "Exogun",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "Pew pew pew" } }
);
add_item(
    "Fists",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "Inspects", "InspectsAfterElimination", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "Allows you to double jump" } }
);
add_item(
    "Knife",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "Backstabs", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Backstab enemies for an instant elimination" } }
);
add_item(
    "Chainsaw",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Mow enemies down at frightening speeds" } }
);
add_item(
    "Katana",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "DamageDealtDeflecting", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "EliminationsDeflecting", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "Inspects", "InspectsAfterElimination", "Deflects", "DeflectsHits", "DeflectsCriticalHits", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Can deflect bullets back at enemies" } }
);
add_item(
    "Scythe",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "DamageDealtDashing", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "EliminationsDashing", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "Inspects", "InspectsAfterElimination", "Dashes", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Allows you to quickly dash in any direction" } }
);
add_item(
    "Trowel",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "Inspects", "InspectsAfterElimination", "WallsBuilt", "WallsBuiltBricksLayed", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "Build walls to defend yourself" }, { 2, "Send the bricks flying to harden them in place" } }
);
add_item(
    "Grenade",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHitsSelf", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "Quick & reliable explosive" } }
);
add_item(
    "Molotov",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "An unethical way of setting your enemies on fire" } }
);
add_item(
    "Flashbang",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "Blinds", "BlindsSelf", "BlindsEnemies", "BlindsTeammates", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "Blinds enemies for a long time" } }
);
add_item(
    "Smoke Grenade",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "Smokeds", "SmokedsSelf", "SmokedsEnemies", "SmokedsTeammates", "Extinguishes", "ExtinguishesPlayers", "ExtinguishesMolotovs", "ExtinguishesFlareGuns", "ExtinguishesFlamethrowers", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 3, "Creates a smoke cloud which obscures vision and extinguishes all flames" } }
);
add_item(
    "Medkit",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "Deaths", "Uses", "UsesQuick", "Inspects", "InspectsAfterElimination", "HealsGiven" },
    { { 2, "Allows you to heal in the midst of a battle" } }
);
add_item(
    "Subspace Tripmine",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHitsSelf", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 3, "An invisible explosive that deals heavy damage and sends enemies flying" } }
);
add_item(
    "Flamethrower",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Airblasts", "AirblastsHits", "AirblastsSmokesCleared", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "Set your enemies on fire" }, { 2, "Use the Airblast to push enemies & smoke clouds" } }
);
add_item(
    "Freeze Ray",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Freezes", "FreezesSelf", "FreezesEnemies" },
    { { 2, "Freeze your enemies with this splash projectile weapon" } }
);
add_item(
    "Elixir",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHitsSelf", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "HealsGiven", "HealsGivenTeammates", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Splash your enemies to deal damage over time" }, { 2, "Splash your teammates to heal over time" } }
);
add_item(
    "War Horn",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "Deaths", "Uses", "UsesQuick", "Inspects", "InspectsAfterElimination", "Empowers", "EmpowersSelf", "EmpowersTeammates" },
    { { 2, "Charge your team into battle with this global speed boost" } }
);
add_item(
    "Satchel",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHitsSelf", "UsesHits", "UsesHitPercent", "Inspects", "InspectsAfterElimination", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Stick multiple explosive charges onto walls" }, { 2, "Detonate or shoot the satchels to cause a chain explosion" }, { 1, "Can stick to Riot Shields" } }
);
add_item(
    "Battle Axe",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "DamageDealtDashing", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "EliminationsDashing", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "Inspects", "InspectsAfterElimination", "Dashes", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Use the spin attack to slice through the competition" } }
);
add_item(
    "Riot Shield",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "DamageDealtDeflecting", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "EliminationsDeflecting", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "Inspects", "InspectsAfterElimination", "Absorbs", "AbsorbsBehind", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Shove your enemies out of the way" }, { 1, "Absorbs most damage sources" }, { 2, "Absorbs damage from behind while unequipped" } }
);
add_item(
    "Scepter",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Casts a magic spell that grows in speed & power" } }
);
add_item(
    "Daggers",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Burst your enemies down with these nimble projectiles" }, { 1, "Allows you to double jump" } }
);
add_item(
    "Energy Pistols",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "Harness the power of laser beams" } }
);
add_item(
    "Energy Rifle",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "DamageDealtBouncing", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "EliminationsBouncing", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Shoots a beam of energy that can bounce off walls" } }
);
add_item(
    "Spray",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "This five-round burst pistol might be illegal" }, { 3, "Loaded with illegally-modified armor-piercing-rounds that break through shields & deflects" } }
);
add_item(
    "Crossbow",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "An agile, long-ranged weapon" } }
);
add_item(
    "Gunblade",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "DamageDealtGunMode", "DamageDealtBladeMode", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "EliminationsGunMode", "EliminationsBladeMode", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Dashes", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Shoot an enemy to switch to Blade Mode" }, { 2, "Slash an enemy to switch to Gun Mode" }, { 1, "Aim while in Gun Mode" }, { 1, "Dash while in Blade Mode" } }
);
add_item(
    "Jump Pad",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "Deaths", "Uses", "UsesQuick", "Inspects", "InspectsAfterElimination", "Bounces", "BouncesSelf", "BouncesTeammates", "BouncesEnemies" },
    { { 2, "Place down a jump pad for all players to use" } }
);
add_item(
    "Glass Cannon",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "The weakest yet strongest weapon" } }
);
add_item(
    "Glast Shard",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Literally a piece of glass" } }
);
add_item(
    "RNG Dice",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "Deaths", "Uses", "UsesQuick", "Inspects", "InspectsAfterElimination" },
    { { 2, "Is today your lucky day?" } }
);
add_item(
    "Distortion",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "VortexesSpawned", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Trap players inside a gravitational vortex" } }
);
add_item(
    "Warper",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "Deaths", "Uses", "Inspects", "InspectsAfterElimination", "PortalsSpawned" },
    { { 2, "Spawn two portals and instantly warp from one place to another" } }
);
add_item(
    "Warpstone",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "Warps", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Throw this odd stone to instantly warp away from danger" } }
);
add_item(
    "Maul",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "DamageDealtDashing", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "EliminationsDashing", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "Inspects", "InspectsAfterElimination", "Leaps", "Slams", "SlamsHits", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "A slow, powerful weapon that pushes enemies" }, { 2, "Use your ability while grounded to leap into the air" }, { 2, "Use your ability while airborne to slam into the ground" } }
);
add_item(
    "Permafrost",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Freezes", "FreezesSelf", "FreezesEnemies", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Slow your enemies down with these chilled bullets" }, { 2, "Throw whatever\'s left of your magazine to freeze your enemies" } }
);
add_item(
    "Spear",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesQuick", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Throws", "ThrowsPierces", "ThrowsWalls", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 1, "Poke enemies from a distance" }, { 2, "Throw this at your enemies to pierce through them" }, { 2, "Throw this at a wall for it to stick and help you jump over" } }
);
add_item(
    "Grappler",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "Deaths", "Uses", "UsesQuick", "Inspects", "InspectsAfterElimination", "Hooks", "HooksEnvironment", "HooksEnemies" },
    { { 1, "Pull yourself towards any wall" }, { 1, "Pull enemies towards you" } }
);
add_item(
    "Wildcat",
    { "Playtime", "PlaytimeUnequipped", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead", "Uses", "UsesHits", "UsesHitPercent", "UsesCriticalHits", "UsesCriticalHitPercent", "Inspects", "InspectsAfterElimination", "AmmoUsed", "Reloads", "Zombies", "ZombiesDamageDealt", "ZombiesEliminations" },
    { { 2, "Pull downwards while shooting to control the recoil" }, { 3, "Jungle-style magazines allow you to reload quicker than usual" } }
);

local function add_map(p180, p181) -- Line: 947
    -- upvalues: u1 (copy)
    local v182 = { "Playtime", "RoundsPlayed", "RoundsWon", "RoundsLost", "RoundsWinPercent", "RankedRoundsPlayed", "RankedRoundsWon", "RankedRoundsLost", "RankedRoundsWinPercent", "DamageDealt", "DamageDealtSliding", "DamageDealtCrouching", "DamageDealtAirborne", "DamageDealtBlinded", "DamageDealtDead", "Eliminations", "EliminationsSliding", "EliminationsCrouching", "EliminationsAirborne", "EliminationsBlinded", "EliminationsDead", "Deaths", "DeathsRatio", "Assists", "AssistsDead" };

    for _, v in pairs(p181 or {}) do
        table.insert(v182, v);
    end;

    local v183 = {};

    for _, v in pairs(v182) do
        table.insert(v183, "Statistic" .. v);
    end;

    u1.Maps[p180] = {
        DataNames = v183
    };
end;

for i, _ in pairs(DuelLibrary.Maps) do
    add_map(i, i == "Zombie Tower" and { "Zombies", "ZombiesDamageDealt", "ZombiesEliminations", "ZombiesEliminations" } or nil);
end;

(function() -- Line: 980, Name: generate_visible_career_statistics
    -- upvalues: ShopLibrary (copy), CONSTANTS (copy), u1 (copy)
    local v184 = {};

    for _, v in pairs(ShopLibrary:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET)) do
        v184[v] = true;
    end;

    u1.CareerStatistics = u1:GetCareerStatistics(v184);
end)();

local function assert_items() -- Line: 993
    -- upvalues: ItemLibrary (copy), u1 (copy)
    for i in pairs(ItemLibrary.Items) do
        assert(u1.Items[i], i);
    end;
end;

for i in pairs(ItemLibrary.Items) do
    assert(u1.Items[i], i);
end;

return u1;