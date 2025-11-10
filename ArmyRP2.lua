-- ЧАСТЬ 2/6: Вкладки и элементы управления
local ExploitsTab = Window:CreateTab("Exploits", 4483362458)

-- Movement Section
local MovementSection = ExploitsTab:CreateSection("Movement")

local InfJumpToggle = ExploitsTab:CreateToggle({
   Name = "Infinite Jump (Cooldown 0.1s)",
   CurrentValue = false,
   Flag = "InfJumpToggle",
   Callback = function(Value) InfJumpEnabled = Value end,
})

local SpeedToggle = ExploitsTab:CreateToggle({
   Name = "Speed Hack (Velocity)",
   CurrentValue = false,
   Flag = "SpeedToggle",
   Callback = function(Value) SpeedEnabled = Value end,
})

local SpeedSlider = ExploitsTab:CreateSlider({
   Name = "Speed Value", Range = {1, 100}, Increment = 1, Suffix = "speed",
   CurrentValue = 50, Flag = "SpeedValue",
   Callback = function(Value) SpeedValue = Value end,
})

local SpiderToggle = ExploitsTab:CreateToggle({
   Name = "Spider Mode", CurrentValue = false, Flag = "SpiderToggle",
   Callback = function(Value) SpiderEnabled = Value end,
})

local SpiderDistanceSlider = ExploitsTab:CreateSlider({
   Name = "Spider Distance", Range = {1, 5}, Increment = 0.1, Suffix = "studs",
   CurrentValue = 3, Flag = "SpiderDistance",
   Callback = function(Value) SpiderDistance = Value end,
})

local SpiderSpeedSlider = ExploitsTab:CreateSlider({
   Name = "Spider Speed", Range = {1, 100}, Increment = 1, Suffix = "speed",
   CurrentValue = 50, Flag = "SpiderSpeed",
   Callback = function(Value) SpiderSpeed = Value end,
})

-- Other Exploits Section
local OtherSection = ExploitsTab:CreateSection("Other Exploits")

local NoFallToggle = ExploitsTab:CreateToggle({
   Name = "NoFall (Anti Fall Damage)", CurrentValue = false, Flag = "NoFallToggle",
   Callback = function(Value) NoFallEnabled = Value end,
})

local InvisToggle = ExploitsTab:CreateToggle({
   Name = "Safe Invisible Mode (Client-side)", CurrentValue = false, Flag = "InvisToggle",
   Callback = function(Value)
      InvisEnabled = Value
      if Value then EnableSafeInvisible() else DisableSafeInvisible() end
   end,
})

local AttachToggle = ExploitsTab:CreateToggle({
   Name = "Attach to Player", CurrentValue = false, Flag = "AttachToggle",
   Callback = function(Value) AttachEnabled = Value end,
})

local AttachDistanceSlider = ExploitsTab:CreateSlider({
   Name = "Attach Distance", Range = {1, 1000}, Increment = 10, Suffix = "studs",
   CurrentValue = 50, Flag = "AttachDistance",
   Callback = function(Value) AttachDistance = Value end,
})

local NoclipToggle = ExploitsTab:CreateToggle({
   Name = "Noclip", CurrentValue = false, Flag = "NoclipToggle",
   Callback = function(Value) NoclipEnabled = Value end,
})

-- Visuals Tab
local VisualsTab = Window:CreateTab("Visuals", 7072718362)

local WorldVisualsSection = VisualsTab:CreateSection("World Visuals")

local FullbrightToggle = VisualsTab:CreateToggle({
   Name = "Fullbright", CurrentValue = false, Flag = "FullbrightToggle",
   Callback = function(Value)
      FullbrightEnabled = Value
      if Value then
         Lighting.Ambient = Color3.new(1, 1, 1)
         Lighting.Brightness = 2
         Lighting.GlobalShadows = false
      else
         Lighting.Ambient = Color3.new(0, 0, 0)
         Lighting.Brightness = 1
         Lighting.GlobalShadows = true
      end
   end,
})

local FovToggle = VisualsTab:CreateToggle({
   Name = "FOV Changer", CurrentValue = false, Flag = "FovToggle",
   Callback = function(Value) FovEnabled = Value end,
})

local FovSlider = VisualsTab:CreateSlider({
   Name = "FOV Value", Range = {30, 120}, Increment = 1, Suffix = "FOV",
   CurrentValue = 70, Flag = "FovValue",
   Callback = function(Value) FovValue = Value end,
})

local PlayerVisualsSection = VisualsTab:CreateSection("Player Visuals")

local EspToggle = VisualsTab:CreateToggle({
   Name = "ESP", CurrentValue = false, Flag = "EspToggle",
   Callback = function(Value)
      EspEnabled = Value
      if Value then EnableESP() else DisableESP() end
   end,
})

local AimbotToggle = VisualsTab:CreateToggle({
   Name = "Aimbot Highlight", CurrentValue = false, Flag = "AimbotToggle",
   Callback = function(Value) AimbotEnabled = Value end,
})

local AimbotColorPicker = VisualsTab:CreateColorPicker({
    Name = "Aimbot Color", Color = Color3.fromRGB(255,0,0), Flag = "AimbotColor",
    Callback = function(Value) AimbotColor = Value end
})
