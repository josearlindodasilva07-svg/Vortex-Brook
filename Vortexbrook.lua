local Libary = loadstring(game:HttpGet("https://pastefy.app/KkevWErG/raw"))()
workspace.FallenPartsDestroyHeight = -math.huge

local Janela = Libary:MakeWindow({
    Title = "VORTEX HUB",
    SubTitle = "VORTEX HUB",
    LoadText = "Carregando VORTEX HUB",
    Flags = "VortexHub"
})

Janela:AddMinimizeButton({
    Button = {
        Image = 'rbxassetid://76560659040388',
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 35, 0, 35),
    },
    Corner = {
        CornerRadius = UDim.new(0, 100),
    },
})

-- Aba Informações
local AbaInfo = Janela:MakeTab({ Title = "Informações", Icon = "rbxassetid://15309138473" })

AbaInfo:AddSection({ "Informações do Script" })
AbaInfo:AddParagraph({ "Owner / Desenvolvedor:", "GODENOT" })
AbaInfo:AddParagraph({ "Colaborações:", "Godenot" })
AbaInfo:AddParagraph({ "criado por", "Godenot" })
AbaInfo:AddParagraph({ "Você está usando:", "VORTEX HUB Brookhaven" })
AbaInfo:AddParagraph({"Seu Executor:", executor})

AbaInfo:AddSection({ "Reconectar" })
AbaInfo:AddButton({
    Name = "Reconectar",
    Callback = function()
        local ServicoTeleporte = game:GetService("TeleportService")
        ServicoTeleporte:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end
})

-- Aba Troll Jogadores
local AbaTroll = Janela:MakeTab({ Title = "Troll Jogadores", Icon = "skull" })

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
local SecaoJogador = AbaTroll:AddSection({ Name = "Selecionar Jogador" })

local function obterListaJogadores()
    local lista = {}
    for _, jogador in ipairs(Jogadores:GetPlayers()) do
        if jogador ~= JogadorLocal then
            table.insert(lista, jogador.Name)
        end
    end
    return lista
end

local menuJogadores = AbaTroll:AddDropdown({
    Name = "Selecionar Jogador",
    Options = obterListaJogadores(),
    Default = "",
    Callback = function(valor)
        jogadorSelecionado = valor
        getgenv().Alvo = valor
        print("Jogador selecionado: " .. tostring(valor))
    end
})

AbaTroll:AddButton({
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

AbaTroll:AddButton({
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

AbaTroll:AddToggle({
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
local SecaoMetodos = AbaTroll:AddSection({ Name = "Métodos" })

AbaTroll:AddDropdown({
    Name = "Selecionar Método para Matar",
    Options = {"Ônibus", "Sofá", "Sofá Sem ir até o alvo [BETA]"},
    Default = "",
    Callback = function(valor)
        metodoMatar = valor
        print("Método selecionado: " .. tostring(valor))
    end
})

AbaTroll:AddButton({
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
                    if personagem.Humanoid.Sit or not onibus.Parent then
                        for k, v in pairs(onibus.Body:GetChildren()) do
                            if v:IsA("Seat") then
                                v.CanTouch = false
                            end
                        end
                    end
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
                                    local function simularPulo()
                                        local humanoide = personagem and personagem:FindFirstChildWhichIsA("Humanoid")
                                        if humanoide then humanoide:ChangeState(Enum.HumanoidStateType.Jumping) end
                                    end
                                    simularPulo()
                                    print("Simulando pulo!")
                                    task.wait(0.5)
                                    torso.CFrame = posOriginal
                                    print("Jogador voltou para a posição inicial.")
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

AbaTroll:AddButton({
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
    local Veiculos = workspace.Vehicles

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
                else
                    print("Nenhuma casa disponível para compra!")
                    return
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

AbaTroll:AddButton({
    Name = "Banimento de Casa",
    Callback = matarBanimentoCasa
})

-- Auto Fling
local flingAtivo = false
AbaTroll:AddToggle({
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

AbaTroll:AddButton({
    Name = "Arremessar Bola",
    Callback = function()
        arremessarBola(game:GetService("Players")[jogadorSelecionado])
    end
})

-- Fling Boat
AbaTroll:AddButton({
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

AbaTroll:AddButton({
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
local SecaoClickKill = AbaTroll:AddSection({ Name = "Métodos de Click" })

AbaTroll:AddButton({
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

AbaTroll:AddButton({
    Name = "Click Fling Sofá (Ferramenta)",
    Callback = function()
        local jogadores = game:GetService("Players")
        local rep = game:GetService("ReplicatedStorage")
        local entrada = game:GetService("UserInputService")
        local eu = jogadores.LocalPlayer
        local cam = workspace.CurrentCamera
        local podeClicar = true
        local ferramentaEquipada = false
        local NOME_FERRAMENTA = "Click Fling Sofa"
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

AbaTroll:AddButton({
    Name = "Click Fling Bola (Ferramenta)",
    Callback = function()
        local jogadores = game:GetService("Players")
        local rep = game:GetService("ReplicatedStorage")
        local mundo = game:GetService("Workspace")
        local entrada = game:GetService("UserInputService")
        local cam = mundo.CurrentCamera
        local eu = jogadores.LocalPlayer
        local NOME_FERRAMENTA = "Click Fling Bola"
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

AbaTroll:AddButton({
    Name = "Click Matar Sofá (Ferramenta)",
    Callback = function()
        local jogadores = game:GetService("Players")
        local rep = game:GetService("ReplicatedStorage")
        local loop = game:GetService("RunService")
        local mundo = game:GetService("Workspace")
        local entrada = game:GetService("UserInputService")
        local eu = jogadores.LocalPlayer
        local cam = mundo.CurrentCamera
        local NOME_FERRAMENTA = "Click Matar Sofa"
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

-- All Methods
local SecaoAllMethods = AbaTroll:AddSection({ Name = "Todos os Métodos" })

AbaTroll:AddButton({
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

AbaTroll:AddButton({
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

AbaTroll:AddButton({
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

AbaTroll:AddButton({
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

AbaTroll:AddButton({
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

AbaTroll:AddButton({
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

AbaTroll:AddButton({
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

-- Aba Carro
local AbaCarro = Janela:MakeTab({"Carro", "car"})

-- Cores para RGB
local cores = {
    Color3.new(1, 0, 0),
    Color3.new(0, 1, 0),
    Color3.new(0, 0, 1),
    Color3.new(1, 1, 0),
    Color3.new(1, 0, 1),
    Color3.new(0, 1, 1),
    Color3.new(0.5, 0, 0.5),
    Color3.new(1, 0.5, 0)
}

local armazenamentoReplicado = game:GetService("ReplicatedStorage")
local eventoRemoto = armazenamentoReplicado:WaitForChild("RE"):WaitForChild("1Player1sCa1r")

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

AbaCarro:AddParagraph({"Informação:", "Recomendo usar 2 vezes para garantir que todos os veículos sejam removidos"})

AbaCarro:AddButton({
    Name = "Puxar Todos os Carros",
    Callback = function()
        for _, v in next, workspace.Vehicles:GetChildren() do
            v:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character:GetPrimaryPartCFrame())
        end
    end
})

AbaCarro:AddParagraph({"Informação:", "Puxa todos os carros do servidor até você"})

-- Speed V1 Section
local SecaoVelocidade = AbaCarro:AddSection({"Velocidade V1"})

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
            redzlib:MakeNotification({
                Name = "VORTEX HUB",
                Content = "Pronto, você pode se mover agora!",
                Time = 5
            })
        else
            redzlib:MakeNotification({
                Name = "Erro",
                Content = "Entre no carro primeiro!",
                Time = 5
            })
        end
    else
        redzlib:MakeNotification({
            Name = "Erro",
            Content = "Coloque um carro primeiro!",
            Time = 5
        })
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

-- Turbo V2 Section
local SecaoTurboV2 = AbaCarro:AddSection({"Turbo V2"})

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

AbaCarro:AddParagraph({"Informação:", "Ambos os turbos não precisam de Gamepass"})

-- Music Section
local SecaoMusica = AbaCarro:AddSection({"Música para Carros e Casas"})

local musicasIds = {
    "71373562243752", "138129019858244", "138480372357526", "122199933878670",
    "74187181906707", "82793916573031", "107421761958790", "91394092603440",
    "113198957973421", "81452315991527", "93786060174790", "74752089069476",
    "131592235762789", "132081774507495", "124394293950763", "83381647646350",
    "16190782181", "1841682637", "3148329638", "124928367733395",
    "106317184644394", "100247055114504", "107035638005233", "109351649716900",
    "84751398517083", "125259969174449", "89269071829332", "88094479399489",
    "72440232513341", "92893359226454", "111281710445018", "98677515506006",
    "105882833374061", "104541292443133", "105832154444494", "84733736048142",
    "94718473830640", "130324826943718", "123039027577735", "113312785512702",
    "139161205970637", "113768944849093", "135667903253566", "81335392002580",
    "77428091165211", "14145624031", "8080255618", "8654835474",
    "13530439502", "18841894272", "90323407842935", "136932193331774",
    "113504863495384", "1836175030", "79998949362539", "109188610023287",
    "134939857094956", "132245626038510", "124567809277408", "72591334498716",
    "76578817848504", "17422156627", "81902909302285", "130449561461006",
    "110519234838026", "106434295960535", "86271123924168", "85481949732828",
    "106476166672589", "87968531262747", "73966367524216", "137962454483542",
    "98371771055411", "111668097052966", "140095882383991", "122873874738223",
    "105461615542794"
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

AbaCarro:AddParagraph({"Nota", "O script de música funciona em todos os carros e casas"})

-- Car RGB Section
local SecaoCarroRGB = AbaCarro:AddSection({"Carro RGB"})

local corMudando = false
local coroutineCor = nil
local conexaoCarroRGB = nil

local function mudarCorCarro()
    while corMudando do
        for _, cor in ipairs(cores) do
            if not corMudando then return end
            local args = { [1] = "PickingCarColor", [2] = cor }
            eventoRemoto:FireServer(unpack(args))
            wait(1)
        end
    end
end

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

AbaCarro:AddParagraph({"Nota", "Ativando isso deixará seu carro RGB"})

-- Spam Horn Section
local SecaoSpamBuzina = AbaCarro:AddSection({"Spam de Buzina"})

local spammando = false
local argsBuzina = {"Horn"}

local function spamBuzina()
    while spammando do
        eventoRemoto:FireServer(unpack(argsBuzina))
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

-- Fly Car Section
local SecaoVoarCarro = AbaCarro:AddSection({"Voar com Carro"})

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
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
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
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * VelocidadeBox.Text
            wait(.1)
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
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
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
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * -VelocidadeBox.Text
            wait(.1)
            torso.BodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * 0
        end)
    end
})

AbaCarro:AddParagraph({"Nota", "Ativando isso você pode voar com o seu carro"})

-- Spam Cars Section
local SecaoSpamCarros = AbaCarro:AddSection({"Spam de Carros"})

local listaCarros = {
    "SchoolBus", "SmartCar", "FarmTruck", "Cadillac", "Excavator",
    "Jeep", "NascarTruck", "TowTruck", "Snowplow", "MilitaryTruck",
    "Tank", "Limo", "FireTruck"
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

AbaCarro:AddParagraph({"Informação:", "Spamar vários carros"})

-- Aba Criança
local AbaCrianca = Janela:MakeTab({"Criança", "baby"})

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

            if rawget(getgenv(), "ServicoExecucao") then
                return
            end

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

AbaCrianca:AddParagraph({
    Title = "FE",
    Content = "Funcionalidades FE"
})

-- Aba Jogador Local
local AbaJogadorLocal = Janela:MakeTab({"Jogador Local", "user"})

local SecaoLocal = AbaJogadorLocal:AddSection({ Name = "Velocidade, Gravidade e Pulo" })

AbaJogadorLocal:AddTextBox({
    Name = "Velocidade do Jogador",
    PlaceholderText = "Digite a velocidade",
    Callback = function(valor)
        local velocidade = tonumber(valor)
        if velocidade and JogadorLocal.Character and JogadorLocal.Character:FindFirstChild("Humanoid") then
            JogadorLocal.Character.Humanoid.WalkSpeed = velocidade
        else
            warn("Velocidade inválida ou personagem não encontrado!")
        end
    end
})

AbaJogadorLocal:AddButton({
    Name = "Resetar Velocidade",
    Callback = function()
        if JogadorLocal.Character and JogadorLocal.Character:FindFirstChild("Humanoid") then
            JogadorLocal.Character.Humanoid.WalkSpeed = 16
        end
    end
})

AbaJogadorLocal:AddTextBox({
    Name = "Altura do Pulo",
    PlaceholderText = "Digite a altura do pulo",
    Callback = function(valor)
        local alturaPulo = tonumber(valor)
        if alturaPulo and JogadorLocal.Character and JogadorLocal.Character:FindFirstChild("Humanoid") then
            JogadorLocal.Character.Humanoid.JumpPower = alturaPulo
        else
            warn("Altura de pulo inválida ou personagem não encontrado!")
        end
    end
})

AbaJogadorLocal:AddButton({
    Name = "Resetar Pulo",
    Callback = function()
        if JogadorLocal.Character and JogadorLocal.Character:FindFirstChild("Humanoid") then
            JogadorLocal.Character.Humanoid.JumpPower = 50
        end
    end
})

AbaJogadorLocal:AddTextBox({
    Name = "Gravidade",
    PlaceholderText = "Digite a gravidade",
    Callback = function(valor)
        local gravidade = tonumber(valor)
        if gravidade then
            workspace.Gravity = gravidade
        else
            warn("Gravidade inválida!")
        end
    end
})

AbaJogadorLocal:AddButton({
    Name = "Resetar Gravidade",
    Callback = function()
        workspace.Gravity = 196.2
    end
})

-- Spam Chat Section
local SecaoSpamChat = AbaJogadorLocal:AddSection({ Name = "Spam no Chat" })

local textoSalvo
local servicoChatTexto = game:GetService("TextChatService")
local chat = servicoChatTexto.ChatInputBarConfiguration and servicoChatTexto.ChatInputBarConfiguration.TargetTextChannel

function enviarChat(msg)
    if not msg or msg == "" then return end
    if servicoChatTexto.ChatVersion == Enum.ChatVersion.LegacyChatService then
        local sucesso, erro = pcall(function()
            game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents").SayMessageRequest:FireServer(msg, "All")
        end)
        if not sucesso then
            warn("Erro ao enviar chat: " .. erro)
        end
    elseif chat then
        local sucesso, erro = pcall(function()
            chat:SendAsync(msg)
        end)
        if not sucesso then
            warn("Erro ao enviar chat: " .. erro)
        end
    end
end

AbaJogadorLocal:AddTextBox({
    Name = "Digite o texto",
    PlaceholderText = "Digite a mensagem",
    Callback = function(texto)
        textoSalvo = texto
    end
})

AbaJogadorLocal:AddButton({
    Name = "Enviar Chat",
    Callback = function()
        enviarChat(textoSalvo)
    end
})

getgenv().VortexHubDelayEnvio = 1

AbaJogadorLocal:AddSlider({
    Name = "Delay do Spam",
    Min = 0.4,
    Max = 10,
    Default = 1,
    Increment = 0.1,
    Callback = function(Valor)
        getgenv().VortexHubDelayEnvio = Valor
    end
})

AbaJogadorLocal:AddToggle({
    Name = "Spam no Chat",
    Default = false,
    Flag = "spam_textos",
    Callback = function(Valor)
        getgenv().VortexHubSpamTexto = Valor
        while getgenv().VortexHubSpamTexto do
            enviarChat(textoSalvo)
            task.wait(getgenv().VortexHubDelayEnvio)
        end
    end
})

AbaJogadorLocal:AddButton({
    Name = "Spam chat Hacked By Mafia",
    Callback = function()
        if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("hi\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\rServer: Hacked by VORTEX HUB")
        else
            print("Nada")
        end
    end
})

AbaJogadorLocal:AddButton({
    Name = "Limpar Chat",
    Callback = function()
        if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("hi\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\rServer: Chat Limpo")
        else
            print("Nada")
        end
    end
})

-- Headsit Section
local SecaoHeadsit = AbaJogadorLocal:AddSection({ Name = "Head Sit" })

local cabecaSelecionada = nil
local conexaoCabeca = nil

local menuCabeca = AbaJogadorLocal:AddDropdown({
    Name = "Selecionar Jogador",
    Default = "",
    Options = atualizarListaJogadoresCrianca(),
    Callback = function(Valor)
        cabecaSelecionada = Valor
    end
})

AbaJogadorLocal:AddToggle({
    Name = "Head Sit (Cavalinho)",
    Default = false,
    Callback = function(estado)
        local jogador = game.Players.LocalPlayer
        local personagem = jogador.Character or jogador.CharacterAdded:Wait()
        local torso = personagem:WaitForChild("HumanoidRootPart")
        local humanoide = personagem:WaitForChild("Humanoid")

        if not cabecaSelecionada or cabecaSelecionada == "" then
            warn("Nenhum jogador selecionado para Head Sit!")
            return false
        end

        local jogadorSelecionado = game.Players:FindFirstChild(cabecaSelecionada)

        if estado then
            if jogadorSelecionado and jogadorSelecionado.Character then
                humanoide.Sit = true

                if conexaoCabeca then
                    conexaoCabeca:Disconnect()
                end

                conexaoCabeca = game:GetService("RunService").Heartbeat:Connect(function()
                    if jogadorSelecionado.Character and jogadorSelecionado.Character:FindFirstChild("Head") and humanoide.Sit then
                        local cabecaAlvo = jogadorSelecionado.Character.Head
                        torso.CFrame = cabecaAlvo.CFrame * CFrame.Angles(0, 0, 0) * CFrame.new(0, 1.6, 0.4)
                    else
                        if conexaoCabeca then
                            conexaoCabeca:Disconnect()
                            conexaoCabeca = nil
                            humanoide.Sit = false
                        end
                    end
                end)
            else
                warn("Jogador selecionado não encontrado ou sem Character!")
                return false
            end
        else
            if conexaoCabeca then
                conexaoCabeca:Disconnect()
                conexaoCabeca = nil
            end
            humanoide.Sit = false
        end
    end
})

AbaJogadorLocal:AddButton({
    Name = "Atualizar Lista",
    Callback = function()
        local listaAtualizada = atualizarListaJogadoresCrianca()
        if menuCabeca and listaAtualizada then
            pcall(function()
                menuCabeca:Refresh(listaAtualizada)
            end)
            if cabecaSelecionada and not game.Players:FindFirstChild(cabecaSelecionada) then
                cabecaSelecionada = nil
                pcall(function()
                    menuCabeca:Set("")
                end)
            end
        end
    end
})

-- Aba Skybox
local AbaSkybox = Janela:MakeTab({ Title = "Skybox", Icon = "cloud" })

AbaSkybox:AddSection({ "Skybox by Bazuka" })
AbaSkybox:AddButton({
    Name = "Skybox",
    Callback = function()
        loadstring(game:HttpGet("https://api.rubis.app/v2/scrap/qZkSict1retkqFIr/raw"))()
    end
})

local skyboxAtivo = false
local trackSkybox = nil
local trackRigido = nil
local corpoSalvo = {}

local function pararTodasAnimacoes()
    if trackRigido then
        pcall(function()
            trackRigido:Stop()
            trackRigido:Destroy()
        end)
        trackRigido = nil
    end

    if trackSkybox then
        pcall(function()
            trackSkybox:Stop()
            trackSkybox:Destroy()
        end)
        trackSkybox = nil
    end

    local jogador = game.Players.LocalPlayer
    local personagem = jogador.Character
    if personagem then
        local humanoide = personagem:FindFirstChild("Humanoid")
        if humanoide then
            local animador = humanoide:FindFirstChild("Animator")
            if animador then
                for _, track in pairs(animador:GetPlayingAnimationTracks()) do
                    if track.Animation then
                        local animId = track.Animation.AnimationId
                        if animId == "rbxassetid://70883871260184" or animId == "rbxassetid://3695333486" then
                            pcall(function()
                                track:Stop()
                            end)
                        end
                    end
                end
            end
        end
    end
end

AbaSkybox:AddToggle({
    Name = "Nuke Skybox",
    Default = false,
    Callback = function(valor)
        skyboxAtivo = valor

        if valor then
            local jogador = game.Players.LocalPlayer
            local personagem = jogador.Character

            if personagem then
                local humanoide = personagem:FindFirstChildOfClass("Humanoid")
                if humanoide then
                    local descricao = humanoide:GetAppliedDescription()

                    corpoSalvo = {
                        Torso = descricao.Torso,
                        RightArm = descricao.RightArm,
                        LeftArm = descricao.LeftArm,
                        RightLeg = descricao.RightLeg,
                        LeftLeg = descricao.LeftLeg,
                        Head = descricao.Head
                    }

                    task.wait(0.2)

                    local args = {
                        [1] = 123402086843885,
                        [2] = 100839513065432,
                        [3] = 78300682916056,
                        [4] = 86276701020724,
                        [5] = 78409653958165,
                        [6] = 15093053680
                    }

                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes.ChangeCharacterBody:InvokeServer(args)
                    end)

                    task.wait(0.3)

                    local novaAnim = Instance.new("Animation")
                    novaAnim.AnimationId = "rbxassetid://70883871260184"

                    trackSkybox = humanoide:LoadAnimation(novaAnim)
                    trackSkybox.Priority = Enum.AnimationPriority.Action4
                    trackSkybox:Play(0.1, 1, 0.01)

                    task.wait(0.5)

                    local plankAnim = Instance.new("Animation")
                    plankAnim.AnimationId = "rbxassetid://3695333486"
                    trackRigido = humanoide:LoadAnimation(plankAnim)
                    trackRigido.Priority = Enum.AnimationPriority.Movement
                    trackRigido:Play(0.1, 1, 0)
                end
            end
        else
            pararTodasAnimacoes()

            task.wait(0.2)

            if next(corpoSalvo) then
                local jogador = game.Players.LocalPlayer
                local personagem = jogador.Character

                if personagem then
                    local humanoide = personagem:FindFirstChildOfClass("Humanoid")
                    if humanoide then
                        local restaurarCorpo = {
                            [1] = corpoSalvo.Torso,
                            [2] = corpoSalvo.RightArm,
                            [3] = corpoSalvo.LeftArm,
                            [4] = corpoSalvo.RightLeg,
                            [5] = corpoSalvo.LeftLeg,
                            [6] = corpoSalvo.Head
                        }

                        local args = { [1] = restaurarCorpo }

                        pcall(function()
                            game:GetService("ReplicatedStorage").Remotes.ChangeCharacterBody:InvokeServer(unpack(args))
                        end)

                        corpoSalvo = {}
                    end
                end
            end
        end
    end
})

-- Nuke FlashBack
local nukeFlashAtivo = false
local trackNukeFlash = nil
local trackFlashRigido = nil
local corpoNukeSalvo = {}

local function pararAnimacoesFlash()
    if trackFlashRigido then
        pcall(function()
            trackFlashRigido:Stop()
            trackFlashRigido:Destroy()
        end)
        trackFlashRigido = nil
    end

    if trackNukeFlash then
        pcall(function()
            trackNukeFlash:Stop()
            trackNukeFlash:Destroy()
        end)
        trackNukeFlash = nil
    end
end

AbaSkybox:AddToggle({
    Name = "Nuke FlashBack",
    Default = false,
    Callback = function(valor)
        nukeFlashAtivo = valor

        if valor then
            local jogador = game.Players.LocalPlayer
            local personagem = jogador.Character

            if personagem then
                local humanoide = personagem:FindFirstChildOfClass("Humanoid")
                if humanoide then
                    local descricao = humanoide:GetAppliedDescription()

                    corpoNukeSalvo = {
                        Torso = descricao.Torso,
                        RightArm = descricao.RightArm,
                        LeftArm = descricao.LeftArm,
                        RightLeg = descricao.RightLeg,
                        LeftLeg = descricao.LeftLeg,
                        Head = descricao.Head
                    }

                    task.wait(0.2)

                    local args = {
                        [1] = 123402086843885,
                        [2] = 100839513065432,
                        [3] = 78300682916056,
                        [4] = 86276701020724,
                        [5] = 78409653958165,
                        [6] = 15093053680
                    }

                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes.ChangeCharacterBody:InvokeServer(args)
                    end)

                    task.wait(0.3)

                    local novaAnim = Instance.new("Animation")
                    novaAnim.AnimationId = "rbxassetid://70883871260184"

                    trackNukeFlash = humanoide:LoadAnimation(novaAnim)
                    trackNukeFlash.Priority = Enum.AnimationPriority.Action4
                    trackNukeFlash:Play(0.1, 1, 1)

                    task.wait(0.1)
                    trackNukeFlash:AdjustSpeed(5)

                    task.wait(0.3)

                    local plankAnim = Instance.new("Animation")
                    plankAnim.AnimationId = "rbxassetid://3695333486"
                    trackFlashRigido = humanoide:LoadAnimation(plankAnim)
                    trackFlashRigido.Priority = Enum.AnimationPriority.Movement
                    trackFlashRigido:Play(0.1, 1, 0)
                end
            end
        else
            pararAnimacoesFlash()

            task.wait(0.2)

            if next(corpoNukeSalvo) then
                local jogador = game.Players.LocalPlayer
                local personagem = jogador.Character

                if personagem then
                    local humanoide = personagem:FindFirstChildOfClass("Humanoid")
                    if humanoide then
                        local restaurarCorpo = {
                            [1] = corpoNukeSalvo.Torso,
                            [2] = corpoNukeSalvo.RightArm,
                            [3] = corpoNukeSalvo.LeftArm,
                            [4] = corpoNukeSalvo.RightLeg,
                            [5] = corpoNukeSalvo.LeftLeg,
                            [6] = corpoNukeSalvo.Head
                        }

                        local args = { [1] = restaurarCorpo }

                        pcall(function()
                            game:GetService("ReplicatedStorage").Remotes.ChangeCharacterBody:InvokeServer(unpack(args))
                        end)

                        corpoNukeSalvo = {}
                    end
                end
            end
        end
    end
})

-- Aba Proteções
local AbaProtecoes = Janela:MakeTab({"Proteções", "rbxassetid://11322093465"})

local JogadorLocalProt = game:GetService("Players").LocalPlayer
local Mundo = game:GetService("Workspace")
local ServicoExecucao = game:GetService("RunService")

local tabelasBackup = {
    Veiculos = {},
    Canoas = {},
    Jatos = {},
    Helicopteros = {},
    Bolas = {}
}

local TeleporteCarro = {}
function TeleporteCarro:MostrarNotificacao(msg)
    print("🔝 "..msg)
end

local function LoopAntiFling(nome, obterPastaFunc)
    local ativo = false
    task.spawn(function()
        while true do
            if ativo and JogadorLocalProt.Character then
                local pasta = obterPastaFunc()
                if pasta then
                    for _, item in ipairs(pasta:GetChildren()) do
                        local ehMeu = false
                        if nome == "Veiculos" then
                            for _, assento in ipairs(item:GetDescendants()) do
                                if (assento:IsA("VehicleSeat") or assento:IsA("Seat")) and assento.Occupant and assento.Occupant.Parent == JogadorLocalProt.Character then
                                    ehMeu = true
                                    break
                                end
                            end
                        elseif nome == "Canoas" then
                            local dono = item:FindFirstChild("Owner")
                            ehMeu = dono and dono.Value == JogadorLocalProt
                        elseif nome == "Jatos" or nome == "Helicopteros" then
                            ehMeu = item.Name == JogadorLocalProt.Name
                        end
                        if not ehMeu then
                            table.insert(tabelasBackup[nome], item:Clone())
                            item:Destroy()
                        end
                    end
                end
            end
            task.wait(0.03)
        end
    end)
    return function(estado)
        ativo = estado
        TeleporteCarro:MostrarNotificacao(nome.." "..(estado and "ativado!" or "desativado!"))
        if not estado then
            for _, item in ipairs(tabelasBackup[nome]) do
                local pastaPai = obterPastaFunc()
                if pastaPai then item.Parent = pastaPai end
            end
            tabelasBackup[nome] = {}
        end
    end
end

AbaProtecoes:AddToggle({
    Name = "Anti Fling Canoa",
    Description = "",
    Default = false,
    Callback = LoopAntiFling("Canoas", function()
        local workspaceCom = Mundo:FindFirstChild("WorkspaceCom")
        return workspaceCom and workspaceCom:FindFirstChild("001_CanoeStorage")
    end)
})

AbaProtecoes:AddToggle({
    Name = "Anti Fling Jatos",
    Description = "",
    Default = false,
    Callback = LoopAntiFling("Jatos", function()
        local pasta = Mundo:FindFirstChild("WorkspaceCom")
        if pasta and pasta:FindFirstChild("001_Airport") then
            local armazenamento = pasta["001_Airport"]:FindFirstChild("AirportHanger")
            if armazenamento then return armazenamento:FindFirstChild("001_JetStorage") and armazenamento["001_JetStorage"]:FindFirstChild("JetAirport") end
        end
    end)
})

AbaProtecoes:AddToggle({
    Name = "Anti Fling Helicopteros",
    Description = "",
    Default = false,
    Callback = LoopAntiFling("Helicopteros", function()
        local pasta = Mundo:FindFirstChild("WorkspaceCom")
        return pasta and pasta:FindFirstChild("001_HeliStorage") and pasta["001_HeliStorage"]:FindFirstChild("PoliceStationHeli")
    end)
})

AbaProtecoes:AddToggle({
    Name = "Anti Fling Bola",
    Description = "",
    Default = false,
    Callback = LoopAntiFling("Bolas", function()
        local pasta = Mundo:FindFirstChild("WorkspaceCom")
        return pasta and pasta:FindFirstChild("001_SoccerBalls")
    end)
})

local antiSentarAtivo = false
AbaProtecoes:AddToggle({
    Name = "Anti Sentar",
    Description = "",
    Default = false,
    Callback = function(estado)
        antiSentarAtivo = estado
        TeleporteCarro:MostrarNotificacao("Anti Sentar "..(estado and "ativado!" or "desativado!"))
        task.spawn(function()
            while antiSentarAtivo and JogadorLocalProt.Character do
                local humanoide = JogadorLocalProt.Character:FindFirstChildOfClass("Humanoid")
                if humanoide then
                    humanoide:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                    if humanoide:GetState() == Enum.HumanoidStateType.Seated then
                        humanoide:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end
                task.wait(0.05)
            end
            if not antiSentarAtivo then
                local humanoide = JogadorLocalProt.Character and JogadorLocalProt.Character:FindFirstChildOfClass("Humanoid")
                if humanoide then
                    humanoide:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                end
            end
        end)
    end
})

AbaProtecoes:AddToggle({
    Name = "Anti-Lag",
    Description = "",
    Default = false,
    Callback = function(estado)
        local Jogadores = game:GetService("Players")
        local travaDuplicacao = {}
        local JOGADOR_IGNORADO

        if not estado then return end

        local function marcarIgnorado(jogador)
            JOGADOR_IGNORADO = jogador
        end

        local function ehFerramentaAlvo(inst)
            return inst:IsA("Tool")
        end

        local function coletarFerramentas(jogador)
            local encontradas = {}
            local containers = {}
            if jogador.Character then table.insert(containers, jogador.Character) end
            local mochila = jogador:FindFirstChildOfClass("Backpack")
            if mochila then table.insert(containers, mochila) end
            local gearInicial = jogador:FindFirstChild("StarterGear")
            if gearInicial then table.insert(containers, gearInicial) end
            for _, container in ipairs(containers) do
                for _, filho in ipairs(container:GetChildren()) do
                    if ehFerramentaAlvo(filho) then table.insert(encontradas, filho) end
                end
            end
            return encontradas
        end

        local function deduplicarJogador(jogador)
            if jogador == JOGADOR_IGNORADO then return end
            if travaDuplicacao[jogador] then return end
            travaDuplicacao[jogador] = true
            local ferramentas = coletarFerramentas(jogador)
            if #ferramentas > 1 then
                for i = 2, #ferramentas do pcall(function() ferramentas[i]:Destroy() end) end
            end
            travaDuplicacao[jogador] = false
        end

        local function hookJogador(jogador)
            if not JOGADOR_IGNORADO then marcarIgnorado(jogador) end
            task.defer(deduplicarJogador, jogador)
            local function configurarChar(char)
                task.delay(0.5, function() deduplicarJogador(jogador) end)
                char.ChildAdded:Connect(function(filho)
                    if ehFerramentaAlvo(filho) then task.delay(0.1, function() deduplicarJogador(jogador) end) end
                end)
            end
            if jogador.Character then configurarChar(jogador.Character) end
            jogador.CharacterAdded:Connect(configurarChar)
            local mochila = jogador:WaitForChild("Backpack", 10)
            if mochila then
                mochila.ChildAdded:Connect(function(filho)
                    if ehFerramentaAlvo(filho) then task.delay(0.1, function() deduplicarJogador(jogador) end) end
                end)
            end
            local sg = jogador:FindFirstChild("StarterGear") or jogador:WaitForChild("StarterGear", 10)
            if sg then
                sg.ChildAdded:Connect(function(filho)
                    if ehFerramentaAlvo(filho) then task.delay(0.1, function() deduplicarJogador(jogador) end) end
                end)
            end
        end

        Jogadores.PlayerAdded:Connect(hookJogador)
        for _, plr in ipairs(Jogadores:GetPlayers()) do hookJogador(plr) end

        task.spawn(function()
            while estado do
                for _, plr in ipairs(Jogadores:GetPlayers()) do deduplicarJogador(plr) end
                task.wait(2)
            end
        end)
    end
})

-- Aba Editor de Avatar
local AbaAvatarEditor = Janela:MakeTab({"Editor de Avatar", "shirt"})

AbaAvatarEditor:AddSection({"Editor de Avatar"})

AbaAvatarEditor:AddParagraph({
    Title = "Aviso: Vai resetar seu avatar",
    Content = ""
})

AbaAvatarEditor:AddButton({
    Name = "Mini REPO",
    Description = "Avatar mini personalizado",
    Callback = function()
        local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
        local StarterGui = game:GetService("StarterGui")

        pcall(function()
            local partes = {
                117101023704825,
                125767940563838,
                137301494386930,
                87357384184710,
                133391239416999,
                111818794467824
            }
            local args = {partes}
            ArmazenamentoReplicado:WaitForChild("Remotes"):WaitForChild("ChangeCharacterBody"):InvokeServer(unpack(args))
            StarterGui:SetCore("SendNotification", {
                Title = "Avatar",
                Text = "Mini REPO equipado!",
                Duration = 3
            })
        end)
    end
})

AbaAvatarEditor:AddButton({
    Name = "Mini Garanhão",
    Description = "Avatar mini garanhão",
    Callback = function()
        local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
        local StarterGui = game:GetService("StarterGui")

        pcall(function()
            local partes = {
                124355047456535,
                120507500641962,
                82273782655463,
                113625313757230,
                109182039511426,
                0
            }
            local args = {partes}
            ArmazenamentoReplicado:WaitForChild("Remotes"):WaitForChild("ChangeCharacterBody"):InvokeServer(unpack(args))
            StarterGui:SetCore("SendNotification", {
                Title = "Avatar",
                Text = "Mini Garanhão equipado!",
                Duration = 3
            })
        end)
    end
})

AbaAvatarEditor:AddButton({
    Name = "Stick",
    Description = "Avatar estilo palito",
    Callback = function()
        local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
        local StarterGui = game:GetService("StarterGui")

        pcall(function()
            local partes = {
                14731384498,
                14731377938,
                14731377894,
                14731377875,
                14731377941,
                14731382899
            }
            local args = {partes}
            ArmazenamentoReplicado:WaitForChild("Remotes"):WaitForChild("ChangeCharacterBody"):InvokeServer(unpack(args))
            StarterGui:SetCore("SendNotification", {
                Title = "Avatar",
                Text = "Stick equipado!",
                Duration = 3
            })
        end)
    end
})

AbaAvatarEditor:AddButton({
    Name = "Chunky-Bug",
    Description = "Avatar estilo bug",
    Callback = function()
        local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
        local StarterGui = game:GetService("StarterGui")

        pcall(function()
            local partes = {
                15527827600,
                15527827578,
                15527831669,
                15527836067,
                15527827184,
                15527827599
            }
            local args = {partes}
            ArmazenamentoReplicado:WaitForChild("Remotes"):WaitForChild("ChangeCharacterBody"):InvokeServer(unpack(args))
            StarterGui:SetCore("SendNotification", {
                Title = "Avatar",
                Text = "Chunky-Bug equipado!",
                Duration = 3
            })
        end)
    end
})

AbaAvatarEditor:AddButton({
    Name = "Cursed-Spider",
    Description = "Avatar aranha amaldiçoada",
    Callback = function()
        local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
        local StarterGui = game:GetService("StarterGui")

        pcall(function()
            local partes = {
                134555168634906,
                100269043793774,
                125607053187319,
                122504853343598,
                95907982259204,
                91289185840375
            }
            local args = {partes}
            ArmazenamentoReplicado:WaitForChild("Remotes"):WaitForChild("ChangeCharacterBody"):InvokeServer(unpack(args))
            StarterGui:SetCore("SendNotification", {
                Title = "Avatar",
                Text = "Cursed-Spider equipado!",
                Duration = 3
            })
        end)
    end
})

AbaAvatarEditor:AddButton({
    Name = "Possessed-Horror",
    Description = "Avatar horror possuído",
    Callback = function()
        local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
        local StarterGui = game:GetService("StarterGui")

        pcall(function()
            local partes = {
                122800511983371,
                132465361516275,
                125155800236527,
                83070163355072,
                102906187256945,
                78311422507297
            }
            local args = {partes}
            ArmazenamentoReplicado:WaitForChild("Remotes"):WaitForChild("ChangeCharacterBody"):InvokeServer(unpack(args))
            StarterGui:SetCore("SendNotification", {
                Title = "Avatar",
                Text = "Possessed-Horror equipado!",
                Duration = 3
            })
        end)
    end
})

-- Aba Scripts
local AbaScripts = Janela:MakeTab({"Scripts", "rbxassetid://130521044774541"})

AbaScripts:AddButton({
    Name = "FE Invisível",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TROLLLINUXKKK/Fe-invis-vel-/refs/heads/main/Main.txt"))()
    end
})

AbaScripts:AddSection({ "Desastres Naturais" })

AbaScripts:AddButton({
    Name = "Tornado Instável com Navio (FE)",
    Description = "Cria um tornado FE com movimento caótico e instável",
    Callback = function()
        local RS = game:GetService("ReplicatedStorage")
        local RunService = game:GetService("RunService")
        local TextChatService = game:GetService("TextChatService")
        local Player = game.Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        local RootPart = Character:WaitForChild("HumanoidRootPart")
        local Vehicles = workspace:WaitForChild("Vehicles")

        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatService.TextChannels.RBXGeneral:SendAsync(
                "hi\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r[ UM TORNADO SURGIU! VORTEX HUB ON TOP ]"
            )
        end

        local audioSelecionadoID = 9068077052
        local function tocarAudio()
            if not audioSelecionadoID then
                warn("Nenhum áudio selecionado!")
                return
            end

            local args = {
                [1] = workspace,
                [2] = audioSelecionadoID,
                [3] = 1,
            }

            for i = 1, 5 do
                RS.RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))

                local som = Instance.new("Sound")
                som.SoundId = "rbxassetid://" .. tostring(audioSelecionadoID)
                som.Parent = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                if som.Parent then
                    som:Play()
                else
                    warn("HumanoidRootPart não encontrado")
                    break
                end

                task.wait(1.5)
                som:Destroy()
            end
        end

        local function spawnarBarco()
            RootPart.CFrame = CFrame.new(1754, -2, 58)
            task.wait(0.5)
            RS:WaitForChild("RE"):FindFirstChild("1Ca1r"):FireServer("PickingBoat", "PirateFree")
            task.wait(1)
            return Vehicles:FindFirstChild(Player.Name .. "Car")
        end

        local PCarro = spawnarBarco()
        if not PCarro then
            warn("Falha ao spawnar o barco")
            return
        end

        print("Barco PirateFree gerado!")

        local Assento = PCarro:FindFirstChild("Body") and PCarro.Body:FindFirstChild("VehicleSeat")
        if not Assento then
            warn("Assento não encontrado")
            return
        end

        repeat
            task.wait(0.1)
            RootPart.CFrame = Assento.CFrame * CFrame.new(0, 1, 0)
        until Humanoid.SeatPart == Assento

        print("Jogador sentado com sucesso!")

        task.spawn(tocarAudio)

        task.delay(4, function()
            if Humanoid.SeatPart then
                Humanoid.Sit = false
            end
            RootPart.CFrame = CFrame.new(0, 0, 0)
            print("Jogador ejetado e teleportado")
        end)

        local RE_Flip = RS:WaitForChild("RE"):WaitForChild("1Player1sCa1r")
        task.spawn(function()
            while PCarro and PCarro.Parent do
                RE_Flip:FireServer("Flip")
                task.wait(0.5)
            end
        end)

        local waypoints = {
            Vector3.new(-16, 0, -47),
            Vector3.new(-110, 0, -45),
            Vector3.new(16, 0, -55)
        }

        local indiceAtual = 1
        local proximoIndice = 2
        local velocidadeMovimento = 15
        local velocidadeRotacao = math.rad(720)
        local progresso = 0
        local rotacaoAtual = 0

        local function lerpCFrame(a, b, t)
            return a:lerp(b, t)
        end

        RunService.Heartbeat:Connect(function(dt)
            if not (PCarro and PCarro.PrimaryPart) then return end

            local inicioPos = waypoints[indiceAtual]
            local fimPos = waypoints[proximoIndice]

            progresso = progresso + (velocidadeMovimento * dt) / (inicioPos - fimPos).Magnitude
            if progresso >= 1 then
                progresso = 0
                indiceAtual = proximoIndice
                proximoIndice = (proximoIndice % #waypoints) + 1
            end

            local novaPos = lerpCFrame(CFrame.new(inicioPos), CFrame.new(fimPos), progresso).p
            rotacaoAtual = rotacaoAtual + velocidadeRotacao * dt

            local cf = CFrame.new(novaPos) * CFrame.Angles(0, rotacaoAtual, 0)
            PCarro:SetPrimaryPartCFrame(cf)
        end)
    end
})

AbaScripts:AddButton({
    Name = "Desativar Tornado e Remover Veículo",
    Description = "Para o tornado FE, remove o barco e ejeta o jogador",
    Callback = function()
        local sucesso, erro = pcall(function()
            local args = { "DeleteAllVehicles" }
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("1Ca1r"):FireServer(unpack(args))
        end)

        if not sucesso then
            warn("Falha ao deletar veículos:", erro)
        else
            print("[VORTEX HUB] Tornado finalizado e veículos deletados.")
        end
    end
})

-- ESP Section
AbaScripts:AddSection({ "ESP" })

_G.ESPData = _G.ESPData or {
    espAtivo = false,
    tipoESP = "Nome + Idade",
    corSelecionada = "RGB",
    billboardGuis = {},
    highlights = {},
    linhas = {},
    conexoes = {}
}

local JogadoresESP = game:GetService("Players")
local ServicoExecucaoESP = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local function obterCorESP()
    local cores = {
        RGB = function()
            local h = (tick() % 5) / 5
            return Color3.fromHSV(h, 1, 1)
        end,
        Preto = Color3.fromRGB(0,0,0),
        Branco = Color3.fromRGB(255,255,255),
        Vermelho = Color3.fromRGB(255,0,0),
        Verde = Color3.fromRGB(0,255,0),
        Azul = Color3.fromRGB(0,170,255),
        Amarelo = Color3.fromRGB(255,255,0),
        Rosa = Color3.fromRGB(255,105,180),
        Roxo = Color3.fromRGB(128,0,128)
    }

    local c = cores[_G.ESPData.corSelecionada]
    return type(c) == "function" and c() or c or Color3.new(1,1,1)
end

_G.limparTodosESP = function()
    for _, gui in pairs(_G.ESPData.billboardGuis) do
        pcall(function() gui:Destroy() end)
    end
    for _, h in pairs(_G.ESPData.highlights) do
        pcall(function() h:Destroy() end)
    end
    for _, l in pairs(_G.ESPData.linhas) do
        pcall(function() l:Remove() end)
    end
    for _, c in pairs(_G.ESPData.conexoes) do
        pcall(function() c:Disconnect() end)
    end

    _G.ESPData.billboardGuis = {}
    _G.ESPData.highlights = {}
    _G.ESPData.linhas = {}
    _G.ESPData.conexoes = {}
end

local function criarNomeESP(jogador)
    if jogador == JogadoresESP.LocalPlayer then return end
    if not jogador.Character or not jogador.Character:FindFirstChild("Head") then return end

    local cabeca = jogador.Character.Head
    if _G.ESPData.billboardGuis[jogador] then
        _G.ESPData.billboardGuis[jogador]:Destroy()
    end

    local gui = Instance.new("BillboardGui", cabeca)
    gui.Size = UDim2.new(0,200,0,50)
    gui.StudsOffset = Vector3.new(0,3,0)
    gui.AlwaysOnTop = true

    local txt = Instance.new("TextLabel", gui)
    txt.Size = UDim2.new(1,0,1,0)
    txt.BackgroundTransparency = 1
    txt.TextStrokeTransparency = 0.5
    txt.Font = Enum.Font.SourceSansBold
    txt.TextSize = 14
    txt.Text = jogador.Name.." | "..jogador.AccountAge.." dias"
    txt.TextColor3 = obterCorESP()

    _G.ESPData.billboardGuis[jogador] = gui
end

local function criarHighlightESP(jogador)
    if jogador == JogadoresESP.LocalPlayer then return end
    if not jogador.Character then return end

    if _G.ESPData.highlights[jogador] then
        _G.ESPData.highlights[jogador]:Destroy()
    end

    local h = Instance.new("Highlight", jogador.Character)
    h.FillColor = obterCorESP()
    h.FillTransparency = 0.5
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    _G.ESPData.highlights[jogador] = h
end

local function criarLinhaESP(jogador)
    if jogador == JogadoresESP.LocalPlayer then return end
    if _G.ESPData.linhas[jogador] then
        pcall(function() _G.ESPData.linhas[jogador]:Remove() end)
    end

    local l = Drawing.new("Line")
    l.Thickness = 2
    l.Transparency = 1
    l.Visible = false

    _G.ESPData.linhas[jogador] = l
end

_G.aplicarESPActual = function()
    _G.limparTodosESP()
    if not _G.ESPData.espAtivo then return end

    for _, p in pairs(JogadoresESP:GetPlayers()) do
        if _G.ESPData.tipoESP == "Nome + Idade" then
            criarNomeESP(p)
        elseif _G.ESPData.tipoESP == "Corpo (Highlight)" then
            criarHighlightESP(p)
        elseif _G.ESPData.tipoESP == "Linhas" then
            criarLinhaESP(p)
        end
    end

    table.insert(_G.ESPData.conexoes,
        ServicoExecucaoESP.RenderStepped:Connect(function()
            if not _G.ESPData.espAtivo then return end
            local cor = obterCorESP()

            if _G.ESPData.tipoESP == "Nome + Idade" then
                for _, gui in pairs(_G.ESPData.billboardGuis) do
                    if gui:FindFirstChildOfClass("TextLabel") then
                        gui.TextLabel.TextColor3 = cor
                    end
                end

            elseif _G.ESPData.tipoESP == "Corpo (Highlight)" then
                for _, h in pairs(_G.ESPData.highlights) do
                    h.FillColor = cor
                end

            elseif _G.ESPData.tipoESP == "Linhas" then
                for p, l in pairs(_G.ESPData.linhas) do
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local pos, visivel = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
                        l.Visible = visivel
                        if visivel then
                            l.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                            l.To = Vector2.new(pos.X, pos.Y)
                            l.Color = cor
                        end
                    else
                        l.Visible = false
                    end
                end
            end
        end)
    )
end

AbaScripts:AddDropdown({
    Name = "Tipo de ESP",
    Options = {"Nome + Idade","Corpo (Highlight)","Linhas"},
    Default = "Nome + Idade",
    Callback = function(v)
        _G.ESPData.tipoESP = v
        if _G.ESPData.espAtivo then
            _G.aplicarESPActual()
        end
    end
})

AbaScripts:AddDropdown({
    Name = "Cor do ESP",
    Options = {"RGB","Branco","Preto","Vermelho","Verde","Azul","Amarelo","Rosa","Roxo"},
    Default = "RGB",
    Callback = function(v)
        _G.ESPData.corSelecionada = v
    end
})

AbaScripts:AddToggle({
    Name = "ESP Ativado",
    Default = false,
    Callback = function(v)
        _G.ESPData.espAtivo = v
        if v then
            _G.aplicarESPActual()
        else
            _G.limparTodosESP()
        end
    end
})

-- Aba Lag Server
local AbaLag = Janela:MakeTab({"Lag no Servidor", "bomb"})

local metodoSelecionado = nil
local metodoAtivo = false

local function clicarNormalmente(objeto)
    local clickDetector = objeto:FindFirstChildWhichIsA("ClickDetector")
    if clickDetector then
        fireclickdetector(clickDetector)
    end
end

AbaLag:AddDropdown({
    Name = "Selecionar Método",
    Options = {"Laptop", "Telefone", "Bomba"},
    Default = "",
    Callback = function(valor)
        metodoSelecionado = valor
    end
})

AbaLag:AddToggle({
    Name = "Ativar Spam",
    Default = false,
    Callback = function(estado)
        metodoAtivo = estado

        if not estado then return end

        if metodoSelecionado == "Laptop" then
            local caminhoLaptop = workspace:FindFirstChild("WorkspaceCom")
                and workspace.WorkspaceCom:FindFirstChild("001_GiveTools")
                and workspace.WorkspaceCom["001_GiveTools"]:FindFirstChild("Laptop")

            if not caminhoLaptop then warn("Laptop não encontrado.") return end

            task.spawn(function()
                local contador = 0
                while metodoAtivo and contador < 999999999 do
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = caminhoLaptop.CFrame
                    clicarNormalmente(caminhoLaptop)
                    contador = contador + 1
                    task.wait(0.0001)
                end
            end)

        elseif metodoSelecionado == "Telefone" then
            local caminhoTelefone = workspace:FindFirstChild("WorkspaceCom")
                and workspace.WorkspaceCom:FindFirstChild("001_CommercialStores")
                and workspace.WorkspaceCom["001_CommercialStores"]:FindFirstChild("CommercialStorage1")
                and workspace.WorkspaceCom["001_CommercialStores"].CommercialStorage1:FindFirstChild("Store")
                and workspace.WorkspaceCom["001_CommercialStores"].CommercialStorage1.Store:FindFirstChild("Tools")
                and workspace.WorkspaceCom["001_CommercialStores"].CommercialStorage1.Store.Tools:FindFirstChild("Iphone")

            if not caminhoTelefone then warn("Telefone não encontrado.") return end

            task.spawn(function()
                local contador = 0
                while metodoAtivo and contador < 999999 do
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = caminhoTelefone.CFrame
                    clicarNormalmente(caminhoTelefone)
                    contador = contador + 1
                    task.wait(0.01)
                end
            end)

        elseif metodoSelecionado == "Bomba" then
            local Jogador = game.Players.LocalPlayer
            local Personagem = Jogador.Character or Jogador.CharacterAdded:Wait()
            local Raiz = Personagem:WaitForChild("HumanoidRootPart")
            local ArmazenamentoReplicado = game:GetService("ReplicatedStorage")
            local Bomba = workspace:WaitForChild("WorkspaceCom")
                :WaitForChild("001_CriminalWeapons")
                :WaitForChild("GiveTools")
                :WaitForChild("Bomb")

            task.spawn(function()
                while metodoAtivo do
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
                local GerenciadorEntradaVirtual = game:GetService("VirtualInputManager")
                while metodoAtivo do
                    if Bomba and Raiz then
                        GerenciadorEntradaVirtual:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                        task.wait(1.5)
                        GerenciadorEntradaVirtual:SendMouseButtonEvent(500, 500, 0, false, game, 0)

                        local args = { [1] = "Bomb" .. Jogador.Name }
                        ArmazenamentoReplicado:WaitForChild("RE"):WaitForChild("1Blo1wBomb1sServe1r"):FireServer(unpack(args))
                    end
                    task.wait(1.5)
                end
            end)
        end
    end
})

print("VORTEX HUB BY GODENOT - CARREGADO COM SUCESSO!")
