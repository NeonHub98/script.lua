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
local AutoTrial = false
local AutoWalkTrial = false
local InTrial = false

-- =====================================
-- TRIAL EASY CFRAMES (Mobs)
-- =====================================
local TrialEasyMobs = {
    CFrame.new(-399.16275, 1005.16699, 3280.09619, 6.59227371e-05, 0.930409431, -0.366521657, 0.999999881, -6.58035278e-05, 1.25020742e-05, -1.25020742e-05, -0.366521657, -0.930409431),
    CFrame.new(-399.16275, 1005.16699, 3309.08643, 6.59227371e-05, 0.930409431, -0.366521657, 0.999999881, -6.58035278e-05, 1.25020742e-05, -1.25020742e-05, -0.366521657, -0.930409431),
    CFrame.new(-399.16275, 1005.16699, 3339.84668, 6.59227371e-05, 0.930409431, -0.366521657, 0.999999881, -6.58035278e-05, 1.25020742e-05, -1.25020742e-05, -0.366521657, -0.930409431),
    CFrame.new(-399.16275, 1005.16699, 3372.55664, 6.59227371e-05, 0.930409431, -0.366521657, 0.999999881, -6.58035278e-05, 1.25020742e-05, -1.25020742e-05, -0.366521657, -0.930409431)
}

-- =====================================
-- AUTO ENTER TRIAL
-- =====================================
task.spawn(function()
	while task.wait(1) do
		if AutoTrial and not InTrial then
			pcall(function()
				EnterTrial:FireServer(1) -- sempre Trial Easy
			end)
		end
	end
end)

-- =====================================
-- DETECT IN TRIAL
-- =====================================
task.spawn(function()
	local lastPos
	while task.wait(0.5) do
		local char = Player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			local pos = char.HumanoidRootPart.Position
			if lastPos and (pos - lastPos).Magnitude > 200 then
				InTrial = true
			end
			lastPos = pos
		end
	end
end)

-- =====================================
-- AUTO TRIAL EXECUÇÃO (andar entre mobs)
-- =====================================
task.spawn(function()
	while task.wait(0.5) do
		if AutoWalkTrial and InTrial then
			local char = Player.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				local hrp = char.HumanoidRootPart

				-- Delay de 5 segundos para carregar mapa
				task.wait(5)

				-- Loop entre os mobs da Trial Easy
				while AutoWalkTrial and InTrial do
					for _, cf in ipairs(TrialEasyMobs) do
						hrp.CFrame = cf
						task.wait(0.5) -- tempo em cada mob
					end
				end
			end
		end
	end
end)

-- =====================================
-- UI TAB
-- =====================================
local TabTrial = Window:AddTab({ Title = "Auto Trial Easy", Icon = "swords" })

TabTrial:AddToggle("AutoTrial", {
	Title = "Auto Enter + Farm Trial Easy",
	Default = false,
	Callback = function(v)
		AutoTrial = v
		AutoWalkTrial = v
		if not v then InTrial = false end
	end
})
