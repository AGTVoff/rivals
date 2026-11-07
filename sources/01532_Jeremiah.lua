-- Instance: Players .NebulaHub_049.PlayerScripts.Modules.ViewModels.Maul.Jeremiah
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Maul = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ViewModels"):WaitForChild("Maul"));
local u1 = setmetatable({}, Maul);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: Maul (copy), u1 (copy)
    local v2 = Maul.new(...);
    local v3 = setmetatable(v2, u1);
    v3._eyelids = {};
    v3:_Init();

    return v3;
end;

function u1._SetupEyelids(u4) -- Line: 33
    -- upvalues: RunService (copy)
    local Eyelids = u4.ItemModel:WaitForChild("Body"):WaitForChild("Eyelids");
    local u5 = {};

    local function get_blink_cooldown() -- Line: 37
        return 0.5 + 3.5 * math.random();
    end;

    local function eyelid_added(p6) -- Line: 41
        -- upvalues: u5 (copy), u4 (copy)
        local v7 = {
            Object = p6,
            NextBlink = tick() + (0.5 + 3.5 * math.random())
        };
        table.insert(u5, v7);
        u4:_LocalTransparencyModifier(p6, "Blink", 1);
    end;

    Eyelids.ChildAdded:Connect(eyelid_added);

    for _, child in pairs(Eyelids:GetChildren()) do
        eyelid_added(child);
    end;

    while not u4._destroyed do
        for _, v in pairs(u5) do
            if tick() >= v.NextBlink then
                v.NextBlink = tick() + (0.5 + 3.5 * math.random());
                u4:_LocalTransparencyModifier(v.Object, "Blink", 0);
                task.delay(0.1, u4._LocalTransparencyModifier, u4, v.Object, "Blink", 1);
            end;
        end;

        RunService.RenderStepped:Wait();
    end;
end;

function u1._Init(p8) -- Line: 68
    task.spawn(p8._SetupEyelids, p8);
end;

return u1;