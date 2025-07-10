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
]]--

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Make sure GUI folder exists
local gui = Instance.new("ScreenGui")
if syn then syn.protect_gui(gui) end
pcall(function() gui.Parent = game.CoreGui end)
gui.Name = "KELLYEXE_GUI"

-- Dark horror atmosphere
Lighting.Ambient = Color3.fromRGB(0, 0, 0)
Lighting.FogEnd = 100
Lighting.FogStart = 0
Lighting.FogColor = Color3.fromRGB(255, 0, 0)
Lighting.Brightness = 0.3

-- Red glitch sky
local sky = Instance.new("Sky", Lighting)
sky.SkyboxBk = "http://www.roblox.com/asset/?id=159454299"
sky.SkyboxDn = sky.SkyboxBk
sky.SkyboxFt = sky.SkyboxBk
sky.SkyboxLf = sky.SkyboxBk
sky.SkyboxRt = sky.SkyboxBk
sky.SkyboxUp = sky.SkyboxBk

-- Scary sound
local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://1837635124"
sound.Volume = 5
sound.Looped = true
sound:Play()

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

-- Spin above player
spawn(function()
	while clone and clone:FindFirstChild("HumanoidRootPart") and Character:FindFirstChild("HumanoidRootPart") do
		clone:PivotTo(Character:GetPivot() * CFrame.new(0, 15, 0) * CFrame.Angles(0, tick() * 1.5, 0))
		RunService.RenderStepped:Wait()
	end
end)

-- Fake global chat messages
spawn(function()
	while true do
		wait(math.random(6,12))
		local msg = "KELLY.EXE has entered your game..."
		pcall(function()
			ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
			:WaitForChild("SayMessageRequest")
			:FireServer(msg, "All")
		end)
	end
end)

-- Flashing jumpscare GUI
local img = Instance.new("ImageLabel", gui)
img.Size = UDim2.new(1, 0, 1, 0)
img.Image = "rbxassetid://8183827427"
img.BackgroundTransparency = 1
img.ImageTransparency = 1
img.ZIndex = 10

spawn(function()
	while true do
		wait(math.random(10,18))
		img.ImageTransparency = 0
		wait(0.2)
		img.ImageTransparency = 1
	end
end)

-- Done
print("[KELLY.EXE] Loaded successfully.")
