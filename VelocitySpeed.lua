-- PC
local speed = 50 -- speed

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(newCharacter) 
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end)

RunService.Heartbeat:Connect(function()
    if Character and HumanoidRootPart then
        local cameraCFrame = Camera.CFrame
        local lookVector = cameraCFrame.LookVector
        local rightVector = cameraCFrame.RightVector
        
        local mv = Vector3.new(0, 0, 0)

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            mv = mv + Vector3.new(lookVector.X, 0, lookVector.Z).Unit
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            mv = mv - Vector3.new(lookVector.X, 0, lookVector.Z).Unit
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            mv = mv - Vector3.new(rightVector.X, 0, rightVector.Z).Unit
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            mv = mv + Vector3.new(rightVector.X, 0, rightVector.Z).Unit
        end
        
        if mv.Magnitude > 0 then
            HumanoidRootPart.Velocity = Vector3.new(
                mv.X * speed,
                HumanoidRootPart.Velocity.Y,
                mv.Z * speed
            )
        end
    end
end)

--[[ Mobile
local speed = 50 -- speed
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local virtualJoystick = nil
local joystickPosition = Vector2.new(0, 0)
local joystickActive = false
local joystickRadius = 50

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileControls"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local joystickBackground = Instance.new("Frame")
joystickBackground.Name = "JoystickBackground"
joystickBackground.Size = UDim2.new(0, 150, 0, 150)
joystickBackground.Position = UDim2.new(0, 50, 1, -200)
joystickBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
joystickBackground.BackgroundTransparency = 0.5
joystickBackground.BorderSizePixel = 0
joystickBackground.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = joystickBackground

virtualJoystick = Instance.new("Frame")
virtualJoystick.Name = "Joystick"
virtualJoystick.Size = UDim2.new(0, 60, 0, 60)
virtualJoystick.Position = UDim2.new(0.5, -30, 0.5, -30)
virtualJoystick.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
virtualJoystick.BackgroundTransparency = 0.3
virtualJoystick.BorderSizePixel = 0
virtualJoystick.Parent = joystickBackground

local joystickCorner = Instance.new("UICorner")
joystickCorner.CornerRadius = UDim.new(1, 0)
joystickCorner.Parent = virtualJoystick

local jumpButton = Instance.new("TextButton")
jumpButton.Name = "JumpButton"
jumpButton.Size = UDim2.new(0, 100, 0, 100)
jumpButton.Position = UDim2.new(1, -120, 1, -120)
jumpButton.Text = "Jump"
jumpButton.Font = Enum.Font.GothamBold
jumpButton.TextSize = 20
jumpButton.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
jumpButton.BackgroundTransparency = 0.3
jumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpButton.Parent = screenGui

local jumpCorner = Instance.new("UICorner")
jumpCorner.CornerRadius = UDim.new(0, 20)
jumpCorner.Parent = jumpButton

function updateJoystickPosition(input)
    local touchPosition = input.Position
    local backgroundPosition = joystickBackground.AbsolutePosition
    local backgroundSize = joystickBackground.AbsoluteSize
    
    local centerX = backgroundPosition.X + backgroundSize.X / 2
    local centerY = backgroundPosition.Y + backgroundSize.Y / 2
    
    local deltaX = touchPosition.X - centerX
    local deltaY = touchPosition.Y - centerY
    
    local distance = math.sqrt(deltaX^2 + deltaY^2)
    if distance > joystickRadius then
        deltaX = deltaX / distance * joystickRadius
        deltaY = deltaY / distance * joystickRadius
        distance = joystickRadius
    end
    
    virtualJoystick.Position = UDim2.new(
        0.5, deltaX - 30,
        0.5, deltaY - 30
    )
    
    if distance > 10 then
        joystickPosition = Vector2.new(
            deltaX / joystickRadius,
            deltaY / joystickRadius
        )
    else
        joystickPosition = Vector2.new(0, 0)
    end
end

joystickBackground.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        joystickActive = true
        updateJoystickPosition(input)
    end
end)

joystickBackground.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch and joystickActive then
        updateJoystickPosition(input)
    end
end)

joystickBackground.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        joystickActive = false
        virtualJoystick.Position = UDim2.new(0.5, -30, 0.5, -30)
        joystickPosition = Vector2.new(0, 0)
    end
end)

jumpButton.MouseButton1Down:Connect(function()
    if Character then
        local humanoid = Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Jump = true
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    HumanoidRootPart = newCharacter:WaitForChild("HumanoidRootPart")
end)

RunService.Heartbeat:Connect(function()
    if Character and HumanoidRootPart then
        local moveDirection = Vector3.new(0, 0, 0)
        
        if joystickPosition.Magnitude > 0.1 then
            local cameraCFrame = Camera.CFrame
            local lookVector = cameraCFrame.LookVector
            local rightVector = cameraCFrame.RightVector
            
            moveDirection = (lookVector * -joystickPosition.Y) + (rightVector * joystickPosition.X)
            moveDirection = Vector3.new(moveDirection.X, 0, moveDirection.Z).Unit
            
            if moveDirection.Magnitude > 0 then
                HumanoidRootPart.Velocity = Vector3.new(
                    moveDirection.X * speed,
                    HumanoidRootPart.Velocity.Y,
                    moveDirection.Z * speed
                )
                
                HumanoidRootPart.CFrame = CFrame.lookAt(
                    HumanoidRootPart.Position,
                    HumanoidRootPart.Position + moveDirection
                )
            end
        end
    end
end)
]]
