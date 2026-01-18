local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeianRussell/Kavo-UI-Library/main/Movable.source.lua"))()

local Window = Library.CreateLib("OUTWITT", "DarkTheme")
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Main")
Section:NewToggle("God Mode", "ToggleInfo", function(state)
       if state then
        _G.GodModeActive = true
        print("God Mode & Anti-Touch: ON")
    else
        _G.GodModeActive = false
        print("God Mode & Anti-Touch: OFF")
     
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanTouch = true
                end
            end
        end
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if _G.GodModeActive then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.MaxHealth = math.huge
            char.Humanoid.Health = math.huge
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanTouch = false
                end
            end
        end
    end
end)

Section:NewSlider("Walkspeed", "SliderInfo", 500, 0, function(s) -- 500 (MaxValue) | 0 (MinValue)
    local p = game:GetService("Players").LocalPlayer
    local char = p.Character or p.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    if hum then
        hum.WalkSpeed = s
    end
end)

Section:NewButton("Reset Speed", "Kembali ke 16", function()
    local p = game:GetService("Players").LocalPlayer
    local char = p.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char.Humanoid.WalkSpeed = 16
    end
end)

Section:NewToggle("Noclip", "ToggleInfo", function(state)
        if state then
        _G.NoclipActive = true
    else
        _G.NoclipActive = false
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if state then
        _G.NoclipActive = true
        print("Noclip Aktif")
    else
        _G.NoclipActive = false
        print("Noclip Mati")
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if _G.NoclipActive then
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

Section:NewToggle("Bug Crouch (PATCHED)", "ToggleInfo", function(state)
    if state then
        print("Error Bug Crouch Stack Begin Line 100")
    else
        print("Error Bug Crouch Stack Begin Line Off")
    end
end)

Section:NewToggle("Auto Collect Item", "ToggleInfo", function(state)
    if state then
        print("The item's ID was not found")
    else
        print("Toggle Off")
    end
end)

Section:NewToggle("Patched", "ToggleInfo", function(state)
    if state then
        print("Toggle On")
    else
        print("Toggle Off")
    end
end)
