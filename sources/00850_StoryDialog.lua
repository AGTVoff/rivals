-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.ClientReplicatedClasses.ClientDuel.DuelInterface.StoryDialog
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 10
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.DuelInterface = p2;
    v3.Frame = v3.DuelInterface.Frame:WaitForChild("Top"):WaitForChild("StoryDialog");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.RightSpeakerFrame = v3.Container:WaitForChild("RightSpeaker");
    v3.RightSpeakerImage = v3.RightSpeakerFrame:WaitForChild("Player"):WaitForChild("Headshot");
    v3.LeftSpeakerFrame = v3.Container:WaitForChild("LeftSpeaker");
    v3.LeftSpeakerImage = v3.LeftSpeakerFrame:WaitForChild("Player"):WaitForChild("Headshot");
    v3.Message = v3.Container:WaitForChild("Message");
    v3._destroyed = false;
    v3._is_playing_story = false;
    v3._already_played = {};
    v3._random = Random.new(v3.DuelInterface.ClientDuel:Get("DuelSeed"));
    v3:_Init();

    return v3;
end;

function u1.CreateSound(p4, ...) -- Line: 36
    local v5 = p4.Frame.Visible and p4.Container.Visible and p4.DuelInterface:CreateSound(...);

    return v5;
end;

function u1.Update(p6) -- Line: 40
    local Frame = p6.Frame;
    local v7 = not (p6.DuelInterface.Scoreboard:IsOpen() or p6.DuelInterface:IsPageOpen()) and not p6.DuelInterface.RoundResult.Frame.Visible;
    Frame.Visible = v7;

    if p6.DuelInterface.ClientDuel:Get("Status") == "RoundStarted" then
        task.spawn(p6._AttemptToPlayStory, p6);
    end;
end;

function u1.Destroy(p8) -- Line: 48
    p8._destroyed = true;
end;

function u1._GetRandomSpeaker(p9, ...) -- Line: 56
    local v10 = { ... };
    local v11 = {};

    for _, v in pairs(p9.DuelInterface.ClientDuel.Duelers) do
        if v.Player and not table.find(v10, v.Player) then
            table.insert(v11, v.Player);
        end;
    end;

    table.sort(v11, function(p12, p13) -- Line: 66
        return p12.UserId < p13.UserId;
    end);

    if #v11 == 0 then
        return nil;
    end;

    return v11[p9._random:NextInteger(1, #v11)];
end;

function u1._PlayDialog(p14, p15, p16) -- Line: 73
    -- upvalues: Players (copy), CONSTANTS (copy)
    p14._is_playing_story = true;
    p14.Container.Visible = true;
    p14.Container.Size = UDim2.new(1, 0, 1, 0);
    p14:CreateSound("rbxassetid://105553937408843", 1, 1, script, true, 10);

    for i, v in pairs(p16) do
        if p14._destroyed then
            return;
        end;

        task.delay(i == 1 and 0.5 or 0, p14.CreateSound, p14, "rbxassetid://124144337176625", 1, 0.9 + 0.2 * math.random(), script, true, 10);

        if p14.Container:IsDescendantOf(Players.LocalPlayer.PlayerGui) then
            p14.Container.Size = UDim2.new(1.1, 0, 1.1, 0);
            p14.Container:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quint", 0.25, true);
        end;

        p14.Message.Text = v.Message;
        p14.RightSpeakerFrame.Visible = table.find(p15, v.Speaker) == 1;
        p14.RightSpeakerImage.Image = string.format(CONSTANTS.HEADSHOT_IMAGE, v.Speaker.UserId);
        p14.LeftSpeakerImage.Image = p14.RightSpeakerImage.Image;
        p14.LeftSpeakerFrame.Visible = not p14.RightSpeakerFrame.Visible;
        wait(v.WaitBeforeMovingOn);
    end;

    if p14.Container:IsDescendantOf(Players.LocalPlayer.PlayerGui) then
        p14:CreateSound("rbxassetid://105553937408843", 1, 0.75, script, true, 10);
        p14.Container:TweenSize(UDim2.new(0.25, 0, 0.25, 0), "In", "Quint", 0.25, true);
        wait(0.25);
    end;

    p14._is_playing_story = false;
    p14.Container.Visible = false;
end;

function u1._ZombieTowerIntro(p17) -- Line: 111
    local v18 = p17:_GetRandomSpeaker();
    local v19 = p17:_GetRandomSpeaker(v18);

    if v18 and v19 then
        p17:_PlayDialog({ v18, v19 }, {
            {
                WaitBeforeMovingOn = 6,
                Message = "This must be the tower our intel had us locate.",
                Speaker = v18
            },
            {
                WaitBeforeMovingOn = 6,
                Message = "Let\'s find our way to the top and radio for rescue.",
                Speaker = v18
            },
            {
                WaitBeforeMovingOn = 4,
                Message = "Easier said than done!",
                Speaker = v19
            },
            {
                WaitBeforeMovingOn = 6,
                Message = "Do you see how tall it is? I can\'t even see the top!",
                Speaker = v19
            },
            {
                WaitBeforeMovingOn = 6,
                Message = "We\'re so dead. I really thought we had a chance.",
                Speaker = v19
            },
            {
                WaitBeforeMovingOn = 4,
                Message = "We do have a chance.\n",
                Speaker = v18
            },
            {
                WaitBeforeMovingOn = 4,
                Message = "Just stay focused. We\'ve come too far to give up.",
                Speaker = v18
            },
            {
                WaitBeforeMovingOn = 6,
                Message = "We\'re looking for a.. what? A radio? Then what?",
                Speaker = v19
            },
            {
                WaitBeforeMovingOn = 6,
                Message = "..then we hope for the best. Let\'s go!",
                Speaker = v18
            }
        });

        return;
    end;

    if not v18 then
        return;
    end;

    p17:_PlayDialog({ v18 }, {
        {
            WaitBeforeMovingOn = 6,
            Message = "This is it. This is the tower they told me to find.",
            Speaker = v18
        },
        {
            WaitBeforeMovingOn = 6,
            Message = "I\'m the only one left. I can\'t give up now.",
            Speaker = v18
        },
        {
            WaitBeforeMovingOn = 6,
            Message = "All I need to do now is reach the top and.. radio for help.",
            Speaker = v18
        },
        {
            WaitBeforeMovingOn = 6,
            Message = "No problem at all. No big deal.. I got this..",
            Speaker = v18
        }
    });
end;

function u1._GargoyleTowerIntro(p20) -- Line: 145
    local v21 = p20:_GetRandomSpeaker();
    local v22 = p20:_GetRandomSpeaker(v21);

    if v21 and v22 then
        p20:_PlayDialog({ v21, v22 }, {
            {
                WaitBeforeMovingOn = 6,
                Message = "The intel was right, that crack at the base of the tower is the only way in.",
                Speaker = v21
            },
            {
                WaitBeforeMovingOn = 6,
                Message = "This is scarier than last time, this better be our way out.",
                Speaker = v22
            },
            {
                WaitBeforeMovingOn = 6,
                Message = "Our Warper is toast, going up is our only route back to the rest of the squad.",
                Speaker = v21
            },
            {
                WaitBeforeMovingOn = 6,
                Message = "They said the last team set rendezvous for the top of the tower, they left a radio.",
                Speaker = v22
            },
            {
                WaitBeforeMovingOn = 6,
                Message = "Good, I want out of this place.",
                Speaker = v21
            },
            {
                WaitBeforeMovingOn = 6,
                Message = "I don\'t understand how this tower resembles Headquarters at all..",
                Speaker = v22
            },
            {
                WaitBeforeMovingOn = 6,
                Message = "Don\'t mind that, nothing\'s left of what was before. This dimension has already reached their apocalypse.",
                Speaker = v21
            },
            {
                WaitBeforeMovingOn = 6,
                Message = "Whatever. Let\'s get out of here!",
                Speaker = v22
            }
        });

        return;
    end;

    if not v21 then
        return;
    end;

    p20:_PlayDialog({ v21 }, {
        {
            WaitBeforeMovingOn = 6,
            Message = "This is it, the last team set rendezvous for the top of the tower.",
            Speaker = v21
        },
        {
            WaitBeforeMovingOn = 6,
            Message = "I\'m what\'s left of my squad, my Warper is broken, no easy way back.",
            Speaker = v21
        },
        {
            WaitBeforeMovingOn = 6,
            Message = "I need to get back to base. I\'ve got all the data that\'s needed, the only way out is up.. ",
            Speaker = v21
        },
        {
            WaitBeforeMovingOn = 6,
            Message = "This is no different than last year. I\'ve got this.. I\'m so close to the end..",
            Speaker = v21
        }
    });
end;

function u1._AttemptToPlayStory(u23) -- Line: 178
    -- upvalues: DuelLibrary (copy)
    if u23._is_playing_story then
        return;
    end;

    local v24 = u23.DuelInterface.ClientDuel:Get("PlaySourceName");

    if v24 then
        v24 = DuelLibrary.PlaySources[v24].DuelLogic;
    end;

    local function play_story(p25, p26, ...) -- Line: 186
        -- upvalues: u23 (copy)
        if u23._already_played[p25] then
            return;
        end;

        u23._already_played[p25] = true;
        task.spawn(p26, ...);
    end;

    if v24 == "Zombie Tower" then
        play_story("zombietower_intro", u23._ZombieTowerIntro, u23);

        return;
    end;

    if v24 == "Gargoyle Tower" then
        play_story("gargoyletower_intro", u23._GargoyleTowerIntro, u23);
    end;
end;

function u1._Init(u27) -- Line: 202
    u27.DuelInterface.RoundResult.Frame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 203
        -- upvalues: u27 (copy)
        u27:Update();
    end);
    u27.DuelInterface.Scoreboard.VisibilityChanged:Connect(function() -- Line: 207
        -- upvalues: u27 (copy)
        u27:Update();
    end);
end;

return u1;