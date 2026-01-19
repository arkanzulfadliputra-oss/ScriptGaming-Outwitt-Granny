local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "UNIVERSAL HUB",
   Icon = user, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading",
   LoadingSubtitle = "by ScriptGaming",
   ShowText = "Hub", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Tab = Window:CreateTab("Main", "user")

local Section = Tab:CreateSection("Main")

local Toggle = Tab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
      local RunService = game:GetService("RunService")
      local Player = game.Players.LocalPlayer
      
      _G.NoclipEnabled = Value

      if _G.NoclipEnabled then
          _G.NoclipConnection = RunService.Stepped:Connect(function()
              if _G.NoclipEnabled and Player.Character then
                  for _, part in pairs(Player.Character:GetDescendants()) do
                      if part:IsA("BasePart") then
                          part.CanCollide = false
                      end
                  end
              else
                  if _G.NoclipConnection then
                      _G.NoclipConnection:Disconnect()
                  end
              end
          end)
      else
          _G.NoclipEnabled = false
          if _G.NoclipConnection then
              _G.NoclipConnection:Disconnect()
          end
          
          if Player.Character then
              for _, part in pairs(Player.Character:GetDescendants()) do
                  if part:IsA("BasePart") then
                      part.CanCollide = true
                  end
              end
          end
      end
   end,
})

local Slider = Tab:CreateSlider({
   Name = "Walkspeed",
   Range = {0, 1000},
   Increment = 16,
   Suffix = "Walkspeed",
   CurrentValue = 16,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
       local Player = game.Players.LocalPlayer
      
      if Player and Player.Character and Player.Character:FindFirstChild("Humanoid") then
         Player.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local Slider = Tab:CreateSlider({
   Name = "JumpHeight",
   Range = {0, 1000},
   Increment = 50,
   Suffix = "JumpPower",
   CurrentValue = 50,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
      local Player = game.Players.LocalPlayer
      local Character = Player.Character
      
      if Character and Character:FindFirstChild("Humanoid") then
         Character.Humanoid.UseJumpPower = true
         Character.Humanoid.JumpPower = Value
      end
   end,
})

local Tab = Window:CreateTab("Combat", "sword")

local Section = Tab:CreateSection("Combat")

local Toggle = Tab:CreateToggle({
   Name = "Aimbot Enable",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
      local RunService = game:GetService("RunService")
      local Players = game:GetService("Players")
      local LocalPlayer = Players.LocalPlayer
      local Camera = workspace.CurrentCamera
      
      _G.TargetEnabled = Value

      local function getClosestPlayer()
          local closest = nil
          local maxDistance = math.huge

          for _, p in pairs(Players:GetPlayers()) do
              if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                  local dist = (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                  if dist < maxDistance then
                      maxDistance = dist
                      closest = p
                  end
              end
          end
          return closest
      end

      if _G.TargetEnabled then
          _G.AimLoop = RunService.RenderStepped:Connect(function()
              if _G.TargetEnabled then
                  local target = getClosestPlayer()
                  if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                      Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
                  end
              else
                  if _G.AimLoop then _G.AimLoop:Disconnect() end
              end
          end)
      else
          if _G.AimLoop then
              _G.AimLoop:Disconnect()
          end
      end
   end,
})

local Keybind = Tab:CreateKeybind({
   Name = "Aimbot",
   CurrentKeybind = "Q",
   HoldToInteract = false,
   Flag = "Keybind1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)
     local Players = game:GetService("Players")
      local RunService = game:GetService("RunService")
      local Camera = workspace.CurrentCamera
      local LocalPlayer = Players.LocalPlayer
      local TagName = "Aimbot_Lock_Active"
      
      local activeTag = Camera:FindFirstChild(TagName)

      if not activeTag then
          local marker = Instance.new("BoolValue")
          marker.Name = TagName
          marker.Parent = Camera
          
          local connection
          connection = RunService.RenderStepped:Connect(function()
              if not Camera:FindFirstChild(TagName) then
                  connection:Disconnect()
                  return
              end
              
              local target = nil
              local shortestDist = math.huge
              
              for _, v in pairs(Players:GetPlayers()) do
                  if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                      local pos, onScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                      if onScreen then
                          local magnitude = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                          if magnitude < shortestDist then
                              shortestDist = magnitude
                              target = v
                          end
                      end
                  end
              end

              if target and target.Character then
                  Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
              end
          end)
      else
          activeTag:Destroy()
      end
   end,
})

local Tab = Window:CreateTab("ESP/VISUAL", "eye")

local Section = Tab:CreateSection("ESP PLAYER")

local Toggle = Tab:CreateToggle({
   Name = "Esp Player",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
     local TagName = "Visual_ESP_Object"
      local Players = game:GetService("Players")
      _G.EspActive = Value

      if _G.EspActive then
          local function ApplyESP(p)
              if p ~= Players.LocalPlayer and p.Character then
                  if not p.Character:FindFirstChild(TagName) then
                      local hl = Instance.new("Highlight")
                      hl.Name = TagName
                      hl.FillColor = Color3.fromRGB(255, 0, 0) -- Merah
                      hl.OutlineColor = Color3.fromRGB(255, 255, 255) -- Putih
                      hl.FillTransparency = 0.5
                      hl.Parent = p.Character
                  end
              end
          end

          for _, plr in pairs(Players:GetPlayers()) do
              ApplyESP(plr)
          end

          _G.EspConnection = Players.PlayerAdded:Connect(function(newPlr)
              newPlr.CharacterAdded:Connect(function(char)
                  task.wait(0.5)
                  if _G.EspActive then ApplyESP(newPlr) end
              end)
          end)
      else
          if _G.EspConnection then _G.EspConnection:Disconnect() end
          for _, plr in pairs(Players:GetPlayers()) do
              if plr.Character and plr.Character:FindFirstChild(TagName) then
                  plr.Character[TagName]:Destroy()
              end
          end
      end
   end,
})

local Tab = Window:CreateTab("Misc", "menu")

local Section = Tab:CreateSection("Misc")

local Toggle = Tab:CreateToggle({
   Name = "Fullbright + No Fog",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
       local Lighting = game:GetService("Lighting")
      
      _G.OriginalFogStart = _G.OriginalFogStart or Lighting.FogStart
      _G.OriginalFogEnd = _G.OriginalFogEnd or Lighting.FogEnd
      _G.OriginalBrightness = _G.OriginalBrightness or Lighting.Brightness
      _G.OriginalClockTime = _G.OriginalClockTime or Lighting.ClockTime

      if Value then
          Lighting.Brightness = 2
          Lighting.ClockTime = 14
          Lighting.FogEnd = 9e9
          Lighting.GlobalShadows = false
          Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
          
          _G.LightLoop = Lighting.Changed:Connect(function()
              if Value then
                  Lighting.Brightness = 2
                  Lighting.ClockTime = 14
                  Lighting.FogEnd = 9e9
                  Lighting.GlobalShadows = false
              end
          end)
      else
          if _G.LightLoop then _G.LightLoop:Disconnect() end
          
          Lighting.Brightness = _G.OriginalBrightness
          Lighting.ClockTime = _G.OriginalClockTime
          Lighting.FogEnd = _G.OriginalFogEnd
          Lighting.GlobalShadows = true
          Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
      end
   end,
})

local Toggle = Tab:CreateToggle({
   Name = "Xray",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
            local Workspace = game:GetService("Workspace")
      
      local function applyXray(obj)
          if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
              if not obj:FindFirstChild("OriginalTransparency") then
                  local original = Instance.new("NumberValue")
                  original.Name = "OriginalTransparency"
                  original.Value = obj.Transparency
                  original.Parent = obj
              end
              
              if Value then
                  obj.Transparency = 0.5
              else
                  obj.Transparency = obj:FindFirstChild("OriginalTransparency").Value -- Balik normal
              end
          end
      end

      for _, object in pairs(Workspace:GetDescendants()) do
          applyXray(object)
      end
   end,
})
