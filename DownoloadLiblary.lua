local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingScreen"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 200, 0, 20)
textLabel.Position = UDim2.new(0.5, -100, 0.1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "wait 0%"
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextSize = 20
textLabel.Font = Enum.Font.GothamBold
textLabel.Parent = screenGui

local loadTime = math.random(10, 60)
local startTime = tick()

-- Радужные цвета
local colors = {
    Color3.fromRGB(255, 0, 0),      -- Красный
    Color3.fromRGB(255, 127, 0),    -- Оранжевый
    Color3.fromRGB(255, 255, 0),    -- Желтый
    Color3.fromRGB(0, 255, 0),      -- Зеленый
    Color3.fromRGB(0, 0, 255),      -- Синий
    Color3.fromRGB(75, 0, 130),     -- Индиго
    Color3.fromRGB(148, 0, 211)     -- Фиолетовый
}

local colorIndex = 1
local colorTransitionSpeed = 0.5

while tick() - startTime < loadTime do
    local elapsed = tick() - startTime
    local percent = math.floor((elapsed / loadTime) * 100)
    textLabel.Text = "Wait " .. percent .. "%"
    
    -- Радужная смена цвета
    textLabel.TextColor3 = colors[colorIndex]
    
    colorIndex = colorIndex + 1
    if colorIndex > #colors then
        colorIndex = 1
    end
    
    wait(colorTransitionSpeed)
end

textLabel.Text = "Wait 100%"
textLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Зеленый при 100%

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "100%",
    Text = "100% loading",
    Duration = 3
})

wait(1)
screenGui:Destroy()
