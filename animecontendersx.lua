local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local PlaceId = game.PlaceId
local ProductInfo = MarketplaceService:GetProductInfo(PlaceId)
local GameName = ProductInfo.Name

local Main = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Main")

Fluent:Notify({ Title = "Script executado com sucesso", Content = "Você está usando Neon Hub" })

local Window = Fluent:CreateWindow({
    Title = "Neon Hub",
    SubTitle = "-- " .. GameName,
    TabWidth = 102,
    Size = UDim2.fromOffset(450, 320),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "| Farm", Icon = "rbxassetid://18831424669" }),
    Gacha = Window:AddTab({ Title = "| Gachas", Icon = "rbxassetid://18831424669" }),
    TrialShop = Window:AddTab({ Title = "| Trial Shop", Icon = "rbxassetid://18831424669" })
}

Window:SelectTab(1)

--------------------------------------------------
-- 🧪 FARM DE TRIAL: 2 Teleportes com 1s cada
--------------------------------------------------

Tabs.Main:AddParagraph({
    Title = "🧪 Farm de Trial",
    Content = "Este sistema de Auto Farm com loop de teleporte alterna entre duas posições estratégicas com intervalo de 1 segundo."
})

local TeleporteLoop = Tabs.Main:AddToggle("TeleporteLoop", {
    Title = "Loop de Teleportes (Trial)",
    Default = false
})

TeleporteLoop:OnChanged(function()
    while TeleporteLoop.Value do
        local hrp = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(-2299.96045, -286.939514, 250.030273)
            task.wait(1)
            hrp.CFrame = CFrame.new(-2325.96045, -286.939514, 319.030273)
            task.wait(1)
        else
            task.wait(1)
        end
    end
end)

--------------------------------------------------
-- 🎰 GACHA: Organizado por sistemas com tempo 0.1s
--------------------------------------------------

-- 🧙‍♂️ AVATAR SYSTEM
Tabs.Gacha:AddParagraph({
    Title = "🧙‍♂️ Avatar System",
    Content = "Ative repetidamente o Avatar JJK"
})

local AvatarToggle = Tabs.Gacha:AddToggle("AvatarJJK", {
    Title = "Ativar Avatar JJK (Loop)",
    Default = false
})

AvatarToggle:OnChanged(function()
    while AvatarToggle.Value do
        Main:FireServer("bjasxk", { Name = "JJK" })
        task.wait(0.1)
    end
end)

-- 🗡️ ISLAND OF ASSASSINS
Tabs.Gacha:AddParagraph({
    Title = "🗡️ Island of Assassins",
    Content = "Tokens relacionados à ilha dos assassinos"
})

local assassinTokens = {
    { id = "Wings", label = "Consumir Wings" },
    { id = "SwordToken", label = "Consumir SwordToken" }
}

for _, token in ipairs(assassinTokens) do
    local toggle = Tabs.Gacha:AddToggle("Assassin_" .. token.id, {
        Title = token.label,
        Default = false
    })

    toggle:OnChanged(function()
        coroutine.wrap(function()
            while toggle.Value do
                Main:FireServer("usvp", { Type = token.id })
                task.wait(0.1)
            end
        end)()
    end)
end

-- 🐉 DRAGON SYSTEMS
Tabs.Gacha:AddParagraph({
    Title = "🐉 Dragon Systems",
    Content = "Tokens relacionados ao universo Dragon Ball"
})

local dragonTokens = {
    { id = "SaiyanToken", label = "Consumir SaiyanToken" },
    { id = "Capsule", label = "Consumir Capsule" }
}

for _, token in ipairs(dragonTokens) do
    local toggle = Tabs.Gacha:AddToggle("Dragon_" .. token.id, {
        Title = token.label,
        Default = false
    })

    toggle:OnChanged(function()
        coroutine.wrap(function()
            while toggle.Value do
                Main:FireServer("usvp", { Type = token.id })
                task.wait(0.1)
            end
        end)()
    end)
end

-- 🌑 SLAYER SYSTEMS
Tabs.Gacha:AddParagraph({
    Title = "🌑 Slayer Systems",
    Content = "Tokens relacionados ao universo Demon Slayer"
})

local slayerTokens = {
    { id = "DemonToken", label = "Consumir DemonToken" },
    { id = "BreathingToken", label = "Consumir BreathingToken" }
}

for _, token in ipairs(slayerTokens) do
    local toggle = Tabs.Gacha:AddToggle("Slayer_" .. token.id, {
        Title = token.label,
        Default = false
    })

    toggle:OnChanged(function()
        coroutine.wrap(function()
            while toggle.Value do
                Main:FireServer("usvp", { Type = token.id })
                task.wait(0.1)
            end
        end)()
    end)
end

-- 🌀 JUJUTSU SYSTEMS
Tabs.Gacha:AddParagraph({
    Title = "🌀 Jujutsu Systems",
    Content = "Tokens relacionados ao universo Jujutsu Kaisen"
})

local jujutsuTokens = {
    { id = "SukunaToken", label = "Consumir SukunaToken" },
    { id = "LineageToken", label = "Consumir LineageToken" }
}

for _, token in ipairs(jujutsuTokens) do
    local toggle = Tabs.Gacha:AddToggle("Jujutsu_" .. token.id, {
        Title = token.label,
        Default = false
    })

    toggle:OnChanged(function()
        coroutine.wrap(function()
            while toggle.Value do
                Main:FireServer("usvp", { Type = token.id })
                task.wait(0.1)
            end
        end)()
    end)
end

--------------------------------------------------
-- 🛍️ TRIAL SHOP: Dropdown + compra em loop
--------------------------------------------------

Tabs.TrialShop:AddParagraph({
    Title = "🛍️ Comprar Item",
    Content = "Escolha um item e ative o loop para comprar continuamente"
})

local itemDropdown = Tabs.TrialShop:AddDropdown("ItemSelector", {
    Title = "Selecionar Item",
    Values = {
        "StarPotion",
        "DropsPotion",
        "LuckPotion",
        "ExpPotion",
        "DamagePotion",
        "StatReset",
        "ChronoTicket"
    },
    Multi = false,
    Default = "StarPotion"
})

local buyLoopToggle = Tabs.TrialShop:AddToggle("BuyLoopToggle", {
    Title = "Comprar em Loop",
    Default = false
})

buyLoopToggle:OnChanged(function()
    coroutine.wrap(function()
        while buyLoopToggle.Value do
            local selected = itemDropdown.Value
            if selected then
                firesignal(Main.OnClientEvent, "AddingItem", {
                    Type = "Plus",
                    Item = selected,
                    Cantity = 1
                })
            end
            task.wait(0.1)
        end
    end)()
end)
