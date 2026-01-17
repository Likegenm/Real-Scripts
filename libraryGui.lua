local LikegenmUI = {}

LikegenmUI.Colors = {
    Background = Color3.fromRGB(15, 15, 20),
    Surface = Color3.fromRGB(25, 25, 30),
    SurfaceLight = Color3.fromRGB(35, 35, 40),
    Primary = Color3.fromRGB(100, 70, 200),
    PrimaryLight = Color3.fromRGB(120, 90, 220),
    Secondary = Color3.fromRGB(70, 150, 220),
    Success = Color3.fromRGB(70, 200, 100),
    Warning = Color3.fromRGB(255, 180, 60),
    Danger = Color3.fromRGB(255, 80, 80),
    Text = Color3.fromRGB(245, 245, 250),
    TextDim = Color3.fromRGB(180, 180, 190),
    Border = Color3.fromRGB(50, 50, 60)
}

LikegenmUI.Fonts = {
    Title = Enum.Font.GothamBold,
    Heading = Enum.Font.GothamSemibold,
    Body = Enum.Font.Gotham,
    Monospace = Enum.Font.Code
}

function LikegenmUI:RoundedCorners(frame, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = frame
    return corner
end

function LikegenmUI:AddShadow(frame, intensity)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Image = "rbxassetid://5554236805"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = intensity or 0.8
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.Size = UDim2.new(1, 44, 1, 44)
    shadow.Position = UDim2.new(0, -22, 0, -22)
    shadow.BackgroundTransparency = 1
    shadow.ZIndex = -1
    shadow.Parent = frame
    return shadow
end

function LikegenmUI:Tween(object, properties, duration, easing)
    local tweenInfo = TweenInfo.new(
        duration or 0.25,
        easing or Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )
    local tween = game:GetService("TweenService"):Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

function LikegenmUI:Gradient(frame, colors, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(colors)
    gradient.Rotation = rotation or 0
    gradient.Parent = frame
    return gradient
end

function LikegenmUI:CreateWindow(options)
    local Window = {}
    local Tabs = {}
    local CurrentTab = nil
    local Sections = {}
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LikegenmUI"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    local MainContainer = Instance.new("Frame")
    MainContainer.Size = UDim2.new(0, 600, 0, 500)
    MainContainer.Position = UDim2.new(0.5, -300, 0.5, -250)
    MainContainer.BackgroundColor3 = LikegenmUI.Colors.Background
    MainContainer.BorderSizePixel = 0
    MainContainer.Parent = ScreenGui
    
    self:RoundedCorners(MainContainer, 14)
    self:AddShadow(MainContainer, 0.85)
    
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 48)
    TitleBar.BackgroundColor3 = LikegenmUI.Colors.Surface
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainContainer
    
    self:RoundedCorners(TitleBar, 14)
    
    local TitleGradient = Instance.new("Frame")
    TitleGradient.Size = UDim2.new(1, 0, 1, 0)
    TitleGradient.BackgroundTransparency = 1
    TitleGradient.Parent = TitleBar
    
    self:Gradient(TitleGradient, {
        LikegenmUI.Colors.Primary,
        LikegenmUI.Colors.Secondary
    }, 90)
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    TitleLabel.Text = options.Title or "Likegenm UI"
    TitleLabel.TextColor3 = LikegenmUI.Colors.Text
    TitleLabel.Font = LikegenmUI.Fonts.Title
    TitleLabel.TextSize = 20
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = TitleBar
    
    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Size = UDim2.new(1, -100, 0, 16)
    SubtitleLabel.Position = UDim2.new(0, 20, 0, 28)
    SubtitleLabel.Text = options.Subtitle or "Premium UI Library"
    SubtitleLabel.TextColor3 = LikegenmUI.Colors.TextDim
    SubtitleLabel.Font = LikegenmUI.Fonts.Body
    SubtitleLabel.TextSize = 12
    SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Parent = TitleBar
    
    local WindowButtons = Instance.new("Frame")
    WindowButtons.Size = UDim2.new(0, 80, 1, 0)
    WindowButtons.Position = UDim2.new(1, -85, 0, 0)
    WindowButtons.BackgroundTransparency = 1
    WindowButtons.Parent = TitleBar
    
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 28, 0, 28)
    MinimizeButton.Position = UDim2.new(0, 5, 0.5, -14)
    MinimizeButton.Text = "─"
    MinimizeButton.TextColor3 = LikegenmUI.Colors.Text
    MinimizeButton.Font = LikegenmUI.Fonts.Heading
    MinimizeButton.TextSize = 18
    MinimizeButton.BackgroundColor3 = LikegenmUI.Colors.SurfaceLight
    MinimizeButton.AutoButtonColor = false
    MinimizeButton.Parent = WindowButtons
    
    self:RoundedCorners(MinimizeButton, 6)
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 28, 0, 28)
    CloseButton.Position = UDim2.new(1, -33, 0.5, -14)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = LikegenmUI.Colors.Text
    CloseButton.Font = LikegenmUI.Fonts.Heading
    CloseButton.TextSize = 20
    CloseButton.BackgroundColor3 = LikegenmUI.Colors.Danger
    CloseButton.AutoButtonColor = false
    CloseButton.Parent = WindowButtons
    
    self:RoundedCorners(CloseButton, 6)
    
    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(1, -30, 0, 42)
    TabContainer.Position = UDim2.new(0, 15, 0, 60)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = MainContainer
    
    local TabContent = Instance.new("Frame")
    TabContent.Size = UDim2.new(1, -30, 1, -115)
    TabContent.Position = UDim2.new(0, 15, 0, 110)
    TabContent.BackgroundTransparency = 1
    TabContent.ClipsDescendants = true
    TabContent.Parent = MainContainer
    
    local ContentScrolling = Instance.new("ScrollingFrame")
    ContentScrolling.Size = UDim2.new(1, 0, 1, 0)
    ContentScrolling.BackgroundTransparency = 1
    ContentScrolling.BorderSizePixel = 0
    ContentScrolling.ScrollBarThickness = 4
    ContentScrolling.ScrollBarImageColor3 = LikegenmUI.Colors.Border
    ContentScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ContentScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentScrolling.Parent = TabContent
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0, 10)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Parent = ContentScrolling
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 52, 0, 52)
    ToggleButton.Position = UDim2.new(0, 25, 0, 25)
    ToggleButton.Text = "⚙️"
    ToggleButton.TextColor3 = LikegenmUI.Colors.Text
    ToggleButton.Font = LikegenmUI.Fonts.Title
    ToggleButton.TextSize = 28
    ToggleButton.BackgroundColor3 = LikegenmUI.Colors.Primary
    ToggleButton.AutoButtonColor = false
    ToggleButton.Visible = false
    ToggleButton.Parent = ScreenGui
    
    self:RoundedCorners(ToggleButton, 12)
    self:AddShadow(ToggleButton, 0.7)
    
    local isMinimized = false
    
    local function updateToggleButton()
        if isMinimized then
            self:Tween(ToggleButton, {Size = UDim2.new(0, 52, 0, 52)}, 0.3)
            self:Tween(ToggleButton, {BackgroundColor3 = LikegenmUI.Colors.Success}, 0.3)
            ToggleButton.Text = "⚙️"
        else
            self:Tween(ToggleButton, {Size = UDim2.new(0, 52, 0, 52)}, 0.3)
            self:Tween(ToggleButton, {BackgroundColor3 = LikegenmUI.Colors.Primary}, 0.3)
            ToggleButton.Text = "⚙️"
        end
    end
    
    local function toggleWindow()
        if isMinimized then
            isMinimized = false
            ToggleButton.Visible = false
            self:Tween(MainContainer, {
                Size = UDim2.new(0, 600, 0, 500),
                Position = UDim2.new(0.5, -300, 0.5, -250)
            }, 0.4, Enum.EasingStyle.Back)
        else
            isMinimized = true
            self:Tween(MainContainer, {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }, 0.4, Enum.EasingStyle.Back)
            wait(0.4)
            ToggleButton.Visible = true
            updateToggleButton()
        end
    end
    
    ToggleButton.MouseButton1Click:Connect(function()
        toggleWindow()
    end)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        toggleWindow()
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        self:Tween(MainContainer, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }, 0.4, Enum.EasingStyle.Back)
        wait(0.4)
        ScreenGui:Destroy()
    end)
    
    MinimizeButton.MouseEnter:Connect(function()
        self:Tween(MinimizeButton, {BackgroundColor3 = LikegenmUI.Colors.Primary}, 0.2)
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        self:Tween(MinimizeButton, {BackgroundColor3 = LikegenmUI.Colors.SurfaceLight}, 0.2)
    end)
    
    CloseButton.MouseEnter:Connect(function()
        self:Tween(CloseButton, {BackgroundColor3 = Color3.fromRGB(255, 120, 120)}, 0.2)
    end)
    
    CloseButton.MouseLeave:Connect(function()
        self:Tween(CloseButton, {BackgroundColor3 = LikegenmUI.Colors.Danger}, 0.2)
    end)
    
    ToggleButton.MouseEnter:Connect(function()
        self:Tween(ToggleButton, {Size = UDim2.new(0, 56, 0, 56)}, 0.2)
    end)
    
    ToggleButton.MouseLeave:Connect(function()
        self:Tween(ToggleButton, {Size = UDim2.new(0, 52, 0, 52)}, 0.2)
    end)
    
    local dragging = false
    local dragStart, frameStart
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            frameStart = MainContainer.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainContainer.Position = UDim2.new(
                frameStart.X.Scale,
                frameStart.X.Offset + delta.X,
                frameStart.Y.Scale,
                frameStart.Y.Offset + delta.Y
            )
        end
    end)
    
    local TabIndicator = Instance.new("Frame")
    TabIndicator.Size = UDim2.new(0, 80, 0, 3)
    TabIndicator.BackgroundColor3 = LikegenmUI.Colors.Primary
    TabIndicator.BorderSizePixel = 0
    TabIndicator.Visible = false
    TabIndicator.Parent = TabContainer
    
    self:RoundedCorners(TabIndicator, 2)
    
    function Window:CreateTab(name, icon)
        local Tab = {}
        local TabElements = {}
        
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 80, 1, 0)
        TabButton.Position = UDim2.new(0, (#Tabs * 85), 0, 0)
        TabButton.Text = icon and (icon .. " " .. name) or name
        TabButton.TextColor3 = LikegenmUI.Colors.TextDim
        TabButton.Font = LikegenmUI.Fonts.Heading
        TabButton.TextSize = 14
        TabButton.BackgroundTransparency = 1
        TabButton.AutoButtonColor = false
        TabButton.Parent = TabContainer
        
        local TabFrame = Instance.new("Frame")
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = false
        TabFrame.Parent = ContentScrolling
        
        Tab.Button = TabButton
        Tab.Frame = TabFrame
        
        TabButton.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.Frame.Visible = false
                self:Tween(CurrentTab.Button, {TextColor3 = LikegenmUI.Colors.TextDim}, 0.2)
            end
            
            TabFrame.Visible = true
            CurrentTab = Tab
            
            self:Tween(TabButton, {TextColor3 = LikegenmUI.Colors.Text}, 0.2)
            self:Tween(TabIndicator, {
                Position = UDim2.new(0, (#Tabs * 85), 1, -3)
            }, 0.3, Enum.EasingStyle.Back)
        end)
        
        TabButton.MouseEnter:Connect(function()
            if CurrentTab ~= Tab then
                self:Tween(TabButton, {TextColor3 = LikegenmUI.Colors.Text}, 0.2)
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if CurrentTab ~= Tab then
                self:Tween(TabButton, {TextColor3 = LikegenmUI.Colors.TextDim}, 0.2)
            end
        end)
        
        function Tab:CreateSection(title, subtitle)
            local Section = {}
            local Elements = {}
            
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, 0, 0, 50)
            SectionFrame.BackgroundColor3 = LikegenmUI.Colors.Surface
            SectionFrame.BorderSizePixel = 0
            SectionFrame.Parent = TabFrame
            
            self:RoundedCorners(SectionFrame, 10)
            self:AddShadow(SectionFrame, 0.9)
            
            local SectionHeader = Instance.new("Frame")
            SectionHeader.Size = UDim2.new(1, -20, 0, 24)
            SectionHeader.Position = UDim2.new(0, 10, 0, 8)
            SectionHeader.BackgroundTransparency = 1
            SectionHeader.Parent = SectionFrame
            
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Size = UDim2.new(1, 0, 0, 24)
            SectionTitle.Text = title
            SectionTitle.TextColor3 = LikegenmUI.Colors.Text
            SectionTitle.Font = LikegenmUI.Fonts.Heading
            SectionTitle.TextSize = 16
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Parent = SectionHeader
            
            local SectionSubtitle
            if subtitle then
                SectionTitle.Size = UDim2.new(1, 0, 0, 16)
                
                SectionSubtitle = Instance.new("TextLabel")
                SectionSubtitle.Size = UDim2.new(1, 0, 0, 12)
                SectionSubtitle.Position = UDim2.new(0, 0, 0, 18)
                SectionSubtitle.Text = subtitle
                SectionSubtitle.TextColor3 = LikegenmUI.Colors.TextDim
                SectionSubtitle.Font = LikegenmUI.Fonts.Body
                SectionSubtitle.TextSize = 11
                SectionSubtitle.TextXAlignment = Enum.TextXAlignment.Left
                SectionSubtitle.BackgroundTransparency = 1
                SectionSubtitle.Parent = SectionHeader
                
                SectionHeader.Size = UDim2.new(1, -20, 0, 32)
            end
            
            local ElementsContainer = Instance.new("Frame")
            ElementsContainer.Size = UDim2.new(1, -20, 0, 0)
            ElementsContainer.Position = UDim2.new(0, 10, 0, subtitle and 40 or 32)
            ElementsContainer.BackgroundTransparency = 1
            ElementsContainer.AutomaticSize = Enum.AutomaticSize.Y
            ElementsContainer.Parent = SectionFrame
            
            local ElementsLayout = Instance.new("UIListLayout")
            ElementsLayout.Padding = UDim.new(0, 8)
            ElementsLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ElementsLayout.Parent = ElementsContainer
            
            ElementsContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                SectionFrame.Size = UDim2.new(1, 0, 0, (subtitle and 40 or 32) + ElementsContainer.AbsoluteSize.Y + 10)
            end)
            
            function Section:CreateToggle(options)
                local Toggle = {}
                local state = options.Default or false
                
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Size = UDim2.new(1, 0, 0, 32)
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.LayoutOrder = #Elements + 1
                ToggleFrame.Parent = ElementsContainer
                
                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
                ToggleLabel.Text = options.Text or "Toggle"
                ToggleLabel.TextColor3 = LikegenmUI.Colors.Text
                ToggleLabel.Font = LikegenmUI.Fonts.Body
                ToggleLabel.TextSize = 14
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Parent = ToggleFrame
                
                if options.Tooltip then
                    local TooltipIcon = Instance.new("TextLabel")
                    TooltipIcon.Size = UDim2.new(0, 16, 0, 16)
                    TooltipIcon.Position = UDim2.new(0.7, -20, 0.5, -8)
                    TooltipIcon.Text = "?"
                    TooltipIcon.TextColor3 = LikegenmUI.Colors.TextDim
                    TooltipIcon.Font = LikegenmUI.Fonts.Heading
                    TooltipIcon.TextSize = 12
                    TooltipIcon.BackgroundTransparency = 1
                    TooltipIcon.Parent = ToggleFrame
                    
                    local TooltipFrame = Instance.new("Frame")
                    TooltipFrame.Size = UDim2.new(0, 200, 0, 60)
                    TooltipFrame.Position = UDim2.new(0, -210, 0.5, -30)
                    TooltipFrame.BackgroundColor3 = LikegenmUI.Colors.Surface
                    TooltipFrame.BorderSizePixel = 0
                    TooltipFrame.Visible = false
                    TooltipFrame.ZIndex = 100
                    TooltipFrame.Parent = ToggleFrame
                    
                    self:RoundedCorners(TooltipFrame, 8)
                    self:AddShadow(TooltipFrame, 0.9)
                    
                    local TooltipText = Instance.new("TextLabel")
                    TooltipText.Size = UDim2.new(1, -10, 1, -10)
                    TooltipText.Position = UDim2.new(0, 5, 0, 5)
                    TooltipText.Text = options.Tooltip
                    TooltipText.TextColor3 = LikegenmUI.Colors.Text
                    TooltipText.Font = LikegenmUI.Fonts.Body
                    TooltipText.TextSize = 12
                    TooltipText.TextWrapped = true
                    TooltipText.BackgroundTransparency = 1
                    TooltipText.Parent = TooltipFrame
                    
                    TooltipIcon.MouseEnter:Connect(function()
                        TooltipFrame.Visible = true
                        self:Tween(TooltipFrame, {Size = UDim2.new(0, 200, 0, 60)}, 0.2)
                    end)
                    
                    TooltipIcon.MouseLeave:Connect(function()
                        self:Tween(TooltipFrame, {Size = UDim2.new(0, 0, 0, 60)}, 0.2)
                        wait(0.2)
                        TooltipFrame.Visible = false
                    end)
                end
                
                local ToggleSwitch = Instance.new("Frame")
                ToggleSwitch.Size = UDim2.new(0, 48, 0, 24)
                ToggleSwitch.Position = UDim2.new(1, -50, 0.5, -12)
                ToggleSwitch.BackgroundColor3 = state and LikegenmUI.Colors.Success or LikegenmUI.Colors.SurfaceLight
                ToggleSwitch.BorderSizePixel = 0
                ToggleSwitch.Parent = ToggleFrame
                
                self:RoundedCorners(ToggleSwitch, 12)
                
                local ToggleKnob = Instance.new("Frame")
                ToggleKnob.Size = UDim2.new(0, 18, 0, 18)
                ToggleKnob.Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
                ToggleKnob.BackgroundColor3 = Color3.new(1, 1, 1)
                ToggleKnob.BorderSizePixel = 0
                ToggleKnob.Parent = ToggleSwitch
                
                self:RoundedCorners(ToggleKnob, 9)
                self:AddShadow(ToggleKnob, 0.6)
                
                local function updateVisuals()
                    self:Tween(ToggleSwitch, {
                        BackgroundColor3 = state and LikegenmUI.Colors.Success or LikegenmUI.Colors.SurfaceLight
                    }, 0.2)
                    
                    self:Tween(ToggleKnob, {
                        Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
                    }, 0.2)
                    
                    if options.Callback then
                        options.Callback(state)
                    end
                end
                
                ToggleSwitch.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        state = not state
                        updateVisuals()
                    end
                end)
                
                function Toggle:SetValue(newState)
                    state = newState
                    updateVisuals()
                end
                
                function Toggle:GetValue()
                    return state
                end
                
                table.insert(Elements, Toggle)
                return Toggle
            end
            
            function Section:CreateSlider(options)
                local Slider = {}
                local value = options.Default or options.Min or 0
                local dragging = false
                
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Size = UDim2.new(1, 0, 0, 54)
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.LayoutOrder = #Elements + 1
                SliderFrame.Parent = ElementsContainer
                
                local SliderHeader = Instance.new("Frame")
                SliderHeader.Size = UDim2.new(1, 0, 0, 20)
                SliderHeader.BackgroundTransparency = 1
                SliderHeader.Parent = SliderFrame
                
                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.Size = UDim2.new(0.7, 0, 1, 0)
                SliderLabel.Text = options.Text or "Slider"
                SliderLabel.TextColor3 = LikegenmUI.Colors.Text
                SliderLabel.Font = LikegenmUI.Fonts.Body
                SliderLabel.TextSize = 14
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Parent = SliderHeader
                
                local ValueLabel = Instance.new("TextLabel")
                ValueLabel.Size = UDim2.new(0.3, 0, 1, 0)
                ValueLabel.Position = UDim2.new(0.7, 0, 0, 0)
                ValueLabel.Text = tostring(value) .. (options.Suffix or "")
                ValueLabel.TextColor3 = LikegenmUI.Colors.Primary
                ValueLabel.Font = LikegenmUI.Fonts.Heading
                ValueLabel.TextSize = 14
                ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.Parent = SliderHeader
                
                local SliderBar = Instance.new("Frame")
                SliderBar.Size = UDim2.new(1, 0, 0, 6)
                SliderBar.Position = UDim2.new(0, 0, 0, 32)
                SliderBar.BackgroundColor3 = LikegenmUI.Colors.SurfaceLight
                SliderBar.BorderSizePixel = 0
                SliderBar.Parent = SliderFrame
                
                self:RoundedCorners(SliderBar, 3)
                
                local SliderFill = Instance.new("Frame")
                local fillWidth = (value - options.Min) / (options.Max - options.Min)
                SliderFill.Size = UDim2.new(fillWidth, 0, 1, 0)
                SliderFill.BackgroundColor3 = LikegenmUI.Colors.Primary
                SliderFill.BorderSizePixel = 0
                SliderFill.Parent = SliderBar
                
                self:RoundedCorners(SliderFill, 3)
                
                local SliderHandle = Instance.new("Frame")
                SliderHandle.Size = UDim2.new(0, 20, 0, 20)
                SliderHandle.Position = UDim2.new(fillWidth, -10, 0.5, -10)
                SliderHandle.BackgroundColor3 = Color3.new(1, 1, 1)
                SliderHandle.BorderSizePixel = 0
                SliderHandle.Parent = SliderBar
                
                self:RoundedCorners(SliderHandle, 10)
                self:AddShadow(SliderHandle, 0.6)
                
                local function updateValue(newValue)
                    newValue = math.clamp(newValue, options.Min, options.Max)
                    if options.Rounding and options.Rounding > 0 then
                        newValue = math.floor(newValue * (10 ^ options.Rounding)) / (10 ^ options.Rounding)
                    else
                        newValue = math.floor(newValue)
                    end
                    
                    value = newValue
                    ValueLabel.Text = tostring(value) .. (options.Suffix or "")
                    
                    local percentage = (newValue - options.Min) / (options.Max - options.Min)
                    self:Tween(SliderFill, {Size = UDim2.new(percentage, 0, 1, 0)}, 0.1)
                    self:Tween(SliderHandle, {Position = UDim2.new(percentage, -10, 0.5, -10)}, 0.1)
                    
                    if options.Callback then
                        options.Callback(value)
                    end
                end
                
                SliderHandle.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        local relativeX = (input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                        local newValue = options.Min + (relativeX * (options.Max - options.Min))
                        updateValue(newValue)
                    end
                end)
                
                game:GetService("UserInputService").InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                game:GetService("UserInputService").InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local relativeX = (input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
                        local newValue = options.Min + (math.clamp(relativeX, 0, 1) * (options.Max - options.Min))
                        updateValue(newValue)
                    end
                end)
                
                function Slider:SetValue(newValue)
                    updateValue(newValue)
                end
                
                function Slider:GetValue()
                    return value
                end
                
                table.insert(Elements, Slider)
                return Slider
            end
            
            function Section:CreateButton(options)
                local ButtonFrame = Instance.new("Frame")
                ButtonFrame.Size = UDim2.new(1, 0, 0, 36)
                ButtonFrame.BackgroundTransparency = 1
                ButtonFrame.LayoutOrder = #Elements + 1
                ButtonFrame.Parent = ElementsContainer
                
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, 0, 1, 0)
                Button.Text = options.Text or "Button"
                Button.TextColor3 = LikegenmUI.Colors.Text
                Button.Font = LikegenmUI.Fonts.Heading
                Button.TextSize = 14
                Button.BackgroundColor3 = LikegenmUI.Colors.Primary
                Button.AutoButtonColor = false
                Button.Parent = ButtonFrame
                
                self:RoundedCorners(Button, 8)
                
                if options.Icon then
                    local IconLabel = Instance.new("TextLabel")
                    IconLabel.Size = UDim2.new(0, 24, 1, 0)
                    IconLabel.Position = UDim2.new(0, 10, 0, 0)
                    IconLabel.Text = options.Icon
                    IconLabel.TextColor3 = LikegenmUI.Colors.Text
                    IconLabel.Font = LikegenmUI.Fonts.Title
                    IconLabel.TextSize = 18
                    IconLabel.BackgroundTransparency = 1
                    IconLabel.Parent = Button
                    
                    Button.TextXAlignment = Enum.TextXAlignment.Left
                    Button.Text = "  " .. Button.Text
                end
                
                Button.MouseEnter:Connect(function()
                    self:Tween(Button, {BackgroundColor3 = LikegenmUI.Colors.PrimaryLight}, 0.2)
                end)
                
                Button.MouseLeave:Connect(function()
                    self:Tween(Button, {BackgroundColor3 = LikegenmUI.Colors.Primary}, 0.2)
                end)
                
                Button.MouseButton1Click:Connect(function()
                    self:Tween(Button, {Size = UDim2.new(0.98, 0, 0.9, 0)}, 0.1)
                    self:Tween(Button, {Position = UDim2.new(0.01, 0, 0.05, 0)}, 0.1)
                    
                    if options.Callback then
                        options.Callback()
                    end
                    
                    wait(0.1)
                    self:Tween(Button, {Size = UDim2.new(1, 0, 1, 0)}, 0.1)
                    self:Tween(Button, {Position = UDim2.new(0, 0, 0, 0)}, 0.1)
                end)
                
                table.insert(Elements, Button)
                return Button
            end
            
            function Section:CreateLabel(text, size)
                local LabelFrame = Instance.new("Frame")
                LabelFrame.Size = UDim2.new(1, 0, 0, size or 20)
                LabelFrame.BackgroundTransparency = 1
                LabelFrame.LayoutOrder = #Elements + 1
                LabelFrame.Parent = ElementsContainer
                
                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, 0, 1, 0)
                Label.Text = text
                Label.TextColor3 = LikegenmUI.Colors.TextDim
                Label.Font = LikegenmUI.Fonts.Body
                Label.TextSize = size or 14
                Label.TextWrapped = true
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.BackgroundTransparency = 1
                Label.Parent = LabelFrame
                
                table.insert(Elements, Label)
                return Label
            end
            
            function Section:CreateDivider()
                local DividerFrame = Instance.new("Frame")
                DividerFrame.Size = UDim2.new(1, 0, 0, 1)
                DividerFrame.BackgroundTransparency = 1
                DividerFrame.LayoutOrder = #Elements + 1
                DividerFrame.Parent = ElementsContainer
                
                local Divider = Instance.new("Frame")
                Divider.Size = UDim2.new(1, 0, 0, 1)
                Divider.BackgroundColor3 = LikegenmUI.Colors.Border
                Divider.BorderSizePixel = 0
                Divider.Parent = DividerFrame
                
                table.insert(Elements, Divider)
                return Divider
            end
            
            function Section:CreateDropdown(options)
                local Dropdown = {}
                local selected = options.Default or 1
                local open = false
                
                local DropdownFrame = Instance.new("Frame")
                DropdownFrame.Size = UDim2.new(1, 0, 0, 36)
                DropdownFrame.BackgroundTransparency = 1
                DropdownFrame.LayoutOrder = #Elements + 1
                DropdownFrame.Parent = ElementsContainer
                
                local DropdownButton = Instance.new("TextButton")
                DropdownButton.Size = UDim2.new(1, 0, 1, 0)
                DropdownButton.Text = options.Values[selected]
                DropdownButton.TextColor3 = LikegenmUI.Colors.Text
                DropdownButton.Font = LikegenmUI.Fonts.Body
                DropdownButton.TextSize = 14
                DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
                DropdownButton.BackgroundColor3 = LikegenmUI.Colors.SurfaceLight
                DropdownButton.AutoButtonColor = false
                DropdownButton.Parent = DropdownFrame
                
                self:RoundedCorners(DropdownButton, 6)
                
                local DropdownIcon = Instance.new("TextLabel")
                DropdownIcon.Size = UDim2.new(0, 20, 0, 20)
                DropdownIcon.Position = UDim2.new(1, -25, 0.5, -10)
                DropdownIcon.Text = "▼"
                DropdownIcon.TextColor3 = LikegenmUI.Colors.TextDim
                DropdownIcon.Font = LikegenmUI.Fonts.Body
                DropdownIcon.TextSize = 12
                DropdownIcon.BackgroundTransparency = 1
                DropdownIcon.Parent = DropdownButton
                
                local DropdownList = Instance.new("Frame")
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.Position = UDim2.new(0, 0, 1, 5)
                DropdownList.BackgroundColor3 = LikegenmUI.Colors.SurfaceLight
                DropdownList.BorderSizePixel = 0
                DropdownList.ClipsDescendants = true
                DropdownList.Visible = false
                DropdownList.ZIndex = 10
                DropdownList.Parent = DropdownFrame
                
                self:RoundedCorners(DropdownList, 6)
                self:AddShadow(DropdownList, 0.9)
                
                local ListLayout = Instance.new("UIListLayout")
                ListLayout.Padding = UDim.new(0, 1)
                ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                ListLayout.Parent = DropdownList
                
                local function toggleDropdown()
                    open = not open
                    
                    if open then
                        DropdownList.Visible = true
                        self:Tween(DropdownList, {Size = UDim2.new(1, 0, 0, #options.Values * 32)}, 0.2)
                        self:Tween(DropdownIcon, {Rotation = 180}, 0.2)
                    else
                        self:Tween(DropdownList, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
                        self:Tween(DropdownIcon, {Rotation = 0}, 0.2)
                        wait(0.2)
                        DropdownList.Visible = false
                    end
                end
                
                DropdownButton.MouseButton1Click:Connect(toggleDropdown)
                
                DropdownButton.MouseEnter:Connect(function()
                    self:Tween(DropdownButton, {BackgroundColor3 = LikegenmUI.Colors.Surface}, 0.2)
                end)
                
                DropdownButton.MouseLeave:Connect(function()
                    self:Tween(DropdownButton, {BackgroundColor3 = LikegenmUI.Colors.SurfaceLight}, 0.2)
                end)
                
                for i, value in ipairs(options.Values) do
                    local OptionButton = Instance.new("TextButton")
                    OptionButton.Size = UDim2.new(1, 0, 0, 32)
                    OptionButton.Text = value
                    OptionButton.TextColor3 = LikegenmUI.Colors.TextDim
                    OptionButton.Font = LikegenmUI.Fonts.Body
                    OptionButton.TextSize = 14
                    OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                    OptionButton.BackgroundColor3 = i == selected and LikegenmUI.Colors.Primary or LikegenmUI.Colors.SurfaceLight
                    OptionButton.AutoButtonColor = false
                    OptionButton.ZIndex = 11
                    OptionButton.Parent = DropdownList
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        selected = i
                        DropdownButton.Text = value
                        toggleDropdown()
                        
                        if options.Callback then
                            options.Callback(value, i)
                        end
                    end)
                    
                    OptionButton.MouseEnter:Connect(function()
                        if i ~= selected then
                            self:Tween(OptionButton, {
                                BackgroundColor3 = LikegenmUI.Colors.Surface,
                                TextColor3 = LikegenmUI.Colors.Text
                            }, 0.2)
                        end
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        if i ~= selected then
                            self:Tween(OptionButton, {
                                BackgroundColor3 = LikegenmUI.Colors.SurfaceLight,
                                TextColor3 = LikegenmUI.Colors.TextDim
                            }, 0.2)
                        end
                    end)
                end
                
                function Dropdown:SetValue(index)
                    if options.Values[index] then
                        selected = index
                        DropdownButton.Text = options.Values[index]
                        
                        if options.Callback then
                            options.Callback(options.Values[index], index)
                        end
                    end
                end
                
                function Dropdown:GetValue()
                    return selected, options.Values[selected]
                end
                
                table.insert(Elements, Dropdown)
                return Dropdown
            end
            
            table.insert(Sections, Section)
            return Section
        end
        
        table.insert(Tabs, Tab)
        if #Tabs == 1 then
            TabFrame.Visible = true
            CurrentTab = Tab
            TabIndicator.Visible = true
            TabIndicator.Position = UDim2.new(0, 0, 1, -3)
            self:Tween(TabButton, {TextColor3 = LikegenmUI.Colors.Text}, 0.2)
        end
        
        return Tab
    end
    
    function Window:SetTitle(title)
        TitleLabel.Text = title
    end
    
    function Window:SetSubtitle(subtitle)
        SubtitleLabel.Text = subtitle
    end
    
    function Window:Destroy()
        ScreenGui:Destroy()
    end
    
    function Window:Toggle()
        toggleWindow()
    end
    
    return Window
end

return LikegenmUI
