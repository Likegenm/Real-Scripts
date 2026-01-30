local Library = {}
Library.__index = Library

local colors = {
    backgroundGradient = {Color3.fromRGB(255, 105, 180), Color3.fromRGB(147, 112, 219)},
    text = Color3.fromRGB(255, 255, 255),
    button = Color3.fromRGB(220, 20, 60),
    border = Color3.fromRGB(0, 0, 0),
    tabBackground = Color3.fromRGB(50, 50, 50),
    separator = Color3.fromRGB(30, 30, 30)
}

function Library.new(title, subtitle)
    local self = setmetatable({}, Library)
    
    self.tabs = {}
    self.currentTab = nil
    self.gradientOffset = 0
    self.gradientDirection = 1
    self.isVisible = false
    
    self.mainFrame = Instance.new("Frame")
    self.mainFrame.Name = "LibraryUI"
    self.mainFrame.Size = UDim2.new(0, 500, 0, 350)
    self.mainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    self.mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    self.mainFrame.BackgroundTransparency = 1
    self.mainFrame.Visible = false
    self.mainFrame.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    self.gradientFrame = Instance.new("Frame")
    self.gradientFrame.Name = "GradientBackground"
    self.gradientFrame.Size = UDim2.new(1, 0, 1, 0)
    self.gradientFrame.Position = UDim2.new(0, 0, 0, 0)
    self.gradientFrame.BackgroundColor3 = colors.backgroundGradient[1]
    self.gradientFrame.BorderSizePixel = 0
    self.gradientFrame.Parent = self.mainFrame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, colors.backgroundGradient[1]),
        ColorSequenceKeypoint.new(1, colors.backgroundGradient[2])
    }
    gradient.Rotation = 45
    gradient.Enabled = true
    gradient.Parent = self.gradientFrame
    
    self.borderFrame = Instance.new("Frame")
    self.borderFrame.Name = "Border"
    self.borderFrame.Size = UDim2.new(1, -4, 1, -4)
    self.borderFrame.Position = UDim2.new(0, 2, 0, 2)
    self.borderFrame.BackgroundColor3 = colors.border
    self.borderFrame.BorderSizePixel = 0
    self.borderFrame.Parent = self.mainFrame
    
    self.container = Instance.new("Frame")
    self.container.Name = "Container"
    self.container.Size = UDim2.new(1, -4, 1, -4)
    self.container.Position = UDim2.new(0, 2, 0, 2)
    self.container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    self.container.BorderSizePixel = 0
    self.container.Parent = self.borderFrame
    
    self.titleLabel = Instance.new("TextLabel")
    self.titleLabel.Name = "Title"
    self.titleLabel.Size = UDim2.new(1, 0, 0, 30)
    self.titleLabel.Position = UDim2.new(0, 0, 0, 0)
    self.titleLabel.BackgroundTransparency = 1
    self.titleLabel.TextColor3 = colors.text
    self.titleLabel.Text = title or "Library"
    self.titleLabel.TextSize = 18
    self.titleLabel.Font = Enum.Font.GothamBold
    self.titleLabel.TextStrokeTransparency = 0.5
    self.titleLabel.Parent = self.container
    
    self.subtitleLabel = Instance.new("TextLabel")
    self.subtitleLabel.Name = "Subtitle"
    self.subtitleLabel.Size = UDim2.new(1, 0, 0, 20)
    self.subtitleLabel.Position = UDim2.new(0, 0, 0, 30)
    self.subtitleLabel.BackgroundTransparency = 1
    self.subtitleLabel.TextColor3 = colors.text
    self.subtitleLabel.Text = subtitle or "Powered by Lua Library"
    self.subtitleLabel.TextSize = 12
    self.subtitleLabel.Font = Enum.Font.Gotham
    self.subtitleLabel.TextStrokeTransparency = 0.7
    self.subtitleLabel.Parent = self.container
    
    self.separator1 = Instance.new("Frame")
    self.separator1.Name = "Separator1"
    self.separator1.Size = UDim2.new(1, -20, 0, 1)
    self.separator1.Position = UDim2.new(0, 10, 0, 55)
    self.separator1.BackgroundColor3 = colors.separator
    self.separator1.BorderSizePixel = 0
    self.separator1.Parent = self.container
    
    self.executorLabel = Instance.new("TextLabel")
    self.executorLabel.Name = "ExecutorInfo"
    self.executorLabel.Size = UDim2.new(1, -20, 0, 15)
    self.executorLabel.Position = UDim2.new(0, 10, 1, -20)
    self.executorLabel.BackgroundTransparency = 1
    self.executorLabel.TextColor3 = colors.text
    self.executorLabel.Text = "Executor: Unknown"
    self.executorLabel.TextSize = 10
    self.executorLabel.Font = Enum.Font.Gotham
    self.executorLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.executorLabel.Parent = self.container
    
    self.openKeyLabel = Instance.new("TextLabel")
    self.openKeyLabel.Name = "OpenKey"
    self.openKeyLabel.Size = UDim2.new(0, 150, 0, 20)
    self.openKeyLabel.Position = UDim2.new(1, -160, 0, 5)
    self.openKeyLabel.BackgroundTransparency = 1
    self.openKeyLabel.TextColor3 = colors.text
    self.openKeyLabel.Text = "Open: RightShift"
    self.openKeyLabel.TextSize = 12
    self.openKeyLabel.Font = Enum.Font.Gotham
    self.openKeyLabel.TextXAlignment = Enum.TextXAlignment.Right
    self.openKeyLabel.Parent = self.container
    
    self.tabsContainer = Instance.new("Frame")
    self.tabsContainer.Name = "TabsContainer"
    self.tabsContainer.Size = UDim2.new(0, 120, 1, -100)
    self.tabsContainer.Position = UDim2.new(0, 10, 0, 65)
    self.tabsContainer.BackgroundColor3 = colors.tabBackground
    self.tabsContainer.BorderSizePixel = 0
    self.tabsContainer.Parent = self.container
    
    self.tabSeparator = Instance.new("Frame")
    self.tabSeparator.Name = "TabSeparator"
    self.tabSeparator.Size = UDim2.new(0, 1, 1, 0)
    self.tabSeparator.Position = UDim2.new(0, 120, 0, 0)
    self.tabSeparator.BackgroundColor3 = colors.separator
    self.tabSeparator.BorderSizePixel = 0
    self.tabSeparator.Parent = self.tabsContainer
    
    self.contentContainer = Instance.new("Frame")
    self.contentContainer.Name = "ContentContainer"
    self.contentContainer.Size = UDim2.new(1, -150, 1, -80)
    self.contentContainer.Position = UDim2.new(0, 140, 0, 65)
    self.contentContainer.BackgroundTransparency = 1
    self.contentContainer.ClipsDescendants = true
    self.contentContainer.Parent = self.container
    
    self.buttonsContainer = Instance.new("Frame")
    self.buttonsContainer.Name = "ButtonsContainer"
    self.buttonsContainer.Size = UDim2.new(1, -20, 0, 40)
    self.buttonsContainer.Position = UDim2.new(0, 10, 1, -65)
    self.buttonsContainer.BackgroundColor3 = colors.border
    self.buttonsContainer.BorderSizePixel = 0
    self.buttonsContainer.Parent = self.container
    
    self.buttonSeparator = Instance.new("Frame")
    self.buttonSeparator.Name = "ButtonSeparator"
    self.buttonSeparator.Size = UDim2.new(1, 0, 0, 1)
    self.buttonSeparator.Position = UDim2.new(0, 0, 0, 0)
    self.buttonSeparator.BackgroundColor3 = colors.separator
    self.buttonSeparator.BorderSizePixel = 0
    self.buttonSeparator.Parent = self.buttonsContainer
    
    self.watermark = Instance.new("Frame")
    self.watermark.Name = "Watermark"
    self.watermark.Size = UDim2.new(0, 200, 0, 40)
    self.watermark.Position = UDim2.new(1, -210, 0, 10)
    self.watermark.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    self.watermark.BackgroundTransparency = 0.7
    self.watermark.BorderColor3 = colors.border
    self.watermark.BorderSizePixel = 1
    
    local watermarkCorner = Instance.new("UICorner")
    watermarkCorner.CornerRadius = UDim.new(0, 5)
    watermarkCorner.Parent = self.watermark
    
    self.watermarkText = Instance.new("TextLabel")
    self.watermarkText.Name = "WatermarkText"
    self.watermarkText.Size = UDim2.new(1, 0, 1, 0)
    self.watermarkText.Position = UDim2.new(0, 0, 0, 0)
    self.watermarkText.BackgroundTransparency = 1
    self.watermarkText.TextColor3 = colors.text
    self.watermarkText.Text = "Loading..."
    self.watermarkText.TextSize = 12
    self.watermarkText.Font = Enum.Font.Gotham
    self.watermarkText.Parent = self.watermark
    
    self.watermark.Parent = self.container
    
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        self.watermark.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    self.watermark.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.watermark.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    self.watermark.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)
    
    self.animationConnection = game:GetService("RunService").RenderStepped:Connect(function(dt)
        self.gradientOffset = (self.gradientOffset + dt * 0.1 * self.gradientDirection) % 1
        
        if self.gradientOffset >= 0.9 then
            self.gradientDirection = -1
        elseif self.gradientOffset <= 0.1 then
            self.gradientDirection = 1
        end
        
        gradient.Offset = Vector2.new(self.gradientOffset, self.gradientOffset)
    end)
    
    self:updateWatermark()
    
    return self
end

function Library:updateWatermark()
    local player = game:GetService("Players").LocalPlayer
    local playerName = player.Name
    
    coroutine.wrap(function()
        while self.mainFrame and self.mainFrame.Parent do
            local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
            local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
            
            self.watermarkText.Text = string.format("Player: %s\nFPS: %d | Ping: %dms\nExecutor: %s", 
                playerName, fps, ping, identifyexecutor() or "Unknown")
            
            wait(0.5)
        end
    end)()
end

function Library:setOpenKey(keyName)
    self.openKeyLabel.Text = "Open: " .. keyName
end

function Library:Toggle()
    self.isVisible = not self.isVisible
    self.mainFrame.Visible = self.isVisible
    return self.isVisible
end

function Library:Show()
    self.isVisible = true
    self.mainFrame.Visible = true
end

function Library:Hide()
    self.isVisible = false
    self.mainFrame.Visible = false
end

function Library:CreateTab(tabName)
    local tab = {}
    
    tab.name = tabName
    tab.button = Instance.new("TextButton")
    tab.button.Name = "Tab_" .. tabName
    tab.button.Size = UDim2.new(1, -10, 0, 30)
    tab.button.Position = UDim2.new(0, 5, 0, 10 + (#self.tabs * 35))
    tab.button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tab.button.BorderSizePixel = 0
    tab.button.TextColor3 = colors.text
    tab.button.Text = tabName
    tab.button.TextSize = 14
    tab.button.Font = Enum.Font.Gotham
    tab.button.Parent = self.tabsContainer
    
    tab.content = Instance.new("Frame")
    tab.content.Name = "Content_" .. tabName
    tab.content.Size = UDim2.new(1, 0, 1, 0)
    tab.content.Position = UDim2.new(0, 0, 0, 0)
    tab.content.BackgroundTransparency = 1
    tab.content.Visible = false
    tab.content.Parent = self.contentContainer
    
    tab.button.MouseButton1Click:Connect(function()
        self:SwitchTab(tabName)
    end)
    
    table.insert(self.tabs, tab)
    
    if #self.tabs == 1 then
        self:SwitchTab(tabName)
    end
    
    return tab
end

function Library:SwitchTab(tabName)
    for _, tab in ipairs(self.tabs) do
        if tab.content then
            tab.content.Visible = false
        end
        if tab.button then
            tab.button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
    end
    
    for _, tab in ipairs(self.tabs) do
        if tab.name == tabName then
            tab.content.Visible = true
            tab.button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            self.currentTab = tab
            break
        end
    end
end

function Library:AddButton(tabName, buttonName, callback)
    local tab = self:GetTab(tabName)
    if not tab then return end
    
    local buttonCount = #tab.content:GetChildren() - 1
    
    local button = Instance.new("TextButton")
    button.Name = "Button_" .. buttonName
    button.Size = UDim2.new(1, -20, 0, 30)
    button.Position = UDim2.new(0, 10, 0, 10 + (buttonCount * 40))
    button.BackgroundColor3 = colors.button
    button.BorderSizePixel = 0
    button.TextColor3 = colors.text
    button.Text = buttonName
    button.TextSize = 14
    button.Font = Enum.Font.Gotham
    
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    button.Parent = tab.content
    
    return button
end

function Library:AddLabel(tabName, labelText)
    local tab = self:GetTab(tabName)
    if not tab then return end
    
    local elementCount = #tab.content:GetChildren() - 1
    
    local label = Instance.new("TextLabel")
    label.Name = "Label_" .. labelText
    label.Size = UDim2.new(1, -20, 0, 25)
    label.Position = UDim2.new(0, 10, 0, 10 + (elementCount * 35))
    label.BackgroundTransparency = 1
    label.TextColor3 = colors.text
    label.Text = labelText
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    label.Parent = tab.content
    
    return label
end

function Library:AddToggle(tabName, toggleName, default, callback)
    local tab = self:GetTab(tabName)
    if not tab then return end
    
    local elementCount = #tab.content:GetChildren() - 1
    local state = default or false
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = "Toggle_" .. toggleName
    toggleFrame.Size = UDim2.new(1, -20, 0, 30)
    toggleFrame.Position = UDim2.new(0, 10, 0, 10 + (elementCount * 40))
    toggleFrame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = colors.text
    label.Text = toggleName
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 50, 0, 25)
    toggleButton.Position = UDim2.new(1, -55, 0, 2)
    toggleButton.BackgroundColor3 = state and colors.button or Color3.fromRGB(80, 80, 80)
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = state and "ON" or "OFF"
    toggleButton.TextColor3 = colors.text
    toggleButton.TextSize = 12
    toggleButton.Font = Enum.Font.Gotham
    toggleButton.Parent = toggleFrame
    
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        toggleButton.BackgroundColor3 = state and colors.button or Color3.fromRGB(80, 80, 80)
        toggleButton.Text = state and "ON" or "OFF"
        
        if callback then
            callback(state)
        end
    end)
    
    toggleFrame.Parent = tab.content
    
    return {
        Set = function(value)
            state = value
            toggleButton.BackgroundColor3 = state and colors.button or Color3.fromRGB(80, 80, 80)
            toggleButton.Text = state and "ON" or "OFF"
            if callback then callback(state) end
        end,
        Get = function() return state end
    }
end

function Library:GetTab(tabName)
    for _, tab in ipairs(self.tabs) do
        if tab.name == tabName then
            return tab
        end
    end
    return nil
end

function Library:Destroy()
    if self.animationConnection then
        self.animationConnection:Disconnect()
    end
    if self.mainFrame then
        self.mainFrame:Destroy()
    end
end

return Library
