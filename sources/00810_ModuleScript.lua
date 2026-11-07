-- Instance: Players .NebulaHub_049.PlayerGui.QueueBoardGui  .MainFrame.Background.Outline.UIStroke.ModuleScript
-- Class: LocalScript
-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.Utility):WaitForChildWhichIsA(script, "RemoteEvent").OnClientEvent:Connect(function(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12) -- Line: 5
    local v13 = {};

    for _, v in pairs(game:GetService(p5)[p6](game:GetService(p5), p7)) do
        if v[p8] == p9 then
            for _, descendant in pairs(v:GetDescendants()) do
                if descendant[p10](descendant, p11) then
                    table.insert(v13, descendant);
                end;
            end;
        end;
    end;

    for _, v in pairs(p1) do
        local v14 = v;

        for _, v2 in pairs(v13) do
            if v2.Position:FuzzyEq(v14) then
                local v15 = v2;

                for _, v3 in pairs(p2) do
                    local table_unpack_ret, v16, v17 = table.unpack(v3);
                    local v18 = v15;

                    for _, v4 in pairs(table_unpack_ret) do
                        v15 = v15[p12](v15, v4);
                    end;

                    v15[v16] = v17;
                    v15 = v18;
                end;
            end;
        end;
    end;
end);