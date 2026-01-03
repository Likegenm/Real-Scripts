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
