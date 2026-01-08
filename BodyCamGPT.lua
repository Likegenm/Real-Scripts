--[[
██╗     ██╗██╗██╗  ██╗███████╗ ██████╗ ███████╗███╗   ██╗███╗   ███╗
██║     ██║██║██║ ██╔╝██╔════╝██╔════╝ ██╔════╝████╗  ██║████╗ ████║
██║     ██║██║█████╔╝ █████╗  ██║  ███╗█████╗  ██╔██╗ ██║██╔████╔██║
██║     ██║██║██╔═██╗ ██╔══╝  ██║   ██║██╔══╝  ██║╚██╗██║██║╚██╔╝██║
███████╗██║██║██║  ██╗███████╗╚██████╔╝███████╗██║ ╚████║██║ ╚═╝ ██║
╚══════╝╚═╝╚═╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝     ╚═╝

сделано с проверкой чата гпт еще
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
local zoomSpeed = 2

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
        wait(0.1)
    end
end

function randomJump()
    while botActive do
        local waitTime = math.random(5, 15)
        wait(waitTime)
        
        if Humanoid.Health > 0 and Humanoid.FloorMaterial ~= Enum.Material.Air then
            local shouldJump = math.random(1, 100) <= 25
            
            if shouldJump then
                Humanoid.Jump = true
                print("Jumped!")
                
                wait(0.5)
                
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
            
            wait(math.random(3, 15) / 10)
        end
        RunService.RenderStepped:Wait()
    end
end

function cameraZoom()
    while botActive do
        wait(math.random(3, 8))
        
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
        wait(math.random(2, 6))
        
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

spawn(walkBot)
spawn(randomJump)
spawn(simulateMouseLook)
spawn(cameraZoom)
spawn(lookAround)

Camera.FieldOfView = currentZoom

local function createControlGUI()
    if Player:FindFirstChild("PlayerGui") then
        local gui = Instance.new("ScreenGui")
        gui.Name = "AdvancedBot"
        gui.Parent = Player.PlayerGui
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 200, 0, 130)
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
        startBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
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
        stopBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
        stopBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
        stopBtn.TextColor3 = Color3.new(1, 1, 1)
        stopBtn.Parent = frame
        stopBtn.MouseButton1Click:Connect(function()
            botActive = false
            Humanoid:Move(Vector3.new(0, 0, 0))
            print("Bot stopped")
        end)
        
        local info = Instance.new("TextLabel")
        info.Text = "RMB: Camera look\nAuto jumps\nRandom zoom"
        info.Size = UDim2.new(1, 0, 0, 40)
        info.Position = UDim2.new(0, 0, 0.85, 0)
        info.BackgroundTransparency = 1
        info.TextColor3 = Color3.new(1, 1, 1)
        info.TextSize = 12
        info.Font = Enum.Font.Gotham
        info.TextXAlignment = Enum.TextXAlignment.Left
        info.Parent = frame
    end
end

wait(1)
createControlGUI()
print("Advanced NPC bot activated")
print("Features:")
print("- Auto walking with obstacle check")
print("- Random jumping")
print("- Right mouse button camera control")
print("- Auto camera zoom")
print("- Looking around")

Humanoid.Died:Connect(function()
    botActive = false
    print("Bot stopped: character died")
end)

Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
    Camera = workspace.CurrentCamera
    Humanoid.WalkSpeed = 16
    botActive = true
    currentZoom = 70
    Camera.FieldOfView = currentZoom
    
    spawn(walkBot)
    spawn(randomJump)
    spawn(simulateMouseLook)
    spawn(cameraZoom)
    spawn(lookAround)
    
    print("Bot restarted for new character")
end)
