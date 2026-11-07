-- Instance: ReplicatedStorage .Modules.MonetizationLibrary
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local CurrencyLibrary = require(ReplicatedStorage.Modules.CurrencyLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
require(ReplicatedStorage.Modules.Utility);
local u1 = {
    ["\\"] = true,
    ["|"] = true,
    [" "] = true,
    q = true,
    w = true,
    e = true,
    r = true,
    t = true,
    y = true,
    u = true,
    i = true,
    o = true,
    p = true,
    a = true,
    s = true,
    d = true,
    f = true,
    g = true,
    h = true,
    j = true,
    k = true,
    l = true,
    z = true,
    x = true,
    c = true,
    v = true,
    b = true,
    n = true,
    m = true,
    ["1"] = true,
    ["2"] = true,
    ["3"] = true,
    ["4"] = true,
    ["5"] = true,
    ["6"] = true,
    ["7"] = true,
    ["8"] = true,
    ["9"] = true,
    ["0"] = true,
    ["`"] = true,
    ["-"] = true,
    ["="] = true,
    ["["] = true,
    ["]"] = true,
    [";"] = true,
    ["\'"] = true,
    [","] = true,
    ["."] = true,
    ["/"] = true,
    ["~"] = true,
    ["!"] = true,
    ["@"] = true,
    ["#"] = true,
    ["$"] = true,
    ["%"] = true,
    ["^"] = true,
    ["&"] = true,
    ["*"] = true,
    ["("] = true,
    [")"] = true,
    _ = true,
    ["+"] = true,
    ["{"] = true,
    ["}"] = true,
    [":"] = true,
    ["\""] = true,
    ["<"] = true,
    [">"] = true,
    ["?"] = true
};
local u8 = {
    NUM_KEY_BUNDLES = 5,
    NUM_EVENT_CURRENCY_BUNDLES = 5,
    GIFT_REWARD_DATA = "Bubbles",
    BATTLE_PASS_LEVELS = { "BattlePassLevels1", "BattlePassLevels5", "BattlePassLevels10", "BattlePassLevels20", "BattlePassLevels30", "BattlePassLevels40", "BattlePassLevels50", "BattlePassLevels60", "BattlePassLevels70" },
    MAX_GIFTING_NOTE_CHARACTER_COUNT = 128,
    VIDEO_AD_REWARDS_ENABLED = true,
    VIDEO_AD_REWARDS_MAX_SCALE_FACTOR = 2,
    VIDEO_ADS_SHOP_OFFER_PLACEMENT_ID = CONSTANTS.IS_TESTING_SERVER and 539056999862972 or 329421439571920,
    MAX_FREE_WEAPON_TRIALS_PER_DAY = 5,
    VIDEO_ADS_WEAPON_TRIAL_PLACEMENT_ID = CONSTANTS.IS_TESTING_SERVER and 711043139604582 or 755928445335559,
    MAX_BILLBOARD_VIDEO_ADS_PER_DAY = 2,
    BILLBOARD_KEYS_REWARD_DATA = {
        Name = "Key",
        Quantity = 1
    },
    BILLBOARD_WRAPS_REWARD_DATA = {
        Name = "Brimstone",
        Quantity = 1,
        Weapon = "IsRandom"
    },
    BILLBOARD_KEYS_VIDEO_AD_PLACEMENT_ID = CONSTANTS.IS_TESTING_SERVER and 329647288529142 or 118857322168446,
    BILLBOARD_WRAPS_VIDEO_AD_PLACEMENT_ID = CONSTANTS.IS_TESTING_SERVER and 842581759201595 or 345653440933702,
    SUPER_STARTER_BUNDLE_OFFER_DURATION = 604800,
    Gamepasses = {},
    Products = {},
    Bundles = {},
    CosmeticBundlesOrder = {},
    Gifts = {},
    GiftOrder = {},
    VideoAdRewards = {},
    UGCs = {},
    UGCAssetIDToName = {},
    UGCOrder = {},
    UGCMilestones = {},
    UGCMilestoneOrder = {},

    GetGiftRewardRobuxSpentRequirement = function(p2, p3) -- Line: 46, Name: GetGiftRewardRobuxSpentRequirement
        return math.min(500, 25 + 25 * p3);
    end,

    GetGamepassName = function(p4, p5) -- Line: 50, Name: GetGamepassName
        for i, v in pairs(p4.Gamepasses) do
            if p5 == v.GamepassID then
                return i;
            end;
        end;
    end,

    GetProductName = function(p6, p7) -- Line: 58, Name: GetProductName
        for i, v in pairs(p6.Products) do
            if p7 == v.ProductID then
                return i;
            end;
        end;
    end
};

function u8.GetBundleByProductID(p9, p10) -- Line: 66
    -- upvalues: u8 (copy)
    for i, v in pairs(u8.Bundles) do
        if v.ProductID == p10 then
            return i;
        end;
    end;
end;

function u8.GetBundleContainingReward(p11, p12) -- Line: 74
    -- upvalues: u8 (copy)
    for i, v in pairs(u8.Bundles) do
        local v13 = i;

        for _, v2 in pairs(v.Rewards) do
            if v2.Name == p12 then
                return v13;
            end;
        end;
    end;
end;

function u8.GetStandardWeaponBundleWeapons(p14) -- Line: 84
    -- upvalues: ShopLibrary (copy), CONSTANTS (copy), ItemLibrary (copy)
    local v15 = {};

    for _, v in pairs(ShopLibrary:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET, ShopLibrary.OwnableWeaponsAlphabetized)) do
        if not (table.find(CONSTANTS.DEFAULT_WEAPONS, v) or (ItemLibrary.Items[v].Status ~= "Standard" or not ShopLibrary.Weapons[v].KeyPrice)) then
            table.insert(v15, v);
        end;
    end;

    return v15;
end;

function u8.SanitizeGiftNote(p16, p17) -- Line: 98
    -- upvalues: u1 (copy)
    if typeof(p17) ~= "string" or #p17 == 0 then
        return nil;
    end;

    local math_min_ret = math.min(#p17, p16.MAX_GIFTING_NOTE_CHARACTER_COUNT);
    local string_sub_ret = string.sub(p17, 1, math_min_ret);
    local v18 = "";

    for i = 1, #string_sub_ret do
        local string_sub_ret2 = string.sub(string_sub_ret, i, i);
        v18 = v18 .. (not u1[string.lower(string_sub_ret2)] and "#" or string_sub_ret2);
        local _ = i;
    end;

    return v18;
end;

function u8.GetNextUGCMilestone(p19, p20) -- Line: 114
    for i, v in pairs(p19.UGCMilestoneOrder) do
        local v21 = p19.UGCMilestones[v];

        if v21.PurchaseRequirement > p20 then
            local v22 = p19.UGCMilestoneOrder[i - 1];
            local v23;

            if v22 then
                v23 = p19.UGCMilestones[v22];
            else
                v23 = nil;
            end;

            return v21, v23;
        end;
    end;
end;

function u8.GetNumVideoAdsForFreeWeaponTrial(p24, p25) -- Line: 129
    -- upvalues: ItemLibrary (copy), ShopLibrary (copy)
    local v26 = ItemLibrary.Items[p25];
    local v27 = ShopLibrary.Weapons[p25] and ShopLibrary.Weapons[p25].KeyPrice;

    if not (v26 and (v26.Status == "Standard" and v27)) then
        return nil;
    end;

    local math_floor_ret = math.floor(v27 / 7.5);

    return math.max(2, math_floor_ret);
end;

function u8.GetNumVideoAdsForBillboardReward(p28, p29) -- Line: 140
    return 3 + 1 * p29;
end;

local function add_gamepass(p30, p31, p32, p33) -- Line: 144
    -- upvalues: u8 (copy)
    u8.Gamepasses[p30] = {
        BundleName = nil,
        GamepassID = p31,
        DisplayName = p32,
        StaticRobuxPrice = p33
    };
end;

u8.Gamepasses.StandardWeaponsBundle = {
    GamepassID = 838203071,
    DisplayName = "Standard Weapons Bundle",
    StaticRobuxPrice = 999,
    BundleName = nil
};
u8.Gamepasses.ClassicBundle = {
    GamepassID = 838160059,
    DisplayName = "Classic Bundle",
    StaticRobuxPrice = 1149,
    BundleName = nil
};
u8.Gamepasses.HeavyDutyBundle = {
    GamepassID = 838198043,
    DisplayName = "Heavy Duty Bundle",
    StaticRobuxPrice = 1899,
    BundleName = nil
};
u8.Gamepasses.ExogunBundle = {
    GamepassID = 838087219,
    DisplayName = "Exogun Bundle",
    StaticRobuxPrice = 649,
    BundleName = nil
};
u8.Gamepasses.MedkitBundle = {
    GamepassID = 837904767,
    DisplayName = "Medkit Bundle",
    StaticRobuxPrice = 249,
    BundleName = nil
};
u8.Gamepasses.StarterBundle = {
    GamepassID = 839491390,
    DisplayName = "Starter Bundle",
    StaticRobuxPrice = 49,
    BundleName = nil
};
u8.Gamepasses.EnergyBundle = {
    GamepassID = 977061826,
    DisplayName = "Energy Bundle",
    StaticRobuxPrice = 1299,
    BundleName = nil
};
u8.Gamepasses.RPGBundle = {
    GamepassID = 1162134376,
    DisplayName = "RPG Bundle",
    StaticRobuxPrice = 124,
    BundleName = nil
};

local function add_product(p34, p35, p36, p37) -- Line: 166
    -- upvalues: u8 (copy)
    local v38 = {
        Name = p34,
        ProductID = p35,
        DisplayName = p36
    };

    for i, v in pairs(p37 or {}) do
        v38[i] = v;
    end;

    u8.Products[p34] = v38;
end;

add_product("RefreshTasks", 1852077788, "Refresh Daily Tasks");
add_product("DailySkin1Common", 1852078966, "Common Skin #1");
add_product("DailySkin1Rare", 1852080069, "Rare Skin #1");
add_product("DailySkin1Legendary", 1852068440, "Legendary Skin #1");
add_product("DailySkin2Common", 1857673571, "Common Skin #2");
add_product("DailySkin2Rare", 1857673748, "Rare Skin #2");
add_product("DailySkin2Legendary", 1857673858, "Legendary Skin #2");
add_product("DailySkin3Common", 2151911761, "Common Skin #3");
add_product("DailySkin3Rare", 2151911909, "Rare Skin #3");
add_product("DailySkin3Legendary", 2151912016, "Legendary Skin #3");
add_product("DailySkin4Common", 2151912274, "Common Skin #4");
add_product("DailySkin4Rare", 2151912453, "Rare Skin #4");
add_product("DailySkin4Legendary", 2151912592, "Legendary Skin #4");
add_product("DailySkin5Common", 2151912371, "Common Skin #5");
add_product("DailySkin5Rare", 2151912504, "Rare Skin #5");
add_product("DailySkin5Legendary", 2151912645, "Legendary Skin #5");
add_product("VideoAdRewardShopOffer", CONSTANTS.IS_TESTING_SERVER and 3328255161 or 3322045009, "Video Ad Reward - Shop Offer");
add_product("VideoAdRewardPlayWithReward", CONSTANTS.IS_TESTING_SERVER and 3592874068 or 3592870962, "Video Ad Reward - Play With Reward");
add_product("VideoAdRewardWeaponTrial", CONSTANTS.IS_TESTING_SERVER and 3592920078 or 3592919946, "Video Ad Reward - Free Weapon Trial");
add_product("VideoAdRewardBillboardKeys", CONSTANTS.IS_TESTING_SERVER and 3592980242 or 3592980112, "Video Ad Reward - Billboard Keys");
add_product("VideoAdRewardBillboardWraps", CONSTANTS.IS_TESTING_SERVER and 3592980378 or 3592980464, "Video Ad Reward - Billboard Wraps");
add_product("BattlePassLevels1", 3406958794, "+1 Season Pass Level", {
    BattlePassLevelIncrement = 1
});
add_product("BattlePassLevels5", 3406958927, "+5 Season Pass Levels", {
    BattlePassLevelIncrement = 5
});
add_product("BattlePassLevels10", 3406959039, "+10 Season Pass Levels", {
    BattlePassLevelIncrement = 10
});
add_product("BattlePassLevels20", 3406959143, "+20 Season Pass Levels", {
    BattlePassLevelIncrement = 20
});
add_product("BattlePassLevels30", 3406962774, "+30 Season Pass Levels", {
    BattlePassLevelIncrement = 30
});
add_product("BattlePassLevels40", 3406959259, "+40 Season Pass Levels", {
    BattlePassLevelIncrement = 40
});
add_product("BattlePassLevels50", 3406962880, "+50 Season Pass Levels", {
    BattlePassLevelIncrement = 50
});
add_product("BattlePassLevels60", 3406963062, "+60 Season Pass Levels", {
    BattlePassLevelIncrement = 60
});
add_product("BattlePassLevels70", 3406959434, "+70 Season Pass Levels", {
    BattlePassLevelIncrement = 70
});

local function add_bundle(p39, p40, p41, p42, p43, p44, p45, p46) -- Line: 211
    -- upvalues: u8 (copy)
    for _, v in pairs(p44) do
        assert(v.Name);
    end;

    local v47 = {
        Type = p39,
        DisplayName = p41,
        ProductID = p42,
        GamepassName = p43,
        Rewards = p44,
        BubbleText = p45
    };

    for i, v in pairs(p46 or {}) do
        v47[i] = v;
    end;

    u8.Bundles[p40] = v47;

    if p43 then
        u8.Gamepasses[p43].BundleName = p40;
    end;
end;

add_bundle("Currency", "keybundle_1", "Key Bundle", 1851594490, nil, { {
        Name = "Key",
        Quantity = 10
    } });
add_bundle(
    "Currency",
    "keybundle_2",
    "Mega Key Bundle",
    1851594599,
    nil,
    { {
            Name = "Key",
            Quantity = 40
        }, {
            Name = "Charm Capsule",
            Weapon = "IsRandom",
            Quantity = 1
        } }
);
add_bundle(
    "Currency",
    "keybundle_3",
    "Super Key Bundle",
    1851594741,
    nil,
    { {
            Name = "Key",
            Quantity = 90
        }, {
            Name = "Charm Capsule",
            Weapon = "IsRandom",
            Quantity = 3
        }, {
            Name = "Wrap Box 3",
            Weapon = "IsRandom",
            Quantity = 1
        }, {
            Name = "Mini Key",
            Weapon = "IsRandom",
            Quantity = 1
        } }
);
add_bundle(
    "Currency",
    "keybundle_4",
    "Ultra Key Bundle",
    1851594902,
    nil,
    { {
            Name = "Key",
            Quantity = 450
        }, {
            Name = "Charm Capsule",
            Weapon = "IsRandom",
            Quantity = 15
        }, {
            Name = "Wrap Box 3",
            Weapon = "IsRandom",
            Quantity = 5
        }, {
            Name = "Mini Key",
            Weapon = "IsRandom",
            Quantity = 5
        }, {
            Name = "Luxurious",
            Weapon = "IsRandom",
            Quantity = 2
        }, {
            Name = "Opulent",
            Weapon = "IsRandom",
            Quantity = 1
        }, {
            Name = "Enerkey Rifle",
            Weapon = "Energy Rifle"
        } }
);
add_bundle(
    "Currency",
    "keybundle_5",
    "Legendary Key Bundle",
    1851595031,
    nil,
    { {
            Name = "Key",
            Quantity = 1100
        }, {
            Name = "Charm Capsule",
            Weapon = "IsRandom",
            Quantity = 40
        }, {
            Name = "Wrap Box 3",
            Weapon = "IsRandom",
            Quantity = 15
        }, {
            Name = "Mini Key",
            Weapon = "IsRandom",
            Quantity = 15
        }, {
            Name = "Luxurious",
            Weapon = "IsRandom",
            Quantity = 5
        }, {
            Name = "Opulent",
            Weapon = "IsRandom",
            Quantity = 3
        }, {
            Name = "Enerkey Pistols",
            Weapon = "Energy Pistols"
        }, {
            Name = "Skin Case 3",
            Weapon = "IsRandom",
            Quantity = 1
        } }
);

if EventLibrary.IS_ACTIVE then
    local DisplayName = CurrencyLibrary.Info.EventCurrency.DisplayName;
    add_bundle("Currency", "eventcurrencybundle_1", DisplayName .. " Bundle", 2155532324, nil, { {
            Name = "EventCurrency",
            Quantity = 100
        } });
    add_bundle("Currency", "eventcurrencybundle_2", "Mega " .. DisplayName .. " Bundle", 2155532405, nil, {
        {
            Name = "EventCurrency",
            Quantity = 400
        },
        {
            Weapon = "IsRandom",
            Quantity = 1,
            Name = EventLibrary.SPECIAL_LOOTBOX_VARIETY
        }
    });
    add_bundle("Currency", "eventcurrencybundle_3", "Super " .. DisplayName .. " Bundle", 2155532505, nil, {
        {
            Name = "EventCurrency",
            Quantity = 900
        },
        {
            Weapon = "IsRandom",
            Quantity = 3,
            Name = EventLibrary.SPECIAL_LOOTBOX_VARIETY
        },
        {
            Weapon = "IsRandom",
            Quantity = 1,
            Name = EventLibrary.CURRENCY_BUNDLE_CHARM
        }
    });
    add_bundle("Currency", "eventcurrencybundle_4", "Ultra " .. DisplayName .. " Bundle", 2155532614, nil, {
        {
            Name = "EventCurrency",
            Quantity = 4500
        },
        {
            Weapon = "IsRandom",
            Quantity = 15,
            Name = EventLibrary.SPECIAL_LOOTBOX_VARIETY
        },
        {
            Weapon = "IsRandom",
            Quantity = 5,
            Name = EventLibrary.CURRENCY_BUNDLE_CHARM
        },
        {
            Weapon = "IsRandom",
            Quantity = 2,
            Name = EventLibrary.CURRENCY_BUNDLE_WRAP
        },
        {
            Weapon = "IsRandom",
            Quantity = 1,
            Name = EventLibrary.CURRENCY_BUNDLE_FINISHER
        }
    });
    add_bundle("Currency", "eventcurrencybundle_5", "Legendary " .. DisplayName .. " Bundle", 2155532697, nil, {
        {
            Name = "EventCurrency",
            Quantity = 11000
        },
        {
            Weapon = "IsRandom",
            Quantity = 30,
            Name = EventLibrary.SPECIAL_LOOTBOX_VARIETY
        },
        {
            Weapon = "IsRandom",
            Quantity = 15,
            Name = EventLibrary.CURRENCY_BUNDLE_CHARM
        },
        {
            Weapon = "IsRandom",
            Quantity = 6,
            Name = EventLibrary.CURRENCY_BUNDLE_WRAP
        },
        {
            Weapon = "IsRandom",
            Quantity = 3,
            Name = EventLibrary.CURRENCY_BUNDLE_FINISHER
        },
        {
            Name = EventLibrary.CURRENCY_BUNDLE_SKIN,
            Weapon = CosmeticLibrary.Cosmetics[EventLibrary.CURRENCY_BUNDLE_SKIN].ItemName
        },
        {
            Weapon = "IsRandom",
            Quantity = 1,
            Name = EventLibrary.SPECIAL_LOOTBOX_SKINS
        }
    });
end;

add_bundle(
    "Product",
    "superstarter_bundle",
    "Super Starter Bundle",
    3710468157,
    nil,
    { {
            Name = "Plasma Wildcat",
            Weapon = "Wildcat"
        }, {
            Name = "Wildcat"
        }, {
            Name = "Spray"
        }, {
            Name = "Chainsaw"
        }, {
            Name = "Flashbang"
        }, {
            Name = "Key",
            Quantity = 25
        } },
    "x15 VALUE"
);
add_bundle(
    "Gamepass",
    "starter_bundle",
    "Starter Bundle",
    nil,
    "StarterBundle",
    { {
            Name = "Standard Weapon Crate",
            Quantity = 1
        }, {
            Name = "Shorty"
        }, {
            Name = "Too Shorty",
            Weapon = "Shorty"
        }, {
            Name = "Paint",
            Weapon = "IsUniversal"
        }, {
            Name = "Emoji: Nauseated",
            Weapon = "IsUniversal"
        }, {
            Name = "Stiff",
            Weapon = "IsUniversal"
        }, {
            Name = "Key",
            Quantity = 10
        } },
    "x12 VALUE"
);
add_bundle(
    "Gamepass",
    "standardweapons_bundle",
    "Standard Weapons Bundle",
    nil,
    "StandardWeaponsBundle",
    { {
            Name = "Disco",
            Weapon = "IsUniversal"
        }, {
            Name = "Mini Disco Ball",
            Weapon = "IsUniversal"
        }, {
            Name = "Boogie",
            Weapon = "IsUniversal"
        }, {
            Name = "Wrap Box",
            Weapon = "IsRandom",
            Quantity = 5
        }, {
            Name = "Charm Capsule",
            Weapon = "IsRandom",
            Quantity = 10
        }, {
            Name = "Key",
            Quantity = 15
        } },
    "x3 VALUE"
);
add_bundle(
    "Gamepass",
    "classic_bundle",
    "Classic Bundle",
    nil,
    "ClassicBundle",
    { {
            Name = "Paintball Gun"
        }, {
            Name = "Slingshot"
        }, {
            Name = "Trowel"
        }, {
            Name = "Subspace Tripmine"
        }, {
            Name = "Classic",
            Weapon = "IsUniversal"
        }, {
            Name = "Mini Ban Hammer",
            Weapon = "IsUniversal"
        }, {
            Name = "OOF",
            Weapon = "IsUniversal"
        }, {
            Name = "Wrap Box",
            Weapon = "IsRandom",
            Quantity = 10
        }, {
            Name = "Charm Capsule",
            Weapon = "IsRandom",
            Quantity = 20
        }, {
            Name = "Key",
            Quantity = 40
        } },
    "x7 VALUE"
);
add_bundle(
    "Gamepass",
    "heavyduty_bundle",
    "Heavy Duty Bundle",
    nil,
    "HeavyDutyBundle",
    { {
            Name = "Grenade Launcher"
        }, {
            Name = "Minigun"
        }, {
            Name = "Flamethrower"
        }, {
            Name = "Magma",
            Weapon = "IsUniversal"
        }, {
            Name = "Explosion",
            Weapon = "IsUniversal"
        }, {
            Name = "Ignite",
            Weapon = "IsUniversal"
        }, {
            Name = "Wrap Box",
            Weapon = "IsRandom",
            Quantity = 10
        }, {
            Name = "Charm Capsule",
            Weapon = "IsRandom",
            Quantity = 20
        }, {
            Name = "Key",
            Quantity = 40
        } },
    "x4 VALUE"
);
add_bundle(
    "Gamepass",
    "exogun_bundle",
    "Exogun Bundle",
    nil,
    "ExogunBundle",
    { {
            Name = "Exogun"
        }, {
            Name = "Wondergun",
            Weapon = "Exogun"
        }, {
            Name = "Nebula",
            Weapon = "IsUniversal"
        }, {
            Name = "Alien Head",
            Weapon = "IsUniversal"
        }, {
            Name = "Low Gravity",
            Weapon = "IsUniversal"
        }, {
            Name = "Wrap Box",
            Weapon = "IsRandom",
            Quantity = 15
        }, {
            Name = "Key",
            Quantity = 20
        } },
    "x4 VALUE"
);
add_bundle(
    "Gamepass",
    "medkit_bundle",
    "Medkit Bundle",
    nil,
    "MedkitBundle",
    { {
            Name = "Medkit"
        }, {
            Name = "Briefcase",
            Weapon = "Medkit"
        }, {
            Name = "Aurum",
            Weapon = "IsUniversal"
        }, {
            Name = "First Aid",
            Weapon = "IsUniversal"
        }, {
            Name = "Heartbeat",
            Weapon = "IsUniversal"
        }, {
            Name = "Wrap Box",
            Weapon = "IsRandom",
            Quantity = 15
        }, {
            Name = "Key",
            Quantity = 20
        } },
    "x10 VALUE"
);
add_bundle(
    "Gamepass",
    "energy_bundle",
    "Energy Bundle",
    nil,
    "EnergyBundle",
    { {
            Name = "Energy Rifle"
        }, {
            Name = "Energy Pistols"
        }, {
            Name = "Apex Rifle",
            Weapon = "Energy Rifle"
        }, {
            Name = "Apex Pistols",
            Weapon = "Energy Pistols"
        }, {
            Name = ".dll",
            Weapon = "IsUniversal"
        }, {
            Name = "Energy Cell",
            Weapon = "IsUniversal"
        }, {
            Name = "Beacon",
            Weapon = "IsUniversal"
        } },
    "x5 VALUE"
);
add_bundle(
    "Gamepass",
    "rpg_bundle",
    "RPG Bundle",
    nil,
    "RPGBundle",
    { {
            Name = "RPG"
        }, {
            Name = "Pencil Launcher",
            Weapon = "RPG"
        }, {
            Name = "Emoji: Nerd",
            Weapon = "IsUniversal"
        }, {
            Name = "Cardboard",
            Weapon = "IsUniversal"
        }, {
            Name = "Erased",
            Weapon = "IsUniversal"
        }, {
            Name = "Key",
            Quantity = 5
        } },
    "x3 VALUE"
);

if SeasonLibrary.CurrentSeason.BattlePassActive then
    add_bundle("Product", "primeseason_bundle", "Prime Bundle", 3406969974, nil, { {
            Name = "Prime Season Pass"
        }, {
            Name = "Prime Nametag"
        } }, "<s>" .. utf8.char(57346) .. " 724</s>", {
        BattlePassMaxPassTrackNum = 2,
        UnlockNowDisplayName = "Prime Season Pass",
        UnlockNowWeaponStatusUIEffect = "Prime"
    });
    add_bundle("Product", "contrabandseason_bundle", "Contraband Bundle", 3406992213, nil, {
        {
            Name = "Prime Season Pass"
        },
        {
            Name = "Contraband Nametag"
        },
        {
            Name = "Season Pass Level",
            Quantity = SeasonLibrary.SEASON_PASS_LEVELS_IN_SEASON_BUNDLE
        },
        {
            Name = "Prime Goodie Bag",
            Quantity = 10,
            Weapon = "IsRandom"
        },
        {
            Quantity = 1,
            Name = SeasonLibrary.CurrentSeason.ContrabandBundleSkinName,
            Weapon = CosmeticLibrary.Cosmetics[SeasonLibrary.CurrentSeason.ContrabandBundleSkinName].ItemName
        },
        {
            Quantity = 1,
            Weapon = "IsUniversal",
            Name = SeasonLibrary.CurrentSeason.ContrabandBundleWrapName
        },
        {
            Quantity = 1,
            Weapon = "IsUniversal",
            Name = SeasonLibrary.CurrentSeason.ContrabandBundleCharmName
        },
        {
            Quantity = 1,
            Weapon = "IsUniversal",
            Name = SeasonLibrary.CurrentSeason.ContrabandBundleFinisherName
        },
        {
            Quantity = 1,
            Name = SeasonLibrary.CurrentSeason.ContrabandBundleEmoteName
        }
    }, "<s>" .. utf8.char(57346) .. " 2,499</s>", {
        BattlePassMaxPassTrackNum = 2,
        BattlePassLevelIncrement = SeasonLibrary.SEASON_PASS_LEVELS_IN_SEASON_BUNDLE
    });
end;

local function add_cosmetic_bundle(p48, p49, p50, p51, p52, p53) -- Line: 447
    -- upvalues: CosmeticLibrary (copy), add_bundle (copy), u8 (copy)
    for _, v in pairs(p53) do
        CosmeticLibrary:ExternallySetCosmeticDescription(v[3].Name, string.format(p48 and "Used to be included in the %s" or "Included in the %s", p50));
    end;

    if p48 then
        return;
    end;

    local v54 = {};
    local v55 = {};

    for _, v in pairs(p53) do
        table.insert(v54, v[3]);

        if v[1] then
            table.insert(v55, v[1]);
            table.insert(v55, Enum.InfoType.Product);
        end;
    end;

    add_bundle("Product", p49, p50, p51, nil, v54, nil, {
        IsCosmeticBundle = true,
        RewardsWithIndividualProductIDs = p53,
        SetRobuxTextArgs = v55,
        GiftProductID = p52
    });
    table.insert(u8.CosmeticBundlesOrder, p49);
end;

add_cosmetic_bundle(
    nil,
    "pixel_bundle",
    "Pixel Bundle",
    3535136080,
    2146952782,
    { { 3535139215, 3535796474, {
                Name = "Pixel Burst",
                Weapon = "Burst Rifle"
            } }, { 3535139428, 3535796544, {
                Name = "Pixel Handgun",
                Weapon = "Handgun"
            } }, { 3535139535, 3535796623, {
                Name = "Pixel Katana",
                Weapon = "Katana"
            } }, { 3535139628, 3535796722, {
                Name = "Pixel Flashbang",
                Weapon = "Flashbang"
            } }, { nil, nil, {
                Name = "Geometric",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "EZ",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Pixel Coins",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Coin Block"
            } } }
);
add_cosmetic_bundle(
    nil,
    "balloon_bundle",
    "Balloon Bundle",
    3535217450,
    3535800297,
    { { 3535217737, 3535800345, {
                Name = "Balloon Launcher",
                Weapon = "Grenade Launcher"
            } }, { 3535217775, 3535800399, {
                Name = "Paintballoon Gun",
                Weapon = "Paintball Gun"
            } }, { 3535217832, 3535800453, {
                Name = "Balloon Bow",
                Weapon = "Bow"
            } }, { 3535217904, 3535800531, {
                Name = "Balloon Axe",
                Weapon = "Battle Axe"
            } }, { nil, nil, {
                Name = "Balloon Dog",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Red Rubber",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Inflate",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Whimsical"
            } } }
);
add_cosmetic_bundle(
    nil,
    "nostalgia_bundle",
    "Nostalgia Bundle",
    3535218231,
    3535800586,
    { { 3535218275, 3535800641, {
                Name = "Ban Hammer",
                Weapon = "Maul"
            } }, { 3535218311, 3535800699, {
                Name = "Rocket Launcher",
                Weapon = "RPG"
            } }, { 3535218352, 3535800924, {
                Name = "Hyperlaser Guns",
                Weapon = "Energy Pistols"
            } }, { 3535218430, 3535800959, {
                Name = "Linked Sword",
                Weapon = "Katana"
            } }, { nil, nil, {
                Name = "Happy Home",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "The Heights",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Dematerialize",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Illumina Storm"
            } } }
);

for _, v in pairs({ { 3535218018, 3535801045, {
            Name = "Beloved Bow",
            Weapon = "Bow"
        } }, { 3535218067, 3535801071, {
            Name = "Broken Hearts",
            Weapon = "Daggers"
        } }, { 3535218104, 3535801113, {
            Name = "Cuddle Bomb",
            Weapon = "Grenade"
        } }, { 3535218148, 3535801142, {
            Name = "Box of Chocolates",
            Weapon = "Medkit"
        } }, { nil, nil, {
            Name = "Pierced Heart",
            Weapon = "IsUniversal"
        } }, { nil, nil, {
            Name = "Heartfelt",
            Weapon = "IsUniversal"
        } }, { nil, nil, {
            Name = "Poof",
            Weapon = "IsUniversal"
        } }, { nil, nil, {
            Name = "Tango"
        } } }) do
    CosmeticLibrary:ExternallySetCosmeticDescription(v[3].Name, string.format("Used to be included in the %s", "Lovely Bundle"));
end;

for _, v in pairs({ { 3549289473, 3549289668, {
            Name = "Rainbowthrower",
            Weapon = "Flamethrower"
        } }, { 3549289501, 3549289722, {
            Name = "Lucky Horseshoe",
            Weapon = "Slingshot"
        } }, { 3549289534, 3549289757, {
            Name = "Caladbolg",
            Weapon = "Knife"
        } }, { 3549289575, 3549289804, {
            Name = "Pot o\' Keys",
            Weapon = "Subspace Tripmine"
        } }, { nil, nil, {
            Name = "Four-Leaf Clover",
            Weapon = "IsUniversal"
        } }, { nil, nil, {
            Name = "Clovers",
            Weapon = "IsUniversal"
        } }, { nil, nil, {
            Name = "Leprechaunify",
            Weapon = "IsUniversal"
        } }, { nil, nil, {
            Name = "Step Dancing"
        } } }) do
    CosmeticLibrary:ExternallySetCosmeticDescription(v[3].Name, string.format("Used to be included in the %s", "Lucky Bundle"));
end;

add_cosmetic_bundle(
    nil,
    "prop_bundle",
    "Prop Bundle",
    3580412457,
    3580412891,
    { { 3580412515, 3580412913, {
                Name = "Extinguisher",
                Weapon = "Flamethrower"
            } }, { 3580412541, 3580412953, {
                Name = "Toaster",
                Weapon = "Daggers"
            } }, { 3580412562, 3580412985, {
                Name = "Street Sign",
                Weapon = "Battle Axe"
            } }, { 3580412593, 3580413018, {
                Name = "Pizza Box",
                Weapon = "Satchel"
            } }, { nil, nil, {
                Name = "Pencil",
                Weapon = "Knife"
            } }, { nil, nil, {
                Name = "Box TV",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "TV Error",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Goofy Brawl",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Scoot"
            } } }
);
add_cosmetic_bundle(
    nil,
    "pirate_bundle",
    "Pirate Bundle",
    3605561386,
    3605561751,
    { { 3605561596, 3605561781, {
                Name = "Kraken Sniper",
                Weapon = "Sniper"
            } }, { 3605561621, 3605561802, {
                Name = "Cannon Shorty",
                Weapon = "Shorty"
            } }, { 3605561673, 3605561828, {
                Name = "Pirate Hook",
                Weapon = "Fists"
            } }, { 3605561690, 3605561892, {
                Name = "Ship In A Bottle",
                Weapon = "Molotov"
            } }, { nil, nil, {
                Name = "Cutlass",
                Weapon = "Katana"
            } }, { nil, nil, {
                Name = "Long Lost Treasure",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Dutchman",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Spectralized",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "X Marks The Spot"
            } } }
);
add_cosmetic_bundle(
    nil,
    "bat_bundle",
    "Bat Bundle",
    3716730402,
    3716731407,
    { { 3716730830, 3716731473, {
                Name = "Batblade",
                Weapon = "Gunblade"
            } }, { 3716730904, 3716731518, {
                Name = "Slingshotula",
                Weapon = "Slingshot"
            } }, { 3716730996, 3716731590, {
                Name = "Karambat",
                Weapon = "Knife"
            } }, { 3716731074, 3716731685, {
                Name = "Batnade",
                Weapon = "Grenade"
            } }, { nil, nil, {
                Name = "Bat Wing",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Bat Flock",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Become Bat",
                Weapon = "IsUniversal"
            } }, { nil, nil, {
                Name = "Take Flight"
            } } }
);

local function add_gift(p56, p57, p58, p59, p60, p61, p62) -- Line: 569
    -- upvalues: u8 (copy), ShopLibrary (copy)
    local v63 = p57 == "Gamepass" and u8.Gamepasses[p58] or (p57 == "Product" and u8.Products[p58] or p57 == "Bundle" and u8.Bundles[p58] or (p57 == "ShopEntry" and ShopLibrary.Entries[p58] or error("???")));
    local v64 = {
        ImageID = nil,
        ProductID = p56,
        ProductType = p57 == "Gamepass" and "Gamepass" or "Product",
        GiftType = p57,
        GiftName = p58,
        TargetProductID = p62 or p57 == "Gamepass" and v63.GamepassID or (p57 == "ShopEntry" and v63.ProductQuantityToID[p60 or 1] or v63.ProductID),
        DisplayName = p61 or (p57 == "ShopEntry" and v63.Rewards[1].Name .. ((not p60 or p60 == 1) and "" or " [×" .. p60 .. "]") or v63.DisplayName),
        IsPaidRandomItem = p59,
        Quantity = p60
    };
    u8.Gifts[tostring(p56)] = v64;
    local GiftOrder = u8.GiftOrder;
    local v65 = tostring(p56);
    table.insert(GiftOrder, v65);
end;

local function add_bundle_gift(p66) -- Line: 593
    -- upvalues: u8 (copy)
    local v67 = u8.Bundles[p66];

    if v67.GiftProductID then
        local GiftProductID = v67.GiftProductID;
        local v68 = u8.Bundles[p66] or error("???");
        local v69 = {
            ProductType = "Product",
            GiftType = "Bundle",
            IsPaidRandomItem = nil,
            Quantity = nil,
            ImageID = nil,
            ProductID = GiftProductID,
            GiftName = p66,
            TargetProductID = v68.ProductID,
            DisplayName = v68.DisplayName
        };
        u8.Gifts[tostring(GiftProductID)] = v69;
        local GiftOrder = u8.GiftOrder;
        local v70 = tostring(GiftProductID);
        table.insert(GiftOrder, v70);
    end;

    for _, v in pairs(v67.RewardsWithIndividualProductIDs) do
        if v[1] and v[2] then
            local v71 = v[2];
            local Name = v[3].Name;
            local v72 = v[1];
            local v73 = u8.Bundles[p66] or error("???");
            local v74 = {
                ProductType = "Product",
                GiftType = "Bundle",
                IsPaidRandomItem = nil,
                Quantity = nil,
                ImageID = nil,
                ProductID = v71,
                GiftName = p66,
                TargetProductID = v72 or v73.ProductID,
                DisplayName = Name or v73.DisplayName
            };
            u8.Gifts[tostring(v71)] = v74;
            local GiftOrder = u8.GiftOrder;
            local v75 = tostring(v71);
            table.insert(GiftOrder, v75);
        end;
    end;
end;

if EventLibrary.IS_ACTIVE then
    if EventLibrary.PRIZE_WHEEL_NAME then
        local STANDALONE_PRIZE_WHEEL_SHOP_ENTRY_NAME = EventLibrary.STANDALONE_PRIZE_WHEEL_SHOP_ENTRY_NAME;
        local v76 = ShopLibrary.Entries[STANDALONE_PRIZE_WHEEL_SHOP_ENTRY_NAME] or error("???");
        local v77 = {
            ProductID = 3717335257,
            ProductType = "Product",
            GiftType = "ShopEntry",
            IsPaidRandomItem = true,
            Quantity = 10,
            ImageID = nil,
            GiftName = STANDALONE_PRIZE_WHEEL_SHOP_ENTRY_NAME,
            TargetProductID = v76.ProductQuantityToID[10] or v76.ProductID,
            DisplayName = v76.Rewards[1].Name .. " [×" .. 10 .. "]" or v76.DisplayName
        };
        u8.Gifts[tostring(3717335257)] = v77;
        local GiftOrder = u8.GiftOrder;
        local v78 = tostring(3717335257);
        table.insert(GiftOrder, v78);
    end;

    if EventLibrary.STANDALONE_SHOP_SKIN then
        local STANDALONE_SHOP_SKIN_SHOP_ENTRY_NAME = EventLibrary.STANDALONE_SHOP_SKIN_SHOP_ENTRY_NAME;
        local v79 = ShopLibrary.Entries[STANDALONE_SHOP_SKIN_SHOP_ENTRY_NAME] or error("???");
        local v80 = {
            ProductID = 3605561994,
            ProductType = "Product",
            GiftType = "ShopEntry",
            IsPaidRandomItem = nil,
            Quantity = nil,
            ImageID = nil,
            GiftName = STANDALONE_SHOP_SKIN_SHOP_ENTRY_NAME,
            TargetProductID = v79.ProductQuantityToID[1] or v79.ProductID,
            DisplayName = v79.Rewards[1].Name .. "" or v79.DisplayName
        };
        u8.Gifts[tostring(3605561994)] = v80;
        local GiftOrder = u8.GiftOrder;
        local v81 = tostring(3605561994);
        table.insert(GiftOrder, v81);
    end;

    local v82 = "lootbox_" .. EventLibrary.SPECIAL_LOOTBOX_SKINS;
    local v83 = ShopLibrary.Entries[v82] or error("???");
    local v84 = {
        ProductID = 2154618268,
        ProductType = "Product",
        GiftType = "ShopEntry",
        IsPaidRandomItem = true,
        Quantity = nil,
        ImageID = nil,
        GiftName = v82,
        TargetProductID = v83.ProductQuantityToID[1] or v83.ProductID,
        DisplayName = v83.Rewards[1].Name .. "" or v83.DisplayName
    };
    u8.Gifts[tostring(2154618268)] = v84;
    local GiftOrder = u8.GiftOrder;
    local v85 = tostring(2154618268);
    table.insert(GiftOrder, v85);
    local v86 = "lootbox_" .. EventLibrary.SPECIAL_LOOTBOX_SKINS;
    local v87 = ShopLibrary.Entries[v86] or error("???");
    local v88 = {
        ProductID = 2319690506,
        ProductType = "Product",
        GiftType = "ShopEntry",
        IsPaidRandomItem = true,
        Quantity = 3,
        ImageID = nil,
        GiftName = v86,
        TargetProductID = v87.ProductQuantityToID[3] or v87.ProductID,
        DisplayName = v87.Rewards[1].Name .. " [×" .. 3 .. "]" or v87.DisplayName
    };
    u8.Gifts[tostring(2319690506)] = v88;
    local GiftOrder2 = u8.GiftOrder;
    local v89 = tostring(2319690506);
    table.insert(GiftOrder2, v89);
    local v90 = u8.Bundles.eventcurrencybundle_1 or error("???");
    local v91 = {
        ProductID = 2319763472,
        ProductType = "Product",
        GiftType = "Bundle",
        GiftName = "eventcurrencybundle_1",
        IsPaidRandomItem = nil,
        Quantity = nil,
        ImageID = nil,
        TargetProductID = v90.ProductID,
        DisplayName = v90.DisplayName
    };
    u8.Gifts[tostring(2319763472)] = v91;
    local GiftOrder3 = u8.GiftOrder;
    local v92 = tostring(2319763472);
    table.insert(GiftOrder3, v92);
    local v93 = u8.Bundles.eventcurrencybundle_2 or error("???");
    local v94 = {
        ProductID = 2319763545,
        ProductType = "Product",
        GiftType = "Bundle",
        GiftName = "eventcurrencybundle_2",
        IsPaidRandomItem = nil,
        Quantity = nil,
        ImageID = nil,
        TargetProductID = v93.ProductID,
        DisplayName = v93.DisplayName
    };
    u8.Gifts[tostring(2319763545)] = v94;
    local GiftOrder4 = u8.GiftOrder;
    local v95 = tostring(2319763545);
    table.insert(GiftOrder4, v95);
    local v96 = u8.Bundles.eventcurrencybundle_3 or error("???");
    local v97 = {
        ProductID = 2319763627,
        ProductType = "Product",
        GiftType = "Bundle",
        GiftName = "eventcurrencybundle_3",
        IsPaidRandomItem = nil,
        Quantity = nil,
        ImageID = nil,
        TargetProductID = v96.ProductID,
        DisplayName = v96.DisplayName
    };
    u8.Gifts[tostring(2319763627)] = v97;
    local GiftOrder5 = u8.GiftOrder;
    local v98 = tostring(2319763627);
    table.insert(GiftOrder5, v98);
    local v99 = u8.Bundles.eventcurrencybundle_4 or error("???");
    local v100 = {
        ProductID = 2319763722,
        ProductType = "Product",
        GiftType = "Bundle",
        GiftName = "eventcurrencybundle_4",
        IsPaidRandomItem = nil,
        Quantity = nil,
        ImageID = nil,
        TargetProductID = v99.ProductID,
        DisplayName = v99.DisplayName
    };
    u8.Gifts[tostring(2319763722)] = v100;
    local GiftOrder6 = u8.GiftOrder;
    local v101 = tostring(2319763722);
    table.insert(GiftOrder6, v101);
    local v102 = u8.Bundles.eventcurrencybundle_5 or error("???");
    local v103 = {
        ProductID = 2319763802,
        ProductType = "Product",
        GiftType = "Bundle",
        GiftName = "eventcurrencybundle_5",
        IsPaidRandomItem = nil,
        Quantity = nil,
        ImageID = nil,
        TargetProductID = v102.ProductID,
        DisplayName = v102.DisplayName
    };
    u8.Gifts[tostring(2319763802)] = v103;
    local GiftOrder7 = u8.GiftOrder;
    local v104 = tostring(2319763802);
    table.insert(GiftOrder7, v104);

    if EventLibrary.SKIN_BUNDLE_NAME then
        add_bundle_gift(EventLibrary.SKIN_BUNDLE_NAME);
    end;
end;

if SeasonLibrary.CurrentSeason.BattlePassActive then
    local v105 = u8.Products.BattlePassLevels10 or error("???");
    local v106 = {
        ProductID = 3407624520,
        ProductType = "Product",
        GiftType = "Product",
        GiftName = "BattlePassLevels10",
        IsPaidRandomItem = nil,
        Quantity = nil,
        ImageID = nil,
        TargetProductID = v105.ProductID,
        DisplayName = v105.DisplayName
    };
    u8.Gifts[tostring(3407624520)] = v106;
    local GiftOrder = u8.GiftOrder;
    local v107 = tostring(3407624520);
    table.insert(GiftOrder, v107);
    local v108 = u8.Bundles.primeseason_bundle or error("???");
    local v109 = {
        ProductID = 3407614262,
        ProductType = "Product",
        GiftType = "Bundle",
        GiftName = "primeseason_bundle",
        IsPaidRandomItem = nil,
        Quantity = nil,
        ImageID = nil,
        TargetProductID = v108.ProductID,
        DisplayName = v108.DisplayName
    };
    u8.Gifts[tostring(3407614262)] = v109;
    local GiftOrder2 = u8.GiftOrder;
    local v110 = tostring(3407614262);
    table.insert(GiftOrder2, v110);
    local v111 = u8.Bundles.contrabandseason_bundle or error("???");
    local v112 = {
        ProductID = 3407615047,
        ProductType = "Product",
        GiftType = "Bundle",
        GiftName = "contrabandseason_bundle",
        IsPaidRandomItem = nil,
        Quantity = nil,
        ImageID = nil,
        TargetProductID = v111.ProductID,
        DisplayName = v111.DisplayName
    };
    u8.Gifts[tostring(3407615047)] = v112;
    local GiftOrder3 = u8.GiftOrder;
    local v113 = tostring(3407615047);
    table.insert(GiftOrder3, v113);
end;

local v114 = u8.Gamepasses.StandardWeaponsBundle or error("???");
local v115 = {
    ProductID = 1890371681,
    ProductType = "Gamepass",
    GiftType = "Gamepass",
    GiftName = "StandardWeaponsBundle",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v114.GamepassID or v114.ProductID,
    DisplayName = v114.DisplayName
};
u8.Gifts[tostring(1890371681)] = v115;
local GiftOrder = u8.GiftOrder;
local v116 = tostring(1890371681);
table.insert(GiftOrder, v116);
local v117 = u8.Gamepasses.ClassicBundle or error("???");
local v118 = {
    ProductID = 1890372364,
    ProductType = "Gamepass",
    GiftType = "Gamepass",
    GiftName = "ClassicBundle",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v117.GamepassID or v117.ProductID,
    DisplayName = v117.DisplayName
};
u8.Gifts[tostring(1890372364)] = v118;
local GiftOrder2 = u8.GiftOrder;
local v119 = tostring(1890372364);
table.insert(GiftOrder2, v119);
local v120 = u8.Gamepasses.HeavyDutyBundle or error("???");
local v121 = {
    ProductID = 1890372130,
    ProductType = "Gamepass",
    GiftType = "Gamepass",
    GiftName = "HeavyDutyBundle",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v120.GamepassID or v120.ProductID,
    DisplayName = v120.DisplayName
};
u8.Gifts[tostring(1890372130)] = v121;
local GiftOrder3 = u8.GiftOrder;
local v122 = tostring(1890372130);
table.insert(GiftOrder3, v122);
local v123 = u8.Gamepasses.ExogunBundle or error("???");
local v124 = {
    ProductID = 1890372574,
    ProductType = "Gamepass",
    GiftType = "Gamepass",
    GiftName = "ExogunBundle",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v123.GamepassID or v123.ProductID,
    DisplayName = v123.DisplayName
};
u8.Gifts[tostring(1890372574)] = v124;
local GiftOrder4 = u8.GiftOrder;
local v125 = tostring(1890372574);
table.insert(GiftOrder4, v125);
local v126 = u8.Gamepasses.MedkitBundle or error("???");
local v127 = {
    ProductID = 1890372831,
    ProductType = "Gamepass",
    GiftType = "Gamepass",
    GiftName = "MedkitBundle",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v126.GamepassID or v126.ProductID,
    DisplayName = v126.DisplayName
};
u8.Gifts[tostring(1890372831)] = v127;
local GiftOrder5 = u8.GiftOrder;
local v128 = tostring(1890372831);
table.insert(GiftOrder5, v128);
local v129 = u8.Gamepasses.StarterBundle or error("???");
local v130 = {
    ProductID = 1890371901,
    ProductType = "Gamepass",
    GiftType = "Gamepass",
    GiftName = "StarterBundle",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v129.GamepassID or v129.ProductID,
    DisplayName = v129.DisplayName
};
u8.Gifts[tostring(1890371901)] = v130;
local GiftOrder6 = u8.GiftOrder;
local v131 = tostring(1890371901);
table.insert(GiftOrder6, v131);
local v132 = u8.Gamepasses.EnergyBundle or error("???");
local v133 = {
    ProductID = 2661338143,
    ProductType = "Gamepass",
    GiftType = "Gamepass",
    GiftName = "EnergyBundle",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v132.GamepassID or v132.ProductID,
    DisplayName = v132.DisplayName
};
u8.Gifts[tostring(2661338143)] = v133;
local GiftOrder7 = u8.GiftOrder;
local v134 = tostring(2661338143);
table.insert(GiftOrder7, v134);
local v135 = u8.Gamepasses.RPGBundle or error("???");
local v136 = {
    ProductID = 3277561206,
    ProductType = "Gamepass",
    GiftType = "Gamepass",
    GiftName = "RPGBundle",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v135.GamepassID or v135.ProductID,
    DisplayName = v135.DisplayName
};
u8.Gifts[tostring(3277561206)] = v136;
local GiftOrder8 = u8.GiftOrder;
local v137 = tostring(3277561206);
table.insert(GiftOrder8, v137);
local v138 = ShopLibrary.Entries["lootbox_Skin Case"] or error("???");
local v139 = {
    ProductID = 1892544195,
    ProductType = "Product",
    GiftType = "ShopEntry",
    GiftName = "lootbox_Skin Case",
    IsPaidRandomItem = true,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v138.ProductQuantityToID[1] or v138.ProductID,
    DisplayName = v138.Rewards[1].Name .. "" or v138.DisplayName
};
u8.Gifts[tostring(1892544195)] = v139;
local GiftOrder9 = u8.GiftOrder;
local v140 = tostring(1892544195);
table.insert(GiftOrder9, v140);
local v141 = ShopLibrary.Entries["lootbox_Skin Case"] or error("???");
local v142 = {
    ProductID = 2319692001,
    ProductType = "Product",
    GiftType = "ShopEntry",
    GiftName = "lootbox_Skin Case",
    IsPaidRandomItem = true,
    Quantity = 3,
    ImageID = nil,
    TargetProductID = v141.ProductQuantityToID[3] or v141.ProductID,
    DisplayName = v141.Rewards[1].Name .. " [×" .. 3 .. "]" or v141.DisplayName
};
u8.Gifts[tostring(2319692001)] = v142;
local GiftOrder10 = u8.GiftOrder;
local v143 = tostring(2319692001);
table.insert(GiftOrder10, v143);
local v144 = ShopLibrary.Entries["lootbox_Skin Case 2"] or error("???");
local v145 = {
    ProductID = 1892544449,
    ProductType = "Product",
    GiftType = "ShopEntry",
    GiftName = "lootbox_Skin Case 2",
    IsPaidRandomItem = true,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v144.ProductQuantityToID[1] or v144.ProductID,
    DisplayName = v144.Rewards[1].Name .. "" or v144.DisplayName
};
u8.Gifts[tostring(1892544449)] = v145;
local GiftOrder11 = u8.GiftOrder;
local v146 = tostring(1892544449);
table.insert(GiftOrder11, v146);
local v147 = ShopLibrary.Entries["lootbox_Skin Case 2"] or error("???");
local v148 = {
    ProductID = 2319692175,
    ProductType = "Product",
    GiftType = "ShopEntry",
    GiftName = "lootbox_Skin Case 2",
    IsPaidRandomItem = true,
    Quantity = 3,
    ImageID = nil,
    TargetProductID = v147.ProductQuantityToID[3] or v147.ProductID,
    DisplayName = v147.Rewards[1].Name .. " [×" .. 3 .. "]" or v147.DisplayName
};
u8.Gifts[tostring(2319692175)] = v148;
local GiftOrder12 = u8.GiftOrder;
local v149 = tostring(2319692175);
table.insert(GiftOrder12, v149);
local v150 = ShopLibrary.Entries["lootbox_Skin Case 3"] or error("???");
local v151 = {
    ProductID = 3251887720,
    ProductType = "Product",
    GiftType = "ShopEntry",
    GiftName = "lootbox_Skin Case 3",
    IsPaidRandomItem = true,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v150.ProductQuantityToID[1] or v150.ProductID,
    DisplayName = v150.Rewards[1].Name .. "" or v150.DisplayName
};
u8.Gifts[tostring(3251887720)] = v151;
local GiftOrder13 = u8.GiftOrder;
local v152 = tostring(3251887720);
table.insert(GiftOrder13, v152);
local v153 = ShopLibrary.Entries["lootbox_Skin Case 3"] or error("???");
local v154 = {
    ProductID = 3251887824,
    ProductType = "Product",
    GiftType = "ShopEntry",
    GiftName = "lootbox_Skin Case 3",
    IsPaidRandomItem = true,
    Quantity = 3,
    ImageID = nil,
    TargetProductID = v153.ProductQuantityToID[3] or v153.ProductID,
    DisplayName = v153.Rewards[1].Name .. " [×" .. 3 .. "]" or v153.DisplayName
};
u8.Gifts[tostring(3251887824)] = v154;
local GiftOrder14 = u8.GiftOrder;
local v155 = tostring(3251887824);
table.insert(GiftOrder14, v155);
local v156 = u8.Bundles.keybundle_1 or error("???");
local v157 = {
    ProductID = 1890374722,
    ProductType = "Product",
    GiftType = "Bundle",
    GiftName = "keybundle_1",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v156.ProductID,
    DisplayName = v156.DisplayName
};
u8.Gifts[tostring(1890374722)] = v157;
local GiftOrder15 = u8.GiftOrder;
local v158 = tostring(1890374722);
table.insert(GiftOrder15, v158);
local v159 = u8.Bundles.keybundle_2 or error("???");
local v160 = {
    ProductID = 1890374959,
    ProductType = "Product",
    GiftType = "Bundle",
    GiftName = "keybundle_2",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v159.ProductID,
    DisplayName = v159.DisplayName
};
u8.Gifts[tostring(1890374959)] = v160;
local GiftOrder16 = u8.GiftOrder;
local v161 = tostring(1890374959);
table.insert(GiftOrder16, v161);
local v162 = u8.Bundles.keybundle_3 or error("???");
local v163 = {
    ProductID = 1890375172,
    ProductType = "Product",
    GiftType = "Bundle",
    GiftName = "keybundle_3",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v162.ProductID,
    DisplayName = v162.DisplayName
};
u8.Gifts[tostring(1890375172)] = v163;
local GiftOrder17 = u8.GiftOrder;
local v164 = tostring(1890375172);
table.insert(GiftOrder17, v164);
local v165 = u8.Bundles.keybundle_4 or error("???");
local v166 = {
    ProductID = 1890375405,
    ProductType = "Product",
    GiftType = "Bundle",
    GiftName = "keybundle_4",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v165.ProductID,
    DisplayName = v165.DisplayName
};
u8.Gifts[tostring(1890375405)] = v166;
local GiftOrder18 = u8.GiftOrder;
local v167 = tostring(1890375405);
table.insert(GiftOrder18, v167);
local v168 = u8.Bundles.keybundle_5 or error("???");
local v169 = {
    ProductID = 1890375611,
    ProductType = "Product",
    GiftType = "Bundle",
    GiftName = "keybundle_5",
    IsPaidRandomItem = nil,
    Quantity = nil,
    ImageID = nil,
    TargetProductID = v168.ProductID,
    DisplayName = v168.DisplayName
};
u8.Gifts[tostring(1890375611)] = v169;
local GiftOrder19 = u8.GiftOrder;
local v170 = tostring(1890375611);
table.insert(GiftOrder19, v170);

for _, v in pairs(u8.CosmeticBundlesOrder) do
    if v ~= EventLibrary.SKIN_BUNDLE_NAME then
        add_bundle_gift(v);
    end;
end;

local function add_video_ad_reward(p171, p172, p173) -- Line: 667
    -- upvalues: u8 (copy)
    table.insert(u8.VideoAdRewards, {
        NumAdsRequired = p171,
        RewardDatas = p172 or {},
        PreRepetitionRewardDatas = p173 or {}
    });
end;

add_video_ad_reward(1, { {
        Name = "3D Glasses",
        Quantity = 1,
        Weapon = "IsRandom"
    } }, nil);
add_video_ad_reward(2, { {
        Name = "Glamour",
        Quantity = 1,
        Weapon = "IsRandom"
    } }, nil);
add_video_ad_reward(
    3,
    { {
            Name = "Director\'s Cut",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    { {
            Name = "Key",
            Quantity = 3
        } }
);

local function add_ugc(p174, p175, p176) -- Line: 681
    -- upvalues: u8 (copy)
    assert(not u8.UGCs[p174]);

    for _, v in pairs(u8.UGCs) do
        assert(v.AssetID ~= p175);
    end;

    u8.UGCs[p174] = {
        Name = p174,
        AssetID = p175,
        CanBeMisleading = p176
    };
    u8.UGCAssetIDToName[tostring(p175)] = p174;
    table.insert(u8.UGCOrder, p174);
end;

add_ugc("clothing_iloverivals1", 137732463728326);
add_ugc("clothing_iloverivals2", 90796679262086);
add_ugc("clothing_arenashirt", 137296265324812);
add_ugc("clothing_arenapants", 129512336852435);
add_ugc("ugc_arenamanhead", 92733410260261);
add_ugc("ugc_removeautoshootsign", 96099566912338);
add_ugc("ugc_rivalskatana", 125867270722283, true);
add_ugc("ugc_rivalsrpkey", 111522988085700, true);
add_ugc("ugc_rivalskeyvolver", 113554056154134, true);
add_ugc("ugc_rivalskeytana", 109723477692566, true);
add_ugc("ugc_rivalskeythe", 124750945461549, true);
add_ugc("ugc_rivalsakey", 107643383612249, true);
add_ugc("ugc_rivalskeyper", 115241839813934, true);
add_ugc("ugc_rivalskeybow", 84129786923826, true);
add_ugc("ugc_rivalsshotkey", 85619994948307, true);
add_ugc("ugc_rivalskeyttleaxe", 112664145011287, true);
add_ugc("ugc_rivalskeyzi", 103972049379360, true);
add_ugc("ugc_rivalskeylisong", 138648784848614, true);
add_ugc("ugc_rivalskeyrambit", 84629336575689, true);
add_ugc("ugc_rivalskeynais", 105245077140577, true);
add_ugc("ugc_rivalskeyst", 117095370466098, true);
add_ugc("ugc_shouldermedkitty", 103869769768832, true);
add_ugc("ugc_rivalsnotebook", 133770605510980, true);
add_ugc("ugc_targetmask", 127292540343907);
add_ugc("ugc_eliminatedtrollface", 121118883943056);
add_ugc("ugc_disconnectedtrollface", 73916910731449);
add_ugc("ugc_unranked", 115861376533108);
add_ugc("ugc_bronzerank", 101681212276850);
add_ugc("ugc_silverrank", 140214523497602);
add_ugc("ugc_goldrank", 102276356750407);
add_ugc("ugc_platinumrank", 110101090201266);
add_ugc("ugc_diamondrank", 133745283061883);
add_ugc("ugc_onyxrank", 85555348152612);
add_ugc("ugc_nemesisrank", 110806369909684);
add_ugc("ugc_archnemesisrank", 102797305676607);

local function add_ugc_milestone(p177, p178, p179) -- Line: 735
    -- upvalues: u8 (copy), CosmeticLibrary (copy)
    assert(not u8.UGCMilestones[p177]);
    local v180 = {
        Name = p177,
        PurchaseRequirement = p178,
        Reward = p179
    };
    u8.UGCMilestones[p177] = v180;
    table.insert(u8.UGCMilestoneOrder, p177);

    if CosmeticLibrary.Cosmetics[v180.Reward.Name] then
        CosmeticLibrary:ExternallySetCosmeticDescription(v180.Reward.Name, "Earned from purchasing " .. v180.PurchaseRequirement .. " UGC item" .. (v180.PurchaseRequirement == 1 and "" or "s"));
    end;
end;

add_ugc_milestone("ugc_milestone0", 1, {
    Name = "Skin Ticket",
    Quantity = 1
});
add_ugc_milestone("ugc_milestone1", 5, {
    Name = "Sneaker",
    Weapon = "IsUniversal"
});
add_ugc_milestone("ugc_milestone2", 10, {
    Name = "Heirloom",
    Weapon = "IsUniversal"
});
add_ugc_milestone("ugc_milestone3", 15, {
    Name = "Plushify",
    Weapon = "IsUniversal"
});
add_ugc_milestone("ugc_milestone4", 20, {
    Name = "Busting A Move"
});
add_ugc_milestone("ugc_milestone5", 25, {
    Name = "Fist",
    Weapon = "Fists"
});

return u8;