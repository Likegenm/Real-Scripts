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

local loadTime = math.random(1, 5)
local startTime = tick()

local colors = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(255, 127, 0),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(75, 0, 130),
    Color3.fromRGB(148, 0, 211)
}

local currentTime = 0
local colorSpeed = 20

while tick() - startTime < loadTime do
    local elapsed = tick() - startTime
    local percent = math.floor((elapsed / loadTime) * 100)
    textLabel.Text = "Wait " .. percent .. "%"
    
    currentTime = currentTime + colorSpeed * 0.1
    local t = (math.sin(currentTime) + 1) / 2
    
    local colorIndex1 = math.floor(currentTime % #colors) + 1
    local colorIndex2 = (colorIndex1 % #colors) + 1
    
    textLabel.TextColor3 = colors[colorIndex1]:Lerp(colors[colorIndex2], t)
    
    wait(0.1)
end

textLabel.Text = "Wait 100%"
textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "100%",
    Text = "100% loading",
    Duration = 3
})

screenGui:Destroy()
