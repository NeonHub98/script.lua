-- =====================================
-- SERVICES
-- =====================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local Player = Players.LocalPlayer

-- =====================================
-- GAME NAME
-- =====================================
local GameName = "Game"
pcall(function()
	GameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
end)

-- =====================================
-- FLUENT UI
-- =====================================
local Fluent = loadstring(game:HttpGet(
	"https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"
))()

Fluent:Notify({
	Title = "Script executado com sucesso",
	Content = "Você está usando o melhor script ZEON HUB",
	Duration = 6
})

local Window = Fluent:CreateWindow({
	Title = "ZEON HUB",
	SubTitle = "-- " .. GameName,
	TabWidth = 120,
	Size = UDim2.fromOffset(350, 250),
	Acrylic = false,
	Theme = "Dark",
	MinimizeKey = Enum.KeyCode.LeftControl
})

-- =====================================
-- REMOTES
-- =====================================
local Remotes = ReplicatedStorage:WaitForChild("RemotesFolder")
local EnterTrial = Remotes:WaitForChild("EnterTrial")

-- =====================================
-- STATES
-- =====================================
local AutoTrialEasy = false
local AutoWalkTrialEasy = false
local InTrialEasy = false

local AutoTrialMedium = false
local AutoWalkTrialMedium = false
local InTrialMedium = false

-- =====================================
-- TRIAL EASY POSITIONS
-- =====================================
local TrialEasyMobs = {
    Vector3.new(-399.16275, 1005.16699, 3280.09619),
    Vector3.new(-399.16275, 1005.16699, 3309.08643),
    Vector3.new(-399.16275, 1005.16699, 3339.84668),
    Vector3.new(-399.16275, 1005.16699, 3372.55664)
}

-- =====================================
-- TRIAL MEDIUM POSITIONS
-- =====================================
local TrialMediumMobs = {
    Vector3.new(-399.16275, 1005.16699, 3280.09619),
    Vector3.new(-399.16275, 1005.16699, 3309.08643),
    Vector3.new(-399.16275, 1005.16699, 3339.84668),
    Vector3.new(-399.16275, 1005.16699, 3372.55664)
}

-- =====================================
-- AUTO ENTER TRIAL EASY
-- =====================================
task.spawn(function()
	while task.wait(1) do
		if AutoTrialEasy and not InTrialEasy then
			pcall(function()
				EnterTrial:FireServer(1)
			end)
		end
	end
end)

-- DETECT IN TRIAL EASY
task.spawn(function()
	local lastPos
	while task.wait(0.5) do
		local char = Player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			local pos = char.HumanoidRootPart.Position
			if lastPos and (pos - lastPos).Magnitude > 200 then
				InTrialEasy = true
			end
			lastPos = pos
		end
	end
end)

-- AUTO TRIAL EASY EXECUÇÃO (MoveTo)
task.spawn(function()
	while task.wait(0.5) do
		if AutoWalkTrialEasy and InTrialEasy then
			local char = Player.Character
			if char and char:FindFirstChild("Humanoid") then
				local humanoid = char:FindFirstChild("Humanoid")
				task.wait(5) -- espera carregar mapa
				while AutoWalkTrialEasy and InTrialEasy do
					for _, pos in ipairs(TrialEasyMobs) do
						humanoid:MoveTo(pos)
						humanoid.MoveToFinished:Wait()
						task.wait(0.5)
					end
				end
			end
		end
	end
end)

-- =====================================
-- AUTO ENTER TRIAL MEDIUM
-- =====================================
task.spawn(function()
	while task.wait(1) do
		if AutoTrialMedium and not InTrialMedium then
			pcall(function()
				EnterTrial:FireServer(2)
			end)
		end
	end
end)

-- DETECT IN TRIAL MEDIUM
task.spawn(function()
	local lastPos
	while task.wait(0.5) do
		local char = Player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			local pos = char.HumanoidRootPart.Position
			if lastPos and (pos - lastPos).Magnitude > 200 then
				InTrialMedium = true
			end
			lastPos = pos
		end
	end
end)

-- AUTO TRIAL MEDIUM EXECUÇÃO (MoveTo)
task.spawn(function()
	while task.wait(0.5) do
		if AutoWalkTrialMedium and InTrialMedium then
			local char = Player.Character
			if char and char:FindFirstChild("Humanoid") then
				local humanoid = char:FindFirstChild("Humanoid")
				task.wait(5) -- espera carregar mapa
				while AutoWalkTrialMedium and InTrialMedium do
					for _, pos in ipairs(TrialMediumMobs) do
						humanoid:MoveTo(pos)
						humanoid.MoveToFinished:Wait()
						task.wait(0.5)
					end
				end
			end
		end
	end
end)

-- =====================================
-- UI TAB
-- =====================================
local TabTrial = Window:AddTab({ Title = "Auto Trial", Icon = "swords" })

-- Seção Easy
TabTrial:AddSection("Trial Easy")
TabTrial:AddToggle("AutoTrialEasy", {
	Title = "Auto Enter + MoveTo Trial Easy",
	Default = false,
	Callback = function(v)
		AutoTrialEasy = v
		AutoWalkTrialEasy = v
		InTrialEasy = false
	end
})

-- Seção Medium
TabTrial:AddSection("Trial Medium")
TabTrial:AddToggle("AutoTrialMedium", {
	Title = "Auto Enter + MoveTo Trial Medium",
	Default = false,
	Callback = function(v)
		AutoTrialMedium = v
		AutoWalkTrialMedium = v
		InTrialMedium = false
	end
})
