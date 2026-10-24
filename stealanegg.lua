-- =========================================================================
--   ♾️ GOJO HUB - STEAL AN EGG 🥚 (BẢN GỐC TỰ PHÁT TRIỂN)
--   GIAO DIỆN CHUẨN TỐI GIẢN · 1 CHỨC NĂNG CƠ BẢN · DỄ DÀNG CODE THÊM
-- =========================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
LocalPlayer.CharacterAdded:Connect(function(char) Character = char end)

-- Xóa UI cũ nếu đang chạy
if CoreGui:FindFirstChild("GojoHub_UI") then CoreGui.GojoHub_UI:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GojoHub_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- =========================================================================
--   1. NÚT TRÒN BẬT / TẮT MENU (FLOATING TOGGLE BUTTON)
-- =========================================================================
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "GojoToggle"
ToggleButton.Size = UDim2.new(0, 52, 0, 52)
ToggleButton.Position = UDim2.new(0, 20, 0.2, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 20, 32)
ToggleButton.Text = "♾️"
ToggleButton.TextColor3 = Color3.fromRGB(56, 189, 248)
ToggleButton.TextSize = 24
ToggleButton.ZIndex = 100
ToggleButton.Parent = ScreenGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleButton)
ToggleStroke.Color = Color3.fromRGB(56, 189, 248)
ToggleStroke.Thickness = 1.8

-- Kéo thả nút tròn
local dragToggle = false
local dragStartToggle, startPosToggle
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStartToggle = input.Position
        startPosToggle = ToggleButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragToggle = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartToggle
        ToggleButton.Position = UDim2.new(startPosToggle.X.Scale, startPosToggle.X.Offset + delta.X, startPosToggle.Y.Scale, startPosToggle.Y.Offset + delta.Y)
    end
end)

-- =========================================================================
--   2. KHUNG MENU CHÍNH (MAIN WINDOW)
-- =========================================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Size = UDim2.new(0, 540, 0, 340)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 16, 26)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 50
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(56, 189, 248)
MainStroke.Thickness = 1.4

-- Thanh dải màu phát sáng tím - xanh ngọc phía trên
local TopGlow = Instance.new("Frame")
TopGlow.Size = UDim2.new(1, 0, 0, 3)
TopGlow.Position = UDim2.new(0, 0, 0, 0)
TopGlow.BorderSizePixel = 0
TopGlow.ZIndex = 55
TopGlow.Parent = MainFrame

local GlowGrad = Instance.new("UIGradient", TopGlow)
GlowGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 189, 248)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(168, 85, 247)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(56, 189, 248))
})

-- Kéo thả Main Window bằng Header
local isDraggingMain, dragStartMain, startPosMain = false, nil, nil
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if input.Position.Y - MainFrame.AbsolutePosition.Y < 45 then
            isDraggingMain = true
            dragStartMain = input.Position
            startPosMain = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then isDraggingMain = false end
            end)
        end
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if isDraggingMain and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartMain
        MainFrame.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
    end
end)

-- Bật / tắt mở Menu bằng nút tròn
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- =========================================================================
--   3. HEADER CỦA MENU
-- =========================================================================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundColor3 = Color3.fromRGB(18, 22, 36)
Header.BorderSizePixel = 0
Header.ZIndex = 51
Header.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Position = UDim2.new(0, 16, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "♾️ GOJO HUB | STEAL AN EGG 🥚"
TitleLabel.TextColor3 = Color3.fromRGB(248, 250, 252)
TitleLabel.TextSize = 13.5
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 52
TitleLabel.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -38, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 48)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(148, 163, 184)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 53
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- =========================================================================
--   4. CỘT DANH MỤC TRÁI (TABS SIDEBAR)
-- =========================================================================
local TabSidebar = Instance.new("Frame")
TabSidebar.Size = UDim2.new(0, 140, 1, -42)
TabSidebar.Position = UDim2.new(0, 0, 0, 42)
TabSidebar.BackgroundColor3 = Color3.fromRGB(15, 18, 28)
TabSidebar.BorderSizePixel = 0
TabSidebar.ZIndex = 51
TabSidebar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout", TabSidebar)
TabListLayout.Padding = UDim.new(0, 6)
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local SidebarPad = Instance.new("UIPadding", TabSidebar)
SidebarPad.PaddingTop = UDim.new(0, 10)
SidebarPad.PaddingLeft = UDim.new(0, 8)
SidebarPad.PaddingRight = UDim.new(0, 8)

-- KHUNG CHỨA NỘI DUNG (CONTAINER)
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -140, 1, -42)
ContentContainer.Position = UDim2.new(0, 140, 0, 42)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ZIndex = 51
ContentContainer.Parent = MainFrame

-- =========================================================================
--   5. BỘ TẠO GIAO DIỆN (UI BUILDER HELPERS)
-- =========================================================================
local Tabs = {}
local FirstTab = nil

local function CreateTab(tabName: string, iconText: string)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 36)
    TabButton.BackgroundColor3 = Color3.fromRGB(20, 24, 38)
    TabButton.Text = (iconText or "📌") .. " " .. tabName
    TabButton.TextColor3 = Color3.fromRGB(148, 163, 184)
    TabButton.TextSize = 11.5
    TabButton.Font = Enum.Font.GothamBold
    TabButton.AutoButtonColor = false
    TabButton.ZIndex = 52
    TabButton.Parent = TabSidebar
    Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 8)

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, -20, 1, -20)
    Page.Position = UDim2.new(0, 10, 0, 10)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(56, 189, 248)
    Page.Visible = false
    Page.ZIndex = 52
    Page.Parent = ContentContainer

    local PageLayout = Instance.new("UIListLayout", Page)
    PageLayout.Padding = UDim.new(0, 8)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder

    TabButton.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Page.Visible = false
            t.Button.BackgroundColor3 = Color3.fromRGB(20, 24, 38)
            t.Button.TextColor3 = Color3.fromRGB(148, 163, 184)
        end
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(14, 165, 233)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    local tabObj = { Button = TabButton, Page = Page }
    table.insert(Tabs, tabObj)

    if not FirstTab then
        FirstTab = tabObj
        Page.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(14, 165, 233)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    return Page
end

-- Hàm tạo Nút Bật/Tắt (Toggle Switch)
local function CreateToggle(parentPage: ScrollingFrame, title: string, defaultVal: boolean, callback: (boolean) -> ())
    local ToggleCard = Instance.new("Frame")
    ToggleCard.Size = UDim2.new(1, 0, 0, 44)
    ToggleCard.BackgroundColor3 = Color3.fromRGB(18, 22, 36)
    ToggleCard.ZIndex = 53
    ToggleCard.Parent = parentPage
    Instance.new("UICorner", ToggleCard).CornerRadius = UDim.new(0, 8)

    local ToggleStroke = Instance.new("UIStroke", ToggleCard)
    ToggleStroke.Color = Color3.fromRGB(36, 44, 68)
    ToggleStroke.Thickness = 1

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.Position = UDim2.new(0, 14, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = title
    Label.TextColor3 = Color3.fromRGB(248, 250, 252)
    Label.TextSize = 11.5
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 54
    Label.Parent = ToggleCard

    local SwitchBg = Instance.new("TextButton")
    SwitchBg.Size = UDim2.new(0, 46, 0, 24)
    SwitchBg.Position = UDim2.new(1, -56, 0.5, -12)
    SwitchBg.BackgroundColor3 = defaultVal and Color3.fromRGB(14, 165, 233) or Color3.fromRGB(30, 36, 56)
    SwitchBg.Text = ""
    SwitchBg.AutoButtonColor = false
    SwitchBg.ZIndex = 54
    SwitchBg.Parent = ToggleCard
    Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 18, 0, 18)
    Circle.Position = defaultVal and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.BorderSizePixel = 0
    Circle.ZIndex = 55
    Circle.Parent = SwitchBg
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local state = defaultVal
    SwitchBg.MouseButton1Click:Connect(function()
        state = not state
        local targetPos = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        local targetColor = state and Color3.fromRGB(14, 165, 233) or Color3.fromRGB(30, 36, 56)

        TweenService:Create(Circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = targetPos }):Play()
        TweenService:Create(SwitchBg, TweenInfo.new(0.2), { BackgroundColor3 = targetColor }):Play()

        task.spawn(function()
            pcall(callback, state)
        end)
    end)
end

-- =========================================================================
--   6. TẠO CÁC TAB & 1 CHỨC NĂNG CƠ BẢN NHẤT: AUTO STEAL TRỨNG
-- =========================================================================
local TabSteal = CreateTab("Cướp Trứng", "🥚")
local TabPlayer = CreateTab("Nhân Vật", "⚡")

-- Biến điều khiển tính năng Auto Steal
local AutoStealEnabled = false

-- CHỨC NĂNG CƠ BẢN: Tự tìm và lấy quả trứng gần nhất
local function FindNearestEgg(): Instance?
    local hrp = Character and Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local nearestEgg = nil
    local shortestDist = math.huge

    -- Quét tất cả các vật phẩm trứng trong Workspace
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local name = obj.Name:lower()
            -- Phát hiện trứng qua tên gọi
            if name:find("egg") and not obj:IsDescendantOf(Character) then
                local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    local dist = (hrp.Position - part.Position).Magnitude
                    if dist < shortestDist and dist < 500 then
                        shortestDist = dist
                        nearestEgg = part
                    end
                end
            end
        end
    end
    return nearestEgg
end

-- Vòng lặp tự động cướp trứng khi bật Toggle
task.spawn(function()
    while true do
        task.wait(0.5)
        if AutoStealEnabled and Character and Character:FindFirstChild("HumanoidRootPart") then
            local hrp = Character.HumanoidRootPart
            local targetEgg = FindNearestEgg()

            if targetEgg then
                -- Dịch chuyển / chạm tới trứng để lấy
                hrp.CFrame = targetEgg.CFrame + Vector3.new(0, 2, 0)
                
                -- Kích hoạt ProximityPrompt nếu có
                local prompt = targetEgg:FindFirstChildOfClass("ProximityPrompt") or targetEgg.Parent:FindFirstChildOfClass("ProximityPrompt")
                if prompt and fireproximityprompt then
                    fireproximityprompt(prompt)
                end
            end
        end
    end
end)

-- Tạo Toggle duy nhất trên giao diện:
CreateToggle(TabSteal, "Tự Động Cướp Trứng Gần Nhất", false, function(value)
    AutoStealEnabled = value
end)

-- Tab Nhân Vật (Ví dụ mẫu thêm 1 chức năng tăng tốc chạy):
CreateToggle(TabPlayer, "Tăng Tốc Chạy (Speed Boost)", false, function(value)
    local hum = Character and Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = value and 32 or 16
    end
end)

print("♾️ Gojo Hub Loaded Successfully!")
