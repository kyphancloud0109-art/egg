-- =========================================================================
--   ♾️ GOJO HUB - STEAL AN EGG 🥚 (NO KEY EDITION)
--   THE HONORED ONE · AUTO LOAD & ZERO ADS · LIMITLESS SYSTEM
-- =========================================================================

local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local TargetScriptUrl = "https://raw.githubusercontent.com/robvxs24/freemium/refs/heads/main/chilliv5beta.lua"

-- Assets & Icons
local GojoAvatarId = "rbxassetid://92622270383869"

task.spawn(function()
    pcall(function()
        ContentProvider:PreloadAsync({ GojoAvatarId })
    end)
end)

-- =========================================================================
--   THÔNG BÁO LIVE TOAST (FLOATING STATUS NOTIFICATION)
-- =========================================================================
local function ShowGojoToast(title: string, message: string, duration: number?)
    duration = duration or 4

    if CoreGui:FindFirstChild("GojoHub_ToastUI") then CoreGui.GojoHub_ToastUI:Destroy() end
    if LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("GojoHub_ToastUI") then
        LocalPlayer.PlayerGui.GojoHub_ToastUI:Destroy()
    end

    local ToastGui = Instance.new("ScreenGui")
    ToastGui.Name = "GojoHub_ToastUI"
    ToastGui.ResetOnSpawn = false
    pcall(function() ToastGui.Parent = CoreGui end)
    if not ToastGui.Parent then ToastGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local ToastPill = Instance.new("Frame")
    ToastPill.Name = "ToastPill"
    ToastPill.AnchorPoint = Vector2.new(0.5, 0)
    ToastPill.Size = UDim2.new(0, 320, 0, 52)
    ToastPill.Position = UDim2.new(0.5, 0, 0, -70)
    ToastPill.BackgroundColor3 = Color3.fromRGB(12, 15, 26)
    ToastPill.ZIndex = 99
    ToastPill.Parent = ToastGui
    Instance.new("UICorner", ToastPill).CornerRadius = UDim.new(0, 14)

    local PillStroke = Instance.new("UIStroke", ToastPill)
    PillStroke.Color = Color3.fromRGB(56, 189, 248)
    PillStroke.Thickness = 1.3

    local PillGrad = Instance.new("UIGradient", ToastPill)
    PillGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 24, 42)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 13, 24))
    })

    local IconBox = Instance.new("Frame")
    IconBox.Size = UDim2.new(0, 36, 0, 36)
    IconBox.Position = UDim2.new(0, 8, 0.5, -18)
    IconBox.BackgroundColor3 = Color3.fromRGB(24, 32, 54)
    IconBox.ZIndex = 100
    IconBox.Parent = ToastPill
    Instance.new("UICorner", IconBox).CornerRadius = UDim.new(0, 10)

    local IconText = Instance.new("TextLabel")
    IconText.Size = UDim2.new(1, 0, 1, 0)
    IconText.BackgroundTransparency = 1
    IconText.Text = "♾️"
    IconText.TextSize = 18
    IconText.ZIndex = 101
    IconText.Parent = IconBox

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -60, 0, 18)
    TitleLabel.Position = UDim2.new(0, 52, 0, 8)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(248, 250, 252)
    TitleLabel.TextSize = 12
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.ZIndex = 100
    TitleLabel.Parent = ToastPill

    local SubLabel = Instance.new("TextLabel")
    SubLabel.Size = UDim2.new(1, -60, 0, 16)
    SubLabel.Position = UDim2.new(0, 52, 0, 27)
    SubLabel.BackgroundTransparency = 1
    SubLabel.Text = message
    SubLabel.TextColor3 = Color3.fromRGB(148, 163, 184)
    SubLabel.TextSize = 10
    SubLabel.Font = Enum.Font.GothamMedium
    SubLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubLabel.ZIndex = 100
    SubLabel.Parent = ToastPill

    TweenService:Create(ToastPill, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0, 18)
    }):Play()

    task.delay(duration, function()
        if ToastPill and ToastPill.Parent then
            local hideTween = TweenService:Create(ToastPill, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, 0, 0, -80)
            })
            hideTween:Play()
            hideTween.Completed:Connect(function()
                if ToastGui and ToastGui.Parent then ToastGui:Destroy() end
            end)
        end
    end)
end

-- =========================================================================
--   MÀN HÌNH TẢI HIỆN ĐẠI GOJO HUB (SPLASH LOADER SCREEN)
-- =========================================================================
local function ShowLoadingScreen(onFinished: () -> ())
    if CoreGui:FindFirstChild("GojoHub_LoaderUI") then CoreGui.GojoHub_LoaderUI:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GojoHub_LoaderUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() ScreenGui.Parent = CoreGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local MainCard = Instance.new("Frame")
    MainCard.Name = "MainCard"
    MainCard.AnchorPoint = Vector2.new(0.5, 0.5)
    MainCard.Size = UDim2.new(0, 360, 0, 200)
    MainCard.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainCard.BackgroundColor3 = Color3.fromRGB(12, 15, 25)
    MainCard.BorderSizePixel = 0
    MainCard.ClipsDescendants = true
    MainCard.ZIndex = 50
    MainCard.Parent = ScreenGui
    Instance.new("UICorner", MainCard).CornerRadius = UDim.new(0, 18)

    local CardStroke = Instance.new("UIStroke", MainCard)
    CardStroke.Color = Color3.fromRGB(56, 189, 248)
    CardStroke.Thickness = 1.4

    -- Thanh dải màu phát sáng tím - xanh ngọc
    local TopAccent = Instance.new("Frame")
    TopAccent.Size = UDim2.new(1, 0, 0, 3)
    TopAccent.Position = UDim2.new(0, 0, 0, 0)
    TopAccent.BorderSizePixel = 0
    TopAccent.ZIndex = 55
    TopAccent.Parent = MainCard

    local TopGrad = Instance.new("UIGradient", TopAccent)
    TopGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 189, 248)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(168, 85, 247)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(56, 189, 248))
    })

    -- Logo 6 Mắt / Vô Hạn
    local LogoBox = Instance.new("Frame")
    LogoBox.Size = UDim2.new(0, 50, 0, 50)
    LogoBox.Position = UDim2.new(0.5, -25, 0, 22)
    LogoBox.BackgroundColor3 = Color3.fromRGB(20, 26, 44)
    LogoBox.ZIndex = 52
    LogoBox.Parent = MainCard
    Instance.new("UICorner", LogoBox).CornerRadius = UDim.new(0, 14)

    local LogoStroke = Instance.new("UIStroke", LogoBox)
    LogoStroke.Color = Color3.fromRGB(56, 189, 248)
    LogoStroke.Thickness = 1.2

    local LogoIcon = Instance.new("TextLabel")
    LogoIcon.Size = UDim2.new(1, 0, 1, 0)
    LogoIcon.BackgroundTransparency = 1
    LogoIcon.Text = "⚡"
    LogoIcon.TextColor3 = Color3.fromRGB(56, 189, 248)
    LogoIcon.TextSize = 24
    LogoIcon.ZIndex = 53
    LogoIcon.Parent = LogoBox

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 22)
    Title.Position = UDim2.new(0, 0, 0, 80)
    Title.BackgroundTransparency = 1
    Title.Text = "GOJO HUB ♾️"
    Title.TextColor3 = Color3.fromRGB(248, 250, 252)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.ZIndex = 52
    Title.Parent = MainCard

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, 0, 0, 18)
    StatusLabel.Position = UDim2.new(0, 0, 0, 104)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "Đang khởi động hệ thống No-Key..."
    StatusLabel.TextColor3 = Color3.fromRGB(148, 163, 184)
    StatusLabel.TextSize = 10.5
    StatusLabel.Font = Enum.Font.GothamMedium
    StatusLabel.ZIndex = 52
    StatusLabel.Parent = MainCard

    -- Thanh tiến trình (Progress Bar)
    local BarBg = Instance.new("Frame")
    BarBg.Size = UDim2.new(1, -60, 0, 8)
    BarBg.Position = UDim2.new(0, 30, 0, 142)
    BarBg.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
    BarBg.ZIndex = 52
    BarBg.Parent = MainCard
    Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)

    local BarFill = Instance.new("Frame")
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(56, 189, 248)
    BarFill.BorderSizePixel = 0
    BarFill.ZIndex = 53
    BarFill.Parent = BarBg
    Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

    local FillGrad = Instance.new("UIGradient", BarFill)
    FillGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 189, 248)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(168, 85, 247))
    })

    local VersionFooter = Instance.new("TextLabel")
    VersionFooter.Size = UDim2.new(1, 0, 0, 16)
    VersionFooter.Position = UDim2.new(0, 0, 0, 164)
    VersionFooter.BackgroundTransparency = 1
    VersionFooter.Text = "Steal An Egg 🥚 • No Key Edition"
    VersionFooter.TextColor3 = Color3.fromRGB(100, 116, 139)
    VersionFooter.TextSize = 9.5
    VersionFooter.Font = Enum.Font.GothamMedium
    VersionFooter.ZIndex = 52
    VersionFooter.Parent = MainCard

    -- Hiệu ứng chạy thanh tiến trình
    task.spawn(function()
        task.wait(0.2)
        TweenService:Create(BarFill, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.65, 0, 1, 0)
        }):Play()

        StatusLabel.Text = "Đang tải dữ liệu Steal An Egg..."
        task.wait(0.6)

        TweenService:Create(BarFill, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play()

        StatusLabel.Text = "Kích hoạt thành công!"
        StatusLabel.TextColor3 = Color3.fromRGB(74, 222, 128)
        task.wait(0.4)

        -- Đóng màn hình tải với hiệu ứng phóng nhẹ
        local closeTween = TweenService:Create(MainCard, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 320, 0, 180),
            BackgroundTransparency = 1
        })
        closeTween:Play()
        closeTween.Completed:Connect(function()
            ScreenGui:Destroy()
            if onFinished then onFinished() end
        end)
    end)
end

-- =========================================================================
--   LUỒNG CHẠY CHÍNH (AUTO LOAD SCRIPT)
-- =========================================================================
ShowLoadingScreen(function()
    ShowGojoToast("GOJO HUB ♾️ KÍCH HOẠT", "Đã mở thành công bản No-Key! Chúc bạn chơi vui vẻ.", 4.5)

    getgenv().GojoHub_Active = true
    getgenv().ChilliV5_Active = true

    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet(TargetScriptUrl))()
        end)
    end)
end)
