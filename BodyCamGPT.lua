--[[
██╗     ██╗██╗██╗  ██╗███████╗ ██████╗ ███████╗███╗   ██╗███╗   ███╗
██║     ██║██║██║ ██╔╝██╔════╝██╔════╝ ██╔════╝████╗  ██║████╗ ████║
██║     ██║██║█████╔╝ █████╗  ██║  ███╗█████╗  ██╔██╗ ██║██╔████╔██║
██║     ██║██║██╔═██╗ ██╔══╝  ██║   ██║██╔══╝  ██║╚██╗██║██║╚██╔╝██║
███████╗██║██║██║  ██╗███████╗╚██████╔╝███████╗██║ ╚████║██║ ╚═╝ ██║
╚══════╝╚═╝╚═╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝     ╚═╝

сделано с помощью Deepseek ну и Likegenm
]]

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera

local botActive = true
local isWalking = false
local isMouse2Pressed = false
local mouse = Player:GetMouse()

Humanoid.WalkSpeed = 16

local currentZoom = 70
local minZoom = 30
local maxZoom = 120

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isMouse2Pressed = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isMouse2Pressed = false
    end
end)

function pressVandZ()
    task.wait(1)
    
    print("Pressing V and Z...")
    
    if Humanoid.Health > 0 then
        task.spawn(function()
            local VTime = math.random(3, 8) / 10
            local ZTime = math.random(5, 12) / 10
            
            for i = 1, math.random(1, 3) do
                UserInputService:SendKeyEvent(true, Enum.KeyCode.V, false, nil)
                task.wait(VTime)
                UserInputService:SendKeyEvent(false, Enum.KeyCode.V, false, nil)
                task.wait(0.1)
            end
            
            task.wait(0.3)
            
            for i = 1, math.random(1, 2) do
                UserInputService:SendKeyEvent(true, Enum.KeyCode.Z, false, nil)
                task.wait(ZTime)
                UserInputService:SendKeyEvent(false, Enum.KeyCode.Z, false, nil)
                task.wait(0.1)
            end
            
            print("V and Z pressed")
        end)
    end
end

function autoVandZ()
    while botActive do
        local waitTime = math.random(20, 45)
        task.wait(waitTime)
        
        if Humanoid.Health > 0 and math.random(1, 100) <= 40 then
            pressVandZ()
        end
    end
end

function checkObstacle(direction)
    if not RootPart then return true end
    
    local origin = RootPart.Position + Vector3.new(0, 2, 0)
    local rayDirection = direction.Unit * 6
    
    local ray = Ray.new(origin, rayDirection)
    local ignoreList = {Character}
    
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
    
    return hit ~= nil
end

function simulateMouseLook()
    while botActive do
        if isMouse2Pressed then
            local deltaX = math.random(-40, 40)
            local deltaY = math.random(-25, 25)
            
            local startTime = tick()
            local duration = 0.3
            
            while tick() - startTime < duration and isMouse2Pressed and botActive do
                if Camera then
                    local newCF = Camera.CFrame * CFrame.Angles(
                        math.rad(deltaY/200),
                        math.rad(deltaX/200),
                        0
                    )
                    
                    Camera.CFrame = Camera.CFrame:Lerp(newCF, 0.1)
                end
                RunService.RenderStepped:Wait()
            end
        end
        task.wait(0.1)
    end
end

function randomJump()
    while botActive do
        local waitTime = math.random(5, 15)
        task.wait(waitTime)
        
        if Humanoid.Health > 0 and Humanoid.FloorMaterial ~= Enum.Material.Air then
            local shouldJump = math.random(1, 100) <= 25
            
            if shouldJump then
                Humanoid.Jump = true
                
                task.wait(0.5)
                
                if math.random(1, 100) <= 50 then
                    local smallMove = Vector3.new(
                        math.random(-100, 100) / 100,
                        0,
                        math.random(-100, 100) / 100
                    ).Unit
                    
                    local startTime = tick()
                    while tick() - startTime < 0.3 do
                        Humanoid:Move(smallMove)
                        RunService.RenderStepped:Wait()
                    end
                end
            end
        end
    end
end

function walkBot()
    while botActive and Humanoid.Health > 0 do
        if not isWalking then
            isWalking = true
            
            local walkTime = math.random(8, 25) / 10
            
            local startTime = tick()
            local moveDir = Vector3.new(
                math.random(-100, 100) / 100,
                0,
                math.random(-100, 100) / 100
            ).Unit
            
            while tick() - startTime < walkTime and botActive do
                if checkObstacle(moveDir) then
                    moveDir = Vector3.new(
                        math.random(-100, 100) / 100,
                        0,
                        math.random(-100, 100) / 100
                    ).Unit
                end
                
                Humanoid:Move(moveDir)
                
                if math.random(1, 100) <= 10 then
                    local smallTurn = Vector3.new(
                        moveDir.X + math.random(-30, 30)/100,
                        0,
                        moveDir.Z + math.random(-30, 30)/100
                    ).Unit
                    Humanoid:Move(smallTurn)
                end
                
                RunService.RenderStepped:Wait()
            end
            
            Humanoid:Move(Vector3.new(0, 0, 0))
            isWalking = false
            
            task.wait(math.random(3, 15) / 10)
        end
        RunService.RenderStepped:Wait()
    end
end

function cameraZoom()
    while botActive do
        task.wait(math.random(3, 8))
        
        if math.random(1, 100) <= 20 then
            currentZoom = math.clamp(currentZoom + math.random(-15, 15), minZoom, maxZoom)
            
            local startFOV = Camera.FieldOfView
            local endFOV = currentZoom
            local duration = 0.4
            local startTime = tick()
            
            while tick() - startTime < duration and botActive do
                local alpha = (tick() - startTime) / duration
                Camera.FieldOfView = startFOV + (endFOV - startFOV) * alpha
                RunService.RenderStepped:Wait()
            end
        end
    end
end

function lookAround()
    while botActive do
        task.wait(math.random(2, 6))
        
        if not isMouse2Pressed and math.random(1, 100) <= 30 then
            local lookAngle = math.rad(math.random(-60, 60))
            local lookDir = Vector3.new(math.sin(lookAngle), 0, math.cos(lookAngle))
            
            if RootPart then
                local targetPos = RootPart.Position + lookDir * 15 + Vector3.new(0, 2, 0)
                
                local startTime = tick()
                local startCF = Camera.CFrame
                local endCF = CFrame.new(Camera.CFrame.Position, targetPos)
                local duration = 0.5
                
                while tick() - startTime < duration and botActive do
                    local alpha = (tick() - startTime) / duration
                    Camera.CFrame = startCF:Lerp(endCF, alpha)
                    RunService.RenderStepped:Wait()
                end
            end
        end
    end
end

spawn(pressVandZ)
spawn(walkBot)
spawn(randomJump)
spawn(simulateMouseLook)
spawn(cameraZoom)
spawn(lookAround)
spawn(autoVandZ)

Camera.FieldOfView = currentZoom

local function createControlGUI()
    if Player:FindFirstChild("PlayerGui") then
        local gui = Instance.new("ScreenGui")
        gui.Name = "AdvancedBot"
        gui.Parent = Player.PlayerGui
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 200, 0, 150)
        frame.Position = UDim2.new(0, 10, 0, 10)
        frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        frame.Parent = gui
        
        local title = Instance.new("TextLabel")
        title.Text = "NPC BOT"
        title.Size = UDim2.new(1, 0, 0, 30)
        title.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        title.TextColor3 = Color3.new(1, 1, 1)
        title.Font = Enum.Font.GothamBold
        title.Parent = frame
        
        local startBtn = Instance.new("TextButton")
        startBtn.Text = "START"
        startBtn.Size = UDim2.new(0.8, 0, 0, 25)
        startBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
        startBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
        startBtn.TextColor3 = Color3.new(1, 1, 1)
        startBtn.Parent = frame
        startBtn.MouseButton1Click:Connect(function()
            botActive = true
            print("Bot started")
        end)
        
        local stopBtn = Instance.new("TextButton")
        stopBtn.Text = "STOP"
        stopBtn.Size = UDim2.new(0.8, 0, 0, 25)
        stopBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
        stopBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
        stopBtn.TextColor3 = Color3.new(1, 1, 1)
        stopBtn.Parent = frame
        stopBtn.MouseButton1Click:Connect(function()
            botActive = false
            Humanoid:Move(Vector3.new(0, 0, 0))
            print("Bot stopped")
        end)
        
        local vButton = Instance.new("TextButton")
        vButton.Text = "PRESS V"
        vButton.Size = UDim2.new(0.8, 0, 0, 25)
        vButton.Position = UDim2.new(0.1, 0, 0.65, 0)
        vButton.BackgroundColor3 = Color3.fromRGB(80, 100, 180)
        vButton.TextColor3 = Color3.new(1, 1, 1)
        vButton.Parent = frame
        vButton.MouseButton1Click:Connect(function()
            pressVandZ()
        end)
        
        local info = Instance.new("TextLabel")
        info.Text = "Features:\n- Auto V/Z on spawn\n- RMB camera control\n- Random jumps\n- Auto V/Z every 20-45s"
        info.Size = UDim2.new(1, 0, 0, 50)
        info.Position = UDim2.new(0, 0, 0.85, 0)
        info.BackgroundTransparency = 1
        info.TextColor3 = Color3.new(1, 1, 1)
        info.TextSize = 11
        info.Font = Enum.Font.Gotham
        info.TextXAlignment = Enum.TextXAlignment.Left
        info.Parent = frame
    end
end

task.wait(2)
createControlGUI()
print("Advanced NPC bot activated")
print("Auto pressing V and Z on spawn...")

Humanoid.Died:Connect(function()
    botActive = false
    print("Bot stopped: character died")
end)

Player.CharacterAdded:Connect(function(newChar)
    task.wait(1)
    
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
    Camera = workspace.CurrentCamera
    Humanoid.WalkSpeed = 16
    botActive = true
    currentZoom = 70
    Camera.FieldOfView = currentZoom
    
    spawn(pressVandZ)
    spawn(walkBot)
    spawn(randomJump)
    spawn(simulateMouseLook)
    spawn(cameraZoom)
    spawn(lookAround)
    spawn(autoVandZ)
    
    print("Bot restarted, pressing V and Z...")
end)
