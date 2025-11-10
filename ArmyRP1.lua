-- Загрузка библиотеки Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- Создание окна Rayfield с оранжевым фоном
local Window = Rayfield:CreateWindow({
   Name = "likegenm Script",
   LoadingTitle = "Rayfield Interface Suite",
   LoadingSubtitle = "by likegenm",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "likegenmConfig",
      FileName = "likegenm"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   Theme = {
      Background = Color3.fromRGB(255, 165, 0), -- Оранжевый фон
      Glow = Color3.fromRGB(255, 140, 0), -- Оранжевое свечение
      Accent = Color3.fromRGB(255, 100, 0), -- Акцентный оранжевый
      LightContrast = Color3.fromRGB(255, 180, 0), -- Светлый контраст
      DarkContrast = Color3.fromRGB(200, 100, 0), -- Темный контраст
      TextColor = Color3.fromRGB(255, 255, 255) -- Белый текст
   }
})

-- Variables
local InfJumpEnabled = false
local InfJumpCooldown = 0.1
local LastInfJumpTime = 0
local SpeedEnabled = false
local SpeedValue = 50
local SpiderEnabled = false
local SpiderDistance = 3
local SpiderSpeed = 50
local InvisEnabled = false
local AttachEnabled = false
local AttachDistance = 50
local NoclipEnabled = false
local NoFallEnabled = false
local FullbrightEnabled = false
local FovEnabled = false
local FovValue = 70
local AimbotEnabled = false
local AimbotColor = Color3.fromRGB(255, 0, 0)
local EspEnabled = false
local FlyEnabled = false
local GodWeaponEnabled = false
