--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║              🚀 GUI FLY BY FIKZXX 🚀                        ║
    ║                                                              ║
    ║           Premium Mobile Fly Script for Roblox              ║
    ║                    Version 2.0.0                            ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝
    
    📌 Description:
    Advanced fly script with modern GUI interface optimized for 
    mobile devices. Features smooth controls, customizable speed,
    and dynamic color system.
    
    📱 Support:
    - Mobile (iOS/Android)
    - PC/Console
    - All Executors
    
    ⚙️ Configuration:
    Edit config.lua to customize settings
    
    🔗 GitHub: https://github.com/Fikzxx/GUI-Fly
    📧 Contact: Fikzxx#0001 (Discord)
--]]

-- ============================================================
-- IMPORTS & SERVICES
-- ============================================================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")

-- ============================================================
-- CONFIGURATION
-- ============================================================
local CONFIG = {
    -- UI Settings
    UI = {
        ThemeColor = Color3.fromRGB(0, 170, 255),
        BackgroundTransparency = 0.08,
        BorderSize = 2,
        CornerRadius = 8,
    },
    
    -- Fly Settings
    Fly = {
        DefaultSpeed = 50,
        MinSpeed = 1,
        MaxSpeed = 100,
        MaxForce = 100000,
    },
    
    -- Features
    Features = {
        EnableSmoothTransition = true,
        EnableParticles = false,  -- Coming soon
        EnableSound = false,      -- Coming soon
    },
    
    -- Developer
    Developer = {
        Name = "Fikzxx",
        Version = "2.0.0",
        GitHub = "https://github.com/Fikzxx/GUI-Fly",
    }
}

-- ============================================================
-- VARIABLES
-- ============================================================
local Player = Players.LocalPlayer
local Character = Player.Character
local Humanoid = Character and Character:FindFirstChild("Humanoid")
local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")

local FlyState = {
    Active = false,
    Speed = CONFIG.Fly.DefaultSpeed,
    Color = CONFIG.UI.ThemeColor,
    Connections = {},
}

-- ============================================================
-- GUI CREATION
-- ============================================================
local function CreateGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FlyGui_Fikzxx"
    ScreenGui.Parent = Player.PlayerGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- MAIN FRAME
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    MainFrame.BackgroundTransparency = CONFIG.UI.BackgroundTransparency
    MainFrame.BorderColor3 = CONFIG.UI.ThemeColor
    MainFrame.BorderSizePixel = CONFIG.UI.BorderSize
    MainFrame.ClipsDescendants = true
    MainFrame.Position = UDim2.new(0.5, -160, 0.3, -110)
    MainFrame.Size = UDim2.new(0, 320, 0, 220)
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    -- Corner
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, CONFIG.UI.CornerRadius)
    Corner.Parent = MainFrame
    
    -- Shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = MainFrame
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -5, 0, -5)
    Shadow.Size = UDim2.new(1, 10, 1, 10)
    Shadow.Image = "rbxassetid://1316044328"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 10, 10)
    
    -- TITLE
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.BackgroundColor3 = CONFIG.UI.ThemeColor
    Title.BackgroundTransparency = 0.3
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "🚀 GUI FLY BY FIKZXX"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.TextSize = 22
    Title.TextWrapped = true
    Title.TextXAlignment = Enum.TextXAlignment.Center
    
    -- TITLE GLOW
    local TitleGlow = Instance.new("ImageLabel")
    TitleGlow.Name = "TitleGlow"
    TitleGlow.Parent = Title
    TitleGlow.BackgroundTransparency = 1
    TitleGlow.Position = UDim2.new(0, 0, 0.5, -20)
    TitleGlow.Size = UDim2.new(1, 0, 0, 40)
    TitleGlow.Image = "rbxassetid://1316044328"
    TitleGlow.ImageColor3 = CONFIG.UI.ThemeColor
    TitleGlow.ImageTransparency = 0.8
    TitleGlow.ScaleType = Enum.ScaleType.Slice
    TitleGlow.SliceCenter = Rect.new(10, 10, 10, 10)
    
    -- TOGGLE BUTTON
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = MainFrame
    ToggleButton.BackgroundColor3 = CONFIG.UI.ThemeColor
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(0.08, 0, 0.3, 5)
    ToggleButton.Size = UDim2.new(0.4, 0, 0, 40)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = "▶  START FLY"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextScaled = true
    ToggleButton.TextSize = 16
    ToggleButton.TextWrapped = true
    
    -- Toggle Button Corner
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 5)
    ToggleCorner.Parent = ToggleButton
    
    -- SPEED LABEL
    local SpeedLabel = Instance.new("TextLabel")
    SpeedLabel.Name = "SpeedLabel"
    SpeedLabel.Parent = MainFrame
    SpeedLabel.BackgroundColor3 = CONFIG.UI.ThemeColor
    SpeedLabel.BackgroundTransparency = 0.3
    SpeedLabel.BorderSizePixel = 0
    SpeedLabel.Position = UDim2.new(0.08, 0, 0.5, 5)
    SpeedLabel.Size = UDim2.new(0.25, 0, 0, 35)
    SpeedLabel.Font = Enum.Font.GothamBold
    SpeedLabel.Text = "50"
    SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedLabel.TextScaled = true
    SpeedLabel.TextSize = 18
    SpeedLabel.TextWrapped = true
    
    -- Speed Label Corner
    local SpeedCorner = Instance.new("UICorner")
    SpeedCorner.CornerRadius = UDim.new(0, 5)
    SpeedCorner.Parent = SpeedLabel
    
    -- SPEED SLIDER
    local SpeedSlider = Instance.new("Frame")
    SpeedSlider.Name = "SpeedSlider"
    SpeedSlider.Parent = MainFrame
    SpeedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    SpeedSlider.BorderColor3 = CONFIG.UI.ThemeColor
    SpeedSlider.BorderSizePixel = 1
    SpeedSlider.Position = UDim2.new(0.35, 5, 0.5, 5)
    SpeedSlider.Size = UDim2.new(0.55, 0, 0, 35)
    
    -- Slider Corner
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 5)
    SliderCorner.Parent = SpeedSlider
    
    -- SLIDER BAR
    local SliderBar = Instance.new("Frame")
    SliderBar.Name = "SliderBar"
    SliderBar.Parent = SpeedSlider
    SliderBar.BackgroundColor3 = CONFIG.UI.ThemeColor
    SliderBar.BorderSizePixel = 0
    SliderBar.Position = UDim2.new(0, 0, 0, 0)
    SliderBar.Size = UDim2.new(0.5, 0, 1, 0)
    
    -- Slider Bar Corner
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 5)
    BarCorner.Parent = SliderBar
    
    -- SLIDER BUTTON
    local SliderButton = Instance.new("TextButton")
    SliderButton.Name = "SliderButton"
    SliderButton.Parent = SpeedSlider
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.BorderSizePixel = 2
    SliderButton.BorderColor3 = CONFIG.UI.ThemeColor
    SliderButton.Position = UDim2.new(0.5, -12, 0, -8)
    SliderButton.Size = UDim2.new(0, 24, 0, 51)
    SliderButton.Text = ""
    SliderButton.ZIndex = 2
    
    -- Slider Button Corner
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 12)
    ButtonCorner.Parent = SliderButton
    
    -- COLOR BUTTON
    local ColorButton = Instance.new("TextButton")
    ColorButton.Name = "ColorButton"
    ColorButton.Parent = MainFrame
    ColorButton.BackgroundColor3 = CONFIG.UI.ThemeColor
    ColorButton.BorderSizePixel = 0
    ColorButton.Position = UDim2.new(0.52, 0, 0.3, 5)
    ColorButton.Size = UDim2.new(0.4, 0, 0, 40)
    ColorButton.Font = Enum.Font.GothamBold
    ColorButton.Text = "🎨 COLOR"
    ColorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ColorButton.TextScaled = true
    ColorButton.TextSize = 16
    ColorButton.TextWrapped = true
    
    -- Color Button Corner
    local ColorCorner = Instance.new("UICorner")
    ColorCorner.CornerRadius = UDim.new(0, 5)
    ColorCorner.Parent = ColorButton
    
    -- CLOSE BUTTON
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = MainFrame
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(0.93, -20, 0, 5)
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextScaled = true
    CloseButton.TextSize = 16
    
    -- Close Button Corner
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 12)
    CloseCorner.Parent = CloseButton
    
    -- VERSION LABEL
    local VersionLabel = Instance.new("TextLabel")
    VersionLabel.Name = "VersionLabel"
    VersionLabel.Parent = MainFrame
    VersionLabel.BackgroundTransparency = 1
    VersionLabel.Position = UDim2.new(0, 10, 1, -25)
    VersionLabel.Size = UDim2.new(0, 100, 0, 20)
    VersionLabel.Font = Enum.Font.Gotham
    VersionLabel.Text = "v" .. CONFIG.Developer.Version
    VersionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    VersionLabel.TextSize = 12
    VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        Title = Title,
        ToggleButton = ToggleButton,
        SpeedLabel = SpeedLabel,
        SpeedSlider = SpeedSlider,
        SliderBar = SliderBar,
        SliderButton = SliderButton,
        ColorButton = ColorButton,
        CloseButton = CloseButton,
        VersionLabel = VersionLabel,
    }
end

-- ============================================================
-- FLY SYSTEM
-- ============================================================
local function CreateFlySystem()
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1, 1, 1) * CONFIG.Fly.MaxForce
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = RootPart
    
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1, 1, 1) * CONFIG.Fly.MaxForce
    bodyGyro.CFrame = RootPart.CFrame
    bodyGyro.Parent = RootPart
    
    return bodyVelocity, bodyGyro
end

local function StartFly()
    if FlyState.Active then return end
    
    -- Validate character
    if not Character or not Humanoid or not RootPart then
        Character = Player.Character
        Humanoid = Character and Character:FindFirstChild("Humanoid")
        RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if not Character or not Humanoid or not RootPart then
            warn("[GUI Fly] Character not found!")
            return
        end
    end
    
    FlyState.Active = true
    
    -- Create fly parts
    local bodyVelocity, bodyGyro = CreateFlySystem()
    
    -- Fly loop
    local connection = RunService.Heartbeat:Connect(function()
        if not FlyState.Active then
            bodyVelocity:Destroy()
            bodyGyro:Destroy()
            return
        end
        
        local moveDirection = Vector3.new()
        local camera = workspace.CurrentCamera
        
        -- Keyboard controls
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        -- Apply movement
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit * FlyState.Speed
            bodyVelocity.Velocity = moveDirection
            bodyGyro.CFrame = CFrame.new(RootPart.Position, RootPart.Position + camera.CFrame.LookVector)
        else
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
    end)
    
    table.insert(FlyState.Connections, connection)
end

local function StopFly()
    FlyState.Active = false
    
    -- Cleanup connections
    for _, conn in ipairs(FlyState.Connections) do
        conn:Disconnect()
    end
    FlyState.Connections = {}
    
    -- Cleanup body parts
    if RootPart then
        for _, v in pairs(RootPart:GetChildren()) do
            if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
                v:Destroy()
            end
        end
    end
end

-- ============================================================
-- UI FUNCTIONS
-- ============================================================
local function UpdateColor(color)
    FlyState.Color = color
    
    local elements = {
        GUI.MainFrame,
        GUI.Title,
        GUI.ToggleButton,
        GUI.SpeedLabel,
        GUI.SpeedSlider,
        GUI.SliderBar,
        GUI.ColorButton,
        GUI.SliderButton,
    }
    
    for _, element in ipairs(elements) do
        if element then
            if element == GUI.MainFrame then
                element.BorderColor3 = color
            elseif element == GUI.SliderButton then
                element.BorderColor3 = color
            elseif element == GUI.Title then
                element.BackgroundColor3 = color
            elseif element == GUI.ToggleButton then
                if not FlyState.Active then
                    element.BackgroundColor3 = color
                end
            elseif element == GUI.ColorButton then
                element.BackgroundColor3 = color
            elseif element == GUI.SpeedSlider then
                element.BorderColor3 = color
            elseif element == GUI.SliderBar then
                element.BackgroundColor3 = color
            elseif element == GUI.SpeedLabel then
                element.BackgroundColor3 = color
            end
        end
    end
end

local function RandomColor()
    local colors = {
        Color3.fromRGB(0, 170, 255),   -- Blue
        Color3.fromRGB(255, 50, 50),    -- Red
        Color3.fromRGB(50, 255, 50),    -- Green
        Color3.fromRGB(255, 255, 50),   -- Yellow
        Color3.fromRGB(255, 50, 255),   -- Magenta
        Color3.fromRGB(50, 255, 255),   -- Cyan
        Color3.fromRGB(255, 165, 0),    -- Orange
        Color3.fromRGB(255, 20, 147),   -- Pink
        Color3.fromRGB(128, 0, 255),    -- Purple
        Color3.fromRGB(0, 255, 127),    -- Spring Green
    }
    return colors[math.random(1, #colors)]
end

-- ============================================================
-- EVENT HANDLERS
-- ============================================================
local function SetupEvents(GUI)
    -- Toggle Fly
    GUI.ToggleButton.MouseButton1Click:Connect(function()
        if FlyState.Active then
            StopFly()
            GUI.ToggleButton.Text = "▶  START FLY"
            GUI.ToggleButton.BackgroundColor3 = FlyState.Color
        else
            StartFly()
            GUI.ToggleButton.Text = "⏹  STOP FLY"
            GUI.ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end
    end)
    
    -- Change Color
    GUI.ColorButton.MouseButton1Click:Connect(function()
        local newColor = RandomColor()
        UpdateColor(newColor)
    end)
    
    -- Close GUI
    GUI.CloseButton.MouseButton1Click:Connect(function()
        if FlyState.Active then
            StopFly()
        end
        GUI.ScreenGui:Destroy()
        print("[GUI Fly] Script unloaded successfully!")
    end)
    
    -- Slider Drag
    local draggingSlider = false
    
    GUI.SliderButton.MouseButton1Down:Connect(function()
        draggingSlider = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and 
           (input.UserInputType == Enum.UserInputType.MouseMovement or 
            input.UserInputType == Enum.UserInputType.Touch) then
            
            local sliderPos = input.Position.X
            local sliderAbsPos = GUI.SpeedSlider.AbsolutePosition.X
            local sliderSize = GUI.SpeedSlider.AbsoluteSize.X
            
            local percent = math.clamp((sliderPos - sliderAbsPos) / sliderSize, 0, 1)
            GUI.SliderBar.Size = UDim2.new(percent, 0, 1, 0)
            GUI.SliderButton.Position = UDim2.new(percent, -12, 0, -8)
            
            FlyState.Speed = math.floor(percent * (CONFIG.Fly.MaxSpeed - CONFIG.Fly.MinSpeed)) + CONFIG.Fly.MinSpeed
            GUI.SpeedLabel.Text = tostring(FlyState.Speed)
        end
    end)
    
    -- Mobile Touch Controls
    local touchStart = nil
    
    UserInputService.TouchStarted:Connect(function(input)
        if not FlyState.Active then return end
        touchStart = input.Position
    end)
    
    UserInputService.TouchMoved:Connect(function(input)
        if not FlyState.Active or not touchStart then return end
        
        local delta = input.Position - touchStart
        
        -- Simulate keyboard based on swipe direction
        if delta.Y < -40 then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, nil)
        elseif delta.Y > 40 then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.S, false, nil)
        end
        
        if delta.X < -40 then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.A, false, nil)
        elseif delta.X > 40 then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.D, false, nil)
        end
    end)
    
    UserInputService.TouchEnded:Connect(function()
        touchStart = nil
        -- Release all keys
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, nil)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.S, false, nil)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.A, false, nil)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.D, fa
