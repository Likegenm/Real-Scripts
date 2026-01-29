local Notification = function(title, message, style, buttons)
    local Player = game:GetService("Players").LocalPlayer
    local Gui = Player:FindFirstChildOfClass("PlayerGui") or Player:WaitForChild("PlayerGui")
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Notification"
    ScreenGui.Parent = Gui
    ScreenGui.DisplayOrder = 999
    
    local textService = game:GetService("TextService")
    local textSize = textService:GetTextSize(message, 14, Enum.Font.Gotham, Vector2.new(310, math.huge))
    local textHeight = math.min(textSize.Y, 150)
    local baseHeight = 100
    local buttonHeight = buttons and #buttons > 0 and 35 or 0
    local totalHeight = baseHeight + textHeight + buttonHeight
    
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.new(0, 350, 0, totalHeight)
    Main.Position = UDim2.new(0.5, -175, 0.05, 0)
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Main
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(255, 60, 60)
    Stroke.Thickness = 2
    Stroke.Parent = Main
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -20, 0, 30)
    TitleLabel.Position = UDim2.new(0, 10, 0, 10)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title or "NOTIFICATION"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Main
    
    local Line = Instance.new("Frame")
    Line.Name = "Line"
    Line.Size = UDim2.new(1, -20, 0, 1)
    Line.Position = UDim2.new(0, 10, 0, 45)
    Line.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Line.BorderSizePixel = 0
    Line.Parent = Main
    
    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Name = "Message"
    MessageLabel.Size = UDim2.new(1, -20, 0, textHeight)
    MessageLabel.Position = UDim2.new(0, 10, 0, 50)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = message or ""
    MessageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MessageLabel.TextSize = 14
    MessageLabel.Font = Enum.Font.Gotham
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
    MessageLabel.TextWrapped = true
    MessageLabel.Parent = Main
    
    if buttons and #buttons > 0 then
        local buttonContainer = Instance.new("Frame")
        buttonContainer.Name = "ButtonContainer"
        buttonContainer.Size = UDim2.new(1, -20, 0, 30)
        buttonContainer.Position = UDim2.new(0, 10, 1, -40)
        buttonContainer.BackgroundTransparency = 1
        buttonContainer.Parent = Main
        
        local buttonCount = math.min(#buttons, 3)
        local buttonWidth = (350 - 20 - ((buttonCount - 1) * 10)) / buttonCount
        
        for i, buttonData in ipairs(buttons) do
            if i > 3 then break end
            
            local button = Instance.new("TextButton")
            button.Name = "Button"..i
            button.Size = UDim2.new(0, buttonWidth, 1, 0)
            button.Position = UDim2.new(0, (i-1) * (buttonWidth + 10), 0, 0)
            button.BackgroundColor3 = buttonData.Color or Color3.fromRGB(255, 60, 60)
            button.BorderSizePixel = 0
            button.Text = buttonData.Text or "Button"
            button.TextColor3 = Color3.new(1, 1, 1)
            button.TextSize = 12
            button.Font = Enum.Font.GothamBold
            button.Parent = buttonContainer
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 4)
            ButtonCorner.Parent = button
            
            button.MouseButton1Click:Connect(function()
                if buttonData.Callback then
                    buttonData.Callback()
                end
                ScreenGui:Destroy()
            end)
        end
    else
        local CloseButton = Instance.new("TextButton")
        CloseButton.Name = "Close"
        CloseButton.Size = UDim2.new(0, 60, 0, 25)
        CloseButton.Position = UDim2.new(1, -70, 1, -35)
        CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        CloseButton.BorderSizePixel = 0
        CloseButton.Text = "Accept"
        CloseButton.TextColor3 = Color3.new(1, 1, 1)
        CloseButton.TextSize = 12
        CloseButton.Font = Enum.Font.GothamBold
        CloseButton.Parent = Main
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 4)
        ButtonCorner.Parent = CloseButton
        
        CloseButton.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)
    end
    
    if style == "success" then
        Stroke.Color = Color3.fromRGB(60, 255, 100)
        TitleLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
    elseif style == "warning" then
        Stroke.Color = Color3.fromRGB(255, 180, 60)
        TitleLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    elseif style == "info" then
        Stroke.Color = Color3.fromRGB(60, 150, 255)
        TitleLabel.TextColor3 = Color3.fromRGB(100, 180, 255)
    end
    
    task.wait(10)
    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()
    end
end

Notification("Warning", "Likegenm scripts", "warning", {
    {
        Text = "I ACCEPT",
        Color = Color3.fromRGB(255, 180, 60),
        Callback = function()
            print("Terms accepted")
        end
    },
    {
        Text = "DECLINE",
        Color = Color3.fromRGB(255, 60, 60),
        Callback = function()
            game.Players.LocalPlayer:Kick("Kick :)")
        end
    },
    {
        Text = "Privacy policy",
        Color = Color3.fromRGB(60, 150, 255),
        Callback = function()
            if setclipboard then
                setclipboard("https://github.com/Likegenm/Real-Scripts/blob/main/README.md")
            else
                print("https://github.com/Likegenm/Real-Scripts/blob/main/README.md")
            end
        end
    }
})
