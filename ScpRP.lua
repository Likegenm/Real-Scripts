local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local Window = Library:CreateWindow({
    Title = "Likegenm scripts",
    Footer = "version: 1.0",
    Icon = 95816097006870,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

local Tabs = {
    Player = Window:AddTab("Player", "user"),
    WeaponHack = Window:AddTab("WeaponHack", "gun"),
    Troll = Window:AddTab("Troll", "laugh"),
    ESP = Window:AddTab("ESP", "target"),
    ["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

local SpeedhackGroup = Tabs.Player:AddLeftGroupbox("Speedhack")
local MovementGroup = Tabs.Player:AddRightGroupbox("Movement")
local VisualsGroup = Tabs.Player:AddLeftGroupbox("Visuals")
local KeybindsGroup = Tabs.Player:AddRightGroupbox("Keybinds")

SpeedhackGroup:AddToggle("SpeedhackToggle", {
    Text = "Enable Speedhack",
    Default = false,
})

SpeedhackGroup:AddSlider("SpeedhackDistance", {
    Text = "Teleport Distance",
    Default = 1,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Suffix = "studs",
})

SpeedhackGroup:AddSlider("SpeedhackDelay", {
    Text = "Teleport Delay",
    Default = 0.1,
    Min = 0.01,
    Max = 1,
    Rounding = 2,
    Suffix = "s",
})

MovementGroup:AddToggle("InfJumpToggle", {
    Text = "Infinite Jump",
    Default = false,
})

MovementGroup:AddToggle("NoclipToggle", {
    Text = "Noclip",
    Default = false,
})

MovementGroup:AddToggle("FlyToggle", {
    Text = "Fly Mode",
    Default = false,
})

MovementGroup:AddToggle("InvisibleToggle", {
    Text = "Invisible",
    Default = false,
})

MovementGroup:AddSlider("FlySpeed", {
    Text = "Fly Speed",
    Default = 1,
    Min = 0.01,
    Max = 3,
    Rounding = 2,
    Suffix = "mult",
})

MovementGroup:AddSlider("FlyRisePower", {
    Text = "Rise Power",
    Default = 50,
    Min = 20,
    Max = 100,
    Rounding = 0,
})

MovementGroup:AddSlider("FlyFloatSpeed", {
    Text = "Float Speed",
    Default = 5,
    Min = 1,
    Max = 15,
    Rounding = 0,
})

VisualsGroup:AddToggle("FullbrightToggle", {
    Text = "Fullbright",
    Default = false,
})

VisualsGroup:AddToggle("FOVToggle", {
    Text = "FOV Changer",
    Default = false,
})

VisualsGroup:AddSlider("FOVValue", {
    Text = "FOV Value",
    Default = 80,
    Min = 30,
    Max = 120,
    Rounding = 0,
})

KeybindsGroup:AddLabel("Fly Keybind"):AddKeyPicker("FlyKeybind", {
    Default = "X",
    NoUI = false,
    Text = "Fly toggle key",
})

KeybindsGroup:AddLabel("Speedhack Keybind"):AddKeyPicker("SpeedhackKeybind", {
    Default = "V",
    NoUI = false,
    Text = "Speedhack toggle key",
})

KeybindsGroup:AddLabel("InfJump Keybind"):AddKeyPicker("InfJumpKeybind", {
    Default = "N",
    NoUI = false,
    Text = "Infinite Jump toggle key",
})

KeybindsGroup:AddLabel("Noclip Keybind"):AddKeyPicker("NoclipKeybind", {
    Default = "C",
    NoUI = false,
    Text = "Noclip toggle key",
})

KeybindsGroup:AddLabel("ESP Keybind"):AddKeyPicker("ESPKeybind", {
    Default = "Z",
    NoUI = false,
    Text = "ESP toggle key",
})

KeybindsGroup:AddLabel("Invisible Keybind"):AddKeyPicker("InvisibleKeybind", {
    Default = "I",
    NoUI = false,
    Text = "Invisible toggle key",
})

local WeaponGroup = Tabs.WeaponHack:AddLeftGroupbox("Weapon Hacks")

WeaponGroup:AddToggle("WeaponHackToggle", {
    Text = "Enable Weapon Hack",
    Default = false,
})

WeaponGroup:AddToggle("OneHitKillToggle", {
    Text = "One Hit Kill",
    Default = false,
})

WeaponGroup:AddSlider("WeaponDamage", {
    Text = "Damage Multiplier",
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Suffix = "x",
})

WeaponGroup:AddSlider("WeaponFireRate", {
    Text = "Fire Rate",
    Default = 1,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Suffix = "x",
})

WeaponGroup:AddSlider("WeaponRange", {
    Text = "Range",
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Suffix = "x",
})

WeaponGroup:AddToggle("WeaponNoRecoil", {
    Text = "No Recoil",
    Default = false,
})

WeaponGroup:AddToggle("WeaponNoSpread", {
    Text = "No Spread",
    Default = false,
})

WeaponGroup:AddToggle("WeaponInfiniteAmmo", {
    Text = "Infinite Ammo",
    Default = false,
})

WeaponGroup:AddToggle("WeaponAutoReload", {
    Text = "Auto Reload",
    Default = false,
})

WeaponGroup:AddToggle("WeaponNoSlowdown", {
    Text = "No Slowdown",
    Default = false,
})

WeaponGroup:AddToggle("WeaponSilentAim", {
    Text = "Silent Aim",
    Default = false,
})

WeaponGroup:AddSlider("SilentAimFOV", {
    Text = "Silent Aim FOV",
    Default = 30,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Suffix = "°",
})

WeaponGroup:AddToggle("WeaponTriggerBot", {
    Text = "Trigger Bot",
    Default = false,
})

WeaponGroup:AddSlider("TriggerBotDelay", {
    Text = "Trigger Bot Delay",
    Default = 0.1,
    Min = 0.01,
    Max = 1,
    Rounding = 2,
    Suffix = "s",
})

KeybindsGroup:AddLabel("Weapon Hack Keybind"):AddKeyPicker("WeaponHackKeybind", {
    Default = "B",
    NoUI = false,
    Text = "Weapon Hack toggle key",
})

local TrollGroup = Tabs.Troll:AddLeftGroupbox("Troll Features")

TrollGroup:AddToggle("TouchFlingToggle", {
    Text = "Touch Fling",
    Default = false,
})

TrollGroup:AddSlider("FlingPower", {
    Text = "Fling Power",
    Default = 100,
    Min = 50,
    Max = 500,
    Rounding = 0,
    Suffix = "power",
})

TrollGroup:AddToggle("ChatTrollToggle", {
    Text = "Kill Chat",
    Default = false,
})

TrollGroup:AddInput("ChatMessage", {
    Text = "Kill Message",
    Default = "ez",
})

local ESPOptionsGroup = Tabs.ESP:AddLeftGroupbox("ESP")

ESPOptionsGroup:AddToggle("ESPToggle", {
    Text = "Enable ESP",
    Default = false,
})

local ESPObjects = {}
local ESPConnections = {}
local ESPEnabled = false

local function createESP()
    removeESP()
    
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    
    for _, player in pairs(players:GetPlayers()) do
        addPlayerESP(player)
    end
    
    ESPConnections.playerAdded = players.PlayerAdded:Connect(function(player)
        addPlayerESP(player)
    end)
    
    ESPConnections.playerRemoving = players.PlayerRemoving:Connect(function(player)
        if ESPObjects[player] then
            for _, obj in pairs(ESPObjects[player]) do
                if obj then
                    obj:Remove()
                end
            end
            ESPObjects[player] = nil
        end
    end)
end

local function addPlayerESP(player)
    local character = player.Character
    if not character then
        ESPConnections[player] = player.CharacterAdded:Connect(function(newChar)
            addPlayerESP(player)
        end)
        return
    end
    
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
    if not humanoidRootPart then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = player.Name .. "_Highlight"
    highlight.Adornee = character
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = game:GetService("CoreGui")
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = player.Name .. "_Info"
    billboard.Adornee = humanoidRootPart
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = game:GetService("CoreGui")
    
    local healthLabel = Instance.new("TextLabel")
    healthLabel.Name = "Health"
    healthLabel.Text = "100"
    healthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    healthLabel.BackgroundTransparency = 1
    healthLabel.Size = UDim2.new(1, 0, 1, 0)
    healthLabel.TextScaled = true
    healthLabel.Parent = billboard
    
    local tracer = Instance.new("Frame")
    tracer.Name = player.Name .. "_Tracer"
    tracer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tracer.BorderSizePixel = 0
    tracer.Size = UDim2.new(0, 2, 0, 2)
    tracer.AnchorPoint = Vector2.new(0.5, 0.5)
    tracer.Parent = game:GetService("CoreGui")
    
    ESPObjects[player] = {
        Highlight = highlight,
        Billboard = billboard,
        HealthLabel = healthLabel,
        Tracer = tracer
    }
    
    ESPConnections[player] = game:GetService("RunService").Heartbeat:Connect(function()
        if not ESPEnabled or not character or not character:FindFirstChild("HumanoidRootPart") then
            return
        end
        
        updatePlayerESP(player, character)
    end)
end

local function updatePlayerESP(player, character)
    if not ESPObjects[player] then return end
    
    local localPlayer = game:GetService("Players").LocalPlayer
    local localChar = localPlayer.Character
    if not localChar then return end
    
    local humanoidRootPart = character.HumanoidRootPart
    local localRootPart = localChar:FindFirstChild("HumanoidRootPart")
    if not localRootPart then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local health = humanoid and humanoid.Health or 0
    
    ESPObjects[player].HealthLabel.Text = tostring(math.floor(health))
    
    local screenPoint, onScreen = game:GetService("Workspace").CurrentCamera:WorldToViewportPoint(humanoidRootPart.Position)
    
    if onScreen then
        ESPObjects[player].Billboard.Enabled = true
        ESPObjects[player].Highlight.Enabled = true
        
        local tracer = ESPObjects[player].Tracer
        tracer.Visible = true
        tracer.Position = UDim2.new(0, screenPoint.X, 0, screenPoint.Y)
    else
        ESPObjects[player].Billboard.Enabled = false
        ESPObjects[player].Highlight.Enabled = false
        ESPObjects[player].Tracer.Visible = false
    end
end

local function updateESP()
    if ESPEnabled then
        createESP()
    else
        removeESP()
    end
end

local function removeESP()
    for player, objects in pairs(ESPObjects) do
        if objects.Highlight then objects.Highlight:Destroy() end
        if objects.Billboard then objects.Billboard:Destroy() end
        if objects.Tracer then objects.Tracer:Destroy() end
    end
    ESPObjects = {}
    
    for _, connection in pairs(ESPConnections) do
        connection:Disconnect()
    end
    ESPConnections = {}
end

Toggles.ESPToggle:OnChanged(function()
    ESPEnabled = Toggles.ESPToggle.Value
    updateESP()
end)

Options.FlyKeybind:OnClick(function()
    Toggles.FlyToggle:SetValue(not Toggles.FlyToggle.Value)
end)

Options.SpeedhackKeybind:OnClick(function()
    Toggles.SpeedhackToggle:SetValue(not Toggles.SpeedhackToggle.Value)
end)

Options.InfJumpKeybind:OnClick(function()
    Toggles.InfJumpToggle:SetValue(not Toggles.InfJumpToggle.Value)
end)

Options.NoclipKeybind:OnClick(function()
    Toggles.NoclipToggle:SetValue(not Toggles.NoclipToggle.Value)
end)

Options.ESPKeybind:OnClick(function()
    Toggles.ESPToggle:SetValue(not Toggles.ESPToggle.Value)
end)

Options.InvisibleKeybind:OnClick(function()
    Toggles.InvisibleToggle:SetValue(not Toggles.InvisibleToggle.Value)
end)

Options.WeaponHackKeybind:OnClick(function()
    Toggles.WeaponHackToggle:SetValue(not Toggles.WeaponHackToggle.Value)
end)

local SpeedhackConnection
local SpeedhackEnabled = false
local LastTeleportTime = 0

local function isMoving()
    local UserInputService = game:GetService("UserInputService")
    return UserInputService:IsKeyDown(Enum.KeyCode.W) or
           UserInputService:IsKeyDown(Enum.KeyCode.A) or
           UserInputService:IsKeyDown(Enum.KeyCode.S) or
           UserInputService:IsKeyDown(Enum.KeyCode.D)
end

local function startSpeedhack()
    if SpeedhackConnection then
        SpeedhackConnection:Disconnect()
    end
    
    SpeedhackConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not SpeedhackEnabled then return end
        
        local currentTime = tick()
        if currentTime - LastTeleportTime < Options.SpeedhackDelay.Value then
            return
        end
        
        if not isMoving() then
            return
        end
        
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        local moveDirection = Vector3.new(0, 0, 0)
        local UserInputService = game:GetService("UserInputService")
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + humanoidRootPart.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - humanoidRootPart.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - humanoidRootPart.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + humanoidRootPart.CFrame.RightVector
        end
        
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
            local distance = Options.SpeedhackDistance.Value
            
            humanoidRootPart.CFrame = humanoidRootPart.CFrame + moveDirection * distance
            LastTeleportTime = currentTime
        end
    end)
end

local function stopSpeedhack()
    if SpeedhackConnection then
        SpeedhackConnection:Disconnect()
        SpeedhackConnection = nil
    end
end

Toggles.SpeedhackToggle:OnChanged(function()
    SpeedhackEnabled = Toggles.SpeedhackToggle.Value
    
    if SpeedhackEnabled then
        startSpeedhack()
    else
        stopSpeedhack()
    end
end)

local InfJumpConnection
local InfJumpEnabled = false

local function getCharacter()
    local player = game.Players.LocalPlayer
    return player.Character
end

local function getHumanoid()
    local character = getCharacter()
    if character then
        return character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

local function getRootPart()
    local character = getCharacter()
    if character then
        return character:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

local function startInfJump()
    if InfJumpConnection then
        InfJumpConnection:Disconnect()
    end
    
    InfJumpConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not InfJumpEnabled then return end
        
        local humanoid = getHumanoid()
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

local function stopInfJump()
    if InfJumpConnection then
        InfJumpConnection:Disconnect()
        InfJumpConnection = nil
    end
end

Toggles.InfJumpToggle:OnChanged(function()
    InfJumpEnabled = Toggles.InfJumpToggle.Value
    
    if InfJumpEnabled then
        startInfJump()
    else
        stopInfJump()
    end
end)

local NoclipConnection
local NoclipEnabled = false

local function startNoclip()
    if NoclipConnection then
        NoclipConnection:Disconnect()
    end
    
    NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
        if not NoclipEnabled then return end
        
        local character = getCharacter()
        if not character then return end
        
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end)
end

local function stopNoclip()
    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end
end

Toggles.NoclipToggle:OnChanged(function()
    NoclipEnabled = Toggles.NoclipToggle.Value
    
    if NoclipEnabled then
        startNoclip()
    else
        stopNoclip()
    end
end)

local InvisibleConnection
local InvisibleEnabled = false

local function startInvisible()
    if InvisibleConnection then
        InvisibleConnection:Disconnect()
    end
    
    local character = getCharacter()
    if not character then return end
    
    local rootPart = getRootPart()
    if not rootPart then return end
    
    local currentPosition = rootPart.Position
    local undergroundPosition = Vector3.new(currentPosition.X, currentPosition.Y - 10, currentPosition.Z)
    rootPart.CFrame = CFrame.new(undergroundPosition)
    
    InvisibleConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not InvisibleEnabled then return end
        
        local currentRoot = getRootPart()
        if not currentRoot then return end
        
        currentRoot.Velocity = Vector3.new(currentRoot.Velocity.X, 0, currentRoot.Velocity.Z)
    end)
end

local function stopInvisible()
    if InvisibleConnection then
        InvisibleConnection:Disconnect()
        InvisibleConnection = nil
    end
    
    local character = getCharacter()
    if character then
        local rootPart = getRootPart()
        if rootPart then
            local currentPos = rootPart.Position
            local surfacePosition = Vector3.new(currentPos.X, currentPos.Y + 10, currentPos.Z)
            rootPart.CFrame = CFrame.new(surfacePosition)
        end
    end
end

Toggles.InvisibleToggle:OnChanged(function()
    InvisibleEnabled = Toggles.InvisibleToggle.Value
    
    if InvisibleEnabled then
        startInvisible()
    else
        stopInvisible()
    end
end)

local FlyConnection
local FlyEnabled = false

local function startFly()
    if FlyConnection then
        FlyConnection:Disconnect()
    end
    
    FlyConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not FlyEnabled then return end
        
        local rootPart = getRootPart()
        if not rootPart then return end
        
        local moveDirection = Vector3.new(0, 0, 0)
        local UserInputService = game:GetService("UserInputService")
        local humanoid = getHumanoid()
        local walkSpeed = humanoid and humanoid.WalkSpeed or 16
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + rootPart.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - rootPart.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - rootPart.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + rootPart.CFrame.RightVector
        end
        
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
            local flySpeed = Options.FlySpeed.Value * walkSpeed
            
            rootPart.CFrame = rootPart.CFrame + moveDirection * flySpeed
        end
        
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            rootPart.Velocity = Vector3.new(
                rootPart.Velocity.X,
                Options.FlyRisePower.Value,
                rootPart.Velocity.Z
            )
        elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            rootPart.Velocity = Vector3.new(
                rootPart.Velocity.X,
                -Options.FlyFloatSpeed.Value,
                rootPart.Velocity.Z
            )
        else
            rootPart.Velocity = Vector3.new(
                rootPart.Velocity.X,
                0,
                rootPart.Velocity.Z
            )
        end
    end)
end

local function stopFly()
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
end

Toggles.FlyToggle:OnChanged(function()
    FlyEnabled = Toggles.FlyToggle.Value
    
    if FlyEnabled then
        startFly()
    else
        stopFly()
    end
end)

local WeaponHackConnection
local WeaponHackEnabled = false
local OriginalWeapons = {}

local function getWeapons()
    local weapons = {}
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return weapons end
    
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Tool") then
            table.insert(weapons, item)
        end
    end
    
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                table.insert(weapons, item)
            end
        end
    end
    
    return weapons
end

local function applyWeaponModifications(weapon)
    if not weapon then return end
    
    if not OriginalWeapons[weapon] then
        OriginalWeapons[weapon] = {}
    end
    
    if Toggles.OneHitKillToggle.Value then
        local damageValue = weapon:FindFirstChild("Damage")
        if damageValue and damageValue:IsA("NumberValue") then
            damageValue.Value = 9999
        end
    else
        local damageValue = weapon:FindFirstChild("Damage")
        if damageValue and damageValue:IsA("NumberValue") then
            if not OriginalWeapons[weapon].Damage then
                OriginalWeapons[weapon].Damage = damageValue.Value
            end
            damageValue.Value = OriginalWeapons[weapon].Damage * Options.WeaponDamage.Value
        end
    end
    
    local fireRate = weapon:FindFirstChild("FireRate")
    if fireRate and fireRate:IsA("NumberValue") then
        if not OriginalWeapons[weapon].FireRate then
            OriginalWeapons[weapon].FireRate = fireRate.Value
        end
        fireRate.Value = OriginalWeapons[weapon].FireRate * Options.WeaponFireRate.Value
    end
    
    local range = weapon:FindFirstChild("Range")
    if range and range:IsA("NumberValue") then
        if not OriginalWeapons[weapon].Range then
            OriginalWeapons[weapon].Range = range.Value
        end
        range.Value = OriginalWeapons[weapon].Range * Options.WeaponRange.Value
    end
    
    if Toggles.WeaponNoRecoil.Value then
        local recoil = weapon:FindFirstChild("Recoil")
        if recoil and recoil:IsA("NumberValue") then
            recoil.Value = 0
        end
    end
    
    if Toggles.WeaponNoSpread.Value then
        local spread = weapon:FindFirstChild("Spread")
        if spread and spread:IsA("NumberValue") then
            spread.Value = 0
        end
    end
    
    if Toggles.WeaponInfiniteAmmo.Value then
        local ammo = weapon:FindFirstChild("Ammo")
        if ammo and ammo:IsA("IntValue") then
            ammo.Value = 999
        end
        local clip = weapon:FindFirstChild("Clip")
        if clip and clip:IsA("IntValue") then
            clip.Value = 999
        end
        local magazine = weapon:FindFirstChild("Magazine")
        if magazine and magazine:IsA("IntValue") then
            magazine.Value = 999
        end
        local bullets = weapon:FindFirstChild("Bullets")
        if bullets and bullets:IsA("IntValue") then
            bullets.Value = 999
        end
    end
    
    if Toggles.WeaponAutoReload.Value then
        local ammo = weapon:FindFirstChild("Ammo")
        local clip = weapon:FindFirstChild("Clip")
        if ammo and clip and ammo.Value <= 0 then
            ammo.Value = 999
            clip.Value = 999
        end
    end
    
    if Toggles.WeaponNoSlowdown.Value then
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = 16
        end
    end
end

local function restoreWeapon(weapon)
    if not weapon or not OriginalWeapons[weapon] then return end
    
    local damageValue = weapon:FindFirstChild("Damage")
    if damageValue and OriginalWeapons[weapon].Damage then
        damageValue.Value = OriginalWeapons[weapon].Damage
    end
    
    local fireRate = weapon:FindFirstChild("FireRate")
    if fireRate and OriginalWeapons[weapon].FireRate then
        fireRate.Value = OriginalWeapons[weapon].FireRate
    end
    
    local range = weapon:FindFirstChild("Range")
    if range and OriginalWeapons[weapon].Range then
        range.Value = OriginalWeapons[weapon].Range
    end
end

local function startWeaponHack()
    if WeaponHackConnection then
        WeaponHackConnection:Disconnect()
    end
    
    WeaponHackConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not WeaponHackEnabled then return end
        
        local weapons = getWeapons()
        for _, weapon in pairs(weapons) do
            applyWeaponModifications(weapon)
        end
    end)
end

local function stopWeaponHack()
    if WeaponHackConnection then
        WeaponHackConnection:Disconnect()
        WeaponHackConnection = nil
    end
    
    local weapons = getWeapons()
    for _, weapon in pairs(weapons) do
        restoreWeapon(weapon)
    end
    OriginalWeapons = {}
end

Toggles.WeaponHackToggle:OnChanged(function()
    WeaponHackEnabled = Toggles.WeaponHackToggle.Value
    
    if WeaponHackEnabled then
        startWeaponHack()
    else
        stopWeaponHack()
    end
end)

local TouchFlingConnection
local TouchFlingEnabled = false

local function startTouchFling()
    if TouchFlingConnection then
        TouchFlingConnection:Disconnect()
    end
    
    TouchFlingConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not TouchFlingEnabled then return end
        
        local character = getCharacter()
        if not character then return end
        
        local rootPart = getRootPart()
        if not rootPart then return end
        
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Parent and part.Parent:FindFirstChildOfClass("Humanoid") and part.Parent ~= character then
                local distance = (part.Position - rootPart.Position).Magnitude
                if distance < 5 then
                    part.Velocity = Vector3.new(
                        math.random(-Options.FlingPower.Value, Options.FlingPower.Value),
                        Options.FlingPower.Value,
                        math.random(-Options.FlingPower.Value, Options.FlingPower.Value)
                    )
                end
            end
        end
    end)
end

local function stopTouchFling()
    if TouchFlingConnection then
        TouchFlingConnection:Disconnect()
        TouchFlingConnection = nil
    end
end

Toggles.TouchFlingToggle:OnChanged(function()
    TouchFlingEnabled = Toggles.TouchFlingToggle.Value
    
    if TouchFlingEnabled then
        startTouchFling()
    else
        stopTouchFling()
    end
end)

local ChatTrollConnection
local ChatTrollEnabled = false

local function startChatTroll()
    if ChatTrollConnection then
        ChatTrollConnection:Disconnect()
    end
    
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    
    ChatTrollConnection = players.PlayerRemoving:Connect(function(player)
        if not ChatTrollEnabled then return end
        
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            if humanoid.Health <= 0 then
                local killedBy = humanoid:FindFirstChild("creator")
                if killedBy and killedBy.Value == localPlayer then
                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Options.ChatMessage.Value, "All")
                end
            end
        end
    end)
end

local function stopChatTroll()
    if ChatTrollConnection then
        ChatTrollConnection:Disconnect()
        ChatTrollConnection = nil
    end
end

Toggles.ChatTrollToggle:OnChanged(function()
    ChatTrollEnabled = Toggles.ChatTrollToggle.Value
    
    if ChatTrollEnabled then
        startChatTroll()
    else
        stopChatTroll()
    end
end)

local FullbrightConnection
local FullbrightEnabled = false

local function startFullbright()
    if FullbrightConnection then
        FullbrightConnection:Disconnect()
    end
    
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").Brightness = 2
    
    FullbrightConnection = game:GetService("Lighting").Changed:Connect(function()
        if FullbrightEnabled then
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").Brightness = 2
        end
    end)
end

local function stopFullbright()
    if FullbrightConnection then
        FullbrightConnection:Disconnect()
        FullbrightConnection = nil
    end
    
    game:GetService("Lighting").GlobalShadows = true
    game:GetService("Lighting").Brightness = 1
end

Toggles.FullbrightToggle:OnChanged(function()
    FullbrightEnabled = Toggles.FullbrightToggle.Value
    
    if FullbrightEnabled then
        startFullbright()
    else
        stopFullbright()
    end
end)

local FOVConnection
local FOVEnabled = false

local function startFOV()
    if FOVConnection then
        FOVConnection:Disconnect()
    end
    
    local camera = game:GetService("Workspace").CurrentCamera
    FOVConnection = game:GetService("RunService").RenderStepped:Connect(function()
        if not FOVEnabled then return end
        
        camera.FieldOfView = Options.FOVValue.Value
    end)
end

local function stopFOV()
    if FOVConnection then
        FOVConnection:Disconnect()
        FOVConnection = nil
    end
end

Toggles.FOVToggle:OnChanged(function()
    FOVEnabled = Toggles.FOVToggle.Value
    
    if FOVEnabled then
        startFOV()
    else
        stopFOV()
    end
end)

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "Open Keybind Menu",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor",
    Default = true,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})

MenuGroup:AddDropdown("NotificationSide", {
    Values = {"Left", "Right"},
    Default = "Right",
    Text = "Notification Side",
    Callback = function(Value)
        Library:SetNotifySide(Value)
    end,
})

MenuGroup:AddDropdown("DPIDropdown", {
    Values = {"50%", "75%", "100%", "125%", "150%", "175%", "200%"},
    Default = "100%",
    Text = "DPI Scale",
    Callback = function(Value)
        Value = Value:gsub("%%", "")
        local DPI = tonumber(Value)
        Library:SetDPIScale(DPI)
    end,
})

MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {Default = "RightShift", NoUI = true, Text = "Menu keybind"})

MenuGroup:AddButton("Unload", function()
    Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})

ThemeManager:SetFolder("MyScriptHub")
SaveManager:SetFolder("MyScriptHub/specific-game")

SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()

Library:OnUnload(function()
    stopSpeedhack()
    stopInfJump()
    stopFly()
    stopNoclip()
    stopInvisible()
    stopWeaponHack()
    stopTouchFling()
    stopChatTroll()
    stopFullbright()
    stopFOV()
    removeESP()
    print("Unloaded!")
end)
