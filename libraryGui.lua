-- Aurora UI - Современная библиотека с анимациями
local Aurora = {}

-- Современная цветовая палитра
Aurora.Colors = {
    Dark1 = Color3.fromRGB(18, 18, 24),
    Dark2 = Color3.fromRGB(28, 28, 36),
    Dark3 = Color3.fromRGB(38, 38, 48),
    Accent = Color3.fromRGB(136, 96, 208),
    AccentLight = Color3.fromRGB(156, 116, 228),
    Text = Color3.fromRGB(240, 240, 245),
    TextDim = Color3.fromRGB(180, 180, 190),
    Success = Color3.fromRGB(100, 200, 120),
    Warning = Color3.fromRGB(255, 180, 60),
    Danger = Color3.fromRGB(255, 100, 100)
}

-- Функция для скругленных углов
function Aurora:RoundedCorners(frame, radius)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, radius)
    UICorner.Parent = frame
    return UICorner
end

-- Функция для тени
function Aurora:AddShadow(frame)
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.8
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    Shadow.Size = UDim2.new(1, 36, 1, 36)
    Shadow.Position = UDim2.new(0, -18, 0, -18)
    Shadow.BackgroundTransparency = 1
    Shadow.Parent = frame
    return Shadow
end

-- Функция для плавных анимаций
function Aurora:Tween(object, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(
        duration or 0.3,
        easingStyle or Enum.EasingStyle.Quad,
        easingDirection or Enum.EasingDirection.Out
    )
    local tween = game:GetService("TweenService"):Create(object, tweenInfo, properties)
    tween:Play()
    return tween
end

function Aurora:CreateWindow(options)
    local Window = {}
    local Tabs = {}
    local CurrentTab = nil
    
    -- Создаем основной GUI (скрытый сначала)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AuroraUI"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Enabled = false -- Сначала скрыт
    
    -- Основное окно
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 520, 0, 440)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -220)
    MainFrame.BackgroundColor3 = Aurora.Colors.Dark1
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    Aurora:RoundedCorners(MainFrame, 12)
    Aurora:AddShadow(MainFrame)
    
    -- Заголовок с градиентом
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 42)
    TitleBar.BackgroundColor3 = Aurora.Colors.Dark2
    TitleBar.Parent = MainFrame
    
    Aurora:RoundedCorners(TitleBar, 12)
    
    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Aurora.Colors.Accent),
        ColorSequenceKeypoint.new(1, Aurora.Colors.AccentLight)
    })
    TitleGradient.Rotation = 90
    TitleGradient.Parent = TitleBar
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Text = options.Name or "Aurora UI"
    TitleLabel.TextColor3 = Color3.new(1, 1, 1)
    TitleLabel.Font = Enum.Font.GothamSemibold
    TitleLabel.TextSize = 18
    TitleLabel.Size = UDim2.new(1, -40, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 28, 0, 28)
    CloseButton.Position = UDim2.new(1, -33, 0.5, -14)
    CloseButton.Text = "×"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 20
    CloseButton.TextColor3 = Aurora.Colors.Text
    CloseButton.BackgroundColor3 = Aurora.Colors.Dark3
    CloseButton.AutoButtonColor = false
    CloseButton.Parent = TitleBar
    
    Aurora:RoundedCorners(CloseButton, 8)
    
    CloseButton.MouseEnter:Connect(function()
        Aurora:Tween(CloseButton, {BackgroundColor3 = Aurora.Colors.Danger}, 0.2)
    end)
    
    CloseButton.MouseLeave:Connect(function()
        Aurora:Tween(CloseButton, {BackgroundColor3 = Aurora.Colors.Dark3}, 0.2)
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        Aurora:Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
        wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Кнопки вкладок
    local TabButtonsFrame = Instance.new("Frame")
    TabButtonsFrame.Size = UDim2.new(1, -20, 0, 36)
    TabButtonsFrame.Position = UDim2.new(0, 10, 0, 50)
    TabButtonsFrame.BackgroundTransparency = 1
    TabButtonsFrame.Parent = MainFrame
    
    -- Контейнер для контента
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -20, 1, -110)
    ContentFrame.Position = UDim2.new(0, 10, 0, 94)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame
    
    -- Фон для секций
    local ContentBackground = Instance.new("Frame")
    ContentBackground.Size = UDim2.new(1, 0, 1, 0)
    ContentBackground.BackgroundColor3 = Aurora.Colors.Dark2
    ContentBackground.Parent = ContentFrame
    
    Aurora:RoundedCorners(ContentBackground, 8)
    
    -- Индикатор активной вкладки
    local TabIndicator = Instance.new("Frame")
    TabIndicator.Size = UDim2.new(0, 3, 0, 36)
    TabIndicator.BackgroundColor3 = Aurora.Colors.Accent
    TabIndicator.Visible = false
    TabIndicator.Parent = TabButtonsFrame
    
    Aurora:RoundedCorners(TabIndicator, 2)
    
    -- Кнопка для открытия GUI (в левом верхнем углу)
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 50, 0, 50)
    ToggleButton.Position = UDim2.new(0, 20, 0, 20)
    ToggleButton.Text = "☰"
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.TextSize = 24
    ToggleButton.TextColor3 = Aurora.Colors.Text
    ToggleButton.BackgroundColor3 = Aurora.Colors.Accent
    ToggleButton.AutoButtonColor = false
    ToggleButton.Parent = ScreenGui
    
    Aurora:RoundedCorners(ToggleButton, 12)
    Aurora:AddShadow(ToggleButton)
    
    local function toggleUI()
        if ScreenGui.Enabled then
            Aurora:Tween(MainFrame, {
                Size = UDim2.new(0, 0, 0, 440),
                Position = UDim2.new(0.5, 0, 0.5, -220)
            }, 0.3)
            wait(0.3)
            ScreenGui.Enabled = false
            Aurora:Tween(ToggleButton, {BackgroundColor3 = Aurora.Colors.Accent}, 0.2)
        else
            ScreenGui.Enabled = true
            Aurora:Tween(MainFrame, {
                Size = UDim2.new(0, 520, 0, 440),
                Position = UDim2.new(0.5, -260, 0.5, -220)
            }, 0.3)
            Aurora:Tween(ToggleButton, {BackgroundColor3 = Aurora.Colors.Success}, 0.2)
        end
    end
    
    ToggleButton.MouseButton1Click:Connect(toggleUI)
    
    -- Перетаскивание окна
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local startPos = input.Position
            local framePos = MainFrame.Position
            
            local connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    connection:Disconnect()
                else
                    local delta = input.Position - startPos
                    MainFrame.Position = UDim2.new(
                        framePos.X.Scale,
                        framePos.X.Offset + delta.X,
                        framePos.Y.Scale,
                        framePos.Y.Offset + delta.Y
                    )
                end
            end)
        end
    end)
    
    function Window:CreateTab(name, icon)
        local Tab = {}
        
        -- Кнопка таба
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.Position = UDim2.new(0, (#Tabs * 105), 0, 0)
        TabButton.Text = name
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.TextSize = 14
        TabButton.TextColor3 = Aurora.Colors.TextDim
        TabButton.BackgroundTransparency = 1
        TabButton.AutoButtonColor = false
        TabButton.Parent = TabButtonsFrame
        
        -- Контент таба
        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.BorderSizePixel = 0
        TabFrame.ScrollBarThickness = 4
        TabFrame.ScrollBarImageColor3 = Aurora.Colors.Dark3
        TabFrame.Visible = false
        TabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabFrame.Parent = ContentFrame
        
        Tab.Frame = TabFrame
        
        TabButton.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.Frame.Visible = false
                Aurora:Tween(TabIndicator, {
                    Position = UDim2.new(0, (#Tabs * 105), 0, 0)
                }, 0.2)
            end
            
            TabFrame.Visible = true
            CurrentTab = Tab
            
            Aurora:Tween(TabButton, {TextColor3 = Aurora.Colors.Text}, 0.2)
            for _, otherTab in pairs(Tabs) do
                if otherTab ~= Tab then
                    Aurora:Tween(otherTab.Button, {TextColor3 = Aurora.Colors.TextDim}, 0.2)
                end
            end
        end)
        
        Tab.Button = TabButton
        
        function Tab:CreateSection(name)
            local Section = {}
            
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, -20, 0, 40)
            SectionFrame.Position = UDim2.new(0, 10, 0, (#TabFrame:GetChildren() * 50) + 10)
            SectionFrame.BackgroundColor3 = Aurora.Colors.Dark3
            SectionFrame.Parent = TabFrame
            
            Aurora:RoundedCorners(SectionFrame, 8)
            
            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Size = UDim2.new(1, -20, 1, 0)
            SectionLabel.Position = UDim2.new(0, 15, 0, 0)
            SectionLabel.Text = name
            SectionLabel.Font = Enum.Font.GothamSemibold
            SectionLabel.TextSize = 14
            SectionLabel.TextColor3 = Aurora.Colors.Text
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Parent = SectionFrame
            
            local ElementsFrame = Instance.new("Frame")
            ElementsFrame.Size = UDim2.new(1, -20, 0, 0)
            ElementsFrame.Position = UDim2.new(0, 10, 0, 45)
            ElementsFrame.BackgroundTransparency = 1
            ElementsFrame.AutomaticSize = Enum.AutomaticSize.Y
            ElementsFrame.Parent = SectionFrame
            
            function Section:CreateToggle(options)
                local Toggle = {}
                local enabled = options.Default or false
                
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
                ToggleFrame.Position = UDim2.new(0, 0, 0, (#ElementsFrame:GetChildren() * 35))
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Parent = ElementsFrame
                
                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
                ToggleLabel.Text = options.Text or "Toggle"
                ToggleLabel.Font = Enum.Font.Gotham
                ToggleLabel.TextSize = 13
                ToggleLabel.TextColor3 = Aurora.Colors.Text
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Parent = ToggleFrame
                
                local ToggleButton = Instance.new("Frame")
                ToggleButton.Size = UDim2.new(0, 48, 0, 24)
                ToggleButton.Position = UDim2.new(1, -50, 0.5, -12)
                ToggleButton.BackgroundColor3 = enabled and Aurora.Colors.Success or Aurora.Colors.Dark2
                ToggleButton.Parent = ToggleFrame
                
                Aurora:RoundedCorners(ToggleButton, 12)
                
                local ToggleCircle = Instance.new("Frame")
                ToggleCircle.Size = UDim2.new(0, 18, 0, 18)
                ToggleCircle.Position = enabled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
                ToggleCircle.BackgroundColor3 = Color3.new(1, 1, 1)
                ToggleCircle.Parent = ToggleButton
                
                Aurora:RoundedCorners(ToggleCircle, 9)
                
                local function updateToggle()
                    Aurora:Tween(ToggleButton, {
                        BackgroundColor3 = enabled and Aurora.Colors.Success or Aurora.Colors.Dark2
                    }, 0.2)
                    
                    Aurora:Tween(ToggleCircle, {
                        Position = enabled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
                    }, 0.2)
                    
                    if options.Callback then
                        options.Callback(enabled)
                    end
                end
                
                ToggleButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        enabled = not enabled
                        updateToggle()
                    end
                end)
                
                function Toggle:SetValue(value)
                    enabled = value
                    updateToggle()
                end
                
                return Toggle
            end
            
            function Section:CreateSlider(options)
                local Slider = {}
                local value = options.Default or options.Min or 0
                
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Size = UDim2.new(1, 0, 0, 50)
                SliderFrame.Position = UDim2.new(0, 0, 0, (#ElementsFrame:GetChildren() * 55))
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.Parent = ElementsFrame
                
                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.Size = UDim2.new(1, -60, 0, 20)
                SliderLabel.Text = options.Text or "Slider"
                SliderLabel.Font = Enum.Font.Gotham
                SliderLabel.TextSize = 13
                SliderLabel.TextColor3 = Aurora.Colors.Text
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Parent = SliderFrame
                
                local ValueLabel = Instance.new("TextLabel")
                ValueLabel.Size = UDim2.new(0, 50, 0, 20)
                ValueLabel.Position = UDim2.new(1, -50, 0, 0)
                ValueLabel.Text = tostring(value)
                ValueLabel.Font = Enum.Font.GothamMedium
                ValueLabel.TextSize = 13
                ValueLabel.TextColor3 = Aurora.Colors.Accent
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
                ValueLabel.Parent = SliderFrame
                
                local SliderBar = Instance.new("Frame")
                SliderBar.Size = UDim2.new(1, 0, 0, 8)
                SliderBar.Position = UDim2.new(0, 0, 0, 25)
                SliderBar.BackgroundColor3 = Aurora.Colors.Dark2
                SliderBar.Parent = SliderFrame
                
                Aurora:RoundedCorners(SliderBar, 4)
                
                local SliderFill = Instance.new("Frame")
                SliderFill.Size = UDim2.new((value - options.Min) / (options.Max - options.Min), 0, 1, 0)
                SliderFill.BackgroundColor3 = Aurora.Colors.Accent
                SliderFill.Parent = SliderBar
                
                Aurora:RoundedCorners(SliderFill, 4)
                
                local SliderButton = Instance.new("TextButton")
                SliderButton.Size = UDim2.new(0, 20, 0, 20)
                SliderButton.Position = UDim2.new((value - options.Min) / (options.Max - options.Min), -10, 0.5, -10)
                SliderButton.Text = ""
                SliderButton.BackgroundColor3 = Color3.new(1, 1, 1)
                SliderButton.Parent = SliderBar
                
                Aurora:RoundedCorners(SliderButton, 10)
                Aurora:AddShadow(SliderButton)
                
                local dragging = false
                
                local function updateValue(newValue)
                    newValue = math.clamp(newValue, options.Min, options.Max)
                    value = math.floor(newValue)
                    ValueLabel.Text = tostring(value)
                    
                    local fillWidth = (newValue - options.Min) / (options.Max - options.Min)
                    Aurora:Tween(SliderFill, {Size = UDim2.new(fillWidth, 0, 1, 0)}, 0.1)
                    Aurora:Tween(SliderButton, {Position = UDim2.new(fillWidth, -10, 0.5, -10)}, 0.1)
                    
                    if options.Callback then
                        options.Callback(value)
                    end
                end
                
                SliderButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                
                game:GetService("UserInputService").InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                game:GetService("UserInputService").InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local relativeX = math.clamp(input.Position.X - SliderBar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
                        local percentage = relativeX / SliderBar.AbsoluteSize.X
                        local newValue = options.Min + (percentage * (options.Max - options.Min))
                        updateValue(newValue)
                    end
                end)
                
                function Slider:SetValue(newValue)
                    updateValue(newValue)
                end
                
                return Slider
            end
            
            function Section:CreateButton(options)
                local ButtonFrame = Instance.new("Frame")
                ButtonFrame.Size = UDim2.new(1, 0, 0, 36)
                ButtonFrame.Position = UDim2.new(0, 0, 0, (#ElementsFrame:GetChildren() * 41))
                ButtonFrame.BackgroundTransparency = 1
                ButtonFrame.Parent = ElementsFrame
                
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, 0, 1, 0)
                Button.Text = options.Text or "Button"
                Button.Font = Enum.Font.GothamMedium
                Button.TextSize = 14
                Button.TextColor3 = Aurora.Colors.Text
                Button.BackgroundColor3 = Aurora.Colors.Accent
                Button.AutoButtonColor = false
                Button.Parent = ButtonFrame
                
                Aurora:RoundedCorners(Button, 8)
                
                Button.MouseEnter:Connect(function()
                    Aurora:Tween(Button, {BackgroundColor3 = Aurora.Colors.AccentLight}, 0.2)
                end)
                
                Button.MouseLeave:Connect(function()
                    Aurora:Tween(Button, {BackgroundColor3 = Aurora.Colors.Accent}, 0.2)
                end)
                
                Button.MouseButton1Click:Connect(function()
                    if options.Callback then
                        Aurora:Tween(Button, {Size = UDim2.new(0.95, 0, 0.9, 0), Position = UDim2.new(0.025, 0, 0.05, 0)}, 0.1)
                        wait(0.1)
                        Aurora:Tween(Button, {Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0)}, 0.1)
                        options.Callback()
                    end
                end)
                
                return Button
            end
            
            -- Увеличиваем высоту секции под элементы
            ElementsFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                SectionFrame.Size = UDim2.new(1, -20, 0, 40 + ElementsFrame.AbsoluteSize.Y)
            end)
            
            return Section
        end
        
        table.insert(Tabs, Tab)
        if #Tabs == 1 then
            TabFrame.Visible = true
            CurrentTab = Tab
            TabIndicator.Visible = true
            TabIndicator.Position = UDim2.new(0, 0, 0, 0)
            Aurora:Tween(TabButton, {TextColor3 = Aurora.Colors.Text}, 0.2)
        end
        
        return Tab
    end
    
    -- Добавляем иконку на кнопку открытия
    if options.Icon then
        ToggleButton.Text = options.Icon
    end
    
    return Window
end

return Aurora
