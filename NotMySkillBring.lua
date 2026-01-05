-- этот скрипт писал мой друг так что дизайн изменен

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local savedPosition = nil
local lastTeleportTime = 0
local teleportCooldown = 0.5

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SkillBringGUI"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 200, 0, 240)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(80, 80, 120)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "SKILL BRING"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 22
title.BackgroundTransparency = 1
title.Parent = mainFrame

local dragBar = Instance.new("Frame")
dragBar.Name = "DragBar"
dragBar.Size = UDim2.new(1, 0, 0, 25)
dragBar.Position = UDim2.new(0, 0, 0, 40)
dragBar.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
dragBar.BorderSizePixel = 0
dragBar.Parent = mainFrame

local dragText = Instance.new("TextLabel")
dragText.Text = "Drag"
dragText.Size = UDim2.new(1, 0, 1, 0)
dragText.TextColor3 = Color3.fromRGB(200, 200, 200)
dragText.Font = Enum.Font.Gotham
dragText.TextSize = 14
dragText.BackgroundTransparency = 1
dragText.Parent = dragBar

local button = Instance.new("TextButton")
button.Name = "TeleportButton"
button.Text = "TELEPORT"
button.Size = UDim2.new(0.8, 0, 0, 60)
button.Position = UDim2.new(0.1, 0, 0.3, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
button.BackgroundTransparency = 0.2
button.BorderSizePixel = 0
button.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = button

local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(100, 150, 255)
buttonStroke.Thickness = 2
buttonStroke.Parent = button

local statusFrame = Instance.new("Frame")
statusFrame.Name = "StatusFrame"
statusFrame.Size = UDim2.new(0.8, 0, 0, 80)
statusFrame.Position = UDim2.new(0.1, 0, 0.65, 0)
statusFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
statusFrame.BorderSizePixel = 0
statusFrame.Parent = mainFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusFrame

local statusTitle = Instance.new("TextLabel")
statusTitle.Text = "STATUS:"
statusTitle.Size = UDim2.new(1, 0, 0, 20)
statusTitle.Position = UDim2.new(0, 0, 0, 5)
statusTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
statusTitle.Font = Enum.Font.Gotham
statusTitle.TextSize = 14
statusTitle.BackgroundTransparency = 1
statusTitle.Parent = statusFrame

local statusText = Instance.new("TextLabel")
statusText.Name = "StatusText"
statusText.Text = "READY"
statusText.Size = UDim2.new(1, 0, 0, 30)
statusText.Position = UDim2.new(0, 0, 0, 25)
statusText.TextColor3 = Color3.fromRGB(100, 200, 100)
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 18
statusText.BackgroundTransparency = 1
statusText.Parent = statusFrame

local positionText = Instance.new("TextLabel")
positionText.Name = "PositionText"
positionText.Text = "No saved position"
positionText.Size = UDim2.new(1, 0, 0, 20)
positionText.Position = UDim2.new(0, 0, 0, 55)
positionText.TextColor3 = Color3.fromRGB(150, 150, 150)
positionText.Font = Enum.Font.Gotham
positionText.TextSize = 12
positionText.BackgroundTransparency = 1
positionText.Parent = statusFrame

local function teleportToY490()
    local character = LocalPlayer.Character
    if not character then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return false end
    
    local currentPos = humanoidRootPart.Position
    
    if currentPos.Y > -500 then
        savedPosition = currentPos
        positionText.Text = string.format("Saved: %.0f, %.0f, %.0f", savedPosition.X, savedPosition.Y, savedPosition.Z)
        
        humanoidRootPart.CFrame = CFrame.new(currentPos.X, -490, currentPos.Z)
        statusText.Text = "AT -490Y"
        statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        button.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
        return true
        
    elseif currentPos.Y <= -500 and savedPosition then
        humanoidRootPart.CFrame = CFrame.new(savedPosition)
        savedPosition = nil
        positionText.Text = "No saved position"
        statusText.Text = "RETURNED"
        statusText.TextColor3 = Color3.fromRGB(100, 200, 100)
        button.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
        return true
    end
    
    return false
end

button.MouseButton1Click:Connect(function()
    if tick() - lastTeleportTime < teleportCooldown then return end
    
    if teleportToY490() then
        lastTeleportTime = tick()
    end
end)

local isDragging = false
local dragOffset = Vector2.new(0, 0)

dragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        local framePos = mainFrame.AbsolutePosition
        local mousePos = input.Position
        dragOffset = Vector2.new(framePos.X - mousePos.X, framePos.Y - mousePos.Y)
    end
end)

dragBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    if isDragging then
        local mousePos = UserInputService:GetMouseLocation()
        mainFrame.Position = UDim2.new(0, mousePos.X + dragOffset.X, 0, mousePos.Y + dragOffset.Y)
    end
end)

RunService.Heartbeat:Connect(function()
    if savedPosition then
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        if humanoidRootPart.Position.Y <= -500 then
            humanoidRootPart.CFrame = CFrame.new(savedPosition)
            savedPosition = nil
            positionText.Text = "No saved position"
            statusText.Text = "AUTO RETURN"
            statusText.TextColor3 = Color3.fromRGB(255, 200, 100)
            button.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    savedPosition = nil
    statusText.Text = "READY"
    statusText.TextColor3 = Color3.fromRGB(100, 200, 100)
    positionText.Text = "No saved position"
    button.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
end)
