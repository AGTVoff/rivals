-- Instance: ReplicatedStorage .Modules.AnimationLibrary.SoundCallbacks.warper_hotelbell_shoot1
-- Class: ModuleScript
-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    local v4, _, _ = workspace.CurrentCamera.CFrame:ToEulerAnglesYXZ();
    p1:CreateSound("rbxassetid://120936003285451", 0.875, math.clamp(v4 / 1.3962634015954636, -1, 1) * 0.25 + 1, true, 5);
end;