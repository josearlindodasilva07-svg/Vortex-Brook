Libary = loadstring(game:HttpGet("https://pastefy.app/TYVuPNOS/raw"))()
workspace.FallenPartsDestroyHeight = -math.huge

local Janela = Libary:MakeWindow({
    Title = "VORTEX HUB",
    SubTitle = "VORTEX HUB",
    LoadText = "CARREGANDO VORTEX...",
    Flags = "vortexhub_Broookhaven"
})

Janela:AddMinimizeButton({
    Button = {
        Image = "rbxassetid://ID IMAGEM",
        BackgroundTransparency = 0
    },
    Corner = {
        CornerRadius = UDim.new(35, 1)
    },
})

-- Aba Informações
local AbaInfo = Janela:MakeTab({
    Title = "Informações",
    Icon = "rbxassetid://10723415903"
})

AbaInfo:AddSection({ "Informações do Script" })
AbaInfo:AddParagraph({ "Owner / Desenvolvedor:", "GODENOT" })
AbaInfo:AddParagraph({ "Colaborações:", "GODENOT" })
AbaInfo:AddParagraph({ "Você está usando:", "VORTEX HUB" })
AbaInfo:AddParagraph({"Fonte Desofuscada com Sucesso"})
AbaInfo:AddParagraph({"Novidades:", "Lag com ônibus já está disponível!"})

AbaInfo:AddButton({"VERSÃO EDIT", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wx-sources/spacecomm/refs/heads/main/experimental"))()
end})

AbaInfo:AddSection({ "Reconectar" })
AbaInfo:AddButton({
    Name = "Reconectar",
    Callback = function()
        local ServicoTeleporte = game:GetService("TeleportService")
        ServicoTeleporte:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end
})

-- Aba Scripts Trolls
local AbaTroll = Janela:MakeTab({
    Title = "Scripts Trolls",
    Icon = "rbxassetid://13364900349"
})

AbaTroll:AddSection({ "Buraco Negro" })
AbaTroll:AddButton({
    Name = "Buraco Negro",
    Description = "Ativando isso você puxa objetos até o seu personagem",
    Callback = function()
        local Jogadores = game:GetService("Players")
        local ServicoExecucao = game:GetService("RunService")
        local JogadorLocal = Jogadores.LocalPlayer
        local Mundo = game:GetService("Workspace")
        local angulo = 1
        local raio = 10
        local buracoAtivo = false
        
        local function configurarJogador()
            local personagem = JogadorLocal.Character or JogadorLocal.CharacterAdded:Wait()
            local torso = personagem:WaitForChild("HumanoidRootPart")
            local pasta = Instance.new("Folder", Mundo)
            local parte = Instance.new("Part", pasta)
            local anexo1 = Instance.new("Attachment", parte)
            parte.Anchored = true
            parte.CanCollide = false
            parte.Transparency = 1
            return torso, anexo1
        end
        
        local torso, anexo1 = configurarJogador()
        
        if not getgenv().Rede then
            getgenv().Rede = {
                PartesBase = {},
                Velocidade = Vector3.new(14.46262424, 14.46262424, 14.46262424)
            }
            
            Rede.ReterParte = function(parte)
                if typeof(parte) == "Instance" and parte:IsA("BasePart") and parte:IsDescendantOf(Mundo) then
                    table.insert(Rede.PartesBase, parte)
                    parte.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                    parte.CanCollide = false
                end
            end
            
            local function ativarControlePartes()
                JogadorLocal.ReplicationFocus = Mundo
                ServicoExecucao.Heartbeat:Connect(function()
                    sethiddenproperty(JogadorLocal, "SimulationRadius", math.huge)
                    for _, parte in pairs(Rede.PartesBase) do
                        if parte:IsDescendantOf(Mundo) then
                            parte.Velocity = Rede.Velocidade
                        end
                    end
                end)
            end
            ativarControlePartes()
        end
        
        local function forcarParte(v)
            if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
                for _, x in next, v:GetChildren() do
                    if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                        x:Destroy()
                    end
                end
                if v:FindFirstChild("Attachment") then v:FindFirstChild("Attachment"):Destroy() end
                if v:FindFirstChild("AlignPosition") then v:FindFirstChild("AlignPosition"):Destroy() end
                if v:FindFirstChild("Torque") then v:FindFirstChild("Torque"):Destroy() end
                v.CanCollide = false
                local torque = Instance.new("Torque", v)
                torque.Torque = Vector3.new(1000000, 1000000, 1000000)
                local alinharPosicao = Instance.new("AlignPosition", v)
                local anexo2 = Instance.new("Attachment", v)
                torque.Attachment0 = anexo2
                alinharPosicao.MaxForce = math.huge
                alinharPosicao.MaxVelocity = math.huge
                alinharPosicao.Responsiveness = 500
                alinharPosicao.Attachment0 = anexo2
                alinharPosicao.Attachment1 = anexo1
            end
        end
        
        local function alternarBuracoNegro()
            buracoAtivo = not buracoAtivo
            if buracoAtivo then
                for _, v in next, Mundo:GetDescendants() do
                    forcarParte(v)
                end
                Mundo.DescendantAdded:Connect(function(v)
                    if buracoAtivo then forcarParte(v) end
                end)
                spawn(function()
                    while buracoAtivo and ServicoExecucao.RenderStepped:Wait() do
                        angulo = angulo + math.rad(2)
                        local deslocamentoX = math.cos(angulo) * raio
                        local deslocamentoZ = math.sin(angulo) * raio
                        anexo1.WorldCFrame = torso.CFrame * CFrame.new(deslocamentoX, 0, deslocamentoZ)
                    end
                end)
            else
                anexo1.WorldCFrame = CFrame.new(0, -1000, 0)
            end
        end
        
        JogadorLocal.CharacterAdded:Connect(function()
            torso, anexo1 = configurarJogador()
            if buracoAtivo then alternarBuracoNegro() end
        end)
        
        local biblioteca = loadstring(game:HttpGet("https://raw.githubusercontent.com/miroeramaa/TurtleLib/main/TurtleUiLib.lua"))()
        local janela = biblioteca:Window("Projeto VORTEX")
        janela:Slider("Raio do Buraco Negro", 1, 100, 10, function(valor) raio = valor end)
        janela:Toggle("Buraco Negro", true, function(valor)
            if valor then alternarBuracoNegro() else buracoAtivo = false end
        end)
        
        spawn(function()
            while true do
                ServicoExecucao.RenderStepped:Wait()
                if buracoAtivo then angulo = angulo + math.rad(2) end
            end
        end)
        
        alternarBuracoNegro()
    end
})

AbaTroll:AddSection({ "Puxar Objetos" })
AbaTroll:AddButton({
    Name = "Puxar Objetos",
    Description = "Para usar, chegue perto do Jogador Selecionado",
    Callback = function()
        local Gui = Instance.new("ScreenGui")
        local Principal = Instance.new("Frame")
        local CaixaTexto = Instance.new("TextBox")
        local RestricaoTexto = Instance.new("UITextSizeConstraint")
        local Label = Instance.new("TextLabel")
        local RestricaoTexto2 = Instance.new("UITextSizeConstraint")
        local Botao = Instance.new("TextButton")
        local RestricaoTexto3 = Instance.new("UITextSizeConstraint")
        
        Gui.Name = "Gui"
        Gui.Parent = gethui()
        Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        Principal.Name = "Principal"
        Principal.Parent = Gui
        Principal.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
        Principal.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Principal.BorderSizePixel = 0
        Principal.Position = UDim2.new(0.335954279, 0, 0.542361975, 0)
        Principal.Size = UDim2.new(0.240350261, 0, 0.166880623, 0)
        Principal.Active = true
        Principal.Draggable = true
        
        CaixaTexto.Name = "CaixaTexto"
        CaixaTexto.Parent = Principal
        CaixaTexto.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
        CaixaTexto.BorderColor3 = Color3.fromRGB(0, 0, 0)
        CaixaTexto.BorderSizePixel = 0
        CaixaTexto.Position = UDim2.new(0.0980926454, 0, 0.218712583, 0)
        CaixaTexto.Size = UDim2.new(0.801089942, 0, 0.364963502, 0)
        CaixaTexto.FontFace = Font.new("rbxasset://fonts/families/SourceSansSemibold.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        CaixaTexto.PlaceholderText = "Nome do Jogador"
        CaixaTexto.Text = ""
        CaixaTexto.TextColor3 = Color3.fromRGB(255, 255, 255)
        CaixaTexto.TextScaled = true
        CaixaTexto.TextSize = 31.000
        CaixaTexto.TextWrapped = true
        RestricaoTexto.Parent = CaixaTexto
        RestricaoTexto.MaxTextSize = 31
        
        Label.Name = "Label"
        Label.Parent = Principal
        Label.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
        Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Label.BorderSizePixel = 0
        Label.Size = UDim2.new(1, 0, 0.160583943, 0)
        Label.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        Label.Text = "Puxar Objetos | Feito por: GODENOT"
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextScaled = true
        Label.TextSize = 14.000
        Label.TextWrapped = true
        RestricaoTexto2.Parent = Label
        RestricaoTexto2.MaxTextSize = 21
        
        Botao.Name = "Botao"
        Botao.Parent = Principal
        Botao.BackgroundColor3 = Color3.fromRGB(95, 95, 95)
        Botao.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Botao.BorderSizePixel = 0
        Botao.Position = UDim2.new(0.183284417, 0, 0.656760991, 0)
        Botao.Size = UDim2.new(0.629427791, 0, 0.277372271, 0)
        Botao.Font = Enum.Font.Nunito
        Botao.Text = "Puxar | Desligado"
        Botao.TextColor3 = Color3.fromRGB(255, 255, 255)
        Botao.TextScaled = true
        Botao.TextSize = 28.000
        Botao.TextWrapped = true
        RestricaoTexto3.Parent = Botao
        RestricaoTexto3.MaxTextSize = 28
        
        local Jogadores = game:GetService("Players")
        local ServicoExecucao = game:GetService("RunService")
        local JogadorLocal = Jogadores.LocalPlayer
        local ServicoEntradaUsuario = game:GetService("UserInputService")
        local Mundo = game:GetService("Workspace")
        local personagem
        local torso
        
        local statusPrincipal = true
        ServicoEntradaUsuario.InputBegan:Connect(function(input, processadoJogo)
            if input.KeyCode == Enum.KeyCode.RightControl and not processadoJogo then
                statusPrincipal = not statusPrincipal
                Principal.Visible = statusPrincipal
            end
        end)
        
        local pasta = Instance.new("Folder", Mundo)
        local parte = Instance.new("Part", pasta)
        local anexo1 = Instance.new("Attachment", parte)
        parte.Anchored = true
        parte.CanCollide = false
        parte.Transparency = 1
        
        if not getgenv().Rede then
            getgenv().Rede = {
                PartesBase = {},
                Velocidade = Vector3.new(14.46262424, 14.46262424, 14.46262424)
            }
            Rede.ReterParte = function(parte)
                if parte:IsA("BasePart") and parte:IsDescendantOf(Mundo) then
                    table.insert(Rede.PartesBase, parte)
                    parte.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                    parte.CanCollide = false
                end
            end
            local function ativarControlePartes()
                JogadorLocal.ReplicationFocus = Mundo
                ServicoExecucao.Heartbeat:Connect(function()
                    sethiddenproperty(JogadorLocal, "SimulationRadius", math.huge)
                    for _, parte in pairs(Rede.PartesBase) do
                        if parte:IsDescendantOf(Mundo) then
                            parte.Velocity = Rede.Velocidade
                        end
                    end
                end)
            end
            ativarControlePartes()
        end
        
        local function forcarParte(v)
            if v:IsA("BasePart") and not v.Anchored and not v.Parent:FindFirstChildOfClass("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
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
                torque.Torque = Vector3.new(100000, 100000, 100000)
                local alinharPosicao = Instance.new("AlignPosition", v)
                local anexo2 = Instance.new("Attachment", v)
                torque.Attachment0 = anexo2
                alinharPosicao.MaxForce = math.huge
                alinharPosicao.MaxVelocity = math.huge
                alinharPosicao.Responsiveness = 200
                alinharPosicao.Attachment0 = anexo2
                alinharPosicao.Attachment1 = anexo1
            end
        end
        
        local buracoAtivo = false
        local conexaoAdicaoDescendente
        
        local function alternarBuracoNegro()
            buracoAtivo = not buracoAtivo
            if buracoAtivo then
                Botao.Text = "Puxar | Ligado"
                for _, v in ipairs(Mundo:GetDescendants()) do
                    forcarParte(v)
                end
                conexaoAdicaoDescendente = Mundo.DescendantAdded:Connect(function(v)
                    if buracoAtivo then forcarParte(v) end
                end)
                spawn(function()
                    while buracoAtivo and ServicoExecucao.RenderStepped:Wait() do
                        anexo1.WorldCFrame = torso.CFrame
                    end
                end)
            else
                Botao.Text = "Puxar | Desligado"
                if conexaoAdicaoDescendente then conexaoAdicaoDescendente:Disconnect() end
            end
        end
        
        local function obterJogador(nome)
            local nomeMinusculo = string.lower(nome)
            for _, p in pairs(Jogadores:GetPlayers()) do
                if string.find(string.lower(p.Name), nomeMinusculo) then
                    return p
                elseif string.find(string.lower(p.DisplayName), nomeMinusculo) then
                    return p
                end
            end
        end
        
        local jogador = nil
        
        local function scriptCaixaTexto()
            CaixaTexto.FocusLost:Connect(function(enterPressionado)
                if enterPressionado then
                    jogador = obterJogador(CaixaTexto.Text)
                    if jogador then
                        CaixaTexto.Text = jogador.Name
                        print("Jogador encontrado:", jogador.Name)
                    else
                        print("Jogador não encontrado")
                    end
                end
            end)
        end
        coroutine.wrap(scriptCaixaTexto)()
        
        local function scriptBotao()
            Botao.MouseButton1Click:Connect(function()
                if jogador then
                    personagem = jogador.Character or jogador.CharacterAdded:Wait()
                    torso = personagem:WaitForChild("HumanoidRootPart")
                    alternarBuracoNegro()
                else
                    print("Nenhum jogador selecionado")
                end
            end)
        end
        coroutine.wrap(scriptBotao)()
    end
})

AbaTroll:AddSection({ "Invisível" })
AbaTroll:AddButton({
    Name = "Ficar Invisível",
    Description = "Ficar invisível FE",
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
        
        local todosAcessorios = {}
        for _, acessorio in ipairs({
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
            for id in string.gmatch(acessorio, "%d+") do
                table.insert(todosAcessorios, tonumber(id))
            end
        end
        
        wait()
        for _, id in ipairs(todosAcessorios) do
            task.spawn(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Wear"):InvokeServer(id)
                print(id)
            end)
        end
    end
})

AbaTroll:AddSection({ "Avatar RGB" })
local cores = { "Bright red", "Lime green", "Bright blue", "Bright yellow", "Bright cyan", "Hot pink", "Royal purple" }
local rgbAtivo = false

local function mudarCor(cor)
    local args = { cor }
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ChangeBodyColor"):FireServer(unpack(args))
end

local function alternarRGBPersonagem(ativo)
    rgbAtivo = ativo
    if rgbAtivo then
        while rgbAtivo do
            for _, cor in ipairs(cores) do
                if not rgbAtivo then return end
                mudarCor(cor)
                wait(0.5)
            end
        end
    end
end

AbaTroll:AddToggle({
    Name = "Personagem RGB",
    Description = "Deixa seu personagem RGB",
    Default = false,
    Callback = function(valor)
        alternarRGBPersonagem(valor)
    end
})

AbaTroll:AddSection({ "Cabelo RGB" })
local coresCabelo = {
    Color3.new(1, 1, 0),
    Color3.new(0, 0, 1),
    Color3.new(1, 0, 1),
    Color3.new(1, 1, 1),
    Color3.new(0, 1, 0),
    Color3.new(0.5, 0, 1),
    Color3.new(1, 0.647, 0),
    Color3.new(0, 1, 1)
}
local ativo = false

local function mudarCorCabelo()
    local i = 1
    while ativo do
        if not ativo then break end
        local args = { [1] = "ChangeHairColor2", [2] = coresCabelo[i] }
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Max1y"):FireServer(unpack(args))
        wait(0.1)
        i = i % #coresCabelo + 1
    end
end

AbaTroll:AddToggle({
    Name = "Cabelo RGB",
    Description = "Deixa Seu Cabelo RGB",
    Default = false,
    Callback = function(valor)
        ativo = valor
        if ativo then mudarCorCabelo() end
    end
})

-- Anti Sentar
AbaTroll:AddSection({ "Anti Sentar" })
AbaTroll:AddToggle({
    Name = "Anti Sentar",
    Description = "Não Deixa seu personagem Sentar",
    Default = false,
    Callback = function(Valor)
        local jogador = game.Players.LocalPlayer
        local conexoes = {}
        local servicoExecucao = game:GetService("RunService")
        
        local function prevenirSentar(humanoide)
            if humanoide then
                humanoide:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                local conexaoSentar = humanoide.StateChanged:Connect(function(_, novoEstado)
                    if novoEstado == Enum.HumanoidStateType.Seated then
                        humanoide:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end)
                table.insert(conexoes, conexaoSentar)
            end
        end
        
        local function monitorarPersonagem()
            local function aoAdicionarPersonagem(personagem)
                local humanoide = personagem:WaitForChild("Humanoid")
                prevenirSentar(humanoide)
            end
            local conexaoAdicaoPersonagem = jogador.CharacterAdded:Connect(aoAdicionarPersonagem)
            table.insert(conexoes, conexaoAdicaoPersonagem)
            if jogador.Character then aoAdicionarPersonagem(jogador.Character) end
        end
        
        local function resetarSentar()
            for _, conexao in ipairs(conexoes) do
                conexao:Disconnect()
            end
            conexoes = {}
            local humanoide = jogador.Character and jogador.Character:FindFirstChildOfClass("Humanoid")
            if humanoide then humanoide:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end
        end
        
        if Valor then
            monitorarPersonagem()
            local conexaoHeartbeat = servicoExecucao.Heartbeat:Connect(function()
                local humanoide = jogador.Character and jogador.Character:FindFirstChildOfClass("Humanoid")
                if humanoide then humanoide:SetStateEnabled(Enum.HumanoidStateType.Seated, false) end
            end)
            table.insert(conexoes, conexaoHeartbeat)
        else
            resetarSentar()
        end
    end
})

-- Aba Troll Players
local AbaTrollPlayers = Janela:MakeTab({
    Title = "Troll Jogadores",
    Icon = "rbxassetid://131153193945220"
})

local Jogadores = game:GetService("Players")
local JogadorLocal = Jogadores.LocalPlayer
local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
local GerenciadorEntradaVirtual = game:GetService("VirtualInputManager")
local ServicoExecucao = game:GetService("RunService")
local camera = workspace.CurrentCamera
local jogadorSelecionado = nil
local metodoMatar = nil
getgenv().Alvo = nil
local Personagem = JogadorLocal.Character
local Humanoide = Personagem and Personagem:WaitForChild("Humanoid")
local Raiz = Personagem and Personagem:WaitForChild("HumanoidRootPart")

-- Função para limpar o sofá
local function limparSofa()
    local char = JogadorLocal.Character
    if char then
        local sofa = char:FindFirstChild("Vortex.Sofa") or JogadorLocal.Backpack:FindFirstChild("Vortex.Sofa")
        if sofa then sofa:Destroy() end
    end
    ArmazenamentoReplicado:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
end

-- Conectar evento CharacterAdded
JogadorLocal.CharacterAdded:Connect(function(novoPersonagem)
    Personagem = novoPersonagem
    Humanoide = novoPersonagem:WaitForChild("Humanoid")
    Raiz = novoPersonagem:WaitForChild("HumanoidRootPart")
    limparSofa()
    Humanoide.Died:Connect(function() limparSofa() end)
end)

if Humanoide then
    Humanoide.Died:Connect(function() limparSofa() end)
end

-- Função KillPlayerCouch
local function matarJogadorSofa()
    if not jogadorSelecionado then
        warn("Erro: Nenhum jogador selecionado")
        return
    end
    local alvo = Jogadores:FindFirstChild(jogadorSelecionado)
    if not alvo or not alvo.Character then
        warn("Erro: Jogador alvo não encontrado ou sem personagem")
        return
    end
    local char = JogadorLocal.Character
    if not char then
        warn("Erro: Personagem do jogador local não encontrado")
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local raiz = char:FindFirstChild("HumanoidRootPart")
    local raizAlvo = alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart")
    if not hum or not raiz or not raizAlvo then
        warn("Erro: Componentes necessários não encontrados")
        return
    end
    local posOriginal = raiz.Position
    local posSentar = Vector3.new(145.51, -350.09, 21.58)
    
    ArmazenamentoReplicado:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
    task.wait(0.2)
    ArmazenamentoReplicado.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    task.wait(0.3)
    local ferramenta = JogadorLocal.Backpack:FindFirstChild("Couch")
    if ferramenta then ferramenta.Parent = char end
    task.wait(0.1)
    GerenciadorEntradaVirtual:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    task.wait(0.1)
    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    hum.PlatformStand = false
    camera.CameraSubject = alvo.Character:FindFirstChild("Head") or raizAlvo or hum
    
    local alinhar = Instance.new("BodyPosition")
    alinhar.Name = "PosicaoPuxar"
    alinhar.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    alinhar.D = 10
    alinhar.P = 30000
    alinhar.Position = raiz.Position
    alinhar.Parent = raizAlvo
    
    task.spawn(function()
        local angulo = 0
        local tempoInicio = tick()
        while tick() - tempoInicio < 5 and alvo and alvo.Character and alvo.Character:FindFirstChildOfClass("Humanoid") do
            local tHum = alvo.Character:FindFirstChildOfClass("Humanoid")
            if not tHum or tHum.Sit then break end
            local hrp = alvo.Character.HumanoidRootPart
            local posAjustada = hrp.Position + (hrp.Velocity / 1.5)
            angulo = angulo + 50
            raiz.CFrame = CFrame.new(posAjustada + Vector3.new(0, 2, 0)) * CFrame.Angles(math.rad(angulo), 0, 0)
            alinhar.Position = raiz.Position + Vector3.new(2, 0, 0)
            task.wait()
        end
        alinhar:Destroy()
        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        hum.PlatformStand = false
        camera.CameraSubject = hum
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Velocity = Vector3.zero
                p.RotVelocity = Vector3.zero
            end
        end
        task.wait(0.1)
        raiz.CFrame = CFrame.new(posSentar)
        task.wait(0.3)
        local ferramenta = char:FindFirstChild("Couch")
        if ferramenta then ferramenta.Parent = JogadorLocal.Backpack end
        task.wait(0.01)
        ArmazenamentoReplicado.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
        task.wait(0.2)
        raiz.CFrame = CFrame.new(posOriginal)
    end)
end

-- Função BringPlayerLLL
local function puxarJogadorLLL()
    if not jogadorSelecionado then
        warn("Erro: Nenhum jogador selecionado")
        return
    end
    local alvo = Jogadores:FindFirstChild(jogadorSelecionado)
    if not alvo or not alvo.Character then
        warn("Erro: Jogador alvo não encontrado ou sem personagem")
        return
    end
    local char = JogadorLocal.Character
    if not char then
        warn("Erro: Personagem do jogador local não encontrado")
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local raiz = char:FindFirstChild("HumanoidRootPart")
    local raizAlvo = alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart")
    if not hum or not raiz or not raizAlvo then
        warn("Erro: Componentes necessários não encontrados")
        return
    end
    local posOriginal = raiz.Position
    
    ArmazenamentoReplicado:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
    task.wait(0.2)
    ArmazenamentoReplicado.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    task.wait(0.3)
    local ferramenta = JogadorLocal.Backpack:FindFirstChild("Couch")
    if ferramenta then ferramenta.Parent = char end
    task.wait(0.1)
    GerenciadorEntradaVirtual:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    task.wait(0.1)
    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    hum.PlatformStand = false
    camera.CameraSubject = alvo.Character:FindFirstChild("Head") or raizAlvo or hum
    
    local alinhar = Instance.new("BodyPosition")
    alinhar.Name = "PosicaoPuxar"
    alinhar.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    alinhar.D = 10
    alinhar.P = 30000
    alinhar.Position = raiz.Position
    alinhar.Parent = raizAlvo
    
    task.spawn(function()
        local angulo = 0
        local tempoInicio = tick()
        while tick() - tempoInicio < 5 and alvo and alvo.Character and alvo.Character:FindFirstChildOfClass("Humanoid") do
            local tHum = alvo.Character:FindFirstChildOfClass("Humanoid")
            if not tHum or tHum.Sit then break end
            local hrp = alvo.Character.HumanoidRootPart
            local posAjustada = hrp.Position + (hrp.Velocity / 1.5)
            angulo = angulo + 50
            raiz.CFrame = CFrame.new(posAjustada + Vector3.new(0, 2, 0)) * CFrame.Angles(math.rad(angulo), 0, 0)
            alinhar.Position = raiz.Position + Vector3.new(2, 0, 0)
            task.wait()
        end
        alinhar:Destroy()
        hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        hum.PlatformStand = false
        camera.CameraSubject = hum
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Velocity = Vector3.zero
                p.RotVelocity = Vector3.zero
            end
        end
        task.wait(0.1)
        raiz.Anchored = true
        raiz.CFrame = CFrame.new(posOriginal)
        task.wait(0.001)
        raiz.Anchored = false
        task.wait(0.7)
        local ferramenta = char:FindFirstChild("Couch")
        if ferramenta then ferramenta.Parent = JogadorLocal.Backpack end
        task.wait(0.001)
        ArmazenamentoReplicado.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    end)
end

-- Função BringWithCouch
local function puxarComSofa()
    local alvo = Jogadores:FindFirstChild(getgenv().Alvo)
    if not alvo then
        warn("Erro: Nenhum jogador alvo selecionado")
        return
    end
    if not alvo.Character or not alvo.Character:FindFirstChild("HumanoidRootPart") then
        warn("Erro: Jogador alvo sem personagem ou HumanoidRootPart")
        return
    end
    local args = { [1] = "ClearAllTools" }
    ArmazenamentoReplicado.RE["1Clea1rTool1s"]:FireServer(unpack(args))
    local args = { [1] = "PickingTools", [2] = "Couch" }
    ArmazenamentoReplicado.RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
    local sofa = JogadorLocal.Backpack:WaitForChild("Couch", 2)
    if not sofa then
        warn("Erro: Sofá não encontrado no Backpack")
        return
    end
    sofa.Name = "Vortex.Sofa"
    local assento1 = sofa:FindFirstChild("Seat1")
    local assento2 = sofa:FindFirstChild("Seat2")
    local handle = sofa:FindFirstChild("Handle")
    if assento1 and assento2 and handle then
        assento1.Disabled = true
        assento2.Disabled = true
        handle.Name = "Handle "
    else
        warn("Erro: Componentes do sofá não encontrados")
        return
    end
    sofa.Parent = JogadorLocal.Character
    local tet = Instance.new("BodyVelocity", assento1)
    tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    tet.P = 1250
    tet.Velocity = Vector3.new(0, 0, 0)
    tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
    repeat
        for m = 1, 35 do
            local pos = { x = 0, y = 0, z = 0 }
            local raizAlvo = alvo.Character and alvo.Character.HumanoidRootPart
            if not raizAlvo then break end
            pos.x = raizAlvo.Position.X + (raizAlvo.Velocity.X / 2)
            pos.y = raizAlvo.Position.Y + (raizAlvo.Velocity.Y / 2)
            pos.z = raizAlvo.Position.Z + (raizAlvo.Velocity.Z / 2)
            assento1.CFrame = CFrame.new(Vector3.new(pos.x, pos.y, pos.z)) * CFrame.new(-2, 2, 0)
            task.wait()
        end
        tet:Destroy()
        sofa.Parent = JogadorLocal.Backpack
        task.wait()
        sofa:FindFirstChild("Handle ").Name = "Handle"
        task.wait(0.2)
        sofa.Parent = JogadorLocal.Character
        task.wait()
        sofa.Parent = JogadorLocal.Backpack
        sofa.Handle.Name = "Handle "
        task.wait(0.2)
        sofa.Parent = JogadorLocal.Character
        tet = Instance.new("BodyVelocity", assento1)
        tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        tet.P = 1250
        tet.Velocity = Vector3.new(0, 0, 0)
        tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
    until alvo.Character and alvo.Character.Humanoid and alvo.Character.Humanoid.Sit == true
    task.wait()
    tet:Destroy()
    sofa.Parent = JogadorLocal.Backpack
    task.wait()
    sofa:FindFirstChild("Handle ").Name = "Handle"
    task.wait(0.3)
    sofa.Parent = JogadorLocal.Character
    task.wait(0.3)
    sofa.Grip = CFrame.new(Vector3.new(0, 0, 0))
    task.wait(0.3)
    ArmazenamentoReplicado.RE["1Clea1rTool1s"]:FireServer("ClearAllTools")
end

-- Função KillWithCouch
local function matarComSofa()
    local alvo = Jogadores:FindFirstChild(getgenv().Alvo)
    if not alvo then
        warn("Erro: Nenhum jogador alvo selecionado")
        return
    end
    if not alvo.Character or not alvo.Character:FindFirstChild("HumanoidRootPart") then
        warn("Erro: Jogador alvo sem personagem ou HumanoidRootPart")
        return
    end
    local args = { [1] = "ClearAllTools" }
    ArmazenamentoReplicado.RE["1Clea1rTool1s"]:FireServer(unpack(args))
    local args = { [1] = "PickingTools", [2] = "Couch" }
    ArmazenamentoReplicado.RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
    local sofa = JogadorLocal.Backpack:WaitForChild("Couch", 2)
    if not sofa then
        warn("Erro: Sofá não encontrado no Backpack")
        return
    end
    sofa.Name = "Vortex.Sofa"
    local assento1 = sofa:FindFirstChild("Seat1")
    local assento2 = sofa:FindFirstChild("Seat2")
    local handle = sofa:FindFirstChild("Handle")
    if assento1 and assento2 and handle then
        assento1.Disabled = true
        assento2.Disabled = true
        handle.Name = "Handle "
    else
        warn("Erro: Componentes do sofá não encontrados")
        return
    end
    sofa.Parent = JogadorLocal.Character
    local tet = Instance.new("BodyVelocity", assento1)
    tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    tet.P = 1250
    tet.Velocity = Vector3.new(0, 0, 0)
    tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
    repeat
        for m = 1, 35 do
            local pos = { x = 0, y = 0, z = 0 }
            local raizAlvo = alvo.Character and alvo.Character.HumanoidRootPart
            if not raizAlvo then break end
            pos.x = raizAlvo.Position.X + (raizAlvo.Velocity.X / 2)
            pos.y = raizAlvo.Position.Y + (raizAlvo.Velocity.Y / 2)
            pos.z = raizAlvo.Position.Z + (raizAlvo.Velocity.Z / 2)
            assento1.CFrame = CFrame.new(Vector3.new(pos.x, pos.y, pos.z)) * CFrame.new(-2, 2, 0)
            task.wait()
        end
        tet:Destroy()
        sofa.Parent = JogadorLocal.Backpack
        task.wait()
        sofa:FindFirstChild("Handle ").Name = "Handle"
        task.wait(0.2)
        sofa.Parent = JogadorLocal.Character
        task.wait()
        sofa.Parent = JogadorLocal.Backpack
        sofa.Handle.Name = "Handle "
        task.wait(0.2)
        sofa.Parent = JogadorLocal.Character
        tet = Instance.new("BodyVelocity", assento1)
        tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        tet.P = 1250
        tet.Velocity = Vector3.new(0, 0, 0)
        tet.Name = "#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W"
    until alvo.Character and alvo.Character.Humanoid and alvo.Character.Humanoid.Sit == true
    task.wait()
    sofa.Parent = JogadorLocal.Backpack
    assento1.CFrame = CFrame.new(Vector3.new(9999, -450, 9999))
    assento2.CFrame = CFrame.new(Vector3.new(9999, -450, 9999))
    sofa.Parent = JogadorLocal.Character
    task.wait(0.1)
    sofa.Parent = JogadorLocal.Backpack
    task.wait(2)
    local bv = assento1:FindFirstChild("#mOVOOEPF$#@F$#GERE..>V<<<<EW<V<<W")
    if bv then bv:Destroy() end
    ArmazenamentoReplicado.RE["1Clea1rTool1s"]:FireServer("ClearAllTools")
end

-- Seção de seleção de jogador
local SecaoJogador = AbaTrollPlayers:AddSection({ Name = "Selecionar Jogador" })

local function obterListaJogadores()
    local lista = {}
    for _, jogador in ipairs(Jogadores:GetPlayers()) do
        if jogador ~= JogadorLocal then
            table.insert(lista, jogador.Name)
        end
    end
    return lista
end

local menuJogadores = AbaTrollPlayers:AddDropdown({
    Name = "Selecionar Jogador",
    Options = obterListaJogadores(),
    Default = "",
    Callback = function(valor)
        jogadorSelecionado = valor
        getgenv().Alvo = valor
        print("Jogador selecionado: " .. tostring(valor))
    end
})

AbaTrollPlayers:AddButton({
    Name = "Atualizar Lista",
    Callback = function()
        local novaLista = obterListaJogadores()
        if menuJogadores and #novaLista > 0 then
            menuJogadores:Set(novaLista)
            print("Lista de jogadores atualizada: ", table.concat(novaLista, ", "))
            if jogadorSelecionado and not Jogadores:FindFirstChild(jogadorSelecionado) then
                jogadorSelecionado = nil
                getgenv().Alvo = nil
                menuJogadores:SetValue("")
                print("Seleção resetada, jogador não está mais no servidor.")
            end
        end
    end
})

AbaTrollPlayers:AddButton({
    Name = "Teleportar até o Jogador",
    Callback = function()
        if not jogadorSelecionado or not Jogadores:FindFirstChild(jogadorSelecionado) then
            print("Erro: Jogador não selecionado ou não existe")
            return
        end
        local personagem = JogadorLocal.Character
        local torso = personagem and personagem:FindFirstChild("HumanoidRootPart")
        if not torso then
            warn("Erro: HumanoidRootPart do jogador local não encontrado")
            return
        end
        local alvo = Jogadores:FindFirstChild(jogadorSelecionado)
        if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
            torso.CFrame = alvo.Character.HumanoidRootPart.CFrame
        end
    end
})

AbaTrollPlayers:AddToggle({
    Name = "Espectar Jogador",
    Default = false,
    Callback = function(valor)
        local Camera = workspace.CurrentCamera
        local function atualizarCamera()
            if valor then
                local alvo = Jogadores:FindFirstChild(jogadorSelecionado)
                if alvo and alvo.Character then
                    local humanoide = alvo.Character:FindFirstChild("Humanoid")
                    if humanoide then Camera.CameraSubject = humanoide end
                end
            else
                if JogadorLocal.Character then
                    local humanoide = JogadorLocal.Character:FindFirstChild("Humanoid")
                    if humanoide then Camera.CameraSubject = humanoide end
                end
            end
        end
        if valor then
            if not getgenv().ConexaoCamera then
                getgenv().ConexaoCamera = ServicoExecucao.Heartbeat:Connect(atualizarCamera)
            end
        else
            if getgenv().ConexaoCamera then
                getgenv().ConexaoCamera:Disconnect()
                getgenv().ConexaoCamera = nil
            end
            atualizarCamera()
        end
    end
})

-- Seção de Métodos
local SecaoMetodos = AbaTrollPlayers:AddSection({ Name = "Métodos" })

AbaTrollPlayers:AddDropdown({
    Name = "Selecionar Método para Matar",
    Options = {"Ônibus", "Sofá", "Sofá Sem ir até o alvo [BETA]"},
    Default = "",
    Callback = function(valor)
        metodoMatar = valor
        print("Método selecionado: " .. tostring(valor))
    end
})

AbaTrollPlayers:AddButton({
    Name = "Matar Jogador",
    Callback = function()
        if not jogadorSelecionado or not Jogadores:FindFirstChild(jogadorSelecionado) then
            print("Erro: Jogador não selecionado ou não existe")
            return
        end
        if metodoMatar == "Sofá" then
            matarJogadorSofa()
        elseif metodoMatar == "Sofá Sem ir até o alvo [BETA]" then
            matarComSofa()
        else
            -- Método do ônibus
            local personagem = JogadorLocal.Character
            local torso = personagem and personagem:FindFirstChild("HumanoidRootPart")
            if not torso then return end
            local posOriginal = torso.CFrame
            
            local function pegarOnibus()
                local veiculos = workspace:FindFirstChild("Vehicles")
                if veiculos then return veiculos:FindFirstChild(JogadorLocal.Name .. "Car") end
                return nil
            end
            
            local onibus = pegarOnibus()
            if not onibus then
                torso.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                local eventoRemoto = ArmazenamentoReplicado:FindFirstChild("RE")
                if eventoRemoto and eventoRemoto:FindFirstChild("1Ca1r") then
                    eventoRemoto["1Ca1r"]:FireServer("PickingCar", "SchoolBus")
                end
                task.wait(1)
                onibus = pegarOnibus()
            end
            
            if onibus then
                local assento = onibus:FindFirstChild("Body") and onibus.Body:FindFirstChild("VehicleSeat")
                if assento and personagem:FindFirstChildOfClass("Humanoid") and not personagem.Humanoid.Sit then
                    repeat
                        torso.CFrame = assento.CFrame * CFrame.new(0, 2, 0)
                        task.wait()
                    until personagem.Humanoid.Sit or not onibus.Parent
                end
            end
            
            local function rastrearJogador()
                while true do
                    if jogadorSelecionado then
                        local alvo = Jogadores:FindFirstChild(jogadorSelecionado)
                        if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
                            local humanoideAlvo = alvo.Character:FindFirstChildOfClass("Humanoid")
                            if humanoideAlvo and humanoideAlvo.Sit then
                                if personagem.Humanoid then
                                    onibus:SetPrimaryPartCFrame(CFrame.new(9999, -450, 9999))
                                    print("Jogador sentou, levando ônibus para o void!")
                                    task.wait(0.2)
                                    if personagem.Humanoid then
                                        personagem.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                    end
                                    task.wait(0.5)
                                    torso.CFrame = posOriginal
                                end
                                break
                            else
                                local raizAlvo = alvo.Character.HumanoidRootPart
                                local tempo = tick() * 35
                                local deslocamentoLateral = math.sin(tempo) * 4
                                local deslocamentoFrontal = math.cos(tempo) * 20
                                onibus:SetPrimaryPartCFrame(raizAlvo.CFrame * CFrame.new(deslocamentoLateral, 0, deslocamentoFrontal))
                            end
                        end
                    end
                    ServicoExecucao.RenderStepped:Wait()
                end
            end
            spawn(rastrearJogador)
        end
    end
})

AbaTrollPlayers:AddButton({
    Name = "Puxar Jogador",
    Callback = function()
        if not jogadorSelecionado or not Jogadores:FindFirstChild(jogadorSelecionado) then
            print("Erro: Jogador não selecionado ou não existe")
            return
        end
        if metodoMatar == "Sofá" then
            puxarJogadorLLL()
        elseif metodoMatar == "Sofá Sem ir até o alvo [BETA]" then
            puxarComSofa()
        else
            -- Método do ônibus
            local personagem = JogadorLocal.Character
            local torso = personagem and personagem:FindFirstChild("HumanoidRootPart")
            if not torso then return end
            local posOriginal = torso.CFrame
            
            local function pegarOnibus()
                local veiculos = workspace:FindFirstChild("Vehicles")
                if veiculos then return veiculos:FindFirstChild(JogadorLocal.Name .. "Car") end
                return nil
            end
            
            local onibus = pegarOnibus()
            if not onibus then
                torso.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                local eventoRemoto = ArmazenamentoReplicado:FindFirstChild("RE")
                if eventoRemoto and eventoRemoto:FindFirstChild("1Ca1r") then
                    eventoRemoto["1Ca1r"]:FireServer("PickingCar", "SchoolBus")
                end
                task.wait(1)
                onibus = pegarOnibus()
            end
            
            if onibus then
                local assento = onibus:FindFirstChild("Body") and onibus.Body:FindFirstChild("VehicleSeat")
                if assento and personagem:FindFirstChildOfClass("Humanoid") and not personagem.Humanoid.Sit then
                    repeat
                        torso.CFrame = assento.CFrame * CFrame.new(0, 2, 0)
                        task.wait()
                    until personagem.Humanoid.Sit or not onibus.Parent
                end
            end
            
            local function rastrearJogador()
                while true do
                    if jogadorSelecionado then
                        local alvo = Jogadores:FindFirstChild(jogadorSelecionado)
                        if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
                            local humanoideAlvo = alvo.Character:FindFirstChildOfClass("Humanoid")
                            if humanoideAlvo and humanoideAlvo.Sit then
                                if personagem.Humanoid then
                                    onibus:SetPrimaryPartCFrame(posOriginal)
                                    task.wait(0.7)
                                    local args = { [1] = "DeleteAllVehicles" }
                                    ArmazenamentoReplicado.RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
                                end
                                break
                            else
                                local raizAlvo = alvo.Character.HumanoidRootPart
                                local tempo = tick() * 35
                                local deslocamentoLateral = math.sin(tempo) * 4
                                local deslocamentoFrontal = math.cos(tempo) * 20
                                onibus:SetPrimaryPartCFrame(raizAlvo.CFrame * CFrame.new(deslocamentoLateral, 0, deslocamentoFrontal))
                            end
                        end
                    end
                    ServicoExecucao.RenderStepped:Wait()
                end
            end
            spawn(rastrearJogador)
        end
    end
})

-- Função House Ban Kill
local function matarBanimentoCasa()
    if not jogadorSelecionado then
        print("Nenhum jogador selecionado!")
        return
    end
    local Jogador = game.Players.LocalPlayer
    local Mochila = Jogador.Backpack
    local Personagem = Jogador.Character
    local Humanoide = Personagem:FindFirstChildOfClass("Humanoid")
    local Raiz = Personagem:FindFirstChild("HumanoidRootPart")
    local Casas = game.Workspace:FindFirstChild("001_Lots")
    local PosAntiga = Raiz.CFrame
    local Angulos = 0
    local Veiculos = Workspace.Vehicles
    
    local function Verificar()
        if Jogador and Personagem and Humanoide and Raiz and Veiculos then
            return true
        else
            return false
        end
    end
    
    local jogadorSelecionadoObj = game.Players:FindFirstChild(jogadorSelecionado)
    if jogadorSelecionadoObj and jogadorSelecionadoObj.Character then
        if Verificar() then
            local Casa = Casas:FindFirstChild(Jogador.Name .. "House")
            if not Casa then
                local CasaEscolhida
                local casasDisponiveis = {}
                for _, Lote in pairs(Casas:GetChildren()) do
                    if Lote.Name == "For Sale" then
                        for _, num in pairs(Lote:GetDescendants()) do
                            if num:IsA("NumberValue") and num.Name == "Number" and num.Value < 25 and num.Value > 10 then
                                table.insert(casasDisponiveis, {Lote = Lote, Number = num.Value})
                                break
                            end
                        end
                    end
                end
                if #casasDisponiveis > 0 then
                    local casaAleatoria = casasDisponiveis[math.random(1, #casasDisponiveis)]
                    CasaEscolhida = casaAleatoria.Lote
                    local numeroCasa = casaAleatoria.Number
                    local DetectorCompra = CasaEscolhida:FindFirstChild("BuyHouse")
                    if DetectorCompra and DetectorCompra:IsA("BasePart") then
                        Raiz.CFrame = DetectorCompra.CFrame + Vector3.new(0, -6, 0)
                        task.wait(0.5)
                        local ClickDetector = DetectorCompra:FindFirstChild("ClickDetector")
                        if ClickDetector then fireclickdetector(ClickDetector) end
                    end
                    task.wait(0.5)
                    local args = { numeroCasa, "056_House" }
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Lot:BuildProperty"):FireServer(unpack(args))
                end
            end
            task.wait(0.5)
            local PreCasa = Casas:FindFirstChild(Jogador.Name .. "House")
            if PreCasa then
                task.wait(0.5)
                local Numero
                for i, x in pairs(PreCasa:GetDescendants()) do
                    if x.Name == "Number" and x:IsA("NumberValue") then
                        Numero = x
                    end
                end
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gettin1gHous1e"):FireServer("PickingCustomHouse", "049_House", Numero.Value)
            end
            task.wait(0.5)
            local PCarro = Veiculos:FindFirstChild(Jogador.Name .. "Car")
            if not PCarro then
                if Verificar() then
                    Raiz.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                    task.wait(0.5)
                    PCarro = Veiculos:FindFirstChild(Jogador.Name .. "Car")
                    task.wait(0.5)
                    local Assento = PCarro:FindFirstChild("Body") and PCarro.Body:FindFirstChild("VehicleSeat")
                    if Assento then
                        repeat
                            task.wait()
                            Raiz.CFrame = Assento.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                        until Humanoide.Sit
                    end
                end
            end
            task.wait(0.5)
            PCarro = Veiculos:FindFirstChild(Jogador.Name .. "Car")
            if PCarro then
                if not Humanoide.Sit then
                    local Assento = PCarro:FindFirstChild("Body") and PCarro.Body:FindFirstChild("VehicleSeat")
                    if Assento then
                        repeat
                            task.wait()
                            Raiz.CFrame = Assento.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                        until Humanoide.Sit
                    end
                end
                local Alvo = jogadorSelecionadoObj
                local PersonagemAlvo = Alvo.Character
                local HumanoideAlvo = PersonagemAlvo:FindFirstChildOfClass("Humanoid")
                local RaizAlvo = PersonagemAlvo:FindFirstChild("HumanoidRootPart")
                if PersonagemAlvo and HumanoideAlvo and RaizAlvo then
                    if not HumanoideAlvo.Sit then
                        while not HumanoideAlvo.Sit do
                            task.wait()
                            local Arremessar = function(alvo, pos, angulo)
                                PCarro:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                            end
                            Angulos = Angulos + 100
                            Arremessar(RaizAlvo, CFrame.new(0, 1.5, 0) + HumanoideAlvo.MoveDirection * RaizAlvo.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angulos), 0, 0))
                            Arremessar(RaizAlvo, CFrame.new(0, -1.5, 0) + HumanoideAlvo.MoveDirection * RaizAlvo.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angulos), 0, 0))
                            Arremessar(RaizAlvo, CFrame.new(2.25, 1.5, -2.25) + HumanoideAlvo.MoveDirection * RaizAlvo.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angulos), 0, 0))
                            Arremessar(RaizAlvo, CFrame.new(-2.25, -1.5, 2.25) + HumanoideAlvo.MoveDirection * RaizAlvo.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angulos), 0, 0))
                            Arremessar(RaizAlvo, CFrame.new(0, 1.5, 0) + HumanoideAlvo.MoveDirection * RaizAlvo.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angulos), 0, 0))
                            Arremessar(RaizAlvo, CFrame.new(0, -1.5, 0) + HumanoideAlvo.MoveDirection * RaizAlvo.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angulos), 0, 0))
                        end
                        task.wait(0.2)
                        local Casa = Casas:FindFirstChild(Jogador.Name .. "House")
                        PCarro:SetPrimaryPartCFrame(CFrame.new(Casa.HouseSpawnPosition.Position))
                        task.wait(0.2)
                        local regiao = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(30, 30, 30), game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(30, 30, 30))
                        local partes = workspace:FindPartsInRegion3(regiao, game.Players.LocalPlayer.Character.HumanoidRootPart, math.huge)
                        for i, v in pairs(partes) do
                            if v.Name == "HumanoidRootPart" then
                                local b = game:GetService("Players"):FindFirstChild(v.Parent.Name)
                                local args = { [1] = "BanPlayerFromHouse", [2] = b, [3] = v.Parent }
                                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))
                                local args = { [1] = "DeleteAllVehicles" }
                                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
                            end
                        end
                    end
                end
            end
        end
    end
end

AbaTrollPlayers:AddButton({
    Name = "Banimento de Casa",
    Callback = matarBanimentoCasa
})

-- Auto Fling
local flingAtivo = false
AbaTrollPlayers:AddToggle({
    Name = "Auto Fling",
    Default = false,
    Callback = function(estado)
        flingAtivo = estado
        if estado and jogadorSelecionado then
            local alvo = Jogadores:FindFirstChild(jogadorSelecionado)
            if not alvo or not alvo.Character then return end
            local raiz = JogadorLocal.Character and JogadorLocal.Character:FindFirstChild("HumanoidRootPart")
            local raizAlvo = alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart")
            if not raiz or not raizAlvo then return end
            local char = JogadorLocal.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            local original = raiz.CFrame
            local args = { "ClearAllTools" }
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
            task.wait(0.2)
            local args = { [1] = "PickingTools", [2] = "Couch" }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
            task.wait(0.3)
            local ferramenta = JogadorLocal.Backpack:FindFirstChild("Couch")
            if ferramenta then ferramenta.Parent = char end
            task.wait(0.2)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
            task.wait(0.25)
            workspace.FallenPartsDestroyHeight = 0/0
            local bv = Instance.new("BodyVelocity")
            bv.Name = "ForcaFling"
            bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
            bv.MaxForce = Vector3.new(1/0, 1/0, 1/0)
            bv.Parent = raiz
            hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            hum.PlatformStand = false
            camera.CameraSubject = alvo.Character:FindFirstChild("Head") or raizAlvo or hum
            task.spawn(function()
                local angulo = 0
                local partes = {raiz}
                while flingAtivo and alvo and alvo.Character and alvo.Character:FindFirstChildOfClass("Humanoid") do
                    local tHum = alvo.Character:FindFirstChildOfClass("Humanoid")
                    if tHum.Sit then break end
                    angulo = angulo + 50
                    for _, parte in ipairs(partes) do
                        local pos_x = alvo.Character.HumanoidRootPart.Position.X
                        local pos_y = alvo.Character.HumanoidRootPart.Position.Y
                        local pos_z = alvo.Character.HumanoidRootPart.Position.Z
                        pos_x = pos_x + (alvo.Character.HumanoidRootPart.Velocity.X / 1.5)
                        pos_y = pos_y + (alvo.Character.HumanoidRootPart.Velocity.Y / 1.5)
                        pos_z = pos_z + (alvo.Character.HumanoidRootPart.Velocity.Z / 1.5)
                        raiz.CFrame = CFrame.new(pos_x, pos_y, pos_z) * CFrame.Angles(math.rad(angulo), 0, 0)
                    end
                    raiz.Velocity = Vector3.new(9e8, 9e8, 9e8)
                    raiz.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                    task.wait()
                end
                flingAtivo = false
                bv:Destroy()
                hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                hum.PlatformStand = false
                raiz.CFrame = original
                camera.CameraSubject = hum
                for _, p in pairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.Velocity = Vector3.zero
                        p.RotVelocity = Vector3.zero
                    end
                end
                hum:UnequipTools()
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
            end)
        end
    end
})

-- Função Fling Ball
local function arremessarBola(alvo)
    local jogadores = game:GetService("Players")
    local jogador = jogadores.LocalPlayer
    local personagem = jogador.Character or jogador.CharacterAdded:Wait()
    local humanoide = personagem:WaitForChild("Humanoid")
    local hrp = personagem:WaitForChild("HumanoidRootPart")
    local mochila = jogador:WaitForChild("Backpack")
    local BolasServidor = workspace.WorkspaceCom:WaitForChild("001_SoccerBalls")
    
    local function pegarBola()
        if not mochila:FindFirstChild("SoccerBall") then
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "SoccerBall")
        end
        repeat task.wait() until mochila:FindFirstChild("SoccerBall")
        mochila.SoccerBall.Parent = personagem
        repeat task.wait() until BolasServidor:FindFirstChild("Soccer" .. jogador.Name)
        personagem.SoccerBall.Parent = mochila
        return BolasServidor:FindFirstChild("Soccer" .. jogador.Name)
    end
    
    local Bola = BolasServidor:FindFirstChild("Soccer" .. jogador.Name) or pegarBola()
    Bola.CanCollide = false
    Bola.Massless = true
    Bola.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0)
    
    if alvo ~= jogador then
        local charAlvo = alvo.Character
        if charAlvo and charAlvo:FindFirstChild("HumanoidRootPart") and charAlvo:FindFirstChild("Humanoid") then
            local raizAlvo = charAlvo.HumanoidRootPart
            local humAlvo = charAlvo.Humanoid
            if Bola:FindFirstChildWhichIsA("BodyVelocity") then
                Bola:FindFirstChildWhichIsA("BodyVelocity"):Destroy()
            end
            local bv = Instance.new("BodyVelocity")
            bv.Name = "PoderArremesso"
            bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.P = 9e900
            bv.Parent = Bola
            workspace.CurrentCamera.CameraSubject = humAlvo
            local TempoInicio = os.time()
            repeat
                if raizAlvo.Velocity.Magnitude > 0 then
                    local pos_x = raizAlvo.Position.X + (raizAlvo.Velocity.X / 1.5)
                    local pos_y = raizAlvo.Position.Y + (raizAlvo.Velocity.Y / 1.5)
                    local pos_z = raizAlvo.Position.Z + (raizAlvo.Velocity.Z / 1.5)
                    local posicao = Vector3.new(pos_x, pos_y, pos_z)
                    Bola.CFrame = CFrame.new(posicao)
                    Bola.Orientation = Bola.Orientation + Vector3.new(45, 60, 30)
                else
                    for i, v in pairs(charAlvo:GetChildren()) do
                        if v:IsA("BasePart") and v.CanCollide and not v.Anchored then
                            Bola.CFrame = v.CFrame
                            task.wait(1/6000)
                        end
                    end
                end
                task.wait(1/6000)
            until raizAlvo.Velocity.Magnitude > 1000 or humAlvo.Health <= 0 or not charAlvo:IsDescendantOf(workspace) or alvo.Parent ~= jogadores
            workspace.CurrentCamera.CameraSubject = humanoide
        end
    end
end

AbaTrollPlayers:AddButton({
    Name = "Arremessar Bola",
    Callback = function()
        arremessarBola(game:GetService("Players")[jogadorSelecionado])
    end
})

-- Fling Boat
AbaTrollPlayers:AddButton({
    Name = "Fling - Barco",
    Callback = function()
        if not jogadorSelecionado or not game.Players:FindFirstChild(jogadorSelecionado) then
            warn("Nenhum jogador selecionado ou não existe")
            return
        end
        local Jogador = game.Players.LocalPlayer
        local Personagem = Jogador.Character
        local Humanoide = Personagem and Personagem:FindFirstChildOfClass("Humanoid")
        local Raiz = Personagem and Personagem:FindFirstChild("HumanoidRootPart")
        local Veiculos = game.Workspace:FindFirstChild("Vehicles")
        
        if not Humanoide or not Raiz then
            warn("Humanoide ou Raiz inválido")
            return
        end
        
        local function spawnarBarco()
            Raiz.CFrame = CFrame.new(1754, -2, 58)
            task.wait(0.5)
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingBoat", "MilitaryBoatFree")
            task.wait(1)
            return Veiculos:FindFirstChild(Jogador.Name.."Car")
        end
        
        local PCarro = Veiculos:FindFirstChild(Jogador.Name.."Car") or spawnarBarco()
        if not PCarro then
            warn("Falha ao spawnar o barco")
            return
        end
        
        local Assento = PCarro:FindFirstChild("Body") and PCarro.Body:FindFirstChild("VehicleSeat")
        if not Assento then
            warn("Assento não encontrado")
            return
        end
        
        repeat
            task.wait(0.1)
            Raiz.CFrame = Assento.CFrame * CFrame.new(0, 1, 0)
        until Humanoide.SeatPart == Assento
        
        print("Barco spawnado!")
        
        local JogadorAlvo = game.Players:FindFirstChild(jogadorSelecionado)
        if not JogadorAlvo or not JogadorAlvo.Character then
            warn("Jogador não encontrado")
            return
        end
        
        local PersonagemAlvo = JogadorAlvo.Character
        local HumanoideAlvo = PersonagemAlvo:FindFirstChildOfClass("Humanoid")
        local RaizAlvo = PersonagemAlvo:FindFirstChild("HumanoidRootPart")
        
        if not RaizAlvo or not HumanoideAlvo then
            warn("Humanoide ou Raiz do alvo não encontrado")
            return
        end
        
        local Giro = Instance.new("BodyAngularVelocity")
        Giro.Name = "Girando"
        Giro.Parent = PCarro.PrimaryPart
        Giro.MaxTorque = Vector3.new(0, math.huge, 0)
        Giro.AngularVelocity = Vector3.new(0, 369, 0)
        
        print("Fling ativo!")
        
        local function moverCarro(RaizAlvo, offset)
            if PCarro and PCarro.PrimaryPart then
                PCarro:SetPrimaryPartCFrame(CFrame.new(RaizAlvo.Position + offset))
            end
        end
        
        task.spawn(function()
            while PCarro and PCarro.Parent and RaizAlvo and RaizAlvo.Parent do
                task.wait(0.01)
                moverCarro(RaizAlvo, Vector3.new(0, 1, 0))
                moverCarro(RaizAlvo, Vector3.new(0, -2.25, 5))
                moverCarro(RaizAlvo, Vector3.new(0, 2.25, 0.25))
                moverCarro(RaizAlvo, Vector3.new(-2.25, -1.5, 2.25))
                moverCarro(RaizAlvo, Vector3.new(0, 1.5, 0))
                moverCarro(RaizAlvo, Vector3.new(0, -1.5, 0))
                if PCarro and PCarro.PrimaryPart then
                    local Rotacao = CFrame.Angles(math.rad(math.random(-369, 369)), math.rad(math.random(-369, 369)), math.rad(math.random(-369, 369)))
                    PCarro:SetPrimaryPartCFrame(CFrame.new(RaizAlvo.Position + Vector3.new(0, 1.5, 0)) * Rotacao)
                end
            end
            if Giro and Giro.Parent then
                Giro:Destroy()
                print("Fling desativado")
            end
        end)
    end
})

AbaTrollPlayers:AddButton({
    Name = "Desligar Fling - Barco",
    Callback = function()
        local Jogador = game.Players.LocalPlayer
        local Personagem = Jogador.Character
        local Raiz = Personagem and Personagem:FindFirstChild("HumanoidRootPart")
        local Humanoide = Personagem and Personagem:FindFirstChildOfClass("Humanoid")
        local Veiculos = game.Workspace:FindFirstChild("Vehicles")
        
        if not Raiz or not Humanoide then
            warn("Nenhum Raiz ou Humanoide encontrado!")
            return
        end
        
        Humanoide.PlatformStand = true
        print("Jogador paralisado para reduzir efeitos do giro.")
        
        for _, obj in pairs(Raiz:GetChildren()) do
            if obj:IsA("BodyAngularVelocity") or obj:IsA("BodyVelocity") then
                obj:Destroy()
            end
        end
        print("Giro e forças removidas do jogador.")
        
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
        task.wait(0.5)
        
        local PCarro = Veiculos and Veiculos:FindFirstChild(Jogador.Name.."Car")
        if PCarro and PCarro.PrimaryPart then
            for _, obj in pairs(PCarro.PrimaryPart:GetChildren()) do
                if obj:IsA("BodyAngularVelocity") or obj:IsA("BodyVelocity") then
                    obj:Destroy()
                end
            end
            print("Giro removido do barco.")
        end
        
        task.wait(1)
        local posSegura = Vector3.new(0, 1000, 0)
        local bp = Instance.new("BodyPosition", Raiz)
        bp.Position = posSegura
        bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        local bg = Instance.new("BodyGyro", Raiz)
        bg.CFrame = Raiz.CFrame
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        print("Jogador está preso na coordenada segura.")
        
        task.wait(3)
        bp:Destroy()
        bg:Destroy()
        Humanoide.PlatformStand = false
        print("Jogador liberado, seguro na posição.")
    end
})

-- Click Kill Methods
local SecaoClickKill = AbaTrollPlayers:AddSection({ Name = "Métodos de Click" })

AbaTrollPlayers:AddButton({
    Name = "Click Fling Portas [Beta]",
    Description = "Para usar, recomendo chegar perto de outras portas, após ela ir até você, clique no jogador que deseja flingar",
    Callback = function()
        local Jogadores = game:GetService("Players")
        local Mundo = game:GetService("Workspace")
        local ServicoExecucao = game:GetService("RunService")
        local ServicoEntradaUsuario = game:GetService("UserInputService")
        local JogadorLocal = Jogadores.LocalPlayer
        local Personagem = JogadorLocal.Character or JogadorLocal.CharacterAdded:Wait()
        local HRP = Personagem:WaitForChild("HumanoidRootPart")
        
        local BuracoNegro = Instance.new("Part")
        BuracoNegro.Size = Vector3.new(100000, 100000, 100000)
        BuracoNegro.Transparency = 1
        BuracoNegro.Anchored = true
        BuracoNegro.CanCollide = false
        BuracoNegro.Name = "AlvoBuracoNegro"
        BuracoNegro.Parent = Mundo
        
        local anexoBase = Instance.new("Attachment")
        anexoBase.Name = "AnexoBuracoNegro"
        anexoBase.Parent = BuracoNegro
        
        ServicoExecucao.Heartbeat:Connect(function()
            BuracoNegro.CFrame = HRP.CFrame
        end)
        
        local PortasControladas = {}
        
        local function ConfigurarParte(parte)
            if not parte:IsA("BasePart") or parte.Anchored or not string.find(parte.Name, "Door") then return end
            if parte:FindFirstChild("Anexado") then return end
            parte.CanCollide = false
            for _, obj in ipairs(parte:GetChildren()) do
                if obj:IsA("AlignPosition") or obj:IsA("Torque") or obj:IsA("Attachment") then
                    obj:Destroy()
                end
            end
            local marcador = Instance.new("BoolValue", parte)
            marcador.Name = "Anexado"
            local a1 = Instance.new("Attachment", parte)
            local alinhar = Instance.new("AlignPosition", parte)
            alinhar.Attachment0 = a1
            alinhar.Attachment1 = anexoBase
            alinhar.MaxForce = 1e20
            alinhar.MaxVelocity = math.huge
            alinhar.Responsiveness = 99999
            local torque = Instance.new("Torque", parte)
            torque.Attachment0 = a1
            torque.RelativeTo = Enum.ActuatorRelativeTo.World
            torque.Torque = Vector3.new(math.random(-10e5, 10e5) * 10000, math.random(-10e5, 10e5) * 10000, math.random(-10e5, 10e5) * 10000)
            table.insert(PortasControladas, {Parte = parte, Alinhar = alinhar})
        end
        
        for _, obj in ipairs(Mundo:GetDescendants()) do
            if obj:IsA("BasePart") and string.find(obj.Name, "Door") then
                ConfigurarParte(obj)
            end
        end
        
        Mundo.DescendantAdded:Connect(function(obj)
            if obj:IsA("BasePart") and string.find(obj.Name, "Door") then
                ConfigurarParte(obj)
            end
        end)
        
        local function ArremessarJogador(jogador)
            local char = jogador.Character
            if not char then return end
            local hrpAlvo = char:FindFirstChild("HumanoidRootPart")
            if not hrpAlvo then return end
            local anexoAlvo = hrpAlvo:FindFirstChild("AnexoAlvo")
            if not anexoAlvo then
                anexoAlvo = Instance.new("Attachment", hrpAlvo)
                anexoAlvo.Name = "AnexoAlvo"
            end
            for _, dados in ipairs(PortasControladas) do
                if dados.Alinhar then
                    dados.Alinhar.Attachment1 = anexoAlvo
                end
            end
            local inicio = tick()
            while tick() - inicio < 5 do
                if hrpAlvo.Velocity.Magnitude >= 20 then break end
                ServicoExecucao.Heartbeat:Wait()
            end
            for _, dados in ipairs(PortasControladas) do
                if dados.Alinhar then
                    dados.Alinhar.Attachment1 = anexoBase
                end
            end
        end
        
        ServicoEntradaUsuario.TouchTap:Connect(function(posicoesToque, processado)
            if processado then return end
            local pos = posicoesToque[1]
            local camera = Mundo.CurrentCamera
            local raioUnidade = camera:ScreenPointToRay(pos.X, pos.Y)
            local resultadoRaio = Mundo:Raycast(raioUnidade.Origin, raioUnidade.Direction * 1000)
            if resultadoRaio and resultadoRaio.Instance then
                local acertado = resultadoRaio.Instance
                local jogador = Jogadores:GetPlayerFromCharacter(acertado:FindFirstAncestorOfClass("Model"))
                if jogador and jogador ~= JogadorLocal then
                    ArremessarJogador(jogador)
                end
            end
        end)
    end
})

AbaTrollPlayers:AddButton({
    Name = "Click Fling Sofá (Ferramenta)",
    Callback = function()
        local jogadores = game:GetService("Players")
        local rep = game:GetService("ReplicatedStorage")
        local entrada = game:GetService("UserInputService")
        local eu = jogadores.LocalPlayer
        local cam = workspace.CurrentCamera
        local podeClicar = true
        local ferramentaEquipada = false
        local CHAOS_FERRAMENTA = "Click Fling Sofa"
        local mochila = eu:WaitForChild("Backpack")
        
        if not mochila:FindFirstChild(CHAOS_FERRAMENTA) and not (eu.Character and eu.Character:FindFirstChild(CHAOS_FERRAMENTA)) then
            local ferramenta = Instance.new("Tool")
            ferramenta.Name = CHAOS_FERRAMENTA
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
            local raizAlvo = alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart")
            if not raiz or not raizAlvo then return end
            local boneco = eu.Character
            local humano = boneco:FindFirstChildOfClass("Humanoid")
            local posOriginal = raiz.CFrame
            
            rep:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
            task.wait(0.2)
            rep.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
            task.wait(0.3)
            local sofa = eu.Backpack:FindFirstChild("Couch")
            if sofa then sofa.Parent = boneco end
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
            cam.CameraSubject = alvo.Character:FindFirstChild("Head") or raizAlvo or humano
            
            task.spawn(function()
                local angulo = 0
                local partes = {raiz}
                while jogando and alvo and alvo.Character and alvo.Character:FindFirstChildOfClass("Humanoid") do
                    local alvoHum = alvo.Character:FindFirstChildOfClass("Humanoid")
                    if alvoHum.Sit then break end
                    angulo = angulo + 50
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

AbaTrollPlayers:AddButton({
    Name = "Click Fling Bola (Ferramenta)",
    Callback = function()
        local jogadores = game:GetService("Players")
        local rep = game:GetService("ReplicatedStorage")
        local mundo = game:GetService("Workspace")
        local entrada = game:GetService("UserInputService")
        local cam = mundo.CurrentCamera
        local eu = jogadores.LocalPlayer
        local CHAOS_FERRAMENTA = "Click Fling Bola"
        local ferramentaEquipada = false
        local mochila = eu:WaitForChild("Backpack")
        
        if not mochila:FindFirstChild(CHAOS_FERRAMENTA) then
            local ferramenta = Instance.new("Tool")
            ferramenta.Name = CHAOS_FERRAMENTA
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
        
        local function ArremessarBola(alvo)
            local jogadores = game:GetService("Players")
            local jogador = jogadores.LocalPlayer
            local personagem = jogador.Character or jogador.CharacterAdded:Wait()
            local humanoide = personagem:WaitForChild("Humanoid")
            local hrp = personagem:WaitForChild("HumanoidRootPart")
            local mochila = jogador:WaitForChild("Backpack")
            local BolasServidor = workspace.WorkspaceCom:WaitForChild("001_SoccerBalls")
            
            local function pegarBola()
                if not mochila:FindFirstChild("SoccerBall") and not personagem:FindFirstChild("SoccerBall") then
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "SoccerBall")
                end
                repeat task.wait() until mochila:FindFirstChild("SoccerBall") or personagem:FindFirstChild("SoccerBall")
                local bolaTool = mochila:FindFirstChild("SoccerBall")
                if bolaTool then bolaTool.Parent = personagem end
                repeat task.wait() until BolasServidor:FindFirstChild("Soccer" .. jogador.Name)
                return BolasServidor:FindFirstChild("Soccer" .. jogador.Name)
            end
            
            local Bola = BolasServidor:FindFirstChild("Soccer" .. jogador.Name) or pegarBola()
            Bola.CanCollide = false
            Bola.Massless = true
            Bola.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0)
            
            if alvo ~= jogador then
                local charAlvo = alvo.Character
                if charAlvo and charAlvo:FindFirstChild("HumanoidRootPart") and charAlvo:FindFirstChild("Humanoid") then
                    local raizAlvo = charAlvo.HumanoidRootPart
                    local humAlvo = charAlvo.Humanoid
                    if Bola:FindFirstChildWhichIsA("BodyVelocity") then
                        Bola:FindFirstChildWhichIsA("BodyVelocity"):Destroy()
                    end
                    local bv = Instance.new("BodyVelocity")
                    bv.Name = "PoderArremesso"
                    bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bv.P = 9e900
                    bv.Parent = Bola
                    workspace.CurrentCamera.CameraSubject = humAlvo
                    repeat
                        if raizAlvo.Velocity.Magnitude > 0 then
                            local pos = raizAlvo.Position + (raizAlvo.Velocity / 1.5)
                            Bola.CFrame = CFrame.new(pos)
                            Bola.Orientation = Bola.Orientation + Vector3.new(45, 60, 30)
                        else
                            for i, v in pairs(charAlvo:GetChildren()) do
                                if v:IsA("BasePart") and v.CanCollide and not v.Anchored then
                                    Bola.CFrame = v.CFrame
                                    task.wait(1/6000)
                                end
                            end
                        end
                        task.wait(1/6000)
                    until raizAlvo.Velocity.Magnitude > 1000 or humAlvo.Health <= 0 or not charAlvo:IsDescendantOf(workspace) or alvo.Parent ~= jogadores
                    workspace.CurrentCamera.CameraSubject = humanoide
                end
            end
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
                    ArremessarBola(jogador)
                end
            end
        end)
    end
})

AbaTrollPlayers:AddButton({
    Name = "Click Matar Sofá (Ferramenta)",
    Callback = function()
        local jogadores = game:GetService("Players")
        local rep = game:GetService("ReplicatedStorage")
        local loop = game:GetService("RunService")
        local mundo = game:GetService("Workspace")
        local entrada = game:GetService("UserInputService")
        local eu = jogadores.LocalPlayer
        local cam = mundo.CurrentCamera
        local CHAOS_FERRAMENTA = "Click Matar Sofa"
        local ferramentaEquipada = false
        local CHAOSAlvo = nil
        local loopTP = nil
        local sofaEquipado = false
        local base = nil
        local posInicial = nil
        local raiz = nil
        local mochila = eu:WaitForChild("Backpack")
        
        if not mochila:FindFirstChild(CHAOS_FERRAMENTA) then
            local ferramenta = Instance.new("Tool")
            ferramenta.Name = CHAOS_FERRAMENTA
            ferramenta.RequiresHandle = false
            ferramenta.CanBeDropped = false
            ferramenta.Equipped:Connect(function()
                ferramentaEquipada = true
            end)
            ferramenta.Unequipped:Connect(function()
                ferramentaEquipada = false
                CHAOSAlvo = nil
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
            CHAOSAlvo = alvo.Name
            local boneco = eu.Character
            if not boneco then return end
            posInicial = boneco:FindFirstChild("HumanoidRootPart") and boneco.HumanoidRootPart.CFrame
            raiz = boneco:FindFirstChild("HumanoidRootPart")
            pegarSofa()
            loopTP = loop.Heartbeat:Connect(function()
                local alvoAtual = jogadores:FindFirstChild(CHAOSAlvo)
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
                local alvoAtual = jogadores:FindFirstChild(CHAOSAlvo)
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

-- All Methods
local SecaoAllMethods = AbaTrollPlayers:AddSection({ Name = "Todos os Métodos" })

AbaTrollPlayers:AddButton({
    Name = "Matar Todos com Ônibus",
    Callback = function()
        local Jogadores = game:GetService("Players")
        local Mundo = game:GetService("Workspace")
        local ServicoExecucao = game:GetService("RunService")
        local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
        local destino = Vector3.new(145.51, -374.09, 21.58)
        local posOriginal = nil
        
        local function pegarOnibus()
            local veiculos = Mundo:FindFirstChild("Vehicles")
            if veiculos then return veiculos:FindFirstChild(Jogadores.LocalPlayer.Name.."Car") end
            return nil
        end
        
        local function rastrearJogador(nomeJogador, callback)
            while true do
                if nomeJogador then
                    local alvo = Jogadores:FindFirstChild(nomeJogador)
                    if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
                        local humanoideAlvo = alvo.Character:FindFirstChildOfClass("Humanoid")
                        if humanoideAlvo and humanoideAlvo.Sit then
                            local onibus = pegarOnibus()
                            if onibus then
                                onibus:SetPrimaryPartCFrame(CFrame.new(destino))
                                print("Jogador sentou, levando ônibus para o void!")
                                task.wait(0.2)
                                local function simularPulo()
                                    local humanoide = Jogadores.LocalPlayer.Character and Jogadores.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                                    if humanoide then humanoide:ChangeState(Enum.HumanoidStateType.Jumping) end
                                end
                                simularPulo()
                                print("Simulando primeiro pulo!")
                                task.wait(0.4)
                                simularPulo()
                                print("Simulando segundo pulo!")
                                task.wait(0.5)
                                if posOriginal then
                                    Jogadores.LocalPlayer.Character.HumanoidRootPart.CFrame = posOriginal
                                    print("Jogador voltou para a posição inicial")
                                    task.wait(0.1)
                                    local args = { [1] = "DeleteAllVehicles" }
                                    ArmazenamentoReplicado:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
                                    print("Todos os veículos foram deletados!")
                                end
                            end
                            break
                        else
                            local raizAlvo = alvo.Character.HumanoidRootPart
                            local tempo = tick() * 35
                            local deslocamentoLateral = math.sin(tempo) * 10
                            local deslocamentoFrontal = math.cos(tempo) * 20
                            local onibus = pegarOnibus()
                            if onibus then
                                onibus:SetPrimaryPartCFrame(raizAlvo.CFrame * CFrame.new(0, 0, deslocamentoFrontal))
                            end
                        end
                    end
                end
                ServicoExecucao.RenderStepped:Wait()
            end
            if callback then callback() end
        end
        
        local function iniciarMatarTodos(nomeJogador, callback)
            local nomeSelecionado = nomeJogador
            local jogador = Jogadores.LocalPlayer
            local personagem = jogador.Character or jogador.CharacterAdded:Wait()
            local torso = personagem:WaitForChild("HumanoidRootPart")
            posOriginal = torso.CFrame
            local onibus = pegarOnibus()
            if not onibus then
                torso.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                local eventoRemoto = ArmazenamentoReplicado:FindFirstChild("RE")
                if eventoRemoto and eventoRemoto:FindFirstChild("1Ca1r") then
                    eventoRemoto["1Ca1r"]:FireServer("PickingCar", "SchoolBus")
                end
                task.wait(1)
                onibus = pegarOnibus()
            end
            if onibus then
                local assento = onibus:FindFirstChild("Body") and onibus.Body:FindFirstChild("VehicleSeat")
                if assento and personagem:FindFirstChildOfClass("Humanoid") and not personagem.Humanoid.Sit then
                    repeat
                        torso.CFrame = assento.CFrame * CFrame.new(0, 2, 0)
                        task.wait()
                    until personagem.Humanoid.Sit or not onibus.Parent
                end
            end
            spawn(function()
                rastrearJogador(nomeSelecionado, callback)
            end)
        end
        
        local function executarParaTodosJogadores(jogadoresLista)
            if #jogadoresLista == 0 then return end
            local jogador = table.remove(jogadoresLista, 1)
            iniciarMatarTodos(jogador.Name, function()
                task.wait(0.5)
                executarParaTodosJogadores(jogadoresLista)
            end)
        end
        
        executarParaTodosJogadores(Jogadores:GetPlayers())
    end
})

AbaTrollPlayers:AddButton({
    Name = "Banimento de Casa em Todos",
    Callback = function()
        local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
        local Jogadores = game:GetService("Players")
        local Mundo = game:GetService("Workspace")
        
        local function executarScriptParaJogador(jogadorAlvo)
            local Jogador = game.Players.LocalPlayer
            local Mochila = Jogador.Backpack
            local Personagem = Jogador.Character
            local Humanoide = Personagem:FindFirstChildOfClass("Humanoid")
            local Raiz = Personagem:FindFirstChild("HumanoidRootPart")
            local Casas = game.Workspace:FindFirstChild("001_Lots")
            local PosAntiga = Raiz.CFrame
            local Angulos = 0
            local Veiculos = Mundo.Vehicles
            
            local function Verificar()
                if Jogador and Personagem and Humanoide and Raiz and Veiculos then
                    return true
                else
                    return false
                end
            end
            
            if Verificar() then
                local Casa = Casas:FindFirstChild(Jogador.Name.."House")
                if not Casa then
                    local CasaEscolhida
                    for _, Lote in pairs(Casas:GetChildren()) do
                        if Lote.Name == "For Sale" then
                            for _, num in pairs(Lote:GetDescendants()) do
                                if num:IsA("NumberValue") and num.Name == "Number" and num.Value < 25 and num.Value > 10 then
                                    CasaEscolhida = Lote
                                    break
                                end
                            end
                        end
                    end
                    local DetectorCompra = CasaEscolhida:FindFirstChild("BuyHouse")
                    if DetectorCompra and DetectorCompra:IsA("BasePart") then
                        Raiz.CFrame = DetectorCompra.CFrame + Vector3.new(0, -6, 0)
                        task.wait(0.5)
                        local ClickDetector = DetectorCompra:FindFirstChild("ClickDetector")
                        if ClickDetector then fireclickdetector(ClickDetector) end
                    end
                end
                task.wait(0.5)
                local PreCasa = Casas:FindFirstChild(Jogador.Name .. "House")
                if PreCasa then
                    task.wait(0.5)
                    local Numero
                    for i, x in pairs(PreCasa:GetDescendants()) do
                        if x.Name == "Number" and x:IsA("NumberValue") then
                            Numero = x
                        end
                    end
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gettin1gHous1e"):FireServer("PickingCustomHouse", "049_House", Numero.Value)
                end
                task.wait(0.5)
                local PCarro = Veiculos:FindFirstChild(Jogador.Name.."Car")
                if not PCarro then
                    if Verificar() then
                        Raiz.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                        task.wait(0.5)
                        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                        task.wait(0.5)
                        PCarro = Veiculos:FindFirstChild(Jogador.Name.."Car")
                        task.wait(0.5)
                        local Assento = PCarro:FindFirstChild("Body") and PCarro.Body:FindFirstChild("VehicleSeat")
                        if Assento then
                            repeat
                                task.wait()
                                Raiz.CFrame = Assento.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                            until Humanoide.Sit
                        end
                    end
                end
                task.wait(0.5)
                PCarro = Veiculos:FindFirstChild(Jogador.Name.."Car")
                if PCarro then
                    if not Humanoide.Sit then
                        local Assento = PCarro:FindFirstChild("Body") and PCarro.Body:FindFirstChild("VehicleSeat")
                        if Assento then
                            repeat
                                task.wait()
                                Raiz.CFrame = Assento.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                            until Humanoide.Sit
                        end
                    end
                    local Alvo = jogadorAlvo
                    local PersonagemAlvo = Alvo.Character
                    local HumanoideAlvo = PersonagemAlvo:FindFirstChildOfClass("Humanoid")
                    local RaizAlvo = PersonagemAlvo:FindFirstChild("HumanoidRootPart")
                    if PersonagemAlvo and HumanoideAlvo and RaizAlvo then
                        if not HumanoideAlvo.Sit then
                            while not HumanoideAlvo.Sit do
                                task.wait()
                                local Arremessar = function(alvo, pos, angulo)
                                    PCarro:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                                end
                                Angulos = Angulos + 100
                                Arremessar(RaizAlvo, CFrame.new(0, 1.5, 0) + HumanoideAlvo.MoveDirection * RaizAlvo.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angulos), 0, 0))
                                Arremessar(RaizAlvo, CFrame.new(0, -1.5, 0) + HumanoideAlvo.MoveDirection * RaizAlvo.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angulos), 0, 0))
                                Arremessar(RaizAlvo, CFrame.new(2.25, 1.5, -2.25) + HumanoideAlvo.MoveDirection * RaizAlvo.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angulos), 0, 0))
                                Arremessar(RaizAlvo, CFrame.new(-2.25, -1.5, 2.25) + HumanoideAlvo.MoveDirection * RaizAlvo.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angulos), 0, 0))
                                Arremessar(RaizAlvo, CFrame.new(0, 1.5, 0) + HumanoideAlvo.MoveDirection * RaizAlvo.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angulos), 0, 0))
                                Arremessar(RaizAlvo, CFrame.new(0, -1.5, 0) + HumanoideAlvo.MoveDirection * RaizAlvo.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(Angulos), 0, 0))
                            end
                            task.wait(0.2)
                            local Casa = Casas:FindFirstChild(Jogador.Name.."House")
                            PCarro:SetPrimaryPartCFrame(CFrame.new(Casa.HouseSpawnPosition.Position))
                            task.wait(0.2)
                            local regiao = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(30,30,30), game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(30,30,30))
                            local partes = workspace:FindPartsInRegion3(regiao, game.Players.LocalPlayer.Character.HumanoidRootPart, math.huge)
                            for i, v in pairs(partes) do
                                if v.Name == "HumanoidRootPart" then
                                    local b = game:GetService("Players"):FindFirstChild(v.Parent.Name)
                                    local args = { [1] = "BanPlayerFromHouse", [2] = b, [3] = v.Parent }
                                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))
                                end
                            end
                        end
                    end
                end
            end
            local argsDelete = { [1] = "DeleteAllVehicles" }
            ArmazenamentoReplicado:WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(argsDelete))
        end
        
        for _, jogador in pairs(Jogadores:GetPlayers()) do
            if jogador ~= Jogadores.LocalPlayer then
                executarScriptParaJogador(jogador)
                task.wait(2)
            end
        end
    end
})

AbaTrollPlayers:AddButton({
    Name = "Fling Barco em Todos",
    Callback = function()
        local Jogador = game.Players.LocalPlayer
        local Personagem = Jogador.Character
        local Humanoide = Personagem:FindFirstChildOfClass("Humanoid")
        local Raiz = Personagem:FindFirstChild("HumanoidRootPart")
        local Veiculos = game.Workspace:FindFirstChild("Vehicles")
        local PosAntiga = Raiz.CFrame
        local Angulos = 0
        local PCarro = Veiculos:FindFirstChild(Jogador.Name.."Car")
        
        if not PCarro then
            if Raiz then
                Raiz.CFrame = CFrame.new(1754, -2, 58)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingBoat", "MilitaryBoatFree")
                task.wait(0.5)
                PCarro = Veiculos:FindFirstChild(Jogador.Name.."Car")
                task.wait(0.5)
                local Assento = PCarro:FindFirstChild("Body") and PCarro.Body:FindFirstChild("VehicleSeat")
                if Assento then
                    repeat
                        task.wait()
                        Raiz.CFrame = Assento.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoide.Sit
                end
            end
        end
        
        task.wait(0.5)
        PCarro = Veiculos:FindFirstChild(Jogador.Name.."Car")
        
        if PCarro then
            if not Humanoide.Sit then
                local Assento = PCarro:FindFirstChild("Body") and PCarro.Body:FindFirstChild("VehicleSeat")
                if Assento then
                    repeat
                        task.wait()
                        Raiz.CFrame = Assento.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoide.Sit
                end
            end
        end
        
        local Giro = Instance.new("BodyGyro")
        Giro.Parent = PCarro.PrimaryPart
        Giro.MaxTorque = Vector3.new(1e7, 1e7, 1e7)
        Giro.P = 1e7
        Giro.CFrame = PCarro.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(90), 0)
        
        local function arremessarJogador(PersonagemAlvo, RaizAlvo, HumanoideAlvo)
            Angulos = 0
            local tempoFinal = tick() + 1
            while tick() < tempoFinal do
                Angulos = Angulos + 100
                task.wait()
                local matar = function(alvo, pos, angulo)
                    PCarro:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                end
                matar(RaizAlvo, CFrame.new(0, 3, 0), CFrame.Angles(math.rad(Angulos), 0, 0))
                matar(RaizAlvo, CFrame.new(0, -1.5, 2), CFrame.Angles(math.rad(Angulos), 0, 0))
                matar(RaizAlvo, CFrame.new(2, 1.5, 2.25), CFrame.Angles(math.rad(50), 0, 0))
                matar(RaizAlvo, CFrame.new(-2.25, -1.5, 2.25), CFrame.Angles(math.rad(30), 0, 0))
                matar(RaizAlvo, CFrame.new(0, 1.5, 0), CFrame.Angles(math.rad(Angulos), 0, 0))
                matar(RaizAlvo, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(Angulos), 0, 0))
            end
        end
        
        for _, Alvo in pairs(game.Players:GetPlayers()) do
            if Alvo ~= Jogador then
                local PersonagemAlvo = Alvo.Character
                local HumanoideAlvo = PersonagemAlvo and PersonagemAlvo:FindFirstChildOfClass("Humanoid")
                local RaizAlvo = PersonagemAlvo and PersonagemAlvo:FindFirstChild("HumanoidRootPart")
                if PersonagemAlvo and HumanoideAlvo and RaizAlvo then
                    arremessarJogador(PersonagemAlvo, RaizAlvo, HumanoideAlvo)
                end
            end
        end
        
        task.wait(0.5)
        PCarro:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
        task.wait(0.5)
        Humanoide.Sit = false
        task.wait(0.5)
        Raiz.CFrame = PosAntiga
        Giro:Destroy()
    end
})

AbaTrollPlayers:AddButton({
    Name = "Auto Fling em Todos",
    Callback = function()
        local Jogadores = game:GetService("Players")
        local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
        local JogadorLocal = Jogadores.LocalPlayer
        local cam = workspace.CurrentCamera
        
        local function ProcessarJogador(alvo)
            if not alvo or not alvo.Character or alvo == JogadorLocal then return end
            local flingAtivo = true
            local raiz = JogadorLocal.Character and JogadorLocal.Character:FindFirstChild("HumanoidRootPart")
            local raizAlvo = alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart")
            if not raiz or not raizAlvo then return end
            local char = JogadorLocal.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            local original = raiz.CFrame
            
            ArmazenamentoReplicado:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
            task.wait(0.2)
            ArmazenamentoReplicado.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
            task.wait(0.3)
            local ferramenta = JogadorLocal.Backpack:FindFirstChild("Couch")
            if ferramenta then ferramenta.Parent = char end
            task.wait(0.1)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
            task.wait(0.25)
            workspace.FallenPartsDestroyHeight = 0/0
            
            local bv = Instance.new("BodyVelocity")
            bv.Name = "ForcaFling"
            bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Parent = raiz
            hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            hum.PlatformStand = false
            cam.CameraSubject = alvo.Character:FindFirstChild("Head") or raizAlvo or hum
            
            task.spawn(function()
                local angulo = 0
                local partes = {raiz}
                while flingAtivo and alvo and alvo.Character and alvo.Character:FindFirstChildOfClass("Humanoid") do
                    local tHum = alvo.Character:FindFirstChildOfClass("Humanoid")
                    if tHum.Sit then break end
                    angulo = angulo + 50
                    for _, parte in ipairs(partes) do
                        local hrp = alvo.Character.HumanoidRootPart
                        local pos = hrp.Position + hrp.Velocity / 1.5
                        raiz.CFrame = CFrame.new(pos) * CFrame.Angles(math.rad(angulo), 0, 0)
                    end
                    raiz.Velocity = Vector3.new(9e8, 9e8, 9e8)
                    raiz.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                    task.wait()
                end
                flingAtivo = false
                bv:Destroy()
                hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                hum.PlatformStand = false
                raiz.CFrame = original
                cam.CameraSubject = hum
                for _, p in pairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.Velocity = Vector3.zero
                        p.RotVelocity = Vector3.zero
                    end
                end
                hum:UnequipTools()
                ArmazenamentoReplicado.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
            end)
            
            while flingAtivo do
                task.wait()
            end
        end
        
        for _, jogador in ipairs(Jogadores:GetPlayers()) do
            ProcessarJogador(jogador)
        end
    end
})

AbaTrollPlayers:AddButton({
    Name = "Puxar Todos com Sofá [Melhor]",
    Callback = function()
        local args = { [1] = "ClearAllTools" }
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
        wait(0.2)
        
        local posInicial = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        local parte = Instance.new("Part")
        parte.Size = Vector3.new(5000, 10, 5000)
        parte.Position = Vector3.new(0, -500, 0)
        parte.Anchored = true
        parte.CanCollide = true
        parte.Parent = game.Workspace
        task.wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -500, 0)
        wait(2)
        
        local ferramentaSelecionada = "Couch"
        local quantidadeDupe = 25
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        local remoteLimparFerramentas = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
        
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Duplicando", Text = "Não clique em nada enquanto duplica", Button1 = "Entendi", Duration = 5})
        
        local duplicando = true
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        
        wait(0.1)
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.5)
        
        for _, afh in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if afh.Name ~= ferramentaSelecionada then
                if afh:IsA("Tool") then
                    afh.Parent = game.Players.LocalPlayer.Backpack
                end
            end
        end
        
        for _, dvjbvj in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if dvjbvj:IsA("Tool") then
                if dvjbvj.Name ~= ferramentaSelecionada then
                    dvjbvj:Destroy()
                end
            end
        end
        
        for _, ddvdvdsvdfbrnytytmvdv in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if ddvdvdsvdfbrnytytmvdv:IsA("Tool") then
                if ddvdvdsvdfbrnytytmvdv.Name ~= ferramentaSelecionada then
                    ddvdvdsvdfbrnytytmvdv:Destroy()
                end
            end
        end
        
        local toollllfoun2 = false
        local tollllahhhh
        
        for _, toollel in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if toollel:IsA("Tool") then
                if toollel.Name == ferramentaSelecionada then
                    toollllfoun2 = true
                    for _, aijfw in pairs(toollel:GetDescendants()) do
                        if aijfw.Name == "Handle" then
                            aijfw.Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                            toollel.Parent = game.Players.LocalPlayer.Backpack
                            toollel.Parent = game.Players.LocalPlayer.Character
                            tollllahhhh = toollel
                            task.wait()
                        end
                    end
                else
                    toollllfoun2 = false
                end
            end
        end
        
        local toollllfoun = false
        local toolllffel
        
        for _, toollll in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if toollll:IsA("Tool") then
                if toollll.Name == ferramentaSelecionada then
                    toollllfoun = true
                    for _, jjsjsj in pairs(toollll:GetDescendants()) do
                        if jjsjsj.Name == "Handle" then
                            toollll.Parent = game.Players.LocalPlayer.Character
                            wait()
                            jjsjsj.Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                            toollll.Parent = game.Players.LocalPlayer.Backpack
                            toollll.Parent = game.Players.LocalPlayer.Character
                            toolllffel = toollll
                        end
                    end
                else
                    toollllfoun = false
                end
            end
        end
        
        if toollllfoun == true then
            if game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil then
                toollllfoun = false
            end
            repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil
            toollllfoun = false
        end
        
        if toollllfoun2 == true then
            if game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil then
                toollllfoun2 = false
            end
            repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil
            toollllfoun2 = false
        end
        
        wait(0.1)
        
        for m = 1, quantidadeDupe do
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = { [1] = "PickingTools", [2] = ferramentaSelecionada }
            remotePegarFerramenta:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Character
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[ferramentaSelecionada]:FindFirstChild("Handle").Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                task.wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaSelecionada) == nil
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframeAntigo
        wait()
        duplicando = false
        
        local contadorJogadores = 0
        for _, weifwwe in pairs(game.Players:GetPlayers()) do
            if weifwwe.Name ~= game.Players.LocalPlayer.Name then
                contadorJogadores = contadorJogadores + 1
            end
        end
        
        for m = 1, contadorJogadores do
            game.Players.LocalPlayer.Backpack.Couch.Name = "VortexSofa" .. m
        end
        
        wait()
        
        for _, iwiejguiwg in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if iwiejguiwg.Name:find("VortexSofa") then
                iwiejguiwg.Handle.Name = "Handle "
            end
        end
        
        wait(0.2)
        
        local function puxar(indice, alvo)
            if alvo == nil then return end
            game.Players.LocalPlayer.Backpack["VortexSofa"..indice]:FindFirstChild("Seat1").Disabled = true
            game.Players.LocalPlayer.Backpack["VortexSofa"..indice]:FindFirstChild("Seat2").Disabled = true
            game.Players.LocalPlayer.Backpack["VortexSofa"..indice].Parent = game.Players.LocalPlayer.Character
            
            local tet = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character["VortexSofa"..indice]:FindFirstChild("Handle "))
            tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            tet.P = 1250
            tet.Velocity = Vector3.new(0, 0, 0)
            tet.Name = "ForcaMovimento"
            
            repeat
                for m = 1, 35 do
                    local pos = {x = 0, y = 0, z = 0}
                    pos.x = alvo.Character.HumanoidRootPart.Position.X + alvo.Character.HumanoidRootPart.Velocity.X / 2
                    pos.y = alvo.Character.HumanoidRootPart.Position.Y + alvo.Character.HumanoidRootPart.Velocity.Y / 2
                    pos.z = alvo.Character.HumanoidRootPart.Position.Z + alvo.Character.HumanoidRootPart.Velocity.Z / 2
                    game.Players.LocalPlayer.Character["VortexSofa"..indice]:FindFirstChild("Seat1").CFrame = CFrame.new(Vector3.new(pos.x, pos.y, pos.z)) * CFrame.new(-2, 2, 0)
                    task.wait()
                end
                game.Players.LocalPlayer.Character["VortexSofa"..indice].Parent = game.Players.LocalPlayer.Backpack
                wait()
                game.Players.LocalPlayer.Backpack["VortexSofa"..indice]:FindFirstChild("Handle ").Name = "Handle"
                wait(0.2)
                game.Players.LocalPlayer.Backpack["VortexSofa"..indice].Parent = game.Players.LocalPlayer.Character
                wait()
                game.Players.LocalPlayer.Character["VortexSofa"..indice].Parent = game.Players.LocalPlayer.Backpack
                game.Players.LocalPlayer.Backpack["VortexSofa"..indice].Handle.Name = "Handle "
                wait(0.2)
                game.Players.LocalPlayer.Backpack["VortexSofa"..indice].Parent = game.Players.LocalPlayer.Character
                tet = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character["VortexSofa"..indice]:FindFirstChild("Seat1"))
                tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                tet.P = 1250
                tet.Velocity = Vector3.new(0, 0, 0)
                tet.Name = "ForcaMovimento"
            until alvo.Character.Humanoid.Sit == true
            
            wait()
            game.Players.LocalPlayer.Character["VortexSofa"..indice]:FindFirstChild("Handle "):FindFirstChild("ForcaMovimento"):Destroy()
            game.Players.LocalPlayer.Character["VortexSofa"..indice].Parent = game.Players.LocalPlayer.Backpack
            wait()
            game.Players.LocalPlayer.Backpack["VortexSofa"..indice]:FindFirstChild("Handle ").Name = "Handle"
            wait(0.2)
            game.Players.LocalPlayer.Backpack["VortexSofa"..indice].Parent = game.Players.LocalPlayer.Character
            wait()
            game.Players.LocalPlayer.Character["VortexSofa"..indice].Parent = game.Players.LocalPlayer.Backpack
        end
        
        local indiceAtual = 1
        for _, jogador in pairs(game.Players:GetPlayers()) do
            if jogador.Name ~= game.Players.LocalPlayer.Name then
                spawn(function()
                    puxar(indiceAtual, jogador)
                end)
                indiceAtual = indiceAtual + 1
            end
        end
        
        task.delay(14, function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(posInicial)
        end)
        
        task.delay(14.1, function()
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
        end)
    end
})

AbaTrollPlayers:AddButton({
    Name = "Matar Todos com Sofá [Melhor]",
    Callback = function()
        local args = { [1] = "ClearAllTools" }
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
        wait(0.2)
        
        local posInicial = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        local parte = Instance.new("Part")
        parte.Size = Vector3.new(5000, 10, 5000)
        parte.Position = Vector3.new(0, -500, 0)
        parte.Anchored = true
        parte.CanCollide = true
        parte.Parent = game.Workspace
        task.wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -500, 0)
        wait(2)
        
        local ferramentaSelecionada = "Couch"
        local quantidadeDupe = 25
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        local remoteLimparFerramentas = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
        
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Duplicando", Text = "Não clique em nada", Button1 = "Entendi", Duration = 5})
        
        local duplicando = true
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        
        wait(0.1)
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.5)
        
        for _, afh in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if afh.Name ~= ferramentaSelecionada then
                if afh:IsA("Tool") then
                    afh.Parent = game.Players.LocalPlayer.Backpack
                end
            end
        end
        
        for _, dvjbvj in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if dvjbvj:IsA("Tool") then
                if dvjbvj.Name ~= ferramentaSelecionada then
                    dvjbvj:Destroy()
                end
            end
        end
        
        for _, ddvdvdsvdfbrnytytmvdv in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if ddvdvdsvdfbrnytytmvdv:IsA("Tool") then
                if ddvdvdsvdfbrnytytmvdv.Name ~= ferramentaSelecionada then
                    ddvdvdsvdfbrnytytmvdv:Destroy()
                end
            end
        end
        
        local toollllfoun2 = false
        local tollllahhhh
        
        for _, toollel in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if toollel:IsA("Tool") then
                if toollel.Name == ferramentaSelecionada then
                    toollllfoun2 = true
                    for _, aijfw in pairs(toollel:GetDescendants()) do
                        if aijfw.Name == "Handle" then
                            aijfw.Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                            toollel.Parent = game.Players.LocalPlayer.Backpack
                            toollel.Parent = game.Players.LocalPlayer.Character
                            tollllahhhh = toollel
                            task.wait()
                        end
                    end
                else
                    toollllfoun2 = false
                end
            end
        end
        
        local toollllfoun = false
        local toolllffel
        
        for _, toollll in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if toollll:IsA("Tool") then
                if toollll.Name == ferramentaSelecionada then
                    toollllfoun = true
                    for _, jjsjsj in pairs(toollll:GetDescendants()) do
                        if jjsjsj.Name == "Handle" then
                            toollll.Parent = game.Players.LocalPlayer.Character
                            wait()
                            jjsjsj.Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                            toollll.Parent = game.Players.LocalPlayer.Backpack
                            toollll.Parent = game.Players.LocalPlayer.Character
                            toolllffel = toollll
                        end
                    end
                else
                    toollllfoun = false
                end
            end
        end
        
        if toollllfoun == true then
            if game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil then
                toollllfoun = false
            end
            repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil
            toollllfoun = false
        end
        
        if toollllfoun2 == true then
            if game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil then
                toollllfoun2 = false
            end
            repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil
            toollllfoun2 = false
        end
        
        wait(0.1)
        
        for m = 1, quantidadeDupe do
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = { [1] = "PickingTools", [2] = ferramentaSelecionada }
            remotePegarFerramenta:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Character
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[ferramentaSelecionada]:FindFirstChild("Handle").Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                task.wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaSelecionada) == nil
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframeAntigo
        wait()
        duplicando = false
        
        local contadorJogadores = 0
        for _, weifwwe in pairs(game.Players:GetPlayers()) do
            if weifwwe.Name ~= game.Players.LocalPlayer.Name then
                contadorJogadores = contadorJogadores + 1
            end
        end
        
        for m = 1, contadorJogadores do
            game.Players.LocalPlayer.Backpack.Couch.Name = "VortexSofaMorte" .. m
        end
        
        wait()
        
        for _, iwiejguiwg in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if iwiejguiwg.Name:find("VortexSofaMorte") then
                iwiejguiwg.Handle.Name = "Handle "
            end
        end
        
        wait(0.2)
        
        local function matar(indice, alvo)
            if alvo == nil then return end
            game.Players.LocalPlayer.Backpack["VortexSofaMorte"..indice]:FindFirstChild("Seat1").Disabled = true
            game.Players.LocalPlayer.Backpack["VortexSofaMorte"..indice]:FindFirstChild("Seat2").Disabled = true
            game.Players.LocalPlayer.Backpack["VortexSofaMorte"..indice].Parent = game.Players.LocalPlayer.Character
            
            local tet = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character["VortexSofaMorte"..indice]:FindFirstChild("Handle "))
            tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            tet.P = 1250
            tet.Velocity = Vector3.new(0, 0, 0)
            tet.Name = "ForcaMovimento"
            
            repeat
                for m = 1, 35 do
                    local pos = {x = 0, y = 0, z = 0}
                    pos.x = alvo.Character.HumanoidRootPart.Position.X + alvo.Character.HumanoidRootPart.Velocity.X / 2
                    pos.y = alvo.Character.HumanoidRootPart.Position.Y + alvo.Character.HumanoidRootPart.Velocity.Y / 2
                    pos.z = alvo.Character.HumanoidRootPart.Position.Z + alvo.Character.HumanoidRootPart.Velocity.Z / 2
                    game.Players.LocalPlayer.Character["VortexSofaMorte"..indice]:FindFirstChild("Seat1").CFrame = CFrame.new(Vector3.new(pos.x, pos.y, pos.z)) * CFrame.new(-2, 2, 0)
                    task.wait()
                end
                game.Players.LocalPlayer.Character["VortexSofaMorte"..indice].Parent = game.Players.LocalPlayer.Backpack
                wait()
                game.Players.LocalPlayer.Backpack["VortexSofaMorte"..indice]:FindFirstChild("Handle ").Name = "Handle"
                wait(0.2)
                game.Players.LocalPlayer.Backpack["VortexSofaMorte"..indice].Parent = game.Players.LocalPlayer.Character
                wait()
                game.Players.LocalPlayer.Character["VortexSofaMorte"..indice].Parent = game.Players.LocalPlayer.Backpack
                game.Players.LocalPlayer.Backpack["VortexSofaMorte"..indice].Handle.Name = "Handle "
                wait(0.2)
                game.Players.LocalPlayer.Backpack["VortexSofaMorte"..indice].Parent = game.Players.LocalPlayer.Character
                tet = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character["VortexSofaMorte"..indice]:FindFirstChild("Seat1"))
                tet.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                tet.P = 1250
                tet.Velocity = Vector3.new(0, 0, 0)
                tet.Name = "ForcaMovimento"
            until alvo.Character.Humanoid.Sit == true
            
            wait()
            game.Players.LocalPlayer.Character["VortexSofaMorte"..indice].Parent = game.Players.LocalPlayer.Backpack
            game.Players.LocalPlayer.Backpack["VortexSofaMorte"..indice]:FindFirstChild("Seat1").CFrame = CFrame.new(9999, -450, 9999)
            game.Players.LocalPlayer.Backpack["VortexSofaMorte"..indice]:FindFirstChild("Seat2").CFrame = CFrame.new(9999, -450, 9999)
            game.Players.LocalPlayer.Backpack["VortexSofaMorte"..indice].Parent = game.Players.LocalPlayer.Character
            task.wait(0.1)
            game.Players.LocalPlayer.Character["VortexSofaMorte"..indice].Parent = game.Players.LocalPlayer.Backpack
        end
        
        local indiceAtual = 1
        for _, jogador in pairs(game.Players:GetPlayers()) do
            if jogador.Name ~= game.Players.LocalPlayer.Name then
                spawn(function()
                    matar(indiceAtual, jogador)
                end)
                indiceAtual = indiceAtual + 1
            end
        end
        
        task.delay(14, function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(posInicial)
        end)
        
        task.delay(14.1, function()
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
        end)
    end
})

AbaTrollPlayers:AddButton({
    Name = "Arremessar Bola em Todos",
    Callback = function()
        local jogador = game:GetService("Players").LocalPlayer
        local BolasServidor = workspace.WorkspaceCom["001_SoccerBalls"]
        local MinhaBola = BolasServidor:FindFirstChild("Soccer"..jogador.Name)
        
        if not MinhaBola then
            if not jogador.Backpack:FindFirstChild("SoccerBall") then
                local args = {[1]="PickingTools",[2]="SoccerBall"}
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
                task.wait()
                jogador.Backpack.SoccerBall.Parent = jogador.Character
                repeat
                    MinhaBola = BolasServidor:FindFirstChild("Soccer"..jogador.Name)
                    task.wait()
                until MinhaBola
                jogador.Character.SoccerBall.Parent = jogador.Backpack
                task.wait()
            else
                jogador.Backpack.SoccerBall.Parent = jogador.Character
                repeat
                    MinhaBola = BolasServidor:FindFirstChild("Soccer"..jogador.Name)
                    task.wait()
                until MinhaBola
                jogador.Character.SoccerBall.Parent = jogador.Backpack
            end
        end
        
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                local alvo = v
                local PersonagemAlvo = alvo.Character or alvo.CharacterAdded:Wait()
                local RaizAlvo = PersonagemAlvo:WaitForChild("HumanoidRootPart")
                
                if not MinhaBola or not RaizAlvo then return end
                
                for _, v in pairs(MinhaBola:GetChildren()) do
                    if v:IsA("BodyMover") then
                        v:Destroy()
                    end
                end
                
                local corpoVelocidade = Instance.new("BodyVelocity")
                corpoVelocidade.Velocity = Vector3.new(9e8, 9e8, 9e8)
                corpoVelocidade.MaxForce = Vector3.new(1/0, 1/0, 1/0)
                corpoVelocidade.P = 1e10
                corpoVelocidade.Parent = MinhaBola
                
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(9e8, 9e8, 9e8)
                bv.MaxForce = Vector3.new(1/0, 1/0, 1/0)
                bv.P = 1e9
                bv.Parent = RaizAlvo
                
                local posAntiga = RaizAlvo.Position
                workspace.CurrentCamera.CameraSubject = RaizAlvo
                
                repeat
                    local velocidade = RaizAlvo.Velocity.Magnitude
                    local partes = {}
                    for _, parte in pairs(PersonagemAlvo:GetDescendants()) do
                        if parte:IsA("BasePart") and parte.CanCollide and not parte.Anchored then
                            table.insert(partes, parte)
                        end
                    end
                    for _, parte in ipairs(partes) do
                        local pos_x = alvo.Character.HumanoidRootPart.Position.X
                        local pos_y = alvo.Character.HumanoidRootPart.Position.Y
                        local pos_z = alvo.Character.HumanoidRootPart.Position.Z
                        pos_x = pos_x + (alvo.Character.HumanoidRootPart.Velocity.X / 1.5)
                        pos_y = pos_y + (alvo.Character.HumanoidRootPart.Velocity.Y / 1.5)
                        pos_z = pos_z + (alvo.Character.HumanoidRootPart.Velocity.Z / 1.5)
                        MinhaBola.CFrame = CFrame.new(pos_x, pos_y, pos_z)
                        task.wait(1/6000)
                    end
                    task.wait(1/6000)
                until RaizAlvo.Velocity.Magnitude > 5000 or PersonagemAlvo.Humanoid.Health == 0 or alvo.Parent ~= game.Players or RaizAlvo.Parent ~= PersonagemAlvo or PersonagemAlvo ~= alvo.Character
            end
        end
        
        workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    end
})

-- Aba Avatar
local AbaAvatar = Janela:MakeTab({
    Title = "Avatar",
    Icon = "rbxassetid://10734952036"
})

AbaAvatar:AddSection({ Name = "Copiar Skin" })

local JogadoresAvatar = game:GetService("Players")
local ArmazenamentoReplicadoAvatar = game:GetService("ReplicatedStorage")
local Remotes = ArmazenamentoReplicadoAvatar:WaitForChild("Remotes")
local AlvoAvatar = nil

local function obterNomesJogadores()
    local Nomes = {}
    for _, jogador in ipairs(JogadoresAvatar:GetPlayers()) do
        table.insert(Nomes, jogador.Name)
    end
    return Nomes
end

local DropdownAvatar = AbaAvatar:AddDropdown({
    Name = "Selecionar Jogador",
    Options = obterNomesJogadores(),
    Default = AlvoAvatar,
    Callback = function(Valor)
        AlvoAvatar = Valor
    end
})

local function atualizarDropdown()
    DropdownAvatar:Refresh(obterNomesJogadores(), true)
end

JogadoresAvatar.PlayerAdded:Connect(atualizarDropdown)
JogadoresAvatar.PlayerRemoving:Connect(atualizarDropdown)

AbaAvatar:AddButton({
    Name = "Copiar Avatar",
    Callback = function()
        if not AlvoAvatar then return end
        local JP = JogadoresAvatar.LocalPlayer
        local JChar = JP.Character
        local JogadorAlvo = JogadoresAvatar:FindFirstChild(AlvoAvatar)
        if JogadorAlvo and JogadorAlvo.Character then
            local JHumanoide = JChar and JChar:FindFirstChildOfClass("Humanoid")
            local THumanoide = JogadorAlvo.Character:FindFirstChildOfClass("Humanoid")
            if JHumanoide and THumanoide then
                local JDesc = JHumanoide:GetAppliedDescription()
                for _, acc in ipairs(JDesc:GetAccessories(true)) do
                    if acc.AssetId and tonumber(acc.AssetId) then
                        Remotes.Wear:InvokeServer(tonumber(acc.AssetId))
                        task.wait(0.2)
                    end
                end
                if tonumber(JDesc.Shirt) then
                    Remotes.Wear:InvokeServer(tonumber(JDesc.Shirt))
                    task.wait(0.2)
                end
                if tonumber(JDesc.Pants) then
                    Remotes.Wear:InvokeServer(tonumber(JDesc.Pants))
                    task.wait(0.2)
                end
                if tonumber(JDesc.Face) then
                    Remotes.Wear:InvokeServer(tonumber(JDesc.Face))
                    task.wait(0.2)
                end
                
                local PDesc = THumanoide:GetAppliedDescription()
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
                
                for _, v in ipairs(PDesc:GetAccessories(true)) do
                    if v.AssetId and tonumber(v.AssetId) then
                        Remotes.Wear:InvokeServer(tonumber(v.AssetId))
                        task.wait(0.3)
                    end
                end
                
                local CorPele = JogadorAlvo.Character:FindFirstChild("Body Colors")
                if CorPele then
                    Remotes.ChangeBodyColor:FireServer(tostring(CorPele.HeadColor))
                    task.wait(0.3)
                end
                
                if tonumber(PDesc.IdleAnimation) then
                    Remotes.Wear:InvokeServer(tonumber(PDesc.IdleAnimation))
                    task.wait(0.3)
                end
                
                local Mochila = JogadorAlvo:FindFirstChild("PlayersBag")
                if Mochila then
                    if Mochila:FindFirstChild("RPName") and Mochila.RPName.Value ~= "" then
                        Remotes.RPNameText:FireServer("RolePlayName", Mochila.RPName.Value)
                        task.wait(0.3)
                    end
                    if Mochila:FindFirstChild("RPBio") and Mochila.RPBio.Value ~= "" then
                        Remotes.RPNameText:FireServer("RolePlayBio", Mochila.RPBio.Value)
                        task.wait(0.3)
                    end
                    if Mochila:FindFirstChild("RPNameColor") then
                        Remotes.RPNameColor:FireServer("PickingRPNameColor", Mochila.RPNameColor.Value)
                        task.wait(0.3)
                    end
                    if Mochila:FindFirstChild("RPBioColor") then
                        Remotes.RPNameColor:FireServer("PickingRPBioColor", Mochila.RPBioColor.Value)
                        task.wait(0.3)
                    end
                end
            end
        end
    end
})

-- Aba Casas
local AbaCasas = Janela:MakeTab({
    Title = "Casas",
    Icon = "rbxassetid://home"
})

local coresRGB = {
    Color3.new(1, 0, 0),
    Color3.new(0, 1, 0),
    Color3.new(0, 0, 1),
    Color3.new(1, 1, 0),
    Color3.new(0, 1, 1),
    Color3.new(1, 0, 1)
}

local casaRGBActiva = false

local function mudarCorCasa()
    local armazenamentoReplicado = game:GetService("ReplicatedStorage")
    local eventoRemoto = armazenamentoReplicado:FindFirstChild("RE") and armazenamentoReplicado.RE:FindFirstChild("1Player1sHous1e")
    if not eventoRemoto then
        warn("RemoteEvent '1Player1sHous1e' não encontrado.")
        return
    end
    while casaRGBActiva do
        for _, cor in ipairs(coresRGB) do
            if not casaRGBActiva then return end
            local args = { [1] = "ColorPickHouse", [2] = cor }
            pcall(function()
                eventoRemoto:FireServer(unpack(args))
            end)
            task.wait(0.8)
        end
    end
end

local function alternarCasaRGB(estado)
    casaRGBActiva = estado
    if casaRGBActiva then
        print("Casa RGB Ativada")
        spawn(mudarCorCasa)
    else
        print("Casa RGB Desativada")
    end
end

local desbanimentoAtivo = false
local CasaSelecionada = nil
local NoClipPorta = nil

local function obterListaCasas()
    local Tabela = {}
    local lotes = workspace:FindFirstChild("001_Lots")
    if lotes then
        for _, Casa in ipairs(lotes:GetChildren()) do
            if Casa.Name ~= "For Sale" and Casa:IsA("Model") then
                table.insert(Tabela, Casa.Name)
            end
        end
    end
    return Tabela
end

pcall(function()
    AbaCasas:AddDropdown({
        Name = "Selecione a Casa",
        Options = obterListaCasas(),
        Default = "...",
        Callback = function(Valor)
            CasaSelecionada = Valor
            if NoClipPorta then
                NoClipPorta:Set(false)
            end
            print("Casa selecionada: " .. tostring(Valor))
        end
    })
end)

local function atualizarDropdownCasas()
    local Tabela = obterListaCasas()
    pcall(function()
        AbaCasas:ClearDropdown("Selecione a Casa")
        AbaCasas:AddDropdown({
            Name = "Selecione a Casa",
            Options = Tabela,
            Default = "...",
            Callback = function(Valor)
                CasaSelecionada = Valor
                if NoClipPorta then
                    NoClipPorta:Set(false)
                end
            end
        })
    end)
end

pcall(atualizarDropdownCasas)

pcall(function()
    AbaCasas:AddButton({
        Name = "Atualizar Lista de Casas",
        Callback = function()
            pcall(atualizarDropdownCasas)
        end
    })
end)

pcall(function()
    AbaCasas:AddButton({
        Name = "Teleportar para Casa",
        Callback = function()
            local Casa = workspace["001_Lots"]:FindFirstChild(tostring(CasaSelecionada))
            if Casa and game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Casa.WorldPivot.Position)
            else
                print("Casa não encontrada: " .. tostring(CasaSelecionada))
            end
        end
    })
end)

pcall(function()
    AbaCasas:AddButton({
        Name = "Teleportar para Cofre",
        Callback = function()
            local Casa = workspace["001_Lots"]:FindFirstChild(tostring(CasaSelecionada))
            if Casa and Casa:FindFirstChild("HousePickedByPlayer") and game.Players.LocalPlayer.Character then
                local cofre = Casa.HousePickedByPlayer.HouseModel:FindFirstChild("001_Safe")
                if cofre then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(cofre.WorldPivot.Position)
                else
                    print("Cofre não encontrado na casa: " .. tostring(CasaSelecionada))
                end
            else
                print("Casa não encontrada: " .. tostring(CasaSelecionada))
            end
        end
    })
end)

pcall(function()
    NoClipPorta = AbaCasas:AddToggle({
        Name = "Atravessar Porta da Casa",
        Description = "",
        Default = false,
        Callback = function(Valor)
            pcall(function()
                local Casa = workspace["001_Lots"]:FindFirstChild(tostring(CasaSelecionada))
                if Casa and Casa:FindFirstChild("HousePickedByPlayer") then
                    local casaEscolhida = Casa.HousePickedByPlayer
                    local portas = casaEscolhida.HouseModel:FindFirstChild("001_HouseDoors")
                    if portas and portas:FindFirstChild("HouseDoorFront") then
                        for _, Base in ipairs(portas.HouseDoorFront:GetChildren()) do
                            if Base:IsA("BasePart") then
                                Base.CanCollide = not Valor
                            end
                        end
                    end
                end
            end)
        end
    })
end)

pcall(function()
    AbaCasas:AddToggle({
        Name = "Tocar Campainha",
        Description = "",
        Default = false,
        Callback = function(Valor)
            getgenv().VortexHubAutoSpawnDoorbellValue = Valor
            spawn(function()
                while getgenv().VortexHubAutoSpawnDoorbellValue do
                    local Casa = workspace["001_Lots"]:FindFirstChild(tostring(CasaSelecionada))
                    if Casa and Casa:FindFirstChild("HousePickedByPlayer") then
                        local campainha = Casa.HousePickedByPlayer.HouseModel:FindFirstChild("001_DoorBell")
                        if campainha and campainha:FindFirstChild("TouchBell") then
                            pcall(function()
                                fireclickdetector(campainha.TouchBell.ClickDetector)
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
    AbaCasas:AddToggle({
        Name = "Bater na Porta",
        Description = "",
        Default = false,
        Callback = function(Valor)
            getgenv().VortexHubAutoSpawnDoorValue = Valor
            spawn(function()
                while getgenv().VortexHubAutoSpawnDoorValue do
                    local Casa = workspace["001_Lots"]:FindFirstChild(tostring(CasaSelecionada))
                    if Casa and Casa:FindFirstChild("HousePickedByPlayer") then
                        local portas = Casa.HousePickedByPlayer.HouseModel:FindFirstChild("001_HouseDoors")
                        if portas and portas:FindFirstChild("HouseDoorFront") and portas.HouseDoorFront:FindFirstChild("Knock") then
                            pcall(function()
                                fireclickdetector(portas.HouseDoorFront.Knock.TouchBell.ClickDetector)
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
    AbaCasas:AddSection({ Name = "Teleporte Para Casas" })
end)

local casasTeleporte = {
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

local casasOrdenadas = {}
for nome, _ in pairs(casasTeleporte) do
    table.insert(casasOrdenadas, nome)
end
table.sort(casasOrdenadas, function(a, b)
    local numA = tonumber(a:match("%d+")) or 0
    local numB = tonumber(b:match("%d+")) or 0
    return numA < numB
end)

pcall(function()
    AbaCasas:AddDropdown({
        Name = "Selecionar Casa",
        Options = casasOrdenadas,
        Callback = function(casaSelecionada)
            local jogador = game.Players.LocalPlayer
            if jogador and jogador.Character then
                jogador.Character.HumanoidRootPart.CFrame = CFrame.new(casasTeleporte[casaSelecionada])
            end
        end
    })
end)

pcall(function()
    AbaCasas:AddLabel("Teleporte para a Casa que Quiser")
end)

pcall(function()
    AbaCasas:AddSection({ Name = "Auto Desbanimento" })
end)

pcall(function()
    AbaCasas:AddToggle({
        Name = "Auto Desbanimento",
        Default = false,
        Callback = function(estado)
            desbanimentoAtivo = estado
            if desbanimentoAtivo then
                print("Auto Desbanimento Ativado")
                spawn(function()
                    while desbanimentoAtivo do
                        pcall(function()
                            for _, v in pairs(game:GetService("Workspace"):WaitForChild("001_Lots"):GetDescendants()) do
                                if v.Name:match("^BannedBlock%d+$") then
                                    v:Destroy()
                                end
                            end
                        end)
                        task.wait(1)
                    end
                end)
            else
                print("Auto Desbanimento Desativado")
            end
        end
    })
end)

pcall(function()
    AbaCasas:AddLabel("Te desbane automaticamente das Casas")
end)

pcall(function()
    AbaCasas:AddSection({ Name = "Casa RGB" })
end)

pcall(function()
    AbaCasas:AddToggle({
        Name = "Casa RGB",
        Default = false,
        Callback = function(estado)
            alternarCasaRGB(estado)
        end
    })
end)

pcall(function()
    AbaCasas:AddLabel("Deixa a sua casa RGB")
end)

-- Aba Áudio
local AbaAudio = Janela:MakeTab({
    Title = "Áudio",
    Icon = "rbxassetid://music"
})

AbaAudio:AddSection({ "Áudio para Todos os Jogadores" })

local audios = {
    {Name = "Yamete Kudasai", ID = 108494476595033},
    {Name = "Gritinho", ID = 5710016194},
    {Name = "Jumpscare Horroroso", ID = 85435253347146},
    {Name = "Áudio Alto", ID = 6855150757},
    {Name = "Ruído", ID = 120034877160791},
    {Name = "Jumpscare 2", ID = 110637995610528},
    {Name = "Risada Da Bruxa Minecraft", ID = 116214940486087},
    {Name = "The Boiled One", ID = 137177653817621},
    {Name = "Deitei Um Ave Maria Doido", ID = 128669424001766},
    {Name = "Mandrake Detected", ID = 9068077052},
    {Name = "Aaaaaaaaa", ID = 80156405968805},
    {Name = "AAAHHHH", ID = 9084006093},
    {Name = "amongus", ID = 6651571134},
    {Name = "Sus", ID = 6701126635},
    {Name = "Gritao AAAAAAAAA", ID = 5853668794},
    {Name = "UHHHHH COFFCOFF", ID = 7056720271},
    {Name = "SUS", ID = 7153419575},
    {Name = "Sonic.exe", ID = 2496367477},
    {Name = "Tubers93 1", ID = 270145703},
    {Name = "Tubers93 2", ID = 18131809532},
    {Name = "John's Laugh", ID = 130759239},
    {Name = "Nao sei KKKK", ID = 6549021381},
    {Name = "Grito", ID = 80156405968805},
    {Name = "audio estranho", ID = 7705506391},
    {Name = "AAAH", ID = 7772283448},
    {Name = "Gay, gay", ID = 18786647417},
    {Name = "Bat Hit", ID = 7129073354},
    {Name = "Nuclear Siren", ID = 675587093},
    {Name = "Sem ideia", ID = 7520729342},
    {Name = "Grito 2", ID = 91412024101709},
    {Name = "Estora tímpano", ID = 268116333},
    {Name = "[ Content Deleted ]", ID = 106835463235574},
    {Name = "Toma Jack", ID = 132603645477541},
    {Name = "Pede ifood pede", ID = 133843750864059},
    {Name = "I Ghost The down", ID = 84663543883498},
    {Name = "Compre OnLine Na shoope", ID = 8747441609},
    {Name = "Uh Que Nojo", ID = 103440368630269},
    {Name = "Sai dai Lava Prato", ID = 101232400175829},
    {Name = "Seloko num compensa", ID = 78442476709262},
    {Name = "(NEW) Chimpanzini Bananini Funk", ID = 137148228908678},
    {Name = "(NEW) Candyland - Tobu", ID = 118939739460633},
    {Name = "(NEW) Meme do Dom pollo What the hell", ID = 100656590080703},
    {Name = "(NEW) não to entendendo nd meme estourado", ID = 7962533987},
}

local audioSelecionadoID = nil

AbaAudio:AddTextBox({
    Name = "Insira o ID do Áudio ou Música",
    Description = "Digite o ID do áudio",
    PlaceholderText = "ID do áudio",
    Callback = function(valor)
        audioSelecionadoID = tonumber(valor)
    end
})

local nomesAudios = {}
for _, audio in ipairs(audios) do
    table.insert(nomesAudios, audio.Name)
end

AbaAudio:AddDropdown({
    Name = "Selecione o Áudio",
    Description = "Escolha um áudio da lista",
    Options = nomesAudios,
    Default = nomesAudios[1],
    Flag = "audio_selecionado",
    Callback = function(valor)
        for _, audio in ipairs(audios) do
            if audio.Name == valor then
                audioSelecionadoID = audio.ID
                break
            end
        end
    end
})

local loopAudio = false

AbaAudio:AddSection({ "Loop de Áudio" })

local function tocarAudioEmLoop()
    while loopAudio do
        if audioSelecionadoID then
            local args = { [1] = game:GetService("Workspace"), [2] = audioSelecionadoID, [3] = 1 }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))
            local som = Instance.new("Sound")
            som.SoundId = "rbxassetid://" .. audioSelecionadoID
            som.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
            som:Play()
        else
            warn("Nenhum áudio selecionado!")
        end
        task.wait(0.5)
    end
end

AbaAudio:AddToggle({
    Name = "Loop Tocar Áudio",
    Description = "Ativa o loop do áudio",
    Default = false,
    Flag = "audio_loop",
    Callback = function(valor)
        loopAudio = valor
        if loopAudio then
            task.spawn(tocarAudioEmLoop)
        end
    end
})

AbaAudio:AddParagraph({ "Info", "Loop de tocar áudio (Todos players do servidor ouvem)" })

local function tocarAudio()
    if audioSelecionadoID then
        local args = { [1] = game:GetService("Workspace"), [2] = audioSelecionadoID, [3] = 1 }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))
        local som = Instance.new("Sound")
        som.SoundId = "rbxassetid://" .. audioSelecionadoID
        som.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
        som:Play()
    else
        warn("Nenhum áudio selecionado!")
    end
end

AbaAudio:AddSection({ "Tocar Áudio" })
AbaAudio:AddButton({ "Tocar Áudio", function() tocarAudio() end })

local ArmazenamentoReplicadoAudio = game:GetService("ReplicatedStorage")
local audioIDFixo = 6314880174

local function Audio_All_Cliente(ID)
    local function VerificarPastaAudio()
        local PastaAudio = workspace:FindFirstChild("Audio all client")
        if not PastaAudio then
            PastaAudio = Instance.new("Folder")
            PastaAudio.Name = "Audio all client"
            PastaAudio.Parent = workspace
        end
        return PastaAudio
    end
    
    local function CriarSom(ID)
        if type(ID) ~= "number" then
            print("Insira um número válido!")
            return nil
        end
        local Pasta_Audio = VerificarPastaAudio()
        if Pasta_Audio then
            local Som = Instance.new("Sound")
            Som.SoundId = "rbxassetid://" .. ID
            Som.Volume = 1
            Som.Looped = false
            Som.Parent = Pasta_Audio
            Som:Play()
            task.wait(1)
            Som:Destroy()
        end
    end
    CriarSom(ID)
end

local function Audio_All_Servidor(ID)
    if type(ID) ~= "number" then
        print("Insira um número válido!")
        return nil
    end
    local EventoSom = ArmazenamentoReplicadoAudio:FindFirstChild("1Gu1nSound1s", true)
    if EventoSom then
        EventoSom:FireServer(workspace, ID, 1)
    end
end

AbaAudio:AddToggle({
    Name = "Estourar ouvido de geral",
    Description = "Toca áudio repetidamente para todos",
    Default = false,
    Flag = "audio_spam",
    Callback = function(valor)
        getgenv().Audio_All_loop_rapido = valor
        while getgenv().Audio_All_loop_rapido do
            Audio_All_Servidor(audioIDFixo)
            task.spawn(function()
                Audio_All_Cliente(audioIDFixo)
            end)
            task.wait(0.03)
        end
    end
})

AbaAudio:AddParagraph({ "Info", "Todos do servidor ouvem o áudio" })

-- Aba Lag Server
local AbaLag = Janela:MakeTab({
    Title = "Lag no Servidor",
    Icon = "rbxassetid://bomb"
})

local SecaoLag = AbaLag:AddSection({ Name = "Lags Experimentais" })

local lagAtivo = false
local lagCoroutine

AbaLag:AddToggle({
    Name = "Lag com Ônibus",
    Default = false,
    Callback = function(Valor)
        lagAtivo = Valor
        if lagAtivo then
            local Jogadores = game:GetService("Players")
            local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
            local JogadorLocal = Jogadores.LocalPlayer
            
            if not JogadorLocal then
                warn("JogadorLocal não encontrado.")
                return
            end
            
            local personagem = JogadorLocal.Character or JogadorLocal.CharacterAdded:Wait()
            local torso = personagem:WaitForChild("HumanoidRootPart", 5)
            
            if not torso then
                warn("HumanoidRootPart não encontrado.")
                return
            end
            
            local function pegarOnibus()
                local veiculos = workspace:FindFirstChild("Vehicles")
                if veiculos then
                    return veiculos:FindFirstChild(JogadorLocal.Name .. "Car")
                end
                return nil
            end
            
            local eventoRemoto = ArmazenamentoReplicado:FindFirstChild("RE")
            if not eventoRemoto then
                warn("RemoteEvent 'RE' não encontrado em ReplicatedStorage.")
                return
            end
            
            if not eventoRemoto:FindFirstChild("1Ca1r") then
                warn("Evento filho '1Ca1r' não encontrado dentro de 'RE'.")
                return
            end
            
            lagCoroutine = coroutine.wrap(function()
                while lagAtivo do
                    local sucesso, erro = pcall(function()
                        torso.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                        local onibus = pegarOnibus()
                        eventoRemoto["1Ca1r"]:FireServer("PickingCar", "SchoolBus")
                    end)
                    if not sucesso then
                        warn("Erro ao executar loop de lag: " .. tostring(erro))
                        lagAtivo = false
                        break
                    end
                    task.wait(0)
                end
            end)
            lagCoroutine()
        end
    end
})

local togglesLag = { LagLaptop = false }

local function clicarNormalmente(objeto)
    local clickDetector = objeto:FindFirstChildWhichIsA("ClickDetector")
    if clickDetector then
        fireclickdetector(clickDetector)
    end
end

local function lagarJogoLaptop(caminhoLaptop, maxTeleportes)
    if caminhoLaptop then
        local contadorTeleportes = 0
        while contadorTeleportes < maxTeleportes and togglesLag.LagLaptop do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = caminhoLaptop.CFrame
            clicarNormalmente(caminhoLaptop)
            contadorTeleportes = contadorTeleportes + 1
            wait(0.0001)
        end
    else
        warn("Laptop não encontrado.")
    end
end

AbaLag:AddToggle({
    Name = "Lag com Laptop (trava muito)",
    Default = false,
    Callback = function(estado)
        togglesLag.LagLaptop = estado
        if estado then
            local caminhoLaptop = workspace:FindFirstChild("WorkspaceCom"):FindFirstChild("001_GiveTools"):FindFirstChild("Laptop")
            if caminhoLaptop then
                spawn(function()
                    lagarJogoLaptop(caminhoLaptop, 999999999)
                end)
            else
                warn("Laptop não encontrado.")
            end
        else
            print("Lag com Laptop desativado.")
        end
    end
})

AbaLag:AddParagraph({ "Informação de Lag", "O efeito de lag começa após 20 segundos" })

togglesLag.LagPhone = false

local function lagarJogoPhone(caminhoPhone, maxTeleportes)
    if caminhoPhone then
        local contadorTeleportes = 0
        while contadorTeleportes < maxTeleportes and togglesLag.LagPhone do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = caminhoPhone.CFrame
            clicarNormalmente(caminhoPhone)
            contadorTeleportes = contadorTeleportes + 1
            wait(0.01)
        end
    else
        warn("Telefone não encontrado.")
    end
end

AbaLag:AddToggle({
    Name = "Lag com Telefone",
    Default = false,
    Callback = function(estado)
        togglesLag.LagPhone = estado
        if estado then
            local caminhoPhone = workspace:FindFirstChild("WorkspaceCom"):FindFirstChild("001_CommercialStores"):FindFirstChild("CommercialStorage1"):FindFirstChild("Store"):FindFirstChild("Tools"):FindFirstChild("Iphone")
            if caminhoPhone then
                spawn(function()
                    lagarJogoPhone(caminhoPhone, 999999)
                end)
            else
                warn("Telefone não encontrado.")
            end
        else
            print("Lag com Telefone desativado.")
        end
    end
})

AbaLag:AddParagraph({ "Informação de Lag", "O script começa a causar lag após 35 segundos" })

local BombaAtiva = false

AbaLag:AddToggle({
    Name = "Lag com Bomba",
    Default = false,
    Callback = function(Valor)
        if Valor then
            BombaAtiva = true
            local Jogador = game.Players.LocalPlayer
            local Personagem = Jogador.Character or Jogador.CharacterAdded:Wait()
            local Raiz = Personagem:WaitForChild("HumanoidRootPart")
            local Mundo = game:GetService("Workspace")
            local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
            local Bomba = Mundo:WaitForChild("WorkspaceCom"):WaitForChild("001_CriminalWeapons"):WaitForChild("GiveTools"):WaitForChild("Bomb")
            
            task.spawn(function()
                while BombaAtiva do
                    if Bomba and Raiz then
                        Raiz.CFrame = Bomba.CFrame
                        fireclickdetector(Bomba.ClickDetector)
                        task.wait(0.00001)
                    else
                        task.wait(0.0001)
                    end
                end
            end)
            
            task.spawn(function()
                while BombaAtiva do
                    if Bomba and Raiz then
                        local GerenciadorEntradaVirtual = game:GetService("VirtualInputManager")
                        GerenciadorEntradaVirtual:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                        task.wait(1.5)
                        GerenciadorEntradaVirtual:SendMouseButtonEvent(500, 500, 0, false, game, 0)
                        local args = { [1] = "Bomb" .. Jogador.Name }
                        ArmazenamentoReplicado:WaitForChild("RE"):WaitForChild("1Blo1wBomb1sServe1r"):FireServer(unpack(args))
                    end
                    task.wait(1.5)
                end
            end)
        else
            BombaAtiva = false
        end
    end
})

AbaLag:AddParagraph({ "Informação de Lag", "O script começa a causar lag após 35 segundos" })

-- Aba Nomes
local AbaNomes = Janela:MakeTab({
    Title = "Nomes",
    Icon = "rbxassetid://paper"
})

local nomeAtivo = false
local bioAtivo = false

AbaNomes:AddSection({ Name = "Nome RGB" })
AbaNomes:AddToggle({
    Name = "Nome RGB",
    Description = "Ativar Nome RGB",
    Default = false,
    Callback = function(valor)
        nomeAtivo = valor
        print(valor and "Nome RGB ativado" or "Nome RGB desativado")
    end
})

AbaNomes:AddSection({ Name = "Bio RGB" })
AbaNomes:AddToggle({
    Name = "Bio RGB",
    Description = "Ativar Bio RGB",
    Default = false,
    Callback = function(valor)
        bioAtivo = valor
        print(valor and "Bio RGB ativado" or "Bio RGB desativado")
    end
})

local coresVibrantes = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 165, 0),
    Color3.fromRGB(128, 0, 128),
    Color3.fromRGB(255, 20, 147)
}

spawn(function()
    while true do
        if nomeAtivo then
            local corAleatoria = coresVibrantes[math.random(#coresVibrantes)]
            local args = { [1] = "PickingRPNameColor", [2] = corAleatoria }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r"):FireServer(unpack(args))
        end
        wait(0.7)
    end
end)

spawn(function()
    while true do
        if bioAtivo then
            local corAleatoria = coresVibrantes[math.random(#coresVibrantes)]
            local args = { [1] = "PickingRPBioColor", [2] = corAleatoria }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1RPNam1eColo1r"):FireServer(unpack(args))
        end
        wait(0.7)
    end
end)

AbaNomes:AddSection({ Name = "Adicionar Nomes no Jogador" })

local nomes = {
    {"Anônimo", " Anônimo "},
    {"PRO", " PRO "},
    {"ERR0R_666", " ERR0R_666 "},
    {"DARKNE1SSS", " DARKNE1SSS "},
    {"FANTASMA", " FANTASMA "},
    {"CORINGA", " CORINGA "},
    {"ADMIN", " ADMIN "},
    {"TUBERS93", " TUBERS 93 "},
    {"CO0LKID", " CO0 LKID "},
    {"JOGO ATACADO PELA MÁFIA", " JOGO ATACADO PELA MÁFIA "},
    {"INC0MUN", " INC0MUN"},
    {"BAD BOY", " BAD BOY "}
}

for _, nome in ipairs(nomes) do
    AbaNomes:AddButton({
        Name = "Nome: " .. nome[1],
        Callback = function()
            game:GetService("ReplicatedStorage").RE["1RPNam1eTex1t"]:FireServer("RolePlayName", nome[2])
        end
    })
end

-- Aba Carro
local AbaCarro = Janela:MakeTab({
    Title = "Carro",
    Icon = "rbxassetid://car"
})

local coresCarro = {
    Color3.new(1, 0, 0),
    Color3.new(0, 1, 0),
    Color3.new(0, 0, 1),
    Color3.new(1, 1, 0),
    Color3.new(1, 0, 1),
    Color3.new(0, 1, 1),
    Color3.new(0.5, 0, 0.5),
    Color3.new(1, 0.5, 0)
}

local armazenamentoReplicadoCarro = game:GetService("ReplicatedStorage")
local eventoRemotoCarro = armazenamentoReplicadoCarro:WaitForChild("RE"):WaitForChild("1Player1sCa1r")

local corMudando = false
local coroutineCor = nil

local function mudarCorCarro()
    while corMudando do
        for _, cor in ipairs(coresCarro) do
            if not corMudando then return end
            local args = { [1] = "PickingCarColor", [2] = cor }
            eventoRemotoCarro:FireServer(unpack(args))
            wait(1)
        end
    end
end

AbaCarro:AddButton({
    Name = "Remover Todos os Carros",
    Callback = function()
        local executando = false
        if executando == true then return end
        executando = true
        local nomeBarco = "MilitaryBoatFree"
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1754, -2, 58)
        wait(0.3)
        local args = { [1] = "PickingBoat", [2] = nomeBarco }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
        wait(1)
        local assentoCarro
        for _, errb in pairs(game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"]:GetDescendants()) do
            if errb:IsA("VehicleSeat") then
                assentoCarro = errb
            end
        end
        repeat
            if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then return end
            if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                if not game.Players.LocalPlayer.Character.Humanoid.SeatPart == assentoCarro then
                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                end
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = assentoCarro.CFrame
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = assentoCarro.CFrame + Vector3.new(0,1,0)
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = assentoCarro.CFrame + Vector3.new(0,-1,0)
            task.wait()
        until game.Players.LocalPlayer.Character.Humanoid.SeatPart == assentoCarro
        
        for _, wifn in pairs(game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"]:GetDescendants()) do
            if wifn.Name == "PhysicalWheel" then
                wifn:Destroy()
            end
        end
        
        local ARREMESSO = Instance.new("BodyThrust", game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass)
        ARREMESSO.Force = Vector3.new(50000, 0, 50000)
        ARREMESSO.Name = "VORTEX FLING"
        ARREMESSO.Location = game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.Position
        
        for _, wvwvwasc in pairs(game.workspace.Vehicles:GetChildren()) do
            for _, ascegr in pairs(wvwvwasc:GetDescendants()) do
                if ascegr.Name == "VehicleSeat" then
                    local carroAlvo = ascegr
                    local tet = Instance.new("BodyVelocity", game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass)
                    tet.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                    tet.P = 1250
                    tet.Velocity = Vector3.new(0,0,0)
                    tet.Name = "ForcaMovimento"
                    for m = 1, 25 do
                        local pos = {x = 0, y = 0, z = 0}
                        pos.x = carroAlvo.Position.X
                        pos.y = carroAlvo.Position.Y
                        pos.z = carroAlvo.Position.Z
                        pos.x = pos.x + carroAlvo.Velocity.X / 2
                        pos.y = pos.y + carroAlvo.Velocity.Y / 2
                        pos.z = pos.z + carroAlvo.Velocity.Z / 2
                        if pos.y <= -200 then
                            game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(0,1000,0)
                        else
                            game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z))
                            task.wait()
                            game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) + Vector3.new(0,-2,0)
                            task.wait()
                            game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) * CFrame.new(0,0,2)
                            task.wait()
                            game.workspace.Vehicles[game.Players.LocalPlayer.Name.."Car"].Chassis.Mass.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z)) * CFrame.new(2,0,0)
                            task.wait()
                        end
                        task.wait()
                    end
                end
            end
        end
        
        task.wait()
        local args = { [1] = "DeleteAllVehicles" }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
        wait()
        local tet = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
        tet.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        tet.P = 1250
        tet.Velocity = Vector3.new(0,0,0)
        tet.Name = "ForcaMovimento"
        wait(0.1)
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframeAntigo
        end
        wait(1)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframeAntigo
        wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("ForcaMovimento"):Destroy()
        wait(0.2)
        executando = false
    end
})

AbaCarro:AddParagraph({ "Informação:", "Recomendo usar 2 vezes para garantir que todos os veículos sejam removidos" })

AbaCarro:AddButton({
    Name = "Puxar Todos os Carros",
    Callback = function()
        for _, v in next, workspace.Vehicles:GetChildren() do
            v:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character:GetPrimaryPartCFrame())
        end
    end
})

AbaCarro:AddParagraph({ "Informação:", "Puxa todos os carros do servidor até você" })

-- Speed V1
AbaCarro:AddSection({ "Velocidade V1" })

local Velocidade = 50
local Turbo = 50

local function AlterarVelocidadeCarro(valorVelocidade, valorTurbo)
    local jogador = game.Players.LocalPlayer
    local carro = workspace.Vehicles:FindFirstChild(jogador.Name .. "Car")
    if carro then
        local body = carro:FindFirstChild("Body").VehicleSeat
        if body then
            body.TopSpeed.Value = valorVelocidade
            body.Turbo.Value = valorTurbo
            wait(0.1)
            redzlib:MakeNotification({ Name = "Original by Mafia Hub", Content = "Pronto, você pode se mover agora!", Time = 5 })
        else
            redzlib:MakeNotification({ Name = "Erro", Content = "Entre no carro primeiro!", Time = 5 })
        end
    else
        redzlib:MakeNotification({ Name = "Erro", Content = "Coloque um carro primeiro!", Time = 5 })
    end
end

AbaCarro:AddTextBox({
    Name = "Velocidade",
    PlaceholderText = "50",
    Callback = function(valor)
        local novaVelocidade = tonumber(valor)
        if novaVelocidade then Velocidade = novaVelocidade end
    end
})

AbaCarro:AddTextBox({
    Name = "Turbo",
    PlaceholderText = "50",
    Callback = function(valor)
        local novoTurbo = tonumber(valor)
        if novoTurbo then Turbo = novoTurbo end
    end
})

AbaCarro:AddTextBox({
    Name = "Drift",
    PlaceholderText = "50",
    Callback = function(valor)
        local args = { [1] = "DriftingNumber", [2] = valor }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sCa1r"):FireServer(unpack(args))
    end
})

AbaCarro:AddButton({
    Name = "Aplicar Velocidade, Turbo e Drift",
    Callback = function()
        AlterarVelocidadeCarro(Velocidade, Turbo)
    end
})

-- Turbo V2
AbaCarro:AddSection({ "Turbo V2" })

AbaCarro:AddButton({
    Name = "Turbo V2 [Melhor]",
    Callback = function()
        local jogador = game.Players.LocalPlayer
        local personagem = jogador.Character or jogador.CharacterAdded:Wait()
        local torso = personagem:FindFirstChild("HumanoidRootPart")
        local voando = false
        local velocidade = 30
        local telaGui = Instance.new("ScreenGui", jogador.PlayerGui)
        
        local function criarBotaoImagem(nome, posicao, idImagem, rotacao, acao)
            local botao = Instance.new("ImageButton", telaGui)
            botao.Size = UDim2.new(0, 60, 0, 60)
            botao.Position = posicao
            botao.BackgroundTransparency = 1
            botao.Image = "rbxassetid://" .. idImagem
            botao.Rotation = rotacao
            botao.MouseButton1Down:Connect(acao)
            return botao
        end
        
        local botaoFrente = criarBotaoImagem("BotaoFrente", UDim2.new(0, 10, 0.35, 0), "18478249606", 0, function()
            voando = true
            while voando do
                if torso then torso.Velocity = torso.CFrame.LookVector * velocidade end
                task.wait()
            end
        end)
        
        local botaoTras = criarBotaoImagem("BotaoTras", UDim2.new(0, 10, 0.5, 0), "18478249606", 180, function()
            voando = true
            while voando do
                if torso then torso.Velocity = -torso.CFrame.LookVector * velocidade end
                task.wait()
            end
        end)
        
        local botaoEsquerda = criarBotaoImagem("BotaoEsquerda", UDim2.new(1, -210, 0.3, 0), "18478249606", -90, function()
            voando = true
            while voando do
                if torso then torso.Velocity = -torso.CFrame.RightVector * velocidade end
                task.wait()
            end
        end)
        
        local botaoDireita = criarBotaoImagem("BotaoDireita", UDim2.new(1, -140, 0.3, 0), "18478249606", 90, function()
            voando = true
            while voando do
                if torso then torso.Velocity = torso.CFrame.RightVector * velocidade end
                task.wait()
            end
        end)
        
        local function pararVoo()
            voando = false
            if torso then torso.Velocity = Vector3.new(0, 0, 0) end
        end
        
        botaoFrente.MouseButton1Up:Connect(pararVoo)
        botaoTras.MouseButton1Up:Connect(pararVoo)
        botaoEsquerda.MouseButton1Up:Connect(pararVoo)
        botaoDireita.MouseButton1Up:Connect(pararVoo)
        
        local botaoTurbo = Instance.new("ImageButton", telaGui)
        botaoTurbo.Size = UDim2.new(0, 60, 0, 60)
        botaoTurbo.Position = UDim2.new(1, -130, 0, 10)
        botaoTurbo.BackgroundTransparency = 1
        botaoTurbo.Image = "rbxassetid://97607579386418"
        botaoTurbo.MouseButton1Down:Connect(function()
            velocidade = 300
        end)
        
        local botaoMinimizar = Instance.new("TextButton", telaGui)
        botaoMinimizar.Size = UDim2.new(0, 60, 0, 60)
        botaoMinimizar.Position = UDim2.new(0, 10, 0, 10)
        botaoMinimizar.BackgroundTransparency = 1
        botaoMinimizar.Text = "-"
        botaoMinimizar.TextSize = 40
        botaoMinimizar.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        local botoes = {botaoFrente, botaoTras, botaoEsquerda, botaoDireita, botaoTurbo}
        local minimizado = false
        
        local function alternarBotoes()
            minimizado = not minimizado
            for _, botao in ipairs(botoes) do
                botao.Visible = not minimizado
            end
            if minimizado then
                botaoMinimizar.Text = "+"
            else
                botaoMinimizar.Text = "-"
            end
        end
        
        botaoMinimizar.MouseButton1Down:Connect(alternarBotoes)
    end
})

AbaCarro:AddParagraph({ "Informação:", "Ambos os turbos não precisam de Gamepass" })

-- Música para Carros
AbaCarro:AddSection({ "Música para Carros e Casas" })

local musicasIds = {
    "71373562243752", "138129019858244", "138480372357526", "122199933878670", "74187181906707",
    "82793916573031", "107421761958790", "91394092603440", "113198957973421", "81452315991527",
    "93786060174790", "74752089069476", "131592235762789", "132081774507495", "124394293950763",
    "83381647646350", "16190782181", "1841682637", "3148329638", "124928367733395", "106317184644394",
    "100247055114504", "107035638005233", "109351649716900", "84751398517083", "125259969174449",
    "89269071829332", "88094479399489", "72440232513341", "92893359226454", "111281710445018",
    "98677515506006", "105882833374061", "104541292443133", "105832154444494", "84733736048142",
    "94718473830640", "130324826943718", "123039027577735", "113312785512702", "139161205970637",
    "113768944849093", "135667903253566", "81335392002580", "77428091165211", "14145624031",
    "8080255618", "8654835474", "13530439502", "18841894272", "90323407842935", "136932193331774",
    "113504863495384", "1836175030", "79998949362539", "109188610023287", "134939857094956",
    "132245626038510", "124567809277408", "72591334498716", "76578817848504", "17422156627",
    "81902909302285", "130449561461006", "110519234838026", "106434295960535", "86271123924168",
    "85481949732828", "106476166672589", "87968531262747", "73966367524216", "137962454483542",
    "98371771055411", "111668097052966", "140095882383991", "122873874738223", "105461615542794"
}

local function tocarMusicaCarro(idMusica)
    if idMusica and idMusica ~= "" then
        local args = { [1] = "PickingCarMusicText", [2] = idMusica }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Player1sCa1r"):FireServer(unpack(args))
    end
end

local function tocarMusicaPatinete(idMusica)
    if idMusica and idMusica ~= "" then
        local args = { [1] = "PickingScooterMusicText", [2] = idMusica }
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1NoMoto1rVehicle1s"):FireServer(unpack(args))
    end
end

local function tocarMusicaCasa(idMusica)
    if idMusica and idMusica ~= "" then
        local args = { [1] = "PickHouseMusicText", [2] = idMusica }
        game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Player1sHous1e"):FireServer(unpack(args))
    end
end

AbaCarro:AddTextBox({
    Name = "ID da Música (Requer Gamepass)",
    PlaceholderText = "Digite o ID da Música",
    Callback = function(valor)
        tocarMusicaCarro(valor)
        tocarMusicaPatinete(valor)
        tocarMusicaCasa(valor)
    end
})

AbaCarro:AddDropdown({
    Name = "Selecionar Música (Requer Gamepass)",
    Options = musicasIds,
    Callback = function(valor)
        tocarMusicaCarro(valor)
        tocarMusicaPatinete(valor)
        tocarMusicaCasa(valor)
    end
})

AbaCarro:AddParagraph({ "Nota", "O script de música funciona em todos os carros e casas" })

-- Carro RGB
AbaCarro:AddSection({ "Carro RGB" })

AbaCarro:AddToggle({
    Name = "Carro RGB",
    Default = false,
    Callback = function(estado)
        corMudando = estado
        if corMudando then
            coroutineCor = coroutine.create(mudarCorCarro)
            coroutine.resume(coroutineCor)
        end
    end
})

AbaCarro:AddParagraph({ "Nota", "Ativando isso deixará seu carro RGB" })

-- Spam de Buzina
AbaCarro:AddSection({ "Spam de Buzina" })

local spammando = false
local argsBuzina = {"Horn"}

local function spamBuzina()
    while spammando do
        eventoRemotoCarro:FireServer(unpack(argsBuzina))
        wait(0.1)
    end
end

AbaCarro:AddToggle({
    Name = "Spam de Buzina",
    Default = false,
    Callback = function(valor)
        spammando = valor
        if spammando then
            spawn(spamBuzina)
        end
    end
})

-- Fly Car
AbaCarro:AddSection({ "Voar com Carro" })

AbaCarro:AddButton({
    Name = "Voar com Carro",
    Callback = function()
        local FlyGuiV2 = Instance.new("ScreenGui")
        local Arrastar = Instance.new("Frame")
        local FrameFly = Instance.new("Frame")
        local Titulo = Instance.new("TextButton")
        local VelocidadeBox = Instance.new("TextBox")
        local Fly = Instance.new("TextButton")
        local VelocidadeLabel = Instance.new("TextLabel")
        local Status = Instance.new("TextLabel")
        local StatusValor = Instance.new("TextLabel")
        local Unfly = Instance.new("TextButton")
        local Vfly = Instance.new("TextLabel")
        local Fechar = Instance.new("TextButton")
        local Minimizar = Instance.new("TextButton")
        local FlyOn = Instance.new("Frame")
        local W = Instance.new("TextButton")
        local S = Instance.new("TextButton")
        
        FlyGuiV2.Name = "FlyGuiV2"
        FlyGuiV2.Parent = game.CoreGui
        FlyGuiV2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        Arrastar.Name = "Arrastar"
        Arrastar.Parent = FlyGuiV2
        Arrastar.Active = true
        Arrastar.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
        Arrastar.BorderSizePixel = 0
        Arrastar.Draggable = true
        Arrastar.Position = UDim2.new(0.482438415, 0, 0.454874992, 0)
        Arrastar.Size = UDim2.new(0, 237, 0, 27)
        
        FrameFly.Name = "FrameFly"
        FrameFly.Parent = Arrastar
        FrameFly.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        FrameFly.BorderSizePixel = 0
        FrameFly.Draggable = true
        FrameFly.Position = UDim2.new(-0.00200000009, 0, 0.989000022, 0)
        FrameFly.Size = UDim2.new(0, 237, 0, 139)
        
        Titulo.Name = "Titulo"
        Titulo.Parent = FrameFly
        Titulo.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
        Titulo.BorderSizePixel = 0
        Titulo.Position = UDim2.new(-0.000210968778, 0, -0.00395679474, 0)
        Titulo.Size = UDim2.new(0, 237, 0, 27)
        Titulo.Font = Enum.Font.SourceSans
        Titulo.Text = "by GODENOT"
        Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
        Titulo.TextScaled = true
        Titulo.TextSize = 14.000
        Titulo.TextWrapped = true
        
        VelocidadeBox.Name = "VelocidadeBox"
        VelocidadeBox.Parent = FrameFly
        VelocidadeBox.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
        VelocidadeBox.BorderColor3 = Color3.fromRGB(0, 0, 191)
        VelocidadeBox.BorderSizePixel = 0
        VelocidadeBox.Position = UDim2.new(0.445025861, 0, 0.402877688, 0)
        VelocidadeBox.Size = UDim2.new(0, 111, 0, 33)
        VelocidadeBox.Font = Enum.Font.SourceSans
        VelocidadeBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
        VelocidadeBox.Text = "50"
        VelocidadeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        VelocidadeBox.TextScaled = true
        VelocidadeBox.TextSize = 14.000
        VelocidadeBox.TextWrapped = true
        
        Fly.Name = "Fly"
        Fly.Parent = FrameFly
        Fly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
        Fly.BorderSizePixel = 0
        Fly.Position = UDim2.new(0.0759493634, 0, 0.705797076, 0)
        Fly.Size = UDim2.new(0, 199, 0, 32)
        Fly.Font = Enum.Font.SourceSans
        Fly.Text = "Ativar"
        Fly.TextColor3 = Color3.fromRGB(255, 255, 255)
        Fly.TextScaled = true
        Fly.TextSize = 14.000
        Fly.TextWrapped = true
        
        Fly.MouseButton1Click:Connect(function()
            local torso = game.Players.LocalPlayer.Character.HumanoidRootPart
            Fly.Visible = false
            StatusValor.Text = "Ligado"
            StatusValor.TextColor3 = Color3.fromRGB(0, 255, 0)
            Unfly.Visible = true
            FlyOn.Visible = true
            local BV = Instance.new("BodyVelocity", torso)
            local BG = Instance.new("BodyGyro", torso)
            BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            game:GetService('RunService').RenderStepped:connect(function()
                BG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                BG.D = 5000
                BG.P = 100000
                BG.CFrame = game.Workspace.CurrentCamera.CFrame
            end)
        end)
        
        VelocidadeLabel.Name = "VelocidadeLabel"
        VelocidadeLabel.Parent = FrameFly
        VelocidadeLabel.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        VelocidadeLabel.BorderSizePixel = 0
        VelocidadeLabel.Position = UDim2.new(0.0759493634, 0, 0.402877688, 0)
        VelocidadeLabel.Size = UDim2.new(0, 87, 0, 32)
        VelocidadeLabel.ZIndex = 0
        VelocidadeLabel.Font = Enum.Font.SourceSans
        VelocidadeLabel.Text = "Velocidade:"
        VelocidadeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        VelocidadeLabel.TextScaled = true
        VelocidadeLabel.TextSize = 14.000
        VelocidadeLabel.TextWrapped = true
        
        Status.Name = "Status"
        Status.Parent = FrameFly
        Status.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        Status.BorderSizePixel = 0
        Status.Position = UDim2.new(0.299983799, 0, 0.239817441, 0)
        Status.Size = UDim2.new(0, 85, 0, 15)
        Status.Font = Enum.Font.SourceSans
        Status.Text = "Status:"
        Status.TextColor3 = Color3.fromRGB(255, 255, 255)
        Status.TextScaled = true
        Status.TextSize = 14.000
        Status.TextWrapped = true
        
        StatusValor.Name = "StatusValor"
        StatusValor.Parent = FrameFly
        StatusValor.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        StatusValor.BorderSizePixel = 0
        StatusValor.Position = UDim2.new(0.546535194, 0, 0.239817441, 0)
        StatusValor.Size = UDim2.new(0, 27, 0, 15)
        StatusValor.Font = Enum.Font.SourceSans
        StatusValor.Text = "Desligado"
        StatusValor.TextColor3 = Color3.fromRGB(255, 0, 0)
        StatusValor.TextScaled = true
        StatusValor.TextSize = 14.000
        StatusValor.TextWrapped = true
        
        Unfly.Name = "Unfly"
        Unfly.Parent = FrameFly
        Unfly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
        Unfly.BorderSizePixel = 0
        Unfly.Position = UDim2.new(0.0759493634, 0, 0.705797076, 0)
        Unfly.Size = UDim2.new(0, 199, 0, 32)
        Unfly.Visible = false
        Unfly.Font = Enum.Font.SourceSans
        Unfly.Text = "Desativar"
        Unfly.TextColor3 = Color3.fromRGB(255, 255, 255)
        Unfly.TextScaled = true
        Unfly.TextSize = 14.000
        Unfly.TextWrapped = true
        
        Unfly.MouseButton1Click:Connect(function()
            local torso = game.Players.LocalPlayer.Character.HumanoidRootPart
            Fly.Visible = true
            StatusValor.Text = "Desligado"
            StatusValor.TextColor3 = Color3.fromRGB(255, 0, 0)
            wait()
            Unfly.Visible = false
            FlyOn.Visible = false
            torso:FindFirstChildOfClass("BodyVelocity"):Destroy()
            torso:FindFirstChildOfClass("BodyGyro"):Destroy()
        end)
        
        Vfly.Name = "Vfly"
        Vfly.Parent = Arrastar
        Vfly.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
        Vfly.BorderSizePixel = 0
        Vfly.Size = UDim2.new(0, 57, 0, 27)
        Vfly.Font = Enum.Font.SourceSans
        Vfly.Text = "Voar"
        Vfly.TextColor3 = Color3.fromRGB(255, 255, 255)
        Vfly.TextScaled = true
        Vfly.TextSize = 14.000
        Vfly.TextWrapped = true
        
        Fechar.Name = "Fechar"
        Fechar.Parent = Arrastar
        Fechar.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
        Fechar.BorderSizePixel = 0
        Fechar.Position = UDim2.new(0.875, 0, 0, 0)
        Fechar.Size = UDim2.new(0, 27, 0, 27)
        Fechar.Font = Enum.Font.SourceSans
        Fechar.Text = "X"
        Fechar.TextColor3 = Color3.fromRGB(255, 255, 255)
        Fechar.TextScaled = true
        Fechar.TextSize = 14.000
        Fechar.TextWrapped = true
        
        Fechar.MouseButton1Click:Connect(function()
            FlyGuiV2:Destroy()
        end)
        
        Minimizar.Name = "Minimizar"
        Minimizar.Parent = Arrastar
        Minimizar.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
        Minimizar.BorderSizePixel = 0
        Minimizar.Position = UDim2.new(0.75, 0, 0, 0)
        Minimizar.Size = UDim2.new(0, 27, 0, 27)
        Minimizar.Font = Enum.Font.SourceSans
        Minimizar.Text = "-"
        Minimizar.TextColor3 = Color3.fromRGB(255, 255, 255)
        Minimizar.TextScaled = true
        Minimizar.TextSize = 14.000
        Minimizar.TextWrapped = true
        
        function Mini()
            if Minimizar.Text == "-" then
                Minimizar.Text = "+"
                FrameFly.Visible = false
            elseif Minimizar.Text == "+" then
                Minimizar.Text = "-"
                FrameFly.Visible = true
            end
        end
        
        Minimizar.MouseButton1Click:Connect(Mini)
        
        FlyOn.Name = "FlyOn"
        FlyOn.Parent = FlyGuiV2
        FlyOn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        FlyOn.BorderSizePixel = 0
        FlyOn.Position = UDim2.new(0.117647067, 0, 0.550284624, 0)
        FlyOn.Size = UDim2.new(0.148000002, 0, 0.314999998, 0)
        FlyOn.Visible = false
        FlyOn.Active = true
        FlyOn.Draggable = true
        
        W.Name = "W"
        W.Parent = FlyOn
        W.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
        W.BorderSizePixel = 0
        W.Position = UDim2.new(0.134719521, 0, 0.0152013302, 0)
        W.Size = UDim2.new(0.708999991, 0, 0.499000013, 0)
        W.Font = Enum.Font.SourceSans
        W.Text = "^"
        W.TextColor3 = Color3.fromRGB(255, 255, 255)
        W.TextScaled = true
        W.TextSize = 14.000
        W.TextWrapped = true
        
        W.TouchLongPress:Connect(function()
            local torso = game.Players.LocalPlayer.Character.HumanoidRootPart
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
        end)
        
        W.MouseButton1Click:Connect(function()
            local torso = game.Players.LocalPlayer.Character.HumanoidRootPart
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
        end)
        
        S.Name = "S"
        S.Parent = FlyOn
        S.BackgroundColor3 = Color3.fromRGB(0, 150, 191)
        S.BorderSizePixel = 0
        S.Position = UDim2.new(0.134000003, 0, 0.479999989, 0)
        S.Rotation = 180.000
        S.Size = UDim2.new(0.708999991, 0, 0.499000013, 0)
        S.Font = Enum.Font.SourceSans
        S.Text = "^"
        S.TextColor3 = Color3.fromRGB(255, 255, 255)
        S.TextScaled = true
        S.TextSize = 14.000
        S.TextWrapped = true
        
        S.TouchLongPress:Connect(function()
            local torso = game.Players.LocalPlayer.Character.HumanoidRootPart
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
        end)
        
        S.MouseButton1Click:Connect(function()
            local torso = game.Players.LocalPlayer.Character.HumanoidRootPart
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
        end)
    end
})

AbaCarro:AddParagraph({ "Nota", "Ativando isso você pode voar com o seu carro" })

-- Spam de Carros
AbaCarro:AddSection({ "Spam de Carros" })

local listaCarros = {
    "SchoolBus", "SmartCar", "FarmTruck", "Cadillac", "Excavator", "Jeep",
    "NascarTruck", "TowTruck", "Snowplow", "MilitaryTruck", "Tank", "Limo", "FireTruck"
}

local spamCarrosAtivo = false

local function spawnarCarro(nomeCarro)
    local args = { [1] = "PickingCar", [2] = nomeCarro }
    game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
end

AbaCarro:AddToggle({
    Name = "Spam de Carros",
    Default = false,
    Callback = function(estado)
        spamCarrosAtivo = estado
        if spamCarrosAtivo then
            task.spawn(function()
                while spamCarrosAtivo do
                    for _, nomeCarro in ipairs(listaCarros) do
                        if not spamCarrosAtivo then break end
                        spawnarCarro(nomeCarro)
                        wait(0.4)
                    end
                end
            end)
        end
    end
})

AbaCarro:AddParagraph({ "Informação:", "Spamar vários carros" })

-- Aba Criança
local AbaCrianca = Janela:MakeTab({
    Title = "Criança",
    Icon = "rbxassetid://baby"
})

local SecaoCrianca = AbaCrianca:AddSection({ Name = "Criança" })

local jogadorPerseguindo = nil
local jogadorLocalCrianca = game.Players.LocalPlayer

local function atualizarListaJogadoresCrianca()
    local lista = {}
    for _, jogador in pairs(game.Players:GetPlayers()) do
        table.insert(lista, jogador.Name)
    end
    return lista
end

local menuJogadoresCrianca = AbaCrianca:AddDropdown({
    Name = "Selecione um jogador para perseguir",
    Options = atualizarListaJogadoresCrianca(),
    Default = "",
    Callback = function(selecionado)
        if game.Players:FindFirstChild(selecionado) then
            jogadorPerseguindo = selecionado
        else
            jogadorPerseguindo = nil
        end
    end
})

AbaCrianca:AddButton({
    Name = "Atualizar Lista de Jogadores",
    Callback = function()
        local listaAtualizada = atualizarListaJogadoresCrianca()
        if menuJogadoresCrianca and listaAtualizada then
            pcall(function()
                menuJogadoresCrianca:Refresh(listaAtualizada)
            end)
            if jogadorPerseguindo and not game.Players:FindFirstChild(jogadorPerseguindo) then
                jogadorPerseguindo = nil
                pcall(function()
                    menuJogadoresCrianca:Set("")
                end)
            end
        end
    end
})

game.Players.PlayerAdded:Connect(function()
    task.wait(0.1)
    local listaAtualizada = atualizarListaJogadoresCrianca()
    if menuJogadoresCrianca and listaAtualizada then
        pcall(function()
            menuJogadoresCrianca:Refresh(listaAtualizada)
        end)
    end
end)

game.Players.PlayerRemoving:Connect(function(jogador)
    task.wait(0.1)
    local listaAtualizada = atualizarListaJogadoresCrianca()
    if menuJogadoresCrianca and listaAtualizada then
        pcall(function()
            menuJogadoresCrianca:Refresh(listaAtualizada)
        end)
        if jogadorPerseguindo == jogador.Name then
            jogadorPerseguindo = nil
            pcall(function()
                menuJogadoresCrianca:Set("")
            end)
        end
    end
end)

AbaCrianca:AddButton({
    Name = "Enviar Criança",
    Callback = function()
        if not jogadorPerseguindo then
            warn("Nenhum jogador selecionado!")
            return
        end
        if not workspace:FindFirstChild(jogadorLocalCrianca.Name) or not workspace[jogadorLocalCrianca.Name]:FindFirstChild("FollowCharacter") then
            local args = { [1] = "CharacterFollowSpawnPlayer", [2] = "BabyBoy" }
            local sucesso, erro = pcall(function()
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Bab1yFollo1w"):FireServer(unpack(args))
            end)
            if not sucesso then
                warn("Erro ao enviar criança: " .. erro)
            end
        end
        task.wait(0.2)
        if workspace:FindFirstChild(jogadorLocalCrianca.Name) then
            for _, v in pairs(workspace[jogadorLocalCrianca.Name]:GetChildren()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
        local alvo = jogadorPerseguindo
        if workspace:FindFirstChild(alvo) and workspace:FindFirstChild(jogadorLocalCrianca.Name) and workspace[jogadorLocalCrianca.Name]:FindFirstChild("FollowCharacter") then
            workspace[jogadorLocalCrianca.Name].FollowCharacter.Parent = workspace[alvo]
            if rawget(getgenv(), "ServicoExecucao") then return end
            getgenv().ServicoExecucao = game:GetService("RunService").Heartbeat:Connect(function()
                local personagemSeguir = workspace[alvo]:FindFirstChild("FollowCharacter")
                if personagemSeguir and personagemSeguir:FindFirstChild("Torso") and personagemSeguir.Torso:FindFirstChild("BodyPosition") then
                    local torso = workspace[alvo]:FindFirstChild("HumanoidRootPart")
                    if torso then
                        personagemSeguir.Torso.BodyPosition.Position = torso.Position - (torso.CFrame.LookVector * 3)
                        personagemSeguir.Torso.BodyGyro.CFrame = torso.CFrame
                    end
                end
            end)
        end
    end
})

AbaCrianca:AddButton({
    Name = "Retornar Criança",
    Callback = function()
        if rawget(getgenv(), "ServicoExecucao") then
            getgenv().ServicoExecucao:Disconnect()
            getgenv().ServicoExecucao = nil
        end
        local args = { [1] = "DeleteFollowCharacter" }
        local sucesso, erro = pcall(function()
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Bab1yFollo1w"):FireServer(unpack(args))
        end)
        if not sucesso then
            warn("Erro ao retornar criança: " .. erro)
        end
        local args1 = { [1] = "CharacterFollowSpawnPlayer", [2] = "BabyBoy" }
        sucesso, erro = pcall(function()
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Bab1yFollo1w"):FireServer(unpack(args1))
        end)
        if not sucesso then
            warn("Erro ao spawnar criança: " .. erro)
        end
    end
})

AbaCrianca:AddToggle({
    Name = "Espectar Jogador",
    Default = false,
    Callback = function(Valor)
        local Jogadores = game:GetService("Players")
        local ServicoExecucao = game:GetService("RunService")
        local JogadorLocal = Jogadores.LocalPlayer
        local Camera = workspace.CurrentCamera
        
        if Valor then
            if not jogadorPerseguindo then
                warn("Nenhum jogador selecionado para espectar!")
                return false
            end
            if not rawget(getgenv(), "ConexaoCameraCrianca") then
                getgenv().ConexaoCameraCrianca = ServicoExecucao.Heartbeat:Connect(function()
                    local jogadorAlvo = Jogadores:FindFirstChild(jogadorPerseguindo)
                    if jogadorAlvo and jogadorAlvo.Character and jogadorAlvo.Character:FindFirstChild("Humanoid") then
                        Camera.CameraSubject = jogadorAlvo.Character.Humanoid
                    else
                        if rawget(getgenv(), "ConexaoCameraCrianca") then
                            getgenv().ConexaoCameraCrianca:Disconnect()
                            getgenv().ConexaoCameraCrianca = nil
                        end
                        Camera.CameraSubject = JogadorLocal.Character and JogadorLocal.Character:FindFirstChild("Humanoid") or nil
                    end
                end)
            end
        else
            if rawget(getgenv(), "ConexaoCameraCrianca") then
                getgenv().ConexaoCameraCrianca:Disconnect()
                getgenv().ConexaoCameraCrianca = nil
            end
            if JogadorLocal.Character and JogadorLocal.Character:FindFirstChild("Humanoid") then
                Camera.CameraSubject = JogadorLocal.Character.Humanoid
            end
        end
    end
})

AbaCrianca:AddParagraph({ Title = "FE", Content = "Funcionalidades FE" })

-- Aba Itens (Continuação)
AbaItens:AddSection({ Name = "Colorir Mapa" })

AbaItens:AddButton({
    Name = "Colorir Mapa Chão [Muito OP]",
    Callback = function()
        local ferramentaSelecionada = "PaintRoller"
        local quantidadeDupe = 100
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        local remoteLimparFerramentas = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
        local duplicando = true
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local TabelaGripPos = {}
        
        for i = 1, 100 do
            if i == 1 then
                table.insert(TabelaGripPos, Vector3.new(0, 5, 0))
            else
                table.insert(TabelaGripPos, Vector3.new((i - 1) * 1.2, 5, 0))
            end
        end
        
        local contadorFerramentas = 0
        for _, ferramenta in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ferramenta:IsA("Tool") and ferramenta.Name == ferramentaSelecionada then
                contadorFerramentas = contadorFerramentas + 1
            end
        end
        for _, ferramenta in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if ferramenta:IsA("Tool") and ferramenta.Name == ferramentaSelecionada then
                contadorFerramentas = contadorFerramentas + 1
            end
        end
        
        if contadorFerramentas >= quantidadeDupe then
            for i, ferramenta in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if ferramenta:IsA("Tool") and ferramenta.Name == ferramentaSelecionada then
                    ferramenta.Parent = game.Players.LocalPlayer.Backpack
                end
            end
            for i, ferramenta in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if ferramenta:IsA("Tool") and ferramenta.Name == ferramentaSelecionada then
                    ferramenta.Parent = game.Players.LocalPlayer.Character
                    local indiceGrip = math.min(i, #TabelaGripPos)
                    local posGrip = TabelaGripPos[indiceGrip]
                    ferramenta.GripPos = posGrip
                end
            end
        else
            local args = { [1] = "ClearAllTools" }
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
            wait(0.2)
            game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Vortex Hub Dupe", Text = "Não clique em nada enquanto as ferramentas estão sendo duplicadas", Button1 = "Entendi", Duration = 3 })
            
            if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                task.wait()
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            end
            
            wait(0.1)
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            
            for m = 1, 2 do
                task.wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
            end
            
            task.wait(0.2)
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
            wait(0.5)
            
            for _, afh in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                if afh.Name ~= ferramentaSelecionada then
                    if afh:IsA("Tool") then
                        afh.Parent = game.Players.LocalPlayer.Backpack
                    end
                end
            end
            
            for _, dvjbvj in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if dvjbvj:IsA("Tool") then
                    if dvjbvj.Name ~= ferramentaSelecionada then
                        dvjbvj:Destroy()
                    end
                end
            end
            
            for _, ddvdvdsvdfbrnytytmvdv in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                if ddvdvdsvdfbrnytytmvdv:IsA("Tool") then
                    if ddvdvdsvdfbrnytytmvdv.Name ~= ferramentaSelecionada then
                        ddvdvdsvdfbrnytytmvdv:Destroy()
                    end
                end
            end
            
            local toollllfoun2 = false
            local tollllahhhh
            
            for _, toollel in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                if toollel:IsA("Tool") then
                    if toollel.Name == ferramentaSelecionada then
                        toollllfoun2 = true
                        for _, aijfw in pairs(toollel:GetDescendants()) do
                            if aijfw.Name == "Handle" then
                                aijfw.Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                                toollel.Parent = game.Players.LocalPlayer.Backpack
                                toollel.Parent = game.Players.LocalPlayer.Character
                                tollllahhhh = toollel
                                task.wait()
                            end
                        end
                    else
                        toollllfoun2 = false
                    end
                end
            end
            
            local toollllfoun = false
            local toolllffel
            
            for _, toollll in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if toollll:IsA("Tool") then
                    if toollll.Name == ferramentaSelecionada then
                        toollllfoun = true
                        for _, jjsjsj in pairs(toollll:GetDescendants()) do
                            if jjsjsj.Name == "Handle" then
                                toollll.Parent = game.Players.LocalPlayer.Character
                                wait()
                                jjsjsj.Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                                toollll.Parent = game.Players.LocalPlayer.Backpack
                                toollll.Parent = game.Players.LocalPlayer.Character
                                toolllffel = toollll
                            end
                        end
                    else
                        toollllfoun = false
                    end
                end
            end
            
            if toollllfoun == true then
                if game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil then
                    toollllfoun = false
                end
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil
                toollllfoun = false
            end
            
            if toollllfoun2 == true then
                if game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil then
                    toollllfoun2 = false
                end
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil
                toollllfoun2 = false
            end
            
            wait(0.1)
            
            for m = 1, quantidadeDupe do
                if duplicando == false then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                    return
                end
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                local args = { [1] = "PickingTools", [2] = ferramentaSelecionada }
                remotePegarFerramenta:InvokeServer(unpack(args))
                game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Character
                if duplicando == false then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                    return
                end
                wait()
                game:GetService("Players").LocalPlayer.Character[ferramentaSelecionada]:FindFirstChild("Handle").Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Backpack
                game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Character
                game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Vortex Hub Tool", Text = "Ferramenta Duplicada: " .. m .. " / " .. quantidadeDupe, Duration = 1 })
                repeat
                    if game:GetService("Workspace"):FindFirstChild("Camera") then
                        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                    end
                    task.wait()
                until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaSelecionada) == nil
            end
            
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
            repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframeAntigo
            
            for z, x in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if x.Name == ferramentaSelecionada then
                    -- variável toolamouth = z
                end
            end
            
            wait()
            duplicando = false
            wait(0.1)
            
            for i, ferramenta in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if ferramenta:IsA("Tool") then
                    ferramenta.Parent = game.Players.LocalPlayer.Character
                    local indiceGrip = math.min(i, #TabelaGripPos)
                    local posGrip = TabelaGripPos[indiceGrip]
                    if ferramenta:IsDescendantOf(game.Players.LocalPlayer.Character) then
                        ferramenta.GripPos = posGrip
                    else
                        warn("", ferramenta.Name, "")
                    end
                end
            end
            
            wait(1)
            
            function EquiparTudo()
                local jogador = game:GetService("Players").LocalPlayer
                local function mudarAnimacao(ferramenta)
                    if ferramenta:FindFirstChild("CycleNextAnimation") then
                        ferramenta.CycleNextAnimation:FireServer()
                    end
                end
                for _, ferramenta in ipairs(jogador.Backpack:GetChildren()) do
                    if ferramenta:IsA("Tool") and ferramenta.Name == "PaintRoller" then
                        mudarAnimacao(ferramenta)
                    end
                end
                local personagem = jogador.Character or jogador.CharacterAdded:Wait()
                for _, ferramenta in ipairs(personagem:GetChildren()) do
                    if ferramenta:IsA("Tool") and ferramenta.Name == "PaintRoller" then
                        mudarAnimacao(ferramenta)
                    end
                end
            end
            
            EquiparTudo()
            wait(1)
            EquiparTudo()
            wait(1)
            EquiparTudo()
            
            function iniciarGiro()
                local Jogadores = game:GetService("Players")
                local ServicoExecucao = game:GetService("RunService")
                local jogador = Jogadores.LocalPlayer
                local personagem = jogador.Character or jogador.CharacterAdded:Wait()
                local raiz = personagem:WaitForChild("HumanoidRootPart")
                task.wait(1)
                local velocidadeGiro = math.rad(1750)
                ServicoExecucao.RenderStepped:Connect(function(dt)
                    raiz.CFrame = raiz.CFrame * CFrame.Angles(0, velocidadeGiro * dt, 0)
                end)
            end
            
            iniciarGiro()
        end
    end
})

AbaItens:AddButton({
    Name = "Colorir Mapa Céu [Muito OP]",
    Callback = function()
        local ferramentaSelecionada = "PaintRoller"
        local quantidadeDupe = 100
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        local remoteLimparFerramentas = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
        local duplicando = true
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local TabelaGripPos = {}
        
        for i = 1, 100 do
            if i == 1 then
                table.insert(TabelaGripPos, Vector3.new(2, 50, -50))
            else
                table.insert(TabelaGripPos, Vector3.new((i - 1) * 2, 50, -50))
            end
        end
        
        local contadorFerramentas = 0
        for _, ferramenta in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ferramenta:IsA("Tool") and ferramenta.Name == ferramentaSelecionada then
                contadorFerramentas = contadorFerramentas + 1
            end
        end
        for _, ferramenta in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if ferramenta:IsA("Tool") and ferramenta.Name == ferramentaSelecionada then
                contadorFerramentas = contadorFerramentas + 1
            end
        end
        
        if contadorFerramentas >= quantidadeDupe then
            for i, ferramenta in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if ferramenta:IsA("Tool") and ferramenta.Name == ferramentaSelecionada then
                    ferramenta.Parent = game.Players.LocalPlayer.Backpack
                end
            end
            for i, ferramenta in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if ferramenta:IsA("Tool") and ferramenta.Name == ferramentaSelecionada then
                    ferramenta.Parent = game.Players.LocalPlayer.Character
                    local indiceGrip = math.min(i, #TabelaGripPos)
                    local posGrip = TabelaGripPos[indiceGrip]
                    ferramenta.GripPos = posGrip
                end
            end
        else
            local args = { [1] = "ClearAllTools" }
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer(unpack(args))
            wait(0.2)
            game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Vortex Hub Dupe", Text = "Não clique em nada enquanto as ferramentas estão sendo duplicadas", Button1 = "Entendi", Duration = 3 })
            
            if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                task.wait()
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            end
            
            wait(0.1)
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            
            for m = 1, 2 do
                task.wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
            end
            
            task.wait(0.2)
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
            wait(0.5)
            
            for _, afh in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                if afh.Name ~= ferramentaSelecionada then
                    if afh:IsA("Tool") then
                        afh.Parent = game.Players.LocalPlayer.Backpack
                    end
                end
            end
            
            for _, dvjbvj in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if dvjbvj:IsA("Tool") then
                    if dvjbvj.Name ~= ferramentaSelecionada then
                        dvjbvj:Destroy()
                    end
                end
            end
            
            for _, ddvdvdsvdfbrnytytmvdv in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                if ddvdvdsvdfbrnytytmvdv:IsA("Tool") then
                    if ddvdvdsvdfbrnytytmvdv.Name ~= ferramentaSelecionada then
                        ddvdvdsvdfbrnytytmvdv:Destroy()
                    end
                end
            end
            
            local toollllfoun2 = false
            local tollllahhhh
            
            for _, toollel in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                if toollel:IsA("Tool") then
                    if toollel.Name == ferramentaSelecionada then
                        toollllfoun2 = true
                        for _, aijfw in pairs(toollel:GetDescendants()) do
                            if aijfw.Name == "Handle" then
                                aijfw.Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                                toollel.Parent = game.Players.LocalPlayer.Backpack
                                toollel.Parent = game.Players.LocalPlayer.Character
                                tollllahhhh = toollel
                                task.wait()
                            end
                        end
                    else
                        toollllfoun2 = false
                    end
                end
            end
            
            local toollllfoun = false
            local toolllffel
            
            for _, toollll in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if toollll:IsA("Tool") then
                    if toollll.Name == ferramentaSelecionada then
                        toollllfoun = true
                        for _, jjsjsj in pairs(toollll:GetDescendants()) do
                            if jjsjsj.Name == "Handle" then
                                toollll.Parent = game.Players.LocalPlayer.Character
                                wait()
                                jjsjsj.Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                                toollll.Parent = game.Players.LocalPlayer.Backpack
                                toollll.Parent = game.Players.LocalPlayer.Character
                                toolllffel = toollll
                            end
                        end
                    else
                        toollllfoun = false
                    end
                end
            end
            
            if toollllfoun == true then
                if game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil then
                    toollllfoun = false
                end
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil
                toollllfoun = false
            end
            
            if toollllfoun2 == true then
                if game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil then
                    toollllfoun2 = false
                end
                repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil
                toollllfoun2 = false
            end
            
            wait(0.1)
            
            for m = 1, quantidadeDupe do
                if duplicando == false then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                    return
                end
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                local args = { [1] = "PickingTools", [2] = ferramentaSelecionada }
                remotePegarFerramenta:InvokeServer(unpack(args))
                game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Character
                if duplicando == false then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                    return
                end
                wait()
                game:GetService("Players").LocalPlayer.Character[ferramentaSelecionada]:FindFirstChild("Handle").Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Backpack
                game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Character
                game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Vortex Hub Tool", Text = "Ferramenta Duplicada: " .. m .. " / " .. quantidadeDupe, Duration = 1 })
                repeat
                    if game:GetService("Workspace"):FindFirstChild("Camera") then
                        game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                    end
                    task.wait()
                until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaSelecionada) == nil
            end
            
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
            repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframeAntigo
            
            for z, x in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if x.Name == ferramentaSelecionada then
                    -- variável toolamouth = z
                end
            end
            
            wait()
            duplicando = false
            wait(0.1)
            
            for i, ferramenta in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if ferramenta:IsA("Tool") then
                    ferramenta.Parent = game.Players.LocalPlayer.Character
                    local indiceGrip = math.min(i, #TabelaGripPos)
                    local posGrip = TabelaGripPos[indiceGrip]
                    if ferramenta:IsDescendantOf(game.Players.LocalPlayer.Character) then
                        ferramenta.GripPos = posGrip
                    else
                        warn("", ferramenta.Name, "")
                    end
                end
            end
            
            wait(1)
            
            function EquiparTudo()
                local jogador = game:GetService("Players").LocalPlayer
                local function mudarAnimacao(ferramenta)
                    if ferramenta:FindFirstChild("CycleNextAnimation") then
                        ferramenta.CycleNextAnimation:FireServer()
                    end
                end
                for _, ferramenta in ipairs(jogador.Backpack:GetChildren()) do
                    if ferramenta:IsA("Tool") and ferramenta.Name == "PaintRoller" then
                        mudarAnimacao(ferramenta)
                    end
                end
                local personagem = jogador.Character or jogador.CharacterAdded:Wait()
                for _, ferramenta in ipairs(personagem:GetChildren()) do
                    if ferramenta:IsA("Tool") and ferramenta.Name == "PaintRoller" then
                        mudarAnimacao(ferramenta)
                    end
                end
            end
            
            EquiparTudo()
            wait(1)
            EquiparTudo()
            wait(1)
            EquiparTudo()
            
            function iniciarGiro()
                local Jogadores = game:GetService("Players")
                local ServicoExecucao = game:GetService("RunService")
                local jogador = Jogadores.LocalPlayer
                local personagem = jogador.Character or jogador.CharacterAdded:Wait()
                local raiz = personagem:WaitForChild("HumanoidRootPart")
                task.wait(1)
                local velocidadeGiro = math.rad(1750)
                ServicoExecucao.RenderStepped:Connect(function(dt)
                    raiz.CFrame = raiz.CFrame * CFrame.Angles(0, velocidadeGiro * dt, 0)
                end)
            end
            
            iniciarGiro()
        end
    end
})

-- Tabela de cores para o rolo de pintura
local tabelaCores = {
    {Name = "Vermelho", Color = Color3.fromRGB(255, 0, 0)},
    {Name = "Laranja", Color = Color3.fromRGB(255, 165, 0)},
    {Name = "Amarelo", Color = Color3.fromRGB(255, 255, 0)},
    {Name = "Verde", Color = Color3.fromRGB(0, 255, 0)},
    {Name = "Ciano", Color = Color3.fromRGB(0, 255, 255)},
    {Name = "Azul", Color = Color3.fromRGB(0, 0, 255)},
    {Name = "Roxo", Color = Color3.fromRGB(128, 0, 128)},
    {Name = "Preto", Color = Color3.fromRGB(0, 0, 0)}
}

local corSelecionada = tabelaCores[1].Color

local function aplicarCorSelecionada()
    local JogadorLocal = game:GetService("Players").LocalPlayer
    local mochila = JogadorLocal.Backpack
    local personagem = JogadorLocal.Character
    local args = {corSelecionada}
    
    local function mudarCorFerramenta(ferramenta)
        if ferramenta:IsA("Tool") and ferramenta.Name == "PaintRoller" then
            local SetColor = ferramenta:FindFirstChild("SetColor", true)
            if SetColor then
                SetColor:FireServer(unpack(args))
            end
        end
    end
    
    for _, ferramenta in ipairs(mochila:GetChildren()) do
        mudarCorFerramenta(ferramenta)
    end
    for _, ferramenta in ipairs(personagem:GetChildren()) do
        mudarCorFerramenta(ferramenta)
    end
end

local function equiparEDesequiparFerramentas(callback)
    local JogadorLocal = game:GetService("Players").LocalPlayer
    local mochila = JogadorLocal.Backpack
    local personagem = JogadorLocal.Character
    
    local function desequiparFerramentas()
        for _, ferramenta in ipairs(personagem:GetChildren()) do
            if ferramenta:IsA("Tool") and ferramenta.Name == "PaintRoller" then
                ferramenta.Parent = mochila
            end
        end
    end
    
    local function equiparFerramentas()
        for _, ferramenta in ipairs(mochila:GetChildren()) do
            if ferramenta:IsA("Tool") and ferramenta.Name == "PaintRoller" then
                ferramenta.Parent = personagem
            end
        end
    end
    
    desequiparFerramentas()
    wait(0.7)
    if callback then callback() end
    wait(0.7)
    equiparFerramentas()
end

AbaItens:AddDropdown({
    Name = "Selecione a Cor",
    Description = "Escolha uma cor para aplicar",
    Options = (function()
        local nomesCores = {}
        for _, cor in ipairs(tabelaCores) do
            table.insert(nomesCores, cor.Name)
        end
        return nomesCores
    end)(),
    Default = tabelaCores[1].Name,
    Callback = function(selecionado)
        for _, cor in ipairs(tabelaCores) do
            if cor.Name == selecionado then
                corSelecionada = cor.Color
                equiparEDesequiparFerramentas(aplicarCorSelecionada)
                break
            end
        end
    end
})

local function aplicarCicloRGB()
    local JogadorLocal = game:GetService("Players").LocalPlayer
    local mochila = JogadorLocal.Backpack
    local personagem = JogadorLocal.Character
    local indiceFerramenta = 0
    local totalCores = #tabelaCores
    
    local function mudarCorFerramenta(ferramenta, cor)
        if ferramenta:IsA("Tool") and ferramenta.Name == "PaintRoller" then
            local SetColor = ferramenta:FindFirstChild("SetColor", true)
            if SetColor then
                SetColor:FireServer(cor)
            end
        end
    end
    
    for _, ferramenta in ipairs(mochila:GetChildren()) do
        if ferramenta.Name == "PaintRoller" then
            indiceFerramenta = indiceFerramenta + 1
            local cor = tabelaCores[(indiceFerramenta - 1) % totalCores + 1].Color
            mudarCorFerramenta(ferramenta, cor)
        end
    end
    for _, ferramenta in ipairs(personagem:GetChildren()) do
        if ferramenta.Name == "PaintRoller" then
            indiceFerramenta = indiceFerramenta + 1
            local cor = tabelaCores[(indiceFerramenta - 1) % totalCores + 1].Color
            mudarCorFerramenta(ferramenta, cor)
        end
    end
end

AbaItens:AddButton({
    Name = "Colorido",
    Callback = function()
        equiparEDesequiparFerramentas(aplicarCicloRGB)
    end
})

-- Combinações de cores
local combinacoesCores = {}
for i, cor1 in ipairs(tabelaCores) do
    for j, cor2 in ipairs(tabelaCores) do
        if i ~= j then
            table.insert(combinacoesCores, {Name = cor1.Name .. " e " .. cor2.Name, Cores = {cor1.Color, cor2.Color}})
        end
    end
end

AbaItens:AddDropdown({
    Name = "Selecione a Combinação de Cores",
    Description = "Escolha uma combinação de cores",
    Options = (function()
        local nomesCombinacoes = {}
        for _, combinacao in ipairs(combinacoesCores) do
            table.insert(nomesCombinacoes, combinacao.Name)
        end
        return nomesCombinacoes
    end)(),
    Default = combinacoesCores[1].Name,
    Callback = function(selecionado)
        for _, combinacao in ipairs(combinacoesCores) do
            if combinacao.Name == selecionado then
                local function aplicarDuasCores()
                    local JogadorLocal = game:GetService("Players").LocalPlayer
                    local mochila = JogadorLocal.Backpack
                    local personagem = JogadorLocal.Character
                    local indiceFerramenta = 0
                    local cores = combinacao.Cores
                    
                    local function mudarCorFerramenta(ferramenta, cor)
                        if ferramenta:IsA("Tool") and ferramenta.Name == "PaintRoller" then
                            local SetColor = ferramenta:FindFirstChild("SetColor", true)
                            if SetColor then
                                SetColor:FireServer(cor)
                            end
                        end
                    end
                    
                    for _, ferramenta in ipairs(mochila:GetChildren()) do
                        if ferramenta.Name == "PaintRoller" then
                            indiceFerramenta = indiceFerramenta + 1
                            local cor = cores[(indiceFerramenta - 1) % 2 + 1]
                            mudarCorFerramenta(ferramenta, cor)
                        end
                    end
                    for _, ferramenta in ipairs(personagem:GetChildren()) do
                        if ferramenta.Name == "PaintRoller" then
                            indiceFerramenta = indiceFerramenta + 1
                            local cor = cores[(indiceFerramenta - 1) % 2 + 1]
                            mudarCorFerramenta(ferramenta, cor)
                        end
                    end
                end
                equiparEDesequiparFerramentas(aplicarDuasCores)
                break
            end
        end
    end
})

-- Botões N4zi
AbaItens:AddSection({ Name = "N4zi Grip" })

AbaItens:AddButton({
    Name = "Giant Joust Blue N4zi",
    Callback = function()
        local ferramentaSelecionada = "JoustBlue"
        local quantidadeDupe = 175
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        local remoteLimparFerramentas = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
        local duplicando = true
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Dupe Script", Text = "Por favor, não equipe ou desequipe ferramentas enquanto duplica.", Button1 = "Entendi", Duration = 5})
        
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        
        wait(0.1)
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.5)
        
        for _, afh in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if afh.Name ~= ferramentaSelecionada then
                if afh:IsA("Tool") then
                    afh.Parent = game.Players.LocalPlayer.Backpack
                end
            end
        end
        
        for _, dvjbvj in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if dvjbvj:IsA("Tool") then
                if dvjbvj.Name ~= ferramentaSelecionada then
                    dvjbvj:Destroy()
                end
            end
        end
        
        for _, ddvdvdsvdfbrnytytmvdv in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if ddvdvdsvdfbrnytytmvdv:IsA("Tool") then
                if ddvdvdsvdfbrnytytmvdv.Name ~= ferramentaSelecionada then
                    ddvdvdsvdfbrnytytmvdv:Destroy()
                end
            end
        end
        
        local toollllfoun2 = false
        local tollllahhhh
        
        for _, toollel in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if toollel:IsA("Tool") then
                if toollel.Name == ferramentaSelecionada then
                    toollllfoun2 = true
                    for _, aijfw in pairs(toollel:GetDescendants()) do
                        if aijfw.Name == "Handle" then
                            aijfw.Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                            toollel.Parent = game.Players.LocalPlayer.Backpack
                            toollel.Parent = game.Players.LocalPlayer.Character
                            tollllahhhh = toollel
                            task.wait()
                        end
                    end
                else
                    toollllfoun2 = false
                end
            end
        end
        
        local toollllfoun = false
        local toolllffel
        
        for _, toollll in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if toollll:IsA("Tool") then
                if toollll.Name == ferramentaSelecionada then
                    toollllfoun = true
                    for _, jjsjsj in pairs(toollll:GetDescendants()) do
                        if jjsjsj.Name == "Handle" then
                            toollll.Parent = game.Players.LocalPlayer.Character
                            wait()
                            jjsjsj.Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                            toollll.Parent = game.Players.LocalPlayer.Backpack
                            toollll.Parent = game.Players.LocalPlayer.Character
                            toolllffel = toollll
                        end
                    end
                else
                    toollllfoun = false
                end
            end
        end
        
        if toollllfoun == true then
            if game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil then
                toollllfoun = false
            end
            repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil
            toollllfoun = false
        end
        
        if toollllfoun2 == true then
            if game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil then
                toollllfoun2 = false
            end
            repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil
            toollllfoun2 = false
        end
        
        wait(1)
        
        for m = 1, quantidadeDupe do
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = { [1] = "PickingTools", [2] = ferramentaSelecionada }
            remotePegarFerramenta:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Character
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[ferramentaSelecionada]:FindFirstChild("Handle").Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                task.wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaSelecionada) == nil
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframeAntigo
        
        for z, x in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if x.Name == ferramentaSelecionada then
                -- variável toolamouth = z
            end
        end
        
        wait()
        duplicando = false
        wait(1)
        
        local TabelaGripPos = {
            Vector3.new(0, 3, 6), Vector3.new(1, 3, 6), Vector3.new(2, 3, 6), Vector3.new(3, 3, 6),
            Vector3.new(4, 3, 6), Vector3.new(5, 3, 6), Vector3.new(6, 3, 6), Vector3.new(0, 3, 17),
            Vector3.new(1, 3, 17), Vector3.new(2, 3, 17), Vector3.new(3, 3, 17), Vector3.new(4, 3, 17),
            Vector3.new(5, 3, 17), Vector3.new(6, 3, 17), Vector3.new(0, 3, 30), Vector3.new(1, 3, 30),
            Vector3.new(2, 3, 30), Vector3.new(3, 3, 30), Vector3.new(4, 3, 30), Vector3.new(5, 3, 30),
            Vector3.new(6, 3, 30), Vector3.new(0, 3, 43), Vector3.new(1, 3, 43), Vector3.new(2, 3, 43),
            Vector3.new(3, 3, 43), Vector3.new(4, 3, 43), Vector3.new(5, 3, 43), Vector3.new(6, 3, 43),
            Vector3.new(0, 3, 55), Vector3.new(1, 3, 55), Vector3.new(2, 3, 55), Vector3.new(3, 3, 55),
            Vector3.new(4, 3, 55), Vector3.new(5, 3, 55), Vector3.new(6, 3, 55), Vector3.new(-1, 3, 6),
            Vector3.new(-2, 3, 6), Vector3.new(-3, 3, 6), Vector3.new(-4, 3, 6), Vector3.new(-5, 3, 6),
            Vector3.new(-6, 3, 6), Vector3.new(-7, 3, 6), Vector3.new(-8, 3, 6), Vector3.new(-9, 3, 6),
            Vector3.new(-10, 3, 6), Vector3.new(-11, 3, 6), Vector3.new(-12, 3, 6), Vector3.new(-13, 3, 6),
            Vector3.new(-14, 3, 6), Vector3.new(-15, 3, 6), Vector3.new(-16, 3, 6), Vector3.new(-17, 3, 6),
            Vector3.new(-18, 3, 6), Vector3.new(-19, 3, 6), Vector3.new(-20, 3, 6), Vector3.new(-21, 3, 6)
        }
        
        for i, ferramenta in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ferramenta:IsA("Tool") then
                ferramenta.Parent = game.Players.LocalPlayer.Character
                local indiceGrip = math.min(i, #TabelaGripPos)
                local posGrip = TabelaGripPos[indiceGrip]
                if ferramenta:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    ferramenta.GripPos = posGrip
                else
                    warn("", ferramenta.Name, "")
                end
            end
        end
    end
})

AbaItens:AddButton({
    Name = "Giant Joust Red N4zi",
    Callback = function()
        local ferramentaSelecionada = "JoustRed"
        local quantidadeDupe = 175
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        local remoteLimparFerramentas = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s")
        local duplicando = true
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Dupe Script", Text = "Por favor, não equipe ou desequipe ferramentas enquanto duplica.", Button1 = "Entendi", Duration = 5})
        
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        
        wait(0.1)
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.5)
        
        for _, afh in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if afh.Name ~= ferramentaSelecionada then
                if afh:IsA("Tool") then
                    afh.Parent = game.Players.LocalPlayer.Backpack
                end
            end
        end
        
        for _, dvjbvj in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if dvjbvj:IsA("Tool") then
                if dvjbvj.Name ~= ferramentaSelecionada then
                    dvjbvj:Destroy()
                end
            end
        end
        
        for _, ddvdvdsvdfbrnytytmvdv in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if ddvdvdsvdfbrnytytmvdv:IsA("Tool") then
                if ddvdvdsvdfbrnytytmvdv.Name ~= ferramentaSelecionada then
                    ddvdvdsvdfbrnytytmvdv:Destroy()
                end
            end
        end
        
        local toollllfoun2 = false
        local tollllahhhh
        
        for _, toollel in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
            if toollel:IsA("Tool") then
                if toollel.Name == ferramentaSelecionada then
                    toollllfoun2 = true
                    for _, aijfw in pairs(toollel:GetDescendants()) do
                        if aijfw.Name == "Handle" then
                            aijfw.Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                            toollel.Parent = game.Players.LocalPlayer.Backpack
                            toollel.Parent = game.Players.LocalPlayer.Character
                            tollllahhhh = toollel
                            task.wait()
                        end
                    end
                else
                    toollllfoun2 = false
                end
            end
        end
        
        local toollllfoun = false
        local toolllffel
        
        for _, toollll in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if toollll:IsA("Tool") then
                if toollll.Name == ferramentaSelecionada then
                    toollllfoun = true
                    for _, jjsjsj in pairs(toollll:GetDescendants()) do
                        if jjsjsj.Name == "Handle" then
                            toollll.Parent = game.Players.LocalPlayer.Character
                            wait()
                            jjsjsj.Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
                            toollll.Parent = game.Players.LocalPlayer.Backpack
                            toollll.Parent = game.Players.LocalPlayer.Character
                            toolllffel = toollll
                        end
                    end
                else
                    toollllfoun = false
                end
            end
        end
        
        if toollllfoun == true then
            if game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil then
                toollllfoun = false
            end
            repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(toolllffel) == nil
            toollllfoun = false
        end
        
        if toollllfoun2 == true then
            if game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil then
                toollllfoun2 = false
            end
            repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild(tollllahhhh) == nil
            toollllfoun2 = false
        end
        
        wait(1)
        
        for m = 1, quantidadeDupe do
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = { [1] = "PickingTools", [2] = ferramentaSelecionada }
            remotePegarFerramenta:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Character
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[ferramentaSelecionada]:FindFirstChild("Handle").Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaSelecionada).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                task.wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaSelecionada) == nil
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframeAntigo
        
        for z, x in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if x.Name == ferramentaSelecionada then
                -- variável toolamouth = z
            end
        end
        
        wait()
        duplicando = false
        wait(1)
        
        local TabelaGripPos = {
            Vector3.new(0, 3, 6), Vector3.new(1, 3, 6), Vector3.new(2, 3, 6), Vector3.new(3, 3, 6),
            Vector3.new(4, 3, 6), Vector3.new(5, 3, 6), Vector3.new(6, 3, 6), Vector3.new(0, 3, 17),
            Vector3.new(1, 3, 17), Vector3.new(2, 3, 17), Vector3.new(3, 3, 17), Vector3.new(4, 3, 17),
            Vector3.new(5, 3, 17), Vector3.new(6, 3, 17), Vector3.new(0, 3, 30), Vector3.new(1, 3, 30),
            Vector3.new(2, 3, 30), Vector3.new(3, 3, 30), Vector3.new(4, 3, 30), Vector3.new(5, 3, 30),
            Vector3.new(6, 3, 30), Vector3.new(0, 3, 43), Vector3.new(1, 3, 43), Vector3.new(2, 3, 43),
            Vector3.new(3, 3, 43), Vector3.new(4, 3, 43), Vector3.new(5, 3, 43), Vector3.new(6, 3, 43),
            Vector3.new(0, 3, 55), Vector3.new(1, 3, 55), Vector3.new(2, 3, 55), Vector3.new(3, 3, 55),
            Vector3.new(4, 3, 55), Vector3.new(5, 3, 55), Vector3.new(6, 3, 55), Vector3.new(-1, 3, 6),
            Vector3.new(-2, 3, 6), Vector3.new(-3, 3, 6), Vector3.new(-4, 3, 6), Vector3.new(-5, 3, 6),
            Vector3.new(-6, 3, 6), Vector3.new(-7, 3, 6), Vector3.new(-8, 3, 6), Vector3.new(-9, 3, 6),
            Vector3.new(-10, 3, 6), Vector3.new(-11, 3, 6), Vector3.new(-12, 3, 6), Vector3.new(-13, 3, 6),
            Vector3.new(-14, 3, 6), Vector3.new(-15, 3, 6), Vector3.new(-16, 3, 6), Vector3.new(-17, 3, 6),
            Vector3.new(-18, 3, 6), Vector3.new(-19, 3, 6), Vector3.new(-20, 3, 6), Vector3.new(-21, 3, 6)
        }
        
        for i, ferramenta in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ferramenta:IsA("Tool") then
                ferramenta.Parent = game.Players.LocalPlayer.Character
                local indiceGrip = math.min(i, #TabelaGripPos)
                local posGrip = TabelaGripPos[indiceGrip]
                if ferramenta:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    ferramenta.GripPos = posGrip
                else
                    warn("", ferramenta.Name, "")
                end
            end
        end
    end
})

AbaItens:AddButton({
    Name = "(+13) Fogo N4zi",
    Callback = function()
        local nomeFerramentas = "fogo n4zi lel"
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local ferramentaDupe = "PaperbagFire"
        local ferramenta = "PaperbagFire"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Dupe Script", Text = "Por favor, não equipe ou desequipe ferramentas enquanto duplica.", Button1 = "Entendi", Duration = 5})
        
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        
        wait(0.1)
        local args = { [1] = "ClearAllTools" }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer(unpack(args))
        
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.3)
        
        local duplicando = true
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        
        for m = 1, 57 do
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = { [1] = "PickingTools", [2] = ferramentaDupe }
            remotePegarFerramenta:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[ferramentaDupe]:FindFirstChild("Handle").Name = "HÃ¢ndlÃª"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe) == nil
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        duplicando = false
        wait()
        
        local gripBase = CFrame.new(-0.290086746, 0.0755810738, -0.0109872818, 0.0439560413, 0.509705901, -0.859225094, -0.0591450632, -0.857220173, -0.511542261, -0.997281134, 0.0733042806, -0.00753343105)
        local posicoesGrip = {
            Vector3.new(0, 0, 0), Vector3.new(0, 0.5, 0), Vector3.new(0, 1, 0), Vector3.new(0, 1.5, 0),
            Vector3.new(0, 2, 0), Vector3.new(0, 2.5, 0), Vector3.new(0, 3, 0), Vector3.new(0, 3.5, 0),
            Vector3.new(0, 4, 0), Vector3.new(0, 4.5, 0), Vector3.new(0, 5, 0), Vector3.new(0, 5, -1),
            Vector3.new(0, 5, -2), Vector3.new(0, 5, -3), Vector3.new(0, 5, -4), Vector3.new(0, 5, -5),
            Vector3.new(0, 5, -6), Vector3.new(0, 5, -7), Vector3.new(0, 5, -8), Vector3.new(0, 5, -9),
            Vector3.new(0, 5, -10), Vector3.new(0, 5.5, -10), Vector3.new(0, 6, -10), Vector3.new(0, 6.5, -10),
            Vector3.new(0, 7, -10), Vector3.new(0, 7.5, -10), Vector3.new(0, 8, -10), Vector3.new(0, 8.5, -10),
            Vector3.new(0, 9, -10), Vector3.new(0, 9.5, -10), Vector3.new(0, 10, -10), Vector3.new(0, 10, -5),
            Vector3.new(0, 10, -4.5), Vector3.new(0, 10, -4), Vector3.new(0, 10, -3.5), Vector3.new(0, 10, -3),
            Vector3.new(0, 10, -2.5), Vector3.new(0, 10, -2), Vector3.new(0, 10, -1.5), Vector3.new(0, 10, -1),
            Vector3.new(0, 10, -0.5), Vector3.new(0, 10, 0), Vector3.new(0, 9, -5), Vector3.new(0, 8, -5),
            Vector3.new(0, 7, -5), Vector3.new(0, 6, -5), Vector3.new(0, 5, -5), Vector3.new(0, 4, -5),
            Vector3.new(0, 3, -5), Vector3.new(0, 2, -5), Vector3.new(0, 1, -5), Vector3.new(0, 0, -5),
            Vector3.new(0, 0, -10), Vector3.new(0, 0, -9), Vector3.new(0, 0, -8), Vector3.new(0, 0, -7),
            Vector3.new(0, 0, -6)
        }
        
        for _, pos in ipairs(posicoesGrip) do
            game.Players.LocalPlayer.Backpack[ferramenta].Grip = gripBase + pos
            game.Players.LocalPlayer.Backpack[ferramenta].Name = nomeFerramentas
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframeAntigo
        wait(0.5)
        
        for _, ferramentaObj in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if ferramentaObj:IsA("Tool") and ferramentaObj.Name == nomeFerramentas then
                ferramentaObj.Parent = game:GetService("Players").LocalPlayer.Character
            end
        end
    end
})

AbaItens:AddButton({
    Name = "Crystal N4zi",
    Callback = function()
        local nomeFerramentas = "crystal n4zi lel"
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local ferramentaDupe = "Crystal"
        local ferramenta = "Crystal"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Dupe Script", Text = "Por favor, não equipe ou desequipe ferramentas enquanto duplica.", Button1 = "Entendi", Duration = 5})
        
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        
        wait(0.1)
        local args = { [1] = "ClearAllTools" }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer(unpack(args))
        
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.3)
        
        local duplicando = true
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        
        for m = 1, 57 do
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = { [1] = "PickingTools", [2] = ferramentaDupe }
            remotePegarFerramenta:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[ferramentaDupe]:FindFirstChild("Handle").Name = "HÃ¢ndlÃª"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe) == nil
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        duplicando = false
        wait()
        
        local gripBase = CFrame.new(-0.290086746, 0.0755810738, -0.0109872818, 0.0439560413, 0.509705901, -0.859225094, -0.0591450632, -0.857220173, -0.511542261, -0.997281134, 0.0733042806, -0.00753343105)
        local posicoesGrip = {
            Vector3.new(0, 0, 0), Vector3.new(0, 0.5, 0), Vector3.new(0, 1, 0), Vector3.new(0, 1.5, 0),
            Vector3.new(0, 2, 0), Vector3.new(0, 2.5, 0), Vector3.new(0, 3, 0), Vector3.new(0, 3.5, 0),
            Vector3.new(0, 4, 0), Vector3.new(0, 4.5, 0), Vector3.new(0, 5, 0), Vector3.new(0, 5, -1),
            Vector3.new(0, 5, -2), Vector3.new(0, 5, -3), Vector3.new(0, 5, -4), Vector3.new(0, 5, -5),
            Vector3.new(0, 5, -6), Vector3.new(0, 5, -7), Vector3.new(0, 5, -8), Vector3.new(0, 5, -9),
            Vector3.new(0, 5, -10), Vector3.new(0, 5.5, -10), Vector3.new(0, 6, -10), Vector3.new(0, 6.5, -10),
            Vector3.new(0, 7, -10), Vector3.new(0, 7.5, -10), Vector3.new(0, 8, -10), Vector3.new(0, 8.5, -10),
            Vector3.new(0, 9, -10), Vector3.new(0, 9.5, -10), Vector3.new(0, 10, -10), Vector3.new(0, 10, -5),
            Vector3.new(0, 10, -4.5), Vector3.new(0, 10, -4), Vector3.new(0, 10, -3.5), Vector3.new(0, 10, -3),
            Vector3.new(0, 10, -2.5), Vector3.new(0, 10, -2), Vector3.new(0, 10, -1.5), Vector3.new(0, 10, -1),
            Vector3.new(0, 10, -0.5), Vector3.new(0, 10, 0), Vector3.new(0, 9, -5), Vector3.new(0, 8, -5),
            Vector3.new(0, 7, -5), Vector3.new(0, 6, -5), Vector3.new(0, 5, -5), Vector3.new(0, 4, -5),
            Vector3.new(0, 3, -5), Vector3.new(0, 2, -5), Vector3.new(0, 1, -5), Vector3.new(0, 0, -5),
            Vector3.new(0, 0, -10), Vector3.new(0, 0, -9), Vector3.new(0, 0, -8), Vector3.new(0, 0, -7),
            Vector3.new(0, 0, -6)
        }
        
        for _, pos in ipairs(posicoesGrip) do
            game.Players.LocalPlayer.Backpack[ferramenta].Grip = gripBase + pos
            game.Players.LocalPlayer.Backpack[ferramenta].Name = nomeFerramentas
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframeAntigo
        wait(0.5)
        
        for _, ferramentaObj in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if ferramentaObj:IsA("Tool") and ferramentaObj.Name == nomeFerramentas then
                ferramentaObj.Parent = game:GetService("Players").LocalPlayer.Character
            end
        end
    end
})

AbaItens:AddButton({
    Name = "FireX N4zi",
    Callback = function()
        local nomeFerramentas = "nazi firex lel"
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local ferramentaDupe = "FireX"
        local ferramenta = "FireX"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Dupe Script", Text = "Por favor, não equipe ou desequipe ferramentas enquanto duplica.", Button1 = "Entendi", Duration = 5})
        
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        
        wait(0.1)
        local args = { [1] = "ClearAllTools" }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer(unpack(args))
        
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.3)
        
        local duplicando = true
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        
        for m = 1, 71 do
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = { [1] = "PickingTools", [2] = ferramentaDupe }
            remotePegarFerramenta:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[ferramentaDupe]:FindFirstChild("Handle").Name = "HÃ¢ndlÃª"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe) == nil
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        duplicando = false
        wait()
        
        local gripBase = CFrame.new(0.0538333468, -0.264812469, -0.0177594293, 0.999998629, 0, 0.00164011808, 0, 1, 0, -0.00164011808, 0, 0.999998629)
        local posicoesGrip = {
            Vector3.new(0, -2, 0), Vector3.new(0, -4, 0), Vector3.new(0, -6, 0), Vector3.new(0, -8, 0),
            Vector3.new(0, -10, 0), Vector3.new(0, -12, 0), Vector3.new(0, -14, 0), Vector3.new(1, -14, 0),
            Vector3.new(2, -14, 0), Vector3.new(3, -14, 0), Vector3.new(4, -14, 0), Vector3.new(5, -14, 0),
            Vector3.new(6, -14, 0), Vector3.new(7, -14, 0), Vector3.new(8, -14, 0), Vector3.new(9, -14, 0),
            Vector3.new(10, -14, 0), Vector3.new(11, -14, 0), Vector3.new(12, -14, 0), Vector3.new(13, -14, 0),
            Vector3.new(14, -14, 0), Vector3.new(15, -14, 0), Vector3.new(16, -14, 0), Vector3.new(17, -14, 0),
            Vector3.new(18, -14, 0), Vector3.new(19, -14, 0), Vector3.new(20, -14, 0), Vector3.new(20, -16, 0),
            Vector3.new(20, -18, 0), Vector3.new(20, -20, 0), Vector3.new(20, -22, 0), Vector3.new(20, -24, 0),
            Vector3.new(20, -26, 0), Vector3.new(20, -28, 0), Vector3.new(20, -30, 0), Vector3.new(10, -30, 0),
            Vector3.new(10, -28, 0), Vector3.new(10, -26, 0), Vector3.new(10, -24, 0), Vector3.new(10, -22, 0),
            Vector3.new(10, -20, 0), Vector3.new(10, -18, 0), Vector3.new(10, -16, 0), Vector3.new(10, -14, 0),
            Vector3.new(10, -12, 0), Vector3.new(10, -10, 0), Vector3.new(10, -8, 0), Vector3.new(10, -6, 0),
            Vector3.new(10, -4, 0), Vector3.new(10, -2, 0), Vector3.new(11, -2, 0), Vector3.new(12, -2, 0),
            Vector3.new(13, -2, 0), Vector3.new(14, -2, 0), Vector3.new(15, -2, 0), Vector3.new(16, -2, 0),
            Vector3.new(17, -2, 0), Vector3.new(18, -2, 0), Vector3.new(19, -2, 0), Vector3.new(20, -2, 0),
            Vector3.new(1, -30, 0), Vector3.new(0, -30, 0), Vector3.new(2, -30, 0), Vector3.new(3, -30, 0),
            Vector3.new(4, -30, 0), Vector3.new(5, -30, 0), Vector3.new(6, -30, 0), Vector3.new(7, -30, 0),
            Vector3.new(8, -30, 0), Vector3.new(9, -30, 0)
        }
        
        for _, pos in ipairs(posicoesGrip) do
            game.Players.LocalPlayer.Backpack[ferramenta].Grip = gripBase + pos
            game.Players.LocalPlayer.Backpack[ferramenta].Name = nomeFerramentas
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframeAntigo
        wait(0.5)
        
        for _, ferramentaObj in ipairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
            if ferramentaObj:IsA("Tool") and ferramentaObj.Name == nomeFerramentas then
                ferramentaObj.Parent = game:GetService("Players").LocalPlayer.Character
            end
        end
    end
})

-- Seção Aura Grip
AbaItens:AddSection({ Name = "Aura Grip" })

AbaItens:AddButton({
    Name = "Aura de Sofá",
    Callback = function()
        local nomeFerramentas = "Aura Sofá"
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local ferramentaDupe = "Couch"
        local ferramenta = "Couch"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Dupe Script", Text = "Por favor, não equipe ou desequipe ferramentas enquanto duplica.", Button1 = "Entendi", Duration = 5})
        
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        
        wait(0.1)
        local args = { [1] = "ClearAllTools" }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer(unpack(args))
        
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.3)
        
        local duplicando = true
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        
        for m = 1, 124 do
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = { [1] = "PickingTools", [2] = ferramentaDupe }
            remotePegarFerramenta:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[ferramentaDupe]:FindFirstChild("Handle").Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe) == nil
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        duplicando = false
        wait()
        
        local TabelaGripPos = {
            Vector3.new(0, 0, 0), Vector3.new(10, 0, 0), Vector3.new(20, 0, 0), Vector3.new(30, 0, 0),
            Vector3.new(40, 0, 0), Vector3.new(50, 0, 0), Vector3.new(60, 0, 0), Vector3.new(-0, 0, 0),
            Vector3.new(-10, 0, 0), Vector3.new(-20, 0, 0), Vector3.new(-30, 0, 0), Vector3.new(-40, 0, 0),
            Vector3.new(-50, 0, 0), Vector3.new(-60, 0, 0), Vector3.new(0, 0, 30), Vector3.new(10, 0, 30),
            Vector3.new(20, 0, 30), Vector3.new(30, 0, 30), Vector3.new(40, 0, 30), Vector3.new(50, 0, 30),
            Vector3.new(60, 0, 30), Vector3.new(-0, 0, 30), Vector3.new(-10, 0, 30), Vector3.new(-20, 0, 30),
            Vector3.new(-30, 0, 30), Vector3.new(-40, 0, 30), Vector3.new(-50, 0, 30), Vector3.new(-60, 0, 30),
            Vector3.new(0, 0, 45), Vector3.new(10, 0, 45), Vector3.new(20, 0, 45), Vector3.new(30, 0, 45),
            Vector3.new(40, 0, 45), Vector3.new(50, 0, 45), Vector3.new(60, 0, 45), Vector3.new(-0, 0, 45),
            Vector3.new(-10, 0, 45), Vector3.new(-20, 0, 45), Vector3.new(-30, 0, 45), Vector3.new(-40, 0, 45),
            Vector3.new(-50, 0, 45), Vector3.new(-60, 0, 45), Vector3.new(0, 0, 15), Vector3.new(10, 0, 15),
            Vector3.new(20, 0, 15), Vector3.new(30, 0, 15), Vector3.new(40, 0, 15), Vector3.new(50, 0, 15),
            Vector3.new(60, 0, 15), Vector3.new(-0, 0, 15), Vector3.new(-10, 0, 15), Vector3.new(-20, 0, 15),
            Vector3.new(-30, 0, 15), Vector3.new(-40, 0, 15), Vector3.new(-50, 0, 15), Vector3.new(-60, 0, 15),
            Vector3.new(0, 0, -15), Vector3.new(10, 0, -15), Vector3.new(20, 0, -15), Vector3.new(30, 0, -15),
            Vector3.new(40, 0, -15), Vector3.new(50, 0, -15), Vector3.new(60, 0, -15), Vector3.new(-0, 0, -15),
            Vector3.new(-10, 0, -15), Vector3.new(-20, 0, -15), Vector3.new(-30, 0, -15), Vector3.new(-40, 0, -15),
            Vector3.new(-50, 0, -15), Vector3.new(-60, 0, -15), Vector3.new(0, 0, -30), Vector3.new(10, 0, -30),
            Vector3.new(20, 0, -30), Vector3.new(30, 0, -30), Vector3.new(40, 0, -30), Vector3.new(50, 0, -30),
            Vector3.new(60, 0, -30), Vector3.new(-0, 0, -30), Vector3.new(-10, 0, -30), Vector3.new(-20, 0, -30),
            Vector3.new(-30, 0, -30), Vector3.new(-40, 0, -30), Vector3.new(-50, 0, -30), Vector3.new(-60, 0, -30),
            Vector3.new(0, 0, -30), Vector3.new(10, 0, -45), Vector3.new(20, 0, -45), Vector3.new(30, 0, -45),
            Vector3.new(40, 0, -45), Vector3.new(50, 0, -45), Vector3.new(60, 0, -45), Vector3.new(-0, 0, -45),
            Vector3.new(-10, 0, -45), Vector3.new(-20, 0, -45), Vector3.new(-30, 0, -45), Vector3.new(-40, 0, -45),
            Vector3.new(-50, 0, -45), Vector3.new(-60, 0, -45), Vector3.new(10, 0, -60), Vector3.new(20, 0, -60),
            Vector3.new(30, 0, -60), Vector3.new(40, 0, -60), Vector3.new(50, 0, -60), Vector3.new(60, 0, -60),
            Vector3.new(-0, 0, -60), Vector3.new(-10, 0, -60), Vector3.new(-20, 0, -60), Vector3.new(-30, 0, -60),
            Vector3.new(-40, 0, -60), Vector3.new(-50, 0, -60), Vector3.new(-60, 0, -60), Vector3.new(10, 0, -75),
            Vector3.new(20, 0, -75), Vector3.new(30, 0, -75), Vector3.new(40, 0, -75), Vector3.new(50, 0, -75),
            Vector3.new(60, 0, -75), Vector3.new(-0, 0, -75), Vector3.new(-10, 0, -75), Vector3.new(-20, 0, -75),
            Vector3.new(-30, 0, -75), Vector3.new(-40, 0, -75), Vector3.new(-50, 0, -75), Vector3.new(-60, 0, -75)
        }
        
        for i, ferramentaObj in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ferramentaObj:IsA("Tool") then
                ferramentaObj.Parent = game.Players.LocalPlayer.Character
                local indiceGrip = math.min(i, #TabelaGripPos)
                local posGrip = TabelaGripPos[indiceGrip]
                if ferramentaObj:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    ferramentaObj.GripPos = posGrip
                else
                    warn("", ferramentaObj.Name, "")
                end
            end
        end
    end
})

AbaItens:AddButton({
    Name = "Aura de Fogo",
    Callback = function()
        local nomeFerramentas = "Aura Fogo"
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local ferramentaDupe = "PaperbagFire"
        local ferramenta = "PaperbagFire"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Dupe Script", Text = "Por favor, não equipe ou desequipe ferramentas enquanto duplica.", Button1 = "Entendi", Duration = 5})
        
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        
        wait(0.1)
        local args = { [1] = "ClearAllTools" }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer(unpack(args))
        
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.3)
        
        local duplicando = true
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        
        for m = 1, 124 do
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = { [1] = "PickingTools", [2] = ferramentaDupe }
            remotePegarFerramenta:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[ferramentaDupe]:FindFirstChild("Handle").Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe) == nil
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        duplicando = false
        wait()
        
        local TabelaGripPos = {
            Vector3.new(0, 0, 0), Vector3.new(10, 0, 0), Vector3.new(20, 0, 0), Vector3.new(30, 0, 0),
            Vector3.new(40, 0, 0), Vector3.new(50, 0, 0), Vector3.new(60, 0, 0), Vector3.new(-0, 0, 0),
            Vector3.new(-10, 0, 0), Vector3.new(-20, 0, 0), Vector3.new(-30, 0, 0), Vector3.new(-40, 0, 0),
            Vector3.new(-50, 0, 0), Vector3.new(-60, 0, 0), Vector3.new(0, 0, 30), Vector3.new(10, 0, 30),
            Vector3.new(20, 0, 30), Vector3.new(30, 0, 30), Vector3.new(40, 0, 30), Vector3.new(50, 0, 30),
            Vector3.new(60, 0, 30), Vector3.new(-0, 0, 30), Vector3.new(-10, 0, 30), Vector3.new(-20, 0, 30),
            Vector3.new(-30, 0, 30), Vector3.new(-40, 0, 30), Vector3.new(-50, 0, 30), Vector3.new(-60, 0, 30),
            Vector3.new(0, 0, 45), Vector3.new(10, 0, 45), Vector3.new(20, 0, 45), Vector3.new(30, 0, 45),
            Vector3.new(40, 0, 45), Vector3.new(50, 0, 45), Vector3.new(60, 0, 45), Vector3.new(-0, 0, 45),
            Vector3.new(-10, 0, 45), Vector3.new(-20, 0, 45), Vector3.new(-30, 0, 45), Vector3.new(-40, 0, 45),
            Vector3.new(-50, 0, 45), Vector3.new(-60, 0, 45), Vector3.new(0, 0, 15), Vector3.new(10, 0, 15),
            Vector3.new(20, 0, 15), Vector3.new(30, 0, 15), Vector3.new(40, 0, 15), Vector3.new(50, 0, 15),
            Vector3.new(60, 0, 15), Vector3.new(-0, 0, 15), Vector3.new(-10, 0, 15), Vector3.new(-20, 0, 15),
            Vector3.new(-30, 0, 15), Vector3.new(-40, 0, 15), Vector3.new(-50, 0, 15), Vector3.new(-60, 0, 15),
            Vector3.new(0, 0, -15), Vector3.new(10, 0, -15), Vector3.new(20, 0, -15), Vector3.new(30, 0, -15),
            Vector3.new(40, 0, -15), Vector3.new(50, 0, -15), Vector3.new(60, 0, -15), Vector3.new(-0, 0, -15),
            Vector3.new(-10, 0, -15), Vector3.new(-20, 0, -15), Vector3.new(-30, 0, -15), Vector3.new(-40, 0, -15),
            Vector3.new(-50, 0, -15), Vector3.new(-60, 0, -15), Vector3.new(0, 0, -30), Vector3.new(10, 0, -30),
            Vector3.new(20, 0, -30), Vector3.new(30, 0, -30), Vector3.new(40, 0, -30), Vector3.new(50, 0, -30),
            Vector3.new(60, 0, -30), Vector3.new(-0, 0, -30), Vector3.new(-10, 0, -30), Vector3.new(-20, 0, -30),
            Vector3.new(-30, 0, -30), Vector3.new(-40, 0, -30), Vector3.new(-50, 0, -30), Vector3.new(-60, 0, -30),
            Vector3.new(0, 0, -30), Vector3.new(10, 0, -45), Vector3.new(20, 0, -45), Vector3.new(30, 0, -45),
            Vector3.new(40, 0, -45), Vector3.new(50, 0, -45), Vector3.new(60, 0, -45), Vector3.new(-0, 0, -45),
            Vector3.new(-10, 0, -45), Vector3.new(-20, 0, -45), Vector3.new(-30, 0, -45), Vector3.new(-40, 0, -45),
            Vector3.new(-50, 0, -45), Vector3.new(-60, 0, -45), Vector3.new(10, 0, -60), Vector3.new(20, 0, -60),
            Vector3.new(30, 0, -60), Vector3.new(40, 0, -60), Vector3.new(50, 0, -60), Vector3.new(60, 0, -60),
            Vector3.new(-0, 0, -60), Vector3.new(-10, 0, -60), Vector3.new(-20, 0, -60), Vector3.new(-30, 0, -60),
            Vector3.new(-40, 0, -60), Vector3.new(-50, 0, -60), Vector3.new(-60, 0, -60), Vector3.new(10, 0, -75),
            Vector3.new(20, 0, -75), Vector3.new(30, 0, -75), Vector3.new(40, 0, -75), Vector3.new(50, 0, -75),
            Vector3.new(60, 0, -75), Vector3.new(-0, 0, -75), Vector3.new(-10, 0, -75), Vector3.new(-20, 0, -75),
            Vector3.new(-30, 0, -75), Vector3.new(-40, 0, -75), Vector3.new(-50, 0, -75), Vector3.new(-60, 0, -75)
        }
        
        for i, ferramentaObj in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ferramentaObj:IsA("Tool") then
                ferramentaObj.Parent = game.Players.LocalPlayer.Character
                local indiceGrip = math.min(i, #TabelaGripPos)
                local posGrip = TabelaGripPos[indiceGrip]
                if ferramentaObj:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    ferramentaObj.GripPos = posGrip
                else
                    warn("", ferramentaObj.Name, "")
                end
            end
        end
    end
})

AbaItens:AddButton({
    Name = "Aura de Água",
    Callback = function()
        local nomeFerramentas = "Aura Água"
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local ferramentaDupe = "WateringCan"
        local ferramenta = "WateringCan"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Dupe Script", Text = "Por favor, não equipe ou desequipe ferramentas enquanto duplica.", Button1 = "Entendi", Duration = 5})
        
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        
        wait(0.1)
        local args = { [1] = "ClearAllTools" }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer(unpack(args))
        
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.3)
        
        local duplicando = true
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        
        for m = 1, 124 do
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = { [1] = "PickingTools", [2] = ferramentaDupe }
            remotePegarFerramenta:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[ferramentaDupe]:FindFirstChild("Handle").Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe) == nil
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        duplicando = false
        wait()
        
        local TabelaGripPos = {
            Vector3.new(0, 0, 0), Vector3.new(10, 0, 0), Vector3.new(20, 0, 0), Vector3.new(30, 0, 0),
            Vector3.new(40, 0, 0), Vector3.new(50, 0, 0), Vector3.new(60, 0, 0), Vector3.new(-0, 0, 0),
            Vector3.new(-10, 0, 0), Vector3.new(-20, 0, 0), Vector3.new(-30, 0, 0), Vector3.new(-40, 0, 0),
            Vector3.new(-50, 0, 0), Vector3.new(-60, 0, 0), Vector3.new(0, 0, 30), Vector3.new(10, 0, 30),
            Vector3.new(20, 0, 30), Vector3.new(30, 0, 30), Vector3.new(40, 0, 30), Vector3.new(50, 0, 30),
            Vector3.new(60, 0, 30), Vector3.new(-0, 0, 30), Vector3.new(-10, 0, 30), Vector3.new(-20, 0, 30),
            Vector3.new(-30, 0, 30), Vector3.new(-40, 0, 30), Vector3.new(-50, 0, 30), Vector3.new(-60, 0, 30),
            Vector3.new(0, 0, 45), Vector3.new(10, 0, 45), Vector3.new(20, 0, 45), Vector3.new(30, 0, 45),
            Vector3.new(40, 0, 45), Vector3.new(50, 0, 45), Vector3.new(60, 0, 45), Vector3.new(-0, 0, 45),
            Vector3.new(-10, 0, 45), Vector3.new(-20, 0, 45), Vector3.new(-30, 0, 45), Vector3.new(-40, 0, 45),
            Vector3.new(-50, 0, 45), Vector3.new(-60, 0, 45), Vector3.new(0, 0, 15), Vector3.new(10, 0, 15),
            Vector3.new(20, 0, 15), Vector3.new(30, 0, 15), Vector3.new(40, 0, 15), Vector3.new(50, 0, 15),
            Vector3.new(60, 0, 15), Vector3.new(-0, 0, 15), Vector3.new(-10, 0, 15), Vector3.new(-20, 0, 15),
            Vector3.new(-30, 0, 15), Vector3.new(-40, 0, 15), Vector3.new(-50, 0, 15), Vector3.new(-60, 0, 15),
            Vector3.new(0, 0, -15), Vector3.new(10, 0, -15), Vector3.new(20, 0, -15), Vector3.new(30, 0, -15),
            Vector3.new(40, 0, -15), Vector3.new(50, 0, -15), Vector3.new(60, 0, -15), Vector3.new(-0, 0, -15),
            Vector3.new(-10, 0, -15), Vector3.new(-20, 0, -15), Vector3.new(-30, 0, -15), Vector3.new(-40, 0, -15),
            Vector3.new(-50, 0, -15), Vector3.new(-60, 0, -15), Vector3.new(0, 0, -30), Vector3.new(10, 0, -30),
            Vector3.new(20, 0, -30), Vector3.new(30, 0, -30), Vector3.new(40, 0, -30), Vector3.new(50, 0, -30),
            Vector3.new(60, 0, -30), Vector3.new(-0, 0, -30), Vector3.new(-10, 0, -30), Vector3.new(-20, 0, -30),
            Vector3.new(-30, 0, -30), Vector3.new(-40, 0, -30), Vector3.new(-50, 0, -30), Vector3.new(-60, 0, -30),
            Vector3.new(0, 0, -30), Vector3.new(10, 0, -45), Vector3.new(20, 0, -45), Vector3.new(30, 0, -45),
            Vector3.new(40, 0, -45), Vector3.new(50, 0, -45), Vector3.new(60, 0, -45), Vector3.new(-0, 0, -45),
            Vector3.new(-10, 0, -45), Vector3.new(-20, 0, -45), Vector3.new(-30, 0, -45), Vector3.new(-40, 0, -45),
            Vector3.new(-50, 0, -45), Vector3.new(-60, 0, -45), Vector3.new(10, 0, -60), Vector3.new(20, 0, -60),
            Vector3.new(30, 0, -60), Vector3.new(40, 0, -60), Vector3.new(50, 0, -60), Vector3.new(60, 0, -60),
            Vector3.new(-0, 0, -60), Vector3.new(-10, 0, -60), Vector3.new(-20, 0, -60), Vector3.new(-30, 0, -60),
            Vector3.new(-40, 0, -60), Vector3.new(-50, 0, -60), Vector3.new(-60, 0, -60), Vector3.new(10, 0, -75),
            Vector3.new(20, 0, -75), Vector3.new(30, 0, -75), Vector3.new(40, 0, -75), Vector3.new(50, 0, -75),
            Vector3.new(60, 0, -75), Vector3.new(-0, 0, -75), Vector3.new(-10, 0, -75), Vector3.new(-20, 0, -75),
            Vector3.new(-30, 0, -75), Vector3.new(-40, 0, -75), Vector3.new(-50, 0, -75), Vector3.new(-60, 0, -75)
        }
        
        for i, ferramentaObj in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ferramentaObj:IsA("Tool") then
                ferramentaObj.Parent = game.Players.LocalPlayer.Character
                local indiceGrip = math.min(i, #TabelaGripPos)
                local posGrip = TabelaGripPos[indiceGrip]
                if ferramentaObj:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    ferramentaObj.GripPos = posGrip
                else
                    warn("", ferramentaObj.Name, "")
                end
            end
        end
    end
})

AbaItens:AddButton({
    Name = "Aura de Luz",
    Callback = function()
        local nomeFerramentas = "Aura Luz"
        local cframeAntigo = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local ferramentaDupe = "FlashLight"
        local ferramenta = "FlashLight"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Dupe Script", Text = "Por favor, não equipe ou desequipe ferramentas enquanto duplica.", Button1 = "Entendi", Duration = 5})
        
        if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid.Sit = false
        end
        
        wait(0.1)
        local args = { [1] = "ClearAllTools" }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer(unpack(args))
        
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        
        for m = 1, 2 do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(999999999.414, -490, 999999999.414, 0.974360406, -0.175734088, 0.14049761, -0.133441404, 0.0514053069, 0.989722729, -0.181150302, -0.983094692, 0.0266370922)
        end
        
        task.wait(0.2)
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        wait(0.3)
        
        local duplicando = true
        local remotePegarFerramenta = game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l")
        
        for m = 1, 124 do
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            if game:GetService("Workspace"):FindFirstChild("Camera") then
                game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
            end
            local args = { [1] = "PickingTools", [2] = ferramentaDupe }
            remotePegarFerramenta:InvokeServer(unpack(args))
            game:GetService("Players").LocalPlayer.Backpack:WaitForChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            if duplicando == false then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                return
            end
            wait()
            game:GetService("Players").LocalPlayer.Character[ferramentaDupe]:FindFirstChild("Handle").Name = "HÃ¢Â¥aÃ¢Â¥nÃ¢Â¥dÃ¢Â¥lÃ¢Â¥e"
            game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Backpack
            game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(ferramentaDupe).Parent = game.Players.LocalPlayer.Character
            repeat
                if game:GetService("Workspace"):FindFirstChild("Camera") then
                    game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
                end
                wait()
            until game:GetService("Players").LocalPlayer.Character:FindFirstChild(ferramentaDupe) == nil
        end
        
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil
        repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        duplicando = false
        wait()
        
        local TabelaGripPos = {
            Vector3.new(0, 0, 0), Vector3.new(10, 0, 0), Vector3.new(20, 0, 0), Vector3.new(30, 0, 0),
            Vector3.new(40, 0, 0), Vector3.new(50, 0, 0), Vector3.new(60, 0, 0), Vector3.new(-0, 0, 0),
            Vector3.new(-10, 0, 0), Vector3.new(-20, 0, 0), Vector3.new(-30, 0, 0), Vector3.new(-40, 0, 0),
            Vector3.new(-50, 0, 0), Vector3.new(-60, 0, 0), Vector3.new(0, 0, 30), Vector3.new(10, 0, 30),
            Vector3.new(20, 0, 30), Vector3.new(30, 0, 30), Vector3.new(40, 0, 30), Vector3.new(50, 0, 30),
            Vector3.new(60, 0, 30), Vector3.new(-0, 0, 30), Vector3.new(-10, 0, 30), Vector3.new(-20, 0, 30),
            Vector3.new(-30, 0, 30), Vector3.new(-40, 0, 30), Vector3.new(-50, 0, 30), Vector3.new(-60, 0, 30),
            Vector3.new(0, 0, 45), Vector3.new(10, 0, 45), Vector3.new(20, 0, 45), Vector3.new(30, 0, 45),
            Vector3.new(40, 0, 45), Vector3.new(50, 0, 45), Vector3.new(60, 0, 45), Vector3.new(-0, 0, 45),
            Vector3.new(-10, 0, 45), Vector3.new(-20, 0, 45), Vector3.new(-30, 0, 45), Vector3.new(-40, 0, 45),
            Vector3.new(-50, 0, 45), Vector3.new(-60, 0, 45), Vector3.new(0, 0, 15), Vector3.new(10, 0, 15),
            Vector3.new(20, 0, 15), Vector3.new(30, 0, 15), Vector3.new(40, 0, 15), Vector3.new(50, 0, 15),
            Vector3.new(60, 0, 15), Vector3.new(-0, 0, 15), Vector3.new(-10, 0, 15), Vector3.new(-20, 0, 15),
            Vector3.new(-30, 0, 15), Vector3.new(-40, 0, 15), Vector3.new(-50, 0, 15), Vector3.new(-60, 0, 15),
            Vector3.new(0, 0, -15), Vector3.new(10, 0, -15), Vector3.new(20, 0, -15), Vector3.new(30, 0, -15),
            Vector3.new(40, 0, -15), Vector3.new(50, 0, -15), Vector3.new(60, 0, -15), Vector3.new(-0, 0, -15),
            Vector3.new(-10, 0, -15), Vector3.new(-20, 0, -15), Vector3.new(-30, 0, -15), Vector3.new(-40, 0, -15),
            Vector3.new(-50, 0, -15), Vector3.new(-60, 0, -15), Vector3.new(0, 0, -30), Vector3.new(10, 0, -30),
            Vector3.new(20, 0, -30), Vector3.new(30, 0, -30), Vector3.new(40, 0, -30), Vector3.new(50, 0, -30),
            Vector3.new(60, 0, -30), Vector3.new(-0, 0, -30), Vector3.new(-10, 0, -30), Vector3.new(-20, 0, -30),
            Vector3.new(-30, 0, -30), Vector3.new(-40, 0, -30), Vector3.new(-50, 0, -30), Vector3.new(-60, 0, -30),
            Vector3.new(0, 0, -30), Vector3.new(10, 0, -45), Vector3.new(20, 0, -45), Vector3.new(30, 0, -45),
            Vector3.new(40, 0, -45), Vector3.new(50, 0, -45), Vector3.new(60, 0, -45), Vector3.new(-0, 0, -45),
            Vector3.new(-10, 0, -45), Vector3.new(-20, 0, -45), Vector3.new(-30, 0, -45), Vector3.new(-40, 0, -45),
            Vector3.new(-50, 0, -45), Vector3.new(-60, 0, -45), Vector3.new(10, 0, -60), Vector3.new(20, 0, -60),
            Vector3.new(30, 0, -60), Vector3.new(40, 0, -60), Vector3.new(50, 0, -60), Vector3.new(60, 0, -60),
            Vector3.new(-0, 0, -60), Vector3.new(-10, 0, -60), Vector3.new(-20, 0, -60), Vector3.new(-30, 0, -60),
            Vector3.new(-40, 0, -60), Vector3.new(-50, 0, -60), Vector3.new(-60, 0, -60), Vector3.new(10, 0, -75),
            Vector3.new(20, 0, -75), Vector3.new(30, 0, -75), Vector3.new(40, 0, -75), Vector3.new(50, 0, -75),
            Vector3.new(60, 0, -75), Vector3.new(-0, 0, -75), Vector3.new(-10, 0, -75), Vector3.new(-20, 0, -75),
            Vector3.new(-30, 0, -75), Vector3.new(-40, 0, -75), Vector3.new(-50, 0, -75), Vector3.new(-60, 0, -75)
        }
        
        for i, ferramentaObj in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ferramentaObj:IsA("Tool") then
                ferramentaObj.Parent = game.Players.LocalPlayer.Character
                local indiceGrip = math.min(i, #TabelaGripPos)
                local posGrip = TabelaGripPos[indiceGrip]
                if ferramentaObj:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    ferramentaObj.GripPos = posGrip
                else
                    warn("", ferramentaObj.Name, "")
                end
            end
        end
    end
})

AbaItens:AddButton({
    Name = "Aura de Fumaça",
    Callback = function()
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Dupe Script", Text = "Por favor, não equipe ou desequipe ferramentas enquanto duplica.", Button1 = "Entendi", Duration = 5})
        
        local args = { [1] = "ClearAllTools" }
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Clea1rTool1s"):FireServer(unpack(args))
        
        if game:GetService("Workspace"):FindFirstChild("Camera") then
            game:GetService("Workspace"):FindFirstChild("Camera"):Destroy()
        end
        
        wait(0.3)
        
        for i = 1, 124 do
            local args = { [1] = "PickingTools", [2] = "FireHose" }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
            local args = { [1] = "FireHose", [2] = "DestroyFireHose" }
            game:GetService("Players").LocalPlayer.Backpack.FireHose.ToolSound:FireServer(unpack(args))
        end
        
        local jogador = game.Players.LocalPlayer
        local personagem = jogador.Character or jogador.CharacterAdded:Wait()
        local humanoide = personagem:FindFirstChildOfClass("Humanoid")
        if humanoide then
            humanoide.Health = 0
        end
        
        wait(8)
        
        local TabelaGripPos = {
            Vector3.new(0, 0, 0), Vector3.new(10, 0, 0), Vector3.new(20, 0, 0), Vector3.new(30, 0, 0),
            Vector3.new(40, 0, 0), Vector3.new(50, 0, 0), Vector3.new(60, 0, 0), Vector3.new(-0, 0, 0),
            Vector3.new(-10, 0, 0), Vector3.new(-20, 0, 0), Vector3.new(-30, 0, 0), Vector3.new(-40, 0, 0),
            Vector3.new(-50, 0, 0), Vector3.new(-60, 0, 0), Vector3.new(0, 0, 30), Vector3.new(10, 0, 30),
            Vector3.new(20, 0, 30), Vector3.new(30, 0, 30), Vector3.new(40, 0, 30), Vector3.new(50, 0, 30),
            Vector3.new(60, 0, 30), Vector3.new(-0, 0, 30), Vector3.new(-10, 0, 30), Vector3.new(-20, 0, 30),
            Vector3.new(-30, 0, 30), Vector3.new(-40, 0, 30), Vector3.new(-50, 0, 30), Vector3.new(-60, 0, 30),
            Vector3.new(0, 0, 45), Vector3.new(10, 0, 45), Vector3.new(20, 0, 45), Vector3.new(30, 0, 45),
            Vector3.new(40, 0, 45), Vector3.new(50, 0, 45), Vector3.new(60, 0, 45), Vector3.new(-0, 0, 45),
            Vector3.new(-10, 0, 45), Vector3.new(-20, 0, 45), Vector3.new(-30, 0, 45), Vector3.new(-40, 0, 45),
            Vector3.new(-50, 0, 45), Vector3.new(-60, 0, 45), Vector3.new(0, 0, 15), Vector3.new(10, 0, 15),
            Vector3.new(20, 0, 15), Vector3.new(30, 0, 15), Vector3.new(40, 0, 15), Vector3.new(50, 0, 15),
            Vector3.new(60, 0, 15), Vector3.new(-0, 0, 15), Vector3.new(-10, 0, 15), Vector3.new(-20, 0, 15),
            Vector3.new(-30, 0, 15), Vector3.new(-40, 0, 15), Vector3.new(-50, 0, 15), Vector3.new(-60, 0, 15),
            Vector3.new(0, 0, -15), Vector3.new(10, 0, -15), Vector3.new(20, 0, -15), Vector3.new(30, 0, -15),
            Vector3.new(40, 0, -15), Vector3.new(50, 0, -15), Vector3.new(60, 0, -15), Vector3.new(-0, 0, -15),
            Vector3.new(-10, 0, -15), Vector3.new(-20, 0, -15), Vector3.new(-30, 0, -15), Vector3.new(-40, 0, -15),
            Vector3.new(-50, 0, -15), Vector3.new(-60, 0, -15), Vector3.new(0, 0, -30), Vector3.new(10, 0, -30),
            Vector3.new(20, 0, -30), Vector3.new(30, 0, -30), Vector3.new(40, 0, -30), Vector3.new(50, 0, -30),
            Vector3.new(60, 0, -30), Vector3.new(-0, 0, -30), Vector3.new(-10, 0, -30), Vector3.new(-20, 0, -30),
            Vector3.new(-30, 0, -30), Vector3.new(-40, 0, -30), Vector3.new(-50, 0, -30), Vector3.new(-60, 0, -30),
            Vector3.new(0, 0, -30), Vector3.new(10, 0, -45), Vector3.new(20, 0, -45), Vector3.new(30, 0, -45),
            Vector3.new(40, 0, -45), Vector3.new(50, 0, -45), Vector3.new(60, 0, -45), Vector3.new(-0, 0, -45),
            Vector3.new(-10, 0, -45), Vector3.new(-20, 0, -45), Vector3.new(-30, 0, -45), Vector3.new(-40, 0, -45),
            Vector3.new(-50, 0, -45), Vector3.new(-60, 0, -45), Vector3.new(10, 0, -60), Vector3.new(20, 0, -60),
            Vector3.new(30, 0, -60), Vector3.new(40, 0, -60), Vector3.new(50, 0, -60), Vector3.new(60, 0, -60),
            Vector3.new(-0, 0, -60), Vector3.new(-10, 0, -60), Vector3.new(-20, 0, -60), Vector3.new(-30, 0, -60),
            Vector3.new(-40, 0, -60), Vector3.new(-50, 0, -60), Vector3.new(-60, 0, -60), Vector3.new(10, 0, -75),
            Vector3.new(20, 0, -75), Vector3.new(30, 0, -75), Vector3.new(40, 0, -75), Vector3.new(50, 0, -75),
            Vector3.new(60, 0, -75), Vector3.new(-0, 0, -75), Vector3.new(-10, 0, -75), Vector3.new(-20, 0, -75),
            Vector3.new(-30, 0, -75), Vector3.new(-40, 0, -75), Vector3.new(-50, 0, -75), Vector3.new(-60, 0, -75)
        }
        
        for i, ferramentaObj in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if ferramentaObj:IsA("Tool") then
                ferramentaObj.Parent = game.Players.LocalPlayer.Character
                local indiceGrip = math.min(i, #TabelaGripPos)
                local posGrip = TabelaGripPos[indiceGrip]
                if ferramentaObj:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    ferramentaObj.GripPos = posGrip
                else
                    warn("Ferramenta ", ferramentaObj.Name, " não está no personagem.")
                end
            end
        end
    end
})

AbaItens:AddSection({ Name = "Outros" })

AbaItens:AddButton({
    Name = "Em breve",
    Callback = function()
        print("Em breve")
    end
})

print("VORTEX HUB BY GODENOT - CARREGADO COM SUCESSO!")
