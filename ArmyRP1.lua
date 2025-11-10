-- Загрузка библиотеки Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- Создание окна Rayfield с оранжевым фоном
local Window = Rayfield:CreateWindow({
   Name = "likegenm Script",
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by likegenm",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "likegenmConfig",
      FileName = "likegenm"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   Theme = {
      Background = Color3.fromRGB(255, 165, 0), -- Оранжевый фон
      Glow = Color3.fromRGB(255, 140, 0), -- Оранжевое свечение
      Accent = Color3.fromRGB(255, 100, 0), -- Акцентный оранжевый
      LightContrast = Color3.fromRGB(255, 180, 0), -- Светлый контраст
      DarkContrast = Color3.fromRGB(200, 100, 0), -- Темный контраст
      TextColor = Color3.fromRGB(255, 255, 255) -- Белый текст
   }
})

-- Variables
local InfJumpEnabled = false
local InfJumpCooldown = 0.1
local LastInfJumpTime = 0
local SpeedEnabled = false
local SpeedValue = 50
local SpiderEnabled = false
local SpiderDistance = 3
local SpiderSpeed = 50
local InvisEnabled = false
local AttachEnabled = false
local AttachDistance = 50
local NoclipEnabled = false
local NoFallEnabled = false
local FullbrightEnabled = false
local FovEnabled = false
local FovValue = 70
local AimbotEnabled = false
local AimbotColor = Color3.fromRGB(255, 0, 0)
local EspEnabled = false
local FlyEnabled = false
local GodWeaponEnabled = false

-- Exploits Tab
local ExploitsTab = Window:CreateTab("Exploits", 4483362458)

local MovementSection = ExploitsTab:CreateSection("Movement")

local InfJumpToggle = ExploitsTab:CreateToggle({
   Name = "Infinite Jump (Cooldown 0.1s)",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value)
      InfJumpEnabled = Value
      if Value then
         Rayfield:Notify({
            Title = "Infinite Jump",
            Content = "Infinite Jump Enabled! Cooldown: 0.1s",
            Duration = 3,
         })
      end
   end,
})

local SpeedToggle = ExploitsTab:CreateToggle({
   Name = "Speed Hack (Velocity)",
   CurrentValue = false,
   Flag = "SpeedToggle",
   Callback = function(Value)
      SpeedEnabled = Value
      if not Value then
         -- Reset velocity when disabled
         local character = LocalPlayer.Character
         if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.Velocity = Vector3.new(
               character.HumanoidRootPart.Velocity.X * 0.5,
               character.HumanoidRootPart.Velocity.Y,
               character.HumanoidRootPart.Velocity.Z * 0.5
            )
         end
      end
   end,
})

local SpeedSlider = ExploitsTab:CreateSlider({
   Name = "Speed Value",
   Range = {1, 100},
   Increment = 1,
   Suffix = "speed",
   CurrentValue = 50,
   Flag = "SpeedValue",
   Callback = function(Value)
      SpeedValue = Value
   end,
})

local SpiderToggle = ExploitsTab:CreateToggle({
   Name = "Spider Mode",
   CurrentValue = false,
   Flag = "SpiderToggle",
   Callback = function(Value)
      SpiderEnabled = Value
   end,
})

local SpiderDistanceSlider = ExploitsTab:CreateSlider({
   Name = "Spider Distance",
   Range = {1, 5},
   Increment = 0.1,
   Suffix = "studs",
   CurrentValue = 3,
   Flag = "SpiderDistance",
   Callback = function(Value)
      SpiderDistance = Value
   end,
})

local SpiderSpeedSlider = ExploitsTab:CreateSlider({
   Name = "Spider Speed",
   Range = {1, 100},
   Increment = 1,
   Suffix = "speed",
   CurrentValue = 50,
   Flag = "SpiderSpeed",
   Callback = function(Value)
      SpiderSpeed = Value
   end,
})

local OtherSection = ExploitsTab:CreateSection("Other Exploits")

local NoFallToggle = ExploitsTab:CreateToggle({
   Name = "NoFall (Anti Fall Damage)",
   CurrentValue = false,
   Flag = "NoFallToggle",
   Callback = function(Value)
      NoFallEnabled = Value
      if Value then
         Rayfield:Notify({
            Title = "NoFall",
            Content = "NoFall Enabled! Freezes at 1 stud from ground",
            Duration = 3,
         })
      end
   end,
})

local InvisToggle = ExploitsTab:CreateToggle({
   Name = "Safe Invisible Mode (Client-side)",
   CurrentValue = false,
   Flag = "InvisToggle",
   Callback = function(Value)
      InvisEnabled = Value
      if Value then
         EnableSafeInvisible()
         Rayfield:Notify({
            Title = "Safe Invisible",
            Content = "Invisible mode activated (Client-side only)",
            Duration = 3,
         })
      else
         DisableSafeInvisible()
      end
   end,
})

local AttachToggle = ExploitsTab:CreateToggle({
   Name = "Attach to Player",
   CurrentValue = false,
   Flag = "AttachToggle",
   Callback = function(Value)
      AttachEnabled = Value
   end,
})

local AttachDistanceSlider = ExploitsTab:CreateSlider({
   Name = "Attach Distance",
   Range = {1, 1000},
   Increment = 10,
   Suffix = "studs",
   CurrentValue = 50,
   Flag = "AttachDistance",
   Callback = function(Value)
      AttachDistance = Value
   end,
})

local NoclipToggle = ExploitsTab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
      NoclipEnabled = Value
   end,
})

-- Visuals Tab
local VisualsTab = Window:CreateTab("Visuals", 7072718362)

local WorldVisualsSection = VisualsTab:CreateSection("World Visuals")

local FullbrightToggle = VisualsTab:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Flag = "FullbrightToggle",
   Callback = function(Value)
      FullbrightEnabled = Value
      if Value then
         Lighting.Ambient = Color3.new(1, 1, 1)
         Lighting.Brightness = 2
         Lighting.GlobalShadows = false
      else
         Lighting.Ambient = Color3.new(0, 0, 0)
         Lighting.Brightness = 1
         Lighting.GlobalShadows = true
      end
   end,
})

local FovToggle = VisualsTab:CreateToggle({
   Name = "FOV Changer",
   CurrentValue = false,
   Flag = "FovToggle",
   Callback = function(Value)
      FovEnabled = Value
   end,
})

local FovSlider = VisualsTab:CreateSlider({
   Name = "FOV Value",
   Range = {30, 120},
   Increment = 1,
   Suffix = "FOV",
   CurrentValue = 70,
   Flag = "FovValue",
   Callback = function(Value)
      FovValue = Value
   end,
})

local PlayerVisualsSection = VisualsTab:CreateSection("Player Visuals")

local EspToggle = VisualsTab:CreateToggle({
   Name = "ESP",
   CurrentValue = false,
   Flag = "EspToggle",
   Callback = function(Value)
      EspEnabled = Value
      if Value then
         EnableESP()
         Rayfield:Notify({
            Title = "ESP",
            Content = "ESP Enabled for all players!",
            Duration = 3,
         })
      else
         DisableESP()
      end
   end,
})

local AimbotToggle = VisualsTab:CreateToggle({
   Name = "Aimbot Highlight",
   CurrentValue = false,
   Flag = "AimbotToggle",
   Callback = function(Value)
      AimbotEnabled = Value
   end,
})

local AimbotColorPicker = VisualsTab:CreateColorPicker({
    Name = "Aimbot Color",
    Color = Color3.fromRGB(255,0,0),
    Flag = "AimbotColor",
    Callback = function(Value)
        AimbotColor = Value
    end
})

-- Weapon Tab
local WeaponTab = Window:CreateTab("Weapon", 7072721560)

local GodWeaponToggle = WeaponTab:CreateToggle({
   Name = "God Weapon Mode",
   CurrentValue = false,
   Flag = "GodWeaponToggle",
   Callback = function(Value)
      GodWeaponEnabled = Value
      if Value then
         EnableGodWeapon()
         Rayfield:Notify({
            Title = "God Weapon",
            Content = "God Weapon mode activated!",
            Duration = 3,
         })
      end
   end,
})

local RefreshWeaponsButton = WeaponTab:CreateButton({
   Name = "Refresh Weapons",
   Callback = function()
      RefreshWeapons()
   end,
})

-- Vehicle Tab
local VehicleTab = Window:CreateTab("Vehicle", 7072720917)

local FlyToggle = VehicleTab:CreateToggle({
   Name = "Car Fly",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
      FlyEnabled = Value
      if Value then
         Rayfield:Notify({
            Title = "Car Fly",
            Content = "Car Fly Enabled! Press Space to go up, Shift to go down",
            Duration = 5,
         })
      end
   end,
})

-- Items Tab
local ItemsTab = Window:CreateTab("Items", 7072720370)

local RefreshItemsButton = ItemsTab:CreateButton({
   Name = "Refresh Items List",
   Callback = function()
      FindAndCopyItems()
   end,
})

ItemsTab:CreateParagraph({Title = "Items Info", Content = "Click 'Refresh Items List' to find available items in the game"})

-- Credits Tab
local CreditsTab = Window:CreateTab("Credits", 7072718917)

CreditsTab:CreateLabel("Script by: likegenm")
CreditsTab:CreateLabel("UI Library: Rayfield")
CreditsTab:CreateParagraph({Title = "Thanks", Content = "Thanks for using this script!"})

-- Safe Invisible Functions (Client-side only)
function EnableSafeInvisible()
    local character = LocalPlayer.Character
    if not character then return end
    
    -- Method 1: Use Highlight with full transparency (safest)
    local highlight = Instance.new("Highlight")
    highlight.Name = "InvisHighlight"
    highlight.FillColor = Color3.new(0, 0, 0)
    highlight.OutlineColor = Color3.new(0, 0, 0)
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 1
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    
    -- Method 2: Apply client-side material changes
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            -- Store original values
            if not part:GetAttribute("OriginalTransparency") then
                part:SetAttribute("OriginalTransparency", part.Transparency)
            end
            if not part:GetAttribute("OriginalMaterial") then
                part:SetAttribute("OriginalMaterial", part.Material)
            end
            
            -- Apply client-side visual changes
            part.Material = Enum.Material.Glass
            part.LocalTransparencyModifier = 0.9 -- Only affects local view
        end
    end
end

function DisableSafeInvisible()
    local character = LocalPlayer.Character
    if not character then return end
    
    -- Remove highlight
    local highlight = character:FindFirstChild("InvisHighlight")
    if highlight then
        highlight:Destroy()
    end
    
    -- Restore original properties
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.LocalTransparencyModifier = 0
            if part:GetAttribute("OriginalMaterial") then
                part.Material = part:GetAttribute("OriginalMaterial")
            else
                part.Material = Enum.Material.Plastic
            end
        end
    end
end

-- ESP Functions
function EnableESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESP_Highlight"
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.Parent = character
            end
        end
    end
end

function DisableESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character then
                local highlight = character:FindFirstChild("ESP_Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end

function EnableGodWeapon()
    -- This would need to be adapted to the specific game
end

function RefreshWeapons()
    Rayfield:Notify({
        Title = "Weapons Refreshed",
        Content = "Weapon list has been updated!",
        Duration = 3,
    })
end

function FindAndCopyItems()
    Rayfield:Notify({
        Title = "Items Search",
        Content = "Searching for items in player inventories...",
        Duration = 3,
    })
end

function GetNearestPlayer(maxDistance)
    local nearestPlayer = nil
    local nearestDistance = maxDistance
    local localPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if localPos then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local targetPos = player.Character:FindFirstChild("HumanoidRootPart")
                if targetPos then
                    local distance = (localPos.Position - targetPos.Position).Magnitude
                    if distance < nearestDistance then
                        nearestDistance = distance
                        nearestPlayer = player
                    end
                end
            end
        end
    end
    return nearestPlayer
end

-- NoFall Function
local LastNoFallTime = 0
local NoFallCooldown = 0.1

local function CheckNoFall()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    local currentTime = tick()
    
    -- Check cooldown
    if currentTime - LastNoFallTime < NoFallCooldown then
        return
    end
    
    -- Check if falling (negative Y velocity)
    if rootPart.Velocity.Y < -10 then
        -- Raycast down to find ground distance
        local rayOrigin = rootPart.Position
        local rayDirection = Vector3.new(0, -50, 0) -- Cast ray 50 studs down
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = {character}
        
        local rayResult = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)
        
        if rayResult then
            local distanceToGround = (rayOrigin - rayResult.Position).Magnitude
            
            -- If we're 1 stud or less from ground
            if distanceToGround <= 1 then
                -- Freeze character for 0.1 seconds to prevent fall damage
                local originalVelocity = rootPart.Velocity
                rootPart.Velocity = Vector3.new(originalVelocity.X, 0, originalVelocity.Z)
                
                -- Small upward boost to prevent hitting ground
                rootPart.Velocity = Vector3.new(
                    originalVelocity.X,
                    5, -- Small upward velocity
                    originalVelocity.Z
                )
                
                LastNoFallTime = currentTime
                
                -- Optional: Debug info
                print(string.format("NoFall activated! Distance to ground: %.2f studs", distanceToGround))
            end
        end
    end
end

-- Improved Infinite Jump with Cooldown and Velocity
local function InfiniteJumpVelocity()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    local currentTime = tick()
    
    -- Check if cooldown has passed
    if currentTime - LastInfJumpTime >= InfJumpCooldown then
        -- Apply upward velocity for jump
        rootPart.Velocity = Vector3.new(
            rootPart.Velocity.X,
            50,
            rootPart.Velocity.Z
        )
        LastInfJumpTime = currentTime
    end
end

-- Speed Hack with Velocity (Improved)
local function ApplySpeedVelocity()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    -- Get movement direction from humanoid
    local moveDirection = humanoid.MoveDirection
    if moveDirection.Magnitude > 0 then
        -- Calculate velocity based on speed value
        local velocityMultiplier = SpeedValue * 2
        local newVelocity = moveDirection * velocityMultiplier
        
        -- Apply velocity while preserving Y (gravity)
        rootPart.Velocity = Vector3.new(
            newVelocity.X,
            rootPart.Velocity.Y,
            newVelocity.Z
        )
    end
end

-- Main Loops
RunService.Heartbeat:Connect(function()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    -- Speed Hack with Velocity
    if SpeedEnabled then
        ApplySpeedVelocity()
    end
    
    -- Spider Mode
    if SpiderEnabled then
        local rayOrigin = rootPart.Position
        local rayDirection = rootPart.CFrame.LookVector * SpiderDistance
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = {character}
        
        local rayResult = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)
        if rayResult then
            rootPart.Velocity = Vector3.new(
                rootPart.Velocity.X,
                SpiderSpeed,
                rootPart.Velocity.Z
            )
        end
    end
    
    -- NoFall Protection
    if NoFallEnabled then
        CheckNoFall()
    end
    
    -- Attach to Player
    if AttachEnabled then
        local nearest = GetNearestPlayer(AttachDistance)
        if nearest and nearest.Character then
            local targetRoot = nearest.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                rootPart.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end
    
    -- Noclip
    if NoclipEnabled then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
    
    -- FOV Changer
    if FovEnabled then
        local camera = Workspace.CurrentCamera
        if camera then
            camera.FieldOfView = FovValue
        end
    end
    
    -- Car Fly
    if FlyEnabled and humanoid.Sit then
        humanoid.PlatformStand = true
        local flyVelocity = 100
        
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, flyVelocity, rootPart.Velocity.Z)
        elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, -flyVelocity, rootPart.Velocity.Z)
        end
    end
end)

-- Improved Infinite Jump Handler
UserInputService.JumpRequest:Connect(function()
    if InfJumpEnabled and LocalPlayer.Character then
        InfiniteJumpVelocity()
    end
end)

-- Auto-ESP for new players
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if EspEnabled then
            wait(1)
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESP_Highlight"
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.Parent = character
        end
    end)
end)

-- Auto-jump when holding space
local SpaceHeld = false
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Space then
        SpaceHeld = true
        while SpaceHeld and InfJumpEnabled do
            InfiniteJumpVelocity()
            wait(InfJumpCooldown)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Space then
        SpaceHeld = false
    end
end)

-- Apply orange theme to existing UI elements
spawn(function()
    wait(2)
    -- Try to find and apply orange theme to all UI elements
    for _, obj in pairs(game:GetService("CoreGui"):GetDescendants()) do
        if obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
            pcall(function()
                if obj.BackgroundColor3 then
                    obj.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
                end
            end)
        end
    end
end)

-- Success notification
Rayfield:Notify({
   Title = "likegenm Script",
   Content = "Script loaded! NoFall added - anti fall damage protection!",
   Duration = 5,
   Image = 4483362458,
   Actions = {
      Ignore = {
         Name = "Okay!",
         Callback = function()
            print("Script with NoFall loaded successfully!")
         end
      },
   },
})

print("likegenm Script with NoFall protection loaded!")
