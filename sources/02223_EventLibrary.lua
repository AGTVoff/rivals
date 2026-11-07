-- Instance: ReplicatedStorage .Modules.EventLibrary
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local v1 = {
    Summer = {
        CURRENCY_NAME = "Pearl",
        CURRENCY_NAME_PLURAL = "Pearls",
        CURRENCY_IMAGE = "rbxassetid://128587370010060",
        CURRENCY_IMAGE_FLAT = "rbxassetid://93406657709407",
        CURRENCY_IMAGE_FLAT_OUTLINE = "rbxassetid://95350863643200",
        CURRENCY_COLOR_GRADIENT = nil,
        OVERVIEW_BANNER_IMAGE = "rbxassetid://117618245635260",
        OVERVIEW_BUTTON_IMAGE = "rbxassetid://92989711430837",
        LOADING_SCREEN_LOGO = "rbxassetid://85313933907097",
        LOBBY_MUSIC = "Tropical",
        LOBBY_MUSIC_MUFFLED = "TropicalMuffled",
        LOBBY_LIGHTING_PROFILE = "LobbyTropical",
        EQUIPMENT_LIGHTING_PROFILE = "LobbyTropical",
        LTM_HEADER_ICON = "rbxassetid://78136793834272",
        CURRENCY_COLOR = Color3.fromRGB(239, 176, 255),
        BUNDLE_BACKGROUND_IMAGES = {
            [1] = "rbxassetid://120786971461452",
            [4] = "rbxassetid://73561500503723",
            [5] = "rbxassetid://79528672047345"
        },
        GLOWY_BACKGROUND_COLOR_OVERRIDES = {
            Purple = Color3.fromRGB(42, 85, 111),
            Purple2 = Color3.fromRGB(31, 61, 144),
            Yellow = Color3.fromRGB(17, 0, 254)
        }
    },
    Spooky = {
        CURRENCY_NAME = "Candy",
        CURRENCY_NAME_PLURAL = "Candy",
        CURRENCY_IMAGE = "rbxassetid://139984992207621",
        CURRENCY_IMAGE_FLAT = "rbxassetid://105505748492292",
        CURRENCY_IMAGE_FLAT_OUTLINE = "rbxassetid://90825880394324",
        CURRENCY_COLOR_GRADIENT = nil,
        OVERVIEW_BANNER_IMAGE = "rbxassetid://121777952645484",
        OVERVIEW_BUTTON_IMAGE = "rbxassetid://80974689450076",
        LOADING_SCREEN_LOGO = "rbxassetid://96198404149077",
        LOBBY_MUSIC = "Spooky",
        LOBBY_MUSIC_MUFFLED = "SpookyMuffled",
        LOBBY_LIGHTING_PROFILE = "LobbySpooky",
        EQUIPMENT_LIGHTING_PROFILE = "LobbySpooky",
        LTM_HEADER_ICON = "rbxassetid://78136793834272",
        CURRENCY_COLOR = Color3.fromRGB(255, 127, 0),
        BUNDLE_BACKGROUND_IMAGES = {
            [1] = "rbxassetid://140701532981455",
            [5] = "rbxassetid://121767138688269"
        },
        GLOWY_BACKGROUND_COLOR_OVERRIDES = {
            Purple = Color3.fromRGB(123, 255, 0),
            Purple2 = Color3.fromRGB(32, 12, 66),
            Yellow = Color3.fromRGB(0, 0, 0)
        }
    },
    Festive = {
        CURRENCY_NAME = "Crystal",
        CURRENCY_NAME_PLURAL = "Crystals",
        CURRENCY_IMAGE = "rbxassetid://134934134842764",
        CURRENCY_IMAGE_FLAT = "rbxassetid://116178247622565",
        CURRENCY_IMAGE_FLAT_OUTLINE = "rbxassetid://89625231758124",
        CURRENCY_COLOR_GRADIENT = nil,
        OVERVIEW_BANNER_IMAGE = "rbxassetid://109554184678249",
        OVERVIEW_BUTTON_IMAGE = "rbxassetid://134934134842764",
        LOADING_SCREEN_LOGO = "rbxassetid://101362140024495",
        LOBBY_MUSIC = "Festive",
        LOBBY_MUSIC_MUFFLED = "FestiveMuffled",
        LOBBY_LIGHTING_PROFILE = "LobbyFestive",
        EQUIPMENT_LIGHTING_PROFILE = "LobbyFestive",
        LTM_HEADER_ICON = "rbxassetid://78136793834272",
        CURRENCY_COLOR = Color3.fromRGB(48, 221, 255),
        BUNDLE_BACKGROUND_IMAGES = {
            [1] = "rbxassetid://135222754688862",
            [5] = "rbxassetid://93388902108383"
        }
    }
};
local u2 = {
    IS_ACTIVE = true,
    NUM_GAMES_NEEDED_TO_PARTICIPATE = 15,
    RESET_CURRENCY_COUNTER = 9,
    RESET_CURRENCY_COMPENSATION_MILESTONE = 30,
    RESET_CURRENCY_COMPENSATION_REWARDS = { {
            Name = "Tropical Chest",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    RESET_CURRENCY_COMPENSATION_REWARDS_CAN_MULTIPLY_QUANTITY = true,
    LAST_EVENT_NAME = "Summer",
    EVENT_NAME = "Spooky",
    EVENT_TASK_NAMES = { "EventDuelRoundPlayed", "EventEliminations", "EventDuelWon", "EventDuelWon2", "EventDuelWon3", "EventDuelWon4" },
    CURRENCY_RUSH_DAILY_LIMIT = 200,
    CURRENCY_RUSH_MULTIPLIER = 5,
    LTM_QUEUENAMES = { "ltm_monstertower_gargoyletower", "ltm_monstertower_gargoyletower_solo", "ltm_monstertower_zombietower", "ltm_monstertower_zombietower_solo" },
    LTM_QUEUES_SMART_TILING_X_SIZE_MULTIPLIER = 0.3,
    LTM_QUEUES_SMART_TILING_DISABLED = false,
    LTM_QUEUES_REWARDS_DISPLAYED = { "Chombie Head", "Zombie", "Towerstone Fists", "Gargoyle Head", "Conduction", "Towerstone Wildcat" },
    UNIVERSAL_SHOP_CHARM = "Jerm",
    UNIVERSAL_SHOP_WRAP = "Brewery",
    UNIVERSAL_SHOP_FINISHER = "Acid Splash",
    UNIVERSAL_SHOP_EMOTE = "Zombie Walk",
    STANDALONE_SHOP_SKIN = {
        Name = "Cursed Daggers",
        Weapon = "Daggers"
    },
    SPECIAL_LOOTBOX_SKINS = "Spooky Skin Case",
    SPECIAL_LOOTBOX_VARIETY = "Haunted Chest",
    CURRENCY_BUNDLE_CHARM = "Dumbkin",
    CURRENCY_BUNDLE_WRAP = "Greenflame",
    CURRENCY_BUNDLE_FINISHER = "DRIP",
    CURRENCY_BUNDLE_SKIN = "Shadow Wildcat",
    PRIZE_WHEEL_NAME = "Spooky Prize Wheel",
    SKIN_BUNDLE_NAME = "bat_bundle",
    EVENT_GIFT_REWARD = nil,
    EVENT_GIFT_COOLDOWN = 3600,
    SHOP_ENTRIES_OVERVIEW = {}
};
u2.EVENT_DETAILS = v1[u2.EVENT_NAME];
u2.LAST_EVENT_DETAILS = v1[u2.LAST_EVENT_NAME];
u2.LOBBY_VISUALS_PROFILE = not u2.IS_ACTIVE and "Default" or u2.EVENT_NAME;
u2.STANDALONE_SHOP_SKIN_SHOP_ENTRY_NAME = "loose_standaloneeventskin";
local v3;

if u2.PRIZE_WHEEL_NAME then
    v3 = "lootbox_" .. u2.PRIZE_WHEEL_NAME;
else
    v3 = nil;
end;

u2.STANDALONE_PRIZE_WHEEL_SHOP_ENTRY_NAME = v3;
(function() -- Line: 130, Name: populate_shop_entries
    -- upvalues: u2 (copy)
    if u2.PRIZE_WHEEL_NAME then
        table.insert(u2.SHOP_ENTRIES_OVERVIEW, u2.STANDALONE_PRIZE_WHEEL_SHOP_ENTRY_NAME);
    end;

    if u2.SPECIAL_LOOTBOX_SKINS then
        table.insert(u2.SHOP_ENTRIES_OVERVIEW, "lootbox_" .. u2.SPECIAL_LOOTBOX_SKINS);
    end;

    if u2.SPECIAL_LOOTBOX_VARIETY then
        table.insert(u2.SHOP_ENTRIES_OVERVIEW, "lootbox_" .. u2.SPECIAL_LOOTBOX_VARIETY);
    end;

    if u2.UNIVERSAL_SHOP_CHARM then
        table.insert(u2.SHOP_ENTRIES_OVERVIEW, "loose_" .. u2.UNIVERSAL_SHOP_CHARM);
    end;

    if u2.UNIVERSAL_SHOP_WRAP then
        table.insert(u2.SHOP_ENTRIES_OVERVIEW, "loose_" .. u2.UNIVERSAL_SHOP_WRAP);
    end;

    if u2.UNIVERSAL_SHOP_FINISHER then
        table.insert(u2.SHOP_ENTRIES_OVERVIEW, "loose_" .. u2.UNIVERSAL_SHOP_FINISHER);
    end;

    if u2.UNIVERSAL_SHOP_EMOTE then
        table.insert(u2.SHOP_ENTRIES_OVERVIEW, "loose_" .. u2.UNIVERSAL_SHOP_EMOTE);
    end;

    if u2.STANDALONE_SHOP_SKIN then
        table.insert(u2.SHOP_ENTRIES_OVERVIEW, u2.STANDALONE_SHOP_SKIN_SHOP_ENTRY_NAME);
    end;
end)();

return u2;