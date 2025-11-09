-- MM2 Script with Touch Fling via Velocity
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local function checkPlayerRestrictions()
    local localPlayer = game.Players.LocalPlayer
    if localPlayer.Name == "Likegenm" then
        return true
    end
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Name == "Likegenm" then
            return false
        end
    end
    return true
end

if not checkPlayerRestrictions() then
    WindUI:Notify({
        Title = "Access Denied",
        Content = "Script blocked: Likegenm is on the server!",
        Icon = "shield-alert"
    })
    return
end

local KeyInputValue = ""
local ValidKeys = {"LikegenmMM2"}
local KeyVerified = false

local MainWindow = WindUI:CreateWindow({
    Title = "MM2 Script | Key System",
    Author = "by Likegenm • Dev Mode",
    Folder = "MM2Script",
    NewElements = true,
    HideSearchBar = false,
})

local KeyTab = MainWindow:Tab({
    Title = "Key System",
    Icon = "key",
})

local KeySection = KeyTab:Section({
    Title = "🔐 AUTHORIZATION SYSTEM",
})

KeySection:Input({
    Title = "Enter access key",
    Placeholder = "Enter key here...",
    Type = "Input",
    Callback = function(value)
        KeyInputValue = value
    end
})

KeySection:Button({
    Title = "CONFIRM KEY",
    Icon = "key",
    Justify = "Center",
    Callback = function()
        local isValid = false
        for _, key in pairs(ValidKeys) do
            if key == KeyInputValue then
                isValid = true
                break
            end
        end
        
        if isValid then
            KeyVerified = true
            WindUI:Notify({
                Title = "AUTHORIZATION SUCCESS",
                Content = "Access granted!",
                Icon = "check"
            })
            createTabs()
        else
            WindUI:Notify({
                Title = "AUTHORIZATION ERROR",
                Content = "Invalid access key!",
                Icon = "x"
            })
        end
    end
})

KeySection:Button({
    Title = "GET KEY",
    Icon = "discord",
    Justify = "Center",
    Color = Color3.fromRGB(88, 101, 242),
    Callback = function()
        setclipboard("https://discord.gg/ppCF95m5h")
        WindUI:Notify({
            Title = "DISCORD COPIED",
            Content = "Discord link copied to clipboard!",
            Icon = "copy"
        })
    end
})

local SpeedHackEnabled = false
local SpeedValue = 16
local InfiniteJumpEnabled = false
local NoClipEnabled = false
local FlyEnabled = false
local FlySpeed = 100
local FullBrightEnabled = false
local FPSBoostEnabled = false
local FOVChangerEnabled = false
local FOVValue = 70
local AutoFarmEnabled = false
local AutoGunEnabled = false
local AttachEnabled = false
local KillAuraEnabled = false
local FlingEnabled = false
local GodModeEnabled = false
local ShootMurderEnabled = false
local KillAllEnabled = false

local EnableESP = false
local ShowNames = true
local ShowDistance = true
local UseTracers = false
local UseBoxESP = false
local UseHighlights = false
local MurdererColor = Color3.fromRGB(255, 0, 0)
local SheriffColor = Color3.fromRGB(0, 0, 255)
local InnocentColor = Color3.fromRGB(0, 255, 0)
local GunColor = Color3.fromRGB(255, 255, 0)
local CandyColor = Color3.fromRGB(255, 105, 180)

local SelectedFlingTarget = nil
local FlingStartPosition = nil
local FlingPlayersList = {}
local LastPlayerUpdate = 0

local GunESPEnabled = false
local CandyESPEnabled = false
local GunESPConnection, CandyESPConnection = nil, nil
local GunESPObjects, CandyESPObjects = {}, {}

local NoClipConnection, InfiniteJumpConnection, FlyConnection, FullBrightConnection
local FPSBoostConnection, FOVConnection, AutoFarmConnection, AutoGunConnection
local AttachConnection, KillAuraConnection, FlingConnection, GodModeConnection, ShootMurderConnection, KillAllConnection
local ESPConnections = {}
local ESPUpdateConnection

function firetouchinterest(part1, part2, toggle)
    if part1 and part2 then
        if toggle == 0 then
            local touch = Instance.new("TouchTransmitter")
            touch.Parent = part1
        else
            for _, obj in pairs(part1:GetChildren()) do
                if obj:IsA("TouchTransmitter") then
                    obj:Destroy()
                end
            end
        end
    end
end

function getPlayerRole(player)
    if not player or not player.Character then 
        return "Innocent" 
    end
    
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                local itemName = item.Name:lower()
                if itemName:find("knife") or itemName:find("murder") then
                    return "Murderer"
                elseif itemName:find("gun") or itemName:find("revolver") or itemName:find("sheriff") then
                    return "Sheriff"
                end
            end
        end
    end
    
    for _, item in pairs(player.Character:GetChildren()) do
        if item:IsA("Tool") then
            local itemName = item.Name:lower()
            if itemName:find("knife") or itemName:find("murder") then
                return "Murderer"
            elseif itemName:find("gun") or itemName:find("revolver") or itemName:find("sheriff") then
                return "Sheriff"
            end
        end
    end
    
    return "Innocent"
end

function getPlayerWeapon(player)
    local weapons = {}
    
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                table.insert(weapons, item.Name)
            end
        end
    end
    
    for _, item in pairs(player.Character:GetChildren()) do
        if item:IsA("Tool") then
            table.insert(weapons, item.Name)
        end
    end
    
    return weapons
end

function hasWeapon(player, weaponType)
    local weapons = getPlayerWeapon(player)
    weaponType = weaponType:lower()
    
    for _, weapon in pairs(weapons) do
        if weapon:lower():find(weaponType) then
            return true
        end
    end
    return false
end

function getRoleColor(role)
    if role == "Murderer" then return MurdererColor
    elseif role == "Sheriff" then return SheriffColor
    else return InnocentColor end
end

function updateFlingPlayers()
    FlingPlayersList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(FlingPlayersList, player.Name)
        end
    end
    LastPlayerUpdate = tick()
end

function applySpeedHack()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = SpeedValue
    end
end

function resetSpeedHack()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
    end
end

function enableInfiniteJump()
    InfiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:ChangeState("Jumping")
        end
    end)
end

function disableInfiniteJump()
    if InfiniteJumpConnection then
        InfiniteJumpConnection:Disconnect()
        InfiniteJumpConnection = nil
    end
end

function enableNoClip()
    NoClipConnection = game:GetService("RunService").Stepped:Connect(function()
        local player = game.Players.LocalPlayer
        if player and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end)
end

function disableNoClip()
    if NoClipConnection then
        NoClipConnection:Disconnect()
        NoClipConnection = nil
    end
end

function enableFly()
    FlyConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not FlyEnabled then return end
        
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            player.Character.Humanoid.PlatformStand = true
            
            local cam = workspace.CurrentCamera.CFrame
            local moveVector = Vector3.new()
            
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                moveVector = moveVector + cam.LookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                moveVector = moveVector - cam.LookVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                moveVector = moveVector - cam.RightVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                moveVector = moveVector + cam.RightVector
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                moveVector = moveVector + Vector3.new(0, 1, 0)
            end
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                moveVector = moveVector - Vector3.new(0, 1, 0)
            end
            
            player.Character.HumanoidRootPart.Velocity = moveVector * FlySpeed
        end
    end)
end

function disableFly()
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
    
    local player = game.Players.LocalPlayer
    if player and player.Character then
        player.Character.Humanoid.PlatformStand = false
    end
end

function enableFullBright()
    FullBrightConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not FullBrightEnabled then return end
        game.Lighting.GlobalShadows = false
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 14
        game.Lighting.FogEnd = 100000
    end)
end

function disableFullBright()
    if FullBrightConnection then
        FullBrightConnection:Disconnect()
        FullBrightConnection = nil
    end
    game.Lighting.GlobalShadows = true
    game.Lighting.Brightness = 1
    game.Lighting.FogEnd = 100000
end

function applyFOV()
    local camera = workspace.CurrentCamera
    if camera then
        camera.FieldOfView = FOVValue
    end
end

function resetFOV()
    local camera = workspace.CurrentCamera
    if camera then
        camera.FieldOfView = 70
    end
end

function enableFPSBoost()
    FPSBoostEnabled = true
    game.Lighting.GlobalShadows = false
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            obj.Enabled = false
        end
    end
    settings().Rendering.QualityLevel = 1
end

function disableFPSBoost()
    FPSBoostEnabled = false
    game.Lighting.GlobalShadows = true
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            obj.Enabled = true
        end
    end
    settings().Rendering.QualityLevel = 8
end

function startAutoFarm()
    stopAutoFarm()
    
    AutoFarmConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not AutoFarmEnabled then return end
        
        local player = game.Players.LocalPlayer
        if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        local candies = {}
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") or obj:IsA("MeshPart") then
                local objName = obj.Name:lower()
                if objName:find("candy") or objName:find("coin") or objName:find("chocolate") then
                    local parent = obj.Parent
                    local validCandy = true
                    while parent and parent ~= workspace do
                        if parent.Name:lower():find("lobby") then
                            validCandy = false
                            break
                        end
                        parent = parent.Parent
                    end
                    if validCandy then
                        table.insert(candies, obj)
                    end
                end
            end
        end
        
        if #candies > 0 then
            local nearestCandy = nil
            local nearestDistance = math.huge
            
            for _, candy in pairs(candies) do
                if candy and candy.Parent then
                    local distance = (candy.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if distance < nearestDistance then
                        nearestDistance = distance
                        nearestCandy = candy
                    end
                end
            end
            
            if nearestCandy and nearestCandy.Parent then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(nearestCandy.Position + Vector3.new(0, 3, 0))
                
                if nearestDistance < 10 then
                    firetouchinterest(player.Character.HumanoidRootPart, nearestCandy, 0)
                    firetouchinterest(player.Character.HumanoidRootPart, nearestCandy, 1)
                end
            end
        else
            if tick() % 10 < 0.1 then
                WindUI:Notify({
                    Title = "Auto Farm",
                    Content = "No candies found! Waiting for respawn...",
                    Icon = "clock"
                })
            end
        end
    end)
end

function stopAutoFarm()
    if AutoFarmConnection then
        AutoFarmConnection:Disconnect()
        AutoFarmConnection = nil
    end
end

function startAutoGun()
    stopAutoGun()
    
    AutoGunConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not AutoGunEnabled then return end
        
        local player = game.Players.LocalPlayer
        if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        local guns = {}
        
        local raggy = workspace:FindFirstChild("Raggy")
        if raggy and raggy:FindFirstChild("HumanoidRootPart") then
            table.insert(guns, {
                Object = raggy,
                Part = raggy.HumanoidRootPart,
                Type = "Raggy"
            })
        end
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") and (obj.Name:lower():find("gun") or obj.Name:lower():find("revolver")) then
                if obj:FindFirstChild("Handle") then
                    table.insert(guns, {
                        Object = obj,
                        Part = obj.Handle,
                        Type = "Gun"
                    })
                end
            end
        end
        
        if #guns > 0 then
            local nearestGun = nil
            local nearestDistance = math.huge
            
            for _, gunData in pairs(guns) do
                if gunData.Part and gunData.Part.Parent then
                    local distance = (gunData.Part.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    if distance < nearestDistance then
                        nearestDistance = distance
                        nearestGun = gunData
                    end
                end
            end
            
            if nearestGun then
                player.Character.HumanoidRootPart.CFrame = nearestGun.Part.CFrame + Vector3.new(0, 3, 0)
                
                if nearestDistance < 5 then
                    firetouchinterest(player.Character.HumanoidRootPart, nearestGun.Part, 0)
                    firetouchinterest(player.Character.HumanoidRootPart, nearestGun.Part, 1)
                end
            end
        else
            if tick() % 5 < 0.1 then
                WindUI:Notify({
                    Title = "Auto Gun",
                    Content = "No guns found in the map!",
                    Icon = "search"
                })
            end
        end
    end)
end

function stopAutoGun()
    if AutoGunConnection then
        AutoGunConnection:Disconnect()
        AutoGunConnection = nil
    end
end

function startGunESP()
    stopGunESP()
    
    local function createGunHighlight(gun)
        if not gun or not gun.Parent then return end
        
        local hrp = gun:FindFirstChild("HumanoidRootPart")
        if hrp then
            local highlight = Instance.new("Highlight")
            highlight.Name = "GunESP_" .. gun.Name
            highlight.Adornee = hrp
            highlight.FillColor = GunColor
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = GunColor
            highlight.OutlineTransparency = 0
            highlight.Parent = hrp
            
            GunESPObjects[gun] = highlight
        end
    end
    
    GunESPConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not GunESPEnabled then return end
        
        local raggy = workspace:FindFirstChild("Raggy")
        if raggy and not GunESPObjects[raggy] then
            createGunHighlight(raggy)
        end
        
        for gun, highlight in pairs(GunESPObjects) do
            if not gun or not gun.Parent then
                if highlight then
                    highlight:Destroy()
                end
                GunESPObjects[gun] = nil
            end
        end
    end)
end

function stopGunESP()
    if GunESPConnection then
        GunESPConnection:Disconnect()
        GunESPConnection = nil
    end
    
    for gun, highlight in pairs(GunESPObjects) do
        if highlight then
            highlight:Destroy()
        end
    end
    GunESPObjects = {}
end

function startCandyESP()
    stopCandyESP()
    
    local function createCandyHighlight(candy)
        if not candy or not candy.Parent then return end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "CandyESP_" .. candy.Name
        highlight.Adornee = candy
        highlight.FillColor = CandyColor
        highlight.FillTransparency = 0.3
        highlight.OutlineColor = CandyColor
        highlight.OutlineTransparency = 0
        highlight.Parent = candy
        
        CandyESPObjects[candy] = highlight
    end
    
    CandyESPConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not CandyESPEnabled then return end
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") or obj:IsA("MeshPart") then
                local objName = obj.Name:lower()
                if objName:find("candy") or objName:find("coin") or objName:find("chocolate") then
                    local parent = obj.Parent
                    local validCandy = true
                    while parent and parent ~= workspace do
                        if parent.Name:lower():find("lobby") then
                            validCandy = false
                            break
                        end
                        parent = parent.Parent
                    end
                    if validCandy and not CandyESPObjects[obj] then
                        createCandyHighlight(obj)
                    end
                end
            end
        end
        
        for candy, highlight in pairs(CandyESPObjects) do
            if not candy or not candy.Parent then
                if highlight then
                    highlight:Destroy()
                end
                CandyESPObjects[candy] = nil
            end
        end
    end)
end

function stopCandyESP()
    if CandyESPConnection then
        CandyESPConnection:Disconnect()
        CandyESPConnection = nil
    end
    
    for candy, highlight in pairs(CandyESPObjects) do
        if highlight then
            highlight:Destroy()
        end
    end
    CandyESPObjects = {}
end

function createESP(player)
    if not player.Character then return end
    
    local role = getPlayerRole(player)
    local color = getRoleColor(role)
    
    local weapons = getPlayerWeapon(player)
    local weaponText = ""
    if #weapons > 0 then
        weaponText = " [" .. table.concat(weapons, ", ") .. "]"
    end
    
    if UseBoxESP then
        local box = Instance.new("BoxHandleAdornment")
        box.Name = "ESPBox_" .. player.Name
        box.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
        box.Size = Vector3.new(4, 6, 4)
        box.Color3 = color
        box.Transparency = 0.3
        box.AlwaysOnTop = true
        box.ZIndex = 1
        box.Parent = player.Character:FindFirstChild("HumanoidRootPart")
    end
    
    if UseHighlights then
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight_" .. player.Name
        highlight.Adornee = player.Character
        highlight.FillColor = color
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = color
        highlight.OutlineTransparency = 0
        highlight.Parent = player.Character
    end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_" .. player.Name
    billboard.Adornee = player.Character:FindFirstChild("Head")
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name .. " (" .. role .. ")" .. weaponText
    nameLabel.TextColor3 = color
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Visible = ShowNames
    nameLabel.Parent = billboard
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = color
    distanceLabel.TextSize = 12
    distanceLabel.Font = Enum.Font.Gotham
    distanceLabel.Visible = ShowDistance
    distanceLabel.Parent = billboard
    
    billboard.Parent = player.Character:FindFirstChild("Head")
    
    if UseTracers then
        local tracer = Instance.new("Frame")
        tracer.Name = "ESPTracer_" .. player.Name
        tracer.BackgroundColor3 = color
        tracer.BorderSizePixel = 0
        tracer.Size = UDim2.new(0, 2, 0, 100)
        tracer.AnchorPoint = Vector2.new(0.5, 1)
        tracer.Position = UDim2.new(0.5, 0, 1, 0)
        tracer.Parent = game.CoreGui
    end
    
    ESPConnections[player] = {
        Billboard = billboard,
        Box = UseBoxESP and player.Character:FindFirstChild("ESPBox_" .. player.Name) or nil,
        Highlight = UseHighlights and player.Character:FindFirstChild("ESPHighlight_" .. player.Name) or nil,
        Tracer = UseTracers and game.CoreGui:FindFirstChild("ESPTracer_" .. player.Name) or nil
    }
end

function startESP()
    stopESP()
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            createESP(player)
        end
    end
    
    local lastUpdate = tick()
    ESPUpdateConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not EnableESP then return end
        
        for player, espData in pairs(ESPConnections) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local localPlayer = game.Players.LocalPlayer
                if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (player.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                    
                    if espData.Billboard then
                        local distanceLabel = espData.Billboard:FindFirstChildOfClass("TextLabel"):FindFirstChildWhichIsA("TextLabel")
                        if distanceLabel then
                            distanceLabel.Text = math.floor(distance) .. " studs"
                        end
                    end
                    
                    if espData.Tracer then
                        updateTracer(espData.Tracer, player)
                    end
                end
            end
        end
        
        if tick() - lastUpdate > 10 then
            updateESP()
            lastUpdate = tick()
        end
    end)
end

function updateTracer(tracer, player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        tracer.Visible = false
        return
    end
    
    local localPlayer = game.Players.LocalPlayer
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        tracer.Visible = false
        return
    end
    
    local playerPos = player.Character.HumanoidRootPart.Position
    local camera = workspace.CurrentCamera
    local screenPos, onScreen = camera:WorldToViewportPoint(playerPos)
    
    if onScreen then
        tracer.Visible = true
        local x = screenPos.X
        local y = screenPos.Y
        
        local centerX = camera.ViewportSize.X / 2
        local centerY = camera.ViewportSize.Y / 2
        
        local deltaX = x - centerX
        local deltaY = y - centerY
        local angle = math.atan2(deltaY, deltaX)
        local length = math.sqrt(deltaX * deltaX + deltaY * deltaY)
        
        tracer.Rotation = math.deg(angle)
        tracer.Size = UDim2.new(0, 2, 0, math.min(length, 200))
        tracer.Position = UDim2.new(0.5, 0, 0.5, 0)
    else
        tracer.Visible = false
    end
end

function stopESP()
    if ESPUpdateConnection then
        ESPUpdateConnection:Disconnect()
        ESPUpdateConnection = nil
    end
    
    for player, espData in pairs(ESPConnections) do
        if espData.Billboard then espData.Billboard:Destroy() end
        if espData.Box then espData.Box:Destroy() end
        if espData.Highlight then espData.Highlight:Destroy() end
        if espData.Tracer then espData.Tracer:Destroy() end
    end
    ESPConnections = {}
end

function updateESP()
    if EnableESP then
        stopESP()
        startESP()
    end
end

function startAttach()
    stopAttach()
    
    AttachConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not AttachEnabled then return end
        
        local nearestPlayer = nil
        local nearestDistance = math.huge
        local localPlayer = game.Players.LocalPlayer
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (player.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < nearestDistance then
                    nearestDistance = distance
                    nearestPlayer = player
                end
            end
        end
        
        if nearestPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = nearestPlayer.Character.HumanoidRootPart.CFrame
        end
    end)
end

function stopAttach()
    if AttachConnection then
        AttachConnection:Disconnect()
        AttachConnection = nil
    end
end

function startKillAura()
    stopKillAura()
    
    KillAuraConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not KillAuraEnabled then return end
        
        local localPlayer = game.Players.LocalPlayer
        if not localPlayer.Character then return end
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (player.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < 15 then
                    localPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                    break
                end
            end
        end
    end)
end

function stopKillAura()
    if KillAuraConnection then
        KillAuraConnection:Disconnect()
        KillAuraConnection = nil
    end
end

function startShootMurder()
    stopShootMurder()
    
    ShootMurderConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not ShootMurderEnabled then return end
        
        local localPlayer = game.Players.LocalPlayer
        if not hasWeapon(localPlayer, "gun") then
            return
        end
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= localPlayer and getPlayerRole(player) == "Murderer" then
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and
                   localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                   
                    local distance = (player.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distance < 50 then
                        local murdererHead = player.Character:FindFirstChild("Head")
                        if murdererHead then
                            local camera = workspace.CurrentCamera
                            camera.CFrame = CFrame.new(camera.CFrame.Position, murdererHead.Position)
                        end
                        break
                    end
                end
            end
        end
    end)
end

function stopShootMurder()
    if ShootMurderConnection then
        ShootMurderConnection:Disconnect()
        ShootMurderConnection = nil
    end
end

function startKillAll()
    stopKillAll()
    
    KillAllConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not KillAllEnabled then return end
        
        local localPlayer = game.Players.LocalPlayer
        if not localPlayer or not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = localPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end)
end

function stopKillAll()
    if KillAllConnection then
        KillAllConnection:Disconnect()
        KillAllConnection = nil
    end
end

-- Touch Fling via Velocity
function startFling()
    stopFling()
    
    updateFlingPlayers()
    
    local targetPlayer = game.Players:FindFirstChild(SelectedFlingTarget)
    if not targetPlayer then 
        WindUI:Notify({
            Title = "Fling Error",
            Content = "Target player not found!",
            Icon = "x"
        })
        return 
    end
    
    FlingStartPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    
    FlingConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not FlingEnabled then return end
        
        if tick() - LastPlayerUpdate > 60 then
            updateFlingPlayers()
        end
        
        local localPlayer = game.Players.LocalPlayer
        if not localPlayer or not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetHRP = targetPlayer.Character.HumanoidRootPart
            local localHRP = localPlayer.Character.HumanoidRootPart
            
            local distance = (targetHRP.Position - localHRP.Position).Magnitude
            if distance > 100 then
                localHRP.CFrame = FlingStartPosition
                return
            end
            
            -- Touch Fling via Velocity method
            localHRP.CFrame = targetHRP.CFrame
            
            -- Apply velocity for flinging effect
            if not localHRP:FindFirstChild("FlingVelocity") then
                local velocity = Instance.new("BodyVelocity")
                velocity.Name = "FlingVelocity"
                velocity.Velocity = Vector3.new(0, 5000, 0)
                velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                velocity.Parent = localHRP
            end
            
            -- Touch activation
            firetouchinterest(localHRP, targetHRP, 0)
            task.wait(0.1)
            firetouchinterest(localHRP, targetHRP, 1)
        end
    end)
end

function stopFling()
    if FlingConnection then
        FlingConnection:Disconnect()
        FlingConnection = nil
    end
    
    local localPlayer = game.Players.LocalPlayer
    if localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local velocity = localPlayer.Character.HumanoidRootPart:FindFirstChild("FlingVelocity")
        if velocity then
            velocity:Destroy()
        end
    end
end

function teleportToMap()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        WindUI:Notify({
            Title = "Teleport",
            Content = "Teleported to map center!",
            Icon = "map"
        })
    end
end

function teleportToLobby()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(50, 5, 50)
        WindUI:Notify({
            Title = "Teleport",
            Content = "Teleported to lobby!",
            Icon = "home"
        })
    end
end

function teleportToPlayer()
    local targetPlayer = game.Players:FindFirstChild(SelectedFlingTarget)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            WindUI:Notify({
                Title = "Teleport",
                Content = "Teleported to " .. SelectedFlingTarget .. "!",
                Icon = "user"
            })
        end
    else
        WindUI:Notify({
            Title = "Teleport Error",
            Content = "Target player not found!",
            Icon = "x"
        })
    end
end

function enableGodMode()
    GodModeEnabled = true
    
    local player = game.Players.LocalPlayer
    if not player or not player.Character then return end
    
    local originalPosition = player.Character.HumanoidRootPart.Position
    
    GodModeConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not GodModeEnabled then return end
        
        if player and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            
            if humanoid then
                humanoid.Health = 100
                humanoid.MaxHealth = 100
                
                if humanoid.Health <= 0 then
                    humanoid.Health = 100
                end
            end
            
            if hrp then
                if hrp.Position.Y < -50 then
                    hrp.CFrame = CFrame.new(originalPosition)
                end
            end
            
            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                if otherPlayer ~= player and otherPlayer.Character then
                    otherPlayer.Character:Destroy()
                end
            end
        end
    end)
    
    WindUI:Notify({
        Title = "GodMode",
        Content = "GodMode enabled! Other players removed.",
        Icon = "shield"
    })
end

function disableGodMode()
    GodModeEnabled = false
    
    if GodModeConnection then
        GodModeConnection:Disconnect()
        GodModeConnection = nil
    end
    
    WindUI:Notify({
        Title = "GodMode",
        Content = "GodMode disabled!",
        Icon = "shield-off"
    })
end

function kickAllPlayers()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            player:Kick("Script by Likegenm")
        end
    end
end

function createTabs()
    if not KeyVerified then return end
    
    local PlayerTab = MainWindow:Tab({Title = "Player", Icon = "user"})
    
    local MovementSection = PlayerTab:Section({Title = "Movement"})
    MovementSection:Toggle({Title = "Speed Hack", Default = false, Callback = function(Value)
        SpeedHackEnabled = Value
        if Value then applySpeedHack() else resetSpeedHack() end
    end})
    
    MovementSection:Slider({Title = "Speed", Step = 1, Value = {Min = 16, Max = 100, Default = 16}, Callback = function(value)
        SpeedValue = value
        if SpeedHackEnabled then applySpeedHack() end
    end})
    
    MovementSection:Toggle({Title = "Infinite Jump", Default = false, Callback = function(Value)
        InfiniteJumpEnabled = Value
        if Value then enableInfiniteJump() else disableInfiniteJump() end
    end})
    
    MovementSection:Toggle({Title = "NoClip", Default = false, Callback = function(Value)
        NoClipEnabled = Value
        if Value then enableNoClip() else disableNoClip() end
    end})
    
    MovementSection:Toggle({Title = "Fly", Default = false, Callback = function(Value)
        FlyEnabled = Value
        if Value then enableFly() else disableFly() end
    end})
    
    MovementSection:Slider({Title = "Fly Speed", Step = 1, Value = {Min = 50, Max = 500, Default = 100}, Callback = function(value)
        FlySpeed = value
    end})
    
    local VisualSection = PlayerTab:Section({Title = "Visual"})
    VisualSection:Toggle({Title = "FullBright", Default = false, Callback = function(Value)
        FullBrightEnabled = Value
        if Value then enableFullBright() else disableFullBright() end
    end})
    
    VisualSection:Toggle({Title = "FOV Changer", Default = false, Callback = function(Value)
        FOVChangerEnabled = Value
        if Value then applyFOV() else resetFOV() end
    end})
    
    VisualSection:Slider({Title = "FOV Value", Step = 1, Value = {Min = 30, Max = 120, Default = 70}, Callback = function(value)
        FOVValue = value
        if FOVChangerEnabled then applyFOV() end
    end})
    
    local PerformanceSection = PlayerTab:Section({Title = "Performance"})
    PerformanceSection:Toggle({Title = "FPS Boost", Default = false, Callback = function(Value)
        FPSBoostEnabled = Value
        if Value then enableFPSBoost() else disableFPSBoost() end
    end})
    
    local ESPTab = MainWindow:Tab({Title = "ESP", Icon = "eye"})
    local ESPSettingsSection = ESPTab:Section({Title = "ESP Settings"})
    
    ESPSettingsSection:Toggle({Title = "Enable ESP", Default = false, Callback = function(Value)
        EnableESP = Value
        if Value then startESP() else stopESP() end
    end})
    
    ESPSettingsSection:Toggle({Title = "Show Names", Default = true, Callback = function(Value)
        ShowNames = Value
        updateESP()
    end})
    
    ESPSettingsSection:Toggle({Title = "Show Distance", Default = true, Callback = function(Value)
        ShowDistance = Value
        updateESP()
    end})
    
    ESPSettingsSection:Toggle({Title = "Tracers", Default = false, Callback = function(Value)
        UseTracers = Value
        updateESP()
    end})
    
    ESPSettingsSection:Toggle({Title = "Box ESP", Default = false, Callback = function(Value)
        UseBoxESP = Value
        updateESP()
    end})
    
    ESPSettingsSection:Toggle({Title = "Highlights", Default = false, Callback = function(Value)
        UseHighlights = Value
        updateESP()
    end})
    
    ESPSettingsSection:Toggle({Title = "Gun ESP", Default = false, Callback = function(Value)
        GunESPEnabled = Value
        if Value then startGunESP() else stopGunESP() end
    end})
    
    ESPSettingsSection:Toggle({Title = "Candy ESP", Default = false, Callback = function(Value)
        CandyESPEnabled = Value
        if Value then startCandyESP() else stopCandyESP() end
    end})
    
    local ColorsSection = ESPTab:Section({Title = "Colors"})
    ColorsSection:Colorpicker({Title = "Murderer", Default = Color3.fromRGB(255, 0, 0), Callback = function(color)
        MurdererColor = color
        updateESP()
    end})
    
    ColorsSection:Colorpicker({Title = "Sheriff", Default = Color3.fromRGB(0, 0, 255), Callback = function(color)
        SheriffColor = color
        updateESP()
    end})
    
    ColorsSection:Colorpicker({Title = "Innocent", Default = Color3.fromRGB(0, 255, 0), Callback = function(color)
        InnocentColor = color
        updateESP()
    end})
    
    ColorsSection:Colorpicker({Title = "Gun", Default = Color3.fromRGB(255, 255, 0), Callback = function(color)
        GunColor = color
        if GunESPEnabled then stopGunESP(); startGunESP() end
    end})
    
    ColorsSection:Colorpicker({Title = "Candy", Default = Color3.fromRGB(255, 105, 180), Callback = function(color)
        CandyColor = color
        if CandyESPEnabled then stopCandyESP(); startCandyESP() end
    end})
    
    local AutoTab = MainWindow:Tab({Title = "Auto", Icon = "settings"})
    local AutoFarmSection = AutoTab:Section({Title = "🔄 Auto Farm"})
    
    AutoFarmSection:Toggle({Title = "Auto Farm Candy", Default = false, Callback = function(Value)
        AutoFarmEnabled = Value
        if Value then startAutoFarm() else stopAutoFarm() end
    end})
    
    AutoFarmSection:Button({Title = "Find Candies", Icon = "search", Callback = function()
        local candies = {}
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") or obj:IsA("MeshPart") then
                local objName = obj.Name:lower()
                if objName:find("candy") or objName:find("coin") then
                    table.insert(candies, obj)
                end
            end
        end
        WindUI:Notify({Title = "Candy Search", Content = "Found " .. #candies .. " candies!", Icon = "search"})
    end})
    
    local AutoGunSection = AutoTab:Section({Title = "🔫 Auto Gun"})
    AutoGunSection:Toggle({Title = "Auto Pickup Gun", Default = false, Callback = function(Value)
        AutoGunEnabled = Value
        if Value then startAutoGun() else stopAutoGun() end
    end})
    
    AutoGunSection:Button({Title = "Find Guns", Icon = "search", Callback = function()
        local gunsFound = 0
        if workspace:FindFirstChild("Raggy") then gunsFound = gunsFound + 1 end
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Tool") and obj.Name:lower():find("gun") then
                gunsFound = gunsFound + 1
            end
        end
        WindUI:Notify({Title = "Gun Search", Content = "Found " .. gunsFound .. " guns!", Icon = "search"})
    end})
    
    AutoGunSection:Button({Title = "Force Pickup Raggy", Icon = "zap", Color = Color3.fromRGB(0, 255, 0), Callback = function()
        local raggy = workspace:FindFirstChild("Raggy")
        if raggy and raggy:FindFirstChild("HumanoidRootPart") then
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character.HumanoidRootPart then
                player.Character.HumanoidRootPart.CFrame = raggy.HumanoidRootPart.CFrame
                WindUI:Notify({Title = "Force Pickup", Content = "Teleported to Raggy!", Icon = "zap"})
            end
        else
            WindUI:Notify({Title = "Force Pickup", Content = "Raggy not found!", Icon = "x"})
        end
    end})
    
    local CombatTab = MainWindow:Tab({Title = "Combat", Icon = "sword"})
    local CombatSection = CombatTab:Section({Title = "Combat Functions"})
    
    CombatSection:Toggle({Title = "Attach", Default = false, Callback = function(Value)
        AttachEnabled = Value
        if Value then startAttach() else stopAttach() end
    end})
    
    CombatSection:Toggle({Title = "Kill Aura", Default = false, Callback = function(Value)
        KillAuraEnabled = Value
        if Value then startKillAura() else stopKillAura() end
    end})
    
    CombatSection:Keybind({Title = "Auto Shoot Murderer (F)", Value = "F", Callback = function(key)
        if key == "F" then
            ShootMurderEnabled = not ShootMurderEnabled
            if ShootMurderEnabled then
                startShootMurder()
                WindUI:Notify({Title = "Auto Shoot", Content = "Auto Shoot enabled! Aiming with mouse.", Icon = "target"})
            else
                stopShootMurder()
                WindUI:Notify({Title = "Auto Shoot", Content = "Auto Shoot disabled!", Icon = "target"})
            end
        end
    end})
    
    CombatSection:Toggle({Title = "Kill All (Murderer)", Default = false, Callback = function(Value)
        KillAllEnabled = Value
        if Value then
            local role = getPlayerRole(game.Players.LocalPlayer)
            if role == "Murderer" then
                startKillAll()
                WindUI:Notify({Title = "Kill All", Content = "Kill All enabled! Teleporting players.", Icon = "skull"})
            else
                WindUI:Notify({Title = "Kill All", Content = "You need to be Murderer!", Icon = "x"})
                KillAllEnabled = false
            end
        else
            stopKillAll()
            WindUI:Notify({Title = "Kill All", Content = "Kill All disabled!", Icon = "skull"})
        end
    end})
    
    local TeleportTab = MainWindow:Tab({Title = "Teleport", Icon = "navigation"})
    
    local TeleportSection = TeleportTab:Section({Title = "Teleport Locations"})
    TeleportSection:Button({Title = "Teleport to Map", Icon = "map", Callback = teleportToMap})
    TeleportSection:Button({Title = "Teleport to Lobby", Icon = "home", Callback = teleportToLobby})
    
    local PlayerTeleportSection = TeleportTab:Section({Title = "Player Teleport"})
    updateFlingPlayers()
    PlayerTeleportSection:Dropdown({Title = "Select Player", Values = FlingPlayersList, Value = FlingPlayersList[1] or "", Callback = function(value)
        SelectedFlingTarget = value
    end})
    PlayerTeleportSection:Button({Title = "Teleport to Player", Icon = "user", Callback = teleportToPlayer})
    
    local TrollTab = MainWindow:Tab({Title = "Troll", Icon = "ghost"})
    local TrollSection = TrollTab:Section({Title = "Troll Functions"})
    
    updateFlingPlayers()
    TrollSection:Dropdown({Title = "Select Fling Target", Values = FlingPlayersList, Value = FlingPlayersList[1] or "", Callback = function(value)
        SelectedFlingTarget = value
    end})
    
    TrollSection:Toggle({Title = "Touch Fling", Default = false, Callback = function(Value)
        FlingEnabled = Value
        if Value then startFling() else stopFling() end
    end})
    
    TrollSection:Toggle({Title = "GodMode (Remove Others)", Default = false, Callback = function(Value)
        GodModeEnabled = Value
        if Value then enableGodMode() else disableGodMode() end
    end})
    
    TrollSection:Button({Title = "Kick All Players", Icon = "user-x", Color = Color3.fromHex("#ff4830"), Callback = kickAllPlayers})
    
    local SettingsTab = MainWindow:Tab({Title = "Settings", Icon = "settings-2"})
    local KeybindsSection = SettingsTab:Section({Title = "Keybinds"})
    KeybindsSection:Keybind({Title = "Toggle GUI", Value = "G", Callback = function(key)
        MainWindow:SetToggleKey(Enum.KeyCode[key])
    end})
    
    local ThemeSection = SettingsTab:Section({Title = "Theme"})
    ThemeSection:Colorpicker({Title = "Background Color", Default = Color3.fromRGB(25, 25, 25), Callback = function(color)
        MainWindow:SetBackgroundColor(color)
    end})
    
    ThemeSection:Colorpicker({Title = "Accent Color", Default = Color3.fromRGB(0, 100, 255), Callback = function(color)
        MainWindow:SetAccentColor(color)
    end})
    
    SettingsTab:Button({Title = "Unload Script", Icon = "power", Color = Color3.fromHex("#ff4830"), Callback = function()
        MainWindow:Destroy()
    end})
end
