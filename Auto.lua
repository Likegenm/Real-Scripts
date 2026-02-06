local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local currentGameId = game.GameId

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LikegenmLoader"
screenGui.Parent = player:WaitForChild("PlayerGui")

local blackScreen = Instance.new("Frame")
blackScreen.Size = UDim2.new(1, 0, 1, 0)
blackScreen.Position = UDim2.new(0, 0, 0, 0)
blackScreen.BackgroundColor3 = Color3.new(0, 0, 0)
blackScreen.BackgroundTransparency = 0
blackScreen.ZIndex = 10
blackScreen.Parent = screenGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
textLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Likegenm Scripts"
textLabel.Font = Enum.Font.GothamBlack
textLabel.TextSize = 72
textLabel.TextTransparency = 0
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextStrokeTransparency = 0.5
textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
textLabel.ZIndex = 11
textLabel.Parent = screenGui

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.6, 0, 0.1, 0)
statusLabel.Position = UDim2.new(0.2, 0, 0.65, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Loading..."
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 24
statusLabel.TextTransparency = 0
statusLabel.TextColor3 = Color3.new(1, 1, 1)
statusLabel.ZIndex = 11
statusLabel.Parent = screenGui

local sliderFrame = Instance.new("Frame")
sliderFrame.Size = UDim2.new(0.6, 0, 0.02, 0)
sliderFrame.Position = UDim2.new(0.2, 0, 0.75, 0)
sliderFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
sliderFrame.BorderSizePixel = 0
sliderFrame.ZIndex = 11
sliderFrame.Parent = screenGui

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.new(1, 0, 0)
sliderFill.BorderSizePixel = 0
sliderFill.ZIndex = 12
sliderFill.Parent = sliderFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = sliderFrame

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = sliderFill

local function updateSlider(percent, color)
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local sizeTween = TweenService:Create(sliderFill, tweenInfo, {Size = UDim2.new(percent, 0, 1, 0)})
    local colorTween = TweenService:Create(sliderFill, tweenInfo, {BackgroundColor3 = color})
    sizeTween:Play()
    colorTween:Play()
end

local function showAnimation()
    local colors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(255, 165, 0),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 255, 255),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(255, 0, 255)
    }
    
    local colorIndex = 1
    local startTime = tick()
    
    while tick() - startTime < 2 do
        textLabel.TextColor3 = colors[colorIndex]
        colorIndex = colorIndex + 1
        if colorIndex > #colors then colorIndex = 1 end
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
        local colorTween = TweenService:Create(textLabel, tweenInfo, {TextColor3 = colors[colorIndex]})
        colorTween:Play()
        wait(0.5)
    end
end

local function checkGame()
    statusLabel.Text = "Checking Game ID..."
    updateSlider(0.1, Color3.fromRGB(255, 0, 0))
    wait(0.5)
    
    local gameScripts = {
        [3808081382] = {"https://raw.githubusercontent.com/Likegenm/Real-Scripts/refs/heads/main/TSB.lua", "The Strongest Battlegrounds"},
        [3109731140] = {"https://raw.githubusercontent.com/Likegenm/Real-Scripts/refs/heads/main/Intruder.lua", "Intruder"},
        [66654135] = {"https://raw.githubusercontent.com/Likegenm/Real-Scripts/refs/heads/main/MM2.lua", "Murder Mystery 2"},
        [1742264997] = {"https://raw.githubusercontent.com/Likegenm/Real-Scripts/refs/heads/main/ScpRP.lua", "SCP Roleplay"},
        [99402433] = {"https://raw.githubusercontent.com/Likegenm/Real-Scripts/refs/heads/main/Speedrun12.lua", "Speedrun 12"},
        [7709344486] = {"https://raw.githubusercontent.com/Likegenm/Real-Scripts/refs/heads/main/SB(Steal%20A%20Brainrot.lua", "Steal A Brainrot"},
        [6699967032] = {"https://raw.githubusercontent.com/Likegenm/Real-Scripts/refs/heads/main/The%20Field.lua", "The Field"},
        [6280758286] = {"https://raw.githubusercontent.com/Likegenm/Real-Scripts/refs/heads/main/ArmyRp.lua", "Army Roleplay"},
        [1489026993] = {"https://raw.githubusercontent.com/Likegenm/Real-Scripts/refs/heads/main/SK.lua", "Super Kart"},
        [4777817887] = {"https://raw.githubusercontent.com/Likegenm/Real-Scripts/refs/heads/main/BladeBall.lua", "Blade Ball"},
        [1934496708] = {"https://raw.githubusercontent.com/Likegenm/Real-Scripts/refs/heads/main/ScpProject.lua", "SCP Project"},
        [1116949753] = {"https://raw.githubusercontent.com/Likegenm/Real-Scripts/refs/heads/main/Isle.lua", "The Isle"}
    }
    
    statusLabel.Text = "Game ID: " .. tostring(currentGameId)
    updateSlider(0.3, Color3.fromRGB(255, 100, 0))
    wait(0.5)
    
    if gameScripts[currentGameId] then
        statusLabel.Text = "Found: " .. gameScripts[currentGameId][2]
        updateSlider(0.5, Color3.fromRGB(255, 255, 0))
        wait(0.5)
        
        statusLabel.Text = "Loading script..."
        updateSlider(0.7, Color3.fromRGB(100, 255, 0))
        wait(0.5)
        
        local success, errorMsg = pcall(function()
            loadstring(game:HttpGet(gameScripts[currentGameId][1], true))()
        end)
        
        if success then
            statusLabel.Text = "Script loaded successfully!"
            updateSlider(1, Color3.fromRGB(0, 255, 0))
            
            StarterGui:SetCore("SendNotification", {
                Title = "Likegenm Scripts",
                Text = "Loaded: " .. gameScripts[currentGameId][2],
                Duration = 5,
                Icon = "rbxassetid://4483345998"
            })
        else
            statusLabel.Text = "Error loading script!"
            updateSlider(1, Color3.fromRGB(255, 0, 0))
            
            StarterGui:SetCore("SendNotification", {
                Title = "Error",
                Text = "Failed to load script",
                Duration = 5,
                Icon = "rbxassetid://4483345998"
            })
        end
    else
        statusLabel.Text = "Game not supported"
        updateSlider(1, Color3.fromRGB(255, 0, 0))
        
        StarterGui:SetCore("SendNotification", {
            Title = "Likegenm Scripts",
            Text = "This game is not supported",
            Duration = 5,
            Icon = "rbxassetid://4483345998"
        })
    end
    
    wait(1)
    
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local fadeOut = TweenService:Create(blackScreen, tweenInfo, {BackgroundTransparency = 1})
    local textFade = TweenService:Create(textLabel, tweenInfo, {TextTransparency = 1})
    local statusFade = TweenService:Create(statusLabel, tweenInfo, {TextTransparency = 1})
    local sliderFade = TweenService:Create(sliderFrame, tweenInfo, {BackgroundTransparency = 1})
    local fillFade = TweenService:Create(sliderFill, tweenInfo, {BackgroundTransparency = 1})
    
    fadeOut:Play()
    textFade:Play()
    statusFade:Play()
    sliderFade:Play()
    fillFade:Play()
    
    fadeOut.Completed:Wait()
    screenGui:Destroy()
end

coroutine.wrap(showAnimation)()
wait(1)
coroutine.wrap(checkGame)()
