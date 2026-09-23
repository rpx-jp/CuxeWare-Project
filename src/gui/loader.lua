-- src/gui/loader.lua
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local BaseUrl = "https://raw.githubusercontent.com/rpx-jp/CuxeWare-Project/main/src/"

-- UIの親先を安全に取得 (CoreGui または PlayerGui)
local guiParent
pcall(function()
    guiParent = (gethui and gethui()) or game:GetService("CoreGui")
end)
if not guiParent then
    guiParent = player:WaitForChild("PlayerGui")
end

-- ==========================================
-- 1. 自作 Asset API の読み込み
-- ==========================================
local Asset = loadstring(game:HttpGet(BaseUrl .. "api/asset.lua"))()

-- ==========================================
-- 2. GUIの構築 (モダン・サイバーデザイン)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CuxeWare_Loader"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = guiParent

-- 背景のアンビエントネオングロー（光の輪）
local AmbientGlow = Instance.new("ImageLabel")
AmbientGlow.Size = UDim2.fromOffset(460, 240)
AmbientGlow.Position = UDim2.fromScale(0.5, 0.5)
AmbientGlow.AnchorPoint = Vector2.new(0.5, 0.5)
AmbientGlow.BackgroundTransparency = 1
AmbientGlow.Image = "rbxassetid://5028857084"
AmbientGlow.ImageColor3 = Color3.fromRGB(99, 102, 241) -- ネオンインディゴ
AmbientGlow.ImageTransparency = 1
AmbientGlow.Parent = ScreenGui

-- メインカード (アクリルダーク質感)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(380, 150)
MainFrame.Position = UDim2.fromScale(0.5, 0.53)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
MainFrame.BackgroundTransparency = 1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local CardCorner = Instance.new("UICorner")
CardCorner.CornerRadius = UDim.new(0, 14)
CardCorner.Parent = MainFrame

-- 上部ハイライトのグラデーション枠線
local CardStroke = Instance.new("UIStroke")
CardStroke.Thickness = 1.2
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

-- ==========================================
-- 3. 自作アイコン（Asset APIから自動保存・取得）
-- ==========================================
local LogoImage = Instance.new("ImageLabel")
LogoImage.Size = UDim2.fromOffset(46, 46)
LogoImage.Position = UDim2.fromOffset(22, 22)
LogoImage.BackgroundColor3 = Color3.fromRGB(25, 27, 38)
LogoImage.BackgroundTransparency = 1
LogoImage.ImageTransparency = 1
LogoImage.BorderSizePixel = 0
LogoImage.Parent = MainFrame

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 10)
LogoCorner.Parent = LogoImage

-- ▼ Asset API経由で cuxe_icon.png を自動保存して読み込む！
LogoImage.Image = Asset.Get("cuxe_icon.png")

-- ==========================================
-- 4. タイトル & 「BETA」バッジ
-- ==========================================
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, -90, 0, 24)
HeaderFrame.Position = UDim2.fromOffset(80, 22)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.fromOffset(115, 24)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "CuxeWare"
TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 250)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.TextTransparency = 1
TitleLabel.Parent = HeaderFrame

local BetaBadge = Instance.new("Frame")
BetaBadge.Size = UDim2.fromOffset(44, 18)
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
BadgeText.Text = "BETA"
BadgeText.TextColor3 = Color3.fromRGB(255, 255, 255)
BadgeText.Font = Enum.Font.GothamBold
BadgeText.TextSize = 10
BadgeText.TextTransparency = 1
BadgeText.Parent = BetaBadge

-- サブステータス文字
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -90, 0, 16)
StatusLabel.Position = UDim2.fromOffset(80, 48)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "INITIALIZING CORE..."
StatusLabel.TextColor3 = Color3.fromRGB(130, 135, 155)
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.TextSize = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextTransparency = 1
StatusLabel.Parent = MainFrame

-- ==========================================
-- 5. ネオングラデーション・プログレスバー
-- ==========================================
local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(1, -44, 0, 6)
BarBackground.Position = UDim2.fromOffset(22, 94)
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

-- パーセント表示
local PercentLabel = Instance.new("TextLabel")
PercentLabel.Size = UDim2.new(1, -44, 0, 16)
PercentLabel.Position = UDim2.fromOffset(22, 110)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Color3.fromRGB(150, 155, 175)
PercentLabel.Font = Enum.Font.GothamMedium
PercentLabel.TextSize = 11
PercentLabel.TextXAlignment = Enum.TextXAlignment.Right
PercentLabel.TextTransparency = 1
PercentLabel.Parent = MainFrame

-- ==========================================
-- 6. 登場アニメーション (Quartイージング)
-- ==========================================
TweenService:Create(MainFrame, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Position = UDim2.fromScale(0.5, 0.5),
    BackgroundTransparency = 0.08
}):Play()
TweenService:Create(AmbientGlow, TweenInfo.new(0.5), { ImageTransparency = 0.55 }):Play()
TweenService:Create(CardStroke, TweenInfo.new(0.45), { Transparency = 0 }):Play()
TweenService:Create(LogoImage, TweenInfo.new(0.35), { ImageTransparency = 0 }):Play()
TweenService:Create(TitleLabel, TweenInfo.new(0.35), { TextTransparency = 0 }):Play()
TweenService:Create(BadgeText, TweenInfo.new(0.35), { TextTransparency = 0 }):Play()
TweenService:Create(BetaBadge, TweenInfo.new(0.35), { BackgroundTransparency = 0.2 }):Play()
TweenService:Create(StatusLabel, TweenInfo.new(0.35), { TextTransparency = 0 }):Play()
TweenService:Create(BarBackground, TweenInfo.new(0.35), { BackgroundTransparency = 0 }):Play()
TweenService:Create(PercentLabel, TweenInfo.new(0.35), { TextTransparency = 0 }):Play()

-- ==========================================
-- 7. ロード更新処理
-- ==========================================
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

-- ==========================================
-- 8. 退出アニメーション & クリーンアップ
-- ==========================================
TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
    Position = UDim2.fromScale(0.5, 0.47),
    BackgroundTransparency = 1
}):Play()
TweenService:Create(AmbientGlow, TweenInfo.new(0.3), { ImageTransparency = 1 }):Play()

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