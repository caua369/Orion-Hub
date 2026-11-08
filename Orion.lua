--// ORION - Blox Fruits
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local RepS = game:GetService("ReplicatedStorage")
local VU = game:GetService("VirtualUser")
local CS = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local lp = Players.LocalPlayer
local VIM = nil
pcall(function() VIM = game:GetService("VirtualInputManager") end)

local NAME = "ORION"
local VERSION = "v3.0"
local CFG_FILE = "OrionHub_config.json"

--==================== CONFIG (salva em arquivo) ====================
local Config = {
    -- farm
    tweenSpeed = 250, height = 12, weapon = "Melee", fast = true, bring = true, haki = true,
    faceMob = false, noclip = true, chestSpeed = 250, fruitSpeed = 250, tpSpeed = 300,
    store = true, hopDelay = 6, seaHeight = 35, seaSpeed = 250, seaSkills = true,
    bossHeight = 14, bossSkills = true, aimCam = false,
    -- toggles
    farm = false, chest = false, bones = false, cake = false, cakeQuest = false, ignoreKat = false,
    elite = false, killIndra = false, sumIndra = false, pads = false,
    killReaper = false, sumReaper = false, killBeard = false, sumBeard = false, hopBeard = false,
    sLev = false, sLevSeg = false, sBeast = false, sShark = false, sPiranha = false, sFish = false, sGhost = false,
    fruit = false, hop = false,
    espPlayers = false, espFruits = false, espChests = false, espDist = true, espOutline = true,
    spdOn = false, speedVal = 50, cfm = false, infj = false,
}
pcall(function()
    if isfile and isfile(CFG_FILE) then
        local d = HttpService:JSONDecode(readfile(CFG_FILE))
        for k, v in pairs(d) do
            if Config[k] ~= nil and type(v) == type(Config[k]) then Config[k] = v end
        end
    end
end)
local function saveCfg()
    pcall(function()
        if writefile then writefile(CFG_FILE, HttpService:JSONEncode(Config)) end
    end)
end

--==================== LIMPEZA / GUI ====================
pcall(function()
    if getgenv and getgenv().ORION_UNLOAD then getgenv().ORION_UNLOAD() end
end)
local function cleanup(par)
    pcall(function()
        for _, n in ipairs({"ORION", "BETAHUB", "YUBX"}) do
            local o = par:FindFirstChild(n)
            if o then o:Destroy() end
        end
    end)
end
pcall(function() cleanup(game:GetService("CoreGui")) end)
pcall(function() cleanup(lp:WaitForChild("PlayerGui")) end)
pcall(function() if gethui then cleanup(gethui()) end end)

local gui = Instance.new("ScreenGui")
gui.Name = "ORION"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local okp = pcall(function()
    gui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
end)
if not okp or not gui.Parent then gui.Parent = lp:WaitForChild("PlayerGui") end

local C = {
    bg = Color3.fromRGB(12, 13, 19), side = Color3.fromRGB(17, 18, 26), card = Color3.fromRGB(26, 27, 38),
    line = Color3.fromRGB(42, 44, 60), txt = Color3.fromRGB(236, 237, 246), mut = Color3.fromRGB(128, 131, 154),
    off = Color3.fromRGB(52, 54, 72), acc = Color3.fromRGB(99, 102, 241),
}
C.panel = C.card
C.sel = C.acc

local function new(cls, props, par)
    local i = Instance.new(cls)
    for k, v in pairs(props) do i[k] = v end
    i.Parent = par
    return i
end
local function round(p, r) new("UICorner", {CornerRadius = UDim.new(0, r or 8)}, p) end
local function isPress(i)
    return i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch
end
local function isMove(i)
    return i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch
end

local active = {}
local gens = {}
local conns = {}
local function keep(c) table.insert(conns, c) return c end
local function destroyAll()
    for k in pairs(gens) do gens[k] = gens[k] + 1 end
    for k in pairs(active) do active[k] = false end
    for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
    pcall(function() gui:Destroy() end)
end
pcall(function() if getgenv then getgenv().ORION_UNLOAD = destroyAll end end)

--==================== JANELA ====================
local cam0 = workspace.CurrentCamera
local vp = cam0 and cam0.ViewportSize or Vector2.new(1280, 720)
local W = math.min(580, vp.X - 20)
local H = math.min(400, vp.Y - 20)

local main = new("Frame", {
    Size = UDim2.fromOffset(W, H), Position = UDim2.new(0.5, -W / 2, 0.5, -H / 2),
    BackgroundColor3 = C.bg, BorderSizePixel = 0,
}, gui)
round(main, 12)
new("UIStroke", {Thickness = 1, Color = C.line}, main)

local top = new("Frame", {Size = UDim2.new(1, 0, 0, 46), BackgroundTransparency = 1}, main)
new("TextLabel", {
    Size = UDim2.fromOffset(220, 46), Position = UDim2.fromOffset(16, 0), BackgroundTransparency = 1,
    Text = NAME .. '  <font color="rgb(128,131,154)" size="12">' .. VERSION .. "</font>", RichText = true,
    TextColor3 = C.txt, Font = Enum.Font.GothamBold, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left,
}, top)
local infoTop = new("TextLabel", {
    Size = UDim2.fromOffset(170, 46), Position = UDim2.new(1, -250, 0, 0), BackgroundTransparency = 1,
    Text = "Blox Fruits", TextColor3 = C.mut, Font = Enum.Font.GothamMedium, TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Right,
}, top)
local function topBtn(txt, xOff)
    local b = new("TextButton", {
        Size = UDim2.fromOffset(26, 26), Position = UDim2.new(1, xOff, 0, 10), BackgroundColor3 = C.card,
        Text = txt, TextColor3 = C.mut, Font = Enum.Font.GothamBold, TextSize = 14, AutoButtonColor = false,
    }, top)
    round(b, 8)
    return b
end
local btnClose = topBtn("x", -38)
local btnMin = topBtn("-", -70)
btnClose.MouseButton1Click:Connect(destroyAll)
new("Frame", {
    Size = UDim2.new(1, -20, 0, 1), Position = UDim2.fromOffset(10, 46), BackgroundColor3 = C.line, BorderSizePixel = 0,
}, main)

local function toggleMain() main.Visible = not main.Visible end
btnMin.MouseButton1Click:Connect(toggleMain)
keep(UIS.InputBegan:Connect(function(i, gp)
    if not gp and i.KeyCode == Enum.KeyCode.RightShift then toggleMain() end
end))

-- arrastar janela
do
    local dragging, dStart, sPos = false, nil, nil
    top.InputBegan:Connect(function(i)
        if isPress(i) then dragging = true dStart = i.Position sPos = main.Position end
    end)
    keep(UIS.InputChanged:Connect(function(i)
        if dragging and isMove(i) then
            local d = i.Position - dStart
            main.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
        end
    end))
    keep(UIS.InputEnded:Connect(function(i)
        if isPress(i) then dragging = false end
    end))
end

-- botao flutuante
do
    local fb = new("TextButton", {
        Size = UDim2.fromOffset(44, 44), Position = UDim2.new(0, 16, 0.5, -22), BackgroundColor3 = C.bg,
        Text = "O", TextColor3 = C.acc, Font = Enum.Font.GothamBlack, TextSize = 20, AutoButtonColor = false,
        ZIndex = 50,
    }, gui)
    round(fb, 22)
    new("UIStroke", {Thickness = 2, Color = C.acc}, fb)
    local drag, moved, startP, startPos = false, false, nil, nil
    fb.InputBegan:Connect(function(i)
        if isPress(i) then drag = true moved = false startP = i.Position startPos = fb.Position end
    end)
    keep(UIS.InputChanged:Connect(function(i)
        if drag and isMove(i) then
            local d = i.Position - startP
            if d.Magnitude > 6 then moved = true end
            if moved then
                fb.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end
    end))
    keep(UIS.InputEnded:Connect(function(i)
        if drag and isPress(i) then
            drag = false
            if not moved then toggleMain() end
        end
    end))
end

--==================== UI: componentes ====================
local side = new("ScrollingFrame", {
    Size = UDim2.new(0, 124, 1, -66), Position = UDim2.fromOffset(10, 56), BackgroundTransparency = 1,
    BorderSizePixel = 0, ScrollBarThickness = 0, CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, main)
new("UIListLayout", {Padding = UDim.new(0, 3)}, side)
local content = new("Frame", {
    Size = UDim2.new(1, -152, 1, -66), Position = UDim2.fromOffset(142, 56), BackgroundTransparency = 1,
}, main)

local tabs = {}
local function selectTab(t)
    for _, o in ipairs(tabs) do
        local on = (o == t)
        o.page.Visible = on
        o.bar.Visible = on
        o.btn.BackgroundTransparency = on and 0 or 1
        o.btn.TextColor3 = on and C.txt or C.mut
    end
end

-- registro de funcoes: ligar uma desliga as outras (evita brigar pelo movimento)
local features = {}
local statusSetters = {}
local function setSt(key, text)
    local f = statusSetters[key]
    if f then f(text) end
end
local function stopOthers(group)
    for _, f in pairs(features) do
        if f.group and f.group ~= group and f.isOn() then f.set(false) end
    end
end
local function otherOn(group)
    for _, f in pairs(features) do
        if f.group and f.group ~= group and f.isOn() then return true end
    end
    return false
end
local function stopMovers() stopOthers("__none__") end

local function makeSwitch(parent, pos)
    local track = new("TextButton", {
        Size = UDim2.fromOffset(42, 22), Position = pos, BackgroundColor3 = C.off, Text = "", AutoButtonColor = false,
    }, parent)
    round(track, 11)
    local knob = new("Frame", {
        Size = UDim2.fromOffset(16, 16), Position = UDim2.fromOffset(3, 3), BackgroundColor3 = Color3.new(1, 1, 1),
        BorderSizePixel = 0,
    }, track)
    round(knob, 8)
    local sw = {btn = track}
    function sw.render(on)
        TS:Create(track, TweenInfo.new(0.15), {BackgroundColor3 = on and C.acc or C.off}):Play()
        TS:Create(knob, TweenInfo.new(0.15), {Position = on and UDim2.fromOffset(23, 3) or UDim2.fromOffset(3, 3)}):Play()
    end
    return sw
end

local function bind(sw, key, cb, group)
    local on = false
    local obj = {group = group}
    function obj.isOn() return on end
    local function apply(v)
        on = v and true or false
        Config[key] = on
        sw.render(on)
        saveCfg()
        pcall(cb, on)
    end
    function obj.set(v) if on ~= v then apply(v) end end
    sw.btn.MouseButton1Click:Connect(function()
        if not on and group then stopOthers(group) end
        apply(not on)
    end)
    features[key] = obj
    local want = Config[key] == true
    if want and group and otherOn(group) then
        want = false
        Config[key] = false
    end
    on = want
    sw.render(on)
    if on then pcall(cb, true) end
    return obj
end

local function newTab(name)
    local btn = new("TextButton", {
        Size = UDim2.new(1, 0, 0, 32), BackgroundColor3 = C.card, BackgroundTransparency = 1,
        Text = name, TextColor3 = C.mut, Font = Enum.Font.GothamMedium, TextSize = 13, AutoButtonColor = false,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, side)
    round(btn, 8)
    new("UIPadding", {PaddingLeft = UDim.new(0, 14)}, btn)
    local bar = new("Frame", {
        Size = UDim2.fromOffset(3, 14), Position = UDim2.new(0, -10, 0.5, -7),
        BackgroundColor3 = C.acc, BorderSizePixel = 0, Visible = false,
    }, btn)
    round(bar, 2)
    local page = new("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, BorderSizePixel = 0,
        ScrollBarThickness = 3, ScrollBarImageColor3 = C.line, CanvasSize = UDim2.new(),
        AutomaticCanvasSize = Enum.AutomaticSize.Y, Visible = false,
    }, content)
    new("UIListLayout", {Padding = UDim.new(0, 8)}, page)
    new("UIPadding", {
        PaddingTop = UDim.new(0, 2), PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 12),
    }, page)

    local t = {btn = btn, bar = bar, page = page}
    table.insert(tabs, t)
    btn.MouseButton1Click:Connect(function() selectTab(t) end)

    function t.Section(text)
        return new("TextLabel", {
            Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1, Text = string.upper(text),
            TextColor3 = C.mut, Font = Enum.Font.GothamBold, TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom,
        }, page)
    end

    function t.Note(text)
        return new("TextLabel", {
            Size = UDim2.new(1, 0, 0, 16), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
            Text = text, TextColor3 = C.mut, Font = Enum.Font.Gotham, TextSize = 12, TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
        }, page)
    end
    t.Label = t.Note

    function t.Button(text, cb, primary)
        local b = new("TextButton", {
            Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = primary and C.acc or C.card, Text = text,
            TextColor3 = C.txt, Font = Enum.Font.GothamMedium, TextSize = 13, AutoButtonColor = false,
        }, page)
        round(b, 10)
        b.MouseButton1Click:Connect(function() pcall(cb) end)
    end

    -- opcao simples (ligar/desligar)
    function t.Toggle(text, key, cb, group)
        local f = new("Frame", {Size = UDim2.new(1, 0, 0, 42), BackgroundColor3 = C.card}, page)
        round(f, 10)
        new("TextLabel", {
            Size = UDim2.new(1, -76, 1, 0), Position = UDim2.fromOffset(12, 0), BackgroundTransparency = 1,
            Text = text, TextColor3 = C.txt, Font = Enum.Font.GothamMedium, TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true,
        }, f)
        local sw = makeSwitch(f, UDim2.new(1, -54, 0.5, -11))
        return bind(sw, key, cb, group)
    end

    -- funcao automatica com status embaixo
    function t.Feature(title, key, cb, group)
        local card = new("Frame", {Size = UDim2.new(1, 0, 0, 62), BackgroundColor3 = C.card}, page)
        round(card, 10)
        new("TextLabel", {
            Size = UDim2.new(1, -76, 0, 18), Position = UDim2.fromOffset(12, 9), BackgroundTransparency = 1,
            Text = title, TextColor3 = C.txt, Font = Enum.Font.GothamMedium, TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        }, card)
        local st = new("TextLabel", {
            Size = UDim2.new(1, -76, 0, 28), Position = UDim2.fromOffset(12, 28), BackgroundTransparency = 1,
            Text = "Desligado", TextColor3 = C.mut, Font = Enum.Font.Gotham, TextSize = 12, TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
            TextTruncate = Enum.TextTruncate.AtEnd,
        }, card)
        statusSetters[key] = function(txt) st.Text = txt end
        local sw = makeSwitch(card, UDim2.new(1, -54, 0, 20))
        return bind(sw, key, cb, group)
    end

    function t.Slider(text, min, max, key)
        local def = Config[key]
        local f = new("Frame", {Size = UDim2.new(1, 0, 0, 50), BackgroundColor3 = C.card}, page)
        round(f, 10)
        new("TextLabel", {
            Size = UDim2.new(1, -90, 0, 20), Position = UDim2.fromOffset(12, 7), BackgroundTransparency = 1,
            Text = text, TextColor3 = C.txt, Font = Enum.Font.GothamMedium, TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        }, f)
        local val = new("TextLabel", {
            Size = UDim2.fromOffset(60, 20), Position = UDim2.new(1, -72, 0, 7), BackgroundTransparency = 1,
            Text = tostring(def), TextColor3 = C.mut, Font = Enum.Font.GothamBold, TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Right,
        }, f)
        local track = new("Frame", {
            Size = UDim2.new(1, -24, 0, 4), Position = UDim2.fromOffset(12, 36), BackgroundColor3 = C.off,
            BorderSizePixel = 0,
        }, f)
        round(track, 2)
        local a0 = math.clamp((def - min) / (max - min), 0, 1)
        local fill = new("Frame", {
            Size = UDim2.new(a0, 0, 1, 0), BackgroundColor3 = C.acc, BorderSizePixel = 0,
        }, track)
        round(fill, 2)
        local knob = new("Frame", {
            Size = UDim2.fromOffset(12, 12), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(a0, 0, 0.5, 0),
            BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, ZIndex = 2,
        }, track)
        round(knob, 6)
        local hit = new("TextButton", {
            Size = UDim2.new(1, -12, 0, 26), Position = UDim2.fromOffset(6, 24), BackgroundTransparency = 1, Text = "",
        }, f)
        local drag = false
        local function setX(x)
            local a = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            local v = math.floor(min + (max - min) * a + 0.5)
            fill.Size = UDim2.new(a, 0, 1, 0)
            knob.Position = UDim2.new(a, 0, 0.5, 0)
            val.Text = tostring(v)
            Config[key] = v
        end
        hit.InputBegan:Connect(function(i)
            if isPress(i) then drag = true setX(i.Position.X) end
        end)
        keep(UIS.InputChanged:Connect(function(i)
            if drag and isMove(i) then setX(i.Position.X) end
        end))
        keep(UIS.InputEnded:Connect(function(i)
            if drag and isPress(i) then drag = false saveCfg() end
        end))
    end

    function t.Choice(text, options, key)
        local f = new("Frame", {Size = UDim2.new(1, 0, 0, 62), BackgroundColor3 = C.card}, page)
        round(f, 10)
        new("TextLabel", {
            Size = UDim2.new(1, -24, 0, 20), Position = UDim2.fromOffset(12, 7), BackgroundTransparency = 1,
            Text = text, TextColor3 = C.txt, Font = Enum.Font.GothamMedium, TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, f)
        local row = new("Frame", {
            Size = UDim2.new(1, -24, 0, 26), Position = UDim2.fromOffset(12, 30), BackgroundTransparency = 1,
        }, f)
        local n = #options
        local buttons = {}
        local function mark()
            for i, b in ipairs(buttons) do
                b.BackgroundColor3 = (options[i] == Config[key]) and C.acc or C.off
            end
        end
        for i, name in ipairs(options) do
            local b = new("TextButton", {
                Size = UDim2.new(1 / n, -6, 1, 0), Position = UDim2.new((i - 1) / n, 3, 0, 0),
                BackgroundColor3 = C.off, Text = name, TextColor3 = C.txt,
                Font = Enum.Font.GothamMedium, TextSize = 12, AutoButtonColor = false,
            }, row)
            round(b, 6)
            buttons[i] = b
            b.MouseButton1Click:Connect(function()
                Config[key] = name
                saveCfg()
                mark()
            end)
        end
        mark()
    end

    return t
end

local tInfo = newTab("Principal")
local tFarm = newTab("Farm")
local tStack = newTab("Stack Farming")
local tFruit = newTab("Fruit + Hop")
local tTp = newTab("Teleport")
local tESP = newTab("ESP")
local tPlayer = newTab("Jogador")
local tCfg = newTab("Configuracoes")

--==================== BASE ====================
local function hum()
    local c = lp.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end
local function root()
    local c = lp.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end
local function getRem()
    local remotes = RepS:FindFirstChild("Remotes")
    return remotes and remotes:FindFirstChild("CommF_")
end
local function getLevel()
    local ok, v = pcall(function() return lp.Data.Level.Value end)
    return ok and tonumber(v) or 1
end
local function norm(s) return string.lower((string.gsub(tostring(s), "[^%a]", ""))) end

local SEA = ({[2753915549] = 1, [4442272183] = 2, [7449423635] = 3})[game.PlaceId] or 0
local function detectSea()
    if SEA > 0 then return end
    pcall(function()
        for _, d in ipairs(lp.PlayerGui:GetDescendants()) do
            if d:IsA("TextLabel") then
                local m = string.match(d.Text, "%-Sea(%d)")
                if m then
                    SEA = tonumber(m) or 0
                    return
                end
            end
        end
    end)
end

-- TweenModel: tween do usuario (Heartbeat + Lerp). Adaptado para esperar terminar,
-- poder ser cancelado por alive() e NAO girar o personagem (nao trava a camera).
local function TweenModel(targetCFrame, speed, alive)
    local hrp = root()
    if not hrp then return false end
    local startCFrame = hrp.CFrame
    local goal = CFrame.new(targetCFrame.Position) * (startCFrame - startCFrame.Position)

    -- distancia e tempo estimado pela velocidade
    local distance = (startCFrame.Position - goal.Position).Magnitude
    if distance < 1 then
        hrp.CFrame = goal
        return true
    end
    local duration = math.max(distance / math.max(speed, 10), 0.03)
    local startTime = os.clock()

    local done, cancelled = false, false
    local connection
    connection = RS.Heartbeat:Connect(function()
        local cur = root()
        if not cur then
            cancelled = true
            done = true
            connection:Disconnect()
            return
        end
        if alive and not alive() then
            cancelled = true
            done = true
            connection:Disconnect()
            return
        end
        local alpha = math.min((os.clock() - startTime) / duration, 1)
        -- movimento linear direto no CFrame
        cur.CFrame = startCFrame:Lerp(goal, alpha)
        if alpha >= 1 then
            done = true
            connection:Disconnect()
        end
    end)
    while not done and os.clock() - startTime < duration + 3 do
        task.wait()
    end
    if not done then
        pcall(function() connection:Disconnect() end)
    end
    return not cancelled
end
local function moveTo(cf, speed, alive)
    return TweenModel(cf, speed, alive)
end

-- posiciona o personagem. Por padrao NAO gira o personagem (nao trava a camera)
local function placeAt(pos, look)
    local r = root()
    if not r then return false end
    if Config.faceMob and look then
        r.CFrame = CFrame.lookAt(pos, Vector3.new(look.X, pos.Y, look.Z))
    else
        r.CFrame = CFrame.new(pos) * (r.CFrame - r.CFrame.Position)
    end
    return true
end

local function anyActive()
    for _, v in pairs(active) do
        if v then return true end
    end
    return false
end

-- noclip + sem queda durante as funcoes automaticas
keep(RS.Stepped:Connect(function()
    if not Config.noclip then return end
    if not anyActive() then return end
    local c = lp.Character
    if not c then return end
    for _, p in ipairs(c:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end
    local r = c:FindFirstChild("HumanoidRootPart")
    if r then r.AssemblyLinearVelocity = Vector3.new(0, 0, 0) end
end))

-- anti AFK
keep(lp.Idled:Connect(function()
    pcall(function()
        VU:CaptureController()
        VU:ClickButton2(Vector2.new())
    end)
end))

local lastHaki = 0
local function ensureHaki()
    if not Config.haki then return end
    if os.clock() - lastHaki < 5 then return end
    lastHaki = os.clock()
    local c = lp.Character
    if c and not c:FindFirstChild("HasBuso") then
        local rem = getRem()
        if rem then pcall(function() rem:InvokeServer("Buso") end) end
    end
end

local function equipWeapon()
    ensureHaki()
    local c = lp.Character
    local h = hum()
    if not c or not h then return end
    local cur = c:FindFirstChildOfClass("Tool")
    if cur and cur.ToolTip == Config.weapon then return end
    for _, t in ipairs(lp.Backpack:GetChildren()) do
        if t:IsA("Tool") and t.ToolTip == Config.weapon then
            h:EquipTool(t)
            return
        end
    end
end

-- Fast Attack: base do usuario (CombatFramework). O controller ativo muda ao trocar de arma,
-- entao ele e lido de novo a cada ataque.
local CombatFramework = nil
task.spawn(function()
    pcall(function()
        local ps = lp:WaitForChild("PlayerScripts", 10)
        local mod = ps and ps:WaitForChild("CombatFramework", 10)
        if mod then CombatFramework = require(mod) end
    end)
end)
local function fastAttackOnce()
    pcall(function()
        local ctrl = typeof(CombatFramework) == "table" and CombatFramework.activeController
        if ctrl and ctrl.active then
            ctrl.timeToNextAttack = 0
            ctrl.hitboxTried = 0
            ctrl:attack()
        end
    end)
end

local function doAttack()
    if Config.fast then fastAttackOnce() end
    pcall(function()
        local c = lp.Character
        local tool = c and c:FindFirstChildOfClass("Tool")
        if tool then tool:Activate() end
    end)
    pcall(function()
        VU:CaptureController()
        VU:ClickButton1(Vector2.new(900, 500))
    end)
end

-- mira com o mouse (sem travar a camera, a menos que a opcao esteja ligada)
local function aimAt(pos)
    local cam = workspace.CurrentCamera
    if not cam then return end
    if Config.aimCam then cam.CFrame = CFrame.lookAt(cam.CFrame.Position, pos) end
    if not VIM then return end
    local v, on = cam:WorldToViewportPoint(pos)
    if on then
        local inset = GuiService:GetGuiInset()
        pcall(function() VIM:SendMouseMoveEvent(v.X, v.Y + inset.Y, game) end)
    end
end
local function useSkills(pos)
    if not VIM then return end
    if pos then aimAt(pos) end
    for _, k in ipairs({Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}) do
        pcall(function()
            VIM:SendKeyEvent(true, k, false, game)
            task.wait(0.05)
            VIM:SendKeyEvent(false, k, false, game)
        end)
    end
end

local function locationsFolder()
    local wo = workspace:FindFirstChild("_WorldOrigin")
    return wo and wo:FindFirstChild("Locations")
end
local function locationPos(sub)
    local loc = locationsFolder()
    if not loc then return nil end
    for _, p in ipairs(loc:GetChildren()) do
        if string.find(norm(p.Name), sub, 1, true) then
            local ok, pos = pcall(function() return p:GetPivot().Position end)
            if ok then return pos end
        end
    end
    return nil
end

local function httpGet(url)
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if ok and res and res ~= "" then return res end
    local req = (syn and syn.request) or request or http_request
    if req then
        local ok2, r = pcall(function() return req({Url = url, Method = "GET"}) end)
        if ok2 and r and r.Body then return r.Body end
    end
    return nil
end

local hopping = false
local function serverHop(setS)
    if hopping then return end
    hopping = true
    task.delay(20, function() hopping = false end)
    local ok, err = pcall(function()
        setS("procurando outro servidor...")
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local body = httpGet(url)
        if not body then setS("nao consegui listar servidores (sem HTTP no executor?)") return end
        local data = HttpService:JSONDecode(body)
        local pool = {}
        for _, s in ipairs(data.data or {}) do
            if s.id ~= game.JobId and s.playing and s.maxPlayers and s.playing < s.maxPlayers - 1 then
                table.insert(pool, s.id)
            end
        end
        if #pool == 0 then setS("nenhum servidor livre agora, tentando de novo") return end
        pcall(function()
            if queue_on_teleport and isfile and isfile("OrionHub.lua") then
                queue_on_teleport('loadstring(readfile("OrionHub.lua"))()')
            end
        end)
        setS("indo para outro servidor...")
        TeleportService:TeleportToPlaceInstance(game.PlaceId, pool[math.random(1, #pool)], lp)
    end)
    if not ok then setS("erro no hop: " .. tostring(err)) end
end
keep(TeleportService.TeleportInitFailed:Connect(function() hopping = false end))

--==================== ALVOS (bosses / eventos) ====================
local function partOfModel(m)
    if m:IsA("BasePart") then return m end
    if m:IsA("Model") then
        return m:FindFirstChild("HumanoidRootPart") or m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart", true)
    end
    return nil
end

local function targetsByNames(names, folders)
    local out = {}
    for _, fname in ipairs(folders or {"Enemies", "SeaBeasts"}) do
        local f = workspace:FindFirstChild(fname)
        if f then
            for _, m in ipairs(f:GetChildren()) do
                local n = norm(m.Name)
                for _, pat in ipairs(names) do
                    if string.find(n, pat, 1, true) then
                        local h = m:FindFirstChildOfClass("Humanoid")
                        local okh = true
                        if h then okh = h.Health > 0 end
                        local part = partOfModel(m)
                        if part and okh then table.insert(out, {mdl = m, part = part, hum = h}) end
                        break
                    end
                end
            end
        end
    end
    return out
end

local function nearestOf(list)
    local r = root()
    local best, bd
    for _, t in ipairs(list) do
        local d = r and (t.part.Position - r.Position).Magnitude or 0
        if not bd or d < bd then best, bd = t, d end
    end
    return best, bd
end

-- Leviathan: segmentos primeiro; o corpo principal so leva dano depois
local function leviathanTargets()
    local all = targetsByNames({"leviathan"}, {"SeaBeasts"})
    local segs = {}
    for _, t in ipairs(all) do
        if string.find(norm(t.mdl.Name), "segment", 1, true) then table.insert(segs, t) end
    end
    if #segs == 0 then
        local f = workspace:FindFirstChild("SeaBeasts")
        if f then
            for _, m in ipairs(f:GetChildren()) do
                if string.find(norm(m.Name), "leviathan", 1, true) then
                    for _, d in ipairs(m:GetDescendants()) do
                        if (d:IsA("Model") or d:IsA("BasePart")) and string.find(norm(d.Name), "segment", 1, true) then
                            local part = partOfModel(d)
                            local h = d:FindFirstChildOfClass("Humanoid")
                            if part and (not h or h.Health > 0) then
                                table.insert(segs, {mdl = d, part = part, hum = h})
                            end
                        end
                    end
                end
            end
        end
    end
    if #segs > 0 then return segs end
    return all
end

-- ataca um alvo de cima, sem girar o personagem
local function engage(tg, alive, hover, skills, speed, timeout)
    local r = root()
    if not r or not tg.part.Parent then return end
    local function goal() return tg.part.Position + Vector3.new(0, hover, 0) end
    if (r.Position - goal()).Magnitude > 60 then
        if not moveTo(CFrame.new(goal()), speed, alive) then return end
    end
    equipWeapon()
    local t0 = os.clock()
    local lastSkill = 0
    while alive() and tg.mdl.Parent and tg.part.Parent and os.clock() - t0 < (timeout or 30) do
        if tg.hum and tg.hum.Health <= 0 then break end
        if not placeAt(goal(), tg.part.Position) then break end
        doAttack()
        if skills and os.clock() - lastSkill > 1.5 then
            lastSkill = os.clock()
            useSkills(tg.part.Position)
        end
        task.wait(0.1)
    end
end

-- loop generico: procura um boss/evento pelo nome e mata
local function huntLoop(key, myGen, names, label, opts)
    opts = opts or {}
    local function alive() return active[key] and gens[key] == myGen end
    local function setS(t) setSt(key, t) end
    while alive() do
        pcall(function()
            local list = targetsByNames(names, opts.folders)
            if #list == 0 then
                if opts.idle then
                    opts.idle(alive, setS)
                else
                    setS("aguardando " .. label .. " aparecer...")
                    task.wait(1.5)
                end
                return
            end
            local best, bd = nearestOf(list)
            setS(label .. " encontrado (" .. math.floor(bd or 0) .. "m)")
            engage(best, alive, Config.bossHeight, Config.bossSkills, Config.tweenSpeed, 40)
        end)
        task.wait(0.2)
    end
    if gens[key] == myGen then setS("desligado") end
end

local function moverCb(key, runner, quiet)
    return function(v)
        active[key] = v and true or false
        gens[key] = (gens[key] or 0) + 1
        if v then
            task.spawn(runner, gens[key])
        elseif not quiet then
            setSt(key, "desligado")
        end
    end
end

--==================== QUESTS (level / bones / katakuri) ====================
local QuestsMod
local function loadQuests()
    if QuestsMod then return QuestsMod end
    local m = RepS:FindFirstChild("Quests")
    if m and m:IsA("ModuleScript") then
        local ok, r = pcall(require, m)
        if ok and type(r) == "table" then QuestsMod = r end
    end
    return QuestsMod
end

local function spawnsFor(mob)
    local out = {}
    local wo = workspace:FindFirstChild("_WorldOrigin")
    local es = wo and wo:FindFirstChild("EnemySpawns")
    if not es then return out end
    local function scan(k)
        local found = {}
        for _, p in ipairs(es:GetChildren()) do
            if p:IsA("BasePart") and string.find(string.lower(p.Name), k, 1, true) then
                table.insert(found, p)
            end
        end
        return found
    end
    local lm = string.lower(mob)
    out = scan(lm)
    if #out == 0 then
        local first = string.match(lm, "^(%S+)")
        if first and #first >= 3 then out = scan(first) end
    end
    if #out == 0 and #lm > 4 then out = scan(string.sub(lm, 1, #lm - 1)) end
    return out
end

local function chooseQuest(level, filter)
    local Q = loadQuests()
    if not Q then return nil, "modulo de quests nao carregou" end
    local cands = {}
    for qn, list in pairs(Q) do
        if type(list) == "table" then
            for idx, q in pairs(list) do
                if type(q) == "table" and type(q.LevelReq) == "number" and q.LevelReq <= level
                    and type(q.Task) == "table" then
                    local mob, cnt
                    for m, c in pairs(q.Task) do mob, cnt = m, c end
                    if mob and type(cnt) == "number" and cnt > 1 then
                        if not filter or filter(norm(mob)) then
                            table.insert(cands, {name = qn, idx = idx, req = q.LevelReq, mob = tostring(mob)})
                        end
                    end
                end
            end
        end
    end
    table.sort(cands, function(a, b) return a.req > b.req end)
    for _, c in ipairs(cands) do
        if #spawnsFor(c.mob) > 0 then return c end
    end
    return nil, "nenhuma quest disponivel (level baixo ou area de outro mar)"
end

local function npcPart(n)
    return n:FindFirstChild("HumanoidRootPart") or n.PrimaryPart or n:FindFirstChildWhichIsA("BasePart", true)
end

local function findQuestNPC(spawns)
    if #spawns == 0 then return nil, nil end
    local sum = Vector3.new(0, 0, 0)
    for _, p in ipairs(spawns) do sum = sum + p.Position end
    local center = sum / #spawns
    local en = workspace:FindFirstChild("Enemies")
    local best, bd
    local function consider(model)
        if not model:IsA("Model") then return end
        if en and model:IsDescendantOf(en) then return end
        if Players:GetPlayerFromCharacter(model) then return end
        local part = npcPart(model)
        if not part then return end
        local d = (part.Position - center).Magnitude
        if d > 700 then return end
        local score = d
        if model:FindFirstChild("QuestBBG", true) then score = score - 300 end
        if string.find(string.lower(model.Name), "quest", 1, true) then score = score - 200 end
        if not bd or score < bd then best, bd = part, score end
    end
    local npcs = workspace:FindFirstChild("NPCs")
    if npcs then
        for _, n in ipairs(npcs:GetChildren()) do consider(n) end
    end
    if not best then
        local ok, parts = pcall(function()
            return workspace:GetPartBoundsInRadius(center, 500, OverlapParams.new())
        end)
        if ok and parts then
            local seen = {}
            for _, p in ipairs(parts) do
                local mdl = p:FindFirstAncestorOfClass("Model")
                if mdl and not seen[mdl] and mdl:FindFirstChildOfClass("Humanoid") then
                    seen[mdl] = true
                    consider(mdl)
                end
            end
        end
    end
    return best, center
end

-- a quest aparece no HUD: procura o texto em TODA a PlayerGui
local function mainGui()
    local pg = lp:FindFirstChild("PlayerGui")
    return pg and pg:FindFirstChild("Main")
end
local function chainVisible(o, stop)
    local cur = o
    while cur and cur ~= stop do
        if cur:IsA("GuiObject") and not cur.Visible then return false end
        cur = cur.Parent
    end
    return true
end
local function questFrameVisible()
    local m = mainGui()
    local qf = m and m:FindFirstChild("Quest")
    return qf ~= nil and qf:IsA("GuiObject") and qf.Visible
end
local function questShows(mob)
    local pg = lp:FindFirstChild("PlayerGui")
    if not pg then return false end
    local lm = string.lower(mob)
    local part = string.sub(lm, 1, math.max(#lm - 2, 3))
    for _, d in ipairs(pg:GetDescendants()) do
        if d:IsA("TextLabel") and d.Text ~= "" and not d:IsDescendantOf(gui) and chainVisible(d, pg) then
            if string.find(string.lower(d.Text), part, 1, true) then return true end
        end
    end
    return false
end
local function questActive(mob)
    return questFrameVisible() or questShows(mob)
end

local function mobsOf(name)
    local out = {}
    local en = workspace:FindFirstChild("Enemies")
    if not en then return out end
    local ln = string.lower(name)
    for _, e in ipairs(en:GetChildren()) do
        if string.find(string.lower(e.Name), ln, 1, true) then
            local h = e:FindFirstChildOfClass("Humanoid")
            local p = e:FindFirstChild("HumanoidRootPart")
            if h and p and h.Health > 0 then
                table.insert(out, {m = e, h = h, p = p})
            end
        end
    end
    return out
end

local function goToQuestNPC(q, spawns, alive, setS)
    local _, center = findQuestNPC(spawns)
    if not center then return false end
    for step = 1, 60 do
        if not alive() then return false end
        local r = root()
        if not r then return false end
        local npc = (findQuestNPC(spawns))
        if npc then
            setS("indo ao NPC da quest (" .. q.name .. ")")
            moveTo(CFrame.new(npc.Position + Vector3.new(0, 3, 4)), Config.tweenSpeed, alive)
            r = root()
            if r and (r.Position - npc.Position).Magnitude < 25 then return true end
        else
            local d = (r.Position - center).Magnitude
            setS("indo para a area do NPC (faltam " .. math.floor(d) .. " studs)")
            if d < 60 then
                task.wait(1.5)
                if step > 8 then return false end
            else
                local dir = center - r.Position
                local stepLen = math.min(dir.Magnitude, 700)
                local target = r.Position + dir.Unit * stepLen
                moveTo(CFrame.new(target.X, center.Y + 60, target.Z), Config.tweenSpeed, alive)
            end
        end
    end
    return false
end

-- sai do NPC, vai ao spawn, junta os mobs num ponto e mata rapido (sem girar o personagem)
local function killQuestMobs(q, spawns, lvl, alive, setS)
    local r = root()
    if not r then return end
    local list = mobsOf(q.mob)
    local fresh = spawnsFor(q.mob)
    if #fresh > 0 then spawns = fresh end

    if #list == 0 then
        if #spawns == 0 then
            setS("nenhum spawn de " .. q.mob .. " encontrado neste mar")
            task.wait(2)
            return
        end
        local sp, sd
        for _, p in ipairs(spawns) do
            local d = (p.Position - r.Position).Magnitude
            if not sd or d < sd then sp, sd = p, d end
        end
        setS("indo ao spawn de " .. q.mob .. " (" .. math.floor(sd) .. " studs)")
        moveTo(CFrame.new(sp.Position + Vector3.new(0, Config.height + 10, 0)), Config.tweenSpeed, alive)
        task.wait(1)
        return
    end

    local near, nd
    for _, e in ipairs(list) do
        local d = (e.p.Position - r.Position).Magnitude
        if not nd or d < nd then near, nd = e, d end
    end
    local anchor = near.p.Position
    if nd > 40 then
        setS("indo ate " .. q.mob)
        moveTo(CFrame.new(anchor + Vector3.new(0, Config.height, 0)), Config.tweenSpeed, alive)
    end

    equipWeapon()
    pcall(function() sethiddenproperty(lp, "SimulationRadius", math.huge) end)
    local t0 = os.clock()
    while alive() and os.clock() - t0 < 25 do
        local cur = mobsOf(q.mob)
        if #cur == 0 then break end
        local n = 0
        for _, e in ipairs(cur) do
            if (e.p.Position - anchor).Magnitude < 300 then
                n = n + 1
                if Config.bring then
                    pcall(function()
                        e.h.WalkSpeed = 0
                        e.p.CanCollide = false
                        e.p.CFrame = CFrame.new(anchor)
                    end)
                end
            end
        end
        setS("Lv " .. lvl .. " | matando " .. n .. "x " .. q.mob)
        if not placeAt(anchor + Vector3.new(0, Config.height, 0), anchor) then break end
        doAttack()
        task.wait()
    end
end

-- farm por quest (usado por Level, Bones e Katakuri)
local function questFarm(key, myGen, spec)
    local function alive() return active[key] and gens[key] == myGen end
    local function setS(t) setSt(key, t) end
    local lastLevel, q, spawns, abandoned, assumeUntil = -1, nil, {}, false, 0
    while alive() do
        local ok, err = pcall(function()
            if spec.pre and spec.pre(alive, setS) then return end
            local lvl = getLevel()
            if lvl ~= lastLevel or not q then
                lastLevel = lvl
                local reason
                q, reason = chooseQuest(lvl, spec.filter)
                abandoned = false
                spawns = q and spawnsFor(q.mob) or {}
                if not q then
                    setS("sem quest: " .. tostring(reason))
                    task.wait(3)
                    return
                end
            end

            if spec.useQuest then
                if questFrameVisible() and not abandoned and not questShows(q.mob) then
                    abandoned = true
                    setS("abandonando quest diferente")
                    local rem = getRem()
                    if rem then pcall(function() rem:InvokeServer("AbandonQuest") end) end
                    task.wait(0.8)
                end

                if not (questActive(q.mob) or os.clock() < assumeUntil) then
                    local arrived = goToQuestNPC(q, spawns, alive, setS)
                    if not alive() then return end
                    if not arrived then
                        setS("nao consegui chegar no NPC da quest, tentando de novo")
                        task.wait(1.5)
                        return
                    end
                    task.wait(0.5)
                    local rem = getRem()
                    if rem then pcall(function() rem:InvokeServer("StartQuest", q.name, q.idx) end) end
                    for _ = 1, 6 do
                        task.wait(0.5)
                        if questActive(q.mob) then break end
                    end
                    if not questActive(q.mob) then
                        setS("quest enviada, mas nao detectei na tela; seguindo por 60s")
                        assumeUntil = os.clock() + 60
                    end
                end
            end
            if not alive() then return end

            killQuestMobs(q, spawns, lvl, alive, setS)
        end)
        if not ok then
            setS("erro: " .. tostring(err))
            task.wait(2)
        end
        task.wait(0.2)
    end
    if gens[key] == myGen then setS("desligado") end
end

local BONES_MOBS = {rebornskeleton = true, livingzombie = true, demonicsoul = true,
    posessedmummy = true, possessedmummy = true}
local CAKE_MOBS = {cookiecrafter = true, cakeguard = true, bakingstaff = true, headbaker = true}

local lastSpawnTry = 0
local function cakeBossStep(alive, setS)
    if Config.ignoreKat then return false end
    local list = targetsByNames({"cakeprince"}, {"Enemies"})
    if #list > 0 then
        local best = nearestOf(list)
        setS("Cake Prince (Katakuri) apareceu! atacando...")
        engage(best, alive, Config.bossHeight, Config.bossSkills, Config.tweenSpeed, 40)
        return true
    end
    if os.clock() - lastSpawnTry > 25 then
        lastSpawnTry = os.clock()
        local rem = getRem()
        if rem then
            pcall(function() rem:InvokeServer("CakePrinceSpawner") end)
            pcall(function() rem:InvokeServer("CakePrinceSpawner", true) end)
        end
    end
    return false
end

local function farmLevelLoop(g) questFarm("farm", g, {useQuest = true}) end
local function bonesLoop(g)
    questFarm("bones", g, {useQuest = true, filter = function(n) return BONES_MOBS[n] == true end})
end
local function cakeLoop(g)
    questFarm("cake", g, {
        useQuest = false, filter = function(n) return CAKE_MOBS[n] == true end, pre = cakeBossStep,
    })
end
local function cakeQuestLoop(g)
    questFarm("cakeQuest", g, {useQuest = true, filter = function(n) return CAKE_MOBS[n] == true end})
end

--==================== CHEST ====================
local function partOf(v)
    if v:IsA("BasePart") then return v end
    if v:IsA("Model") then return v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart", true) end
    return nil
end
local chestNames = {Chest1 = "Bau", Chest2 = "Bau de Prata", Chest3 = "Bau de Ouro"}
local deepT, deepCache = 0, {}

local function chestList()
    local out, seen = {}, {}
    local function add(v)
        if seen[v] or not v.Parent then return end
        local part = partOf(v)
        if not part then return end
        seen[v] = true
        table.insert(out, {obj = v, part = part, name = chestNames[v.Name] or "Bau"})
    end
    pcall(function()
        for _, v in ipairs(CS:GetTagged("_ChestTagged")) do add(v) end
    end)
    for _, v in ipairs(workspace:GetChildren()) do
        if (v:IsA("Model") or v:IsA("BasePart")) and string.find(v.Name, "Chest") then add(v) end
    end
    local cm = workspace:FindFirstChild("ChestModels")
    if cm then
        for _, v in ipairs(cm:GetChildren()) do add(v) end
    end
    if #out == 0 and os.clock() - deepT > 6 then
        deepT = os.clock()
        deepCache = {}
        for _, v in ipairs(workspace:GetDescendants()) do
            if (v:IsA("Model") or v:IsA("BasePart")) and string.match(v.Name, "^Chest%d*$") then
                table.insert(deepCache, v)
            end
        end
    end
    if #out == 0 then
        for _, v in ipairs(deepCache) do add(v) end
    end
    return out
end

local function touchChest(obj, part)
    local r = root()
    if not (r and firetouchinterest) then return end
    local parts = {part}
    if obj:IsA("Model") then
        for _, d in ipairs(obj:GetDescendants()) do
            if d:IsA("BasePart") and d ~= part then
                table.insert(parts, d)
                if #parts >= 6 then break end
            end
        end
    end
    for _, p in ipairs(parts) do
        pcall(function()
            firetouchinterest(r, p, 0)
            task.wait(0.03)
            firetouchinterest(r, p, 1)
        end)
    end
end

local function chestLoop(myGen)
    local function alive() return active.chest and gens.chest == myGen end
    local function setS(t) setSt("chest", t) end
    local skipped = {}
    while alive() do
        pcall(function()
            local r = root()
            if not r then setS("aguardando personagem") return end
            local best, bd, total = nil, nil, 0
            for _, c in ipairs(chestList()) do
                total = total + 1
                local u = skipped[c.obj]
                if not (u and u > os.clock()) then
                    local d = (c.part.Position - r.Position).Magnitude
                    if not bd or d < bd then best, bd = c, d end
                end
            end
            if not best then
                setS(total == 0 and "nenhum bau carregado por perto, procurando..."
                    or "baus encontrados, mas todos ignorados por enquanto")
                task.wait(2)
                return
            end
            setS("indo ate " .. best.name .. " (" .. math.floor(bd) .. "m)")
            if moveTo(CFrame.new(best.part.Position + Vector3.new(0, 2, 0)), Config.chestSpeed, alive) then
                setS("pegando " .. best.name)
                local t0 = os.clock()
                while alive() and best.obj.Parent and os.clock() - t0 < 2.5 do
                    local rr = root()
                    if rr and best.part.Parent then
                        rr.CFrame = best.part.CFrame
                        touchChest(best.obj, best.part)
                    end
                    task.wait(0.25)
                end
                task.wait(0.6)
            end
            if best.obj.Parent then skipped[best.obj] = os.clock() + 30 end
        end)
        task.wait(0.3)
    end
    if gens.chest == myGen then setS("desligado") end
end

--==================== STACK FARMING: acoes ====================
local function findTool(subs)
    for _, cont in ipairs({lp.Character, lp.Backpack}) do
        if cont then
            for _, t in ipairs(cont:GetChildren()) do
                if t:IsA("Tool") then
                    local n = norm(t.Name)
                    for _, s in ipairs(subs) do
                        if string.find(n, s, 1, true) then return t end
                    end
                end
            end
        end
    end
    return nil
end
local function equipTool(t)
    local h = hum()
    if h and t then pcall(function() h:EquipTool(t) end) end
end

-- aciona prompts / click detectors / pads (touch) perto de um ponto
local function interactNear(center, radius, patterns)
    local ok, parts = pcall(function()
        return workspace:GetPartBoundsInRadius(center, radius, OverlapParams.new())
    end)
    if not ok or not parts then return 0 end
    local count = 0
    local seen = {}
    local r = root()
    local function nameMatch(p)
        if not patterns then return true end
        local n = norm(p.Name)
        local par = p.Parent and norm(p.Parent.Name) or ""
        for _, pt in ipairs(patterns) do
            if string.find(n, pt, 1, true) or string.find(par, pt, 1, true) then return true end
        end
        return false
    end
    for _, p in ipairs(parts) do
        if not seen[p] and nameMatch(p) then
            seen[p] = true
            local acted = false
            for _, d in ipairs(p:GetChildren()) do
                if d:IsA("ProximityPrompt") and fireproximityprompt then
                    pcall(fireproximityprompt, d)
                    acted = true
                elseif d:IsA("ClickDetector") and fireclickdetector then
                    pcall(fireclickdetector, d)
                    acted = true
                elseif d:IsA("TouchTransmitter") and firetouchinterest and r then
                    pcall(function()
                        firetouchinterest(r, p, 0)
                        task.wait(0.05)
                        firetouchinterest(r, p, 1)
                    end)
                    acted = true
                end
            end
            if acted then count = count + 1 end
        end
    end
    return count
end

local function runOnce(key, fn)
    return function(myGen)
        local function alive() return active[key] and gens[key] == myGen end
        local function setS(t) setSt(key, t) end
        local ok, err = pcall(fn, alive, setS)
        if not ok then setS("erro: " .. tostring(err)) end
        task.defer(function()
            if gens[key] == myGen and features[key] then features[key].set(false) end
        end)
    end
end

local function summonGeneric(alive, setS, o)
    detectSea()
    if o.sea and SEA ~= o.sea then setS("so funciona no Sea " .. o.sea .. " (voce esta no Sea " .. tostring(SEA) .. ")") return end
    local item = findTool(o.item)
    if not item then setS("voce nao tem o item: " .. o.itemName) return end
    local pos = nil
    for _, sub in ipairs(o.loc) do
        pos = pos or locationPos(sub)
    end
    if not pos then setS("nao achei " .. o.place .. " na lista de ilhas deste mar") return end
    setS("indo para " .. o.place .. "...")
    if not moveTo(CFrame.new(pos + Vector3.new(0, 70, 0)), Config.tpSpeed, alive) then return end
    task.wait(1)
    equipTool(item)
    task.wait(0.5)
    local n = interactNear(pos, o.radius or 400, o.patterns)
    if n > 0 then
        setS("acionei " .. n .. " objeto(s). Se o boss nao apareceu, " .. o.hint)
    else
        setS("nao achei o local de invocar por perto. " .. o.hint)
    end
end

local function summonIndra(alive, setS)
    summonGeneric(alive, setS, {
        sea = 3, item = {"godschalice"}, itemName = "God's Chalice", loc = {"castleonthesea", "castle"},
        place = "o Castle on the Sea", patterns = {"pedestal", "chalice", "summon", "altar", "indra"},
        hint = "confira se os 3 botoes de Aura estao ativos.",
    })
end
local function summonReaper(alive, setS)
    summonGeneric(alive, setS, {
        sea = 3, item = {"hallowessence"}, itemName = "Hallow Essence", loc = {"hauntedcastle", "haunted"},
        place = "o Haunted Castle", patterns = {"altar", "summon", "hallow", "pedestal"},
        hint = "o altar fica perto do mausoleu, no cemiterio.",
    })
end
local function summonBeard(alive, setS)
    summonGeneric(alive, setS, {
        sea = 2, item = {"fistofdarkness"}, itemName = "Fist of Darkness", loc = {"darkarena", "dark"},
        place = "a Dark Arena", patterns = {"pedestal", "altar", "summon", "fist"},
        hint = "o pedestal fica no meio da arena.",
    })
end
local function touchPads(alive, setS)
    detectSea()
    if SEA ~= 3 then setS("so funciona no Sea 3") return end
    local pos = locationPos("castleonthesea") or locationPos("castle")
    if not pos then setS("nao achei o Castle on the Sea na lista de ilhas") return end
    setS("indo ao Castle on the Sea...")
    if not moveTo(CFrame.new(pos + Vector3.new(0, 70, 0)), Config.tpSpeed, alive) then return end
    task.wait(1)
    local n = interactNear(pos, 600, {"pad", "button", "haki", "aura", "plate"})
    setS("toquei em " .. n .. " pad(s). Cada pad precisa da cor de Aura correta equipada.")
end

local ELITE_NAMES = {"Diablo", "Urban", "Deandre"}
local function eliteIdle(alive, setS)
    -- o elite so entra no mapa quando voce chega perto: antes disso ele fica no ReplicatedStorage
    local rsElite
    for _, n in ipairs(ELITE_NAMES) do
        local m = RepS:FindFirstChild(n)
        if m then
            rsElite = m
            break
        end
    end
    if rsElite then
        local part = partOfModel(rsElite)
        if part then
            local pos = part.Position
            local r = root()
            local d = r and (r.Position - pos).Magnitude or 0
            if d > 150 then
                setS("indo ate " .. rsElite.Name .. " (" .. math.floor(d) .. " studs)")
                moveTo(CFrame.new(pos + Vector3.new(0, 60, 0)), Config.tweenSpeed, alive)
                return
            end
            setS("perto de " .. rsElite.Name .. ", aguardando ele aparecer...")
            task.wait(1.5)
            return
        end
    end
    -- nenhum elite ativo: pede a quest
    local rem = getRem()
    if rem then
        setS("pedindo a quest do Elite Hunter...")
        pcall(function() rem:InvokeServer("EliteHunter") end)
    end
    task.wait(4)
    if alive() then
        setS("aguardando o elite spawnar...")
        task.wait(2)
    end
end

local function hopBeardLoop(myGen)
    local function alive() return active.hopBeard and gens.hopBeard == myGen end
    local function setS(t) setSt("hopBeard", t) end
    while alive() do
        pcall(function()
            local list = targetsByNames({"darkbeard"}, {"Enemies"})
            if #list > 0 then
                local best = nearestOf(list)
                setS("Barba Negra encontrado! atacando...")
                engage(best, alive, Config.bossHeight, Config.bossSkills, Config.tweenSpeed, 40)
                return
            end
            for i = Config.hopDelay, 1, -1 do
                if not alive() then return end
                if #targetsByNames({"darkbeard"}, {"Enemies"}) > 0 then return end
                setS("Barba Negra nao esta aqui, trocando de servidor em " .. i .. "s")
                task.wait(1)
            end
            if alive() then serverHop(setS) end
            task.wait(10)
        end)
        task.wait(0.3)
    end
    if gens.hopBeard == myGen then setS("desligado") end
end

--==================== SEA EVENTS ====================
local SEA_EVENTS = {
    {key = "sLev", label = "Kill Leviathan", names = {"leviathan"}},
    {key = "sLevSeg", label = "Kill Leviathan (multi segmentos)", names = {"leviathan"}, segments = true},
    {key = "sBeast", label = "Kill Sea Beast", names = {"seabeast"}},
    {key = "sShark", label = "Kill Terrorshark", names = {"terrorshark"}},
    {key = "sPiranha", label = "Kill Piranha", names = {"piranha"}},
    {key = "sFish", label = "Kill Fish Crew", names = {"fishcrew"}},
    {key = "sGhost", label = "Kill Haunted Shipwreck (Ghost Ship)",
        names = {"hauntedcrew", "ghostshark", "shipdeckhand", "shipengineer", "shipsteward", "shipofficer", "cursedcaptain"}},
}
local seaOn = {}
local function seaLoop(myGen)
    local function alive() return active.sea and gens.sea == myGen end
    local function setS(t) setSt("sea", t) end
    while alive() do
        pcall(function()
            local list = {}
            for _, ev in ipairs(SEA_EVENTS) do
                if seaOn[ev.key] then
                    local found
                    if ev.segments then found = leviathanTargets() else found = targetsByNames(ev.names) end
                    for _, t in ipairs(found) do
                        t.ev = ev.label
                        table.insert(list, t)
                    end
                end
            end
            if #list == 0 then
                setS("aguardando o evento aparecer...")
                task.wait(1.5)
                return
            end
            local best, bd = nearestOf(list)
            setS(best.ev .. " (" .. math.floor(bd or 0) .. "m)")
            engage(best, alive, Config.seaHeight, Config.seaSkills, Config.seaSpeed, 30)
        end)
        task.wait(0.2)
    end
    if gens.sea == myGen then setS("desligado") end
end
local function refreshSea()
    local any = false
    for _, v in pairs(seaOn) do
        if v then any = true end
    end
    active.sea = any
    gens.sea = (gens.sea or 0) + 1
    if any then task.spawn(seaLoop, gens.sea) else setSt("sea", "desligado") end
end

--==================== FRUIT ====================
local function key(s)
    s = tostring(s)
    local first = string.match(s, "^([^%-]+)%-") or s
    local r = string.lower(first)
    r = string.gsub(r, "%s*fruit%s*$", "")
    r = string.gsub(r, "[^a-z]", "")
    if #r < 2 then r = string.gsub(string.lower(s), "[^a-z]", "") end
    return r
end

local function fruitName(v)
    local n = v:GetAttribute("OriginalName") or v:GetAttribute("FruitName") or v.Name
    n = tostring(n)
    n = string.gsub(n, "^%s+", "")
    n = string.gsub(n, "%s+$", "")
    if string.lower(n) == "fruit" then
        for _, d in ipairs(v:GetDescendants()) do
            if d:IsA("Model") and d.Name ~= "Fruit" and d.Name ~= "Handle" then
                n = d.Name
                break
            end
        end
    end
    return n
end

local function fruitList()
    local out = {}
    for _, v in ipairs(workspace:GetChildren()) do
        if (v:IsA("Tool") or v:IsA("Model")) and string.find(v.Name, "Fruit") then
            local part = v:FindFirstChild("Handle") or v:FindFirstChildWhichIsA("BasePart", true)
            if part then table.insert(out, {obj = v, part = part, name = fruitName(v)}) end
        end
    end
    return out
end

local function touch(part)
    local r = root()
    if r and firetouchinterest then
        pcall(function()
            firetouchinterest(r, part, 0)
            task.wait(0.05)
            firetouchinterest(r, part, 1)
        end)
    end
end

local ownedInv, ownedBase, skippedF, storeTries = {}, {}, {}, {}
local ownedLabel = nil
local function isOwned(name)
    local k = key(name)
    return ownedInv[k] ~= nil or ownedBase[k] ~= nil
end
local function updateOwnedLabel()
    if not ownedLabel then return end
    local names = {}
    for _, n in pairs(ownedInv) do table.insert(names, n) end
    for k, n in pairs(ownedBase) do
        if not ownedInv[k] then table.insert(names, n) end
    end
    table.sort(names)
    ownedLabel.Text = #names == 0 and "Minhas frutas detectadas: nenhuma"
        or ("Minhas frutas detectadas (" .. #names .. "): " .. table.concat(names, ", "))
end
local function isFruitTool(t)
    if not t:IsA("Tool") then return false end
    if t:GetAttribute("OriginalName") ~= nil then return true end
    if t:FindFirstChild("Fruit") ~= nil then return true end
    if string.find(t.Name, "Fruit") ~= nil then return true end
    return string.find(t.Name, "^[%a ]+%-[%a ]+$") ~= nil
end
local function toolName(t) return t:GetAttribute("OriginalName") or t.Name end
local function countFruits()
    local n = 0
    for _, cont in ipairs({lp.Backpack, lp.Character}) do
        if cont then
            for _, tool in ipairs(cont:GetChildren()) do
                if isFruitTool(tool) then n = n + 1 end
            end
        end
    end
    return n
end
local function captureBase()
    ownedBase = {}
    for _, cont in ipairs({lp.Backpack, lp.Character}) do
        if cont then
            for _, tool in ipairs(cont:GetChildren()) do
                if isFruitTool(tool) then
                    local nm = toolName(tool)
                    ownedBase[key(nm)] = tostring(nm)
                end
            end
        end
    end
end
local function refreshOwned()
    local rem = getRem()
    if rem then
        local ok, inv = pcall(function() return rem:InvokeServer("getInventory") end)
        if ok and type(inv) == "table" then
            local newInv = {}
            for _, it in pairs(inv) do
                if type(it) == "table" and it.Name then
                    local nm = tostring(it.Name)
                    if it.Type == "Blox Fruit" or string.find(nm, "%-") then newInv[key(nm)] = nm end
                end
            end
            ownedInv = newInv
        end
    end
    updateOwnedLabel()
end
local function storeAll(setS)
    local rem = getRem()
    if not rem then setS("remote de armazenar nao encontrado") return false end
    local did = false
    for _, cont in ipairs({lp.Backpack, lp.Character}) do
        if cont then
            for _, tool in ipairs(cont:GetChildren()) do
                if isFruitTool(tool) then
                    local nm = toolName(tool)
                    if not isOwned(nm) and (storeTries[tool] or 0) < 3 then
                        storeTries[tool] = (storeTries[tool] or 0) + 1
                        setS("armazenando " .. tostring(nm))
                        pcall(function() return rem:InvokeServer("StoreFruit", nm, tool) end)
                        did = true
                        task.wait(0.6)
                    end
                end
            end
        end
    end
    if did then refreshOwned() end
    return did
end

local function fruitLoop(myGen)
    local function alive() return active.fruit and gens.fruit == myGen end
    local function setS(t) setSt("fruit", t) end
    local lastRefresh = os.clock()
    local noneSince = nil
    while alive() do
        pcall(function()
            if os.clock() - lastRefresh > 30 then refreshOwned() lastRefresh = os.clock() end
            local r = root()
            if not r then setS("aguardando personagem") return end

            local best, bd
            for _, f in ipairs(fruitList()) do
                local u = skippedF[f.obj]
                if not (u and u > os.clock()) and not isOwned(f.name) then
                    local d = (f.part.Position - r.Position).Magnitude
                    if not bd or d < bd then best, bd = f, d end
                end
            end

            if not best then
                if Config.store then storeAll(setS) end
                noneSince = noneSince or os.clock()
                local left = math.max(0, Config.hopDelay - (os.clock() - noneSince))
                if Config.hop then
                    setS("nenhuma fruta nova aqui, trocando de servidor em " .. math.ceil(left) .. "s")
                    if left <= 0 then
                        serverHop(setS)
                        noneSince = os.clock()
                    end
                else
                    setS("nenhuma fruta nova no mapa")
                end
                task.wait(1)
                return
            end

            noneSince = nil
            setS("indo ate " .. best.name .. " (" .. math.floor(bd) .. "m)")
            if moveTo(CFrame.new(best.part.Position + Vector3.new(0, 3, 0)), Config.fruitSpeed, alive) then
                setS("pegando " .. best.name)
                local before = countFruits()
                local t0 = os.clock()
                while alive() and best.obj.Parent and os.clock() - t0 < 5 do
                    local rr = root()
                    if rr and best.part.Parent then rr.CFrame = best.part.CFrame touch(best.part) end
                    if countFruits() > before then break end
                    task.wait(0.3)
                end
                task.wait(1)
            end
            if best.obj.Parent then skippedF[best.obj] = os.clock() + 60 end
            if Config.store then storeAll(setS) end
        end)
        task.wait(0.4)
    end
    if gens.fruit == myGen then setS("desligado") end
end

--==================== MONTAGEM DAS ABAS ====================
-- Principal
tInfo.Section("Conta")
local infoLbl = tInfo.Note("")
tInfo.Section("Dicas")
tInfo.Note("O botao redondo O abre e fecha o menu (arraste para mover). No PC, RightShift tambem funciona. Use uma funcao automatica por vez: ao ligar uma, as outras desligam sozinhas.")
tInfo.Section("Menu")
tInfo.Button("Esconder menu", toggleMain)
tInfo.Button("Reentrar no servidor", function()
    pcall(function() TeleportService:Teleport(game.PlaceId, lp) end)
end)
tInfo.Button("Fechar " .. NAME, destroyAll)
local exName = "desconhecido"
pcall(function() if identifyexecutor then exName = tostring(identifyexecutor()) end end)
task.spawn(function()
    while gui.Parent do
        detectSea()
        local seaTxt = SEA > 0 and ("Sea " .. SEA) or "Sea ?"
        infoLbl.Text = seaTxt .. "  |  Level " .. getLevel() .. "  |  Executor: " .. exName
        infoTop.Text = seaTxt .. "  |  Lv " .. getLevel()
        task.wait(2)
    end
end)

-- Farm
tFarm.Section("Level")
tFarm.Feature("Auto Farm Level", "farm", moverCb("farm", farmLevelLoop), "farm")
tFarm.Feature("Auto Chest", "chest", moverCb("chest", chestLoop), "chest")
tFarm.Section("Bones (Haunted Castle)")
tFarm.Feature("Farm Bones", "bones", moverCb("bones", bonesLoop), "bones")
tFarm.Section("Katakuri (Cake Land)")
tFarm.Feature("Auto Farm Katakuri", "cake", moverCb("cake", cakeLoop), "cake")
tFarm.Toggle("Ignorar Katakuri (so farmar os mobs)", "ignoreKat", function() end)
tFarm.Feature("Farm Katakuri Quest (pega missao do NPC)", "cakeQuest", moverCb("cakeQuest", cakeQuestLoop), "cakeQuest")
tFarm.Section("Opcoes do farm")
tFarm.Toggle("Puxar mobs (Bring Mobs)", "bring", function() end)
tFarm.Toggle("Fast Attack (CombatFramework)", "fast", function() end)
tFarm.Toggle("Auto Haki (Buso)", "haki", function() end)
tFarm.Toggle("Olhar para o mob (pode travar a camera)", "faceMob", function() end)
tFarm.Note("Por padrao o personagem NAO gira para o mob, entao a camera fica livre durante o farm. Ligue a ultima opcao so se os golpes estiverem errando.")

-- Stack Farming
tStack.Section("Boss Rip Indra")
tStack.Feature("Auto Elite Hunter", "elite", moverCb("elite", function(g)
    huntLoop("elite", g, {"diablo", "urban", "deandre"}, "Elite", {idle = eliteIdle, folders = {"Enemies"}})
end), "elite")
tStack.Feature("Kill Rip Indra", "killIndra", moverCb("killIndra", function(g)
    huntLoop("killIndra", g, {"ripindra"}, "Rip Indra", {folders = {"Enemies"}})
end), "killIndra")
tStack.Feature("Summon Rip Indra", "sumIndra", moverCb("sumIndra", function(g)
    runOnce("sumIndra", summonIndra)(g)
end, true), "sumIndra")
tStack.Feature("Auto Touch Pad Haki", "pads", moverCb("pads", function(g)
    runOnce("pads", touchPads)(g)
end, true), "pads")

tStack.Section("Boss Soul Reaper")
tStack.Feature("Kill Soul Reaper", "killReaper", moverCb("killReaper", function(g)
    huntLoop("killReaper", g, {"soulreaper"}, "Soul Reaper", {folders = {"Enemies"}})
end), "killReaper")
tStack.Feature("Summon Soul Reaper", "sumReaper", moverCb("sumReaper", function(g)
    runOnce("sumReaper", summonReaper)(g)
end, true), "sumReaper")

tStack.Section("Boss Dark Beard (Barba Negra)")
tStack.Feature("Kill Barba Negra", "killBeard", moverCb("killBeard", function(g)
    huntLoop("killBeard", g, {"darkbeard"}, "Barba Negra", {folders = {"Enemies"}})
end), "killBeard")
tStack.Feature("Summon Barba Negra", "sumBeard", moverCb("sumBeard", function(g)
    runOnce("sumBeard", summonBeard)(g)
end, true), "sumBeard")
tStack.Feature("Hop Server Barba Negra", "hopBeard", moverCb("hopBeard", hopBeardLoop), "hopBeard")

tStack.Section("Sea Events")
tStack.Note("Ligue um ou mais eventos e fique no mar. Ele espera o monstro aparecer, voa ate ele e ataca de cima, mirando com o mouse (sem travar a camera).")
local seaStatusLbl = tStack.Note("Status: desligado")
statusSetters.sea = function(t) seaStatusLbl.Text = "Status: " .. t end
for _, ev in ipairs(SEA_EVENTS) do
    seaOn[ev.key] = false
    tStack.Toggle(ev.label, ev.key, function(v)
        seaOn[ev.key] = v
        refreshSea()
    end, "sea")
end
tStack.Slider("Altura sobre o alvo (studs)", 10, 100, "seaHeight")
tStack.Slider("Velocidade ate o alvo (studs/s)", 20, 400, "seaSpeed")
tStack.Toggle("Usar skills Z X C V nos eventos", "seaSkills", function() end)
tStack.Slider("Altura nos bosses (studs)", 5, 40, "bossHeight")
tStack.Toggle("Usar skills nos bosses", "bossSkills", function() end)
tStack.Toggle("Travar a camera no alvo (eventos/bosses)", "aimCam", function() end)
tStack.Note("Dica: o Leviathan nao toma dano de M1 e o corpo so leva dano depois dos segmentos; por isso use as skills ligadas.")

-- Fruit + Hop
tFruit.Section("Auto Find Fruit")
tFruit.Feature("Auto Find Fruit", "fruit", function(v)
    active.fruit = v and true or false
    gens.fruit = (gens.fruit or 0) + 1
    local g = gens.fruit
    if v then
        skippedF, storeTries = {}, {}
        task.spawn(function()
            setSt("fruit", "detectando suas frutas...")
            captureBase()
            refreshOwned()
            fruitLoop(g)
        end)
    else
        setSt("fruit", "desligado")
    end
end, "fruit")
tFruit.Toggle("Server Hop (troca de servidor sem fruta)", "hop", function() end)
tFruit.Toggle("Armazenar fruta automaticamente", "store", function() end)
tFruit.Slider("Esperar antes de trocar de servidor (s)", 3, 30, "hopDelay")
tFruit.Slider("Velocidade ate a fruta (studs/s)", 20, 400, "fruitSpeed")
ownedLabel = tFruit.Note("Minhas frutas detectadas: (ainda nao detectado)")
tFruit.Button("Trocar de servidor agora", function()
    serverHop(function(t) setSt("fruit", t) end)
end)
tFruit.Button("Atualizar minhas frutas", function() captureBase() refreshOwned() end)
tFruit.Note("Dica: salve este script como OrionHub.lua na pasta workspace do executor. Assim ele roda sozinho em cada servidor novo e as funcoes ligadas continuam (as opcoes ficam salvas).")

-- Teleport
local tpStatus = tTp.Note("Escolha uma ilha na lista (ou busque pelo nome, ex: tiki) e toque em Teleportar.")
local selectedIsland, allIslands, islandBtns = nil, {}, {}

local searchBox = new("TextBox", {
    Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = C.card, Text = "", PlaceholderText = "Buscar ilha (ex: tiki)",
    TextColor3 = C.txt, PlaceholderColor3 = C.mut, Font = Enum.Font.Gotham, TextSize = 13, ClearTextOnFocus = false,
}, tTp.page)
round(searchBox, 10)
new("UIPadding", {PaddingLeft = UDim.new(0, 12)}, searchBox)

local listFrame = new("ScrollingFrame", {
    Size = UDim2.new(1, 0, 0, 170), BackgroundColor3 = C.card, BorderSizePixel = 0,
    ScrollBarThickness = 3, ScrollBarImageColor3 = C.line, CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, tTp.page)
round(listFrame, 10)
new("UIListLayout", {Padding = UDim.new(0, 4)}, listFrame)
new("UIPadding", {
    PaddingTop = UDim.new(0, 6), PaddingLeft = UDim.new(0, 6),
    PaddingRight = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6),
}, listFrame)

local function renderIslands()
    for _, b in ipairs(islandBtns) do b:Destroy() end
    islandBtns = {}
    local q = string.lower(searchBox.Text or "")
    for _, name in ipairs(allIslands) do
        if q == "" or string.find(string.lower(name), q, 1, true) then
            local b = new("TextButton", {
                Size = UDim2.new(1, -6, 0, 28),
                BackgroundColor3 = (name == selectedIsland) and C.acc or C.off,
                Text = name, TextColor3 = C.txt, Font = Enum.Font.Gotham, TextSize = 13, AutoButtonColor = false,
            }, listFrame)
            round(b, 6)
            b.MouseButton1Click:Connect(function()
                selectedIsland = name
                tpStatus.Text = "Selecionada: " .. name
                renderIslands()
            end)
            table.insert(islandBtns, b)
        end
    end
end

local function loadIslands()
    detectSea()
    allIslands = {}
    local seen = {}
    local loc = locationsFolder()
    if loc then
        for _, p in ipairs(loc:GetChildren()) do
            if not seen[p.Name] then
                seen[p.Name] = true
                table.insert(allIslands, p.Name)
            end
        end
    end
    table.sort(allIslands)
    renderIslands()
    if #allIslands == 0 then
        tpStatus.Text = "Nao encontrei a lista de ilhas deste mar."
    else
        tpStatus.Text = (SEA > 0 and ("Sea " .. SEA) or "Mar") .. ": " .. #allIslands .. " ilhas. Escolha uma."
    end
end
searchBox:GetPropertyChangedSignal("Text"):Connect(renderIslands)
loadIslands()

local function islandPos(name)
    local loc = locationsFolder()
    local obj = loc and loc:FindFirstChild(name)
    if not obj then return nil end
    local ok, pos = pcall(function() return obj:GetPivot().Position end)
    if ok then return pos end
    return nil
end

local function findIslandName(kw)
    for _, name in ipairs(allIslands) do
        if string.find(string.lower(name), kw, 1, true) then return name end
    end
    return nil
end

local function findSubmarineNPC()
    local function scan(folder)
        for _, n in ipairs(folder:GetChildren()) do
            if n:IsA("Model") and string.find(string.lower(n.Name), "submarine", 1, true) then
                local part = npcPart(n)
                if part then return part end
            end
        end
        return nil
    end
    local npcs = workspace:FindFirstChild("NPCs")
    local p = npcs and scan(npcs)
    if p then return p end
    return scan(workspace)
end

-- Submerged Island: rota Tiki Outpost -> Submarine Worker -> pedir a viagem
local function goSubmerged(g)
    local function alive() return gens.tp == g end
    local tiki = findIslandName("tiki")
    local tpos = tiki and islandPos(tiki)
    if not tpos then
        tpStatus.Text = "Nao achei o Tiki Outpost na lista. Va ate o Sea 3 e atualize a lista."
        return
    end
    tpStatus.Text = "Indo para o Tiki Outpost..."
    if not moveTo(CFrame.new(tpos + Vector3.new(0, 70, 0)), Config.tpSpeed, alive) then
        tpStatus.Text = "Teleporte cancelado"
        return
    end
    local npc
    for i = 1, 15 do
        if not alive() then return end
        npc = findSubmarineNPC()
        if npc then break end
        tpStatus.Text = "procurando o Submarine Worker no Tiki Outpost (" .. i .. "/15)..."
        task.wait(1)
    end
    if not npc then
        tpStatus.Text = "Nao achei o Submarine Worker. Chegue mais perto dele no Tiki e tente de novo."
        return
    end
    tpStatus.Text = "indo ate o Submarine Worker..."
    if not moveTo(CFrame.new(npc.Position + Vector3.new(0, 3, 4)), Config.tpSpeed, alive) then return end
    task.wait(0.8)
    tpStatus.Text = "falando com o Submarine Worker..."
    local used = false
    pcall(function()
        local m = RepS:FindFirstChild("Modules")
        local net = m and m:FindFirstChild("Net")
        local rf = net and net:FindFirstChild("RF/SubmarineWorkerSpeak")
        if rf then
            used = true
            rf:InvokeServer("TravelToSubmergedIsland")
        end
    end)
    if not used then
        local rem = getRem()
        if rem then
            used = true
            pcall(function() rem:InvokeServer("SubmarineWorkerSpeak", "TravelToSubmergedIsland") end)
        end
    end
    if used then
        tpStatus.Text = "Pedi a viagem para a Submerged Island. Se nao foi, fale com o NPC manualmente."
    else
        tpStatus.Text = "Remote do NPC nao encontrado. Fale com ele manualmente."
    end
end

tTp.Button("Teleportar para a ilha selecionada", function()
    if not selectedIsland then tpStatus.Text = "Escolha uma ilha primeiro." return end
    stopMovers()
    if string.find(string.lower(selectedIsland), "submerged", 1, true) then
        gens.tp = (gens.tp or 0) + 1
        local g = gens.tp
        active.tp = true
        task.spawn(function()
            local ok, err = pcall(goSubmerged, g)
            if gens.tp == g then active.tp = false end
            if not ok then tpStatus.Text = "erro: " .. tostring(err) end
        end)
        return
    end
    local pos = islandPos(selectedIsland)
    if not pos then tpStatus.Text = "Nao consegui ler a posicao dessa ilha." return end
    gens.tp = (gens.tp or 0) + 1
    local g = gens.tp
    active.tp = true
    local name = selectedIsland
    tpStatus.Text = "Indo para " .. name .. "..."
    task.spawn(function()
        local done = moveTo(CFrame.new(pos + Vector3.new(0, 70, 0)), Config.tpSpeed, function() return gens.tp == g end)
        if gens.tp == g then active.tp = false end
        tpStatus.Text = done and ("Chegou em " .. name) or "Teleporte cancelado"
    end)
end, true)
tTp.Button("Parar teleporte", function()
    gens.tp = (gens.tp or 0) + 1
    active.tp = false
    tpStatus.Text = "Teleporte parado."
end)
tTp.Button("Atualizar lista de ilhas", loadIslands)
tTp.Slider("Velocidade do teleporte (studs/s)", 50, 500, "tpSpeed")

local function travel(arg, label)
    local rem = getRem()
    if not rem then tpStatus.Text = "Remote de viagem nao encontrado." return end
    tpStatus.Text = "Viajando para " .. label .. "..."
    pcall(function() rem:InvokeServer(arg) end)
end
tTp.Section("Viajar entre mares")
tTp.Button("Viajar para o Sea 1", function() travel("TravelMain", "Sea 1") end)
tTp.Button("Viajar para o Sea 2", function() travel("TravelDressrosa", "Sea 2") end)
tTp.Button("Viajar para o Sea 3", function() travel("TravelZou", "Sea 3") end)
tTp.Note("Voce chega 70 studs acima da ilha e cai ate o chao. A lista mostra as ilhas do mar em que voce esta.")

-- ESP
local esp = {}
local tags = {}
local function removeTag(k)
    local t = tags[k]
    if t then
        pcall(function() t.bb:Destroy() end)
        if t.hl then pcall(function() t.hl:Destroy() end) end
        tags[k] = nil
    end
end
local function setTag(k, adornee, hlTarget, color, label)
    local t = tags[k]
    if not t or not t.bb.Parent then
        removeTag(k)
        local bb = new("BillboardGui", {
            Size = UDim2.fromOffset(170, 38), AlwaysOnTop = true,
            StudsOffset = Vector3.new(0, 3, 0), Adornee = adornee,
        }, gui)
        local lbl = new("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, TextColor3 = color,
            Font = Enum.Font.GothamBold, TextSize = 13, TextStrokeTransparency = 0.4,
        }, bb)
        local hl = nil
        if Config.espOutline and hlTarget then
            hl = new("Highlight", {
                Adornee = hlTarget, FillTransparency = 1, OutlineColor = color,
                DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
            }, gui)
        end
        t = {bb = bb, lbl = lbl, hl = hl}
        tags[k] = t
    end
    t.lbl.Text = label
    t.bb.Adornee = adornee
end
local function refreshESP()
    local seen = {}
    local r = root()
    local function dist(part)
        if Config.espDist and r then return "\n[" .. math.floor((part.Position - r.Position).Magnitude) .. "m]" end
        return ""
    end
    if Config.espPlayers then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= lp and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    seen[p] = true
                    setTag(p, hrp, p.Character, Color3.fromRGB(255, 80, 80), p.Name .. dist(hrp))
                end
            end
        end
    end
    if Config.espFruits then
        for _, f in ipairs(fruitList()) do
            seen[f.obj] = true
            setTag(f.obj, f.part, f.obj, Color3.fromRGB(255, 190, 60), f.name .. dist(f.part))
        end
    end
    if Config.espChests then
        for _, c in ipairs(chestList()) do
            seen[c.obj] = true
            setTag(c.obj, c.part, nil, Color3.fromRGB(80, 220, 255), c.name .. dist(c.part))
        end
    end
    for k in pairs(tags) do
        if not seen[k] then removeTag(k) end
    end
end
local function clearESP() for k in pairs(tags) do removeTag(k) end end

tESP.Note("Marca jogadores, frutas e baus soltos no mapa.")
tESP.Toggle("ESP Jogadores", "espPlayers", function() refreshESP() end)
tESP.Toggle("ESP Frutas", "espFruits", function() refreshESP() end)
tESP.Toggle("ESP Baus", "espChests", function() refreshESP() end)
tESP.Toggle("Mostrar distancia", "espDist", function() end)
tESP.Toggle("Contornos (jogadores e frutas)", "espOutline", function()
    clearESP()
    refreshESP()
end)
local accT = 0
keep(RS.Heartbeat:Connect(function(dt)
    accT = accT + dt
    if accT < 0.3 then return end
    accT = 0
    if Config.espPlayers or Config.espFruits or Config.espChests then pcall(refreshESP) end
end))

-- Jogador
tPlayer.Toggle("Velocidade ligada", "spdOn", function(v)
    if not v then
        local h = hum()
        if h then h.WalkSpeed = 16 end
    end
end)
tPlayer.Slider("Velocidade", 16, 200, "speedVal")
tPlayer.Toggle("Modo CFrame (se o jogo resetar)", "cfm", function() end)
keep(RS.Heartbeat:Connect(function(dt)
    if not Config.spdOn then return end
    local h = hum()
    if not h then return end
    if Config.cfm then
        local r = root()
        if r and h.MoveDirection.Magnitude > 0 then
            r.CFrame = r.CFrame + (h.MoveDirection * math.max(Config.speedVal - 16, 0) * dt)
        end
    else
        h.WalkSpeed = Config.speedVal
    end
end))
tPlayer.Toggle("Pulo infinito", "infj", function() end)
keep(UIS.JumpRequest:Connect(function()
    if Config.infj then
        local h = hum()
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end))

-- Configuracoes
tCfg.Section("Farm")
tCfg.Slider("Velocidade do tween (studs/s)", 20, 400, "tweenSpeed")
tCfg.Slider("Altura acima dos mobs (studs)", 3, 25, "height")
tCfg.Slider("Velocidade do Auto Chest (studs/s)", 20, 400, "chestSpeed")
tCfg.Choice("Arma do Auto Farm", {"Melee", "Sword", "Gun", "Blox Fruit"}, "weapon")
tCfg.Toggle("Noclip nas funcoes automaticas", "noclip", function() end)
tCfg.Note("Velocidade menor = mais seguro. Se o personagem for puxado de volta ou o jogo kickar, diminua as velocidades.")

selectTab(tabs[1])
print("[" .. NAME .. "] carregado")
pcall(function()
    StarterGui:SetCore("SendNotification", {Title = NAME, Text = "Carregado! Use o botao redondo para abrir/fechar.", Duration = 5})
end)
