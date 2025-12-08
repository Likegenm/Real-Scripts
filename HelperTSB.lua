--This is Highlights for future creators

--THIS IS NOT SCRIPT TSB!!!!!!!

--Script platforma Tsb:
--        https://github.com/Likegenm/Scripts/blob/main/PlatformTSB.lua



--LocalPlayer

--Speedhack(walkspeed):
while true do
  game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
  wait(0.1)
end

--InfJump
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local jumpForce = 50

while task.wait() do
    if humanoid and humanoidRootPart and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        local currentVelocity = humanoidRootPart.Velocity
        humanoidRootPart.Velocity = Vector3.new(
            currentVelocity.X,
            jumpForce,
            currentVelocity.Z
        )
    end
end





--Fly
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local flyEnabled = false
local flySpeed = 80 --Speed

local function toggleFly()
    flyEnabled = not flyEnabled
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.H then --KeyBind Fly
        toggleFly()
    end
end)

RunService.Heartbeat:Connect(function()
    if not flyEnabled then return end
    
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local camera = workspace.CurrentCamera
    local lookVector = camera.CFrame.LookVector
    local rightVector = camera.CFrame.RightVector
    
    local velocity = Vector3.new(0, 0, 0)
    
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        velocity = velocity + lookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        velocity = velocity - lookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        velocity = velocity - rightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        velocity = velocity + rightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        velocity = velocity + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        velocity = velocity + Vector3.new(0, -1, 0)
    end
    
    if velocity.Magnitude > 0 then
        velocity = velocity.Unit * flySpeed
    end
    
    humanoidRootPart.Velocity = velocity
end)

--AntiFreeze
local workspace = game:GetService("Workspace")
local player = game.Players.LocalPlayer

while task.wait(0.01) do
    local character = player.Character
    if character then
        local freeze = character:FindFirstChild("Freeze")
        if freeze then
            freeze:Destroy()
        end
    end
end

--AntiSlow
local workspace = game:GetService("Workspace")
local player = game.Players.LocalPlayer

while task.wait(0.01) do
    local character = player.Character
    if character then
        local slowed = character:FindFirstChild("Slowed")
        if slowed then
            slowed:Destroy()
        end
    end
end

--AlwaysBlock
local workspace = game:GetService("Workspace")
local player = game.Players.LocalPlayer

while task.wait(0.01) do
    local character = player.Character
    if character then
        local NB = character:FindFirstChild("NoBlock")
        if NB then
            NB:Destroy()
        end
    end
end

--
