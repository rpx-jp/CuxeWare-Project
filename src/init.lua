-- src/init.lua
local BaseUrl = "https://raw.githubusercontent.com/rpx-jp/CuxeWare-Project/main/src/"

local folderName = "CuxeWare.config"
local iconPath = folderName .. "/cuxe_icon.png"

if not isfolder(folderName) then makefolder(folderName) end
if not isfile(iconPath) then
    pcall(function()
        writefile(iconPath, game:HttpGet(BaseUrl .. "assets/cuxe_icon.png"))
    end)
end

local WindUI = loadstring(game:HttpGet(BaseUrl .. "api/windui.lua"))()
local function Notify(title, message, duration, icon)
    print(string.format("[CuxeWare - %s] %s", title, message))
    pcall(function()
        WindUI:Notify({
            Title = "CuxeWare | " .. title,
            Content = message,
            Duration = duration or 3,
            Icon = icon or "info",
        })
    end)
end

pcall(function()
    loadstring(game:HttpGet(BaseUrl .. "gui/loader.lua"))()
end)

local gamesList = loadstring(game:HttpGet(BaseUrl .. "games/games.lua"))()
local targetScript = gamesList[game.PlaceId] or gamesList[game.GameId]

if targetScript then
    Notify("Game Detected", "Loading " .. targetScript .. "...", 3, "gamepad-2")
    task.wait(0.5)
    loadstring(game:HttpGet(BaseUrl .. "games/" .. targetScript))()
else
    warn("[CuxeWare] このゲームは未対応です (PlaceId: " .. tostring(game.PlaceId) .. ")")
    WindUI:Notify({
        Title = "CuxeWare | Unsupported",
        Content = "このゲームは未対応です (ID: " .. tostring(game.PlaceId) .. ")",
        Duration = 6,
        Icon = "triangle-alert",
    })
end