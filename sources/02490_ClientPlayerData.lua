-- Instance: StarterPlayer.StarterPlayerScripts.Modules.ClientReplicatedClasses.ClientPlayerData
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedClass = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ReplicatedClass"));
local u1 = setmetatable({}, ReplicatedClass);
u1.__index = u1;

function u1.new(p2) -- Line: 9
    -- upvalues: ReplicatedClass (copy), u1 (copy)
    local v3 = ReplicatedClass.new(p2, true);
    local v4 = setmetatable(v3, u1);
    v4:_Init();

    return v4;
end;

function u1._Init(p5) -- Line: 27
end;

return u1;