local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function createHighlight(player)
    if player.Character and not player.Character:FindFirstChild("ESPHighlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.6
        highlight.OutlineTransparency = 0
        highlight.Adornee = player.Character
        highlight.Parent = player.Character
    end
end

local function checkVisibilityFromHRP(player)
    if not player.Character or not LocalPlayer.Character then return false end
    
    local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local enemyHRP = player.Character:FindFirstChild("HumanoidRootPart")
    
    if not myHRP or not enemyHRP then return false end

    local direction = (enemyHRP.Position - myHRP.Position)
    local ray = Ray.new(myHRP.Position, direction)

    local ignoreList = {LocalPlayer.Character, player.Character}

    local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)

    return not hit
end

local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if player.Character:FindFirstChild("Humanoid") then
                local humanoid = player.Character.Humanoid
                local highlight = player.Character:FindFirstChild("ESPHighlight")
                
                if highlight then
                    if humanoid.Health > 0 then
                        if checkVisibilityFromHRP(player) then
                            highlight.FillColor = Color3.fromRGB(0, 255, 0)
                        else
                            highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        end
                    else
                        highlight.FillColor = Color3.fromRGB(120, 0, 0)
                    end
                end
            end
        end
    end
end

local function setupESP(player)
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            createHighlight(player)
        end)
        
        if player.Character then
            task.wait(0.5)
            createHighlight(player)
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    setupESP(player)
end

Players.PlayerAdded:Connect(function(player)
    setupESP(player)
end)

RunService.RenderStepped:Connect(updateESP)




--[[
Исправленный скрипт потом проверю и выложу возможно
```lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function createHighlight(player)
    if player.Character and not player.Character:FindFirstChild("ESPHighlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.6
        highlight.OutlineTransparency = 0
        highlight.Adornee = player.Character
        highlight.Parent = player.Character
    end
end

local function checkVisibilityFromHRP(player)
    if not player.Character or not LocalPlayer.Character then return false end
    
    local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local enemyHRP = player.Character:FindFirstChild("HumanoidRootPart")
    
    if not myHRP or not enemyHRP then return false end

    local direction = (enemyHRP.Position - myHRP.Position)
    local ray = Ray.new(myHRP.Position, direction)

    local ignoreList = {LocalPlayer.Character, player.Character}

    local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)

    return not hit
end

local function isPlayerNearDesk(player)
    if not player.Character then return false end
    
    local enemyHRP = player.Character:FindFirstChild("HumanoidRootPart")
    if not enemyHRP then return false end
    
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj.Name:find("Desk") or obj.Name:find("Парта") or obj:IsA("Seat") then
            if obj.PrimaryPart then
                if (enemyHRP.Position - obj.PrimaryPart.Position).Magnitude < 10 then
                    return true
                end
            elseif obj:IsA("BasePart") then
                if (enemyHRP.Position - obj.Position).Magnitude < 10 then
                    return true
                end
            end
        end
    end
    return false
end

local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if player.Character:FindFirstChild("Humanoid") then
                local humanoid = player.Character.Humanoid
                local highlight = player.Character:FindFirstChild("ESPHighlight")
                
                if highlight then
                    if humanoid.Health > 0 then
                        if isPlayerNearDesk(player) then
                            highlight.FillColor = Color3.fromRGB(0, 255, 0)
                        elseif checkVisibilityFromHRP(player) then
                            highlight.FillColor = Color3.fromRGB(0, 0, 255)
                        else
                            highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        end
                    else
                        highlight.FillColor = Color3.fromRGB(120, 0, 0)
                    end
                end
            end
        end
    end
end

local function setupESP(player)
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            createHighlight(player)
        end)
        
        if player.Character then
            task.wait(0.5)
            createHighlight(player)
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    setupESP(player)
end

Players.PlayerAdded:Connect(function(player)
    setupESP(player)
end)

RunService.RenderStepped:Connect(updateESP)
```
]]
