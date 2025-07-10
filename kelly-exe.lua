-- KELLY.EXE - FE Universal Terror Script
-- Full Visual Impact, Atmosphere Control, and Psychological Presence
-- Works in any game (client-side), loadable via GitHub loadstring

--[[
🔥 FEATURES:
✅ Haunting ambient lighting and fog
✅ Red glitch skybox and horror audio
✅ Floating ghostly clone
✅ Periodic chat messages
✅ Sudden jumpscare flashes
✅ .haunt and .stop commands to toggle everything
]]--

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")

-- Toggle state
local hauntingEnabled = true

-- GUI
local gui = Instance.new("ScreenGui")
if syn then syn.protect_gui(gui) end
pcall(function() gui.Parent = game.CoreGui end)
gui.Name = "KELLYEXE_GUI"

-- Sky
local sky = Instance.new("Sky")
sky.SkyboxBk = "http://www.roblox.com/asset/?id=159454299"
sky.SkyboxDn = sky.SkyboxBk
sky.SkyboxFt = sky.SkyboxBk
sky.SkyboxLf = sky.SkyboxBk
sky.SkyboxRt = sky.SkyboxBk
sky.SkyboxUp = sky.SkyboxBk

-- Sound
local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://1837635124"
sound.Volume = 5
sound.Looped = true

-- Floating ghost clone
local clone = Character:Clone()
clone.Name = "KELLY.EXE"
for _, part in ipairs(clone:GetDescendants()) do
	if part:IsA("BasePart") then
		part.Anchored = true
		part.Transparency = 0.4
		part.Material = Enum.Material.Neon
	end
end
clone.Parent = workspace

-- Floating clone loop
spawn(function()
	while clone and clone:FindFirstChild("HumanoidRootPart") and Character:FindFirstChild("HumanoidRootPart") do
		if hauntingEnabled then
			clone:PivotTo(Character:GetPivot() * CFrame.new(0, 15, 0) * CFrame.Angles(0, tick() * 1.5, 0))
		end
		RunService.RenderStepped:Wait()
	end
end)

-- Jumpscare flash
local img = Instance.new("ImageLabel", gui)
img.Size = UDim2.new(1, 0, 1, 0)
img.Image = "rbxassetid://8183827427"
img.BackgroundTransparency = 1
img.ImageTransparency = 1
img.ZIndex = 10

spawn(function()
	while true do
		if hauntingEnabled then
			img.ImageTransparency = 0
			wait(0.2)
			img.ImageTransparency = 1
		end
		wait(math.random(10,18))
	end
end)

-- Haunting effects toggle
local function enableHaunting()
	Lighting.Ambient = Color3.fromRGB(0, 0, 0)
	Lighting.FogEnd = 100
	Lighting.FogStart = 0
	Lighting.FogColor = Color3.fromRGB(255, 0, 0)
	Lighting.Brightness = 0.3
	if not sky.Parent then sky.Parent = Lighting end
	sound:Play()
end

local function disableHaunting()
	Lighting.Ambient = Color3.fromRGB(127, 127, 127)
	Lighting.FogEnd = 100000
	Lighting.FogStart = 0
	Lighting.FogColor = Color3.fromRGB(255, 255, 255)
	Lighting.Brightness = 2
	sky:Destroy()
	sound:Stop()
end

-- Chat listener for commands
LocalPlayer.Chatted:Connect(function(msg)
	msg = msg:lower()
	if msg == ".haunt" or msg == ".haunt on" then
		hauntingEnabled = true
		enableHaunting()
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[KELLY.EXE] Haunting enabled.",
			Color = Color3.fromRGB(255, 0, 0)
		})
	elseif msg == ".stop" or msg == ".haunt off" then
		hauntingEnabled = false
		disableHaunting()
		StarterGui:SetCore("ChatMakeSystemMessage", {
			Text = "[KELLY.EXE] Haunting stopped.",
			Color = Color3.fromRGB(100, 255, 100)
		})
	end
end)

-- Chat spam loop
spawn(function()
	while true do
		if hauntingEnabled then
			pcall(function()
				ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
				:WaitForChild("SayMessageRequest")
				:FireServer("KELLY.EXE has entered your game...", "All")
			end)
		end
		wait(math.random(6,12))
	end
end)

-- Auto start
if hauntingEnabled then
	enableHaunting()
end

print("[KELLY.EXE] Loaded with .haunt and .stop commands.")
