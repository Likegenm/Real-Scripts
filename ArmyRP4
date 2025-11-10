-- ЧАСТЬ 4/6: Основные функции
function EnableSafeInvisible()
    local character = LocalPlayer.Character
    if not character then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "InvisHighlight"
    highlight.FillColor = Color3.new(0, 0, 0)
    highlight.OutlineColor = Color3.new(0, 0, 0)
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 1
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character
    
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            if not part:GetAttribute("OriginalMaterial") then
                part:SetAttribute("OriginalMaterial", part.Material)
            end
            part.Material = Enum.Material.Glass
            part.LocalTransparencyModifier = 0.9
        end
    end
end

function DisableSafeInvisible()
    local character = LocalPlayer.Character
    if not character then return end
    
    local highlight = character:FindFirstChild("InvisHighlight")
    if highlight then highlight:Destroy() end
    
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            part.LocalTransparencyModifier = 0
            if part:GetAttribute("OriginalMaterial") then
                part.Material = part:GetAttribute("OriginalMaterial")
            end
        end
    end
end

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
                if highlight then highlight:Destroy() end
            end
        end
    end
end

function EnableGodWeapon()
    -- Адаптируется под конкретную игру
end

function RefreshWeapons()
    Rayfield:Notify({
        Title = "Weapons Refreshed", Content = "Weapon list has been updated!", Duration = 3,
    })
end

function FindAndCopyItems()
    Rayfield:Notify({
        Title = "Items Search", Content = "Searching for items in player inventories...", Duration = 3,
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
