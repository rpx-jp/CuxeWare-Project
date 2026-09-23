-- src/gui/loader.lua
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local BaseUrl = "https://raw.githubusercontent.com/rpx-jp/CuxeWare-Project/main/src/"

local guiParent
pcall(function()
    guiParent = (gethui and gethui()) or game:GetService("CoreGui")
end)
if not guiParent then
    guiParent = player:WaitForChild("PlayerGui")
end

local Asset = loadstring(game:HttpGet(BaseUrl .. "api/asset.lua"))()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CuxeWare_Loader"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = guiParent

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(420, 220)
MainFrame.Position = UDim2.fromScale(0.5, 0.52)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
MainFrame.BackgroundTransparency = 1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 18)
CardCorner.Parent = MainFrame

local CardStroke = Instance.new("UIStroke")
CardStroke.Thickness = 1.4
CardStroke.Color = Color3.fromRGB(255, 255, 255)
CardStroke.Transparency = 1
CardStroke.Parent = MainFrame

local StrokeGradient = Instance.new("UIGradient")
StrokeGradient.Rotation = 90
StrokeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(99, 102, 241)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(50, 55, 75)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 22, 30))
})
StrokeGradient.Parent = CardStroke

local LogoImage = Instance.new("ImageLabel")
LogoImage.Size = UDim2.fromOffset(72, 72)
LogoImage.Position = UDim2.new(0.5, 0, 0, 24)
LogoImage.AnchorPoint = Vector2.new(0.5, 0)
LogoImage.BackgroundColor3 = Color3.fromRGB(25, 27, 38)
LogoImage.BackgroundTransparency = 1
LogoImage.ImageTransparency = 1
LogoImage.BorderSizePixel = 0
LogoImage.Parent = MainFrame

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 16)
LogoCorner.Parent = LogoImage

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(99, 102, 241)
LogoStroke.Thickness = 1.2
LogoStroke.Transparency = 1
LogoStroke.Parent = LogoImage

LogoImage.Image = Asset.Get("cuxe_icon.png")

local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.fromOffset(175, 26)
HeaderFrame.Position = UDim2.new(0.5, 0, 0, 108)
HeaderFrame.AnchorPoint = Vector2.new(0.5, 0)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.fromOffset(115, 26)
TitleLabel.Position = UDim2.fromOffset(0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "CuxeWare"
TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 250)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 21
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.TextTransparency = 1
TitleLabel.Parent = HeaderFrame

local BetaBadge = Instance.new("Frame")
BetaBadge.Size = UDim2.fromOffset(54, 20)
BetaBadge.Position = UDim2.fromOffset(120, 3)
BetaBadge.BackgroundColor3 = Color3.fromRGB(99, 102, 241)
BetaBadge.BackgroundTransparency = 1
BetaBadge.BorderSizePixel = 0
BetaBadge.Parent = HeaderFrame

local BadgeCorner = Instance.new("UICorner")
BadgeCorner.CornerRadius = UDim.new(1, 0)
BadgeCorner.Parent = BetaBadge

local BadgeText = Instance.new("TextLabel")
BadgeText.Size = UDim2.fromScale(1, 1)
BadgeText.BackgroundTransparency = 1
BadgeText.Text = "ベータ版"
BadgeText.TextColor3 = Color3.fromRGB(255, 255, 255)
BadgeText.Font = Enum.Font.GothamBold
BadgeText.TextSize = 11
BadgeText.TextTransparency = 1
BadgeText.Parent = BetaBadge

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -60, 0, 16)
StatusLabel.Position = UDim2.new(0.5, 0, 0, 140)
StatusLabel.AnchorPoint = Vector2.new(0.5, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "INITIALIZING CORE..."
StatusLabel.TextColor3 = Color3.fromRGB(130, 135, 155)
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.TextTransparency = 1
StatusLabel.Parent = MainFrame

local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(1, -64, 0, 8)
BarBackground.Position = UDim2.new(0.5, 0, 0, 166)
BarBackground.AnchorPoint = Vector2.new(0.5, 0)
BarBackground.BackgroundColor3 = Color3.fromRGB(28, 30, 42)
BarBackground.BackgroundTransparency = 1
BarBackground.BorderSizePixel = 0
BarBackground.Parent = MainFrame

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1, 0)
BarCorner.Parent = BarBackground

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.fromScale(0, 1)
ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = BarBackground

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(1, 0)
ProgressCorner.Parent = ProgressBar

local BarGradient = Instance.new("UIGradient")
BarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 220, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 51, 234))
})
BarGradient.Parent = ProgressBar

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(1, -64, 0, 16)
PercentLabel.Position = UDim2.new(0.5, 0, 0, 182)
PercentLabel.AnchorPoint = Vector2.new(0.5, 0)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Color3.fromRGB(150, 155, 175)
PercentLabel.Font = Enum.Font.GothamMedium
PercentLabel.TextSize = 11
PercentLabel.TextXAlignment = Enum.TextXAlignment.Center
PercentLabel.TextTransparency = 1
PercentLabel.Parent = MainFrame

TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Position = UDim2.fromScale(0.5, 0.5),
    BackgroundTransparency = 0.08
}):Play()
TweenService:Create(CardStroke, TweenInfo.new(0.4), { Transparency = 0 }):Play()
TweenService:Create(LogoImage, TweenInfo.new(0.3), { ImageTransparency = 0 }):Play()
TweenService:Create(LogoStroke, TweenInfo.new(0.3), { Transparency = 0.4 }):Play()
TweenService:Create(TitleLabel, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
TweenService:Create(BadgeText, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
TweenService:Create(BetaBadge, TweenInfo.new(0.3), { BackgroundTransparency = 0.2 }):Play()
TweenService:Create(StatusLabel, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
TweenService:Create(PercentLabel, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
TweenService:Create(BarBackground, TweenInfo.new(0.3), { BackgroundTransparency = 0 }):Play()

local function updateProgress(percent, text, duration)
    StatusLabel.Text = string.upper(text)
    PercentLabel.Text = tostring(math.floor(percent * 100)) .. "%"
    
    TweenService:Create(ProgressBar, TweenInfo.new(duration or 0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(percent, 1)
    }):Play()
    
    task.wait(duration or 0.35)
end

updateProgress(0.25, "Synchronizing Environment...", 0.35)
if not game:IsLoaded() then
    game.Loaded:Wait()
end

updateProgress(0.55, "Loading CuxeWare Modules...", 0.35)
task.wait(0.2)

updateProgress(0.85, "Mounting Framework...", 0.35)
task.wait(0.2)

updateProgress(1.0, "Ready to Launch", 0.25)
task.wait(0.35)

TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
    Position = UDim2.fromScale(0.5, 0.48),
    BackgroundTransparency = 1
}):Play()

for _, obj in ipairs(MainFrame:GetDescendants()) do
    if obj:IsA("TextLabel") then
        TweenService:Create(obj, TweenInfo.new(0.25), { TextTransparency = 1 }):Play()
    elseif obj:IsA("ImageLabel") then
        TweenService:Create(obj, TweenInfo.new(0.25), { ImageTransparency = 1 }):Play()
    elseif obj:IsA("Frame") then
        TweenService:Create(obj, TweenInfo.new(0.25), { BackgroundTransparency = 1 }):Play()
    elseif obj:IsA("UIStroke") then
        TweenService:Create(obj, TweenInfo.new(0.25), { Transparency = 1 }):Play()
    end
end

task.wait(0.35)
ScreenGui:Destroy()

return true