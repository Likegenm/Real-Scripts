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
while tick() - startTime < loadTime do
    local elapsed = tick() - startTime
    local percent = math.floor((elapsed / loadTime) * 100)
    textLabel.Text = "Wait " .. percent .. "%"
    wait(0.1)
end
textLabel.Text = "Wait 100%"
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCore("SendNotification", {
    Title = "100%",
    Text = "100% loading",
    Duration = 3
})
wait(1)
screenGui:Destroy()

--я только что украл у тебя минуту жизни просто по приколу
