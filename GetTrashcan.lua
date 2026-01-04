local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

_G.Pos = nil
local trashcanIndex = 1
local trashcanCFrames = {}
local mainButtonActive = false
local cooldownTime = 35.1

local trashFolder = workspace:WaitForChild("Map"):WaitForChild("Trash")
for _, obj in pairs(trashFolder:GetChildren()) do
    if obj.Name == "Trashcan" then
        local actualTrashcan = obj:FindFirstChild("Trashcan")
        if actualTrashcan and actualTrashcan:IsA("BasePart") then
            table.insert(trashcanCFrames, {
                CFrame = actualTrashcan.CFrame,
                Object = actualTrashcan,
                LastVisited = 0
            })
        elseif obj:IsA("BasePart") then
            table.insert(trashcanCFrames, {
                CFrame = obj.CFrame,
                Object = obj,
                LastVisited = 0
            })
        end
    end
end

table.sort(trashcanCFrames, function(a, b)
    return a.CFrame.Position.X < b.CFrame.Position.X
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TrashcanGUI"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local dragButton = Instance.new("TextButton")
dragButton.Name = "DragButton"
dragButton.Size = UDim2.new(0, 180, 0, 60)
dragButton.Position = UDim2.new(0, 50, 0, 20)
dragButton.Text = "Custom Position"
dragButton.Font = Enum.Font.GothamBlack
dragButton.TextSize = 20
dragButton.TextColor3 = Color3.fromRGB(255, 255, 255)
dragButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
dragButton.BackgroundTransparency = 0.2
dragButton.BorderSizePixel = 0
dragButton.Parent = screenGui

local dragCorner = Instance.new("UICorner")
dragCorner.CornerRadius = UDim.new(0, 12)
dragCorner.Parent = dragButton

local dragStroke = Instance.new("UIStroke")
dragStroke.Color = Color3.fromRGB(120, 120, 180)
dragStroke.Thickness = 3
dragStroke.Parent = dragButton

local mainButton = Instance.new("TextButton")
mainButton.Name = "GetTrashcanButton"
mainButton.Size = UDim2.new(0, 150, 0, 50)
mainButton.Text = "Get Trashcan"
mainButton.Font = Enum.Font.GothamBold
mainButton.TextSize = 18
mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mainButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
mainButton.BackgroundTransparency = 0.3
mainButton.BorderSizePixel = 0
mainButton.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainButton

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(150, 150, 150)
mainStroke.Thickness = 2
mainStroke.Parent = mainButton

local nextButton = Instance.new("TextButton")
nextButton.Name = "NextButton"
nextButton.Size = UDim2.new(0, 100, 0, 40)
nextButton.Text = "Next"
nextButton.Font = Enum.Font.GothamBold
nextButton.TextSize = 16
nextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
nextButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
nextButton.BackgroundTransparency = 0.3
nextButton.BorderSizePixel = 0
nextButton.Visible = false
nextButton.Parent = screenGui

local nextCorner = Instance.new("UICorner")
nextCorner.CornerRadius = UDim.new(0, 8)
nextCorner.Parent = nextButton

local nextStroke = Instance.new("UIStroke")
nextStroke.Color = Color3.fromRGB(220, 80, 80)
nextStroke.Thickness = 2
nextStroke.Parent = nextButton

local function updateButtonPositions()
    local dragPos = dragButton.Position
    local dragSize = dragButton.Size
    
    mainButton.Position = UDim2.new(
        dragPos.X.Scale, dragPos.X.Offset,
        dragPos.Y.Scale, dragPos.Y.Offset + dragSize.Y.Offset + 10
    )
    
    local mainPos = mainButton.Position
    local mainSize = mainButton.Size
    nextButton.Position = UDim2.new(
        mainPos.X.Scale, mainPos.X.Offset + (mainSize.X.Offset - nextButton.Size.X.Offset) / 2,
        mainPos.Y.Scale, mainPos.Y.Offset + mainSize.Y.Offset + 10
    )
end

updateButtonPositions()

local isDragging = false
local dragOffset = Vector2.new(0, 0)

dragButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        local buttonPos = dragButton.AbsolutePosition
        local mousePos = input.Position
        dragOffset = Vector2.new(buttonPos.X - mousePos.X, buttonPos.Y - mousePos.Y)
    end
end)

dragButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    if isDragging then
        local mousePos = UserInputService:GetMouseLocation()
        dragButton.Position = UDim2.new(0, mousePos.X + dragOffset.X, 0, mousePos.Y + dragOffset.Y)
        updateButtonPositions()
    end
end)

local function findNextAvailableTrashcan()
    local currentTime = tick()
    local startIndex = trashcanIndex
    
    for i = 1, #trashcanCFrames do
        local trashcan = trashcanCFrames[trashcanIndex]
        local timeSinceVisit = currentTime - trashcan.LastVisited
        
        if trashcan.LastVisited == 0 or timeSinceVisit >= cooldownTime then
            local resultIndex = trashcanIndex
            trashcanIndex = (trashcanIndex % #trashcanCFrames) + 1
            return trashcan, resultIndex
        end
        
        trashcanIndex = (trashcanIndex % #trashcanCFrames) + 1
        
        if trashcanIndex == startIndex then
            local oldestIndex = 1
            local oldestTime = trashcanCFrames[1].LastVisited
            
            for j = 2, #trashcanCFrames do
                if trashcanCFrames[j].LastVisited < oldestTime then
                    oldestTime = trashcanCFrames[j].LastVisited
                    oldestIndex = j
                end
            end
            
            trashcanIndex = (oldestIndex % #trashcanCFrames) + 1
            return trashcanCFrames[oldestIndex], oldestIndex
        end
    end
    
    return nil
end

local function teleportToNextTrashcan()
    local character = LocalPlayer.Character
    if not character then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return false end
    
    if #trashcanCFrames == 0 then return false end
    
    local trashcanData, index = findNextAvailableTrashcan()
    if not trashcanData then return false end
    
    trashcanData.LastVisited = tick()
    
    local targetCFrame = trashcanData.CFrame
    local teleportCFrame = CFrame.new(
        targetCFrame.Position + targetCFrame.LookVector * 2 + Vector3.new(0, 3, 0)
    )
    
    humanoidRootPart.CFrame = teleportCFrame
    
    humanoidRootPart.CFrame = CFrame.lookAt(
        humanoidRootPart.Position,
        targetCFrame.Position
    )
    
    return true
end

local function returnToSavedPosition()
    local character = LocalPlayer.Character
    if not character then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return false end
    
    if _G.Pos then
        humanoidRootPart.CFrame = CFrame.new(_G.Pos)
        return true
    end
    return false
end

mainButton.MouseButton1Click:Connect(function()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    if not mainButtonActive then
        _G.Pos = humanoidRootPart.Position
        mainButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        mainStroke.Color = Color3.fromRGB(80, 220, 80)
        mainButton.Text = "Get Trashcan ✓"
        nextButton.Visible = true
        
        if teleportToNextTrashcan() then
            mainButtonActive = true
        else
            mainButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            mainStroke.Color = Color3.fromRGB(150, 150, 150)
            mainButton.Text = "Get Trashcan"
            nextButton.Visible = false
        end
    else
        if returnToSavedPosition() then
            mainButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            mainStroke.Color = Color3.fromRGB(150, 150, 150)
            mainButton.Text = "Get Trashcan"
            nextButton.Visible = false
            mainButtonActive = false
        end
    end
end)

nextButton.MouseButton1Click:Connect(function()
    if mainButtonActive then
        teleportToNextTrashcan()
    end
end)
