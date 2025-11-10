-- ЧАСТЬ 6/6: Главный цикл и обработчики
RunService.Heartbeat:Connect(function()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    
    -- Speed Hack
    if SpeedEnabled then ApplySpeedVelocity() end
    
    -- Spider Mode
    if SpiderEnabled then
        local rayOrigin = rootPart.Position
        local rayDirection = rootPart.CFrame.LookVector * SpiderDistance
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = {character}
        
        local rayResult = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)
        if rayResult then
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, SpiderSpeed, rootPart.Velocity.Z)
        end
    end
    
    -- NoFall
    if NoFallEnabled then CheckNoFall() end
    
    -- Attach to Player
    if AttachEnabled then
        local nearest = GetNearestPlayer(AttachDistance)
        if nearest and nearest.Character then
            local targetRoot = nearest.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                rootPart.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end
    
    -- Noclip
    if NoclipEnabled then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
    
    -- FOV Changer
    if FovEnabled then
        local camera = Workspace.CurrentCamera
        if camera then camera.FieldOfView = FovValue end
    end
    
    -- Car Fly
    if FlyEnabled and humanoid.Sit then
        humanoid.PlatformStand = true
        local flyVelocity = 100
        
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, flyVelocity, rootPart.Velocity.Z)
        elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, -flyVelocity, rootPart.Velocity.Z)
        end
    end
end)

-- Обработчики ввода
UserInputService.JumpRequest:Connect(function()
    if InfJumpEnabled and LocalPlayer.Character then
        InfiniteJumpVelocity()
    end
end)

local SpaceHeld = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Space then
        SpaceHeld = true
        while SpaceHeld and InfJumpEnabled do
            InfiniteJumpVelocity()
            wait(InfJumpCooldown)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Space then
        SpaceHeld = false
    end
end)

-- Авто-ESP для новых игроков
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if EspEnabled then
            wait(1)
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESP_Highlight"
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.Parent = character
        end
    end)
end)

-- Уведомление о загрузке
Rayfield:Notify({
   Title = "likegenm Script", Content = "Script loaded successfully!", Duration = 5,
   Image = 4483362458, Actions = { Ignore = { Name = "Okay!", Callback = function() end } },
})

print("likegenm Script fully loaded!")
