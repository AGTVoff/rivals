-- Instance: ReplicatedStorage .Modules.ShopEntry
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CurrencyLibrary = require(ReplicatedStorage.Modules.CurrencyLibrary);
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, p5, p6, p7, p8, p9, p10, p11) -- Line: 8
    -- upvalues: u1 (copy)
    local v12 = typeof(p2) == "string";
    local v13 = "Argument 1 invalid, expected a string, got " .. tostring(p2);
    assert(v12, v13);
    local v14 = typeof(p3) == "string";
    local v15 = "Argument 2 invalid, expected a string, got " .. tostring(p3);
    assert(v14, v15);
    local v16 = typeof(p4) == "table";
    local v17 = "Argument 3 invalid, expected a table, got " .. tostring(p4);
    assert(v16, v17);
    local v18 = not p5 or typeof(p5) == "table";
    local v19 = "Argument 4 invalid, expected a table or nil, got " .. tostring(p5);
    assert(v18, v19);
    local v20 = not p6;

    if not v20 then
        if typeof(p6) == "table" then
            v20 = next(p6);
        else
            v20 = false;
        end;
    end;

    local v21 = "Argument 5 invalid, expected a table or nil, got " .. tostring(p6);
    assert(v20, v21);
    local v22 = not p7 or typeof(p7) == "boolean";
    local v23 = "Argument 6 invalid, expected a boolean or nil, got " .. tostring(p7);
    assert(v22, v23);
    local v24 = not p8 or typeof(p8) == "number";
    local v25 = "Argument 7 invalid, expected a number or nil, got " .. tostring(p8);
    assert(v24, v25);
    local v26 = not p9 or typeof(p9) == "number";
    local v27 = "Argument 8 invalid, expected a number or nil, got " .. tostring(p9);
    assert(v26, v27);
    local v28 = not p10 or typeof(p10) == "number";
    local v29 = "Argument 9 invalid, expected a number or nil, got " .. tostring(p10);
    assert(v28, v29);
    local v30 = not p11 or typeof(p11) == "table";
    local v31 = "Argument 10 invalid, expected a table or nil, got " .. tostring(p11);
    assert(v30, v31);
    local v32 = setmetatable({}, u1);
    v32.EntryType = p2;
    v32.EntryName = p3;
    v32.Rewards = p4;
    v32.Prices = p5 or {};
    v32.MainCurrency = nil;
    v32.ProductIDs = p6 or nil;
    v32.ProductQuantityToID = nil;
    v32.IsLimited = p7 or nil;
    v32.PurchaseAppearTime = p8 or -1;
    v32.PurchaseStartTime = p9 or -1;
    v32.PurchaseDuration = p10 or (1 / 0);
    v32._temp_properties = p11;
    v32:_Init();

    return v32;
end;

function u1._Setup(p33) -- Line: 51
    -- upvalues: CurrencyLibrary (copy)
    for i in pairs(p33.Prices) do
        local v34 = CurrencyLibrary.Info[i] ~= nil;
        local v35 = "Argument 4 invalid, expected a valid currency name, got " .. tostring(i);
        assert(v34, v35);

        if not p33.MainCurrency or CurrencyLibrary.Info[i].OrderIndex < CurrencyLibrary.Info[p33.MainCurrency].OrderIndex then
            p33.MainCurrency = i;
        end;
    end;

    assert(p33.MainCurrency or p33.ProductIDs, "Currency missing");

    if p33.ProductIDs then
        p33.ProductQuantityToID = {};

        for i, v in pairs(p33.ProductIDs) do
            p33.ProductQuantityToID[v] = i;
        end;
    end;

    for i, v in pairs(p33._temp_properties or {}) do
        p33[i] = v;
    end;

    p33._temp_properties = nil;
end;

function u1._Init(p36) -- Line: 77
    p36:_Setup();
end;

return u1;