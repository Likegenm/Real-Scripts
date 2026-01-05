-- этот скрипт писал мой друг так что дизайн изменен

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

_G.Position = nil
local lastTeleportTime = 0
local teleportCooldown = 0.5
local isGUIEnabled = true
local isAtNegative490 = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SkillBringGUI"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0.5, -20, 0, 20)
toggleButton.Text = "CP"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 14
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
toggleButton.BorderSizePixel = 0
toggleButton.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(150, 150, 150)
toggleStroke.Thickness = 2
toggleStroke.Parent = toggleButton

local mainContainer = Instance.new("Frame")
mainContainer.Name = "MainContainer"
mainContainer.Size = UDim2.new(0, 80, 0, 80)
mainContainer.Position = UDim2.new(0.5, -40, 0.5, -40)
mainContainer.BackgroundTransparency = 1
mainContainer.Parent = screenGui

local teleportButton = Instance.new("TextButton")
teleportButton.Name = "TeleportButton"
teleportButton.Size = UDim2.new(1, 0, 1, 0)
teleportButton.Text = "T"
teleportButton.Font = Enum.Font.GothamBlack
teleportButton.TextSize = 24
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
teleportButton.BackgroundTransparency = 0.2
teleportButton.BorderSizePixel = 0
teleportButton.Parent = mainContainer

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(1, 0)
buttonCorner.Parent = teleportButton

local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(100, 150, 255)
buttonStroke.Thickness = 3
buttonStroke.Parent = teleportButton

local statusDot = Instance.new("Frame")
statusDot.Name = "StatusDot"
statusDot.Size = UDim2.new(0, 12, 0, 12)
statusDot.Position = UDim2.new(1, -16, 0, 4)
statusDot.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
statusDot.BorderSizePixel = 0
statusDot.Parent = teleportButton

local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = statusDot

local isDragging = false
local dragOffset = Vector2.new(0, 0)

local function updateGUIState()
    if isGUIEnabled then
        toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        toggleStroke.Color = Color3.fromRGB(80, 220, 80)
        mainContainer.Visible = true
    else
        toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        toggleStroke.Color = Color3.fromRGB(150, 150, 150)
        mainContainer.Visible = false
    end
end

toggleButton.MouseButton1Click:Connect(function()
    isGUIEnabled = not isGUIEnabled
    updateGUIState()
end)

local function teleportToNegative490()
    local character = LocalPlayer.Character
    if not character then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return false end
    
    local currentPos = humanoidRootPart.Position

    _G.Position = currentPos

    humanoidRootPart.CFrame = CFrame.new(currentPos.X, -490, currentPos.Z)

    isAtNegative490 = true
    statusDot.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    teleportButton.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    teleportButton.Text = "R"
    
    return true
end

local function returnToSavedPosition()
    local character = LocalPlayer.Character
    if not character then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return false end
    
    if _G.Position then
        humanoidRootPart.CFrame = CFrame.new(_G.Position)
        
        _G.Position = nil

        isAtNegative490 = false
        statusDot.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        teleportButton.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
        teleportButton.Text = "T"
        
        return true
    end
    
    return false
end

teleportButton.MouseButton1Click:Connect(function()
    if tick() - lastTeleportTime < teleportCooldown then return end
    
    if not isAtNegative490 then
        if teleportToNegative490() then
            lastTeleportTime = tick()
        end
    else
        if returnToSavedPosition() then
            lastTeleportTime = tick()
        end
    end
end)

mainContainer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and isGUIEnabled then
        isDragging = true
        local containerPos = mainContainer.AbsolutePosition
        local mousePos = input.Position
        dragOffset = Vector2.new(containerPos.X - mousePos.X, containerPos.Y - mousePos.Y)
    end
end)

mainContainer.InputEnded:Connect(function(input)
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
    if isDragging and isGUIEnabled then
        local mousePos = UserInputService:GetMouseLocation()
        mainContainer.Position = UDim2.new(0, mousePos.X + dragOffset.X, 0, mousePos.Y + dragOffset.Y)
    end
end)

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        local buttonPos = toggleButton.AbsolutePosition
        local mousePos = input.Position
        dragOffset = Vector2.new(buttonPos.X - mousePos.X, buttonPos.Y - mousePos.Y)
    end
end)

toggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
        local mousePos = UserInputService:GetMouseLocation()
        toggleButton.Position = UDim2.new(0, mousePos.X + dragOffset.X, 0, mousePos.Y + dragOffset.Y)
    end
end)

RunService.Heartbeat:Connect(function()
    if _G.Position and isAtNegative490 then
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end

        if humanoidRootPart.Position.Y <= -500 then
            returnToSavedPosition()
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    _G.Position = nil
    isAtNegative490 = false
    statusDot.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    teleportButton.BackgroundColor3 = Color3.fromRGB(70, 120, 200)
    teleportButton.Text = "T"
end)

updateGUIState()
