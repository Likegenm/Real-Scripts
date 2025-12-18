local StarterGui = game:GetService("StarterGui")
local ScriptLoaded = false

local function checkExecutor()
    local executors = {
        ["Delta"] = is_sirhurt_closure,
        ["Synapse X"] = is_synapse_function,
        ["ProtoSmasher"] = pebc_instance,
        ["Krnl"] = KRNL_LOADED,
        ["ScriptWare"] = isexecutorclosure,
        ["Xeno"] = identifyexecutor,
        ["Solara"] = is_solara,
        ["Wave"] = is_wave,
        ["Cryptic"] = is_cryptic
    }
    
    for name, check in pairs(executors) do
        if check then
           StarterGui:SetCore("SendNotification", {
                Title = "Cheat Engine",
                Text = "Нажми OK чтобы загрузить скрипт",
                Icon = "",
                Duration = 10,
                Button1 = "OK",
                Callback = function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/Likegenm/1/refs/heads/main/zip2.lua"))()
                end
           })
           return
        end
    end
end

checkExecutor()
