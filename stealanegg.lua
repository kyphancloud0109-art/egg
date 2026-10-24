-- =========================================================================
--   ♾️ GOJO HUB - STEAL AN EGG 🥚 (100% REBRANDED & NO KEY)
--   THE HONORED ONE · FULL GOJO SATORU THEME · ZERO TRACES OF CHILLI
-- =========================================================================

local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local TargetScriptUrl = "https://raw.githubusercontent.com/robvxs24/freemium/refs/heads/main/chilliv5beta.lua"

-- Gojo Satoru Logo Asset ID
local GOJO_LOGO_ID = "rbxassetid://11486398809"
local OLD_CHILLI_ASSET = "92622270383869"

task.spawn(function()
    pcall(function()
        ContentProvider:PreloadAsync({ GOJO_LOGO_ID })
    end)
end)

-- =========================================================================
--   BỘ LỌC TỰ ĐỘNG THAY THẾ TOÀN BỘ GIAO DIỆN (UI OVERRIDE ENGINE)
--   Tự động phát hiện và chuyển đổi mọi chữ / logo Chilli sang Gojo Hub
-- =========================================================================
local function CleanElement(inst: Instance)
    pcall(function()
        if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
            local txt = inst.Text
            if txt and (txt:find("Chilli", 1, true) or txt:find("chilli", 1, true) or txt:find("CHILLI", 1, true) or txt:find("🌶️", 1, true)) then
                local newTxt = txt:gsub("Chilli Hub V5", "Gojo Hub ♾️")
                                  :gsub("Chilli Hub", "Gojo Hub")
                                  :gsub("Chilli SAE", "Gojo SAE")
                                  :gsub("Chilli", "Gojo")
                                  :gsub("chilli", "gojo")
                                  :gsub("🌶️", "♾️")
                inst.Text = newTxt
            end
        elseif inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
            if inst.Image and inst.Image:find(OLD_CHILLI_ASSET, 1, true) then
                inst.Image = GOJO_LOGO_ID
            end
        end
    end)
end

local function StartUiMonitor()
    local roots = { CoreGui, LocalPlayer:FindFirstChild("PlayerGui") }
    if gethui then pcall(function() table.insert(roots, gethui()) end) end

    for _, root in ipairs(roots) do
        if root then
            -- Quét sạch cây UI hiện có
            for _, desc in ipairs(root:GetDescendants()) do
                CleanElement(desc)
                if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                    desc:GetPropertyChangedSignal("Text"):Connect(function()
                        CleanElement(desc)
                    end)
                elseif desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
                    desc:GetPropertyChangedSignal("Image"):Connect(function()
                        CleanElement(desc)
                    end)
                end
            end

            -- Theo dõi liên tục các element mới sinh ra
            root.DescendantAdded:Connect(function(desc)
                task.wait()
                CleanElement(desc)
                if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                    desc:GetPropertyChangedSignal("Text"):Connect(function()
                        CleanElement(desc)
                    end)
                elseif desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
                    desc:GetPropertyChangedSignal("Image"):Connect(function()
                        CleanElement(desc)
                    end)
                end
            end)
        end
    end
end

-- =========================================================================
--   THÔNG BÁO LIVE TOAST
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
--   MÀN HÌNH TẢI GOJO HUB (SPLASH LOADER)
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
    StatusLabel.Text = "Đang áp dụng giao diện Gojo Hub..."
    StatusLabel.TextColor3 = Color3.fromRGB(148, 163, 184)
    StatusLabel.TextSize = 10.5
    StatusLabel.Font = Enum.Font.GothamMedium
    StatusLabel.ZIndex = 52
    StatusLabel.Parent = MainCard

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
    VersionFooter.Text = "Steal An Egg 🥚 • Gojo Edition"
    VersionFooter.TextColor3 = Color3.fromRGB(100, 116, 139)
    VersionFooter.TextSize = 9.5
    VersionFooter.Font = Enum.Font.GothamMedium
    VersionFooter.ZIndex = 52
    VersionFooter.Parent = MainCard

    task.spawn(function()
        task.wait(0.2)
        TweenService:Create(BarFill, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.7, 0, 1, 0)
        }):Play()

        StatusLabel.Text = "Đang chuyển đổi menu thành Gojo Hub..."
        task.wait(0.5)

        TweenService:Create(BarFill, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play()

        StatusLabel.Text = "Hoàn tất! Đang mở menu..."
        StatusLabel.TextColor3 = Color3.fromRGB(74, 222, 128)
        task.wait(0.35)

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
--   LUỒNG CHẠY CHÍNH: PATCH NỘI DUNG SCRIPT TRONG BỘ NHỚ
-- =========================================================================
ShowLoadingScreen(function()
    StartUiMonitor()
    ShowGojoToast("GOJO HUB ♾️", "Đã đổi tên và kích hoạt Gojo Hub thành công!", 4)

    task.spawn(function()
        local ok, rawCode = pcall(function()
            return game:HttpGet(TargetScriptUrl, true)
        end)

        if ok and type(rawCode) == "string" and #rawCode > 50 then
            -- 1. Đổi tiêu đề menu chính và Logo thành Gojo
            rawCode = rawCode:gsub('local NEW_TITLE, LOGO_ID = "[^"]*", "[^"]*"', 
                                  'local NEW_TITLE, LOGO_ID = "Gojo Hub ♾️", "' .. GOJO_LOGO_ID .. '"')

            -- 2. Đổi toàn bộ các chuỗi text và bản quyền Chilli sang Gojo Hub
            rawCode = rawCode:gsub('"Chilli Hub V5"', '"Gojo Hub ♾️"')
                             :gsub('"Chilli Hub"', '"Gojo Hub"')
                             :gsub('"Chilli SAE"', '"Gojo SAE"')
                             :gsub('Chilli Hub V5', 'Gojo Hub ♾️')
                             :gsub('Chilli Hub', 'Gojo Hub')
                             :gsub('Chilli SAE', 'Gojo SAE')
                             :gsub('ChilliV5', 'GojoHub')
                             :gsub('Chilli', 'Gojo')
                             :gsub('chillihubv5', 'gojohub')
                             :gsub('chilli', 'gojo')
                             :gsub('🌶️', '♾️')
                             :gsub(OLD_CHILLI_ASSET, GOJO_LOGO_ID:match("%d+"))

            -- Chạy script đã được patch sạch
            local fn, err = loadstring(rawCode)
            if fn then
                fn()
            else
                -- Fallback nếu executor có vấn đề với loadstring
                loadstring(game:HttpGet(TargetScriptUrl))()
            end
        else
            -- Fallback tải trực tiếp
            loadstring(game:HttpGet(TargetScriptUrl))()
        end
    end)
end)
