local CorrectKey = "ScriptGaming Subs482" -- Ganti kunci sesukamu
local GetKeyLink = "https://pastebin.com/B8ajhBqa" -- Link untuk ambil key

local MainUrl = "https://raw.githubusercontent.com/Edgeiy/infiniteyield/master/source"

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local KeyInput = Instance.new("TextBox")
local SubmitBtn = Instance.new("TextButton")
local GetBtn = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "GetKeySystem"

Main.Parent = ScreenGui
Main.Size = UDim2.new(0, 240, 0, 140)
Main.Position = UDim2.new(0.5, -120, 0.5, -70)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true 

KeyInput.Parent = Main
KeyInput.PlaceholderText = "Enter Key...."
KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
KeyInput.Position = UDim2.new(0.1, 0, 0.25, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)

SubmitBtn.Parent = Main
SubmitBtn.Text = "SUBMIT"
SubmitBtn.Size = UDim2.new(0.35, 0, 0, 30)
SubmitBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

GetBtn.Parent = Main
GetBtn.Text = "GET KEY"
GetBtn.Size = UDim2.new(0.35, 0, 0, 30)
GetBtn.Position = UDim2.new(0.55, 0, 0.6, 0)
GetBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
GetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

GetBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(GetKeyLink)
        GetBtn.Text = "COPIED!"
        task.wait(1)
        GetBtn.Text = "GET KEY"
    end
end)

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        SubmitBtn.Text = "LOADING..."
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        
        local success, err = pcall(function()
            loadstring(game:HttpGet(MainUrl))()
        end)
        
        if success then
            ScreenGui:Destroy()
        else
            SubmitBtn.Text = "ERROR!"
            warn("Gagal load script: " .. tostring(err))
        end
    else
        SubmitBtn.Text = "WRONG!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        task.wait(1)
        SubmitBtn.Text = "SUBMIT"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end
end)
