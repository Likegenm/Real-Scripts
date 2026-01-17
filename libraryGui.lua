-- Mystic Lib (Vape V4 стиль)
local MysticLib = {}

-- Основные цвета Vape стиля
MysticLib.Colors = {
    Background = Color3.fromRGB(30, 30, 35),
    Section = Color3.fromRGB(40, 40, 45),
    Accent = Color3.fromRGB(120, 80, 200),
    Text = Color3.fromRGB(240, 240, 240),
    ToggleOn = Color3.fromRGB(100, 200, 100),
    ToggleOff = Color3.fromRGB(80, 80, 80)
}

function MysticLib:CreateWindow(options)
    local Window = {}
    
    -- Создаем основной GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MysticLib"
    ScreenGui.Parent = game.CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    MainFrame.BackgroundColor3 = MysticLib.Colors.Background
    MainFrame.Parent = ScreenGui
    
    -- Заголовок
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = MysticLib.Colors.Accent
    TitleBar.Parent = MainFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Text = options.Name or "Mystic Lib"
    TitleLabel.TextColor3 = Color3.new(1, 1, 1)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Size = UDim2.new(1, 0, 1, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = TitleBar
    
    -- Вкладки
    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(1, 0, 0, 40)
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = MainFrame
    
    -- Контент
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -20, 1, -80)
    ContentFrame.Position = UDim2.new(0, 10, 0, 70)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame
    
    local Tabs = {}
    local CurrentTab = nil
    
    function Window:CreateTab(name)
        local Tab = {}
        
        -- Кнопка таба
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 80, 1, 0)
        TabButton.Position = UDim2.new(0, (#Tabs * 85), 0, 0)
        TabButton.Text = name
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextColor3 = MysticLib.Colors.Text
        TabButton.BackgroundColor3 = MysticLib.Colors.Section
        TabButton.Parent = TabContainer
        
        -- Контент таба
        local TabFrame = Instance.new("Frame")
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = false
        TabFrame.Parent = ContentFrame
        
        Tab.Frame = TabFrame
        
        TabButton.MouseButton1Click:Connect(function()
            if CurrentTab then
                CurrentTab.Frame.Visible = false
            end
            TabFrame.Visible = true
            CurrentTab = Tab
        end)
        
        -- Функции для элементов
        function Tab:CreateSection(name)
            local Section = {}
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, -10, 0, 200)
            SectionFrame.Position = UDim2.new(0, 5, 0, (#TabFrame:GetChildren() * 205))
            SectionFrame.BackgroundColor3 = MysticLib.Colors.Section
            SectionFrame.Parent = TabFrame
            
            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Size = UDim2.new(1, 0, 0, 25)
            SectionLabel.Text = name
            SectionLabel.Font = Enum.Font.GothamBold
            SectionLabel.TextColor3 = MysticLib.Colors.Text
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Parent = SectionFrame
            
            local ElementsFrame = Instance.new("Frame")
            ElementsFrame.Size = UDim2.new(1, -10, 1, -30)
            ElementsFrame.Position = UDim2.new(0, 5, 0, 25)
            ElementsFrame.BackgroundTransparency = 1
            ElementsFrame.Parent = SectionFrame
            
            -- Создание элементов
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
                ToggleLabel.TextColor3 = MysticLib.Colors.Text
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Parent = ToggleFrame
                
                local ToggleButton = Instance.new("Frame")
                ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                ToggleButton.Position = UDim2.new(0.8, 0, 0.5, -10)
                ToggleButton.BackgroundColor3 = enabled and MysticLib.Colors.ToggleOn or MysticLib.Colors.ToggleOff
                ToggleButton.Parent = ToggleFrame
                
                local ToggleCircle = Instance.new("Frame")
                ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
                ToggleCircle.Position = enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                ToggleCircle.BackgroundColor3 = Color3.new(1, 1, 1)
                ToggleCircle.Parent = ToggleButton
                
                ToggleButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        enabled = not enabled
                        ToggleButton.BackgroundColor3 = enabled and MysticLib.Colors.ToggleOn or MysticLib.Colors.ToggleOff
                        
                        local tween = game:GetService("TweenService"):Create(
                            ToggleCircle,
                            TweenInfo.new(0.2),
                            {Position = enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}
                        )
                        tween:Play()
                        
                        if options.Callback then
                            options.Callback(enabled)
                        end
                    end
                end)
                
                function Toggle:SetValue(value)
                    enabled = value
                    ToggleButton.BackgroundColor3 = enabled and MysticLib.Colors.ToggleOn or MysticLib.Colors.ToggleOff
                    
                    local tween = game:GetService("TweenService"):Create(
                        ToggleCircle,
                        TweenInfo.new(0.2),
                        {Position = enabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}
                    )
                    tween:Play()
                    
                    if options.Callback then
                        options.Callback(enabled)
                    end
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
                SliderLabel.Size = UDim2.new(1, 0, 0, 20)
                SliderLabel.Text = options.Text or "Slider"
                SliderLabel.Font = Enum.Font.Gotham
                SliderLabel.TextColor3 = MysticLib.Colors.Text
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Parent = SliderFrame
                
                local ValueLabel = Instance.new("TextLabel")
                ValueLabel.Size = UDim2.new(0, 50, 0, 20)
                ValueLabel.Position = UDim2.new(1, -50, 0, 0)
                ValueLabel.Text = tostring(value)
                ValueLabel.Font = Enum.Font.Gotham
                ValueLabel.TextColor3 = MysticLib.Colors.Text
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.Parent = SliderFrame
                
                local SliderBar = Instance.new("Frame")
                SliderBar.Size = UDim2.new(1, 0, 0, 6)
                SliderBar.Position = UDim2.new(0, 0, 0, 25)
                SliderBar.BackgroundColor3 = MysticLib.Colors.ToggleOff
                SliderBar.Parent = SliderFrame
                
                local SliderFill = Instance.new("Frame")
                SliderFill.Size = UDim2.new((value - options.Min) / (options.Max - options.Min), 0, 1, 0)
                SliderFill.BackgroundColor3 = MysticLib.Colors.Accent
                SliderFill.Parent = SliderBar
                
                local SliderButton = Instance.new("TextButton")
                SliderButton.Size = UDim2.new(0, 16, 0, 16)
                SliderButton.Position = UDim2.new((value - options.Min) / (options.Max - options.Min), -8, 0.5, -8)
                SliderButton.Text = ""
                SliderButton.BackgroundColor3 = Color3.new(1, 1, 1)
                SliderButton.Parent = SliderBar
                
                local dragging = false
                
                local function updateValue(newValue)
                    newValue = math.clamp(newValue, options.Min, options.Max)
                    value = newValue
                    ValueLabel.Text = tostring(math.floor(newValue))
                    SliderFill.Size = UDim2.new((newValue - options.Min) / (options.Max - options.Min), 0, 1, 0)
                    SliderButton.Position = UDim2.new((newValue - options.Min) / (options.Max - options.Min), -8, 0.5, -8)
                    
                    if options.Callback then
                        options.Callback(newValue)
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
                        local relativeX = input.Position.X - SliderBar.AbsolutePosition.X
                        local percentage = math.clamp(relativeX / SliderBar.AbsoluteSize.X, 0, 1)
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
                ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
                ButtonFrame.Position = UDim2.new(0, 0, 0, (#ElementsFrame:GetChildren() * 40))
                ButtonFrame.BackgroundTransparency = 1
                ButtonFrame.Parent = ElementsFrame
                
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, 0, 1, 0)
                Button.Text = options.Text or "Button"
                Button.Font = Enum.Font.Gotham
                Button.TextColor3 = MysticLib.Colors.Text
                Button.BackgroundColor3 = MysticLib.Colors.Accent
                Button.Parent = ButtonFrame
                
                Button.MouseButton1Click:Connect(function()
                    if options.Callback then
                        options.Callback()
                    end
                end)
                
                return Button
            end
            
            return Section
        end
        
        table.insert(Tabs, Tab)
        if #Tabs == 1 then
            TabFrame.Visible = true
            CurrentTab = Tab
        end
        
        return Tab
    end
    
    -- Делаем окно перетаскиваемым
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local startPos = input.Position
            local framePos = MainFrame.Position
            local connection
            
            connection = input.Changed:Connect(function()
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
    
    return Window
end

return MysticLib
