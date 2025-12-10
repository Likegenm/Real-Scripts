local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TeleportGUI"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "Teleport to Position"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

local posLabel = Instance.new("TextLabel")
posLabel.Size = UDim2.new(0.9, 0, 0, 60)
posLabel.Position = UDim2.new(0.05, 0, 0.3, 0)
posLabel.BackgroundTransparency = 1
posLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
posLabel.Text = "Target: Vector3.new(-7703.575, 194.176, 1833.229)"
posLabel.Font = Enum.Font.Gotham
posLabel.TextSize = 12
posLabel.TextWrapped = true
posLabel.Parent = frame

local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0.4, 0, 0, 30)
teleportButton.Position = UDim2.new(0.3, 0, 0.8, 0)
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Text = "Teleport"
teleportButton.Font = Enum.Font.GothamBold
teleportButton.TextSize = 14
teleportButton.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = teleportButton

local targetPosition = Vector3.new(-7703.5751953125, 194.17575073242188, 1833.22900390625)

teleportButton.MouseButton1Click:Connect(function()
    local character = player.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local tweenInfo = TweenInfo.new(
                3, --Time
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out
            )
            
            local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
            tween:Play()
            
            frame.Visible = false
            
            tween.Completed:Connect(function()
                print("Teleport completed!")
            end)
        end
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Q then
        frame.Visible = not frame.Visible
    end
end)

print("Press Q to open teleport GUI")
