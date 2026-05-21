local Libary = loadstring(game:HttpGet("https://raw.githubusercontent.com/josearlindodasilva07-svg/Steal/refs/heads/main/Libary%20Vortex"))()

workspace.FallenPartsDestroyHeight = -math.huge

local Window = Libary:MakeWindow({
    Title = "VORTEX HUB",
    SubTitle = "By Godenot",
    LoadText = "VORTEX HUB",
    Flags = "VORTEX_HUB"
})

local minimizeBtn = Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://117383275808403", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(35, 1) },
})

-- Adicionar borda roxa no botão
if minimizeBtn and minimizeBtn.Button then
    local roxoStroke = Instance.new("UIStroke")
    roxoStroke.Thickness = 2
    roxoStroke.Color = Color3.fromRGB(155, 48, 255) -- Roxo
    roxoStroke.Parent = minimizeBtn.Button
end

local Tabstatus = Window:MakeTab({ Title = "STATUS", Icon = "rbxassetid://10723415903" })
local Tabchat = Window:MakeTab({ Title = "CHAT", Icon = "rbxassetid://7734056608" })
local Tabjogado = Window:MakeTab({"JOGADOR", "user"})
local Tabprici = Window:MakeTab({ "AVATA", "rbxassetid://10734952036" })
local Troll = Window:MakeTab({ Title = "TROLL", Icon = "rbxassetid://131153193945220" })
local protec = Window:MakeTab({ Title = "ANTI", Icon = "rbxassetid://11322093465" })
local Tabcasa = Window:MakeTab({"CASA", "home"})
local Tab = Window:MakeTab({"TELEPORT", "tp"})
local CarTab = Window:MakeTab({"VEÍCULO", "car"})
local Tabconfg = Window:MakeTab({ Title = "CONFIG", Icon = "settings" })
----------------------------------------------------------------

Tabstatus:AddSection({ Name = "STATUS" })

local HttpService = game:GetService("HttpService")

local startTime = tick()

local playTimeParagraph = Tabstatus:AddParagraph({"TEMPO JOGANDO", "0s"})

task.spawn(function()
    while true do
        task.wait(1)
        local elapsed = math.floor(tick() - startTime)
        local minutes = math.floor(elapsed / 60)
        local seconds = elapsed % 60
        local displayText = string.format("%02dmin %02ds", minutes, seconds)
        playTimeParagraph:SetDesc(displayText)
    end
end)

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

Tabstatus:AddParagraph({"JOGO", gameName})

Tabstatus:AddParagraph({"MAXIMO NO SERVIDOR", tostring(game.Players.MaxPlayers)})

local currentPlayersParagraph = Tabstatus:AddParagraph({"JOGADORES", tostring(#game.Players:GetPlayers())})

-- Atualiza quantidade de jogadores em tempo real
task.spawn(function()
    while true do
        task.wait(1)
        local playerCount = #game.Players:GetPlayers()
        currentPlayersParagraph:SetDesc(tostring(playerCount))
    end
end)

local UserInputService = game:GetService("UserInputService")

local function getDeviceType()
    local platform = UserInputService:GetPlatform()

    if platform == Enum.Platform.Windows then
        return "DISPOSITIVO : WINDOWS"
    elseif platform == Enum.Platform.OSX then
        return "DISPOSITIVO : MACBOOK"
    elseif platform == Enum.Platform.XBoxOne then
        return "DISPOSITIVO : XBOX"
    elseif platform == Enum.Platform.IOS or platform == Enum.Platform.Android then
        if UserInputService.KeyboardEnabled or UserInputService.MouseEnabled then
            return "DISPOSITIVO : TABLET"
        else
            return "DISPOSITIVO : CELULAR"
        end
    else
        return "DISPOSITIVO : DESCONHECIDO"
    end
end

Tabstatus:AddParagraph({"DISPOSITIVO", getDeviceType()})

local executor = identifyexecutor and identifyexecutor() or "Executor Desconhecido"
warn("Executor detectado: " .. executor)

Tabstatus:AddParagraph({"EXECUTOR", executor})

Tabstatus:AddSection({ Name = "CONFIG" })

Tabstatus:AddButton({
    Name = "RECONECTAR",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")

TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end,
})

Tabstatus:AddButton({
    Name = "IR PRA SERVER CHEIO",
    Callback = function()
        local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Players = game:GetService("Players")

local PlaceId = game.PlaceId
local Api = "https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Desc&limit=100"

local function FindServer()
    local cursor = nil
    repeat
        local url = Api .. (cursor and "&cursor="..cursor or "")
        local data = Http:JSONDecode(game:HttpGet(url))
        for _, server in pairs(data.data) do
            if server.playing < server.maxPlayers and server.playing >= 21 then
                return server.id
            end
        end
        cursor = data.nextPageCursor
    until not cursor
end

local serverId = FindServer()
if serverId then
    TPS:TeleportToPlaceInstance(PlaceId, serverId, Players.LocalPlayer)
else
    warn("AGUARDE ACHAR SERVIDOR CHEIO.")
end
    end,
})

Tabstatus:AddButton({
    Name = "MUDA DE SERVER",
    Callback = function()
        local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local _place = game.PlaceId
local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
function ListServers(cursor)
  local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
  return Http:JSONDecode(Raw)
end

local Server, Next; repeat
  local Servers = ListServers(Next)
  Server = Servers.data[1]
  Next = Servers.nextPageCursor
until Server

TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
    end,
})
----------------------------------------------------------------

Tabchat:AddSection({ Name = "PROTECAO" })

Tabchat:AddButton({
    Name = "EMOJI",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/LI6vQD8k/raw"))()
    end
})

Section = Tabchat:AddSection({
    Name = "CHAT"
})

local TextSave
local tcs = game:GetService("TextChatService")
local chat = tcs.ChatInputBarConfiguration and tcs.ChatInputBarConfiguration.TargetTextChannel

function sendchat(msg)
    if not msg or msg == "" then return end
    if tcs.ChatVersion == Enum.ChatVersion.LegacyChatService then
        local success, err = pcall(function()
            game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents").SayMessageRequest:FireServer(msg, "All")
        end)
        if not success then
            warn("Erro ao enviar chat: " .. err)
        end
    elseif chat then
        local success, err = pcall(function()
            chat:SendAsync(msg)
        end)
        if not success then
            warn("Erro ao enviar chat: " .. err)
        end
    end
end

Tabchat:AddTextBox({
    Name = "ESCREVA",
    PlaceholderText = "Digite a mensagem",
    Callback = function(text)
        TextSave = text
    end
})

Tabchat:AddButton({
    Name = "ENVIAR",
    Callback = function()
        sendchat(TextSave)
    end
})

getgenv().ChaosHubEnviarDelay = 1

Tabchat:AddSlider({
    Name = "DELAY  SPAM",
    Min = 0.4,
    Max = 10,
    Default = 1,
    Increment = 0.1,
    Callback = function(Value)
        getgenv().ChaosHubEnviarDelay = Value
    end
})

Tabchat:AddToggle({
    Name = "AUTO SPAM CHAT",
    Default = false,
    Flag = "Spawn de textos",
    Callback = function(Value)
        getgenv().ChaosHubSpawnText = Value
        while getgenv().ChaosHubSpawnText do
            sendchat(TextSave)
            task.wait(getgenv().ChaosHubEnviarDelay)
        end
    end
})

Tabchat:AddButton({
    Name = "SPAM Vortex HUB",
    Callback = function()
        if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then 
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("gt\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\rgtvz hub")
        else 
            print("Nadaa")
    end
end
})

Tabchat:AddButton({
    Name = "SPAM INDIANO",
    Callback = function()
        if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then 
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("gt\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\rE MUITO RATE XATI")
        else 
            print("Nadaa")
    end
end
})





local Section = Tabjogado:AddSection({
    Name = "JOGADOR"
})

Tabjogado:AddButton({
    Name = "FLY JOGADO",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/mRWia1NF"))()
    end
})

Tabjogado:AddButton({
    Name = "Free Cam Tool",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/8QQTsEMD"))()
    end
})

Tabjogado:AddButton({
    Name = "INVISÍVEL",
Callback = function()
        
        local args = {
    [1] = {
        [1] = 102344834840946,
        [2] = 70400527171038,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 0
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeCharacterBody"):InvokeServer(unpack(args))
game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Wear"):InvokeServer(111858803548721)
local allaccessories = {}

for zxcwefwfecas, xcaefwefas in ipairs({
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.BackAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.FaceAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.FrontAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.NeckAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.HatAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.HairAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.ShouldersAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.WaistAccessory,
    game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription.GraphicTShirt
}) do
    for scacvdfbdb in string.gmatch(xcaefwefas, "%d+") do
        table.insert(allaccessories, tonumber(scacvdfbdb))
    end
end

wait()

for asdwr,asderg in ipairs(allaccessories) do
    task.spawn(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Wear"):InvokeServer(asderg)
        print(asderg)
    end)
end
    end
})

local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local connection
local running = false

local function ativarNoclip()
    if running then return end
    running = true
    connection = RunService.Stepped:Connect(function()
        if not running then return end
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end)
end

local function desativarENukarScript()
    running = false
    if connection then
        connection:Disconnect()
        connection = nil
    end

    task.delay(0.1, function()
        script:Destroy()
    end)
end

Tabjogado:AddToggle({
    Name = "ATRAVESSAR PAREDE",
    Callback = function(value)
        if value then
            ativarNoclip()
        else
            desativarENukarScript()
        end
    end
})

local pl = game.Players.LocalPlayer

local function getHumanoid()
    if pl.Character and pl.Character:FindFirstChild("Humanoid") then
        return pl.Character.Humanoid
    else
        warn("Personagem ou Humanoid nÃ£o encontrado!")
        return nil
    end
end

Tabjogado:AddTextBox({
    Name = "VELOCIDADE JOGADOR",
    PlaceholderText = "DIGITE A VELOCIDADE",
    Callback = function(value)
        local speed = tonumber(value)
        local humanoid = getHumanoid()
        if speed and humanoid then
            humanoid.WalkSpeed = speed
        else
            warn("Velocidade invÃ¡lida!")
        end
    end
})

Tabjogado:AddButton({
    Name = "RESETAR VELOCIDADE",
    Callback = function()
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = 16
        end
    end
})

Tabjogado:AddTextBox({
    Name = "ALTURA DO PULO",
    PlaceholderText = "DIGITE ALTURA PULO",
    Callback = function(value)
        local jumpPower = tonumber(value)
        local humanoid = getHumanoid()
        if jumpPower and humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = jumpPower
        else
            warn("Altura de pulo invÃ¡lida!")
        end
    end
})

Tabjogado:AddButton({
    Name = "RESETAR PULO",
    Callback = function()
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = 50
        end
    end
})

Tabjogado:AddTextBox({
    Name = "GRAVIDADE",
    PlaceholderText = "DIGITE GRAVIDADE",
    Callback = function(value)
        local gravity = tonumber(value)
        if gravity then
            workspace.Gravity = gravity
        else
            warn("Gravidade invÃ¡lida!")
        end
    end
})

Tabjogado:AddButton({
    Name = "RESETAR GRAVIDADE",
    Callback = function()
        workspace.Gravity = 196.2
    end
})

Tabjogado:AddSection({ Name = "ESP JOGADOR" })


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local espRunning = false
local espConnection

local function updatePlayerESP()
    local localCharacter = LocalPlayer.Character
    if not localCharacter or not localCharacter:FindFirstChild("Head") then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local distance = (localCharacter.Head.Position - head.Position).Magnitude

            local billboardGui = head:FindFirstChild("TadachiisESPTags")
            if not billboardGui then
                billboardGui = Instance.new("BillboardGui")
                billboardGui.Name = "TadachiisESPTags"
                billboardGui.Adornee = head
                billboardGui.Size = UDim2.new(0, 100, 0, 50)
                billboardGui.StudsOffset = Vector3.new(0, 2, 0)
                billboardGui.AlwaysOnTop = true
                billboardGui.LightInfluence = 1
                billboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                billboardGui.Parent = head

                local textLabel = Instance.new("TextLabel")
                textLabel.Name = "NameLabel"
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                textLabel.TextStrokeTransparency = 0
                textLabel.TextScaled = true
                textLabel.Text = player.Name .. "\nDistance: " .. math.floor(distance)
                textLabel.Parent = billboardGui
            else
                local label = billboardGui:FindFirstChild("NameLabel")
                if label then
                    label.Text = player.Name .. "\nDistance: " .. math.floor(distance)
                end
            end
        end
    end
end

local function enableESP()
    if not espRunning then
        espConnection = RunService.Heartbeat:Connect(updatePlayerESP)
        espRunning = true
        print("ESP ativado.")
    end
end

local function disableESP()
    if espConnection then
        espConnection:Disconnect()
        espConnection = nil
    end
    espRunning = false

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Head") then
            local tag = player.Character.Head:FindFirstChild("TadachiisESPTags")
            if tag then
                tag:Destroy()
            end
        end
    end

    print("ESP desativado.")
end

-- Toggle no Tabjogado
Tabjogado:AddToggle({
    Name = "ESP NOME DISTANCIA",
    Default = false,
    Callback = function(state)
        if state then
            enableESP()
        else
            disableESP()
        end
    end
})





local FillColor = Color3.fromRGB(0,255,0)
local DepthMode = "AlwaysOnTop"
local FillTransparency = 0.5
local OutlineColor = Color3.fromRGB(0,0,0)
local OutlineTransparency = 0

local CoreGui = game:FindService("CoreGui")
local Players = game:FindService("Players")
local lp = Players.LocalPlayer
local connections = {}
local Storage = nil

local function EnableESP()
    if Storage then return end -- jÃ¡ ativado

    Storage = Instance.new("Folder")
    Storage.Parent = CoreGui
    Storage.Name = "Highlight_Storage"

    local function Highlight(plr)
        if plr == lp then return end -- ignora o prÃ³prio jogador

        local highlight = Instance.new("Highlight")
        highlight.Name = plr.Name
        highlight.FillColor = FillColor
        highlight.DepthMode = Enum.HighlightDepthMode[DepthMode]
        highlight.FillTransparency = FillTransparency
        highlight.OutlineColor = OutlineColor
        highlight.OutlineTransparency = OutlineTransparency
        highlight.Parent = Storage

        local plrchar = plr.Character
        if plrchar then
            highlight.Adornee = plrchar
        end

        connections[plr] = plr.CharacterAdded:Connect(function(char)
            highlight.Adornee = char
        end)
    end

    connections["_PlayerAdded"] = Players.PlayerAdded:Connect(Highlight)

    for _, v in pairs(Players:GetPlayers()) do
        Highlight(v)
    end

    print("ESP Highlight ativado.")
end

local function DisableESP()
    if Storage then
        Storage:Destroy()
        Storage = nil
    end

    for _, conn in pairs(connections) do
        if conn and conn.Disconnect then
            conn:Disconnect()
        end
    end
    connections = {}

    print("ESP Highlight desativado.")
end

-- Toggle no Tabjogado
Tabjogado:AddToggle({
    Name = "ESP HOLOGRAMA",
    Default = false,
    Callback = function(state)
        if state then
            EnableESP()
        else
            DisableESP()
        end
    end
})

Tabjogado:AddButton({
    Name = "SCRIPT ESP",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/XaaRXmoj/raw"))()
    end
})
-------------------------PRICIPAL---------------------------------------

Tabprici:AddSection({ Name = "PRINCIPAL" })

Tabprici:AddToggle({
    Name = "NOME RGB",
    Default = false,
    Callback = function(value)
        if value then
            startRGBLoop()
        else
            stopRGBLoop()
        end
    end
})

-- ServiÃ§os
local Players = game:GetService("Players")
local RE = game:GetService("ReplicatedStorage"):WaitForChild("RE")
local remote = RE:FindFirstChild("1RPNam1eColo1r")

-- FunÃ§Ã£o para interpolar entre duas cores
local function lerpColor(c1, c2, t)
	return Color3.new(
		c1.R + (c2.R - c1.R) * t,
		c1.G + (c2.G - c1.G) * t,
		c1.B + (c2.B - c1.B) * t
	)
end

-- Paleta RGB + cores gama
local colorList = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(255, 102, 0),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 255, 255),
	Color3.fromRGB(0, 102, 255),
	Color3.fromRGB(153, 0, 255),
	Color3.fromRGB(255, 0, 255),
	Color3.fromRGB(255, 105, 180),
	Color3.fromRGB(255, 215, 0),
	Color3.fromRGB(0, 255, 127),
	Color3.fromRGB(135, 206, 250),
	Color3.fromRGB(255, 51, 153),
	Color3.fromRGB(102, 255, 178),
	Color3.fromRGB(204, 153, 255)
}

-- Controle do loop RGB
local loopRunning = false
local rgbThread = nil

-- InÃ­cio da animaÃ§Ã£o RGB com transiÃ§Ã£o suave
function startRGBLoop()
	if loopRunning then return end
	loopRunning = true
	rgbThread = task.spawn(function()
		while loopRunning do
			for i = 1, #colorList do
				local c1 = colorList[i]
				local c2 = colorList[i % #colorList + 1]
				for t = 0, 1, 0.02 do
					if not loopRunning then return end
					if remote then
						remote:FireServer("PickingRPNameColor", lerpColor(c1, c2, t))
					end
					task.wait(0.02)
				end
			end
		end
	end)
end

-- Parar animaÃ§Ã£o RGB
function stopRGBLoop()
	loopRunning = false
end


Tabprici:AddToggle({
    Name = "CORPO RGB",
    Default = false,
    Callback = function(value)
        if value then
            startRGBCharacter()
        else
            stopRGBCharacter()
        end
    end
})

-- Lista de cores RGB para o corpo
local bodyColors = {
    "Bright red",
    "Lime green",
    "Bright blue",
    "Bright yellow",
    "Bright cyan",
    "Hot pink",
    "Royal purple"
}

local bodyLoopRunning = false
local rgbBodyThread = nil

local function changeBodyColor(color)
    local args = { color }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeBodyColor"):FireServer(unpack(args))
end

function startRGBCharacter()
    if bodyLoopRunning then return end
    bodyLoopRunning = true
    rgbBodyThread = task.spawn(function()
        while bodyLoopRunning do
            for _, color in ipairs(bodyColors) do
                if not bodyLoopRunning then return end
                changeBodyColor(color)
                task.wait(0.5)
            end
        end
    end)
end

function stopRGBCharacter()
    bodyLoopRunning = false
end


local hairColors = {
    Color3.new(1, 1, 0), Color3.new(0, 0, 1), Color3.new(1, 0, 1), Color3.new(1, 1, 1),
    Color3.new(0, 1, 0), Color3.new(0.5, 0, 1), Color3.new(1, 0.647, 0), Color3.new(0, 1, 1)
}
local isActive = false


local function changeHairColor()
    local i = 1
    while isActive do
        if not isActive then break end
        local args = { [1] = "ChangeHairColor2", [2] = hairColors[i] }
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Max1y"):FireServer(unpack(args))
        wait(0.1)
        i = i % #hairColors + 1
    end
end


Tabprici:AddToggle({
    Name = "CABELO RGB",
    Default = false,
    Callback = function(value)
        isActive = value
        if isActive then
            changeHairColor()
        end
    end
})


local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local Target = nil

local function GetPlayerNames()
    local PlayerNames = {}
    for _, player in ipairs(Players:GetPlayers()) do
        table.insert(PlayerNames, player.Name)
    end
    return PlayerNames
end

local Dropdown = Tabprici:AddDropdown({
    Name = "SELECIONAR JOGADOR",
    Options = GetPlayerNames(),
    Default = Target,
    Callback = function(Value)
        Target = Value
    end
})

-- // Atualizar Dropdown dinamicamente
local function UpdateDropdown()
    local lista = GetPlayerNames()

    if Dropdown.Set then
        Dropdown:Set(lista)
    elseif Dropdown.Refresh then
        Dropdown:Refresh(lista, true)
    end
end

Tabprici:AddButton({
    Name = "ATUALIZAR A LISTA",
    Callback = function()
        UpdateDropdown()
    end
})

-- // BotÃ£o: Copiar Avatar
Tabprici:AddButton({
    Name = "COPIAR AVATAR",
    Callback = function()
        if not Target then return end

        local LP = Players.LocalPlayer
        local LChar = LP.Character
        local TPlayer = Players:FindFirstChild(Target)

        if not (TPlayer and TPlayer.Character) then return end

        local LHumanoid = LChar and LChar:FindFirstChildOfClass("Humanoid")
        local THumanoid = TPlayer.Character:FindFirstChildOfClass("Humanoid")

        if not (LHumanoid and THumanoid) then return end

        
        local LDesc = LHumanoid:GetAppliedDescription()

        for _, acc in ipairs(LDesc:GetAccessories(true)) do
            if acc.AssetId and tonumber(acc.AssetId) then
                Remotes.Wear:InvokeServer(tonumber(acc.AssetId))
                task.wait(0.2)
            end
        end

        if tonumber(LDesc.Shirt) then
            Remotes.Wear:InvokeServer(tonumber(LDesc.Shirt))
            task.wait(0.2)
        end

        if tonumber(LDesc.Pants) then
            Remotes.Wear:InvokeServer(tonumber(LDesc.Pants))
            task.wait(0.2)
        end

        if tonumber(LDesc.Face) then
            Remotes.Wear:InvokeServer(tonumber(LDesc.Face))
            task.wait(0.2)
        end

        -- // Copiar do jogador selecionado
        local PDesc = THumanoid:GetAppliedDescription()

        -- Trocar corpo
        local argsBody = {
            [1] = {
                [1] = PDesc.Torso,
                [2] = PDesc.RightArm,
                [3] = PDesc.LeftArm,
                [4] = PDesc.RightLeg,
                [5] = PDesc.LeftLeg,
                [6] = PDesc.Head
            }
        }
        Remotes.ChangeCharacterBody:InvokeServer(unpack(argsBody))
        task.wait(0.5)

        -- Aplicar roupas e face
        if tonumber(PDesc.Shirt) then
            Remotes.Wear:InvokeServer(tonumber(PDesc.Shirt))
            task.wait(0.3)
        end

        if tonumber(PDesc.Pants) then
            Remotes.Wear:InvokeServer(tonumber(PDesc.Pants))
            task.wait(0.3)
        end

        if tonumber(PDesc.Face) then
            Remotes.Wear:InvokeServer(tonumber(PDesc.Face))
            task.wait(0.3)
        end

        -- Aplicar acessÃ³rios
        for _, acc in ipairs(PDesc:GetAccessories(true)) do
            if acc.AssetId and tonumber(acc.AssetId) then
                Remotes.Wear:InvokeServer(tonumber(acc.AssetId))
                task.wait(0.3)
            end
        end

        -- Copiar cor de pele
        local SkinColor = TPlayer.Character:FindFirstChild("Body Colors")
        if SkinColor then
            Remotes.ChangeBodyColor:FireServer(tostring(SkinColor.HeadColor))
            task.wait(0.3)
        end

        -- Copiar animaÃ§Ã£o (Idle)
        if tonumber(PDesc.IdleAnimation) then
            Remotes.Wear:InvokeServer(tonumber(PDesc.IdleAnimation))
            task.wait(0.3)
        end
    end
})





-----------------------ðŸ’€TROLLðŸ’€---------------------------------------




local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local cam = workspace.CurrentCamera


local selectedPlayerName = nil
local methodKill = nil
getgenv().Target = nil
local Character = LocalPlayer.Character
local Humanoid = Character and Character:WaitForChild("Humanoid")
local RootPart = Character and Character:WaitForChild("HumanoidRootPart")

-- FunÃ§Ã£o para limpar o sofÃ¡ (couch)
local function cleanupCouch()
    local char = LocalPlayer.Character
    if char then
        local couch = char:FindFirstChild("Chaos.Couch") or LocalPlayer.Backpack:FindFirstChild("Chaos.Couch")
        if couch then
            couch:Destroy()
        end
    end
    -- Limpar ferramentas via remoto
    ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
end

-- Conectar evento CharacterAdded
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = newCharacter:WaitForChild("Humanoid")
    RootPart = newCharacter:WaitForChild("HumanoidRootPart")
    cleanupCouch()
    
    -- Conectar evento Died para o novo Humanoid
    Humanoid.Died:Connect(function()
        cleanupCouch()
    end)
end)

-- Conectar evento Died para o Humanoid inicial, se existir
if Humanoid then
    Humanoid.Died:Connect(function()
        cleanupCouch()
    end)
end

-- FunÃ§Ã£o KillPlayerCouch
local function KillPlayerCouch()
    if not selectedPlayerName then
        warn("Erro: Nenhum jogador selecionado")
        return
    end
    local target = Players:FindFirstChild(selectedPlayerName)
    if not target or not target.Character then
        warn("Erro: Jogador alvo nÃ£o encontrado ou sem personagem")
        return
    end

    local char = LocalPlayer.Character
    if not char then
        warn("Erro: Personagem do jogador local nÃ£o encontrado")
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not hum or not root or not tRoot then
        warn("Erro: Componentes necessÃ¡rios nÃ£o encontrados")
        return
    end

    local originalPos = root.Position 
    local sitPos = Vector3.new(145.51, -350.09, 21.58)

    ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
    task.wait(0.2)

    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    task.wait(0.3)

    local tool = LocalPlayer.Backpack:FindFirstChild("Couch")
    if tool then tool.Parent = char end
    task.wait(0.1)

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    task.wait(0.1)

    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    hum.PlatformStand = false
    cam.CameraSubject = target.Character:FindFirstChild("Head") or tRoot or hum

    local align = Instance.new("BodyPosition")
    align.Name = "BringPosition"
    align.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    align.D = 10
    align.P = 30000
    align.Position = root.Position
    align.Parent = tRoot

    task.spawn(function()
        local angle = 0
        local startTime = tick()
        while tick() - startTime < 5 and target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") do
            local tHum = target.Character:FindFirstChildOfClass("Humanoid")
            if not tHum or tHum.Sit then break end

            local hrp = target.Character.HumanoidRootPart
            local adjustedPos = hrp.Position + (hrp.Velocity / 1.5)

            angle += 50
            root.CFrame = CFrame.new(adjustedPos + Vector3.new(0, 2, 0)) * CFrame.Angles(math.rad(angle), 0, 0)
            align.Position = root.Position + Vector3.new(2, 0, 0)

            task.wait()
        end

        align:Destroy()
        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        hum.PlatformStand = false
        cam.CameraSubject = hum

        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Velocity = Vector3.zero
                p.RotVelocity = Vector3.zero
            end
        end

        task.wait(0.1)
        root.CFrame = CFrame.new(sitPos)
        task.wait(0.3)

        local tool = char:FindFirstChild("Couch")
        if tool then tool.Parent = LocalPlayer.Backpack end

        task.wait(0.01)
        ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
        task.wait(0.2)
        root.CFrame = CFrame.new(originalPos)
    end)
end

-- FunÃ§Ã£o BringPlayerLLL
local function BringPlayerLLL()
    if not selectedPlayerName then
        warn("Erro: Nenhum jogador selecionado")
        return
    end
    local target = Players:FindFirstChild(selectedPlayerName)
    if not target or not target.Character then
        warn("Erro: Jogador alvo nÃ£o encontrado ou sem personagem")
        return
    end

    local char = LocalPlayer.Character
    if not char then
        warn("Erro: Personagem do jogador local nÃ£o encontrado")
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    if not hum or not root or not tRoot then
        warn("Erro: Componentes necessÃ¡rios nÃ£o encontrados")
        return
    end

    local originalPos = root.Position 
    ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
    task.wait(0.2)

    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    task.wait(0.3)

    local tool = LocalPlayer.Backpack:FindFirstChild("Couch")
    if tool then
        tool.Parent = char
    end
    task.wait(0.1)

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    task.wait(0.1)

    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    hum.PlatformStand = false
    cam.CameraSubject = target.Character:FindFirstChild("Head") or tRoot or hum

    local align = Instance.new("BodyPosition")
    align.Name = "BringPosition"
    align.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    align.D = 10
    align.P = 30000
    align.Position = root.Position
    align.Parent = tRoot

    task.spawn(function()
        local angle = 0
        local startTime = tick()
        while tick() - startTime < 5 and target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") do
            local tHum = target.Character:FindFirstChildOfClass("Humanoid")
            if not tHum or tHum.Sit then break end

            local hrp = target.Character.HumanoidRootPart
            local adjustedPos = hrp.Position + (hrp.Velocity / 1.5)

            angle += 50
            root.CFrame = CFrame.new(adjustedPos + Vector3.new(0, 2, 0)) * CFrame.Angles(math.rad(angle), 0, 0)
            align.Position = root.Position + Vector3.new(2, 0, 0)

            task.wait()
        end

        align:Destroy()
        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        hum.PlatformStand = false
        cam.CameraSubject = hum

        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Velocity = Vector3.zero
                p.RotVelocity = Vector3.zero
            end
        end

        task.wait(0.1)
        root.Anchored = true
        root.CFrame = CFrame.new(originalPos)
        task.wait(0.001)
        root.Anchored = false

        task.wait(0.7)
        local tool = char:FindFirstChild("Couch")
        if tool then
            tool.Parent = LocalPlayer.Backpack
        end

        task.wait(0.001)
        ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    end)
end

-- FunÃ§Ã£o BringWithCouch
local function BringWithCouch()
    local targetPlayer = Players:FindFirstChild(getgenv().Target)
    if not targetPlayer then
        warn("Erro: Nenhum jogador alvo selecionado")
        return
    end
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        warn("Erro: Jogador alvo sem personagem ou HumanoidRootPart")
        return
    end

    local args = { [1] = "ClearAllTools" }
    ReplicatedStorage.RE["1Clea1rTool1s"]:FireServer(unpack(args))
    local args = { [1] = "PickingTools", [2] = "Couch" }
    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))

    local couch = LocalPlayer.Backpack:WaitForChild("Couch", 2)
    if not couch then
        warn("Erro: SofÃ¡ nÃ£o encontrado no Backpack")
        return
    end

    couch.Name = "Chaos.Couch"
    local seat1 = couch:FindFirstChild("Seat1")
    local seat2 = couch:FindFirstChild("Seat2")
    local handle = couch:FindFirstChild("Handle")
    if seat1 and seat2 and handle then
        seat1.Disabled = true
        seat2.Disabled = true
        handle.Name = "Handle "
    else
        warn("Erro: Componentes do sofÃ¡ nÃ£o encontrados")
        return
    end
    couch.Parent = LocalPlayer.Character

    local tet = Instance.new("BodyVelocity", seat1)
    tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    tet.P = 1250
    tet.Velocity = Vector3.new(0, 0, 0)
    tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"

    repeat
        for m = 1, 35 do
            local pos = { x = 0, y = 0, z = 0 }
            local tRoot = targetPlayer.Character and targetPlayer.Character.HumanoidRootPart
            if not tRoot then break end
            pos.x = tRoot.Position.X + (tRoot.Velocity.X / 2)
            pos.y = tRoot.Position.Y + (tRoot.Velocity.Y / 2)
            pos.z = tRoot.Position.Z + (tRoot.Velocity.Z / 2)
            seat1.CFrame = CFrame.new(Vector3.new(pos.x, pos.y, pos.z)) * CFrame.new(-2, 2, 0)
            task.wait()
        end
        tet:Destroy()
        couch.Parent = LocalPlayer.Backpack
        task.wait()
        couch:FindFirstChild("Handle ").Name = "Handle"
        task.wait(0.2)
        couch.Parent = LocalPlayer.Character
        task.wait()
        couch.Parent = LocalPlayer.Backpack
        couch.Handle.Name = "Handle "
        task.wait(0.2)
        couch.Parent = LocalPlayer.Character
        tet = Instance.new("BodyVelocity", seat1)
        tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        tet.P = 1250
        tet.Velocity = Vector3.new(0, 0, 0)
        tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
    until targetPlayer.Character and targetPlayer.Character.Humanoid and targetPlayer.Character.Humanoid.Sit == true
    task.wait()
    tet:Destroy()
    couch.Parent = LocalPlayer.Backpack
    task.wait()
    couch:FindFirstChild("Handle ").Name = "Handle"
    task.wait(0.3)
    couch.Parent = LocalPlayer.Character
    task.wait(0.3)
    couch.Grip = CFrame.new(Vector3.new(0, 0, 0))
    task.wait(0.3)
    ReplicatedStorage.RE["1Clea1rTool1s"]:FireServer("ClearAllTools")
end

-- FunÃ§Ã£o KillWithCouch
local function KillWithCouch()
    local targetPlayer = Players:FindFirstChild(getgenv().Target)
    if not targetPlayer then
        warn("Erro: Nenhum jogador alvo selecionado")
        return
    end
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        warn("Erro: Jogador alvo sem personagem ou HumanoidRootPart")
        return
    end

    local args = { [1] = "ClearAllTools" }
    ReplicatedStorage.RE["1Clea1rTool1s"]:FireServer(unpack(args))
    local args = { [1] = "PickingTools", [2] = "Couch" }
    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))

    local couch = LocalPlayer.Backpack:WaitForChild("Couch", 2)
    if not couch then
        warn("Erro: SofÃ¡ nÃ£o encontrado no Backpack")
        return
    end

    couch.Name = "Chaos.Couch"
    local seat1 = couch:FindFirstChild("Seat1")
    local seat2 = couch:FindFirstChild("Seat2")
    local handle = couch:FindFirstChild("Handle")
    if seat1 and seat2 and handle then
        seat1.Disabled = true
        seat2.Disabled = true
        handle.Name = "Handle "
    else
        warn("Erro: Componentes do sofÃ¡ nÃ£o encontrados")
        return
    end
    couch.Parent = LocalPlayer.Character

    local tet = Instance.new("BodyVelocity", seat1)
    tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    tet.P = 1250
    tet.Velocity = Vector3.new(0, 0, 0)
    tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"

    repeat
        for m = 1, 35 do
            local pos = { x = 0, y = 0, z = 0 }
            local tRoot = targetPlayer.Character and targetPlayer.Character.HumanoidRootPart
            if not tRoot then break end
            pos.x = tRoot.Position.X + (tRoot.Velocity.X / 2)
            pos.y = tRoot.Position.Y + (tRoot.Velocity.Y / 2)
            pos.z = tRoot.Position.Z + (tRoot.Velocity.Z / 2)
            seat1.CFrame = CFrame.new(Vector3.new(pos.x, pos.y, pos.z)) * CFrame.new(-2, 2, 0)
            task.wait()
        end
        tet:Destroy()
        couch.Parent = LocalPlayer.Backpack
        task.wait()
        couch:FindFirstChild("Handle ").Name = "Handle"
        task.wait(0.2)
        couch.Parent = LocalPlayer.Character
        task.wait()
        couch.Parent = LocalPlayer.Backpack
        couch.Handle.Name = "Handle "
        task.wait(0.2)
        couch.Parent = LocalPlayer.Character
        tet = Instance.new("BodyVelocity", seat1)
        tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        tet.P = 1250
        tet.Velocity = Vector3.new(0, 0, 0)
        tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
    until targetPlayer.Character and targetPlayer.Character.Humanoid and targetPlayer.Character.Humanoid.Sit == true
    task.wait()
    couch.Parent = LocalPlayer.Backpack
    seat1.CFrame = CFrame.new(Vector3.new(9999, -450, 9999))
    seat2.CFrame = CFrame.new(Vector3.new(9999, -450, 9999))
    couch.Parent = LocalPlayer.Character
    task.wait(0.1)
    couch.Parent = LocalPlayer.Backpack
    task.wait(2)
    local bv = seat1:FindFirstChild("#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W")
    if bv then bv:Destroy() end
    ReplicatedStorage.RE["1Clea1rTool1s"]:FireServer("ClearAllTools")
end

    local PlayerSection = Troll:AddSection({ Name = "Troll Player" })

    -- FunÃ§Ã£o para obter lista de jogadores
    local function getPlayerList()
        local players = Players:GetPlayers()
        local playerNames = {}
        for _, player in ipairs(players) do
            if player ~= LocalPlayer then
                table.insert(playerNames, player.Name)
            end
        end
        return playerNames
    end

    local killDropdown = Troll:AddDropdown({
        Name = "SELECIONAR JOGADOR",
        Options = getPlayerList(),
        Default = "",
        Callback = function(value)
            selectedPlayerName = value
            getgenv().Target = value
            print("Jogador selecionado: " .. tostring(value))
        end
    })

    Troll:AddButton({
        Name = "ATUALIZAR LISTA",
        Callback = function()
            local tablePlayers = Players:GetPlayers()
            local newPlayers = {}
            if killDropdown and #tablePlayers > 0 then
                for _, player in ipairs(tablePlayers) do
                    if player.Name ~= LocalPlayer.Name then
                        table.insert(newPlayers, player.Name)
                    end
                end
                killDropdown:Set(newPlayers)
                print("Lista de jogadores atualizada: ", table.concat(newPlayers, ", "))
                if selectedPlayerName and not Players:FindFirstChild(selectedPlayerName) then
                    selectedPlayerName = nil
                    getgenv().Target = nil
                    killDropdown:SetValue("")
                    print("SeleÃ§Ã£o resetada, jogador nÃ£o estÃ¡ mais no servidor.")
                end
            else
                print("Erro: Dropdown nÃ£o encontrado ou nenhum jogador disponÃ­vel.")
            end
        end
    })

    Troll:AddButton({
        Name = "TP JOGADOR",
        Callback = function()
            if not selectedPlayerName or not Players:FindFirstChild(selectedPlayerName) then
                print("Erro: Player nÃ£o selecionado ou nÃ£o existe")
                return
            end
            local character = LocalPlayer.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then
                warn("Erro: HumanoidRootPart do jogador local nÃ£o encontrado")
                return
            end

            local targetPlayer = Players:FindFirstChild(selectedPlayerName)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                humanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            else
                print("Erro: Player alvo nÃ£o encontrado ou sem HumanoidRootPart")
            end
        end
    })

    Troll:AddToggle({
        Name = "OLHA JOGADOR",
        Default = false,
        Callback = function(value)
            local Camera = workspace.CurrentCamera

            local function UpdateCamera()
                if value then
                    local targetPlayer = Players:FindFirstChild(selectedPlayerName)
                    if targetPlayer and targetPlayer.Character then
                        local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            Camera.CameraSubject = humanoid
                        end
                    end
                else
                    if LocalPlayer.Character then
                        local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            Camera.CameraSubject = humanoid
                        end
                    end
                end
            end

            if value then
                if not getgenv().CameraConnection then
                    getgenv().CameraConnection = RunService.Heartbeat:Connect(UpdateCamera)
                end
            else
                if getgenv().CameraConnection then
                    getgenv().CameraConnection:Disconnect()
                    getgenv().CameraConnection = nil
                end
                UpdateCamera()
            end
        end
    })

    local MethodSection = Troll:AddSection({ Name = "MATATODOS" })

    Troll:AddDropdown({
        Name = "SELECIONAR METADO",
        Options = {"ONIBUS", "SOFA", "SOFA V2"},
        Default = "",
        Callback = function(value)
            methodKill = value
            print("MATATODOS selecionado: " .. tostring(value))
        end
    })

    Troll:AddButton({
        Name = "ELIMINAR JOGADOR",
        Callback = function()
            if not selectedPlayerName or not Players:FindFirstChild(selectedPlayerName) then
                print("Erro: Player nÃ£o selecionado ou nÃ£o existe")
                return
            end
            if methodKill == "SOFA" then
                KillPlayerCouch()
            elseif methodKill == "SOFA V2" then
                KillWithCouch()
            else
                -- MÃ©todo de Ã´nibus
                local character = LocalPlayer.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                if not humanoidRootPart then
                    warn("Erro: HumanoidRootPart do jogador local nÃ£o encontrado")
                    return
                end

                local originalPosition = humanoidRootPart.CFrame

                local function GetBus()
                    local vehicles = game.Workspace:FindFirstChild("Vehicles")
                    if vehicles then
                        return vehicles:FindFirstChild(LocalPlayer.Name .. "Car")
                    end
                    return nil
                end

                local bus = GetBus()

                if not bus then
                    humanoidRootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                    task.wait(0.5)
                    local remoteEvent = ReplicatedStorage:FindFirstChild("RE")
                    if remoteEvent and remoteEvent:FindFirstChild("1Ca1r") then
                        remoteEvent["1Ca1r"]:FireServer("PickingCar", "SchoolBus")
                    end
                    task.wait(1)
                    bus = GetBus()
                end

                if bus then
                    local seat = bus:FindFirstChild("Body") and bus.Body:FindFirstChild("VehicleSeat")
                    if seat and character:FindFirstChildOfClass("Humanoid") and not character.Humanoid.Sit then
                        repeat
                            humanoidRootPart.CFrame = seat.CFrame * CFrame.new(0, 2, 0)
                            task.wait()
                        until character.Humanoid.Sit or not bus.Parent
                        if character.Humanoid.Sit or not bus.Parent then
                            for k, v in pairs(bus.Body:GetChildren()) do
                                if v:IsA("Seat") then
                                    v.CanTouch = false
                                end
                            end
                        end
                    end
                end

                local function TrackPlayer()
                    while true do
                        if selectedPlayerName then
                            local targetPlayer = Players:FindFirstChild(selectedPlayerName)
                            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                                if targetHumanoid and targetHumanoid.Sit then
                                    if character.Humanoid then
                                        bus:SetPrimaryPartCFrame(CFrame.new(Vector3.new(9999, -450, 9999)))
                                        print("Jogador sentou, levando Ã´nibus para o void!")
                                        task.wait(0.2)

                                        local function simulateJump()
                                            local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
                                            if humanoid then
                                                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                            end
                                        end

                                        simulateJump()
                                        print("Simulando pulo!")
                                        task.wait(0.5)
                                        humanoidRootPart.CFrame = originalPosition
                                        print("Player voltou para a posiÃ§Ã£o inicial.")
                                    end
                                    break
                                else
                                    local targetRoot = targetPlayer.Character.HumanoidRootPart
                                    local time = tick() * 35
                                    local lateralOffset = math.sin(time) * 4
                                    local frontBackOffset = math.cos(time) * 20
                                    bus:SetPrimaryPartCFrame(targetRoot.CFrame * CFrame.new(lateralOffset, 0, frontBackOffset))
                                end
                            end
                        end
                        RunService.RenderStepped:Wait()
                    end
                end

                spawn(TrackPlayer)
            end
        end
    })

    Troll:AddButton({
        Name = "PUXAR JOGADOR",
        Callback = function()
            if not selectedPlayerName or not Players:FindFirstChild(selectedPlayerName) then
                print("Erro: Player nÃ£o selecionado ou nÃ£o existe")
                return
            end
            if methodKill == "SOFA" then
                BringPlayerLLL()
            elseif methodKill == "SOFA V2" then
                BringWithCouch()
            else
                -- MÃ©todo de Ã´nibus
                local character = LocalPlayer.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                if not humanoidRootPart then
                    warn("Erro: HumanoidRootPart do jogador local nÃ£o encontrado")
                    return
                end

                local originalPosition = humanoidRootPart.CFrame

                local function GetBus()
                    local vehicles = game.Workspace:FindFirstChild("Vehicles")
                    if vehicles then
                        return vehicles:FindFirstChild(LocalPlayer.Name .. "Car")
                    end
                    return nil
                end

                local bus = GetBus()

                if not bus then
                    humanoidRootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                    task.wait(0.5)
                    local remoteEvent = ReplicatedStorage:FindFirstChild("RE")
                    if remoteEvent and remoteEvent:FindFirstChild("1Ca1r") then
                        remoteEvent["1Ca1r"]:FireServer("PickingCar", "SchoolBus")
                    end
                    task.wait(1)
                    bus = GetBus()
                end

                if bus then
                    local seat = bus:FindFirstChild("Body") and bus.Body:FindFirstChild("VehicleSeat")
                    if seat and character:FindFirstChildOfClass("Humanoid") and not character.Humanoid.Sit then
                        repeat
                            humanoidRootPart.CFrame = seat.CFrame * CFrame.new(0, 2, 0)
                            task.wait()
                        until character.Humanoid.Sit or not bus.Parent
                    end
                end

                local function TrackPlayer()
                    while true do
                        if selectedPlayerName then
                            local targetPlayer = Players:FindFirstChild(selectedPlayerName)
                            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                                if targetHumanoid and targetHumanoid.Sit then
                                    if character.Humanoid then
                                        bus:SetPrimaryPartCFrame(originalPosition)
                                        task.wait(0.7)
                                        local args = { [1] = "DeleteAllVehicles" }
                                        ReplicatedStorage.RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
                                    end
                                    break
                                else
                                    local targetRoot = targetPlayer.Character.HumanoidRootPart
                                    local time = tick() * 35
                                    local lateralOffset = math.sin(time) * 4
                                    local frontBackOffset = math.cos(time) * 20
                                    bus:SetPrimaryPartCFrame(targetRoot.CFrame * CFrame.new(lateralOffset, 0, frontBackOffset))
                                end
                            end
                        end
                        RunService.RenderStepped:Wait()
                    end
                end

                spawn(TrackPlayer)
            end
        end
    })


local function houseBanKill()
    if not selectedPlayerName then
        print("Nenhum jogador selecionado!")
        return
    end

    local Player = game.Players.LocalPlayer
    local Backpack = Player.Backpack
    local Character = Player.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    local Houses = game.Workspace:FindFirstChild("001_Lots")
    local OldPos = RootPart.CFrame
    local Angles = 0
    local Vehicles = Workspace.Vehicles
    local Pos

    function Check()
        if Player and Character and Humanoid and RootPart and Vehicles then
            return true
        else
            return false
        end
    end

    local selectedPlayer = game.Players:FindFirstChild(selectedPlayerName)
    if selectedPlayer and selectedPlayer.Character then
        if Check() then
            local House = Houses:FindFirstChild(Player.Name .. "House")
            if not House then
                local EHouse
                local availableHouses = {}
                
                -- Coletar todas as casas disponÃƒÂ­veis ("For Sale")
                for _, Lot in pairs(Houses:GetChildren()) do
                    if Lot.Name == "For Sale" then
                        for _, num in pairs(Lot:GetDescendants()) do
                            if num:IsA("NumberValue") and num.Name == "Number" and num.Value < 25 and num.Value > 10 then
                                table.insert(availableHouses, {Lot = Lot, Number = num.Value})
                                break
                            end
                        end
                    end
                end

                -- Escolher uma casa aleatÃƒÂ³ria da lista
                if #availableHouses > 0 then
                    local randomHouse = availableHouses[math.random(1, #availableHouses)]
                    EHouse = randomHouse.Lot
                    local houseNumber = randomHouse.Number

                    -- Teleportar para o BuyDetector e clicar
                    local BuyDetector = EHouse:FindFirstChild("BuyHouse")
                    Pos = BuyDetector.Position
                    if BuyDetector and BuyDetector:IsA("BasePart") then
                        RootPart.CFrame = BuyDetector.CFrame + Vector3.new(0, -6, 0)
                        task.wait(0.5)
                        local ClickDetector = BuyDetector:FindFirstChild("ClickDetector")
                        if ClickDetector then
                            fireclickdetector(ClickDetector)
                        end
                    end

                    -- Disparar o novo remote event para construir a casa
                    task.wait(0.5)
                    local args = {
                        houseNumber, -- NÃƒÂºmero da casa aleatÃƒÂ³ria
                        "056_House" -- Tipo da casa
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Lot:BuildProperty"):FireServer(unpack(args))
                else
                    print("Nenhuma casa disponÃƒÂ­vel para compra!")
                    return
                end
            end

            task.wait(0.5)
            local PreHouse = Houses:FindFirstChild(Player.Name .. "House")
            if PreHouse then
                task.wait(0.5)
                local Number
                for i, x in pairs(PreHouse:GetDescendants()) do
                    if x.Name == "Number" and x:IsA("NumberValue") then
                        Number = x
                    end
                end
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gettin1gHous1e"):FireServer("PickingCustomHouse", "049_House", Number.Value)
            end

            task.wait(0.5)
            local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            if not PCar then
                if Check() then
                    RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                    task.wait(0.5)
                    local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
                    task.wait(0.5)
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                    if Seat then
                        repeat
                            task.wait()
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                        until Humanoid.Sit
                    end
                end
            end

            task.wait(0.5)
            local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            if PCar then
                if not Humanoid.Sit then
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                    if Seat then
                        repeat
                            task.wait()
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                        until Humanoid.Sit
                    end
                end

                local Target = selectedPlayer
                local TargetC = Target.Character
                local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
                if TargetC and TargetH and TargetRP then
                    if not TargetH.Sit then
                        while not TargetH.Sit do
                            task.wait()
                            local Fling = function(alvo, pos, angulo)
                                PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                            end
                            Angles = Angles + 100
                            Fling(TargetRP, CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP, CFrame.new(2.25, 1.5, -2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP, CFrame.new(-2.25, -1.5, 2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP, CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                        end
                        task.wait(0.2)
                        local House = Houses:FindFirstChild(Player.Name .. "House")
                        PCar:SetPrimaryPartCFrame(CFrame.new(House.HouseSpawnPosition.Position))
                        task.wait(0.2)
                        local pedro = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(30, 30, 30), game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(30, 30, 30))
                        local a = workspace:FindPartsInRegion3(pedro, game.Players.LocalPlayer.Character.HumanoidRootPart, math.huge)
                        for i, v in pairs(a) do
                            if v.Name == "HumanoidRootPart" then
                                local b = game:GetService("Players"):FindFirstChild(v.Parent.Name)
                                local args = {
                                    [1] = "BanPlayerFromHouse",
                                    [2] = b,
                                    [3] = v.Parent
                                }
                                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))
                                local args = {
                                    [1] = "DeleteAllVehicles"
                                }
                                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
                            end
                        end
                    end
                end
            end
        end
    end
end

Troll:AddButton({
    Name = "MATA JOGADOR BAN",
    Callback = houseBanKill
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local flingAtivo = false
local posicaoOriginal = nil

local function iniciarLoopScript()
    coroutine.wrap(function()
        while flingAtivo do
            pcall(function()
                local selectedName = getgenv().Target
                if not selectedName then return end

                local Player = LocalPlayer
                local TargetPlayer = Players:FindFirstChild(selectedName)
                if not TargetPlayer or TargetPlayer == Player then return end

                local Character = Player.Character
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                local RootPart = Humanoid and Character:FindFirstChild("HumanoidRootPart")

                local TChar = TargetPlayer.Character
                local THumanoid = TChar and TChar:FindFirstChildOfClass("Humanoid")
                local TRoot = THumanoid and TChar:FindFirstChild("HumanoidRootPart")
                local THead = TChar and TChar:FindFirstChild("Head")
                local Accessory = TChar and TChar:FindFirstChildOfClass("Accessory")
                local Handle = Accessory and Accessory:FindFirstChild("Handle")

                if Character and Humanoid and RootPart and TChar then
                    local function FPos(BasePart, Pos, Ang)
                        if not flingAtivo then return end
                        RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                        Character:SetPrimaryPartCFrame(RootPart.CFrame)
                        RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                        RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                    end

                    local function SFBasePart(BasePart)
                        local t0 = tick()
                        local Angle = 0
                        repeat
                            if not flingAtivo then break end
                            if BasePart.Velocity.Magnitude < 50 then
                                Angle += 900
                                local vel = BasePart.Velocity.Magnitude / 1.25
                                local dir = THumanoid.MoveDirection
                                FPos(BasePart, CFrame.new(0, 1.5, 0) + dir * vel, CFrame.Angles(math.rad(Angle), 0, 0)); task.wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0) + dir * vel, CFrame.Angles(math.rad(Angle), 0, 0)); task.wait()
                            else
                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)); task.wait()
                                FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0)); task.wait()
                            end
                        until BasePart.Velocity.Magnitude > 900 or tick() > t0 + 2
                    end

                    workspace.FallenPartsDestroyHeight = 0/0
                    local BV = Instance.new("BodyVelocity", RootPart)
                    BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
                    BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

                    if TRoot and THead then
                        SFBasePart((TRoot.Position - THead.Position).Magnitude > 5 and THead or TRoot)
                    elseif TRoot then SFBasePart(TRoot)
                    elseif THead then SFBasePart(THead)
                    elseif Handle then SFBasePart(Handle) end

                    BV:Destroy()
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                end
            end)
            task.wait(1)
        end
    end)()
end

-- Toggle final e seguro
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local flingAtivo = false
local posicaoOriginal = nil

local function iniciarLoopScript()
    coroutine.wrap(function()
        while flingAtivo do
            pcall(function()
                local selectedName = getgenv().Target
                if not selectedName then return end

                local Player = LocalPlayer
                local TargetPlayer = Players:FindFirstChild(selectedName)
                if not TargetPlayer or TargetPlayer == Player then return end

                local Character = Player.Character
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                local RootPart = Humanoid and Character:FindFirstChild("HumanoidRootPart")

                local TChar = TargetPlayer.Character
                local THumanoid = TChar and TChar:FindFirstChildOfClass("Humanoid")
                local TRoot = THumanoid and TChar:FindFirstChild("HumanoidRootPart")
                local THead = TChar and TChar:FindFirstChild("Head")
                local Accessory = TChar and TChar:FindFirstChildOfClass("Accessory")
                local Handle = Accessory and Accessory:FindFirstChild("Handle")

                if Character and Humanoid and RootPart and TChar then
                    local function FPos(BasePart, Pos, Ang)
                        if not flingAtivo then return end
                        RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                        Character:SetPrimaryPartCFrame(RootPart.CFrame)
                        RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                        RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                    end

                    local function SFBasePart(BasePart)
                        local t0 = tick()
                        local Angle = 0
                        repeat
                            if not flingAtivo then break end
                            if BasePart.Velocity.Magnitude < 50 then
                                Angle += 900
                                local vel = BasePart.Velocity.Magnitude / 1.25
                                local dir = THumanoid.MoveDirection
                                FPos(BasePart, CFrame.new(0, 1.5, 0) + dir * vel, CFrame.Angles(math.rad(Angle), 0, 0)); task.wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0) + dir * vel, CFrame.Angles(math.rad(Angle), 0, 0)); task.wait()
                            else
                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)); task.wait()
                                FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0)); task.wait()
                            end
                        until BasePart.Velocity.Magnitude > 900 or tick() > t0 + 2
                    end

                    workspace.FallenPartsDestroyHeight = 0/0
                    local BV = Instance.new("BodyVelocity", RootPart)
                    BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
                    BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

                    if TRoot and THead then
                        SFBasePart((TRoot.Position - THead.Position).Magnitude > 5 and THead or TRoot)
                    elseif TRoot then SFBasePart(TRoot)
                    elseif THead then SFBasePart(THead)
                    elseif Handle then SFBasePart(Handle) end

                    BV:Destroy()
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                end
            end)
            task.wait(1)
        end
    end)()
end

-- Toggle final com desequipar ao desligar
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local flingAtivo = false
local posicaoOriginal = nil

local function iniciarLoopScript()
    coroutine.wrap(function()
        while flingAtivo do
            pcall(function()
                local selectedName = getgenv().Target
                if not selectedName then return end

                local Player = LocalPlayer
                local TargetPlayer = Players:FindFirstChild(selectedName)
                if not TargetPlayer or TargetPlayer == Player then return end

                local Character = Player.Character
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                local RootPart = Humanoid and Character:FindFirstChild("HumanoidRootPart")

                local TChar = TargetPlayer.Character
                local THumanoid = TChar and TChar:FindFirstChildOfClass("Humanoid")
                local TRoot = THumanoid and TChar:FindFirstChild("HumanoidRootPart")
                local THead = TChar and TChar:FindFirstChild("Head")
                local Accessory = TChar and TChar:FindFirstChildOfClass("Accessory")
                local Handle = Accessory and Accessory:FindFirstChild("Handle")

                if Character and Humanoid and RootPart and TChar then
                    local function FPos(BasePart, Pos, Ang)
                        if not flingAtivo then return end
                        RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                        Character:SetPrimaryPartCFrame(RootPart.CFrame)
                        RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                        RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                    end

                    local function SFBasePart(BasePart)
                        local t0 = tick()
                        local Angle = 0
                        repeat
                            if not flingAtivo then break end
                            if BasePart.Velocity.Magnitude < 50 then
                                Angle += 900
                                local vel = BasePart.Velocity.Magnitude / 1.25
                                local dir = THumanoid.MoveDirection
                                FPos(BasePart, CFrame.new(0, 1.5, 0) + dir * vel, CFrame.Angles(math.rad(Angle), 0, 0)); task.wait()
                                FPos(BasePart, CFrame.new(0, -1.5, 0) + dir * vel, CFrame.Angles(math.rad(Angle), 0, 0)); task.wait()
                            else
                                FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)); task.wait()
                                FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0)); task.wait()
                            end
                        until BasePart.Velocity.Magnitude > 900 or tick() > t0 + 2
                    end

                    workspace.FallenPartsDestroyHeight = 0/0
                    local BV = Instance.new("BodyVelocity", RootPart)
                    BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
                    BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

                    if TRoot and THead then
                        SFBasePart((TRoot.Position - THead.Position).Magnitude > 5 and THead or TRoot)
                    elseif TRoot then SFBasePart(TRoot)
                    elseif THead then SFBasePart(THead)
                    elseif Handle then SFBasePart(Handle) end

                    BV:Destroy()
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                end
            end)
            task.wait(1)
        end
    end)()
end

-- Toggle final sem deletar sofÃ¡
Troll:AddToggle({
	Name = "FLING FATAL",
	Default = false,
	Callback = function(ativo)
		flingAtivo = ativo

		local char = LocalPlayer.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		local selected = getgenv().Target

		if ativo and selected then
			-- Salvar posiÃ§Ã£o original
			if hrp then
				posicaoOriginal = hrp.CFrame
			end

			-- Se nÃ£o tiver o sofÃ¡ nem equipado nem no backpack, tenta pegar
			local temCouch = LocalPlayer.Backpack:FindFirstChild("Couch") or (char and char:FindFirstChild("Couch"))
			if not temCouch then
				local args = { [1] = "PickingTools", [2] = "Couch" }
				local RE = game:GetService("ReplicatedStorage"):FindFirstChild("RE")
				if RE and RE:FindFirstChild("1Too1l") then
					pcall(function()
						RE["1Too1l"]:InvokeServer(unpack(args))
					end)
				end
			end

			-- Esperar sofÃ¡ aparecer no backpack e equipar se ainda nÃ£o estiver
			task.spawn(function()
				local maxTries, tries = 30, 0
				repeat
					task.wait(0.1)
					tries += 1
				until LocalPlayer.Backpack:FindFirstChild("Couch") or tries >= maxTries

				local tool = LocalPlayer.Backpack:FindFirstChild("Couch")
				if tool and not (char:FindFirstChild("Couch")) then
					tool.Parent = char
				end
			end)

			iniciarLoopScript()

		else
			-- Desequipar sofÃ¡ se estiver na mÃ£o (vai pra mochila)
			local tool = char and char:FindFirstChild("Couch")
			if tool then
				tool.Parent = LocalPlayer.Backpack
			end

			-- Resetar corpo e posiÃ§Ã£o com seguranÃ§a
			if hrp and posicaoOriginal then
				hrp.Velocity = Vector3.zero
				hrp.RotVelocity = Vector3.zero

				for _, v in pairs(hrp:GetChildren()) do
					if v:IsA("BodyVelocity") then
						v:Destroy()
					end
				end

				task.wait(0.1)
				hrp.CFrame = posicaoOriginal
				print("FLING parado e posiÃ§Ã£o restaurada com seguranÃ§a.")
			end
		end
	end
})


local function FlingBall(target)

    local players = game:GetService("Players")
    local player = players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local hrp = character:WaitForChild("HumanoidRootPart")
    local backpack = player:WaitForChild("Backpack")
    local ServerBalls = workspace.WorkspaceCom:WaitForChild("001_SoccerBalls")

    local function GetBall()
        if not backpack:FindFirstChild("SoccerBall") then
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "SoccerBall")
        end
        repeat task.wait() until backpack:FindFirstChild("SoccerBall")
        backpack.SoccerBall.Parent = character
        repeat task.wait() until ServerBalls:FindFirstChild("Soccer" .. player.Name)
        character.SoccerBall.Parent = backpack
        return ServerBalls:FindFirstChild("Soccer" .. player.Name)
    end

    local Ball = ServerBalls:FindFirstChild("Soccer" .. player.Name) or GetBall()
    Ball.CanCollide = false
    Ball.Massless = true
    Ball.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0)

    if target ~= player then
        local tchar = target.Character
        if tchar and tchar:FindFirstChild("HumanoidRootPart") and tchar:FindFirstChild("Humanoid") then
            local troot = tchar.HumanoidRootPart
            local thum = tchar.Humanoid

            if Ball:FindFirstChildWhichIsA("BodyVelocity") then
                Ball:FindFirstChildWhichIsA("BodyVelocity"):Destroy()
            end

            local bv = Instance.new("BodyVelocity")
            bv.Name = "FlingPower"
            bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.P = 9e900
            bv.Parent = Ball

            workspace.CurrentCamera.CameraSubject = thum
            local StartTime = os.time()
            repeat
                if troot.Velocity.Magnitude > 0 then
                -- CÃ¡lculo da posiÃ§Ã£o ajustada com base na velocidade do alvo
                local pos_x = troot.Position.X + (troot.Velocity.X / 1.5)
                local pos_y = troot.Position.Y + (troot.Velocity.Y / 1.5)
                local pos_z = troot.Position.Z + (troot.Velocity.Z / 1.5)

                -- Posiciona a bola diretamente na posiÃ§Ã£o ajustada
                local position = Vector3.new(pos_x, pos_y, pos_z)
                Ball.CFrame = CFrame.new(position)
                Ball.Orientation += Vector3.new(45, 60, 30)
else
for i, v in pairs(tchar:GetChildren()) do
if v:IsA("BasePart") and v.CanCollide and not v.Anchored then
Ball.CFrame = v.CFrame
task.wait(1/6000)
end
end
end
                task.wait(1/6000)
            until troot.Velocity.Magnitude > 1000 or thum.Health <= 0 or not tchar:IsDescendantOf(workspace) or target.Parent ~= players
            workspace.CurrentCamera.CameraSubject = humanoid
        end
    end
end

Troll:AddButton({
    Name = "FLING BOLA",
    Callback = function()
        FlingBall(game:GetService("Players")[selectedPlayerName])
    end
})

local Players = game:GetService('Players')
local lplayer = Players.LocalPlayer

local function isItemInInventory(itemName)
    for _, item in pairs(lplayer.Backpack:GetChildren()) do
        if item.Name == itemName then
            return true
        end
    end
    return false
end

local function equipItem(itemName)
    local item = lplayer.Backpack:FindFirstChild(itemName)
    if item then
        lplayer.Character.Humanoid:EquipTool(item)
    end
end

local function unequipItem(itemName)
    local item = lplayer.Character:FindFirstChild(itemName)
    if item then
        item.Parent = lplayer.Backpack
    end
end

local function ActiveAutoFling(targetPlayer)
    if not isItemInInventory("Couch") then
        local args = { [1] = "PickingTools", [2] = "Couch" }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
    end

    equipItem("Couch")
    getgenv().flingloop = true

    while getgenv().flingloop do
        local function flingloopfix()
            local Players = game:GetService("Players")
            local Player = Players.LocalPlayer
            local AllBool = false

            local SkidFling = function(TargetPlayer)
                local Character = Player.Character
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                local RootPart = Humanoid and Humanoid.RootPart
                local TCharacter = TargetPlayer.Character
                local THumanoid, TRootPart, THead, Accessory, Handle

                if TCharacter:FindFirstChildOfClass("Humanoid") then
                    THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
                end
                if THumanoid and THumanoid.RootPart then
                    TRootPart = THumanoid.RootPart
                end
                if TCharacter:FindFirstChild("Head") then
                    THead = TCharacter.Head
                end
                if TCharacter:FindFirstChildOfClass("Accessory") then
                    Accessory = TCharacter:FindFirstChildOfClass("Accessory")
                end
                if Accessory and Accessory:FindFirstChild("Handle") then
                    Handle = Accessory.Handle
                end

                if Character and Humanoid and RootPart then
                    if RootPart.Velocity.Magnitude < 50 then
                        getgenv().OldPos = RootPart.CFrame
                    end
                    if THumanoid and THumanoid.Sit and not AllBool then
                        unequipItem("Couch")
                        getgenv().flingloop = false
                        return
                    end
                    if THead then
                        workspace.CurrentCamera.CameraSubject = THead
                    elseif not THead and Handle then
                        workspace.CurrentCamera.CameraSubject = Handle
                    elseif THumanoid and TRootPart then
                        workspace.CurrentCamera.CameraSubject = THumanoid
                    end

                    if not TCharacter:FindFirstChildWhichIsA("BasePart") then
                        return
                    end

                    local FPos = function(BasePart, Pos, Ang)
                        RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                        Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                        RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                        RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                    end

                    local SFBasePart = function(BasePart)
                        local TimeToWait = 2
                        local Time = tick()
                        local Angle = 0
                        repeat
                            if RootPart and THumanoid then
                                if BasePart.Velocity.Magnitude < 50 then
                                    Angle = Angle + 100
                                    FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                                    task.wait()
                                else
                                    FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                                    task.wait()
                                    FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                                    task.wait()
                                end
                            else
                                break
                            end
                        until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait or getgenv().flingloop == false
                    end

                    workspace.FallenPartsDestroyHeight = 0/0
                    local BV = Instance.new("BodyVelocity")
                    BV.Name = "SpeedDoPai"
                    BV.Parent = RootPart
                    BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
                    BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

                    if TRootPart and THead then
                        if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                            SFBasePart(THead)
                        else
                            SFBasePart(TRootPart)
                        end
                    elseif TRootPart and not THead then
                        SFBasePart(TRootPart)
                    elseif not TRootPart and THead then
                        SFBasePart(THead)
                    elseif not TRootPart and not THead and Accessory and Handle then
                        SFBasePart(Handle)
                    end
                    BV:Destroy()
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                    workspace.CurrentCamera.CameraSubject = Humanoid

                    repeat
                        RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                        Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                        Humanoid:ChangeState("GettingUp")
                        table.foreach(Character:GetChildren(), function(_, x)
                            if x:IsA("BasePart") then
                                x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                            end
                        end)
                        task.wait()
                    until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25

                    workspace.FallenPartsDestroyHeight = getgenv().FPDH
                end
            end

            if AllBool then
                for _, x in next, Players:GetPlayers() do
                    SkidFling(x)
                end
            end

            if targetPlayer then
                SkidFling(targetPlayer)
            end

            task.wait()
        end

        wait()
        pcall(flingloopfix)
    end
end

local kill = Troll:AddSection({Name = "FLING BARCO"})

Troll:AddButton({
    Name = "FLING BARCO",
    Callback = function()
        if not selectedPlayerName or not game.Players:FindFirstChild(selectedPlayerName) then
            warn("Nenhum jogador selecionado ou nÃ£o existe")
            return
        end

        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")

        if not Humanoid or not RootPart then
            warn("Humanoid ou RootPart invÃ¡lido")
            return
        end

        local function spawnBoat()
            RootPart.CFrame = CFrame.new(1754, -2, 58)
            task.wait(0.5)
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingBoat", "MilitaryBoatFree")
            task.wait(1)
            return Vehicles:FindFirstChild(Player.Name.."Car")
        end

        local PCar = Vehicles:FindFirstChild(Player.Name.."Car") or spawnBoat()
        if not PCar then
            warn("Falha ao spawnar o barco")
            return
        end

        local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
        if not Seat then
            warn("Assento nÃ£o encontrado")
            return
        end

        repeat 
            task.wait(0.1)
            RootPart.CFrame = Seat.CFrame * CFrame.new(0, 1, 0)
        until Humanoid.SeatPart == Seat

        print("Barco spawnado!")

        local TargetPlayer = game.Players:FindFirstChild(selectedPlayerName)
        if not TargetPlayer or not TargetPlayer.Character then
            warn("Jogador nÃ£o encontrado")
            return
        end

        local TargetC = TargetPlayer.Character
        local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
        local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")

        if not TargetRP or not TargetH then
            warn("Humanoid ou RootPart do alvo nÃ£o encontrado")
            return
        end

        local Spin = Instance.new("BodyAngularVelocity")
        Spin.Name = "Spinning"
        Spin.Parent = PCar.PrimaryPart
        Spin.MaxTorque = Vector3.new(0, math.huge, 0)
        Spin.AngularVelocity = Vector3.new(0, 369, 0) 

        print("Fling ativo!")

        local function moveCar(TargetRP, offset)
            if PCar and PCar.PrimaryPart then
                PCar:SetPrimaryPartCFrame(CFrame.new(TargetRP.Position + offset))
            end
        end

        task.spawn(function()
            while PCar and PCar.Parent and TargetRP and TargetRP.Parent do
                task.wait(0.01) 
                
                moveCar(TargetRP, Vector3.new(0, 1, 0))  
                moveCar(TargetRP, Vector3.new(0, -2.25, 5))  
                moveCar(TargetRP, Vector3.new(0, 2.25, 0.25))  
                moveCar(TargetRP, Vector3.new(-2.25, -1.5, 2.25))  
                moveCar(TargetRP, Vector3.new(0, 1.5, 0))  
                moveCar(TargetRP, Vector3.new(0, -1.5, 0))  

                if PCar and PCar.PrimaryPart then
                    local Rotation = CFrame.Angles(
                        math.rad(math.random(-369, 369)),  
                        math.rad(math.random(-369, 369)), 
                        math.rad(math.random(-369, 369))
                    )
                    PCar:SetPrimaryPartCFrame(CFrame.new(TargetRP.Position + Vector3.new(0, 1.5, 0)) * Rotation)
                end
            end

            if Spin and Spin.Parent then
                Spin:Destroy()
                print("Fling desativado")
            end
        end)
    end
})
print("Fling - Boat button created")

Troll:AddButton({
    Name = "DESATIVAR FLING BARCO",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")

        if not RootPart or not Humanoid then
            warn("Nenhum RootPart ou Humanoid encontrado!")
            return
        end

        Humanoid.PlatformStand = true
        print("Jogador paralisado para reduzir efeitos do spin.")

        for _, obj in pairs(RootPart:GetChildren()) do
            if obj:IsA("BodyAngularVelocity") or obj:IsA("BodyVelocity") then
                obj:Destroy()
            end
        end
        print("Spin e forÃ§as removidas do jogador.")

        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
        task.wait(0.5)

        local PCar = Vehicles and Vehicles:FindFirstChild(Player.Name.."Car")
        if PCar and PCar.PrimaryPart then
            for _, obj in pairs(PCar.PrimaryPart:GetChildren()) do
                if obj:IsA("BodyAngularVelocity") or obj:IsA("BodyVelocity") then
                    obj:Destroy()
                end
            end
            print("Spin removido do barco.")
        end

        task.wait(1)

        local safePos = Vector3.new(0, 1000, 0)
        local bp = Instance.new("BodyPosition", RootPart)
        bp.Position = safePos
        bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

        local bg = Instance.new("BodyGyro", RootPart)
        bg.CFrame = RootPart.CFrame
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

        print("Jogador estÃ¡ preso na coordenada segura.")

        task.wait(3)

        bp:Destroy()
        bg:Destroy()
        Humanoid.PlatformStand = false

        print("Jogador liberado, seguro na posiÃ§Ã£o.")
    end
})

local kill = Troll:AddSection({Name = "FLING CLICKS"})

Troll:AddButton({
  Name = "FLING PORTA CLICK",
Description = "FIQUE PERTO DAS PORTAS",
  Callback = function()
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Alvo invisÃ­vel (BlackHole)
local BlackHole = Instance.new("Part")
BlackHole.Size = Vector3.new(100000, 100000, 100000)
BlackHole.Transparency = 1
BlackHole.Anchored = true
BlackHole.CanCollide = false
BlackHole.Name = "BlackHoleTarget"
BlackHole.Parent = Workspace

-- Attachment base no BlackHole
local baseAttachment = Instance.new("Attachment")
baseAttachment.Name = "Luscaa_BlackHoleAttachment"
baseAttachment.Parent = BlackHole

-- Atualiza posiÃ§Ã£o do BlackHole
RunService.Heartbeat:Connect(function()
	BlackHole.CFrame = HRP.CFrame
end)

-- Lista de portas controladas
local ControlledDoors = {}

-- Prepara uma porta para ser controlada
local function SetupPart(part)
	if not part:IsA("BasePart") or part.Anchored or not string.find(part.Name, "Door") then return end
	if part:FindFirstChild("Luscaa_Attached") then return end

	part.CanCollide = false

	for _, obj in ipairs(part:GetChildren()) do
		if obj:IsA("AlignPosition") or obj:IsA("Torque") or obj:IsA("Attachment") then
			obj:Destroy()
		end
	end

	local marker = Instance.new("BoolValue", part)
	marker.Name = "Luscaa_Attached"

	local a1 = Instance.new("Attachment", part)

	local align = Instance.new("AlignPosition", part)
	align.Attachment0 = a1
	align.Attachment1 = baseAttachment
	align.MaxForce = 1e20
	align.MaxVelocity = math.huge
	align.Responsiveness = 99999

	local torque = Instance.new("Torque", part)
	torque.Attachment0 = a1
	torque.RelativeTo = Enum.ActuatorRelativeTo.World
	torque.Torque = Vector3.new(
		math.random(-10e5, 10e5) * 10000,
		math.random(-10e5, 10e5) * 10000,
		math.random(-10e5, 10e5) * 10000
	)

	table.insert(ControlledDoors, {Part = part, Align = align})
end

-- Detecta e prepara portas existentes
for _, obj in ipairs(Workspace:GetDescendants()) do
	if obj:IsA("BasePart") and string.find(obj.Name, "Door") then
		SetupPart(obj)
	end
end

-- Novas portas no futuro
Workspace.DescendantAdded:Connect(function(obj)
	if obj:IsA("BasePart") and string.find(obj.Name, "Door") then
		SetupPart(obj)
	end
end)

-- Flinga jogador com timeout e retorno
local function FlingPlayer(player)
	local char = player.Character
	if not char then return end
	local targetHRP = char:FindFirstChild("HumanoidRootPart")
	if not targetHRP then return end

	local targetAttachment = targetHRP:FindFirstChild("SHNMAX_TargetAttachment")
	if not targetAttachment then
		targetAttachment = Instance.new("Attachment", targetHRP)
		targetAttachment.Name = "SHNMAX_TargetAttachment"
	end

	for _, data in ipairs(ControlledDoors) do
		if data.Align then
			data.Align.Attachment1 = targetAttachment
		end
	end

	local start = tick()
	local flingDetected = false

	while tick() - start < 5 do
		if targetHRP.Velocity.Magnitude >= 20 then
			flingDetected = true
			break
		end
		RunService.Heartbeat:Wait()
	end

	-- Sempre retorna as portas
	for _, data in ipairs(ControlledDoors) do
		if data.Align then
			data.Align.Attachment1 = baseAttachment
		end
	end
end

-- Clique (funciona no mobile)
UserInputService.TouchTap:Connect(function(touchPositions, processed)
	if processed then return end
	local pos = touchPositions[1]
	local camera = Workspace.CurrentCamera
	local unitRay = camera:ScreenPointToRay(pos.X, pos.Y)
	local raycast = Workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000)

	if raycast and raycast.Instance then
		local hit = raycast.Instance
		local player = Players:GetPlayerFromCharacter(hit:FindFirstAncestorOfClass("Model"))
		if player and player ~= LocalPlayer then
			FlingPlayer(player)
		end
	end
end)
  end
})


Troll:AddButton({
    Name = "FLING SOFA CLICK ",
    Callback = function()

local jogadores = game:GetService("Players")
local rep = game:GetService("ReplicatedStorage")
local entrada = game:GetService("UserInputService")
local eu = jogadores.LocalPlayer
local cam = workspace.CurrentCamera

local podeClicar = true
local ferramentaEquipada = false
local NOME_FERRAMENTA = "Click Fling Couch"

local mochila = eu:WaitForChild("Backpack")

if not mochila:FindFirstChild(NOME_FERRAMENTA) and not (eu.Character and eu.Character:FindFirstChild(NOME_FERRAMENTA)) then
	local ferramenta = Instance.new("Tool")
	ferramenta.Name = NOME_FERRAMENTA
	ferramenta.RequiresHandle = false
	ferramenta.CanBeDropped = false

	ferramenta.Equipped:Connect(function()
		ferramentaEquipada = true
	end)

	ferramenta.Unequipped:Connect(function()
		ferramentaEquipada = false
	end)

	ferramenta.Parent = mochila
end

local function jogarComSofa(alvo)
	if not ferramentaEquipada then return end
	if not alvo or not alvo.Character or alvo == eu then return end

	local jogando = true
	local raiz = eu.Character and eu.Character:FindFirstChild("HumanoidRootPart")
	local alvoRaiz = alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart")
	if not raiz or not alvoRaiz then return end

	local boneco = eu.Character
	local humano = boneco:FindFirstChildOfClass("Humanoid")
	local posOriginal = raiz.CFrame

	rep:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
	task.wait(0.2)

	rep.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
	task.wait(0.3)

	local sofa = eu.Backpack:FindFirstChild("Couch")
	if sofa then
		sofa.Parent = boneco
	end
	task.wait(0.1)

	game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
	task.wait(0.25)

	workspace.FallenPartsDestroyHeight = 0/0

	local forca = Instance.new("BodyVelocity")
	forca.Name = "ForcaJogada"
	forca.Velocity = Vector3.new(9e8, 9e8, 9e8)
	forca.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	forca.Parent = raiz

	humano:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
	humano.PlatformStand = false
	cam.CameraSubject = alvo.Character:FindFirstChild("Head") or alvoRaiz or humano

	task.spawn(function()
		local angulo = 0
		local partes = {raiz}
		while jogando and alvo and alvo.Character and alvo.Character:FindFirstChildOfClass("Humanoid") do
			local alvoHum = alvo.Character:FindFirstChildOfClass("Humanoid")
			if alvoHum.Sit then break end
			angulo += 50

			for _, parte in ipairs(partes) do
				local hrp = alvo.Character.HumanoidRootPart
				local pos = hrp.Position + hrp.Velocity / 1.5
				raiz.CFrame = CFrame.new(pos) * CFrame.Angles(math.rad(angulo), 0, 0)
			end

			raiz.Velocity = Vector3.new(9e8, 9e8, 9e8)
			raiz.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
			task.wait()
		end

		jogando = false
		forca:Destroy()
		humano:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
		humano.PlatformStand = false
		raiz.CFrame = posOriginal
		cam.CameraSubject = humano

		for _, p in pairs(boneco:GetDescendants()) do
			if p:IsA("BasePart") then
				p.Velocity = Vector3.zero
				p.RotVelocity = Vector3.zero
			end
		end

		humano:UnequipTools()
		rep.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
	end)

	while jogando do
		task.wait()
	end
end

entrada.TouchTap:Connect(function(toques, processado)
	if processado or not podeClicar or not ferramentaEquipada then return end

	local pos = toques[1]
	local raio = cam:ScreenPointToRay(pos.X, pos.Y)
	local acerto = workspace:Raycast(raio.Origin, raio.Direction * 1000)

	if acerto and acerto.Instance then
		local alvo = jogadores:GetPlayerFromCharacter(acerto.Instance:FindFirstAncestorOfClass("Model"))
		if alvo and alvo ~= eu then
			podeClicar = false
			jogarComSofa(alvo)
			task.delay(2, function()
				podeClicar = true
			end)
		end
	end
end)
end
})

Troll:AddButton({
    Name = "FLING BOLA CLICK",
    Callback = function()
local jogadores = game:GetService("Players")
local rep = game:GetService("ReplicatedStorage")
local mundo = game:GetService("Workspace")
local entrada = game:GetService("UserInputService")
local cam = mundo.CurrentCamera
local eu = jogadores.LocalPlayer

local NOME_FERRAMENTA = "Click Fling Ball"
local ferramentaEquipada = false

local mochila = eu:WaitForChild("Backpack")
if not mochila:FindFirstChild(NOME_FERRAMENTA) then
	local ferramenta = Instance.new("Tool")
	ferramenta.Name = NOME_FERRAMENTA
	ferramenta.RequiresHandle = false
	ferramenta.CanBeDropped = false

	ferramenta.Equipped:Connect(function()
		ferramentaEquipada = true
	end)

	ferramenta.Unequipped:Connect(function()
		ferramentaEquipada = false
	end)

	ferramenta.Parent = mochila
end

-- FunÃ§Ã£o FlingBall (bola)
local function FlingBall(target)
    

    local players = game:GetService("Players")
    local player = players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local hrp = character:WaitForChild("HumanoidRootPart")
    local backpack = player:WaitForChild("Backpack")
    local ServerBalls = workspace.WorkspaceCom:WaitForChild("001_SoccerBalls")

    local function GetBall()
        if not backpack:FindFirstChild("SoccerBall") and not character:FindFirstChild("SoccerBall") then
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "SoccerBall")
        end

        repeat task.wait() until backpack:FindFirstChild("SoccerBall") or character:FindFirstChild("SoccerBall")

        local ballTool = backpack:FindFirstChild("SoccerBall")
        if ballTool then
            ballTool.Parent = character
        end

        repeat task.wait() until ServerBalls:FindFirstChild("Soccer" .. player.Name)

        return ServerBalls:FindFirstChild("Soccer" .. player.Name)
    end

    local Ball = ServerBalls:FindFirstChild("Soccer" .. player.Name) or GetBall()
    Ball.CanCollide = false
    Ball.Massless = true
    Ball.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0)

    if target ~= player then
        local tchar = target.Character
        if tchar and tchar:FindFirstChild("HumanoidRootPart") and tchar:FindFirstChild("Humanoid") then
            local troot = tchar.HumanoidRootPart
            local thum = tchar.Humanoid

            if Ball:FindFirstChildWhichIsA("BodyVelocity") then
                Ball:FindFirstChildWhichIsA("BodyVelocity"):Destroy()
            end

            local bv = Instance.new("BodyVelocity")
            bv.Name = "FlingPower"
            bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.P = 9e900
            bv.Parent = Ball

            workspace.CurrentCamera.CameraSubject = thum

            repeat
                if troot.Velocity.Magnitude > 0 then
                    local pos = troot.Position + (troot.Velocity / 1.5)
                    Ball.CFrame = CFrame.new(pos)
                    Ball.Orientation += Vector3.new(45, 60, 30)
                else
                    for i, v in pairs(tchar:GetChildren()) do
                        if v:IsA("BasePart") and v.CanCollide and not v.Anchored then
                            Ball.CFrame = v.CFrame
                            task.wait(1/6000)
                        end
                    end
                end
                task.wait(1/6000)
            until troot.Velocity.Magnitude > 1000 or thum.Health <= 0 or not tchar:IsDescendantOf(workspace) or target.Parent ~= players

            workspace.CurrentCamera.CameraSubject = humanoid
        end
    end
end

-- Toque na tela para aplicar a bola
entrada.TouchTap:Connect(function(toques, processado)
	if not ferramentaEquipada or processado then return end
	local pos = toques[1]
	local raio = cam:ScreenPointToRay(pos.X, pos.Y)
	local hit = mundo:Raycast(raio.Origin, raio.Direction * 1000)
	if hit and hit.Instance then
		local modelo = hit.Instance:FindFirstAncestorOfClass("Model")
		local jogador = jogadores:GetPlayerFromCharacter(modelo)
		if jogador and jogador ~= eu then
			FlingBall(jogador)
		end
	end
end)

end
})

Troll:AddButton({
    Name = "FLING ELIMINAR SOFA CLICK",
    Callback = function()

local jogadores = game:GetService("Players")
local rep = game:GetService("ReplicatedStorage")
local loop = game:GetService("RunService")
local mundo = game:GetService("Workspace")
local entrada = game:GetService("UserInputService")

local eu = jogadores.LocalPlayer
local cam = mundo.CurrentCamera

local NOME_FERRAMENTA = "Click Kill Couch"
local ferramentaEquipada = false
local nomeAlvo = nil
local loopTP = nil
local sofaEquipado = false
local base = nil
local posInicial = nil
local raiz = nil

local mochila = eu:WaitForChild("Backpack")
if not mochila:FindFirstChild(NOME_FERRAMENTA) then
	local ferramenta = Instance.new("Tool")
	ferramenta.Name = NOME_FERRAMENTA
	ferramenta.RequiresHandle = false
	ferramenta.CanBeDropped = false

	ferramenta.Equipped:Connect(function()
		ferramentaEquipada = true
	end)

	ferramenta.Unequipped:Connect(function()
		ferramentaEquipada = false
		nomeAlvo = nil
		limparSofa()
	end)

	ferramenta.Parent = mochila
end

function limparSofa()
	if loopTP then
		loopTP:Disconnect()
		loopTP = nil
	end

	if sofaEquipado then
		local boneco = eu.Character
		if boneco then
			local sofa = boneco:FindFirstChild("Couch")
			if sofa then
				sofa.Parent = eu.Backpack
				sofaEquipado = false
			end
		end
	end

	if base then
		base:Destroy()
		base = nil
	end

	if getgenv().AntiSit then
		getgenv().AntiSit:Set(false)
	end

	local humano = eu.Character and eu.Character:FindFirstChildOfClass("Humanoid")
	if humano then
		humano:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
		humano:ChangeState(Enum.HumanoidStateType.GettingUp)
	end

	if posInicial and raiz then
		raiz.CFrame = posInicial
		posInicial = nil
	end
end

function pegarSofa()
	local boneco = eu.Character
	if not boneco then return end
	local mochila = eu.Backpack

	if not mochila:FindFirstChild("Couch") and not boneco:FindFirstChild("Couch") then
		local args = { "PickingTools", "Couch" }
		rep.RE["1Too1l"]:InvokeServer(unpack(args))
		task.wait(0.1)
	end

	local sofa = mochila:FindFirstChild("Couch") or boneco:FindFirstChild("Couch")
	if sofa then
		sofa.Parent = boneco
		sofaEquipado = true
	end
end

function posAleatoriaAbaixo(boneco)
	local rp = boneco:FindFirstChild("HumanoidRootPart")
	if not rp then return Vector3.new() end
	local offset = Vector3.new(math.random(-2, 2), -5.1, math.random(-2, 2))
	return rp.Position + offset
end

function tpAbaixo(alvo)
	if not alvo or not alvo.Character or not alvo.Character:FindFirstChild("HumanoidRootPart") then return end

	local meuBoneco = eu.Character
	local minhaRaiz = meuBoneco and meuBoneco:FindFirstChild("HumanoidRootPart")
	local humano = meuBoneco and meuBoneco:FindFirstChildOfClass("Humanoid")

	if not minhaRaiz or not humano then return end

	humano:SetStateEnabled(Enum.HumanoidStateType.Physics, false)

	if not base then
		base = Instance.new("Part")
		base.Size = Vector3.new(10, 1, 10)
		base.Anchored = true
		base.CanCollide = true
		base.Transparency = 0.5
		base.Parent = mundo
	end

	local destino = posAleatoriaAbaixo(alvo.Character)
	base.Position = destino
	minhaRaiz.CFrame = CFrame.new(destino)

	humano:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
end

function arremessarComSofa(alvo)
	if not alvo then return end
	nomeAlvo = alvo.Name
	local boneco = eu.Character
	if not boneco then return end

	posInicial = boneco:FindFirstChild("HumanoidRootPart") and boneco.HumanoidRootPart.CFrame
	raiz = boneco:FindFirstChild("HumanoidRootPart")
	pegarSofa()

	loopTP = loop.Heartbeat:Connect(function()
		local alvoAtual = jogadores:FindFirstChild(nomeAlvo)
		if not alvoAtual or not alvoAtual.Character or not alvoAtual.Character:FindFirstChild("Humanoid") then
			limparSofa()
			return
		end
		if getgenv().AntiSit then
			getgenv().AntiSit:Set(true)
		end
		tpAbaixo(alvoAtual)
	end)

	task.spawn(function()
		local alvoAtual = jogadores:FindFirstChild(nomeAlvo)
		while alvoAtual and alvoAtual.Character and alvoAtual.Character:FindFirstChild("Humanoid") do
			task.wait(0.05)
			if alvoAtual.Character.Humanoid.SeatPart then
				local buraco = CFrame.new(265.46, -450.83, -59.93)
				alvoAtual.Character.HumanoidRootPart.CFrame = buraco
				eu.Character.HumanoidRootPart.CFrame = buraco
				task.wait(0.4)
				limparSofa()
				task.wait(0.2)
				if posInicial then
					eu.Character.HumanoidRootPart.CFrame = posInicial
				end
				break
			end
		end
	end)
end

entrada.TouchTap:Connect(function(toques, processado)
	if not ferramentaEquipada or processado then return end
	local pos = toques[1]
	local raio = cam:ScreenPointToRay(pos.X, pos.Y)
	local hit = mundo:Raycast(raio.Origin, raio.Direction * 1000)
	if hit and hit.Instance then
		local modelo = hit.Instance:FindFirstAncestorOfClass("Model")
		local jogador = jogadores:GetPlayerFromCharacter(modelo)
		if jogador and jogador ~= eu then
			arremessarComSofa(jogador)
		end
	end
end)
end
})

local kill = Troll:AddSection({Name = "FLING TODOS"})

Troll:AddButton({
    Name = "ELIMINAR TODOS ONIBUS",
    Callback = function()
        local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local destination = Vector3.new(145.51, -374.09, 21.58) 
local originalPosition = nil  

local function GetBus()  
    local vehicles = Workspace:FindFirstChild("Vehicles")  
    if vehicles then  
        return vehicles:FindFirstChild(Players.LocalPlayer.Name.."Car")  
    end  
    return nil  
end  

local function TrackPlayer(selectedPlayerName, callback)
    while true do  
        if selectedPlayerName then  
            local targetPlayer = Players:FindFirstChild(selectedPlayerName)  
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then  
                local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")  
                if targetHumanoid and targetHumanoid.Sit then  
                    local bus = GetBus()
                    if bus then
                        bus:SetPrimaryPartCFrame(CFrame.new(destination))   
                        print("Jogador sentou, levando Ã´nibus para o void!")  

                        task.wait(0.2)  

                        local function simulateJump()  
                            local humanoid = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")  
                            if humanoid then  
                                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)  
                            end  
                        end  

                        simulateJump()  
                        print("Simulando primeiro pulo!")  

                        task.wait(0.4)  
                        simulateJump()
                        print("Simulando segundo pulo!")  

                        task.wait(0.5)
                        if originalPosition then
                            Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalPosition  
                            print("Player voltou para a posiÃ§Ã£o inicial Xique")  

                            task.wait(0.1)
                            local args = {
                                [1] = "DeleteAllVehicles"
                            }
                            ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
                            print("Todos os veÃ­culos foram deletados!")
                        end
                    end
                    break  
                else  
                    local targetRoot = targetPlayer.Character.HumanoidRootPart  
                    local time = tick() * 35
               
                    local lateralOffset = math.sin(time) * 10  -- Movimento lateral rÃ¡pido  
                    local frontBackOffset = math.cos(time) * 20  -- Movimento frente/trÃ¡s
                      
                    local bus = GetBus()
                    if bus then
                        bus:SetPrimaryPartCFrame(targetRoot.CFrame * CFrame.new(0, 0, frontBackOffset))  
                    end
                end  
            end  
        end  
        RunService.RenderStepped:Wait()  
    end
    
    if callback then
        callback()
    end
end  

local function StartKillBusao(playerName, callback)
    local selectedPlayerName = playerName

    local player = Players.LocalPlayer  
    local character = player.Character or player.CharacterAdded:Wait()  
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")  

    originalPosition = humanoidRootPart.CFrame  

    local bus = GetBus()  

    if not bus then  
        humanoidRootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)  
        task.wait(0.5)  
        local remoteEvent = ReplicatedStorage:FindFirstChild("RE")  
        if remoteEvent and remoteEvent:FindFirstChild("1Ca1r") then  
            remoteEvent["1Ca1r"]:FireServer("PickingCar", "SchoolBus")  
        end  
        task.wait(1)  
        bus = GetBus()  
    end  

    if bus then  
        local seat = bus:FindFirstChild("Body") and bus.Body:FindFirstChild("VehicleSeat")  
        if seat and character:FindFirstChildOfClass("Humanoid") and not character.Humanoid.Sit then  
            repeat  
                humanoidRootPart.CFrame = seat.CFrame * CFrame.new(0, 2, 0)  
                task.wait()  
            until character.Humanoid.Sit or not bus.Parent  
        end  
    end  

    spawn(function()
        TrackPlayer(selectedPlayerName, callback)
    end)
end

local function PerformActionForAllPlayers(players)
    if #players == 0 then
        return
    end

    local player = table.remove(players, 1)
    StartKillBusao(player.Name, function()
        task.wait(0.5)
        PerformActionForAllPlayers(players)
    end)
end

PerformActionForAllPlayers(Players:GetPlayers())
    end
})
print("Kill All Bus button created")

Troll:AddButton({
    Name = "MATA JOGADOR BAN",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")


local function executeScriptForPlayer(targetPlayer)
    local Player = game.Players.LocalPlayer
    local Backpack = Player.Backpack
    local Character = Player.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    local Houses = game.Workspace:FindFirstChild("001_Lots")
    local OldPos = RootPart.CFrame
    local Angles = 0
    local Vehicles = Workspace.Vehicles
    local Pos


    function Check()
        if Player and Character and Humanoid and RootPart and Vehicles then
            return true
        else
            return false
        end
    end


    if Check() then
        local House = Houses:FindFirstChild(Player.Name.."House")
        if not House then
            local EHouse
            for _, Lot in pairs(Houses:GetChildren()) do
                if Lot.Name == "For Sale" then
                    for _, num in pairs(Lot:GetDescendants()) do
                        if num:IsA("NumberValue") and num.Name == "Number" and num.Value < 25 and num.Value > 10 then
                            EHouse = Lot
                            break
                        end
                    end
                end
            end


            local BuyDetector = EHouse:FindFirstChild("BuyHouse")
            Pos = BuyDetector.Position
            if BuyDetector and BuyDetector:IsA("BasePart") then
                RootPart.CFrame = BuyDetector.CFrame + Vector3.new(0, -6, 0)
                task.wait(0.5)
                local ClickDetector = BuyDetector:FindFirstChild("ClickDetector")
                if ClickDetector then
                    fireclickdetector(ClickDetector)
                end
            end
        end


        task.wait(0.5)
        local PreHouse = Houses:FindFirstChild(Player.Name .. "House")
        if PreHouse then
            task.wait(0.5)
            local Number
            for i, x in pairs(PreHouse:GetDescendants()) do
                if x.Name == "Number" and x:IsA("NumberValue") then
                    Number = x
                end
            end
            task.wait(0.5)
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gettin1gHous1e"):FireServer("PickingCustomHouse", "049_House", Number.Value)
        end


        task.wait(0.5)
        local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
        if not PCar then
            if Check() then
                RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                task.wait(0.5)
                local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
                task.wait(0.5)
                local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat
                        task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end
        end


        task.wait(0.5)
        local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
        if PCar then
            if not Humanoid.Sit then
                local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat
                        task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end


            local Target = targetPlayer
            local TargetC = Target.Character
            local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
            local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
            if TargetC and TargetH and TargetRP then
                if not TargetH.Sit then
                    while not TargetH.Sit do
                        task.wait()
                        local Fling = function(alvo, pos, angulo)
                            PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                        end
                        Angles = Angles + 100
                        Fling(TargetRP, CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                        Fling(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                        Fling(TargetRP, CFrame.new(2.25, 1.5, -2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                        Fling(TargetRP, CFrame.new(-2.25, -1.5, 2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                        Fling(TargetRP, CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                        Fling(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angles), 0, 0))
                    end
                    task.wait(0.2)
                    local House = Houses:FindFirstChild(Player.Name.."House")
                    PCar:SetPrimaryPartCFrame(CFrame.new(House.HouseSpawnPosition.Position))
                    task.wait(0.2)
                    local pedro = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(30,30,30), game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(30,30,30))
                    local a = workspace:FindPartsInRegion3(pedro, game.Players.LocalPlayer.Character.HumanoidRootPart, math.huge)
                    for i, v in pairs(a) do
                        if v.Name == "HumanoidRootPart" then
                            local b = game:GetService("Players"):FindFirstChild(v.Parent.Name)
                            local args = {
                                [1] = "BanPlayerFromHouse",
                                [2] = b,
                                [3] = v.Parent
                            }
                            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))
                        end
                    end
                end
            end
        end
    end


    -- Deletar o veÃ­culo
    local deleteArgs = {
        [1] = "DeleteAllVehicles"
    }
    ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(deleteArgs))
end


-- Iterar sobre todos os jogadores no mapa
for _, player in pairs(Players:GetPlayers()) do
    if player ~= Player then
        executeScriptForPlayer(player)
       task.wait(2)
    end
end
    end
})
print("House Ban kill All button created")

Troll:AddButton({
    Name = "FLING TODOS BARCO ",
    Callback = function()
        local Player = game.Players.LocalPlayer
    local Character = Player.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    local Vehicles = game.Workspace:FindFirstChild("Vehicles")
    local OldPos = RootPart.CFrame
    local Angles = 0
    local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
    
    -- Se nÃƒÂ£o tiver um carro, cria um  
            if not PCar then  
                if RootPart then  
                    RootPart.CFrame = CFrame.new(1754, -2, 58)  
                    task.wait(0.5)  
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingBoat", "MilitaryBoatFree")  
                    task.wait(0.5)  
                    PCar = Vehicles:FindFirstChild(Player.Name.."Car")  
                    task.wait(0.5)  
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")  
                    if Seat then  
                        repeat  
                            task.wait()  
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)  
                        until Humanoid.Sit  
                    end  
                end  
            end  
      
            task.wait(0.5)  
            PCar = Vehicles:FindFirstChild(Player.Name.."Car")  
      
            -- Se o carro existir, teletransporta para o assento se necessÃƒÂ¡rio  
            if PCar then  
                if not Humanoid.Sit then  
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")  
                    if Seat then  
                        repeat  
                            task.wait()  
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)  
                        until Humanoid.Sit  
                    end  
                end  
            end  
      
            -- Adiciona o BodyGyro ao carro para controle de movimento  
            local SpinGyro = Instance.new("BodyGyro")  
            SpinGyro.Parent = PCar.PrimaryPart  
            SpinGyro.MaxTorque = Vector3.new(1e7, 1e7, 1e7)  
            SpinGyro.P = 1e7  
            SpinGyro.CFrame = PCar.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(90), 0)  
      
            -- FunÃƒÂ§ÃƒÂ£o de Fling em cada jogador por 3 segundos  
            local function flingPlayer(TargetC, TargetRP, TargetH)
    Angles = 0  
                local endTime = tick() + 1  -- Define o tempo final em 2 segundos a partir de agora  
                while tick() < endTime do  
                    Angles = Angles + 100  
                    task.wait()  
      
                    -- Movimentos e ÃƒÂ¢ngulos para o Fling  
                    local kill = function(alvo, pos, angulo)  
                        PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)  
                    end  
      
                    -- Fling para vÃƒÂ¡rias posiÃƒÂ§ÃƒÂµes ao redor do TargetRP  
                    kill(TargetRP, CFrame.new(0, 3, 0), CFrame.Angles(math.rad(Angles), 0, 0))  
                    kill(TargetRP, CFrame.new(0, -1.5, 2), CFrame.Angles(math.rad(Angles), 0, 0))  
                    kill(TargetRP, CFrame.new(2, 1.5, 2.25), CFrame.Angles(math.rad(50), 0, 0))  
                    kill(TargetRP, CFrame.new(-2.25, -1.5, 2.25), CFrame.Angles(math.rad(30), 0, 0))  
                    kill(TargetRP, CFrame.new(0, 1.5, 0), CFrame.Angles(math.rad(Angles), 0, 0))  
                    kill(TargetRP, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(Angles), 0, 0))  
                end  
            end  
      
            -- Itera sobre todos os jogadores  
            for _, Target in pairs(game.Players:GetPlayers()) do  
                -- Pula o jogador local  
                if Target ~= Player then  
                    local TargetC = Target.Character  
                    local TargetH = TargetC and TargetC:FindFirstChildOfClass("Humanoid")  
                    local TargetRP = TargetC and TargetC:FindFirstChild("HumanoidRootPart")  
      
                    -- Se encontrar o alvo e seus componentes, executa o fling  
                    if TargetC and TargetH and TargetRP then  
                        flingPlayer(TargetC, TargetRP, TargetH)  -- Fling no jogador atual  
                    end  
                end  
            end  
      
            -- Retorna o jogador para sua posiÃƒÂ§ÃƒÂ£o original  
            task.wait(0.5)  
            PCar:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))  
            task.wait(0.5)  
            Humanoid.Sit = false  
            task.wait(0.5)  
            RootPart.CFrame = OldPos  
      
            -- Remove o BodyGyro apÃƒÂ³s o efeito  
            SpinGyro:Destroy()  
    end
})
print("Fling Boat All button created")

Troll:AddButton({
    Name = "FLING TODOS ARMS",
    Callback = function()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer
    local cam = workspace.CurrentCamera


    local function ProcessPlayer(target)
        if not target or not target.Character or target == LocalPlayer then return end
        
        local flingActive = true
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
        if not root or not tRoot then return end
        
        local char = LocalPlayer.Character
        local hum = char:FindFirstChildOfClass("Humanoid")
        local original = root.CFrame

    
        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
        task.wait(0.2)

  
        ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
        task.wait(0.3)

        local tool = LocalPlayer.Backpack:FindFirstChild("Couch")
        if tool then
            tool.Parent = char
        end
task.wait(0.1)

game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
task.wait(0.25)

        workspace.FallenPartsDestroyHeight = 0/0

        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlingForce"
        bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Parent = root

        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        hum.PlatformStand = false
        cam.CameraSubject = target.Character:FindFirstChild("Head") or tRoot or hum

 
        task.spawn(function()
            local angle = 0
            local parts = {root}
            while flingActive and target and target.Character and target.Character:FindFirstChildOfClass("Humanoid") do
                local tHum = target.Character:FindFirstChildOfClass("Humanoid")
                if tHum.Sit then break end
                angle += 50

                for _, part in ipairs(parts) do
                    local hrp = target.Character.HumanoidRootPart
                    local pos = hrp.Position + hrp.Velocity / 1.5
                    root.CFrame = CFrame.new(pos) * CFrame.Angles(math.rad(angle), 0, 0)
                end

                root.Velocity = Vector3.new(9e8, 9e8, 9e8)
                root.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                task.wait()
            end

         
            flingActive = false
            bv:Destroy()
            hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            hum.PlatformStand = false
            root.CFrame = original
            cam.CameraSubject = hum

            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.Velocity = Vector3.zero
                    p.RotVelocity = Vector3.zero
                end
            end

            hum:UnequipTools()
            ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
        end)
       
        while flingActive do
            task.wait()
        end
    end


    for _, player in ipairs(Players:GetPlayers()) do
        ProcessPlayer(player)
			end
    end
})



Troll:AddButton({
    Name = "FLING TODOS BOLA",
    Callback = function()
local player=game:GetService("Players").LocalPlayer
local SoccerBalls=workspace.WorkspaceCom["001_SoccerBalls"]
local MyBall=SoccerBalls:FindFirstChild("Soccer"..player.Name)

if not MyBall then
if not player.Backpack:FindFirstChild("SoccerBall") then
local args={[1]="PickingTools",[2]="SoccerBall"}
game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
task.wait()
player.Backpack.SoccerBall.Parent=player.Character
repeat MyBall=SoccerBalls:FindFirstChild("Soccer"..player.Name) task.wait() until MyBall
player.Character.SoccerBall.Parent=player.Backpack
task.wait()
else
player.Backpack.SoccerBall.Parent=player.Character
repeat MyBall=SoccerBalls:FindFirstChild("Soccer"..player.Name) task.wait() until MyBall
player.Character.SoccerBall.Parent=player.Backpack
end
end


for i,v in pairs(game.Players:GetPlayers()) do
if v~=game.Players.LocalPlayer then
local target=v
local TCharacter=target.Character or target.CharacterAdded:Wait()
local THumanoidRootPart=TCharacter:WaitForChild("HumanoidRootPart")
if not MyBall or not THumanoidRootPart then return end

for _,v in pairs(MyBall:GetChildren()) do
if v:IsA("BodyMover") then v:Destroy() end
end

local bodyVelocity=Instance.new("BodyVelocity")
bodyVelocity.Velocity=Vector3.new(9e8,9e8,9e8)
bodyVelocity.MaxForce=Vector3.new(1/0,1/0,1/0)
bodyVelocity.P=1e10
bodyVelocity.Parent=MyBall

local bv=Instance.new("BodyVelocity")
bv.Velocity=Vector3.new(9e8,9e8,9e8)
bv.MaxForce=Vector3.new(1/0,1/0,1/0)
bv.P=1e9
bv.Parent=THumanoidRootPart

local oldPos=THumanoidRootPart.Position
workspace.CurrentCamera.CameraSubject=THumanoidRootPart

repeat
local velocity=THumanoidRootPart.Velocity.Magnitude
local parts={}
for _,v in pairs(TCharacter:GetDescendants()) do
if v:IsA("BasePart") and v.CanCollide and not v.Anchored then table.insert(parts,v) end
end
for _,part in ipairs(parts) do
local pos_x=target.Character.HumanoidRootPart.Position.X
local pos_y=target.Character.HumanoidRootPart.Position.Y
local pos_z=target.Character.HumanoidRootPart.Position.Z
pos_x=pos_x+(target.Character.HumanoidRootPart.Velocity.X/1.5)
pos_y=pos_y+(target.Character.HumanoidRootPart.Velocity.Y/1.5)
pos_z=pos_z+(target.Character.HumanoidRootPart.Velocity.Z/1.5)
MyBall.CFrame=CFrame.new(pos_x,pos_y,pos_z)
task.wait(1/6000)
end
task.wait(1/6000)
until THumanoidRootPart.Velocity.Magnitude>5000 or TCharacter.Humanoid.Health==0 or target.Parent~=game.Players or THumanoidRootPart.Parent~=TCharacter or TCharacter~=target.Character

end
end

workspace.CurrentCamera.CameraSubject=game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
  end
})

local kill = Troll:AddSection({Name = "FLING BURACO NEGRO"})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- Lista de jogadores (Dropdown)
local function getPlayerList()
    local players = Players:GetPlayers()
    local playerNames = {}
    for _, player in ipairs(players) do
        if player ~= LocalPlayer then
            table.insert(playerNames, player.Name)
        end
    end
    return playerNames
end

local selectedPlayerName = nil
local blackHoleActive = false
local DescendantAddedConnection
local followConnection

local Folder = Instance.new("Folder", Workspace)
Folder.Name = "BringPartsFolder"

local Part = Instance.new("Part", Folder)
Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 1

local Attachment1 = Instance.new("Attachment", Part)

local function ForcePart(v)
    if v:IsA("BasePart") and not v.Anchored and not v.Parent:FindFirstChildOfClass("Humanoid")
        and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then

        for _, x in ipairs(v:GetChildren()) do
            if x:IsA("BodyMover") or x:IsA("RocketPropulsion") then
                x:Destroy()
            end
        end
        if v:FindFirstChild("Attachment") then v:FindFirstChild("Attachment"):Destroy() end
        if v:FindFirstChild("AlignPosition") then v:FindFirstChild("AlignPosition"):Destroy() end
        if v:FindFirstChild("Torque") then v:FindFirstChild("Torque"):Destroy() end

        v.CanCollide = false

        local torque = Instance.new("Torque", v)
        torque.Torque = Vector3.new(9e9, 9e9, 9e9)

        local align = Instance.new("AlignPosition", v)
        local att = Instance.new("Attachment", v)

        torque.Attachment0 = att

        align.MaxForce = 1e12
        align.MaxVelocity = 1e12
        align.Responsiveness = 1e12
        align.Attachment0 = att
        align.Attachment1 = Attachment1
    end
end

if not getgenv().Network then
    getgenv().Network = {
        BaseParts = {},
        Velocity = Vector3.new(1e8, 1e8, 1e8)
    }

    getgenv().Network.RetainPart = function(Part)
        if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(Workspace) then
            table.insert(getgenv().Network.BaseParts, Part)
            Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            Part.CanCollide = false
        end
    end

    RunService.Heartbeat:Connect(function()
        pcall(function()
            sethiddenproperty(Players.LocalPlayer, "SimulationRadius", math.huge)
        end)
        for _, part in ipairs(getgenv().Network.BaseParts) do
            if part:IsDescendantOf(Workspace) then
                part.Velocity = getgenv().Network.Velocity
            end
        end
    end)
end

local function monitorPlayer(player)
    if followConnection then
        followConnection:Disconnect()
        followConnection = nil
    end

    followConnection = RunService.RenderStepped:Connect(function()
        if blackHoleActive and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            Attachment1.WorldCFrame = player.Character.HumanoidRootPart.CFrame
        end
    end)
end

local function updateFollow()
    local player = Players:FindFirstChild(getgenv().SelectedPlayer)
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        monitorPlayer(player)
    else
        if followConnection then
            followConnection:Disconnect()
            followConnection = nil
        end
    end
end

function toggleBlackHole()
    blackHoleActive = not blackHoleActive

    if blackHoleActive then
        local player = Players:FindFirstChild(getgenv().SelectedPlayer)
        if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            warn("Jogador invÃ¡lido.")
            blackHoleActive = false
            return
        end

        monitorPlayer(player)

        for _, v in ipairs(Workspace:GetDescendants()) do
            ForcePart(v)
        end

        DescendantAddedConnection = Workspace.DescendantAdded:Connect(function(v)
            if blackHoleActive then
                ForcePart(v)
            end
        end)
    else
        if DescendantAddedConnection then
            DescendantAddedConnection:Disconnect()
            DescendantAddedConnection = nil
        end
        if followConnection then
            followConnection:Disconnect()
            followConnection = nil
        end
    end
end

local killDropdown = Troll:AddDropdown({
    Name = "SELECIONAR JOGADOR",
    Options = getPlayerList(),
    Default = "",
    Callback = function(value)
        selectedPlayerName = value
        getgenv().SelectedPlayer = value
        print("Jogador selecionado: " .. tostring(value))
        if blackHoleActive then
            updateFollow()
        end
    end
})

Troll:AddButton({
    Name = "ATUALIZAR LISTA",
    Callback = function()
        local players = Players:GetPlayers()
        local newPlayers = {}
        for _, player in ipairs(players) do
            if player ~= LocalPlayer then
                table.insert(newPlayers, player.Name)
            end
        end
        if killDropdown then
            killDropdown:Set(newPlayers)
        end
        print("Lista de jogadores atualizada: ", table.concat(newPlayers, ", "))
        if selectedPlayerName and not Players:FindFirstChild(selectedPlayerName) then
            selectedPlayerName = nil
            getgenv().SelectedPlayer = nil
            killDropdown:SetValue("")
            print("SeleÃ§Ã£o resetada, jogador nÃ£o estÃ¡ mais no servidor.")
        end
    end
})

Troll:AddToggle({
    Name = "FLING BCNG",
    Default = false,
    Callback = function(state)
        if not getgenv().SelectedPlayer or getgenv().SelectedPlayer == "" then
            warn("âš ï¸ Nenhum jogador selecionado.")
            return
        end
        if blackHoleActive ~= state then
            toggleBlackHole()
        end
    end
})


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local Folder = Instance.new("Folder", Workspace)
local Part = Instance.new("Part", Folder)
local Attachment1 = Instance.new("Attachment", Part)
Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 1

-- Fling Control
if not getgenv().Network then
	getgenv().Network = {
		BaseParts = {},
		Velocity = Vector3.new(99999, 99999, 99999)
	}

	Network.RetainPart = function(Part)
		if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(Workspace) then
			table.insert(Network.BaseParts, Part)
			Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
			Part.CanCollide = false
		end
	end

	RunService.Heartbeat:Connect(function()
		pcall(function()
			sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
		end)
		for _, Part in pairs(Network.BaseParts) do
			if Part:IsDescendantOf(Workspace) then
				Part.Velocity = Network.Velocity
			end
		end
	end)
end

local function ForcePart(v)
	if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
		for _, x in ipairs(v:GetChildren()) do
			if x:IsA("BodyMover") or x:IsA("RocketPropulsion") then
				x:Destroy()
			end
		end
		if v:FindFirstChild("Attachment") then v:FindFirstChild("Attachment"):Destroy() end
		if v:FindFirstChild("AlignPosition") then v:FindFirstChild("AlignPosition"):Destroy() end
		if v:FindFirstChild("Torque") then v:FindFirstChild("Torque"):Destroy() end

		v.CanCollide = false

		local Torque = Instance.new("Torque", v)
		Torque.Torque = Vector3.new(999999999, 999999999, 999999999)
		local AlignPosition = Instance.new("AlignPosition", v)
		local Attachment2 = Instance.new("Attachment", v)
		Torque.Attachment0 = Attachment2

		AlignPosition.MaxForce = math.huge
		AlignPosition.MaxVelocity = math.huge
		AlignPosition.Responsiveness = 100000000
		AlignPosition.Attachment0 = Attachment2
		AlignPosition.Attachment1 = Attachment1
	end
end

local function setUltraCollision(model)
	for _, part in pairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CustomPhysicalProperties = PhysicalProperties.new(1000, 0.3, 0, 1000, 1000)
			part.CanCollide = true
			part.Massless = false
		end
	end
end

local function getTruckModel()
	for _, v in pairs(Workspace:GetChildren()) do
		if v:IsA("Model") and v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer and v.Name:lower():find("semi") then
			return v
		end
	end
	return nil
end

local function flingTruck(model)
	if not model.PrimaryPart then
		model.PrimaryPart = model:FindFirstChildWhichIsA("BasePart")
		if not model.PrimaryPart then return end
	end

	setUltraCollision(model)

	for _, part in pairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			part:SetNetworkOwner(nil)
			part.Anchored = false
		end
	end

	task.spawn(function()
		while getgenv().Enabled and model and model.Parent do
			local direction = (humanoidRootPart.Position - model.PrimaryPart.Position).Unit
			model.PrimaryPart.AssemblyLinearVelocity = direction * 1500
			RunService.Heartbeat:Wait()
		end
	end)
end


Troll:AddToggle({
	Name = "FLING BURACO NEGRO 999",
	Default = false,
	Callback = function(state)
		getgenv().Enabled = state

		if state then
			-- Loop principal
			task.spawn(function()
				while getgenv().Enabled do
					for _, v in next, Workspace:GetDescendants() do
						ForcePart(v)
					end

					local truck = getTruckModel()
					if truck then
						flingTruck(truck)
					end

					Workspace.DescendantAdded:Connect(function(v)
						if getgenv().Enabled then
							ForcePart(v)
						end
					end)

					while getgenv().Enabled do
						local radius = 7
						local angle = tick() * 10
						local offset = CFrame.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
						Attachment1.WorldCFrame = humanoidRootPart.CFrame * offset
						RunService.RenderStepped:Wait()
					end
				end
			end)
		end
	end
})

local kill = Troll:AddSection({Name = "LAGA SERVER"})


local BombActive = false

Troll:AddToggle({
    Name = "LAG BOMBA",
    Default = false,
    Callback = function(Value)
        if Value then
            BombActive = true

            local Player = game.Players.LocalPlayer
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local RootPart = Character:WaitForChild("HumanoidRootPart")
            local WorkspaceService = game:GetService("Workspace")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Bomb = WorkspaceService:WaitForChild("WorkspaceCom"):WaitForChild("001_CriminalWeapons"):WaitForChild("GiveTools"):WaitForChild("Bomb")

            task.spawn(function()
                while BombActive do
                    if Bomb and RootPart then
                        RootPart.CFrame = Bomb.CFrame
                        fireclickdetector(Bomb.ClickDetector) -- Aciona o ClickDetector da bomba
                        task.wait(0.00001) -- Delay mÃ­nimo para evitar travamentos
                    else
                        task.wait(0.0001) 
                    end
                end
            end)

            task.spawn(function()
                while BombActive do
                    if Bomb and RootPart then
                        local VirtualInputManager = game:GetService("VirtualInputManager")
                        VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, game, 0) 
                        task.wait(1.5)
                        VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, game, 0) 

                        -- Executa o FireServer com o nome do jogador
                        local args = {
                            [1] = "Bomb" .. Player.Name -- Usa o nome do jogador atual
                        }
                        ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Blo1wBomb1sServe1r"):FireServer(unpack(args))
                    end
                    task.wait(1.5) -- Intervalo de 1 segundo para clique e FireServer
                end
            end)
        else
            -- Desativando a funcionalidade
            BombActive = false
        end
    end
})

local kill = Troll:AddSection({Name = "MENU CEU"})

Troll:AddButton({
    Name = "MUDA CEU",
    Description = "COLOCA UMA IMAGEM NO CEU",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local WearShirt = ReplicatedStorage.Remotes.WearShirt
        WearShirt:InvokeServer(98679358331654)

        local args = {{100839513065432}}
        game:GetService("ReplicatedStorage").Remotes.ChangeCharacterBody:InvokeServer(unpack(args))
        
        -- AnimaÃ§Ã£o
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local function LoadTrack(id)
            local newAnim = Instance.new("Animation")
            newAnim.AnimationId = "rbxassetid://" .. tostring(id)
            local newTrack = humanoid:LoadAnimation(newAnim)
            newTrack.Priority = Enum.AnimationPriority.Action4
            newTrack:Play(0.1, 1, 1)
            return newTrack
        end

        local EmoteId = 101852027997337
        LoadTrack(EmoteId)
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "MUDA CEU",
            Text = "MUDA CEU ATIVADO!",
            Duration = 5
        })
    end
})

Troll:AddButton({
    Name = "DESATIVAR",
    Description = "REMOVE IMAGEM DO CEU",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Remote = ReplicatedStorage.Remotes.ResetCharacterAppearance
        pcall(function()
            Remote:FireServer()
        end)

        local player = game.Players.LocalPlayer
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "MUDA CEU",
            Text = "IMAGEM REMOVIDA!",
            Duration = 5
        })
    end
})


local LocalPlayer = game:GetService("Players").LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local backupTables = {
    Vehicles = {},
    Canoes = {},
    Jets = {},
    Helis = {},
    Balls = {}
}

local TeleportCarro = {}
function TeleportCarro:MostrarNotificacao(msg)
    print("Ã°Å¸â€â€ "..msg)
end

local function AntiFlingLoop(name, getFolderFunc)
    local active = false
    task.spawn(function()
        while true do
            if active and LocalPlayer.Character then
                local folder = getFolderFunc()
                if folder then
                    for _, item in ipairs(folder:GetChildren()) do
                        local isMine = false
                        if name == "Vehicles" then
                            for _, seat in ipairs(item:GetDescendants()) do
                                if (seat:IsA("VehicleSeat") or seat:IsA("Seat")) and seat.Occupant and seat.Occupant.Parent == LocalPlayer.Character then
                                    isMine = true
                                    break
                                end
                            end
                        elseif name == "Canoes" then
                            local owner = item:FindFirstChild("Owner")
                            isMine = owner and owner.Value == LocalPlayer
                        elseif name == "Jets" or name == "Helis" then
                            isMine = item.Name == LocalPlayer.Name
                        end
                        if not isMine then
                            table.insert(backupTables[name], item:Clone())
                            item:Destroy()
                        end
                    end
                end
            end
            task.wait(0.03)
        end
    end)
    return function(state)
        active = state
        TeleportCarro:MostrarNotificacao(name.." "..(state and "ativado!" or "desativado!"))
        if not state then
            for _, item in ipairs(backupTables[name]) do
                local parentFolder = getFolderFunc()
                if parentFolder then item.Parent = parentFolder end
            end
            backupTables[name] = {}
        end
    end
end
 
protec:AddSection({
    Name = "MENU ANTI"
})

protec:AddButton({
    Name = "PROTEÇÃO",
    Description = "CRIA UMA PROTEÇÃO CONTRA BUGS/SCRIPT",
    Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        local blacklist = {
            {Name = "water", Class = "Part"},
        }

        local function neutralize(part)
            if part and part:IsA("BasePart") then
                pcall(function()
                    part.Anchored = true
                    part.CanCollide = false
                    part.Massless = true
                    part.Transparency = 1
                    part:ClearAllChildren()
                end)
                pcall(function()
                    part:Destroy()
                end)
            end
        end

        workspace.DescendantAdded:Connect(function(obj)
            for _, rule in ipairs(blacklist) do
                if obj.Name == rule.Name and obj.ClassName == rule.Class then
                    neutralize(obj)
                end
            end
        end)

        for _, obj in ipairs(workspace:GetDescendants()) do
            for _, rule in ipairs(blacklist) do
                if obj.Name == rule.Name and obj.ClassName == rule.Class then
                    neutralize(obj)
                end
            end
        end

        task.spawn(function()
            while task.wait(0.25) do
                for _, rule in ipairs(blacklist) do
                    for _, v in next, getnilinstances() do
                        if v.Name == rule.Name and v.ClassName == rule.Class then
                            neutralize(v)
                        end
                    end
                end
            end
        end)

        LocalPlayer.CharacterAdded:Connect(function(char)
            local hum = char:WaitForChild("Humanoid")
            hum.Touched:Connect(function(hit)
                for _, rule in ipairs(blacklist) do
                    if hit.Name == rule.Name and hit.ClassName == rule.Class then
                        neutralize(hit)
                    end
                end
            end)
        end)
    end
})

protec:AddButton({
	Name = "ANTI ST FULL",
	Callback = function()
		local player = game.Players.LocalPlayer

		if player.Character and player.Character:FindFirstChild("Humanoid") then
			-- Renomeia o Humanoid original
			player.Character.Humanoid.Name = "1"

			-- Clona e renomeia o novo como "Humanoid"
			local clone = player.Character["1"]:Clone()
			clone.Parent = player.Character
			clone.Name = "Humanoid"
			task.wait(0.1)

			-- Remove o antigo
			player.Character["1"]:Destroy()

			-- Atualiza a cÃ¢mera
			workspace.CurrentCamera.CameraSubject = player.Character.Humanoid

			-- Reinicia o Animate (se existir)
			local anim = player.Character:FindFirstChild("Animate")
			if anim then
				anim.Disabled = true
				task.wait(0.1)
				anim.Disabled = false
			end
		end
	end
})


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ðŸ” FunÃ§Ã£o: Remove tools de OUTROS jogadores (mochila e personagem)
local function removerToolsDe(player)
	pcall(function()
		if player:FindFirstChild("Backpack") then
			for _, tool in ipairs(player.Backpack:GetChildren()) do
				if tool:IsA("Tool") then
					tool:Destroy()
				end
			end
		end
		if player.Character then
			for _, obj in ipairs(player.Character:GetChildren()) do
				if obj:IsA("Tool") then
					obj:Destroy()
				end
			end
		end
	end)
end

-- ðŸ” FunÃ§Ã£o: Remove suas prÃ³prias Tools localmente (sem afetar os outros)
local function removerMinhasTools()
	pcall(function()
		if LocalPlayer:FindFirstChild("Backpack") then
			for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
				if tool:IsA("Tool") then
					tool:Destroy()
				end
			end
		end
		if LocalPlayer.Character then
			for _, tool in ipairs(LocalPlayer.Character:GetChildren()) do
				if tool:IsA("Tool") then
					tool:Destroy()
				end
			end
		end
	end)
end


local rodando = false

protec:AddToggle({
	Name = "ANTI TOOL FULL",
	Default = false,
	Callback = function(Value)
		rodando = Value

		if rodando then
			print("ðŸ”’ ANTI TOOL PRO ATIVADO")

			task.spawn(function()
				while rodando do
					task.wait(1)

					-- Remover tools de todos os outros
					for _, player in ipairs(Players:GetPlayers()) do
						if player ~= LocalPlayer then
							removerToolsDe(player)
						end
					end

					-- Remover suas prÃ³prias tools localmente
					removerMinhasTools()
				end
			end)

		else
			print("ðŸ”“ ANTI TOOL PRO DESATIVADO")
		end
	end
})
protec:AddToggle({
    Name = "ANTI FLING CARROS",
    Description = "",
    Default = false,
    Callback = AntiFlingLoop("Vehicles", function()
        return Workspace:FindFirstChild("Vehicles")
    end)
})

protec:AddToggle({
    Name = "ANTI CANOE FLING",
    Description = "",
    Default = false,
    Callback = AntiFlingLoop("Canoes", function()
        local workspaceCom = Workspace:FindFirstChild("WorkspaceCom")
        return workspaceCom and workspaceCom:FindFirstChild("001_CanoeStorage")
    end)
})

protec:AddToggle({
    Name = "ANTI FLING JETS",
    Description = "",
    Default = false,
    Callback = AntiFlingLoop("Jets", function()
        local folder = Workspace:FindFirstChild("WorkspaceCom")
        if folder and folder:FindFirstChild("001_Airport") then
            local storage = folder["001_Airport"]:FindFirstChild("AirportHanger")
            if storage then return storage:FindFirstChild("001_JetStorage") and storage["001_JetStorage"]:FindFirstChild("JetAirport") end
        end
    end)
})

protec:AddToggle({
    Name = "ANTI FLING HELICOPTERO",
    Description = "",
    Default = false,
    Callback = AntiFlingLoop("Helis", function()
        local folder = Workspace:FindFirstChild("WorkspaceCom")
        return folder and folder:FindFirstChild("001_HeliStorage") and folder["001_HeliStorage"]:FindFirstChild("PoliceStationHeli")
    end)
})

protec:AddToggle({
    Name = "ANTI FLING BOLA",
    Description = "",
    Default = false,
    Callback = AntiFlingLoop("Balls", function()
        local folder = Workspace:FindFirstChild("WorkspaceCom")
        return folder and folder:FindFirstChild("001_SoccerBalls")
    end)
})


local antiSitActive = false
protec:AddToggle({
    Name = "ANTI SENTA",
    Description = "",
    Default = false,
    Callback = function(state)
        antiSitActive = state
        TeleportCarro:MostrarNotificacao("Anti Sit "..(state and "ativado!" or "desativado!"))
        task.spawn(function()
            while antiSitActive and LocalPlayer.Character do
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                    if humanoid:GetState() == Enum.HumanoidStateType.Seated then
                        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end
                task.wait(0.05)
            end
            if not antiSitActive then
                local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                end
            end
        end)
    end
})

protec:AddToggle({
    Name = "ANTI-LAG",
    Description = "",
    Default = false,
    Callback = function(state)
        local Players = game:GetService("Players")
        local dedupLock = {}
        local IGNORED_PLAYER

        if not state then return end

        local function marcarIgnorado(player)
            IGNORED_PLAYER = player
        end

        local function isTargetTool(inst)
            return inst:IsA("Tool")
        end

        local function gatherTools(player)
            local found = {}
            local containers = {}
            if player.Character then table.insert(containers, player.Character) end
            local backpack = player:FindFirstChildOfClass("Backpack")
            if backpack then table.insert(containers, backpack) end
            local sg = player:FindFirstChild("StarterGear")
            if sg then table.insert(containers, sg) end
            for _, container in ipairs(containers) do
                for _, child in ipairs(container:GetChildren()) do
                    if isTargetTool(child) then table.insert(found, child) end
                end
            end
            return found
        end

        local function dedupePlayer(player)
            if player == IGNORED_PLAYER then return end
            if dedupLock[player] then return end
            dedupLock[player] = true
            local tools = gatherTools(player)
            if #tools > 1 then
                for i = 2, #tools do pcall(function() tools[i]:Destroy() end) end
            end
            dedupLock[player] = false
        end

        local function hookPlayer(player)
            if not IGNORED_PLAYER then marcarIgnorado(player) end
            task.defer(dedupePlayer, player)
            local function setupChar(char)
                task.delay(0.5, function() dedupePlayer(player) end)
                char.ChildAdded:Connect(function(child)
                    if isTargetTool(child) then task.delay(0.1, function() dedupePlayer(player) end) end
                end)
            end
            if player.Character then setupChar(player.Character) end
            player.CharacterAdded:Connect(setupChar)
            local backpack = player:WaitForChild("Backpack", 10)
            if backpack then
                backpack.ChildAdded:Connect(function(child)
                    if isTargetTool(child) then task.delay(0.1, function() dedupePlayer(player) end) end
                end)
            end
            local sg = player:FindFirstChild("StarterGear") or player:WaitForChild("StarterGear", 10)
            if sg then
                sg.ChildAdded:Connect(function(child)
                    if isTargetTool(child) then task.delay(0.1, function() dedupePlayer(player) end) end
                end)
            end
        end

        Players.PlayerAdded:Connect(hookPlayer)
        for _, plr in ipairs(Players:GetPlayers()) do hookPlayer(plr) end

        task.spawn(function()
            while state do
                for _, plr in ipairs(Players:GetPlayers()) do dedupePlayer(plr) end
                task.wait(2)
            end
        end)
    end
})

protec:AddToggle({
    Name = "ANTI FLING PORTAS",
    Description = "",
    Default = false,
    Callback = function(state)
        if not _G.hiddenDoors then _G.hiddenDoors = {} end
        if state then
            _G.hiddenDoors = {}
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name:lower():find("door") then
                    local doorData = {
                        door = obj,
                        originalTransparency = obj.Transparency,
                        originalCanCollide = obj.CanCollide,
                        originalCastShadow = obj.CastShadow
                    }
                    obj.Transparency = 1
                    obj.CanCollide = false
                    obj.CastShadow = false
                    for _, child in ipairs(obj:GetChildren()) do
                        if child:IsA("BasePart") then
                            child.Transparency = 1
                            child.CanCollide = false
                        elseif child:IsA("SurfaceGui") or child:IsA("BillboardGui") then
                            child.Enabled = false
                        end
                    end
                    table.insert(_G.hiddenDoors, doorData)
                end
            end
            print("Ã°Å¸â€Â§ " .. #_G.hiddenDoors .. " portas escondidas!")
        else
            for _, doorData in ipairs(_G.hiddenDoors or {}) do
                if doorData.door and doorData.door.Parent then
                    doorData.door.Transparency = doorData.originalTransparency
                    doorData.door.CanCollide = doorData.originalCanCollide
                    doorData.door.CastShadow = doorData.originalCastShadow
                    for _, child in ipairs(doorData.door:GetChildren()) do
                        if child:IsA("BasePart") then
                            child.Transparency = 0
                            child.CanCollide = true
                        elseif child:IsA("SurfaceGui") or child:IsA("BillboardGui") then
                            child.Enabled = true
                        end
                    end
                end
            end
            print("Ã¢Å“â€¦ " .. #(_G.hiddenDoors or {}) .. " portas restauradas com funcionalidade!")
            _G.hiddenDoors = {}
        end
    end
})


local isHouseRGBActive = false

local colors = {
    Color3.new(1, 0, 0),       -- Vermelho
    Color3.new(0, 1, 0),       -- Verde
    Color3.new(0, 0, 1),       -- Azul
    Color3.new(1, 1, 0),       -- Amarelo
    Color3.new(0, 1, 1),       -- Ciano
    Color3.new(1, 0, 1)        -- Magenta
}

local function changeColor()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local remoteEvent = replicatedStorage:FindFirstChild("RE") and replicatedStorage.RE:FindFirstChild("1Player1sHous1e")

    if not remoteEvent then
        warn("RemoteEvent '1Player1sHous1e' nÃ£o encontrado.")
        return
    end

    while isHouseRGBActive do
        for _, color in ipairs(colors) do
            if not isHouseRGBActive then return end
            local args = {
                [1] = "ColorPickHouse",
                [2] = color
            }
            pcall(function()
                remoteEvent:FireServer(unpack(args))
            end)
            task.wait(0.8)
        end
    end
end

local function toggleHouseRGB(state)
    isHouseRGBActive = state
    if isHouseRGBActive then
        print("Casa RGB Ativada")
        spawn(changeColor)
    else
        print("Casa RGB Desativada")
    end
end

-- Agora sim, corretamente:
Tabcasa:AddToggle({
    Name = "CASA RGB",
    Default = false,
    Callback = function(state)
        toggleHouseRGB(state)
    end
})

Tabcasa:AddButton({
    Name = "UNBAN",
    Callback = function()
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local houseModel = nil

        -- 1. Remove a barreira vermelha (bloqueio local)
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") and obj.Transparency > 0.5 and obj.Size.X > 20 and obj.Size.Y > 20 and obj.Size.Z > 20 then
                if tostring(obj.BrickColor):lower():find("red") or tostring(obj.Color):lower():find("255") then
                    obj.CanCollide = false
                    obj.Transparency = 1
                    obj.Material = Enum.Material.SmoothPlastic
                end
            end
        end

        -- 2. Procura a casa e tenta aplicar unban
        local lots = workspace:FindFirstChild("001_Lots")
        if lots then
            for _, v in pairs(lots:GetDescendants()) do
                if v.Name == "Permissions" and v:IsA("Folder") then
                    if v:FindFirstChild("Allow") then
                        houseModel = v
                        break
                    end
                end
            end
        end

        -- 3. Envia unban
        if houseModel then
            local allowRemote = houseModel:FindFirstChild("Allow")
            if allowRemote and allowRemote:IsA("RemoteEvent") then
                allowRemote:FireServer(player)
                print("Unban enviado com sucesso!")
            else
                warn("Remote 'Allow' nÃ£o encontrado.")
            end
        else
            warn("Nenhuma casa com sistema 'Permissions' encontrada.")
        end
    end
})


Tabcasa:AddSection({ Name = "TROLL CASA" })

local isUnbanActive = false
local SelectHouse = nil
local NoclipDoor = nil
local HouseDropdown = nil -- 👈 só adicionamos isso

-- Função para obter lista de casas
local function getHouseList()
    local Tabela = {}
    local lots = workspace:FindFirstChild("001_Lots")
    if lots then
        for _, House in ipairs(lots:GetChildren()) do
            if House.Name ~= "For Sale" and House:IsA("Model") then
                table.insert(Tabela, House.Name)
            end
        end
    end
    return Tabela
end

-- Dropdown para selecionar casas
pcall(function()
    HouseDropdown = Tabcasa:AddDropdown({ -- 👈 só mudamos aqui
        Name = "SELECIONE A CASA",
        Options = getHouseList(),
        Default = "...",
        Callback = function(Value)
            SelectHouse = Value
            if NoclipDoor then
                NoclipDoor:Set(false)
            end
            print("Casa selecionada: " .. tostring(Value))
        end
    })
end)

-- Função para atualizar a lista de casas (FIX)
local function DropdownHouseUpdate()
    local Tabela = getHouseList()
    print("DropdownHouseUpdate called. Houses found:", #Tabela)

    pcall(function()
        if HouseDropdown then
            HouseDropdown.Options = Tabela

            if HouseDropdown.Refresh then
                HouseDropdown:Refresh(Tabela, true)
            elseif HouseDropdown.Set then
                HouseDropdown:Set(Tabela)
            end
        end
    end)
end

-- Inicializar dropdown (mantido)
pcall(DropdownHouseUpdate)

-- Botão para atualizar lista de casas
pcall(function()
    Tabcasa:AddButton({
        Name = "ATUALIZAR LISTA DE CASAS",
        Callback = function()
            print("Atualizar Lista de Casas button clicked.")
            pcall(DropdownHouseUpdate)
        end
    })
end)

-- BotÃ£o para teleportar para casa
pcall(function()
    Tabcasa:AddButton({
        Name = "TELEPORTAR PARA CASA",
        Callback = function()
            local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
            if House and game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(House.WorldPivot.Position)
            else
                print("Casa nÃ£o encontrada: " .. tostring(SelectHouse))
            end
        end
    })
end)

-- BotÃ£o para teleportar para cofre
pcall(function()
    Tabcasa:AddButton({
        Name = "Teleportar para Cofre",
        Callback = function()
            local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
            if House and House:FindFirstChild("HousePickedByPlayer") and game.Players.LocalPlayer.Character then
                local safe = House.HousePickedByPlayer.HouseModel:FindFirstChild("001_Safe")
                if safe then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(safe.WorldPivot.Position)
                else
                    print("Cofre nÃ£o encontrado na casa: " .. tostring(SelectHouse))
                end
            else
                print("Casa nÃ£o encontrada: " .. tostring(SelectHouse))
            end
        end
    })
end)

-- Toggle para atravessar porta
pcall(function()
    NoclipDoor = Tabcasa:AddToggle({
        Name = "ATRAVESSAR PORTA DAS CASA",
        Description = "",
        Default = false,
        Callback = function(Value)
            pcall(function()
                local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
                if House and House:FindFirstChild("HousePickedByPlayer") then
                    local housepickedbyplayer = House.HousePickedByPlayer
                    local doors = housepickedbyplayer.HouseModel:FindFirstChild("001_HouseDoors")
                    if doors and doors:FindFirstChild("HouseDoorFront") then
                        for _, Base in ipairs(doors.HouseDoorFront:GetChildren()) do
                            if Base:IsA("BasePart") then
                                Base.CanCollide = not Value
                            end
                        end
                    end
                end
            end)
        end
    })
end)

-- Toggle para tocar campainha
pcall(function()
    Tabcasa:AddToggle({
        Name = "TOCAR CAMPAINHA",
        Description = "",
        Default = false,
        Callback = function(Value)
            getgenv().ChaosHubAutoSpawnDoorbellValue = Value
            spawn(function()
                while getgenv().ChaosHubAutoSpawnDoorbellValue do
                    local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
                    if House and House:FindFirstChild("HousePickedByPlayer") then
                        local doorbell = House.HousePickedByPlayer.HouseModel:FindFirstChild("001_DoorBell")
                        if doorbell and doorbell:FindFirstChild("TouchBell") then
                            pcall(function()
                                fireclickdetector(doorbell.TouchBell.ClickDetector)
                            end)
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    })
end)

-- Toggle para bater na porta
pcall(function()
    Tabcasa:AddToggle({
        Name = "BATER NA PORTA",
        Description = "",
        Default = false,
        Callback = function(Value)
            getgenv().ChaosHubAutoSpawnDoorValue = Value
            spawn(function()
                while getgenv().ChaosHubAutoSpawnDoorValue do
                    local House = workspace["001_Lots"]:FindFirstChild(tostring(SelectHouse))
                    if House and House:FindFirstChild("HousePickedByPlayer") then
                        local doors = House.HousePickedByPlayer.HouseModel:FindFirstChild("001_HouseDoors")
                        if doors and doors:FindFirstChild("HouseDoorFront") and doors.HouseDoorFront:FindFirstChild("Knock") then
                            pcall(function()
                                fireclickdetector(doors.HouseDoorFront.Knock.TouchBell.ClickDetector)
                            end)
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    })
end)
pcall(function()
    Tabcasa:AddSection({ Name = "TELEPORTE PARA CASAS" })
end)

-- Lista de casas para teletransporte
local casas = {
    ["Casa 1"] = Vector3.new(260.29, 4.37, 209.32),
    ["Casa 2"] = Vector3.new(234.49, 4.37, 228.00),
    ["Casa 3"] = Vector3.new(262.79, 21.37, 210.84),
    ["Casa 4"] = Vector3.new(229.60, 21.37, 225.40),
    ["Casa 5"] = Vector3.new(173.44, 21.37, 228.11),
    ["Casa 6"] = Vector3.new(-43, 21, -137),
    ["Casa 7"] = Vector3.new(-40, 36, -137),
    ["Casa 11"] = Vector3.new(-21, 40, 436),
    ["Casa 12"] = Vector3.new(155, 37, 433),
    ["Casa 13"] = Vector3.new(255, 35, 431),
    ["Casa 14"] = Vector3.new(254, 38, 394),
    ["Casa 15"] = Vector3.new(148, 39, 387),
    ["Casa 16"] = Vector3.new(-17, 42, 395),
    ["Casa 17"] = Vector3.new(-189, 37, -247),
    ["Casa 18"] = Vector3.new(-354, 37, -244),
    ["Casa 19"] = Vector3.new(-456, 36, -245),
    ["Casa 20"] = Vector3.new(-453, 38, -295),
    ["Casa 21"] = Vector3.new(-356, 38, -294),
    ["Casa 22"] = Vector3.new(-187, 37, -295),
    ["Casa 23"] = Vector3.new(-410, 68, -447),
    ["Casa 24"] = Vector3.new(-348, 69, -496),
    ["Casa 28"] = Vector3.new(-103, 12, 1087),
    ["Casa 29"] = Vector3.new(-730, 6, 808),
    ["Casa 30"] = Vector3.new(-245, 7, 822),
    ["Casa 31"] = Vector3.new(639, 76, -361),
    ["Casa 32"] = Vector3.new(-908, 6, -361),
    ["Casa 33"] = Vector3.new(-111, 70, -417),
    ["Casa 34"] = Vector3.new(230, 38, 569),
    ["Casa 35"] = Vector3.new(-30, 13, 2209)
}

-- Criar lista de nomes de casas ordenada
local casasNomes = {}
for nome, _ in pairs(casas) do
    table.insert(casasNomes, nome)
end

table.sort(casasNomes, function(a, b)
    local numA = tonumber(a:match("%d+")) or 0
    local numB = tonumber(b:match("%d+")) or 0
    return numA < numB
end)

-- Dropdown para teletransporte
pcall(function()
    Tabcasa:AddDropdown({
        Name = "Selecionar Casa",
        Options = casasNomes,
        Callback = function(casaSelecionada)
            local player = game.Players.LocalPlayer
            if player and player.Character then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(casas[casaSelecionada])
            end
        end
    })
end)





local teleportButtons = {
    {"TP BASTIDORES", CFrame.new(192, 4, 272)},
    {"TP CENTRO URBANO", CFrame.new(136, 4, 117)},
    {"TP AREA DO CRIME", CFrame.new(-119, -28, 235)},
    {"TP CASA DESERTA", CFrame.new(986, 4, 63)},
    {"TP", CFrame.new(672, 4, -296)},
    {"TP ESCONDERIJO", CFrame.new(505, -75, 143)},
    {"TP ESCOLA", CFrame.new(-312, 4, 211)},
    {"TP", CFrame.new(161, 8, 52)},
    {"TO PONTO INICIAL", CFrame.new(-26, 4, -23)},
    {"TP ARCO PRINCIPAL", CFrame.new(-589, 141, -59)},
    {"TP HOSPITAL", CFrame.new(-309, 4, 71)},
    {"TP", CFrame.new(179, 4, -464)},
    {"TP SALA OCULTA DA OFICINA", CFrame.new(0, 4, -495)},
    {"TP SALA SECRETA 2", CFrame.new(-343, 4, -613)},
    {"TP ILHA ISOLADA", CFrame.new(-1925, 23, 127)},
    {"TP", CFrame.new(182, 4, 150)},
    {"TP ESCALAR MONTANHA 1", CFrame.new(-670, 251, 765)},
    {"TP BANCO PRINCIPAL", CFrame.new(2.28, 4.65, 254.58)},
    {"TP LOJA DE ROUPAS", CFrame.new(-46.15, 4.65, 253.20)},
    {"TP", CFrame.new(-88.48, 22.05, 262.34)},
    {"TP", CFrame.new(-53.58, 22.15, 265.61)},
    {"TP CAFETERIA", CFrame.new(-97.12, 4.65, 254.99)}
}

for _, btn in ipairs(teleportButtons) do
    Tab:AddButton({
        btn[1],
        function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = btn[2]
        end
    })
end

CarTab:AddButton({
    Name = "FLY CAR",
    Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/RtliHFjP/raw"))()
    end
})


CarTab:AddButton({
    Name = "REMOVE TODOS CARROS",
    Callback = function()
        local ofnawufn = false

if ofnawufn == true then
    return
end
ofnawufn = true

local cawwfer = "MilitaryBoatFree" -- Alterado para MilitaryBoatFree
local oldcfffff = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1754, -2, 58) -- Coordenadas atualizadas
wait(0.3)

local args = {
    [1] = "PickingBoat", -- Alterado para PickingBoat
    [2] = cawwfer
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
wait(1)

local wrinfjn
for _, errb in pairs(game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"]:GetDescendants()) do
    if errb:IsA("VehicleSeat") then
        wrinfjn = errb
    end
end

repeat
    if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
        if not game.Players.LocalPlayer.Character.Humanoid.SeatPart == wrinfjn then
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
    end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = wrinfjn.CFrame
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = wrinfjn.CFrame + Vector3.new(0,1,0)
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = wrinfjn.CFrame + Vector3.new(0,-1,0)
    task.wait()
until game.Players.LocalPlayer.Character.Humanoid.SeatPart == wrinfjn

for _, wifn in pairs(game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"]:GetDescendants()) do
    if wifn.Name == "PhysicalWheel" then
        wifn:Destroy()
    end
end

local FLINGED = Instance.new("BodyThrust", game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass) 
FLINGED.Force = Vector3.new(50000, 0, 50000) 
FLINGED.Name = "SUNTERIUM HUB FLING"
FLINGED.Location = game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.Position

for _, wvwvwasc in pairs(game.workspace.Vehicles:GetChildren()) do
    for _, ascegr in pairs(wvwvwasc:GetDescendants()) do
        if ascegr.Name == "VehicleSeat" then
            local targetcar = ascegr
            local tet = Instance.new("BodyVelocity", game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass)
            tet.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            tet.P = 1250
            tet.Velocity = Vector3.new(0,0,0)
            tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
            for m=1,25 do
                local pos = {x=0, y=0, z=0}
                pos.x = targetcar.Position.X
                pos.y = targetcar.Position.Y
                pos.z = targetcar.Position.Z
                pos.x = pos.x + targetcar.Velocity.X / 2
                pos.y = pos.y + targetcar.Velocity.Y / 2
                pos.z = pos.z + targetcar.Velocity.Z / 2
                if pos.y <= -200 then
                    game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(0,1000,0)
                else
                    game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z))
                    task.wait()
                    game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) + Vector3.new(0,-2,0)
                    task.wait()
                    game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) * CFrame.new(0,0,2)
                    task.wait()
                    game.workspace.Vehicles[
game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) * CFrame.new(2,0,0)
                    task.wait()
                end
                task.wait()
            end
        end
    end
end

task.wait()
local args = {
    [1] = "DeleteAllVehicles"
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
game.Players.LocalPlayer.Character.Humanoid.Sit = false
wait()
local tet = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
tet.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
tet.P = 1250
tet.Velocity = Vector3.new(0,0,0)
tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
wait(0.1)
for m=1,2 do 
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcfffff
end
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcfffff
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"):Destroy()
wait(0.2)
ofnawufn = false
    end
})


CarTab:AddToggle({
    Name = "CARRO RGB",
    Default = false,
    Callback = function(Value)
        isColorChanging = Value

        if isColorChanging then
            colorChangeCoroutine = coroutine.create(function()
                while isColorChanging do
                    for _, color in ipairs(colors) do
                        if not isColorChanging then return end
                        local args = {
                            [1] = "PickingCarColor",
                            [2] = color
                        }
                        remoteEvent:FireServer(unpack(args))
                        wait(1)
                    end
                end
            end)
            coroutine.resume(colorChangeCoroutine)
        end
    end
})

-- Cores RGB
local colors = {
    Color3.new(1, 0, 0),     -- Vermelho
    Color3.new(0, 1, 0),     -- Verde
    Color3.new(0, 0, 1),     -- Azul
    Color3.new(1, 1, 0),     -- Amarelo
    Color3.new(1, 0, 1),     -- Magenta
    Color3.new(0, 1, 1),     -- Ciano
    Color3.new(0.5, 0, 0.5), -- Roxo
    Color3.new(1, 0.5, 0)    -- Laranja
}

-- ServiÃ§o e RemoteEvent
local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvent = replicatedStorage:WaitForChild("RE"):WaitForChild("1Player1sCa1r")


CarTab:AddSection({ Name = "SPAWNA VEÍCULOS" })

CarTab:AddButton({
    Name = "AUTO SPAW CAMINHÃO",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/C7sxJQKz"))()
    end
})



Tabconfg:AddSection({ Name = "CONFIG" })

Tabconfg:AddTextBox({
    Name = "ENTRAR NO SERVIDOR",
    PlaceholderText = "DIGITE O ID DO SERVIDOR",
    Callback = function(serverId)
        if typeof(serverId) == "string" and serverId ~= "" then
            local TeleportService = game:GetService("TeleportService")
            local placeId = game.PlaceId

            TeleportService:TeleportToPlaceInstance(placeId, serverId, game.Players.LocalPlayer)
        else
            warn("ID do servidor invÃ¡lido.")
        end
    end
})

Tabconfg:AddButton({
    Name = "COPIAR ID DO SERVIDOR",
    Callback = function()
        local serverId = tostring(game.JobId or "")
        if setclipboard then
            setclipboard(serverId)
        end
    end
})

Tabconfg:AddButton({
    Name = "SHIFT LOK",
    Callback = function()
        local shiftlockk = Instance.new("ScreenGui")
local LockButton = Instance.new("ImageButton")
local btnIcon = Instance.new("ImageLabel")
local buttonEffect = Instance.new("UICorner")
local buttonStroke = Instance.new("UIStroke")
local closeButton = Instance.new("TextButton")
local closeEffect = Instance.new("UICorner")
local closeStroke = Instance.new("UIStroke")

function protectUI(sGui)
    local function blankfunction(...)
        return ...
    end
    local cloneref = cloneref or blankfunction
    local function SafeGetService(service)
        return cloneref(game:GetService(service)) or game:GetService(service)
    end
    local cGUI = SafeGetService("CoreGui")
    local rPlr = SafeGetService("Players"):FindFirstChildWhichIsA("Player")
    local cGUIProtect = {}
    local rService = SafeGetService("RunService")
    local lPlr = SafeGetService("Players").LocalPlayer
    local function NAProtection(inst, var)
        if inst then
            if var then
                inst[var] = "\0"
                inst.Archivable = false
            else
                inst.Name = "\0"
                inst.Archivable = false
            end
        end
    end
    if (get_hidden_gui or gethui) then
        local hiddenUI = (get_hidden_gui or gethui)
        NAProtection(sGui)
        sGui.Parent = hiddenUI()
        return sGui
    elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
        NAProtection(sGui)
        syn.protect_gui(sGui)
        sGui.Parent = cGUI
        return sGui
    elseif cGUI:FindFirstChildWhichIsA("ScreenGui") then
        pcall(function()
            for _, v in pairs(sGui:GetDescendants()) do
                cGUIProtect[v] = rPlr.Name
            end
            sGui.DescendantAdded:Connect(function(v)
                cGUIProtect[v] = rPlr.Name
            end)
            cGUIProtect[sGui] = rPlr.Name
            local meta = getrawmetatable(game)
            local tostr = meta.__tostring
            setreadonly(meta, false)
            meta.__tostring = newcclosure(function(t)
                if cGUIProtect[t] and not checkcaller() then
                    return cGUIProtect[t]
                end
                return tostr(t)
            end)
        end)
        if not rService:IsStudio() then
            local newGui = cGUI:FindFirstChildWhichIsA("ScreenGui")
            newGui.DescendantAdded:Connect(function(v)
                cGUIProtect[v] = rPlr.Name
            end)
            for _, v in pairs(sGui:GetChildren()) do
                v.Parent = newGui
            end
            sGui = newGui
        end
        return sGui
    elseif cGUI then
        NAProtection(sGui)
        sGui.Parent = cGUI
        return sGui
    elseif lPlr and lPlr:FindFirstChild("PlayerGui") then
        NAProtection(sGui)
        sGui.Parent = lPlr:FindFirstChild("PlayerGui")
        return sGui
    else
        return nil
    end
end

shiftlockk.Name = "shiftlockk"
protectUI(shiftlockk)
shiftlockk.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
shiftlockk.ResetOnSpawn = false
shiftlockk.DisplayOrder = 69

LockButton.Name = "LockButton"
LockButton.Parent = shiftlockk
LockButton.AnchorPoint = Vector2.new(0.5, 0.5)
LockButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
LockButton.BackgroundTransparency = 0.3
LockButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
LockButton.BorderSizePixel = 0
LockButton.Position = UDim2.new(0.785148501, 0, 0.865914762, 0)
LockButton.Size = UDim2.new(0, 65, 0, 65)
LockButton.ZIndex = 3
LockButton.Image = ""
LockButton.AutoButtonColor = true

buttonEffect.Parent = LockButton
buttonEffect.CornerRadius = UDim.new(1, 0)

buttonStroke.Parent = LockButton
buttonStroke.Color = Color3.fromRGB(0,255,0)
buttonStroke.Thickness = 2
buttonStroke.Transparency = 0.3

btnIcon.Name = "btnIcon"
btnIcon.Parent = LockButton
btnIcon.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
btnIcon.BackgroundTransparency = 1
btnIcon.Position = UDim2.new(0.15, 0, 0.15, 0)
btnIcon.Size = UDim2.new(0.7, 0, 0.7, 0)
btnIcon.ZIndex = 3
btnIcon.Image = "rbxasset://textures/ui/mouseLock_off.png"
btnIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
btnIcon.ScaleType = Enum.ScaleType.Fit

closeButton.Name = "CloseButton"
closeButton.Parent = LockButton
closeButton.AnchorPoint = Vector2.new(1, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BackgroundTransparency = 0.3
closeButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
closeButton.BorderSizePixel = 0
closeButton.Position = UDim2.new(1, 0, 0, -5)
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.ZIndex = 4
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.SourceSans
closeButton.AutoButtonColor = true

closeEffect.Parent = closeButton
closeEffect.CornerRadius = UDim.new(0.5, 0)

closeStroke.Parent = closeButton
closeStroke.Color = Color3.fromRGB(255, 255, 255)
closeStroke.Thickness = 1
closeStroke.Transparency = 0.3

local tweenService = game:GetService("TweenService")
local hoverInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local clickInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local defaultProps = {
    BackgroundTransparency = 0.3,
    Size = UDim2.new(0, 65, 0, 65)
}

local hoverProps = {
    BackgroundTransparency = 0.1,
    Size = UDim2.new(0, 70, 0, 70)
}

local clickProps = {
    BackgroundTransparency = 0,
    Size = UDim2.new(0, 60, 0, 60)
}

local defaultTween = tweenService:Create(LockButton, hoverInfo, defaultProps)
local hoverTween = tweenService:Create(LockButton, hoverInfo, hoverProps)
local clickTween = tweenService:Create(LockButton, clickInfo, clickProps)

LockButton.MouseEnter:Connect(function()
    hoverTween:Play()
end)

LockButton.MouseLeave:Connect(function()
    defaultTween:Play()
end)

LockButton.MouseButton1Down:Connect(function()
    clickTween:Play()
end)

LockButton.MouseButton1Up:Connect(function()
    hoverTween:Play()
end)

NAdrag = function(ui, dragui)
    if not dragui then dragui = ui end
    local UserInputService = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos
    local function update(input)
        local delta = input.Position - dragStart
        local newXOffset = startPos.X.Offset + delta.X
        local newYOffset = startPos.Y.Offset + delta.Y
        local screenSize = ui.Parent.AbsoluteSize
        local newXScale = startPos.X.Scale + (newXOffset / screenSize.X)
        local newYScale = startPos.Y.Scale + (newYOffset / screenSize.Y)
        ui.Position = UDim2.new(newXScale, 0, newYScale, 0)
    end
    dragui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = ui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    dragui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    ui.Active = true
end

NAdrag(LockButton)

local function YDYMLAX_fake_script()
    local script = Instance.new('LocalScript', LockButton)
    local Input = game:GetService("UserInputService")
    local V = false
    local main = script.Parent
    local buttonStroke = main:FindFirstChildOfClass("UIStroke")
    main.MouseButton1Click:Connect(function()
        V = not V
        if V then
            main.btnIcon.ImageColor3 = Color3.fromRGB(0, 170, 255)
            buttonStroke.Color = Color3.fromRGB(0, 170, 255)
            buttonStroke.Thickness = 3
            spawn(function()
                while V do
                    for i = 0.3, 0.7, 0.1 do
                        if not V then break end
                        buttonStroke.Transparency = i
                        wait(0.1)
                    end
                    for i = 0.7, 0.3, -0.1 do
                        if not V then break end
                        buttonStroke.Transparency = i
                        wait(0.1)
                    end
                end
            end)
            ForceShiftLock()
        else
            main.btnIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            buttonStroke.Color = Color3.fromRGB(0,255,0)
            buttonStroke.Thickness = 2
            buttonStroke.Transparency = 0.3
            EndForceShiftLock()
        end
    end)
    if closeButton then
        closeButton.MouseButton1Click:Connect(function()
            if V then
                EndForceShiftLock()
                V = false
            end
            shiftlockk:Destroy()
        end)
    end
    local g = nil
    local GameSettings = UserSettings():GetService("UserGameSettings")
    local J = nil
    function ForceShiftLock()
        local i, k = pcall(function()
            return GameSettings.RotationType
        end)
        _ = i
        g = k
        J = game:GetService("RunService").RenderStepped:Connect(function()
            pcall(function()
                GameSettings.RotationType = Enum.RotationType.CameraRelative
            end)
        end)
    end
    function EndForceShiftLock()
        if J then
            pcall(function()
                GameSettings.RotationType = g or Enum.RotationType.MovementRelative
            end)
            J:Disconnect()
        end
    end
end
coroutine.wrap(YDYMLAX_fake_script)()
    end,
})

Tabconfg:AddSection({ Name = "CONFIG FPS" })

Tabconfg:AddButton({
    Name = "REMOVE VEÍCULOS",
    Callback = function()
    loadstring(game:HttpGet("https://pastefy.app/O61LTl9E/raw"))()
    end
})

Tabconfg:AddButton({
    Name = "TEXTURA ACESSÓRIOS",
    Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/uZEMYqPR"))()
    end
})

Tabconfg:AddButton({
    Name = "TEXTURA",
    Callback = function()
    loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Low-Gfx-4650"))()
    end
})

Tabconfg:AddButton({
    Name = "GRÁFICOS",
    Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/RUr10TJ0"))()
    end
})

-- ========== FOTO DO SEU PERSONAGEM NA ABA STATUS ==========

-- Container da foto
local fotoContainer = Instance.new("Frame")
fotoContainer.Size = UDim2.new(1, 0, 0, 60)
fotoContainer.Position = UDim2.new(0, 0, 0, 5)
fotoContainer.BackgroundTransparency = 1
fotoContainer.Parent = Tabstatus.Cont

-- Sua foto
local foto = Instance.new("ImageLabel")
foto.Size = UDim2.new(0, 50, 0, 50)
foto.Position = UDim2.new(0, 10, 0.5, -25)
foto.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
foto.BackgroundTransparency = 0
foto.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=420&height=420&format=png"
foto.Parent = fotoContainer

-- Deixar redonda
local redondo = Instance.new("UICorner")
redondo.CornerRadius = UDim.new(1, 0)
redondo.Parent = foto

-- Borda roxa na foto
local bordaRoxa = Instance.new("UIStroke")
bordaRoxa.Thickness = 2
bordaRoxa.Color = Color3.fromRGB(155, 48, 255)
bordaRoxa.Parent = foto

-- Seu nome do lado da foto
local nomeLabel = Instance.new("TextLabel")
nomeLabel.Size = UDim2.new(0, 150, 0, 50)
nomeLabel.Position = UDim2.new(0, 70, 0.5, -25)
nomeLabel.Text = game.Players.LocalPlayer.Name
nomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nomeLabel.BackgroundTransparency = 1
nomeLabel.Font = Enum.Font.GothamBold
nomeLabel.TextSize = 14
nomeLabel.TextXAlignment = Enum.TextXAlignment.Left
nomeLabel.Parent = fotoContainer
