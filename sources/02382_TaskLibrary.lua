-- Instance: ReplicatedStorage .Modules.TaskLibrary
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EventLibrary = require(ReplicatedStorage.Modules.EventLibrary);
local ServerOsTime = require(ReplicatedStorage.Modules.ServerOsTime);
local TestAttribute = require(ReplicatedStorage.Modules.TestLibrary):GetTestAttribute("StudioTestUnreleasedTasks");
local u3 = {
    TASKS_DATA_NAMES = { "Tasks", "BonusTasks", "EventTasks", "SpecialChallenges", "LimitedTasks" },
    NUM_BEGINNER_TASKS = 3,
    DAILY_TASKS_RARE_REWARD = "Nova",
    DAILY_TASKS_RARE_REWARD_CHANCE = 0.05,
    DAILY_TASKS_LEGENDARY_REWARD = "Supernova",
    DAILY_TASKS_LEGENDARY_REWARD_CHANCE = 0.01,
    SPECIAL_CHALLENGES_VERSION = 3,
    SPECIAL_CHALLENGES = nil,
    SPECIAL_CHALLENGES_MUST_BE_COMPLETED_IN_ORDER = false,
    DAILY_TASK_STREAK_REWARD_MAX_MULTIPLIER = 1,
    NUM_DAILY_TASK_STREAK_REWARD_MILESTONES = 0,
    Info = {},
    LimitedTimeTasksBatches = {},
    DailyTaskStreakRewards = {},

    GetCurrentlyActiveLimitedTasks = function(p1) -- Line: 27, Name: GetCurrentlyActiveLimitedTasks
        -- upvalues: ServerOsTime (copy)
        local v2 = ServerOsTime:Get();

        for _, v in pairs(p1.LimitedTimeTasksBatches) do
            if v.StartTimestamp <= v2 and v2 < v.FinishTimestamp then
                return v;
            end;
        end;
    end
};

local function add_task(p4, p5, p6, p7, p8, p9, p10, p11) -- Line: 37
    -- upvalues: u3 (copy)
    local v12 = {
        Goal = p5,
        Title = p7,
        Icon = p8 or "rbxassetid://17619445009",
        Rewards = typeof(p6) == "number" and ({
            {
                Name = "Key",
                Quantity = p6
            }
        } or p6) or p6,
        BadgeName = p9,
        CanBeMultipliedByEventBoost = p10,
        MaxCompletionsPerDay = p11
    };
    u3.Info[p4] = v12;
end;

add_task("Beginner1", 1, 1, "Go to Shooting Range", "rbxassetid://17539215512");
add_task("Beginner2", 5, 1, "Break targets", "rbxassetid://17738770088");
add_task("Beginner3", 3, 1, "Run + crouch to Slide", "rbxassetid://17735857643");
add_task("Beginner4", 1, 2, "Equip Scythe", "rbxassetid://17735878660");
add_task("Beginner5", 3, 2, "Scythe Dash (MB2 / Aim)", "rbxassetid://16828140099");
add_task("Beginner6", 1, 2, "Throw a Grenade", "rbxassetid://17513805716");
add_task("Beginner7", 1, 3, "Play a duel", "rbxassetid://17738769051");
add_task("Beginner8", 5, 3, "Eliminations", "rbxassetid://17735857264");
add_task("Beginner9", 1, 3, "Win a duel", "rbxassetid://17735868621");
add_task("Core1", 5, 1, "Play duels", "rbxassetid://17738769051");
add_task("Core2", 15, 2, "Eliminations", "rbxassetid://17735857264");
add_task("Core3", 2, 3, "Win duels", "rbxassetid://17735868621");
add_task("RepeatableCore1", 10, 1, "Play duels", "rbxassetid://17738769051", nil, nil, 3);
add_task("RepeatableCore2", 35, 2, "Eliminations", "rbxassetid://17735857264", nil, nil, 3);
add_task("RepeatableCore3", 10, 3, "Win duels", "rbxassetid://17735868621", nil, nil, 3);
add_task(
    "RepeatableWins",
    25,
    { {
            Name = "Trophy",
            Weapon = "IsRandom",
            Quantity = 1
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "RepeatableStreak",
    10,
    { {
            Name = "Fire",
            Weapon = "IsRandom",
            Quantity = 1
        } },
    "Win duels in a row",
    "rbxassetid://18151049137"
);
add_task(
    "RepeatableStreak2",
    100,
    { {
            Name = "Blaze",
            Weapon = "IsRandom",
            Quantity = 1
        } },
    "Win duels in a row",
    "rbxassetid://18151049137"
);
add_task(
    "EventDuelRoundPlayed",
    5,
    { {
            Name = "EventCurrency",
            Quantity = 3
        } },
    "Play rounds in a duel",
    "rbxassetid://17738769051",
    nil,
    true
);
add_task(
    "EventEliminations",
    15,
    { {
            Name = "EventCurrency",
            Quantity = 4
        } },
    "Eliminations",
    "rbxassetid://17735857264",
    nil,
    true
);
add_task(
    "EventDuelWon",
    1,
    { {
            Name = "EventCurrency",
            Quantity = 5
        } },
    "Win a duel",
    "rbxassetid://17735868621",
    nil,
    true
);
add_task("EventDuelWon2", 5, {
    {
        Quantity = 1,
        Weapon = "IsRandom",
        Name = EventLibrary.PRIZE_WHEEL_NAME
    }
}, "Win duels", "rbxassetid://17735868621", nil, nil, 1);
add_task("EventDuelWon3", 10, {
    {
        Quantity = 1,
        Weapon = "IsRandom",
        Name = EventLibrary.SPECIAL_LOOTBOX_VARIETY
    }
}, "Win duels", "rbxassetid://17735868621", nil, nil, 1);
add_task("EventDuelWon4", 20, {
    {
        Quantity = 1,
        Weapon = "IsRandom",
        Name = EventLibrary.PRIZE_WHEEL_NAME
    }
}, "Win duels", "rbxassetid://17735868621", nil, nil, 1);
add_task(
    "SpecialChallenge1",
    15,
    { {
            Name = "Key",
            Quantity = 5
        }, {
            Name = "Jolly Chest",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    "Eliminate players in duels",
    "rbxassetid://101221631717761",
    "2024WinterSpotlight1"
);
add_task(
    "SpecialChallenge2",
    100,
    { {
            Name = "Key",
            Quantity = 15
        }, {
            Name = "Jolly Chest",
            Quantity = 3,
            Weapon = "IsRandom"
        }, {
            Name = "Danger",
            Quantity = 1,
            Weapon = "IsUniversal"
        } },
    "Eliminate players in ???",
    "rbxassetid://112147813284051",
    "2024WinterSpotlight2"
);
add_task(
    "SpecialChallengeBridge1",
    5,
    { {
            Name = "Key",
            Quantity = 3
        } },
    "Play duels on the Bridge map",
    "rbxassetid://17738769051"
);
add_task(
    "SpecialChallengeBridge2",
    25,
    { {
            Name = "Bungeoppang",
            Quantity = 1,
            Weapon = "IsUniversal"
        } },
    "Eliminate players on the Bridge map",
    "rbxassetid://17735857264"
);
add_task("Limited_Birthday2_Keys", 1, 3, "Win a duel", "rbxassetid://17735868621");
add_task(
    "Limited_Birthday2_Charm",
    5,
    { {
            Name = "2nd Birthday Cake",
            Weapon = "IsUniversal"
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_Birthday2_Wrap",
    10,
    { {
            Name = "Confetti Cake",
            Weapon = "IsUniversal"
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_Birthday2_Finisher",
    25,
    { {
            Name = "Caked",
            Weapon = "IsUniversal"
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_Birthday2_Emote",
    50,
    { {
            Name = "Yummy Cake"
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_Birthday2_Skin",
    100,
    { {
            Name = "Birthday Candle",
            Weapon = "Knife"
        } },
    "Backstab eliminations",
    "rbxassetid://17225650859"
);
add_task(
    "Limited_2026Summer_Task1",
    1,
    { {
            Name = "EventCurrency",
            Quantity = 50
        } },
    "Win a duel",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_2026Summer_Task2",
    3,
    { {
            Name = "EventCurrency",
            Quantity = 100
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_2026Summer_Task3",
    5,
    { {
            Name = "EventCurrency",
            Quantity = 200
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_2026Summer_Task4",
    10,
    { {
            Name = "Tropical Chest",
            Quantity = 9,
            Weapon = "IsRandom"
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_2026Summer_Task5",
    15,
    { {
            Name = "EventCurrency",
            Quantity = 300
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_2026Summer_Task6",
    20,
    { {
            Name = "Spooky Skin Case",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_2026Spooky_Task1",
    1,
    { {
            Name = "EventCurrency",
            Quantity = 100
        } },
    "Win a duel",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_2026Spooky_Task2",
    5,
    { {
            Name = "EventCurrency",
            Quantity = 200
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_2026Spooky_Task3",
    10,
    { {
            Name = "Haunted Chest",
            Quantity = 3,
            Weapon = "IsRandom"
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_2026Spooky_Task4",
    15,
    { {
            Name = "Spooky Prize Wheel",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_2026Spooky_Task5",
    25,
    { {
            Name = "Spooky Prize Wheel",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    "Win duels",
    "rbxassetid://17735868621"
);
add_task(
    "Limited_2026Spooky_Task6",
    50,
    { {
            Name = "Spooky Skin Case",
            Quantity = 1,
            Weapon = "IsRandom"
        } },
    "Win duels",
    "rbxassetid://17735868621"
);

local function add_limited_time_tasks_batch(p13, p14, p15, p16, p17, p18, p19, p20) -- Line: 106
    -- upvalues: u3 (copy)
    u3.LimitedTimeTasksBatches[p13] = {
        Name = p13,
        RequiresPreviousTaskCompleted = p14,
        DisplayName = p15,
        Image = p16,
        ImageSize = p17,
        StartTimestamp = p18,
        Duration = p19,
        FinishTimestamp = p18 + p19,
        TaskNames = p20
    };
end;

local v21 = {
    Name = "ltt_bday2",
    RequiresPreviousTaskCompleted = true,
    DisplayName = "Birthday Celebration",
    Image = "rbxassetid://17653923757",
    StartTimestamp = 1782619200,
    Duration = 1209600,
    FinishTimestamp = 1783828800,
    ImageSize = UDim2.new(2, 0, 1.5, 0),
    TaskNames = { "Limited_Birthday2_Keys", "Limited_Birthday2_Charm", "Limited_Birthday2_Wrap", "Limited_Birthday2_Finisher", "Limited_Birthday2_Emote", "Limited_Birthday2_Skin" }
};
u3.LimitedTimeTasksBatches.ltt_bday2 = v21;
local v22 = {
    Name = "ltt_summer2026",
    RequiresPreviousTaskCompleted = true,
    DisplayName = "Summer Fun",
    Image = "rbxassetid://17653923757",
    StartTimestamp = 1784260800,
    Duration = 1209600,
    FinishTimestamp = 1785470400,
    ImageSize = UDim2.new(2, 0, 1.5, 0),
    TaskNames = { "Limited_2026Summer_Task1", "Limited_2026Summer_Task2", "Limited_2026Summer_Task3", "Limited_2026Summer_Task4", "Limited_2026Summer_Task5", "Limited_2026Summer_Task6" }
};
u3.LimitedTimeTasksBatches.ltt_summer2026 = v22;
local v23 = {
    Name = "ltt_spooky2026",
    RequiresPreviousTaskCompleted = true,
    DisplayName = "No Tricks, Just Treats",
    Image = "rbxassetid://17653923757",
    StartTimestamp = 1793246400,
    Duration = 950400,
    FinishTimestamp = 1794196800,
    ImageSize = UDim2.new(2, 0, 1.5, 0),
    TaskNames = { "Limited_2026Spooky_Task1", "Limited_2026Spooky_Task2", "Limited_2026Spooky_Task3", "Limited_2026Spooky_Task4", "Limited_2026Spooky_Task5", "Limited_2026Spooky_Task6" }
};
u3.LimitedTimeTasksBatches.ltt_spooky2026 = v23;

local function add_daily_task_streak_reward(p24, p25, p26) -- Line: 126
    -- upvalues: u3 (copy)
    local v27 = {
        Milestone = p24,
        CanMultiplyRewards = p25,
        Rewards = typeof(p26) == "number" and ({
            {
                Name = "Key",
                Quantity = p26
            }
        } or p26) or p26
    };
    u3.DailyTaskStreakRewards[p24] = v27;
    u3.NUM_DAILY_TASK_STREAK_REWARD_MILESTONES = math.max(u3.NUM_DAILY_TASK_STREAK_REWARD_MILESTONES, p24);
end;

add_daily_task_streak_reward(1, true, {});
add_daily_task_streak_reward(2, true, { {
        Name = "Prize Wheel",
        Quantity = 1,
        Weapon = "IsRandom"
    } });
add_daily_task_streak_reward(3, true, {});
add_daily_task_streak_reward(4, true, { {
        Name = "Prize Wheel",
        Quantity = 1,
        Weapon = "IsRandom"
    } });
add_daily_task_streak_reward(5, true, {});
add_daily_task_streak_reward(6, true, { {
        Name = "Prize Wheel",
        Quantity = 1,
        Weapon = "IsRandom"
    } });
add_daily_task_streak_reward(7, false, { {
        Name = "Prize Wheel",
        Quantity = 1,
        Weapon = "IsRandom"
    } });

if TestAttribute then
    local v28 = nil;

    for _, v in pairs(u3.LimitedTimeTasksBatches) do
        if v.StartTimestamp > os.time() then
            v28 = v;
            break;
        end;
    end;

    v28.StartTimestamp = os.time();
    v28.FinishTimestamp = v28.StartTimestamp + v28.Duration;
end;

return u3;