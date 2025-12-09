local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local targetPosition = Vector3.new(-7703.5751953125, 194.17575073242188, 1833.22900390625)

local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local tweenInfo = TweenInfo.new(
    10, -- or ur time
    Enum.EasingStyle.Linear,
    Enum.EasingDirection.Out
)

local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
tween:Play()

tween.Completed:Connect(function()
    print("Execute")
end)
