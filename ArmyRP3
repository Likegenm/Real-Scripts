-- ЧАСТЬ 3/6: Оружие, транспорт и другие вкладки
local WeaponTab = Window:CreateTab("Weapon", 7072721560)

local GodWeaponToggle = WeaponTab:CreateToggle({
   Name = "God Weapon Mode", CurrentValue = false, Flag = "GodWeaponToggle",
   Callback = function(Value) GodWeaponEnabled = Value end,
})

local RefreshWeaponsButton = WeaponTab:CreateButton({
   Name = "Refresh Weapons",
   Callback = function() RefreshWeapons() end,
})

local VehicleTab = Window:CreateTab("Vehicle", 7072720917)

local FlyToggle = VehicleTab:CreateToggle({
   Name = "Car Fly", CurrentValue = false, Flag = "FlyToggle",
   Callback = function(Value) FlyEnabled = Value end,
})

local ItemsTab = Window:CreateTab("Items", 7072720370)

local RefreshItemsButton = ItemsTab:CreateButton({
   Name = "Refresh Items List",
   Callback = function() FindAndCopyItems() end,
})

ItemsTab:CreateParagraph({Title = "Items Info", Content = "Click 'Refresh Items List' to find available items in the game"})

local CreditsTab = Window:CreateTab("Credits", 7072718917)

CreditsTab:CreateLabel("Script by: likegenm")
CreditsTab:CreateLabel("UI Library: Rayfield")
CreditsTab:CreateParagraph({Title = "Thanks", Content = "Thanks for using this script!"})
