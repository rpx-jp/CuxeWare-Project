-- src/api/asset.lua
local AssetAPI = {}

local BaseUrl = "https://raw.githubusercontent.com/rpx-jp/CuxeWare-Project/main/src/"
local ConfigFolder = "CuxeWare.config"
local AssetsFolder = ConfigFolder .. "/assets"

local DEFAULT_FALLBACK = "rbxassetid://10723374276"

function AssetAPI.Get(fileName, fallback)
    fallback = fallback or DEFAULT_FALLBACK
    
    if not isfolder(ConfigFolder) then
        pcall(makefolder, ConfigFolder)
    end

    if not isfolder(AssetsFolder) then
        pcall(makefolder, AssetsFolder)
    end

    local filePath = AssetsFolder .. "/" .. fileName

    if not isfile(filePath) then
        local success, fileData = pcall(function()
            return game:HttpGet(BaseUrl .. "assets/" .. fileName)
        end)
        
        if success and fileData and #fileData > 0 then
            pcall(writefile, filePath, fileData)
            print("[CuxeWare AssetAPI] Saved to assets: " .. filePath)
        else
            warn("[CuxeWare AssetAPI] Failed to download: " .. fileName)
            return fallback
        end
    end

    if isfile(filePath) then
        local success, customAsset = pcall(getcustomasset, filePath)
        if success and customAsset then
            return customAsset
        end
    end

    return fallback
end

return AssetAPI