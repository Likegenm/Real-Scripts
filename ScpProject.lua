local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Likegenm Scripts",
   LoadingTitle = "Likegenm Hub",
   LoadingSubtitle = "by Likegenm",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "LikegenmHub",
      FileName = "Config"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Aimbot Variables
local AimbotEnabled = false
local TeamCheck = true
local WallCheck = true
local AimbotKey = "Q"
local AimbotActive = false
local CurrentTarget = nil

-- ESP Variables
local ESPEnabled = false
local NameESP = true
local HealthESP = true
local TracersESP = false
local HighlightsESP = true  -- 3D Highlights для всего игрока
local DistanceESP = true
local BoxESP = true
local HealthBarESP = true

-- ESP Colors
local NameColor = Color3.fromRGB(255, 255, 255)
local HealthColor = Color3.fromRGB(0, 255, 0)
local TracersColor = Color3.fromRGB(255, 255, 0)
local HighlightsColor = Color3.fromRGB(255, 0, 0)  -- Цвет 3D хайлайтов
local DistanceColor = Color3.fromRGB(128, 128, 255)
local BoxColor = Color3.fromRGB(255, 128, 0)
local HealthBarColor = Color3.fromRGB(0, 255, 0)

-- Blatant Variables
local FullbrightEnabled = false
local SpeedhackEnabled = false
local SpeedhackStuds = 3
local SpeedhackDelay = 0.3
local TeleportHackEnabled = false
local TeleportDistance = 30
local ThirdPersonEnabled = false
local AttachEnabled = false
local AutoClickerEnabled = false

-- Auto Attach Variables
local AutoAttachEnabled = false
local AutoAttachTarget = nil
local AutoAttachLoop = nil

local ESPObjects = {}

-- GUI Movement Variables
local GuiMovementEnabled = true
local dragging = false
local dragInput, dragStart, startPos

-- Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local ESPTab = Window:CreateTab("ESP", 4483362458)
local BlatantTab = Window:CreateTab("Blatant", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- Make GUI Draggable
local function MakeDraggable(topbarobject, object)
    topbarobject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = object.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    topbarobject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging and GuiMovementEnabled then
            local delta = input.Position - dragStart
            object.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Apply draggable to main window
task.spawn(function()
    repeat task.wait() until Window:GetGUI()
    local MainFrame = Window:GetGUI()
    if MainFrame then
        MakeDraggable(MainFrame, MainFrame)
    end
end)

-- Main Tab (Aimbot)
local AimbotSection = MainTab:CreateSection("Aimbot")

local AimbotToggle = MainTab:CreateToggle({
   Name = "Enable Aimbot",
   CurrentValue = false,
   Flag = "AimbotToggle",
   Callback = function(Value)
      AimbotEnabled = Value
      if not Value then
          AimbotActive = false
      end
      print("[Aimbot] Enabled:", Value)
   end,
})

local TeamCheckToggle = MainTab:CreateToggle({
   Name = "Team Check",
   CurrentValue = true,
   Flag = "TeamCheckToggle",
   Callback = function(Value)
      TeamCheck = Value
      print("[Aimbot] Team Check:", Value)
   end,
})

local WallCheckToggle = MainTab:CreateToggle({
   Name = "Wall Check",
   CurrentValue = true,
   Flag = "WallCheckToggle",
   Callback = function(Value)
      WallCheck = Value
      print("[Aimbot] Wall Check:", Value)
   end,
})

MainTab:CreateKeybind({
   Name = "Aimbot Key",
   CurrentKeybind = "Q",
   HoldToInteract = false,
   Flag = "AimbotKeybind",
   Callback = function(Key)
      AimbotKey = Key
      print("[Aimbot] Key changed to:", Key)
   end,
})

-- Auto Clicker Section
local AutoClickerSection = MainTab:CreateSection("Auto Clicker")

local AutoClickerToggle = MainTab:CreateToggle({
   Name = "Auto Clicker",
   CurrentValue = false,
   Flag = "AutoClickerToggle",
   Callback = function(Value)
      AutoClickerEnabled = Value
      print("[AutoClicker] Enabled:", Value)
   end,
})

-- ESP Tab
local ESPMainSection = ESPTab:CreateSection("ESP Settings")

local ESPToggle = ESPTab:CreateToggle({
   Name = "Enable ESP",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
      ESPEnabled = Value
      UpdateESPVisibility()
      print("[ESP] Enabled:", Value)
   end,
})

local NameESPToggle = ESPTab:CreateToggle({
   Name = "Name ESP",
   CurrentValue = true,
   Flag = "NameESPToggle",
   Callback = function(Value)
      NameESP = Value
      print("[ESP] Name ESP:", Value)
   end,
})

local HealthESPToggle = ESPTab:CreateToggle({
   Name = "Health ESP",
   CurrentValue = true,
   Flag = "HealthESPToggle",
   Callback = function(Value)
      HealthESP = Value
      print("[ESP] Health ESP:", Value)
   end,
})

local TracersToggle = ESPTab:CreateToggle({
   Name = "Tracers",
   CurrentValue = false,
   Flag = "TracersToggle",
   Callback = function(Value)
      TracersESP = Value
      print("[ESP] Tracers:", Value)
   end,
})

local HighlightsToggle = ESPTab:CreateToggle({
   Name = "3D Highlights",
   CurrentValue = true,
   Flag = "HighlightsToggle",
   Callback = function(Value)
      HighlightsESP = Value
      UpdateESPVisibility()
      print("[ESP] 3D Highlights:", Value)
   end,
})

local DistanceToggle = ESPTab:CreateToggle({
   Name = "Distance",
   CurrentValue = true,
   Flag = "DistanceToggle",
   Callback = function(Value)
      DistanceESP = Value
      print("[ESP] Distance:", Value)
   end,
})

local BoxToggle = ESPTab:CreateToggle({
   Name = "Box ESP",
   CurrentValue = true,
   Flag = "BoxToggle",
   Callback = function(Value)
      BoxESP = Value
      print("[ESP] Box ESP:", Value)
   end,
})

local HealthBarToggle = ESPTab:CreateToggle({
   Name = "Health Bar",
   CurrentValue = true,
   Flag = "HealthBarToggle",
   Callback = function(Value)
      HealthBarESP = Value
      print("[ESP] Health Bar:", Value)
   end,
})

-- ESP Colors Section
local ESPColorsSection = ESPTab:CreateSection("ESP Colors")

local NameColorPicker = ESPTab:CreateColorPicker({
   Name = "Name Color",
   Color = Color3.fromRGB(255, 255, 255),
   Flag = "NameColorPicker",
   Callback = function(Value)
      NameColor = Value
      print("[ESP] Name Color:", Value)
   end
})

local HealthColorPicker = ESPTab:CreateColorPicker({
   Name = "Health Color",
   Color = Color3.fromRGB(0, 255, 0),
   Flag = "HealthColorPicker",
   Callback = function(Value)
      HealthColor = Value
      print("[ESP] Health Color:", Value)
   end
})

local TracersColorPicker = ESPTab:CreateColorPicker({
   Name = "Tracers Color",
   Color = Color3.fromRGB(255, 255, 0),
   Flag = "TracersColorPicker",
   Callback = function(Value)
      TracersColor = Value
      print("[ESP] Tracers Color:", Value)
   end
})

local HighlightsColorPicker = ESPTab:CreateColorPicker({
   Name = "3D Highlights Color",
   Color = Color3.fromRGB(255, 0, 0),
   Flag = "HighlightsColorPicker",
   Callback = function(Value)
      HighlightsColor = Value
      -- Обновляем цвет всех активных хайлайтов
      for player, esp in pairs(ESPObjects) do
          if esp.Highlight and esp.Highlight.Enabled then
              esp.Highlight.FillColor = HighlightsColor
          end
      end
      print("[ESP] 3D Highlights Color:", Value)
   end
})

local DistanceColorPicker = ESPTab:CreateColorPicker({
   Name = "Distance Color",
   Color = Color3.fromRGB(128, 128, 255),
   Flag = "DistanceColorPicker",
   Callback = function(Value)
      DistanceColor = Value
      print("[ESP] Distance Color:", Value)
   end
})

local BoxColorPicker = ESPTab:CreateColorPicker({
   Name = "Box Color",
   Color = Color3.fromRGB(255, 128, 0),
   Flag = "BoxColorPicker",
   Callback = function(Value)
      BoxColor = Value
      print("[ESP] Box Color:", Value)
   end
})

local HealthBarColorPicker = ESPTab:CreateColorPicker({
   Name = "Health Bar Color",
   Color = Color3.fromRGB(0, 255, 0),
   Flag = "HealthBarColorPicker",
   Callback = function(Value)
      HealthBarColor = Value
      print("[ESP] Health Bar Color:", Value)
   end
})

-- Blatant Tab
local VisualSection = BlatantTab:CreateSection("Visual")

local FullbrightToggle = BlatantTab:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Flag = "FullbrightToggle",
   Callback = function(Value)
      FullbrightEnabled = Value
      if Value then
          Lighting.GlobalShadows = false
          Lighting.Brightness = 2
          Lighting.ClockTime = 14
      else
          Lighting.GlobalShadows = true
          Lighting.Brightness = 1
          Lighting.ClockTime = 14
      end
      print("[Blatant] Fullbright:", Value)
   end,
})

local ThirdPersonToggle = BlatantTab:CreateToggle({
   Name = "Third Person",
   CurrentValue = false,
   Flag = "ThirdPersonToggle",
   Callback = function(Value)
      ThirdPersonEnabled = Value
      if Value then
          Camera.CameraType = Enum.CameraType.Scriptable
          -- Position camera behind player
          if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
              Camera.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 10)
          end
      else
          Camera.CameraType = Enum.CameraType.Custom
      end
      print("[Blatant] Third Person:", Value)
   end,
})

local MovementSection = BlatantTab:CreateSection("Movement")

local SpeedhackToggle = BlatantTab:CreateToggle({
   Name = "Speedhack",
   CurrentValue = false,
   Flag = "SpeedhackToggle",
   Callback = function(Value)
      SpeedhackEnabled = Value
      print("[Blatant] Speedhack:", Value)
   end,
})

local SpeedhackStudsSlider = BlatantTab:CreateSlider({
   Name = "Speedhack Studs",
   Range = {1, 5},
   Increment = 1,
   Suffix = "studs",
   CurrentValue = 3,
   Flag = "SpeedhackStudsSlider",
   Callback = function(Value)
      SpeedhackStuds = Value
      print("[Blatant] Speedhack Studs:", Value)
   end,
})

local SpeedhackDelaySlider = BlatantTab:CreateSlider({
   Name = "Speedhack Delay",
   Range = {0.1, 1},
   Increment = 0.1,
   Suffix = "sec",
   CurrentValue = 0.3,
   Flag = "SpeedhackDelaySlider",
   Callback = function(Value)
      SpeedhackDelay = Value
      print("[Blatant] Speedhack Delay:", Value)
   end,
})

local TeleportSection = BlatantTab:CreateSection("Teleport")

local TeleportHackToggle = BlatantTab:CreateToggle({
   Name = "Teleport Hack",
   CurrentValue = false,
   Flag = "TeleportHackToggle",
   Callback = function(Value)
      TeleportHackEnabled = Value
      print("[Blatant] Teleport Hack:", Value)
   end,
})

local TeleportDistanceSlider = BlatantTab:CreateSlider({
   Name = "Teleport Distance",
   Range = {10, 50},
   Increment = 5,
   Suffix = "studs",
   CurrentValue = 30,
   Flag = "TeleportDistanceSlider",
   Callback = function(Value)
      TeleportDistance = Value
      print("[Blatant] Teleport Distance:", Value)
   end,
})

local AttachToggle = BlatantTab:CreateToggle({
   Name = "Attach to Nearest Player",
   CurrentValue = false,
   Flag = "AttachToggle",
   Callback = function(Value)
      AttachEnabled = Value
      print("[Blatant] Attach:", Value)
   end,
})

local AutoAttachToggle = BlatantTab:CreateToggle({
   Name = "Auto Attach (Every 0.1s)",
   CurrentValue = false,
   Flag = "AutoAttachToggle",
   Callback = function(Value)
      AutoAttachEnabled = Value
      if Value then
          StartAutoAttach()
      else
          StopAutoAttach()
      end
      print("[Blatant] Auto Attach:", Value)
   end,
})

-- Settings Tab
local UISection = SettingsTab:CreateSection("UI Settings")

SettingsTab:CreateToggle({
   Name = "Enable GUI Movement",
   CurrentValue = true,
   Flag = "GUIMovementToggle",
   Callback = function(Value)
      GuiMovementEnabled = Value
      print("[UI] GUI Movement:", Value)
   end,
})

SettingsTab:CreateButton({
   Name = "Unload UI",
   Callback = function()
      Rayfield:Destroy()
   end,
})

-- ESP Functions
local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local ESP = {
        NameLabel = Drawing.new("Text"),
        HealthLabel = Drawing.new("Text"),
        Tracer = Drawing.new("Line"),
        Box = Drawing.new("Square"),
        HealthBar = Drawing.new("Square"),
        HealthBarBackground = Drawing.new("Square"),
        Highlight = Instance.new("Highlight")
    }
    
    -- Initialize all ESP elements as invisible
    ESP.NameLabel.Visible = false
    ESP.HealthLabel.Visible = false
    ESP.Tracer.Visible = false
    ESP.Box.Visible = false
    ESP.HealthBar.Visible = false
    ESP.HealthBarBackground.Visible = false
    
    -- Set default properties
    ESP.NameLabel.Size = 14
    ESP.HealthLabel.Size = 14
    ESP.Box.Thickness = 2
    ESP.Tracer.Thickness = 1
    ESP.HealthBar.Thickness = 1
    ESP.HealthBarBackground.Thickness = 1
    
    -- Set default colors
    ESP.NameLabel.Color = NameColor
    ESP.HealthLabel.Color = HealthColor
    ESP.Tracer.Color = TracersColor
    ESP.Box.Color = BoxColor
    ESP.HealthBar.Color = HealthBarColor
    ESP.HealthBarBackground.Color = Color3.new(0, 0, 0)
    
    -- Настройка 3D Highlight для всего игрока
    if ESP.Highlight then
        ESP.Highlight.Enabled = false
        ESP.Highlight.FillColor = HighlightsColor
        ESP.Highlight.OutlineColor = Color3.new(1, 1, 1)
        ESP.Highlight.FillTransparency = 0.3  -- Полупрозрачный
        ESP.Highlight.OutlineTransparency = 0
        ESP.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        ESP.Highlight.Parent = Workspace
    end
    
    ESPObjects[player] = ESP
end

local function UpdateESPVisibility()
    for player, esp in pairs(ESPObjects) do
        local visible = ESPEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        
        if esp.NameLabel then
            esp.NameLabel.Visible = visible and NameESP
        end
        if esp.HealthLabel then
            esp.HealthLabel.Visible = visible and HealthESP
        end
        if esp.Tracer then
            esp.Tracer.Visible = visible and TracersESP
        end
        if esp.Box then
            esp.Box.Visible = visible and BoxESP
        end
        if esp.HealthBar then
            esp.HealthBar.Visible = visible and HealthBarESP
        end
        if esp.HealthBarBackground then
            esp.HealthBarBackground.Visible = visible and HealthBarESP
        end
        if esp.Highlight then
            esp.Highlight.Enabled = visible and HighlightsESP
            if visible and player.Character then
                esp.Highlight.Adornee = player.Character  -- Весь персонаж
                esp.Highlight.FillColor = HighlightsColor
            else
                esp.Highlight.Adornee = nil
            end
        end
    end
end

local function UpdateESP()
    for player, esp in pairs(ESPObjects) do
        if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            continue
        end
        
        local character = player.Character
        local rootPart = character.HumanoidRootPart
        local head = character:FindFirstChild("Head")
        local humanoid = character:FindFirstChild("Humanoid")
        
        if not head then continue end
        
        local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        
        if onScreen then
            -- Update colors
            esp.NameLabel.Color = NameColor
            esp.HealthLabel.Color = HealthColor
            esp.Tracer.Color = TracersColor
            esp.Box.Color = BoxColor
            esp.HealthBar.Color = HealthBarColor
            if esp.Highlight then
                esp.Highlight.FillColor = HighlightsColor
            end
            
            -- Name ESP
            if NameESP and esp.NameLabel then
                esp.NameLabel.Visible = ESPEnabled
                esp.NameLabel.Text = player.Name
                esp.NameLabel.Position = Vector2.new(screenPos.X, screenPos.Y - 50)
            end
            
            -- Health ESP
            if HealthESP and humanoid and esp.HealthLabel then
                esp.HealthLabel.Visible = ESPEnabled
                esp.HealthLabel.Text = "HP: " .. math.floor(humanoid.Health)
                esp.HealthLabel.Position = Vector2.new(screenPos.X, screenPos.Y - 35)
            end
            
            -- Distance ESP
            if DistanceESP and humanoid and esp.HealthLabel then
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude
                esp.HealthLabel.Text = "HP: " .. math.floor(humanoid.Health) .. " | " .. math.floor(distance) .. "m"
            end
            
            -- Tracers
            if TracersESP and esp.Tracer then
                esp.Tracer.Visible = ESPEnabled
                esp.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                esp.Tracer.To = Vector2.new(screenPos.X, screenPos.Y)
            end
            
            -- Box ESP
            if BoxESP and esp.Box then
                esp.Box.Visible = ESPEnabled
                esp.Box.Size = Vector2.new(50, 80)
                esp.Box.Position = Vector2.new(screenPos.X - 25, screenPos.Y - 40)
            end
            
            -- Health Bar
            if HealthBarESP and humanoid and esp.HealthBar and esp.HealthBarBackground then
                local healthPercent = humanoid.Health / humanoid.MaxHealth
                esp.HealthBarBackground.Visible = ESPEnabled
                esp.HealthBar.Visible = ESPEnabled
                
                esp.HealthBarBackground.Size = Vector2.new(4, 60)
                esp.HealthBarBackground.Position = Vector2.new(screenPos.X - 35, screenPos.Y - 30)
                
                esp.HealthBar.Size = Vector2.new(2, 56 * healthPercent)
                esp.HealthBar.Position = Vector2.new(screenPos.X - 34, screenPos.Y - 28 + (56 * (1 - healthPercent)))
            end
        else
            -- Hide all ESP if off screen
            if esp.NameLabel then esp.NameLabel.Visible = false end
            if esp.HealthLabel then esp.HealthLabel.Visible = false end
            if esp.Tracer then esp.Tracer.Visible = false end
            if esp.Box then esp.Box.Visible = false end
            if esp.HealthBar then esp.HealthBar.Visible = false end
            if esp.HealthBarBackground then esp.HealthBarBackground.Visible = false end
        end
    end
end

-- Aimbot Functions
local function FindBestTarget()
    local bestTarget = nil
    local closestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if TeamCheck and player.Team and LocalPlayer.Team and player.Team == LocalPlayer.Team then continue end
        
        local character = player.Character
        if not character then continue end
        
        local humanoid = character:FindFirstChild("Humanoid")
        local head = character:FindFirstChild("Head")
        
        if not humanoid or humanoid.Health <= 0 or not head then continue end
        
        local screenPoint, onScreen = Camera:WorldToViewportPoint(head.Position)
        if not onScreen then continue end
        
        local distance = (head.Position - Camera.CFrame.Position).Magnitude
        
        if distance < closestDistance then
            if WallCheck then
                local raycastParams = RaycastParams.new()
                raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, character}
                
                local raycastResult = Workspace:Raycast(Camera.CFrame.Position, (head.Position - Camera.CFrame.Position).Unit * distance, raycastParams)
                
                if not raycastResult or raycastResult.Instance:IsDescendantOf(character) then
                    bestTarget = head
                    closestDistance = distance
                end
            else
                bestTarget = head
                closestDistance = distance
            end
        end
    end
    
    return bestTarget
end

-- Function to find nearest player
local function FindNearestPlayer()
    local nearestPlayer = nil
    local closestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if not player.Character then continue end
        
        local character = player.Character
        local humanoid = character:FindFirstChild("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        
        if not humanoid or humanoid.Health <= 0 or not rootPart then continue end
        
        local distance = (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        
        if distance < closestDistance then
            nearestPlayer = player
            closestDistance = distance
        end
    end
    
    return nearestPlayer
end

-- Toggle Aimbot Function
local function ToggleAimbot()
    if not AimbotEnabled then return end
    
    if AimbotActive then
        -- Deactivate aimbot
        AimbotActive = false
        CurrentTarget = nil
        print("[Aimbot] Deactivated")
        Rayfield:Notify({
            Title = "Aimbot",
            Content = "Aimbot Deactivated",
            Duration = 2,
            Image = 4483362458,
        })
    else
        -- Activate aimbot
        AimbotActive = true
        local target = FindBestTarget()
        if target then
            CurrentTarget = target
            print("[Aimbot] Activated - Target:", target.Parent.Name)
            Rayfield:Notify({
                Title = "Aimbot",
                Content = "Target locked: " .. target.Parent.Name,
                Duration = 3,
                Image = 4483362458,
            })
            
            -- Aimbot loop while active
            task.spawn(function()
                while AimbotActive and AimbotEnabled and target and target.Parent do
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Position)
                    task.wait()
                end
            end)
        else
            print("[Aimbot] No target found")
            Rayfield:Notify({
                Title = "Aimbot",
                Content = "No target found",
                Duration = 2,
                Image = 4483362458,
            })
            AimbotActive = false
        end
    end
end

-- Auto Attach Functions (к ближайшему игроку)
local function StartAutoAttach()
    AutoAttachLoop = task.spawn(function()
        while AutoAttachEnabled do
            local nearestPlayer = FindNearestPlayer()
            if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local targetRoot = nearestPlayer.Character.HumanoidRootPart
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local myRoot = LocalPlayer.Character.HumanoidRootPart
                    
                    -- Teleport behind the nearest player every 0.1 seconds
                    local offset = targetRoot.CFrame.LookVector * -5
                    local newPosition = targetRoot.Position + offset + Vector3.new(0, 3, 0)
                    
                    myRoot.CFrame = CFrame.new(newPosition)
                    AutoAttachTarget = nearestPlayer
                end
            else
                AutoAttachTarget = nil
            end
            task.wait(0.1) -- Teleport every 0.1 seconds
        end
    end)
end

local function StopAutoAttach()
    if AutoAttachLoop then
        task.cancel(AutoAttachLoop)
        AutoAttachLoop = nil
    end
    AutoAttachTarget = nil
end

-- Auto Clicker Functions
local function IsEnemy(player)
    -- Check if player is in different team/group
    if player.Team and LocalPlayer.Team then
        return player.Team ~= LocalPlayer.Team
    end
    
    -- Check for SCP groups or other team systems
    local playerGroup = player:GetRankInGroup(9999999) -- Replace with actual group ID if needed
    local myGroup = LocalPlayer:GetRankInGroup(9999999) -- Replace with actual group ID if needed
    
    -- If both are in SCP group or same team, they are not enemies
    if playerGroup > 0 and myGroup > 0 then
        return false
    end
    
    -- Default: anyone not in same team is enemy
    return true
end

local function AutoClick()
    if not AutoClickerEnabled then return end
    
    local targetPlayer = FindNearestPlayer()
    if targetPlayer and IsEnemy(targetPlayer) then
        -- Simulate left mouse click
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.05)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        print("[AutoClicker] Auto clicked enemy:", targetPlayer.Name)
    end
end

-- Aimbot on Q key (Toggle)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- Aimbot on Q key (toggle)
    if input.KeyCode == Enum.KeyCode.Q and AimbotEnabled then
        ToggleAimbot()
    end
    
    -- Teleport Hack on T key
    if input.KeyCode == Enum.KeyCode.T and TeleportHackEnabled then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = LocalPlayer.Character.HumanoidRootPart
            local newPosition = rootPart.Position + rootPart.CFrame.LookVector * TeleportDistance
            rootPart.CFrame = CFrame.new(newPosition)
            print("[Blatant] Teleported forward", TeleportDistance, "studs")
        end
    end
    
    -- Attach function on F key - Teleport to nearest player
    if input.KeyCode == Enum.KeyCode.F and AttachEnabled then
        local nearestPlayer = FindNearestPlayer()
        if nearestPlayer and nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetRoot = nearestPlayer.Character.HumanoidRootPart
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local myRoot = LocalPlayer.Character.HumanoidRootPart
                
                -- Teleport behind the nearest player
                local offset = targetRoot.CFrame.LookVector * -5
                local newPosition = targetRoot.Position + offset + Vector3.new(0, 3, 0)
                
                myRoot.CFrame = CFrame.new(newPosition)
                print("[Blatant] Attached to nearest player:", nearestPlayer.Name)
                
                Rayfield:Notify({
                    Title = "Attach",
                    Content = "Teleported to " .. nearestPlayer.Name,
                    Duration = 3,
                    Image = 4483362458,
                })
            end
        else
            print("[Blatant] No player found nearby")
            Rayfield:Notify({
                Title = "Attach",
                Content = "No player found nearby",
                Duration = 3,
                Image = 4483362458,
            })
        end
    end
end)

-- Auto Clicker loop
task.spawn(function()
    while true do
        if AutoClickerEnabled then
            AutoClick()
        end
        task.wait(0.1) -- Check every 0.1 seconds
    end
end)

-- Blatant Functions
-- Speedhack
task.spawn(function()
    while true do
        if SpeedhackEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = LocalPlayer.Character.HumanoidRootPart
            local newPosition = rootPart.Position + rootPart.CFrame.LookVector * SpeedhackStuds
            rootPart.CFrame = CFrame.new(newPosition)
        end
        task.wait(SpeedhackDelay)
    end
end)

-- Third Person Camera Update
task.spawn(function()
    while true do
        if ThirdPersonEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = LocalPlayer.Character.HumanoidRootPart
            Camera.CFrame = rootPart.CFrame * CFrame.new(0, 2, 8)
        end
        task.wait(0.1)
    end
end)

-- Initialize ESP for existing players
for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end

-- Handle new players
Players.PlayerAdded:Connect(function(player)
    CreateESP(player)
end)

-- Handle player leaving
Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        for _, drawing in pairs(ESPObjects[player]) do
            if typeof(drawing) == "Drawing" then
                drawing:Remove()
            elseif typeof(drawing) == "Instance" then
                drawing:Destroy()
            end
        end
        ESPObjects[player] = nil
    end
end)

-- ESP update loop
RunService.RenderStepped:Connect(UpdateESP)
-- Добавь эти переменные в раздел ESP Variables после существующих
local ModelESP = false
local WeaponModels = {
    ["Glock 17"] = true,
    ["USP"] = true,
    ["AK"] = true,
    ["Flashlight"] = true
}

local KeycardModels = {
    ["MTF Cadet Keycard"] = true,
    ["MTF Lieutenant Keycard"] = true,
    ["MTF Commander Keycard"] = true,
    ["Facility Guard Keycard"] = true,
    ["Scientist Keycard"] = true,
    ["Major Scientist Keycard"] = true
}

local ItemModels = {
    ["Medkit"] = true,
    ["Crowbar"] = true,
    ["Bat"] = true
}

local ModelColors = {
    Weapons = Color3.fromRGB(255, 50, 50),     -- Красный для оружия
    Keycards = Color3.fromRGB(50, 150, 255),   -- Синий для ключ-карт
    Items = Color3.fromRGB(50, 255, 50)        -- Зеленый для предметов
}

local ModelESPObjects = {}

-- Добавь этот toggle в ESP Tab после существующих toggle'ов
local ModelESPToggle = ESPTab:CreateToggle({
   Name = "Model ESP",
   CurrentValue = false,
   Flag = "ModelESPToggle",
   Callback = function(Value)
      ModelESP = Value
      UpdateModelESPVisibility()
      print("[ESP] Model ESP:", Value)
   end,
})

-- Добавь ColorPickers для цветов моделей в ESP Colors Section
local WeaponColorPicker = ESPTab:CreateColorPicker({
   Name = "Weapon Color",
   Color = Color3.fromRGB(255, 50, 50),
   Flag = "WeaponColorPicker",
   Callback = function(Value)
      ModelColors.Weapons = Value
      UpdateModelESPColors()
      print("[ESP] Weapon Color:", Value)
   end
})

local KeycardColorPicker = ESPTab:CreateColorPicker({
   Name = "Keycard Color",
   Color = Color3.fromRGB(50, 150, 255),
   Flag = "KeycardColorPicker",
   Callback = function(Value)
      ModelColors.Keycards = Value
      UpdateModelESPColors()
      print("[ESP] Keycard Color:", Value)
   end
})

local ItemColorPicker = ESPTab:CreateColorPicker({
   Name = "Item Color",
   Color = Color3.fromRGB(50, 255, 50),
   Flag = "ItemColorPicker",
   Callback = function(Value)
      ModelColors.Items = Value
      UpdateModelESPColors()
      print("[ESP] Item Color:", Value)
   end
})

-- Функции для Model ESP
local function GetModelType(modelName)
    if WeaponModels[modelName] then
        return "Weapons"
    elseif KeycardModels[modelName] then
        return "Keycards"
    elseif ItemModels[modelName] then
        return "Items"
    end
    return nil
end

local function GetModelColor(modelType)
    return ModelColors[modelType] or Color3.fromRGB(255, 255, 255)
end

local function CreateModelESP(model)
    local modelName = model.Name
    local modelType = GetModelType(modelName)
    
    if not modelType then return end
    
    local ESP = {
        Label = Drawing.new("Text"),
        Highlight = Instance.new("Highlight"),
        Model = model
    }
    
    -- Initialize ESP elements
    ESP.Label.Visible = false
    ESP.Label.Size = 12
    ESP.Label.Color = GetModelColor(modelType)
    ESP.Label.Text = modelName
    
    -- Setup 3D Highlight
    if ESP.Highlight then
        ESP.Highlight.Enabled = false
        ESP.Highlight.FillColor = GetModelColor(modelType)
        ESP.Highlight.OutlineColor = Color3.new(1, 1, 1)
        ESP.Highlight.FillTransparency = 0.4
        ESP.Highlight.OutlineTransparency = 0
        ESP.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        ESP.Highlight.Parent = Workspace
    end
    
    ModelESPObjects[model] = ESP
end

local function UpdateModelESPVisibility()
    for model, esp in pairs(ModelESPObjects) do
        local visible = ModelESP and model:IsDescendantOf(Workspace)
        
        if esp.Label then
            esp.Label.Visible = visible
        end
        if esp.Highlight then
            esp.Highlight.Enabled = visible
            if visible then
                esp.Highlight.Adornee = model
                esp.Highlight.FillColor = GetModelColor(GetModelType(model.Name))
            else
                esp.Highlight.Adornee = nil
            end
        end
    end
end

local function UpdateModelESPColors()
    for model, esp in pairs(ModelESPObjects) do
        local modelType = GetModelType(model.Name)
        if modelType then
            local color = GetModelColor(modelType)
            if esp.Label then
                esp.Label.Color = color
            end
            if esp.Highlight and esp.Highlight.Enabled then
                esp.Highlight.FillColor = color
            end
        end
    end
end

local function UpdateModelESP()
    for model, esp in pairs(ModelESPObjects) do
        if not model or not model:IsDescendantOf(Workspace) then
            if esp.Label then esp.Label.Visible = false end
            if esp.Highlight then esp.Highlight.Enabled = false end
            continue
        end
        
        local primaryPart = model:FindFirstChild("Handle") or model:FindFirstChild("PrimaryPart") or model:FindFirstChildWhichIsA("BasePart")
        
        if primaryPart then
            local screenPos, onScreen = Camera:WorldToViewportPoint(primaryPart.Position)
            
            if onScreen then
                local modelType = GetModelType(model.Name)
                local color = GetModelColor(modelType)
                
                -- Update label
                if esp.Label then
                    esp.Label.Visible = ModelESP
                    esp.Label.Color = color
                    esp.Label.Position = Vector2.new(screenPos.X, screenPos.Y)
                    esp.Label.Text = model.Name
                end
                
                -- Update highlight
                if esp.Highlight then
                    esp.Highlight.Enabled = ModelESP
                    esp.Highlight.FillColor = color
                end
            else
                if esp.Label then esp.Label.Visible = false end
                if esp.Highlight then esp.Highlight.Enabled = false end
            end
        else
            if esp.Label then esp.Label.Visible = false end
            if esp.Highlight then esp.Highlight.Enabled = false end
        end
    end
end

-- Функция для поиска и создания ESP для существующих моделей
local function InitializeModelESP()
    -- Ищем все модели в workspace
    for _, model in pairs(Workspace:GetDescendants()) do
        if model:IsA("Model") then
            local modelType = GetModelType(model.Name)
            if modelType and not ModelESPObjects[model] then
                CreateModelESP(model)
            end
        end
    end
end

-- Обработчик для новых моделей
Workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("Model") then
        local modelType = GetModelType(descendant.Name)
        if modelType and not ModelESPObjects[descendant] then
            CreateModelESP(descendant)
        end
    end
end)

-- Обработчик для удаленных моделей
Workspace.DescendantRemoving:Connect(function(descendant)
    if ModelESPObjects[descendant] then
        local esp = ModelESPObjects[descendant]
        if esp.Label then esp.Label:Remove() end
        if esp.Highlight then esp.Highlight:Destroy() end
        ModelESPObjects[descendant] = nil
    end
end)

-- Добавь вызов инициализации в конец скрипта
-- После создания ESP для игроков добавь:
InitializeModelESP()

-- И добавь обновление Model ESP в главный цикл
task.spawn(function()
    while true do
        UpdateModelESP()
        task.wait(0.1)
    end
end)

Rayfield:Notify({
   Title = "Likegenm Scripts",
   Content = "Loaded successfully!\nAimbot: Press Q (Toggle)\nTeleport: T\nAttach to Nearest: F\nAuto Attach: Toggle\nAuto Clicker: Toggle\n3D Highlights: Enabled\nMove GUI: Click and drag",
   Duration = 8,
   Image = 4483362458,
})
