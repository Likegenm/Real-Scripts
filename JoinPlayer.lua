local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Player Joiner',
    Center = true,
    AutoShow = true
})

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local placeId = game.PlaceId

local function UsernameToID(name)
    local success, result = pcall(function()
        local r = game:HttpGet("https://api.roblox.com/users/get-by-username?username=" .. name)
        local data = HttpService:JSONDecode(r)
        return data and data.Id
    end)
    return success and result
end

local function GetPublicServers()
    local servers = {}
    local cursor = ""
    repeat
        local success, result = pcall(function()
            local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?limit=100&cursor="..cursor
            local response = game:HttpGet(url)
            return HttpService:JSONDecode(response)
        end)
        if success and result and result.data then
            for _, sv in pairs(result.data) do
                table.insert(servers, sv)
            end
            cursor = result.nextPageCursor or ""
        else
            cursor = ""
        end
    until cursor == "" or cursor == nil
    return servers
end

local Tabs = {
    Main = Window:AddTab('Main'),
    Settings = Window:AddTab('Settings')
}

local MainGroup = Tabs.Main:AddLeftGroupbox('Player Joiner')

local statusLabel = MainGroup:AddLabel('Ready to join')
statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)

MainGroup:AddInput('UsernameInput', {
    Default = '',
    Text = 'Username',
    Placeholder = 'Enter username...'
})

MainGroup:AddButton('Join Player', function()
    local username = Options.UsernameInput.Value
    if username == "" then
        statusLabel.Text = "Enter username"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(2)
        statusLabel.Text = "Ready"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        return
    end
    
    statusLabel.Text = "Checking..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    
    local userId = UsernameToID(username)
    if not userId then
        statusLabel.Text = "Invalid username"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(2)
        statusLabel.Text = "Ready"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        return
    end
    
    statusLabel.Text = "Searching servers..."
    
    local servers = GetPublicServers()
    for _, sv in pairs(servers) do
        if sv.playerIds then
            for _, plr in pairs(sv.playerIds) do
                if tostring(plr) == tostring(userId) then
                    statusLabel.Text = "Joining..."
                    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
                    TeleportService:TeleportToPlaceInstance(placeId, sv.id, Players.LocalPlayer)
                    return
                end
            end
        end
    end
    
    statusLabel.Text = "Player not found"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    task.wait(2)
    statusLabel.Text = "Ready"
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
end)

MainGroup:AddDivider()
MainGroup:AddLabel('Advanced')

MainGroup:AddInput('UserIdInput', {
    Default = '',
    Text = 'User ID (optional)',
    Placeholder = 'Direct UserId...'
})

MainGroup:AddButton('Join by UserId', function()
    local userId = Options.UserIdInput.Value
    if userId == "" then
        statusLabel.Text = "Enter UserId"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(2)
        statusLabel.Text = "Ready"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        return
    end
    
    userId = tonumber(userId)
    if not userId then
        statusLabel.Text = "Invalid UserId"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(2)
        statusLabel.Text = "Ready"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        return
    end
    
    statusLabel.Text = "Searching..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    
    local servers = GetPublicServers()
    for _, sv in pairs(servers) do
        if sv.playerIds then
            for _, plr in pairs(sv.playerIds) do
                if tostring(plr) == tostring(userId) then
                    statusLabel.Text = "Joining..."
                    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
                    TeleportService:TeleportToPlaceInstance(placeId, sv.id, Players.LocalPlayer)
                    return
                end
            end
        end
    end
    
    statusLabel.Text = "Player not found"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    task.wait(2)
    statusLabel.Text = "Ready"
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
end)

local RightGroup = Tabs.Main:AddRightGroupbox('Server Info')
RightGroup:AddLabel('Current Game: ' .. game.PlaceId)

RightGroup:AddButton('Refresh Servers', function()
    statusLabel.Text = "Refreshing..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    task.wait(0.5)
    statusLabel.Text = "Ready"
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
end)

RightGroup:AddButton('Copy PlaceId', function()
    setclipboard(tostring(game.PlaceId))
    statusLabel.Text = "Copied!"
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    task.wait(1)
    statusLabel.Text = "Ready"
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
end)

local MenuGroup = Tabs.Settings:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu Keybind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true })
Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
SaveManager:LoadAutoloadConfig()
