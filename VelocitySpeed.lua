local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

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
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local mv = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            mv = mv + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            mv = mv - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            mv = mv - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            mv = mv + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector
        end
        if mv.Magnitude > 0 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(
                mv.Unit.X * 30, -- x speed
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity.Y,
                mv.Unit.Z * 30 -- z speed
            )
        end
    end
end)
