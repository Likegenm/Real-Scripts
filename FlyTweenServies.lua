local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local flyEnabled = false
local flyTween = nil

local function toggleFly()
    flyEnabled = not flyEnabled
    
    if flyEnabled then
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        RunService.Heartbeat:Connect(function()
            if not flyEnabled then return end
            
            local camera = workspace.CurrentCamera
            local lookVector = camera.CFrame.LookVector
            local rightVector = camera.CFrame.RightVector
            
            local targetVelocity = Vector3.new(0, 0, 0)
            local flySpeed = 50
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                targetVelocity = targetVelocity + lookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                targetVelocity = targetVelocity - lookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                targetVelocity = targetVelocity - rightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                targetVelocity = targetVelocity + rightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                targetVelocity = targetVelocity + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                targetVelocity = targetVelocity + Vector3.new(0, -1, 0)
            end
            
            if targetVelocity.Magnitude > 0 then
                targetVelocity = targetVelocity.Unit * flySpeed
            end
            
            if flyTween then
                flyTween:Cancel()
            end
            
            local tweenInfo = TweenInfo.new(
                0.1,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out
            )
            
            flyTween = TweenService:Create(humanoidRootPart, tweenInfo, {Velocity = targetVelocity})
            flyTween:Play()
        end)
        
        print("Fly enabled")
    else
        if flyTween then
            flyTween:Cancel()
            flyTween = nil
        end
        
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end
        
        print("Fly disabled")
    end
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        toggleFly()
    end
end)
