local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local MarketplaceService = game:GetService("MarketplaceService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Obter nome do jogo
local success, gameInfo = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId)
end)
local gameName = success and gameInfo.Name or "Jogo Desconhecido"

-- Interface
local Window = Fluent:CreateWindow({
    Title = "NetoX Hub",
    SubTitle = "-- " .. gameName,
    TabWidth = 110,
    Size = UDim2.fromOffset(400, 200),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tab = Window:AddTab({ Title = "| Auto Boss", Icon = "rbxassetid://18831424669" })
Window:SelectTab(1)

Tab:AddParagraph({
    Title = "👹 Auto Boss",
    Content = "Varredura a cada 10 minutos + detecção de boss global"
})

-- Lista de CFrames dos bosses
local bossCFrames = {
    CFrame.new(-167.655762, 24.4496307, -349.168213),
    CFrame.new(-229.368652, 24.5450287, 159.449951),
    CFrame.new(74.5591812, 5.09985352, -2257.85645, 0, 0, -1, 0, 1, 0, 1, 0, 0),
    CFrame.new(-168.017975, 5.36529541, -2011.25635, -0.342042685, 0, -0.939684391, 0, 1, 0, 0.939684391, 0, -0.342042685),
    CFrame.new(2279.64502, 10.6542358, -66.4322739, 0, 0, -1, 0, 1, 0, 1, 0, 0),
    CFrame.new(242.869904, 14.2229776, 1822.15356, 0, 0, 1, 1, 0, 0, 0, 1, 0),
    CFrame.new(-126.207565, 14.2375021, 1857.74622, 0, 0, 1, 0, 1, 0, -1, 0, 0)
}

-- Toggle de ativação
local autoBossToggle = Tab:AddToggle("AutoBossToggle", {
    Title = "🔁 Ativar Auto Boss",
    Default = false
})

-- Função para teleportar até boss global
local function teleportToBoss(boss)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local bossHRP = boss:FindFirstChild("HumanoidRootPart")
    if hrp and bossHRP then
        hrp.CFrame = bossHRP.CFrame + Vector3.new(0, 5, 0)
        Fluent:Notify({
            Title = "👹 Boss Global Detectado!",
            Content = "Teleportando para: " .. boss.Name,
            Duration = 5
        })
    end
end

-- Monitorar pasta de bosses globais
local enemiesFolder = Workspace:WaitForChild("Server"):WaitForChild("Enemies"):WaitForChild("Gamemodes"):WaitForChild("Global Bosses")

enemiesFolder.ChildAdded:Connect(function(boss)
    if autoBossToggle.Value and boss:IsA("Model") then
        boss:WaitForChild("HumanoidRootPart", 10)
        task.wait(1)
        teleportToBoss(boss)
    end
end)

-- Loop principal: varredura a cada 10 minutos
autoBossToggle:OnChanged(function(state)
    if state then
        coroutine.wrap(function()
            while autoBossToggle.Value do
                for _, cf in ipairs(bossCFrames) do
                    if not autoBossToggle.Value then break end
                    local hrp = character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = cf + Vector3.new(0, 5, 0)
                    end
                    task.wait(3)
                end
                if autoBossToggle.Value then
                    task.wait(600 - (#bossCFrames * 3))
                end
            end
        end)()
    end
end)
