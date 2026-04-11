-- 03.01.26 (3 January)
--[[
Ку, тут все возможные способы обойти killplane

Hi, here are all the possible ways to bypass killplane

Для начала что такое Killplane

Killplane- это смерть в пустоте при -500 и меннее или более

First, what is a Killplane?

A Killplane is death in the void at -500 or less or more

]]


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
1. FallenPartsDestory
local function FPD(Value)
game:GetService("Workspace").FallenPartsDestroy = Value
end
FPD(-10000000)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
и да так как о всех способах я не знаю я буду просить помощи у ChatGPT

and yes, since I don't know about all the methods, I'll ask ChatGPT for help

2. Velocity

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local safePosition = Vector3.new(0, 100, 0)

RunService.Heartbeat:Connect(function()
    local character = player.Character
    if not character then return end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if root.Position.Y < -500 then
  
        root.Velocity = Vector3.new(0, 100, 0)
    end
end)

3. Update FallenPartsDestroy

local oldFindService
oldFindService = hookfunction(game.FindService, function(self, serviceName)
    if serviceName == "Workspace" then
        local fakeWorkspace = {}
        fakeWorkspace.FallenPartsDestroyHeight = -999999
        return fakeWorkspace
    end
    return oldFindService(self, serviceName)
end)

4. Platform
local f = game.workspace.FallenPartsDestroy + 2.5
local h = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
local p = Instance.new("Part")
p.name = "Part"
p.Size = Vector3.new(50, 5, 50)
p.Position = Vector3.new(h.X, f, h.Z)

------------------------------------------------------------------------------------------------------------------------------------------------------------------

04.11.26 (11 апреля) 
скрипт на обход пустоты
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

-- Параметры безопасной зоны
local TRIGGER_Y = -450  -- На какой высоте включать "режим бога"
local MOVE_SPEED = 50   -- Скорость перемещения вниз/вверх внутри зоны

-- Отключаем стандартное ограничение высоты (визуально)
workspace.FallenPartsDestroyHeight = -50000

-- Режим обхода
local godModeActive = false
local moveDirection = 0 -- -1 (вниз), 1 (вверх), 0 (стоим)

-- Отслеживаем нажатия клавиш для движения в зоне
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.S then moveDirection = -1 end
    if input.KeyCode == Enum.KeyCode.W then moveDirection = 1 end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.W then
        moveDirection = 0
    end
end)

-- Главный цикл обхода
RunService.Heartbeat:Connect(function()
    local currentY = hrp.Position.Y

    if currentY < TRIGGER_Y and not godModeActive then
        -- Заходим в "красную зону": включаем режим бога
        godModeActive = true
        hum.PlatformStand = true
        print("🛡️ Режим обхода активирован (глубина: " .. math.floor(currentY) .. ")")
    end

    if godModeActive then
        -- Если мы в зоне и жмём W/S — перемещаем персонажа твином
        if moveDirection ~= 0 then
            local targetY = hrp.Position.Y + (moveDirection * MOVE_SPEED * 0.1) -- плавное смещение
            
            local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(hrp, tweenInfo, {Position = Vector3.new(hrp.Position.X, targetY, hrp.Position.Z)})
            tween:Play()
        end

        -- Если мы поднялись обратно выше TRIGGER_Y, выключаем режим бога
        if hrp.Position.Y >= TRIGGER_Y then
            godModeActive = false
            hum.PlatformStand = false
            print("ANti Bypasser OFF")
        end
    end
end)
