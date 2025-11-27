local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local ReliableRemote = ReplicatedStorage:WaitForChild("Reply"):WaitForChild("Reliable")

Fluent:Notify({ Title = "Script executado com sucesso", Content = "Neon Hub - Defense Mode" })

local Window = Fluent:CreateWindow({
    Title = "Neon Hub",
    SubTitle = "-- Defense Mode",
    TabWidth = 102,
    Size = UDim2.fromOffset(450, 320),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "| Defense", Icon = "rbxassetid://18831424669" })
}

Window:SelectTab(1)

--------------------------------------------------
-- ⚔️ AUTO DEFENSE
--------------------------------------------------

Tabs.Main:AddParagraph({
    Title = "⚔️ Auto Defense",
    Content = "Entra automaticamente no modo Defense:1"
})

local autoDefenseToggle = Tabs.Main:AddToggle("AutoDefenseToggle", {
    Title = "Ativar Auto Defense",
    Default = false
})

autoDefenseToggle:OnChanged(function()
    coroutine.wrap(function()
        while autoDefenseToggle.Value do
            local enemies = Workspace:FindFirstChild("Enemies")
            if not enemies or #enemies:GetChildren() == 0 then
                local args = {
                    "Join Gamemode",
                    { "Defense:1" }
                }
                ReliableRemote:FireServer(unpack(args))
            end
            task.wait(1)
        end
    end)()
end)

--------------------------------------------------
-- 🧪 TELEPORTE FIXO CONTÍNUO
--------------------------------------------------

Tabs.Main:AddParagraph({
    Title = "🧪 Teleporte contínuo",
    Content = "Teleporta para o ponto fixo enquanto houver inimigos"
})

local teleportToggle = Tabs.Main:AddToggle("TeleportToggle", {
    Title = "Ativar Teleporte",
    Default = false
})

teleportToggle:OnChanged(function(state)
    coroutine.wrap(function()
        while state and teleportToggle.Value do
            local enemies = Workspace:FindFirstChild("Enemies")
            if enemies and #enemies:GetChildren() > 0 then
                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(8308.69922, 63.4373932, 3990.05762)
                end
            end
            task.wait(1)
        end
    end)()
end)

--------------------------------------------------
-- 🚶 CAMINHADA A CADA 5 MINUTOS
--------------------------------------------------

Tabs.Main:AddParagraph({
    Title = "🚶 Caminhada periódica",
    Content = "Anda até o ponto a cada 5 minutos"
})

local walkToggle = Tabs.Main:AddToggle("WalkToPointToggle", {
    Title = "Ativar Caminhada",
    Default = false
})

walkToggle:OnChanged(function(state)
    coroutine.wrap(function()
        while state and walkToggle.Value do
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local humanoid = character:WaitForChild("Humanoid")
            local destino = Vector3.new(8235.36426, 52.5319061, 1466.65723)
            humanoid:MoveTo(destino)
            task.wait(300) -- 5 minutos
        end
    end)()
end)
