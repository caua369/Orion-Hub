--// ORION HUB v5.0 - Blox Fruits
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
local Lighting = game:GetService("Lighting")
local lp = Players.LocalPlayer
local VIM = nil
pcall(function() VIM = game:GetService("VirtualInputManager") end)

local NAME = "Orion Hub"
local VERSION = "v5.0"
local BUTTON_IMAGE = "" -- opcional: "rbxassetid://ID" ou link direto (.png). Vazio = usa a imagem embutida no script
local CFG_FILE = "OrionHub_config.json"

-- imagem do botao redondo (PNG 112x112 em base64)
local BTN_B64 = {
    "iVBORw0KGgoAAAANSUhEUgAAAHAAAABwCAMAAADxPgR5AAABgFBMVEXb2uLMzNPEwMG3ub27rKavrK6kqa6goaa0k4SmkYicmJyaiIGOkpyAjq",
    "CKg4VxgpifdGiNdW2YYlGKX1R/dXZ+aGh+X11+Vk5wdIRec5FuZWtYZH1vXGBuVVZdWmxHWXiFTEB4TEdrTVVsSkV5QjlqQkB0NzBoNzNdTVdc",
    "Rk1bQExcPzxgNjRXNTteLixWLS1LSF5MPUs6Sm43Pl1LN0dLNTU/NkktNlNNLzpFLjxNLi1FLS09L0I+LS4zLj8nLkdYJyZMJilUIB5KHyJEJj",
    "BDJSREHiFDGR48JjI9JSQ8ISo8IR48HSU8HRs8GRs8FBozJjUzITA0JCQ0ICI1Hic1HRsvHSovHR00GSE1GRguGiQuGRk0FRotFRoxEhgwDhQp",
    "JDMgIzMkHCUpGSYpGRkgGSAoFiApFhYkFh4dFhwnEx8jEx8nExUjEhQfEh8gEhUaEhkkDxwmDxIgDxccDxwdDxEiDRUcDRUgCRIZDhoZDRAWDR",
    "QSDRQWCREWBw4OBgzJp2MwAAAh/UlEQVR42m2aB1siWxOtmWgcBRFwFFRAlBxGcAiCIkFAVHIURUKTk4hgwr9+VzWec757n7sF04z9dlWtCru7",
    "OaPZ6nRqlXy+lr/0+f3+83PPqefMc356RstD6+xMf3Cwpzg905+enWrlco1KZTbbjo+M20qTWm22Bby+y8urbPb24aHWfniYTOigjbe3t4+Pl9",
    "FHb/QyqnUASac5/wLbINbyyYuLCyA9Zziu/my2wD47PdXrD6RSLftVLpWr1WqrzXZsUm4r8a3JbLb6fADe3N62H/4FvjXePorOj1Hv5WP00qnU",
    "au1KhfPy8klst2tY2Wz2EjyySU/AU3Z9fj3QHhwQVySSyVRqm9dmBskWCNhsNqs3e3GZvbm5vSk8EG8yeRm9fPTf3ly2FxjZ68HEWq1SawP48m",
    "kii7y9zV5dAue/AoasxDKwXw+w9PRSiIQiiUytsxLQFs0lAqFEKBS+vLhIZrM3GRY4BQ6u/CCfvrxMR9NOBQbi3flfYOeBiNnLS1h4fuUhs/QH",
    "WgC1BJMezJhahUIhl+vA83pttkAi5PWGb28yVz7fxc1NNpMptGHgdDJ6mX58fDxXX+sv05fKtJbGytdYl34iHwCE1XkCkm6uPPCkXq8FTS4VSa",
    "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",
}

--==================== CONFIG (salva em arquivo) ====================
local Config = {
    -- farm / combate
    tweenSpeed = 200, tweenMode = "Lerp", farmDist = 10, posMethod = "Above",
    weapon = "Melee", haki = true, faceMob = false, noclip = true,
    orionClick = false, orionBurst = 1, atkMethod = "Auto", atkDelay = 0.04, moonRange = 60, moonTargets = 12, fast = true,
    chestSpeed = 200, fruitSpeed = 200, tpSpeed = 200, store = true, hopDelay = 6,
    seaHeight = 35, seaSpeed = 200, seaSkills = true, bossHeight = 14, bossSkills = true, aimCam = false,
    bringMob = false, bringDist = 800, bringCount = 5, mouseClick = false,
    -- main
    farm = false, chest = false, bones = false, cake = false, cakeQuest = false, ignoreKat = false,
    halloween = false, halloGacha = false,
    -- multi farm
    elite = false, killIndra = false, sumIndra = false, pads = false,
    killReaper = false, sumReaper = false, killBeard = false, sumBeard = false, hopBeard = false,
    factory = false,
    -- sea events
    sLev = false, sLevSeg = false, sBeast = false, sShark = false, sPiranha = false, sFish = false, sGhost = false,
    autoBoat = false, boatType = "PirateBrigade", boatSpeed = 150,
    -- fruits
    fruit = false, hop = false, gacha = false, gachaDelay = 2, autoStore = false,
    -- itens (espadas Sea 3)
    swYama = false, swTushita = false, swHallow = false, swCanvander = false, swTrident = false,
    swBuddy = false, swDagger = false, swTwin = false,
    -- quests / race / raids / trials
    bartilo = false, citizen = false, raceV2 = false, raceV3 = false,
    raid = false, raidType = "Flame", buyChip = false, badFruit = true, awaken = false,
    actV3 = false, actV4 = false,
    -- extras
    afk = true, afkMin = 5, fpsBoost = false, fpsMax = false,
    espPlayers = false, espFruits = false, espChests = false, espBerries = false, espIsland = false,
    espDist = true, espOutline = true,
    spdOn = false, speedVal = 50, cfm = false, infj = false, walkWater = false,
    island = "", tpGo = false,
    saber = false, sea2Quest = false, sea3Quest = false,
    autoStats = false, statPer = 1, statLeft = "Automatico", statMelee = false, statDefense = false, statSword = false, statGun = false, statFruit = false,
}
pcall(function()
    if isfile and isfile(CFG_FILE) then
        local d = HttpService:JSONDecode(readfile(CFG_FILE))
        for k, v in pairs(d) do
            if Config[k] ~= nil and type(v) == type(Config[k]) then Config[k] = v end
        end
    end
end)
-- Funcoes automaticas sempre comecam DESLIGADAS ao executar (evita sair voando sozinho)
for _, k in ipairs({"farm", "tpGo", "autoBoat", "gacha", "halloween", "halloGacha"}) do Config[k] = false end
local saveCfg
do
    local saveQueued = false
    function saveCfg()
        if saveQueued then return end
        saveQueued = true
        task.delay(0.6, function()
            saveQueued = false
            pcall(function()
                if writefile then writefile(CFG_FILE, HttpService:JSONEncode(Config)) end
            end)
        end)
    end
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
do
    local okp = pcall(function()
        gui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
    end)
    if not okp or not gui.Parent then gui.Parent = lp:WaitForChild("PlayerGui") end
end

local C = {
    bg = Color3.fromRGB(11, 11, 17), side = Color3.fromRGB(15, 15, 23), card = Color3.fromRGB(23, 23, 34),
    line = Color3.fromRGB(40, 40, 58), txt = Color3.fromRGB(236, 236, 246), mut = Color3.fromRGB(126, 128, 152),
    off = Color3.fromRGB(50, 52, 70), acc = Color3.fromRGB(139, 92, 246), acc2 = Color3.fromRGB(99, 102, 241),
}

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

local Stopped = false
local Running = false -- true enquanto o agendador executa alguma funcao automatica
local TpBusy = false
local conns = {}
local function keep(c) table.insert(conns, c) return c end
local function destroyAll()
    Stopped = true
    for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
    pcall(function() RS:UnbindFromRenderStep("ORIONAim") end)
    pcall(function() gui:Destroy() end)
end
pcall(function() if getgenv then getgenv().ORION_UNLOAD = destroyAll end end)

-- decodificador base64 (para a imagem embutida do botao)
local function b64dec(data)
    local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    local map = {}
    for i = 1, 64 do map[string.byte(alphabet, i)] = i - 1 end
    local out, n, bits, acc = {}, 0, 0, 0
    for i = 1, #data do
        local v = map[string.byte(data, i)]
        if v then
            acc = acc * 64 + v
            bits = bits + 6
            if bits >= 8 then
                bits = bits - 8
                local p = 2 ^ bits
                local byte = math.floor(acc / p)
                acc = acc - byte * p
                n = n + 1
                out[n] = string.char(byte)
            end
        end
    end
    return table.concat(out)
end

--==================== JANELA ====================
local main
do
    local cam0 = workspace.CurrentCamera
    local vp = cam0 and cam0.ViewportSize or Vector2.new(1280, 720)
    local W = math.min(660, vp.X - 20)
    local H = math.min(440, vp.Y - 20)
    main = new("Frame", {
        Size = UDim2.fromOffset(W, H), Position = UDim2.new(0.5, -W / 2, 0.5, -H / 2),
        BackgroundColor3 = C.bg, BorderSizePixel = 0,
    }, gui)
end
round(main, 14)
new("UIStroke", {Thickness = 1.5, Color = C.acc, Transparency = 0.45}, main)

local top = new("Frame", {Size = UDim2.new(1, 0, 0, 54), BackgroundTransparency = 1}, main)
new("TextLabel", {
    Size = UDim2.fromOffset(250, 24), Position = UDim2.fromOffset(16, 8), BackgroundTransparency = 1,
    Text = NAME, TextColor3 = C.txt, Font = Enum.Font.GothamBold, TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left,
}, top)
local infoTop = new("TextLabel", {
    Size = UDim2.fromOffset(300, 16), Position = UDim2.fromOffset(16, 31), BackgroundTransparency = 1,
    Text = "Blox Fruit · " .. VERSION, TextColor3 = C.mut, Font = Enum.Font.Gotham, TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
}, top)

local searchBox = new("TextBox", {
    Size = UDim2.fromOffset(140, 28), Position = UDim2.new(1, -354, 0, 13), BackgroundColor3 = C.card,
    Text = "", PlaceholderText = "Search...", PlaceholderColor3 = C.mut, TextColor3 = C.txt,
    Font = Enum.Font.Gotham, TextSize = 12, ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left,
}, top)
round(searchBox, 8)
new("UIPadding", {PaddingLeft = UDim.new(0, 10)}, searchBox)

local function topBtn(txt, xOff, w)
    local b = new("TextButton", {
        Size = UDim2.fromOffset(w or 28, 28), Position = UDim2.new(1, xOff, 0, 13), BackgroundColor3 = C.card,
        Text = txt, TextColor3 = C.txt, Font = Enum.Font.GothamMedium, TextSize = 12, AutoButtonColor = false,
    }, top)
    round(b, 8)
    return b
end
local btnMin = topBtn("-", -70)
local btnCfg = topBtn("Farm Settings", -190, 112)
topBtn("x", -38).MouseButton1Click:Connect(destroyAll)
new("Frame", {
    Size = UDim2.new(1, -20, 0, 1), Position = UDim2.fromOffset(10, 54), BackgroundColor3 = C.line, BorderSizePixel = 0,
}, main)

local function toggleMain() main.Visible = not main.Visible end
btnMin.MouseButton1Click:Connect(toggleMain)
keep(UIS.InputBegan:Connect(function(i, gp)
    if not gp and i.KeyCode == Enum.KeyCode.RightShift then toggleMain() end
end))

do -- arrastar janela
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

-- BOTAO FLUTUANTE: imagem embutida (ou BUTTON_IMAGE); a constelacao desenhada serve de reserva
do
    local fb = new("TextButton", {
        Size = UDim2.fromOffset(54, 54), Position = UDim2.new(0, 16, 0.5, -27), BackgroundColor3 = Color3.fromRGB(8, 10, 24),
        Text = "", AutoButtonColor = false, ZIndex = 50, ClipsDescendants = true,
    }, gui)
    round(fb, 27)
    new("UIStroke", {Thickness = 2, Color = C.acc}, fb)
    new("UIGradient", {
        Color = ColorSequence.new(Color3.fromRGB(26, 30, 66), Color3.fromRGB(6, 7, 18)), Rotation = 60,
    }, fb)
    local art = new("Frame", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ZIndex = 51}, fb)

    local S = 54
    local pts = {
        meissa = {0.50, 0.14}, betel = {0.33, 0.27}, bella = {0.68, 0.27},
        mintaka = {0.61, 0.52}, alnilam = {0.51, 0.54}, alnitak = {0.41, 0.56},
        saiph = {0.37, 0.80}, rigel = {0.71, 0.79},
    }
    local function P(n) return pts[n][1] * S, pts[n][2] * S end
    local function line(a, b)
        local x1, y1 = P(a)
        local x2, y2 = P(b)
        local len = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
        local ang = math.deg(math.atan2(y2 - y1, x2 - x1))
        new("Frame", {
            Size = UDim2.fromOffset(len, 1), AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset((x1 + x2) / 2, (y1 + y2) / 2), Rotation = ang,
            BackgroundColor3 = Color3.fromRGB(170, 185, 255), BackgroundTransparency = 0.45, BorderSizePixel = 0, ZIndex = 51,
        }, art)
    end
    for _, l in ipairs({{"betel", "meissa"}, {"meissa", "bella"}, {"betel", "alnitak"}, {"bella", "mintaka"},
        {"alnitak", "alnilam"}, {"alnilam", "mintaka"}, {"alnitak", "saiph"}, {"mintaka", "rigel"}}) do
        line(l[1], l[2])
    end
    local function star(n, size, col)
        local x, y = P(n)
        local s = new("Frame", {
            Size = UDim2.fromOffset(size, size), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(x, y),
            BackgroundColor3 = col, BorderSizePixel = 0, ZIndex = 53,
        }, art)
        round(s, size)
        local g = new("Frame", {
            Size = UDim2.fromOffset(size * 2.6, size * 2.6), AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset(x, y), BackgroundColor3 = col, BackgroundTransparency = 0.8,
            BorderSizePixel = 0, ZIndex = 52,
        }, art)
        round(g, size * 3)
    end
    star("betel", 5, Color3.fromRGB(255, 190, 170))
    star("rigel", 5, Color3.fromRGB(210, 225, 255))
    star("bella", 3, Color3.fromRGB(190, 210, 255))
    star("meissa", 3, Color3.fromRGB(190, 210, 255))
    star("mintaka", 3, Color3.fromRGB(200, 220, 255))
    star("alnilam", 3, Color3.fromRGB(200, 220, 255))
    star("alnitak", 3, Color3.fromRGB(200, 220, 255))
    star("saiph", 3, Color3.fromRGB(190, 210, 255))

    task.spawn(function()
        local src
        if BUTTON_IMAGE ~= "" then
            src = BUTTON_IMAGE
            if string.sub(src, 1, 4) == "http" then
                local ok, res = pcall(function()
                    writefile("orion_btn.png", game:HttpGet(src))
                    return getcustomasset("orion_btn.png")
                end)
                src = ok and res or nil
            end
        else
            local ok, res = pcall(function()
                writefile("orion_btn.png", b64dec(table.concat(BTN_B64)))
                return getcustomasset("orion_btn.png")
            end)
            src = ok and res or nil
        end
        if src then
            local img = new("ImageLabel", {
                Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Image = src,
                ScaleType = Enum.ScaleType.Crop, ZIndex = 60,
            }, fb)
            round(img, 27)
            art.Visible = false
        end
    end)

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

--==================== UI: componentes (cards estilo Maru) ====================
local side = new("ScrollingFrame", {
    Size = UDim2.new(0, 126, 1, -66), Position = UDim2.fromOffset(10, 62), BackgroundTransparency = 1,
    BorderSizePixel = 0, ScrollBarThickness = 0, CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, main)
new("UIListLayout", {Padding = UDim.new(0, 3)}, side)
local content = new("Frame", {
    Size = UDim2.new(1, -156, 1, -68), Position = UDim2.fromOffset(146, 62), BackgroundTransparency = 1,
}, main)

local tabs, curTab = {}, nil
local function selectTab(t)
    curTab = t
    for _, o in ipairs(tabs) do
        local on = (o == t)
        o.page.Visible = on
        o.bar.Visible = on
        o.btn.BackgroundTransparency = on and 0 or 1
        o.btn.TextColor3 = on and C.txt or C.mut
    end
end

local toggles = {}      -- key -> {set, isOn, group}
local statusSetters = {}
local function setSt(key, text)
    local f = statusSetters[key]
    if f then f(text) end
end
local function uiSet(key, v)
    local t = toggles[key]
    if t then t.set(v) else Config[key] = v end
end

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
    new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}, page)
    new("UIPadding", {PaddingTop = UDim.new(0, 2), PaddingRight = UDim.new(0, 8), PaddingBottom = UDim.new(0, 12)}, page)

    local t = {btn = btn, bar = bar, page = page, cards = {}, order = 0}
    table.insert(tabs, t)
    btn.MouseButton1Click:Connect(function() selectTab(t) end)

    local function nextOrder()
        t.order = t.order + 1
        return t.order
    end
    local function reg(frame, title, desc)
        frame.LayoutOrder = nextOrder()
        table.insert(t.cards, {f = frame, s = string.lower((title or "") .. " " .. (desc or ""))})
    end
    local function heading(card, title, desc, rightPad)
        new("TextLabel", {
            Size = UDim2.new(1, -rightPad, 0, 18), Position = UDim2.fromOffset(14, 9), BackgroundTransparency = 1,
            Text = title, TextColor3 = C.txt, Font = Enum.Font.GothamMedium, TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        }, card)
        return new("TextLabel", {
            Size = UDim2.new(1, -rightPad, 0, 26), Position = UDim2.fromOffset(14, 28), BackgroundTransparency = 1,
            Text = desc or "", TextColor3 = C.mut, Font = Enum.Font.Gotham, TextSize = 11, TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
            TextTruncate = Enum.TextTruncate.AtEnd,
        }, card)
    end

    function t.Section(text)
        local l = new("TextLabel", {
            Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1, Text = text, TextColor3 = C.mut,
            Font = Enum.Font.GothamMedium, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Bottom,
        }, page)
        reg(l, "", "")
        return l
    end

    function t.Note(text)
        local l = new("TextLabel", {
            Size = UDim2.new(1, 0, 0, 16), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
            Text = text, TextColor3 = C.mut, Font = Enum.Font.Gotham, TextSize = 12, TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
        }, page)
        reg(l, text, "")
        return l
    end

    -- liga/desliga ligado a Config[key]; cb(on) opcional; group = exclusivo entre funcoes do mesmo grupo
    local function bind(sw, key, cb, group)
        local obj = {group = group}
        local on = false
        local function apply(v)
            on = v and true or false
            Config[key] = on
            sw.render(on)
            saveCfg()
            if cb then pcall(cb, on) end
        end
        function obj.isOn() return on end
        function obj.set(v) if on ~= v then apply(v) end end
        sw.btn.MouseButton1Click:Connect(function()
            if not on and group then
                for k, o in pairs(toggles) do
                    if o ~= obj and o.group == group and o.isOn() then o.set(false) end
                end
            end
            apply(not on)
        end)
        toggles[key] = obj
        on = Config[key] == true
        if on and group then
            for k, o in pairs(toggles) do
                if o ~= obj and o.group == group and o.isOn() then on = false Config[key] = false end
            end
        end
        sw.render(on)
        if on and cb then task.defer(function() pcall(cb, true) end) end
        return obj
    end

    function t.Toggle(title, desc, key, cb, group)
        local card = new("Frame", {Size = UDim2.new(1, 0, 0, 58), BackgroundColor3 = C.card}, page)
        round(card, 10)
        local d = heading(card, title, desc, 80)
        local sw = makeSwitch(card, UDim2.new(1, -58, 0.5, -11))
        reg(card, title, desc)
        return bind(sw, key, cb, group), d
    end

    -- funcao automatica: a descricao mostra o status ao vivo
    function t.Feature(title, key, group, cb)
        local card = new("Frame", {Size = UDim2.new(1, 0, 0, 58), BackgroundColor3 = C.card}, page)
        round(card, 10)
        local d = heading(card, title, "Desligado", 80)
        statusSetters[key] = function(txt) d.Text = txt end
        local sw = makeSwitch(card, UDim2.new(1, -58, 0.5, -11))
        reg(card, title, "")
        return bind(sw, key, function(on)
            if not on then d.Text = "Desligado" end
            if cb then cb(on) end
        end, group)
    end

    function t.Button(title, desc, btnText, cb)
        local card = new("Frame", {Size = UDim2.new(1, 0, 0, 58), BackgroundColor3 = C.card}, page)
        round(card, 10)
        local d = heading(card, title, desc, 140)
        local b = new("TextButton", {
            Size = UDim2.fromOffset(100, 28), Position = UDim2.new(1, -114, 0.5, -14), BackgroundColor3 = C.acc,
            Text = btnText or "Executar", TextColor3 = Color3.new(1, 1, 1), Font = Enum.Font.GothamMedium,
            TextSize = 12, AutoButtonColor = false,
        }, card)
        round(b, 8)
        b.MouseButton1Click:Connect(function() pcall(cb, b, d) end)
        reg(card, title, desc)
        return d, b
    end

    function t.Slider(title, desc, min, max, key, cb)
        local card = new("Frame", {Size = UDim2.new(1, 0, 0, 66), BackgroundColor3 = C.card}, page)
        round(card, 10)
        heading(card, title, desc, 100)
        local box = new("TextBox", {
            Size = UDim2.fromOffset(62, 24), Position = UDim2.new(1, -76, 0, 8), BackgroundColor3 = C.bg,
            Text = tostring(Config[key]), TextColor3 = C.txt, Font = Enum.Font.GothamMedium, TextSize = 12,
            ClearTextOnFocus = false,
        }, card)
        round(box, 6)
        local track = new("Frame", {
            Size = UDim2.new(1, -28, 0, 6), Position = UDim2.fromOffset(14, 54), BackgroundColor3 = C.off, BorderSizePixel = 0,
        }, card)
        round(track, 3)
        local a0 = math.clamp((Config[key] - min) / (max - min), 0, 1)
        local fill = new("Frame", {Size = UDim2.new(a0, 0, 1, 0), BackgroundColor3 = C.acc, BorderSizePixel = 0}, track)
        round(fill, 3)
        local knob = new("Frame", {
            Size = UDim2.fromOffset(12, 12), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(a0, 0, 0.5, 0),
            BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, ZIndex = 2,
        }, track)
        round(knob, 6)
        local hit = new("TextButton", {
            Size = UDim2.new(1, -14, 0, 22), Position = UDim2.fromOffset(7, 46), BackgroundTransparency = 1, Text = "",
        }, card)
        local isInt = (min % 1 == 0 and max % 1 == 0 and (max - min) >= 10)
        local function setValue(v)
            v = math.clamp(v, min, max)
            if isInt then v = math.floor(v + 0.5) else v = math.floor(v * 100 + 0.5) / 100 end
            Config[key] = v
            local a = (v - min) / (max - min)
            fill.Size = UDim2.new(a, 0, 1, 0)
            knob.Position = UDim2.new(a, 0, 0.5, 0)
            box.Text = tostring(v)
            if cb then pcall(cb, v) end
        end
        local drag = false
        hit.InputBegan:Connect(function(i)
            if isPress(i) then
                drag = true
                setValue(min + (max - min) * math.clamp((i.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1))
            end
        end)
        keep(UIS.InputChanged:Connect(function(i)
            if drag and isMove(i) then
                setValue(min + (max - min) * math.clamp((i.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1))
            end
        end))
        keep(UIS.InputEnded:Connect(function(i)
            if drag and isPress(i) then drag = false saveCfg() end
        end))
        box.FocusLost:Connect(function()
            local n = tonumber(box.Text)
            if n then setValue(n) saveCfg() else box.Text = tostring(Config[key]) end
        end)
        reg(card, title, desc)
    end

    -- lista suspensa: options pode ser trocada depois com obj.setOptions
    function t.Dropdown(title, desc, options, key, cb, maxVisible)
        local card = new("Frame", {Size = UDim2.new(1, 0, 0, 58), BackgroundColor3 = C.card, ClipsDescendants = true}, page)
        round(card, 10)
        heading(card, title, desc, 160)
        local valBtn = new("TextButton", {
            Size = UDim2.fromOffset(132, 28), Position = UDim2.new(1, -146, 0, 15), BackgroundColor3 = C.off,
            Text = "", TextColor3 = C.txt, Font = Enum.Font.GothamMedium, TextSize = 12, AutoButtonColor = false,
            TextTruncate = Enum.TextTruncate.AtEnd,
        }, card)
        round(valBtn, 8)
        local list = new("ScrollingFrame", {
            Size = UDim2.new(1, -20, 0, 0), Position = UDim2.fromOffset(10, 64), BackgroundTransparency = 1,
            BorderSizePixel = 0, ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        }, card)
        new("UIListLayout", {Padding = UDim.new(0, 3)}, list)
        local obj = {options = options}
        local open = false
        local mv = maxVisible or 6
        local function show(cur) valBtn.Text = (cur ~= nil and cur ~= "") and (tostring(cur) .. "   v") or "None   v" end
        local function relayout()
            local rows = math.min(#obj.options, mv)
            list.Size = UDim2.new(1, -20, 0, rows * 29)
            card.Size = UDim2.new(1, 0, 0, open and (72 + rows * 29) or 58)
        end
        function obj.setOptions(opts)
            obj.options = opts
            for _, c in ipairs(list:GetChildren()) do
                if c:IsA("TextButton") then c:Destroy() end
            end
            for _, o in ipairs(opts) do
                local b = new("TextButton", {
                    Size = UDim2.new(1, -6, 0, 26), BackgroundColor3 = C.bg, Text = tostring(o), TextColor3 = C.txt,
                    Font = Enum.Font.Gotham, TextSize = 12, AutoButtonColor = false,
                }, list)
                round(b, 6)
                b.MouseButton1Click:Connect(function()
                    Config[key] = o
                    show(o)
                    open = false
                    relayout()
                    saveCfg()
                    if cb then pcall(cb, o) end
                end)
            end
            relayout()
        end
        valBtn.MouseButton1Click:Connect(function() open = not open relayout() end)
        show(Config[key])
        obj.setOptions(options)
        reg(card, title, desc)
        return obj
    end

    -- lista suspensa com varias opcoes marcaveis; cada opcao e um booleano em Config[key]
    function t.MultiSelect(title, desc, options, cb, maxVisible)
        local card = new("Frame", {Size = UDim2.new(1, 0, 0, 58), BackgroundColor3 = C.card, ClipsDescendants = true}, page)
        round(card, 10)
        heading(card, title, desc, 190)
        local valBtn = new("TextButton", {
            Size = UDim2.fromOffset(160, 28), Position = UDim2.new(1, -174, 0, 15), BackgroundColor3 = C.off,
            Text = "", TextColor3 = C.txt, Font = Enum.Font.GothamMedium, TextSize = 12, AutoButtonColor = false,
            TextTruncate = Enum.TextTruncate.AtEnd,
        }, card)
        round(valBtn, 8)
        local list = new("ScrollingFrame", {
            Size = UDim2.new(1, -20, 0, 0), Position = UDim2.fromOffset(10, 64), BackgroundTransparency = 1,
            BorderSizePixel = 0, ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        }, card)
        new("UIListLayout", {Padding = UDim.new(0, 3)}, list)
        local open = false
        local mv = maxVisible or 5
        local function summary()
            local names = {}
            for _, o in ipairs(options) do
                if Config[o.key] then table.insert(names, o.label) end
            end
            valBtn.Text = (#names == 0 and "Nenhum" or table.concat(names, ", ")) .. "   v"
        end
        local function relayout()
            local n = math.min(#options, mv)
            list.Size = UDim2.new(1, -20, 0, n * 29)
            card.Size = UDim2.new(1, 0, 0, open and (72 + n * 29) or 58)
        end
        for _, o in ipairs(options) do
            local b = new("TextButton", {
                Size = UDim2.new(1, -6, 0, 26), BackgroundColor3 = C.bg, Text = "", TextColor3 = C.txt,
                Font = Enum.Font.Gotham, TextSize = 12, AutoButtonColor = false,
            }, list)
            round(b, 6)
            local function paint()
                b.Text = (Config[o.key] and "[x]  " or "[   ]  ") .. o.label
                b.TextColor3 = Config[o.key] and C.acc or C.txt
            end
            paint()
            b.MouseButton1Click:Connect(function()
                Config[o.key] = not Config[o.key]
                paint()
                summary()
                saveCfg()
                if cb then pcall(cb) end
            end)
        end
        valBtn.MouseButton1Click:Connect(function() open = not open relayout() end)
        summary()
        relayout()
        reg(card, title, desc)
    end

    return t
end

-- busca: filtra os cards da aba atual
local function applySearch()
    if not curTab then return end
    local q = string.lower(searchBox.Text or "")
    for _, c in ipairs(curTab.cards) do
        c.f.Visible = (q == "") or (c.s ~= " " and string.find(c.s, q, 1, true) ~= nil)
    end
end
searchBox:GetPropertyChangedSignal("Text"):Connect(applySearch)

local T = {}
T.cfg = newTab("Farm Settings")
T.main = newTab("Main")
T.multi = newTab("Multi Farm")
T.quests = newTab("Quests")
T.race = newTab("Race")
T.raids = newTab("Raids")
T.sea = newTab("Sea Event")
T.fruit = newTab("Fruits")
T.items = newTab("Itens")
T.loc = newTab("Location")
T.esp = newTab("ESP")
T.player = newTab("Player")
T.status = newTab("Status")
T.misc = newTab("Diversos")
btnCfg.MouseButton1Click:Connect(function() selectTab(T.cfg) end)

local sessionStartedAt = os.clock()

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
local function invoke(...)
    local rem = getRem()
    if not rem then return nil end
    local args = {...}
    local ok, res = pcall(function() return rem:InvokeServer(unpack(args)) end)
    if ok then return res end
    return nil
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

local function partOf(v)
    if v:IsA("BasePart") then return v end
    if v:IsA("Model") then
        return v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart", true)
    end
    return nil
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

--==================== MOVIMENTO ====================
-- Um movimento novo cancela o anterior, evitando conflitos entre farm, baus e teleporte.
local MoveGeneration = 0
-- Tween Lerp (Heartbeat): move o HumanoidRootPart em linha reta na velocidade (studs/s).
-- Retorna true se chegou; false se cancelado. Nao gira o personagem (camera livre).
local function moveTo(cf, speed, alive)
    MoveGeneration = MoveGeneration + 1
    local myGeneration = MoveGeneration
    local hrp = root()
    if not hrp then return false end
    local startCF = hrp.CFrame
    local goal = CFrame.new(cf.Position) * (startCF - startCF.Position)
    local distance = (startCF.Position - goal.Position).Magnitude
    if distance < 1 then
        hrp.CFrame = goal
        return true
    end
    speed = math.min(speed or 200, 200)
    local duration = math.max(distance / math.max(speed, 10), 0.03)
    local t0 = os.clock()
    local finished, cancelled = false, false

    if Config.tweenMode == "Tween" then
        local tw = TS:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = goal})
        local cn = tw.Completed:Connect(function() finished = true end)
        tw:Play()
        while not finished and os.clock() - t0 < duration + 3 do
            if Stopped or myGeneration ~= MoveGeneration or (alive and not alive()) or not root() then
                cancelled = true
                pcall(function() tw:Cancel() end)
                break
            end
            task.wait(0.04)
        end
        cn:Disconnect()
        return finished and not cancelled
    end

    local conn
    conn = RS.Heartbeat:Connect(function()
        local cur = root()
        if Stopped or myGeneration ~= MoveGeneration or not cur or (alive and not alive()) or os.clock() - t0 > duration + 4 then
            cancelled = true
            conn:Disconnect()
            return
        end
        local alpha = math.min((os.clock() - t0) / duration, 1)
        cur.CFrame = startCF:Lerp(goal, alpha)
        if alpha >= 1 then
            finished = true
            conn:Disconnect()
        end
    end)
    while not finished and not cancelled do task.wait() end
    return finished
end

-- REDEMOINHOS (Sea 1): a Underwater City (Fishman) fica a ~60000 studs; so se entra pelo redemoinho.
-- ensureRegion() devolve true quando voce ja esta na mesma regiao do destino. Se nao estiver, voa ate o
-- redemoinho e usa o "requestEntrance" do jogo (entrar ou sair) e devolve false (chame de novo).
local ensureRegion
do
local PORTAL_SURFACE = Vector3.new(3864.69, 6.74, -1926.21)
local PORTAL_UNDER = Vector3.new(61163.85, 11.68, 1819.78)
local function regionOf(pos) return pos.X > 40000 and "under" or "surface" end
local lastEntrance = 0
function ensureRegion(dest, alive, setS)
    detectSea()
    if SEA ~= 1 or not dest then return true end
    local r = root()
    if not r then return true end
    local mine, want = regionOf(r.Position), regionOf(dest)
    if mine == want then return true end
    local standAt = (mine == "surface") and PORTAL_SURFACE or PORTAL_UNDER
    local goTo = (want == "under") and PORTAL_UNDER or PORTAL_SURFACE
    local label = (want == "under") and "entrando na Underwater City pelo redemoinho" or "saindo da Underwater City pelo redemoinho"
    local d = (r.Position - standAt).Magnitude
    if d > 70 then
        setS(label .. " (indo ate o redemoinho, " .. math.floor(d) .. "m)")
        moveTo(CFrame.new(standAt + Vector3.new(0, 6, 0)), Config.tweenSpeed, alive)
        return false
    end
    if os.clock() - lastEntrance < 4 then
        task.wait(0.5)
        return false
    end
    lastEntrance = os.clock()
    setS(label .. "...")
    invoke("requestEntrance", goTo)
    task.wait(2)
    local r2 = root()
    if r2 and regionOf(r2.Position) == want then return true end
    -- se a posicao nao mudou, tenta de novo com o personagem exatamente em cima do redemoinho
    if r2 then r2.CFrame = CFrame.new(standAt) end
    task.wait(0.4)
    invoke("requestEntrance", goTo)
    task.wait(2)
    r2 = root()
    return r2 ~= nil and regionOf(r2.Position) == want
end
end

-- posicao de ataque em relacao ao alvo (Above / Behind / Below)
local function hoverPos(p, dist)
    dist = dist or Config.farmDist
    if Config.posMethod == "Behind" then return p + Vector3.new(0, 3, dist) end
    if Config.posMethod == "Below" then return p - Vector3.new(0, dist, 0) end
    return p + Vector3.new(0, dist, 0)
end

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

-- gruda no alvo: perto (<= 18 studs) so ajusta a posicao; longe, VOA com tween (nunca da tp seco)
local function stickTo(pos, look, alive)
    local r = root()
    if not r then return false end
    if (r.Position - pos).Magnitude > 18 then
        return moveTo(CFrame.new(pos), Config.tweenSpeed, alive)
    end
    return placeAt(pos, look)
end

-- noclip + sem queda durante as funcoes automaticas
keep(RS.Stepped:Connect(function()
    if not Config.noclip or not (Running or TpBusy) then return end
    local c = lp.Character
    if not c then return end
    for _, p in ipairs(c:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end
    local r = c:FindFirstChild("HumanoidRootPart")
    if r then r.AssemblyLinearVelocity = Vector3.new(0, 0, 0) end
end))

--==================== COMBATE ====================
local ensureHaki
do
    local lastHaki = 0
    function ensureHaki()
        if not Config.haki then return end
        if os.clock() - lastHaki < 5 then return end
        lastHaki = os.clock()
        local c = lp.Character
        if c and not c:FindFirstChild("HasBuso") then invoke("Buso") end
    end
end

local function equipTip(tip)
    local c = lp.Character
    local h = hum()
    if not c or not h then return end
    local cur = c:FindFirstChildOfClass("Tool")
    if cur and cur.ToolTip == tip then return end
    for _, t in ipairs(lp.Backpack:GetChildren()) do
        if t:IsA("Tool") and t.ToolTip == tip then
            h:EquipTool(t)
            return
        end
    end
end
local function equipWeapon()
    ensureHaki()
    equipTip(Config.weapon)
end

local function screenCenter()
    local c = workspace.CurrentCamera
    local v = c and c.ViewportSize or Vector2.new(800, 450)
    return v.X / 2, v.Y / 2
end
-- se o hub estiver no ponto do clique, esconde para nao clicar nos botoes dele
local function protectHub(x, y)
    if not main.Visible then return end
    local p, s = main.AbsolutePosition, main.AbsoluteSize
    if x >= p.X - 10 and x <= p.X + s.X + 10 and y >= p.Y - 10 and y <= p.Y + s.Y + 50 then
        main.Visible = false
    end
end
local function m1click()
    -- clique REAL do mouse so se voce ligar em Farm Settings (por padrao o ataque nao mexe no mouse)
    if not Config.mouseClick then return end
    if VIM then
        local x, y = screenCenter()
        protectHub(x, y)
        pcall(function()
            VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
            VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
        end)
    else
        pcall(function()
            VU:CaptureController()
            VU:ClickButton1(Vector2.new(900, 500))
        end)
    end
end
local function toolActivate()
    pcall(function()
        local c = lp.Character
        local tool = c and c:FindFirstChildOfClass("Tool")
        if tool then tool:Activate() end
    end)
end

-- Fast Attack: 4 metodos. No modo Auto ele troca de metodo sozinho se nao causar dano.
local CombatFramework = nil
task.spawn(function()
    pcall(function()
        local ps = lp:WaitForChild("PlayerScripts", 10)
        local mod = ps and ps:WaitForChild("CombatFramework", 10)
        if mod then CombatFramework = require(mod) end
    end)
end)
local function ctrl()
    local ok, c = pcall(function() return CombatFramework and CombatFramework.activeController end)
    if ok then return c end
    return nil
end
local function atkCF()
    local c = ctrl()
    if c and c.active then
        pcall(function()
            c.timeToNextAttack = 0
            c.hitboxTried = 0
            c:attack()
        end)
        return true
    end
    return false
end
local function atkCF2()
    local c = ctrl()
    local a = c and c.active
    if a then
        pcall(function() if a.attacker and a.attacker.hitServerCode then a.attacker:hitServerCode() end end)
        pcall(function() if a.weapon and a.weapon.attack then a.weapon:attack() end end)
        return true
    end
    return false
end
local function getNet(name)
    local mods = RepS:FindFirstChild("Modules")
    local net = mods and mods:FindFirstChild("Net")
    return net and net:FindFirstChild(name)
end
local ActiveCombatMob = nil
local function isActiveCombatTarget(model)
    if not ActiveCombatMob then return true end
    local wanted = norm(ActiveCombatMob)
    local got = norm(model and model.Name or "")
    return wanted ~= "" and string.sub(got, 1, #wanted) == wanted
end
local function enemiesNear(radius)
    local out = {}
    local en = workspace:FindFirstChild("Enemies")
    local r = root()
    if not en or not r then return out end
    for _, e in ipairs(en:GetChildren()) do
        local h = e:FindFirstChildOfClass("Humanoid")
        local p = e:FindFirstChild("HumanoidRootPart")
        if h and p and h.Health > 0 and isActiveCombatTarget(e) and (p.Position - r.Position).Magnitude <= radius then
            table.insert(out, e)
        end
    end
    return out
end
local function atkRemote(extra)
    local ra, rh = getNet("RE/RegisterAttack"), getNet("RE/RegisterHit")
    if not (ra and rh) then return false end
    local fired = false
    pcall(function()
        local targets, mainPart = {}, nil
        for _, e in ipairs(enemiesNear(60)) do
            local part = e:FindFirstChild("Head") or e:FindFirstChild("HumanoidRootPart")
            if part then
                table.insert(targets, {e, part})
                mainPart = mainPart or part
            end
        end
        if extra then
            for _, t in ipairs(extra) do
                if t[1] and isActiveCombatTarget(t[1]) then
                    table.insert(targets, t)
                    mainPart = mainPart or t[2]
                end
            end
        end
        if mainPart then
            ra:FireServer(0)
            rh:FireServer(mainPart, targets)
            fired = true
        end
    end)
    return fired
end

local METHODS = {"Moon", "CF", "CF2", "Remote", "Click"}
local METHOD_NAMES = {Moon = "Moon", CombatFramework = "CF", ["CombatFramework 2"] = "CF2", Remote = "Remote", Click = "Click"}
local Atk = {m = 1, hp = nil, lastHp = 0, lastDmg = 0, near = false, forceUntil = 0, lastAttack = 0}

-- MOON FAST ATTACK (Melee e Sword): golpe do proprio jogo + registro de hit em todos os mobs no alcance
-- Roda no Heartbeat, separado do movimento do farm (o tween nao atrapalha o ataque).
local atkMoon, moonHandles
do
    local Net = {ready = false}
    task.spawn(function()
        local ok = pcall(function()
            local modules = RepS:WaitForChild("Modules", 40)
            local folder = modules and modules:WaitForChild("Net", 40)
            Net.module = require(folder)
            Net.reg = folder:WaitForChild("RE/RegisterAttack", 40)
            Net.hit = folder:WaitForChild("RE/RegisterHit", 40)
            assert(Net.reg and Net.hit)
        end)
        Net.ready = ok
    end)

    local holder, retryAt = nil, 0
    local function findController()
        if holder or os.clock() - retryAt < 3 then return holder end
        retryAt = os.clock()
        pcall(function()
            local ps = lp:FindFirstChild("PlayerScripts")
            local m = ps and ps:FindFirstChild("CombatFramework")
            if not m then return end
            local mod = require(m)
            if type(mod) == "table" and mod.activeController ~= nil then
                holder = mod
                return
            end
            local gu = getupvalues or (debug and debug.getupvalues)
            if gu then holder = gu(mod)[2] end
        end)
        return holder
    end
    local function gameSwing()
        local h = findController()
        local c = h and h.activeController
        if not c then return end
        pcall(function()
            c.hitboxMagnitude = math.max(60, Config.moonRange)
            c.timeToNextAttack = 0
            c.attacking = false
            c:attack()
        end)
    end
    local function isAllyOrSelf(m)
        if m == lp.Character then return true end
        local n = string.lower(m.Name)
        if n == string.lower(lp.Name) or string.find(n, "shadow", 1, true) or string.find(n, "summon", 1, true) then return true end
        for _, a in ipairs({"Owner", "OwnerId", "OwnerUserId", "OwnerName", "Master", "Summoner", "SummonedBy"}) do
            local v = m:GetAttribute(a)
            if v ~= nil and v ~= "" and v ~= 0 then return true end
        end
        return false
    end
    local function collect(rootPart)
        local out = {}
        for _, folderName in ipairs({"Enemies", "Characters"}) do
            local f = workspace:FindFirstChild(folderName)
            if f then
                for _, m in ipairs(f:GetChildren()) do
                    if m:IsA("Model") and not isAllyOrSelf(m) and not m:GetAttribute("IsBoat") and isActiveCombatTarget(m) then
                        if Players:GetPlayerFromCharacter(m) == nil then
                            local h = m:FindFirstChildOfClass("Humanoid")
                            local r = m:FindFirstChild("HumanoidRootPart")
                            if h and r and h.Health > 0 then
                                local d = (r.Position - rootPart.Position).Magnitude
                                if d <= Config.moonRange then out[#out + 1] = {m, r, d} end
                            end
                        end
                    end
                end
            end
        end
        table.sort(out, function(a, b) return a[3] < b[3] end)
        return out
    end
    function moonHandles()
        if not Net.ready then return false end
        local char = lp.Character
        local tool = char and char:FindFirstChildOfClass("Tool")
        local wt = tool and tool:GetAttribute("WeaponType")
        return wt == "Melee" or wt == "Sword"
    end
    function atkMoon()
        if not moonHandles() then return false end
        local char = lp.Character
        local rootPart = char and char:FindFirstChild("HumanoidRootPart")
        local h = char and char:FindFirstChildOfClass("Humanoid")
        if not (rootPart and h and h.Health > 0) then return false end
        gameSwing()
        local targets = collect(rootPart)
        if #targets == 0 then return true end
        local list, head = {}, nil
        for i = 1, math.min(#targets, Config.moonTargets) do
            local m = targets[i][1]
            local hd = m:FindFirstChild("Head")
            local hrp = m:FindFirstChild("HumanoidRootPart")
            if hd then list[#list + 1] = {m, hd} end
            if hrp then list[#list + 1] = {m, hrp} end
            if not hd and not hrp then list[#list + 1] = {m, targets[i][2]} end
            head = head or m:FindFirstChild("Head") or targets[i][2]
        end
        local hash = tostring(lp.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15)
        pcall(function()
            Net.module:RemoteEvent("RegisterHit", true)
            Net.reg:FireServer()
            Net.hit:FireServer(head, list, {}, hash)
        end)
        return true
    end
    local last = 0
    keep(RS.Heartbeat:Connect(function()
        if Stopped or not Config.fast or Config.orionClick or not (Running or TpBusy) then return end
        local mode = Config.atkMethod
        local useMoon = (mode == "Moon") or (mode == "All") or (mode == "Auto" and Atk.m == 1) or os.clock() < Atk.forceUntil
        if not useMoon then return end
        if os.clock() - last < Config.atkDelay then return end
        last = os.clock()
        pcall(atkMoon)
    end))
end

-- ORION CLICK: varios golpes por frame (Moon + Remote/CF), sem intervalo. Mais rapido que o Fast Click.
keep(RS.Heartbeat:Connect(function()
    if Stopped or not Config.orionClick or not (Running or TpBusy) then return end
    local burst = math.max(1, math.floor(Config.orionBurst))
    for _ = 1, burst do
        local okm = false
        pcall(function() okm = atkMoon() end)
        if not okm then
            pcall(atkRemote)
            if not ActiveCombatMob then pcall(atkCF) end
        end
    end
end))

local function runMethod(name, extra)
    -- Durante Auto Farm de quest, nao usar metodos que deixam o jogo escolher
    -- livremente o inimigo mais proximo (isso podia acertar mobs fora da missao).
    if ActiveCombatMob and name ~= "Moon" and name ~= "Remote" then return false end
    if name == "Moon" then return moonHandles() end
    if name == "CF" then return atkCF()
    elseif name == "CF2" then return atkCF2()
    elseif name == "Remote" then return atkRemote(extra)
    end
    toolActivate()
    m1click()
    return true
end
local function attackNow(extra)
    Atk.lastAttack = os.clock()
    if not Config.fast then
        if ActiveCombatMob then
            atkRemote(extra)
        else
            toolActivate()
            m1click()
        end
        return
    end
    local mode = Config.atkMethod
    -- sem dano por 2s (ex.: boss do Saber): usa TODOS os metodos por alguns segundos
    if os.clock() < Atk.forceUntil then mode = "All" end
    if mode == "Auto" then
        if METHODS[Atk.m] == "Moon" and not moonHandles() then Atk.m = 2 end
        local okRun = false
        for _ = 1, #METHODS do
            okRun = runMethod(METHODS[Atk.m], extra)
            if okRun then break end
            Atk.m = Atk.m % #METHODS + 1
        end
    elseif mode == "All" then
        for _, n in ipairs(METHODS) do runMethod(n, extra) end
    else
        runMethod(METHOD_NAMES[mode] or "CF", extra)
    end
end
-- chamado a cada golpe: se o alvo nao perde vida por 2s, troca de metodo (e depois de posicao)
local function watchDamage(h)
    if not h then return end
    if Atk.hp ~= h then
        Atk.hp, Atk.lastHp, Atk.lastDmg = h, h.Health, os.clock()
        Atk.forceUntil = 0
        if Config.atkMethod ~= "Auto" then Atk.near = false end
        return
    end
    if h.Health < Atk.lastHp then
        Atk.lastDmg = os.clock()
        Atk.forceUntil = 0
    end
    Atk.lastHp = h.Health
    if os.clock() - Atk.lastDmg > 2 then
        Atk.lastDmg = os.clock()
        if Config.atkMethod == "Auto" then
            Atk.m = Atk.m % #METHODS + 1
            if Atk.m == 1 then Atk.near = not Atk.near end
        else
            Atk.forceUntil = os.clock() + 6
            Atk.near = true
        end
    end
end
local function atkInfo()
    local mode = Config.atkMethod == "Auto" and (METHODS[Atk.m] .. " (auto)") or Config.atkMethod
    if os.clock() < Atk.forceUntil then mode = "TODOS (sem dano)" end
    return "Metodo: " .. mode .. (Atk.near and " | colado no alvo" or "")
end
local function farmHover(d)
    d = d or Config.farmDist
    if Atk.near then d = math.min(d, 4) end
    return d
end

-- mira + skills
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

--==================== ALVOS ====================
local function partOfModel(m) return partOf(m) end

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

-- sai do assento (barco) antes de lutar
local function leaveSeat()
    local h = hum()
    if h and h.SeatPart then
        h.Sit = false
        h.Jump = true
        task.wait(0.2)
    end
end

-- vida atual (0 a 1)
local function hpFrac()
    local h = hum()
    if not h or h.MaxHealth <= 0 then return 1 end
    return h.Health / h.MaxHealth
end
-- foge para o alto e espera a vida voltar (evita morrer em loop para bosses fortes)
local function recoverHP(alive, setS, need)
    need = need or 0.85
    local r = root()
    if r then moveTo(CFrame.new(r.Position + Vector3.new(0, 250, 0)), 200, alive) end
    local t0 = os.clock()
    while alive() and os.clock() - t0 < 40 do
        local h = hum()
        if not h or h.Health <= 0 then break end -- morreu: o respawn cuida do resto
        if hpFrac() >= need then break end
        if setS then setS("vida baixa (" .. math.floor(hpFrac() * 100) .. "%): recuperando no alto antes de voltar a lutar") end
        task.wait(0.5)
    end
end

-- ataca um alvo de cima
local function engage(tg, alive, hover, skills, speed, timeout, noNear, setS)
    local r = root()
    if not r or not tg.part.Parent then return end
    leaveSeat()
    r = root()
    if not r then return end
    -- recem-respawnado ou machucado: recupera antes de chegar perto
    if hpFrac() < 0.6 then
        recoverHP(alive, setS, 0.85)
        if not alive() then return end
    end
    local hv = hover
    if Atk.near and not noNear then hv = math.min(hover, 5) end
    local function goal() return hoverPos(tg.part.Position, hv) end
    if (r.Position - goal()).Magnitude > 60 then
        if not moveTo(CFrame.new(goal()), speed, alive) then return end
    end
    equipWeapon()
    local t0, lastSkill = os.clock(), 0
    while alive() and tg.mdl.Parent and tg.part.Parent and os.clock() - t0 < (timeout or 30) do
        if tg.hum and tg.hum.Health <= 0 then break end
        if hpFrac() < 0.35 then
            recoverHP(alive, setS, 0.85)
            break
        end
        if Atk.near and not noNear then hv = math.min(hover, 5) end
        if not stickTo(goal(), tg.part.Position, alive) then break end
        attackNow()
        watchDamage(tg.hum)
        if skills and os.clock() - lastSkill > 1.5 then
            lastSkill = os.clock()
            useSkills(tg.part.Position)
        end
        task.wait(Config.orionClick and 0.01 or Config.atkDelay)
    end
end

--==================== NPCs ====================
local function nameHas(model, pats)
    local n = norm(model.Name)
    local dn = ""
    local h = model:FindFirstChildOfClass("Humanoid")
    if h then dn = norm(h.DisplayName) end
    for _, p in ipairs(pats) do
        if string.find(n, p, 1, true) or string.find(dn, p, 1, true) then return true end
    end
    return false
end
local findNPC
do
local npcCache = {}
function findNPC(pats)
    local r = root()
    local best, bd
    local function consider(m)
        if m:IsA("Model") and nameHas(m, pats) then
            local part = partOf(m)
            if part then
                local d = r and (part.Position - r.Position).Magnitude or 0
                if not bd or d < bd then best, bd = part, d end
            end
        end
    end
    local npcs = workspace:FindFirstChild("NPCs")
    if npcs then
        for _, m in ipairs(npcs:GetChildren()) do consider(m) end
    end
    if not best then
        for _, m in ipairs(workspace:GetChildren()) do consider(m) end
    end
    if best then return best end
    local key = table.concat(pats, "|")
    local c = npcCache[key]
    if c and os.clock() - c.t < 10 then return c.part end
    local found
    local n = 0
    for _, d in ipairs(workspace:GetDescendants()) do
        n = n + 1
        if n % 4000 == 0 then task.wait() end
        if d:IsA("Model") and nameHas(d, pats) then
            local part = partOf(d)
            if part then found = part break end
        end
    end
    npcCache[key] = {t = os.clock(), part = found}
    return found
end
end

-- vai ate um NPC: se ele nao carregou, voa ate a ilha dele (locKeys) e procura
local function approachNPC(pats, locKeys, alive, setS, label)
    for attempt = 1, 40 do
        if not alive() then return nil end
        local r = root()
        if not r then return nil end
        local npc = findNPC(pats)
        if npc then
            if not ensureRegion(npc.Position, alive, setS) then
                -- atravessando o redemoinho; tenta de novo
            else
                local d = (r.Position - npc.Position).Magnitude
                if d > 20 then
                    setS("indo ate " .. label .. " (" .. math.floor(d) .. "m)")
                    moveTo(CFrame.new(npc.Position + Vector3.new(0, 3, 4)), Config.tweenSpeed, alive)
                end
                r = root()
                if r and (r.Position - npc.Position).Magnitude < 25 then return npc end
            end
        else
            local lpos
            for _, k in ipairs(locKeys or {}) do lpos = lpos or locationPos(k) end
            if not lpos then
                setS("nao achei " .. label .. " (va ate a ilha dele uma vez)")
                task.wait(2)
                return nil
            end
            local d = (r.Position - lpos).Magnitude
            if d > 500 then
                setS("indo para a ilha de " .. label .. " (" .. math.floor(d) .. "m)")
                local dir = lpos - r.Position
                local stepLen = math.min(dir.Magnitude, 700)
                local tgt = r.Position + dir.Unit * stepLen
                moveTo(CFrame.new(tgt.X, lpos.Y + 70, tgt.Z), Config.tweenSpeed, alive)
            else
                setS("procurando " .. label .. "...")
                local ang = attempt * 1.3
                moveTo(CFrame.new(lpos + Vector3.new(math.cos(ang) * 120, 40, math.sin(ang) * 120)), Config.tweenSpeed, alive)
                task.wait(1)
            end
        end
    end
    return nil
end

local function firePrompts(model)
    local n = 0
    if not model then return n end
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("ProximityPrompt") and fireproximityprompt then
            pcall(function() d.HoldDuration = 0 end)
            pcall(fireproximityprompt, d)
            n = n + 1
        elseif d:IsA("ClickDetector") and fireclickdetector then
            pcall(fireclickdetector, d)
            n = n + 1
        end
    end
    return n
end

--==================== HTTP / SERVER HOP ====================
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
local serverHop
do
local hopping, hopFailed, hopBad = false, false, {}
keep(TeleportService.TeleportInitFailed:Connect(function() hopping = false hopFailed = true end))
function serverHop(setS)
    if hopping then return end
    hopping = true
    task.delay(40, function() hopping = false end)
    local ok, err = pcall(function()
        setS("procurando outro servidor...")
        local pool, cursor = {}, ""
        for _ = 1, 3 do
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
            if cursor ~= "" then url = url .. "&cursor=" .. cursor end
            local body = httpGet(url)
            if not body then break end
            local data = HttpService:JSONDecode(body)
            for _, sv in ipairs(data.data or {}) do
                if sv.id ~= game.JobId and not hopBad[sv.id] and sv.playing and sv.maxPlayers and sv.playing < sv.maxPlayers - 2 then
                    table.insert(pool, sv.id)
                end
            end
            cursor = data.nextPageCursor or ""
            if #pool >= 10 or cursor == "" then break end
        end
        pcall(function()
            if queue_on_teleport and isfile and isfile("OrionHub.lua") then
                queue_on_teleport('loadstring(readfile("OrionHub.lua"))()')
            end
        end)
        if #pool > 0 then
            -- se o jogo recusar o servidor (erro 773 etc.), marca e tenta o proximo
            for attempt = 1, 4 do
                local id = pool[math.random(1, #pool)]
                hopFailed = false
                setS("indo para outro servidor (" .. attempt .. "/4)...")
                local okT = pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, id, lp) end)
                local t0 = os.clock()
                while okT and not hopFailed and os.clock() - t0 < 7 do task.wait(0.3) end
                if okT and not hopFailed then return end
                hopBad[id] = true
                task.wait(1.5)
            end
        end
        setS("o jogo recusou os servidores (erro 773); usando teleporte aleatorio")
        TeleportService:Teleport(game.PlaceId, lp)
    end)
    if not ok then
        hopping = false
        setS("erro no hop: " .. tostring(err))
    end
end
end

--==================== AGENDADOR (prioridades) ====================
-- Funcoes de prioridade alta (fruta, bosses, eventos, raid) INTERROMPEM o farm quando tem algo para fazer
-- e o farm volta sozinho depois. Quanto menor o numero, maior a prioridade.
local Sched = {list = {}, wasOn = {}, cleanups = {}}
local function regFeature(key, prio, has, run, en)
    table.insert(Sched.list, {key = key, prio = prio, has = has, run = run, en = en})
    table.sort(Sched.list, function(a, b) return a.prio < b.prio end)
end
local function featOn(f)
    if f.en then return f.en() end
    return Config[f.key] == true
end
local function higherWants(prio)
    for _, f in ipairs(Sched.list) do
        if f.prio >= prio then break end
        if featOn(f) then
            local ok, h = pcall(f.has)
            if ok and h then return true end
        end
    end
    return false
end
local function startScheduler()
    task.spawn(function()
        while not Stopped and gui.Parent do
            -- ao DESLIGAR uma funcao, limpa o estado dela (listas de "ja tentei", cooldowns) para ela funcionar de novo ao religar
            for _, f in ipairs(Sched.list) do
                local on = featOn(f)
                if Sched.wasOn[f.key] and not on then
                    ActiveCombatMob = nil
                    for _, fn in ipairs(Sched.cleanups) do pcall(fn, f.key) end
                end
                Sched.wasOn[f.key] = on
            end
            local chosen
            for _, f in ipairs(Sched.list) do
                if featOn(f) then
                    local ok, h = pcall(f.has)
                    if ok and h then chosen = f break end
                end
            end
            if chosen then
                Running = true
                local lastCheck, cached = 0, false
                local function alive()
                    if Stopped or not featOn(chosen) then return false end
                    if os.clock() - lastCheck > 0.3 then
                        lastCheck = os.clock()
                        cached = higherWants(chosen.prio)
                    end
                    return not cached
                end
                local ok, err = pcall(chosen.run, alive, function(t) setSt(chosen.key, t) end)
                if not ok then
                    ActiveCombatMob = nil
                    setSt(chosen.key, "erro: " .. tostring(err))
                    task.wait(1.5)
                end
            else
                Running = false
                task.wait(0.4)
            end
            task.wait(0.03)
        end
        Running = false
    end)
end

--==================== HELPERS DE INTERFACE (cliques em botoes/dialogos) ====================
local mainGui, chainVisible, clickUi
do
function mainGui()
    local pg = lp:FindFirstChild("PlayerGui")
    return pg and pg:FindFirstChild("Main")
end
function chainVisible(o, stop)
    local cur = o
    while cur and cur ~= stop do
        if cur:IsA("GuiObject") and not cur.Visible then return false end
        cur = cur.Parent
    end
    return true
end
local function trimLower(s)
    local t = string.gsub(s or "", "^%s*(.-)%s*$", "%1")
    return string.lower(t)
end
local function guiCenter(obj)
    local sg = obj:FindFirstAncestorOfClass("ScreenGui")
    local insetY = 0
    if not (sg and sg.IgnoreGuiInset) then
        local okI, inset = pcall(function() return GuiService:GetGuiInset() end)
        if okI and inset then insetY = inset.Y end
    end
    return obj.AbsolutePosition.X + obj.AbsoluteSize.X / 2, obj.AbsolutePosition.Y + obj.AbsoluteSize.Y / 2 + insetY
end
local function activateGui(obj)
    local clicked = false
    if VIM then
        pcall(function()
            local x, y = guiCenter(obj)
            protectHub(x, y)
            VIM:SendMouseMoveEvent(x, y, game)
            task.wait(0.05)
            VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
            task.wait(0.05)
            VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
            clicked = true
        end)
        task.wait(0.3)
        if clicked then return true end
    end
    local fired = false
    pcall(function()
        if getconnections then
            for _, sigName in ipairs({"MouseButton1Click", "Activated", "MouseButton1Down", "MouseButton1Up"}) do
                local okc, list = pcall(function() return getconnections(obj[sigName]) end)
                if okc and type(list) == "table" then
                    for _, cn in ipairs(list) do
                        if pcall(function() cn:Fire() end) then fired = true end
                    end
                end
            end
        end
    end)
    return fired
end
local function findUiText(patterns, exact)
    local pg = lp:FindFirstChild("PlayerGui")
    if not pg then return nil end
    for _, d in ipairs(pg:GetDescendants()) do
        if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.Text ~= "" and d.Visible
            and not d:IsDescendantOf(gui) and chainVisible(d, pg) then
            local txt = trimLower(d.Text)
            for _, pat in ipairs(patterns) do
                local match
                if exact then match = (txt == pat) else match = (string.find(txt, pat, 1, true) ~= nil) end
                if match then
                    local btn = d
                    while btn and btn ~= pg and not (btn:IsA("TextButton") or btn:IsA("ImageButton")) do btn = btn.Parent end
                    if btn == pg then btn = nil end
                    return d, btn
                end
            end
        end
    end
    return nil
end
function clickUi(patterns, exact)
    local d, btn = findUiText(patterns, exact)
    if not d then return false end
    return activateGui(btn or d)
end

end

-- VIGIA DE DIALOGO DE NPC (ex.: aviso do guarda na prisao): enquanto o farm esta batendo, se aparecer uma
-- janela de dialogo ela e fechada na hora e a arma volta para a mao, para o fast attack nao parar.
do
local DLG = {lastText = "", closed = 0}
local DLG_NAMES = {dialogue = true, dialog = true, npcdialogue = true, dialogueframe = true, conversation = true, npcchat = true}
local function visibleDialogues()
    local out = {}
    local m = mainGui()
    if m then
        for _, d in ipairs(m:GetChildren()) do
            if d:IsA("GuiObject") and d.Visible and DLG_NAMES[string.lower(d.Name)] then table.insert(out, d) end
        end
    end
    return out
end
task.spawn(function()
    while not Stopped and gui.Parent do
        task.wait(0.35)
        if Running and os.clock() - Atk.lastAttack < 3 then
            local frames = visibleDialogues()
            if #frames > 0 then
                for _, f in ipairs(frames) do
                    local txt = ""
                    for _, d in ipairs(f:GetDescendants()) do
                        if d:IsA("TextLabel") and #d.Text > #txt then txt = d.Text end
                    end
                    if txt ~= DLG.lastText then
                        DLG.lastText = txt
                        print("[Orion] dialogo de NPC fechado automaticamente: " .. txt)
                    end
                end
                clickUi({"skip", "close", "ok", "bye", "leave", "fechar", "sair", "pular"}, true)
                task.wait(0.15)
                for _, f in ipairs(visibleDialogues()) do
                    pcall(function() f.Visible = false end)
                end
                DLG.closed = DLG.closed + 1
                Atk.hp = nil
                Atk.forceUntil = 0
            end
            -- se a arma saiu da mao (o dialogo guarda a ferramenta), equipa de novo
            local c = lp.Character
            local tool = c and c:FindFirstChildOfClass("Tool")
            if not tool or tool.ToolTip ~= Config.weapon then pcall(equipWeapon) end
        end
    end
end)
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
    -- Nome EXATO primeiro ("Bandit" nao pode pegar "Desert Bandit", que e outra ilha).
    local want = norm(mob)
    for _, p in ipairs(es:GetChildren()) do
        if p:IsA("BasePart") and norm(p.Name) == want then table.insert(out, p) end
    end
    if #out == 0 then
        for _, p in ipairs(es:GetChildren()) do
            if p:IsA("BasePart") and string.sub(norm(p.Name), 1, #want) == want then table.insert(out, p) end
        end
    end
    if #out == 0 and #want >= 4 then
        -- ultimo recurso: nome contem o do mob (so quando nada exato/prefixo existe)
        for _, p in ipairs(es:GetChildren()) do
            if p:IsA("BasePart") and string.find(norm(p.Name), want, 1, true) then table.insert(out, p) end
        end
    end
    return out
end

local function isSubName(n) return string.find(string.lower(tostring(n)), "submerged", 1, true) ~= nil end

-- escolhe a quest de maior level liberada para o seu level/mar (nao exige spawns carregados)
local mobsOf
local function chooseQuest(level, filter)
    local Q = loadQuests()
    if not Q then return nil, "modulo de quests nao carregou" end
    detectSea()
    local cands = {}
    for qn, list in pairs(Q) do
        if type(list) == "table" then
            for idx, q in pairs(list) do
                if type(q) == "table" and type(q.LevelReq) == "number" and q.LevelReq <= level and type(q.Task) == "table" then
                    local req = q.LevelReq
                    local okSea = true
                    if SEA == 1 and req >= 700 then okSea = false end
                    if SEA == 2 and (req < 700 or req >= 1500) then okSea = false end
                    if SEA == 3 and req < 1500 then okSea = false end
                    local tasks = {}
                    for m, c in pairs(q.Task) do
                        if type(c) == "number" and c > 1 then
                            tasks[#tasks + 1] = {mob = tostring(m), count = c}
                        end
                    end
                    table.sort(tasks, function(a, b) return norm(a.mob) < norm(b.mob) end)
                    local chosenTask
                    for _, taskInfo in ipairs(tasks) do
                        if not filter or filter(norm(taskInfo.mob)) then
                            chosenTask = taskInfo
                            break
                        end
                    end
                    if okSea and chosenTask then
                        table.insert(cands, {name = qn, idx = idx, req = req, mob = chosenTask.mob})
                    end
                end
            end
        end
    end
    table.sort(cands, function(a, b) return a.req > b.req end)
    local me = root()
    local topReq, picked, pickedD
    for _, c in ipairs(cands) do
        if topReq and c.req < topReq then break end
        local sp = spawnsFor(c.mob)
        if #sp > 0 or #mobsOf(c.mob) > 0 or (SEA == 3 and isSubName(c.name)) then
            topReq = c.req
            local nd = 0
            if me and #sp > 0 then
                nd = math.huge
                for _, part in ipairs(sp) do
                    local d = (part.Position - me.Position).Magnitude
                    if d < nd then nd = d end
                end
            end
            if not pickedD or nd < pickedD then picked, pickedD = c, nd end
        end
    end
    if picked then return picked end
    if #cands > 0 then return cands[1] end
    return nil, "nenhuma quest para o seu level neste mar"
end

local function npcPartOf(n)
    return n:FindFirstChild("HumanoidRootPart") or n.PrimaryPart or n:FindFirstChildWhichIsA("BasePart", true)
end
-- NPC da quest perto de um ponto (so NPCs ate 700 studs dali)
local function findQuestNPC(center, maxRadius, loose)
    if not center then return nil end
    maxRadius = maxRadius or 700
    local en = workspace:FindFirstChild("Enemies")
    local best, bd
    local function consider(model)
        if not model:IsA("Model") then return end
        if en and model:IsDescendantOf(en) then return end
        if Players:GetPlayerFromCharacter(model) then return end
        local part = npcPartOf(model)
        if not part then return end
        local ln = norm(model.Name)
        local hasQuestMarker = model:FindFirstChild("QuestBBG", true) ~= nil
            or string.find(ln, "quest", 1, true) ~= nil
        -- Nao escolher um NPC aleatorio da ilha como se fosse o quest giver.
        if not hasQuestMarker and not (loose and model:FindFirstChildOfClass("Humanoid")) then return end
        local d = (part.Position - center).Magnitude
        if d > maxRadius then return end
        local score = d
        if model:FindFirstChild("QuestBBG", true) then score = score - 300 end
        if string.find(ln, "submarine", 1, true) then score = score + 2000 end
        if not bd or score < bd then best, bd = part, score end
    end
    local npcs = workspace:FindFirstChild("NPCs")
    if npcs then
        for _, n in ipairs(npcs:GetChildren()) do consider(n) end
    end
    if not best then
        local ok, parts = pcall(function() return workspace:GetPartBoundsInRadius(center, math.min(maxRadius, 1000), OverlapParams.new()) end)
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
    return best
end

local function questFrameVisible()
    local m = mainGui()
    local qf = m and m:FindFirstChild("Quest")
    return qf ~= nil and qf:IsA("GuiObject") and qf.Visible
end
local function questShows(mob)
    local pg = lp:FindFirstChild("PlayerGui")
    if not pg then return false end
    local wanted = norm(mob)
    if wanted == "" then return false end
    for _, d in ipairs(pg:GetDescendants()) do
        if d:IsA("TextLabel") and d.Text ~= "" and not d:IsDescendantOf(gui) and chainVisible(d, pg) then
            local shown = norm(d.Text)
            if string.find(shown, wanted, 1, true) then return true end
        end
    end
    return false
end
-- Le o progresso "x/y" mostrado na quest do mob (nil se nao achar).
local function questProgress(mob)
    local pg = lp:FindFirstChild("PlayerGui")
    local wanted = norm(mob)
    if not pg or wanted == "" then return nil end
    for _, d in ipairs(pg:GetDescendants()) do
        if d:IsA("TextLabel") and d.Text ~= "" and not d:IsDescendantOf(gui) and chainVisible(d, pg) then
            if string.find(norm(d.Text), wanted, 1, true) then
                local c, t = string.match(d.Text, "(%d+)%s*/%s*(%d+)")
                if c and t then return tonumber(c), tonumber(t) end
            end
        end
    end
    return nil
end
-- Quest NOVA aceita: o contador mostra x/y com x < y (nao confunde com o texto da quest antiga ja completa).
local function questFresh(mob)
    local c, t = questProgress(mob)
    if c and t then return c < t end
    return questFrameVisible() and questShows(mob)
end
-- A quest so conta como ativa quando o objetivo exibido corresponde ao mob esperado.
local function questActive(mob) return questShows(mob) end

function mobsOf(name)
    local out = {}
    local en = workspace:FindFirstChild("Enemies")
    if not en then return out end
    local wanted = norm(name)
    if wanted == "" then return out end
    for _, e in ipairs(en:GetChildren()) do
        local enemyName = norm(e.Name)
        -- Prefixo completo evita confundir nomes parecidos/contendo a mesma palavra.
        if string.sub(enemyName, 1, #wanted) == wanted then
            local h = e:FindFirstChildOfClass("Humanoid")
            local p = e:FindFirstChild("HumanoidRootPart")
            if h and p and h.Health > 0 then table.insert(out, {m = e, h = h, p = p}) end
        end
    end
    return out
end

-- BRING MOB: puxa os mobs da quest para debaixo de voce (no ponto onde o farm te deixa). O alvo acompanha o
-- seu personagem, entao o farm nao precisa correr atras deles. Roda a cada frame num laco proprio (nao mexe no
-- seu personagem), entao nao atrapalha o Fast Attack.
do
local warned = false
keep(RS.Heartbeat:Connect(function()
    if Stopped or not Config.bringMob or not Running or not ActiveCombatMob then return end
    local r = root()
    if not r then return end
    if not sethiddenproperty and not warned then
        warned = true
        pcall(function()
            StarterGui:SetCore("SendNotification", {Title = NAME, Text = "Bring Mob: seu executor nao tem sethiddenproperty, os mobs podem nao seguir.", Duration = 6})
        end)
    end
    pcall(function()
        if sethiddenproperty then
            sethiddenproperty(lp, "SimulationRadius", 1e9)
            sethiddenproperty(lp, "MaxSimulationRadius", 1e9)
        end
    end)
    -- ponto de reuniao: exatamente onde o farm deixa o mob em relacao a voce
    local target
    if Config.posMethod == "Below" then
        target = r.Position + Vector3.new(0, Config.farmDist, 0)
    elseif Config.posMethod == "Behind" then
        target = r.Position - Vector3.new(0, 3, Config.farmDist)
    else
        target = r.Position - Vector3.new(0, Config.farmDist, 0)
    end
    -- so os N mobs mais proximos (N = "Quantos mobs puxar")
    local list = mobsOf(ActiveCombatMob)
    table.sort(list, function(a, b)
        return (a.p.Position - r.Position).Magnitude < (b.p.Position - r.Position).Magnitude
    end)
    local limit = math.max(1, math.floor(Config.bringCount))
    for i, e in ipairs(list) do
        if i > limit then break end
        local dMe = (e.p.Position - r.Position).Magnitude
        if dMe <= Config.bringDist and (e.p.Position - target).Magnitude > 4 then
            pcall(function()
                e.p.CanCollide = false
                e.p.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                e.p.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                e.p.CFrame = CFrame.new(target) * (e.p.CFrame - e.p.CFrame.Position)
                e.h.WalkSpeed = 0
                e.h.JumpPower = 0
            end)
        end
    end
end))
end

-- Ilha Submersa: Tiki Outpost -> Submarine Worker -> viagem
local function nearSubmerged()
    local r = root()
    if not r then return false end
    local npcs = workspace:FindFirstChild("NPCs")
    if npcs then
        for _, m in ipairs(npcs:GetChildren()) do
            if m:IsA("Model") and isSubName(m.Name) then
                local p = npcPartOf(m)
                if p and (p.Position - r.Position).Magnitude < 1500 then return true end
            end
        end
    end
    return false
end
local enterSubmerged
do
local subFailUntil, subFailMsg = 0, ""
function enterSubmerged(alive, setS)
    if nearSubmerged() then return true end
    if os.clock() < subFailUntil then
        setS(subFailMsg)
        task.wait(2)
        return false
    end
    local npc = approachNPC({"submarineworker"}, {"tiki"}, alive, setS, "o Submarine Worker")
    if not npc then
        subFailUntil, subFailMsg = os.clock() + 15, "nao achei o Submarine Worker (Sub Port, Tiki Outpost)"
        return false
    end
    setS("falando com o Submarine Worker...")
    local r = root()
    local before = r and r.Position
    local function moved()
        local rr = root()
        return rr ~= nil and before ~= nil and (rr.Position - before).Magnitude > 1500
    end
    local rf = getNet("RF/SubmarineWorkerSpeak")
    if rf then pcall(function() rf:InvokeServer("TravelToSubmergedIsland") end) end
    task.wait(2.5)
    if moved() then return true end
    invoke("SubmarineWorkerSpeak", "TravelToSubmergedIsland")
    task.wait(2.5)
    if moved() then return true end
    local model = npc:FindFirstAncestorOfClass("Model")
    for _ = 1, 3 do
        firePrompts(model)
        task.wait(1)
        clickUi({"yes", "sim"}, true)
        task.wait(1)
        clickUi({"yes", "sim"}, true)
        task.wait(2.5)
        if moved() then return true end
    end
    subFailUntil, subFailMsg = os.clock() + 20, "nao consegui entrar na ilha (precisa ter derrotado o Tyrant of the Skies)"
    setS(subFailMsg)
    return false
end
end

-- puxa os mobs ate o ponto alvo (precisa de sethiddenproperty)
local function flyStaged(pos, alive, up)
    local r = root()
    if not r then return false end
    local dir = pos - r.Position
    if dir.Magnitude < 2 then return true end
    local stepLen = math.min(dir.Magnitude, 700)
    local tgt = r.Position + dir.Unit * stepLen
    return moveTo(CFrame.new(tgt.X, (dir.Magnitude > 700) and (pos.Y + (up or 60)) or pos.Y, tgt.Z), Config.tweenSpeed, alive)
end

-- mata os mobs da quest: junta todos num ponto e ataca rapido
local function killQuestMobs(q, st, spec, lvl, alive, setS)
    ActiveCombatMob = nil
    local r = root()
    if not r then return end
    local list = mobsOf(q.mob)
    if #list == 0 then
        if isSubName(q.name) and not nearSubmerged() then
            if enterSubmerged(alive, setS) then task.wait(2) end
            return
        end
        local spawns = spawnsFor(q.mob)
        local target
        if #spawns > 0 then
            local sd
            for _, p in ipairs(spawns) do
                local d = (p.Position - r.Position).Magnitude
                if not sd or d < sd then target, sd = p.Position, d end
            end
        elseif spec.loc then
            for _, k in ipairs(spec.loc) do target = target or locationPos(k) end
        end
        if not target then
            setS("nenhum spawn de " .. q.mob .. " encontrado neste mar")
            task.wait(2)
            return
        end
        -- ilha que so se entra por redemoinho (Underwater City): atravessa antes de voar
        if not ensureRegion(target, alive, setS) then
            task.wait(0.1)
            return
        end
        r = root()
        if not r then return end
        local d = (target - r.Position).Magnitude
        setS("indo ate " .. q.mob .. " (" .. math.floor(d) .. " studs)")
        if d > 800 then
            flyStaged(target, alive, 60)
        else
            moveTo(CFrame.new(hoverPos(target, 12)), Config.tweenSpeed, alive)
        end
        task.wait(0.1)
        return
    end

    -- Enquanto esta quest esta sendo executada, todos os metodos de ataque
    -- recebem somente inimigos com o nome do objetivo atual.
    ActiveCombatMob = q.mob
    local near, nd
    for _, e in ipairs(list) do
        local d = (e.p.Position - r.Position).Magnitude
        if not nd or d < nd then near, nd = e, d end
    end
    local anchor = near.p.Position
    equipWeapon()
    if nd > 40 then
        setS("indo ate " .. q.mob)
        moveTo(CFrame.new(hoverPos(anchor, farmHover())), Config.tweenSpeed, alive)
    end
    local t0 = os.clock()
    local lastQ = os.clock()
    while alive() and os.clock() - t0 < 25 do
        if spec.useQuest and os.clock() - lastQ > 0.15 then
            lastQ = os.clock()
            local cur_, tot_ = questProgress(q.mob)
            local done_ = cur_ and tot_ and cur_ >= tot_ and os.clock() - t0 > 0.5
            if (cur_ == nil and not questActive(q.mob)) or done_ then
                -- missao acabou: marca para pegar a missao de novo (mesmo se o texto antigo ainda estiver na tela)
                if st then st.needQuest = true end
                break
            end
        end
        local cur = mobsOf(q.mob)
        if #cur == 0 then break end
        local main_ = cur[1]
        do
            local rr = root()
            local bd
            for _, e in ipairs(cur) do
                local d = rr and (e.p.Position - rr.Position).Magnitude or 0
                if not bd or d < bd then main_, bd = e, d end
            end
            anchor = main_.p.Position
        end
        setS("Lv " .. lvl .. " | " .. q.name .. " (req " .. q.req .. ") | " .. #cur .. "x " .. q.mob .. " | " .. atkInfo())
        if not stickTo(hoverPos(anchor, farmHover()), anchor, alive) then break end
        attackNow()
        watchDamage(main_.h)
        task.wait(Config.orionClick and 0.01 or Config.atkDelay)
    end
    ActiveCombatMob = nil
end

local QS = {}
table.insert(Sched.cleanups, function(key) QS[key] = nil end)
-- um "passo" do farm por quest (o agendador chama em loop)
local function questStep(key, spec, alive, setS)
    local st = QS[key]
    if not st then
        st = {lastLevel = -1, assumeUntil = 0, abandoned = false}
        QS[key] = st
    end
    if spec.pre and spec.pre(alive, setS) then return end
    local lvl = getLevel()
    if lvl ~= st.lastLevel or not st.q then
        st.lastLevel = lvl
        local reason
        local newq
        newq, reason = chooseQuest(lvl, spec.filter)
        -- Nunca volta para uma quest de nivel menor (ex.: ilha inicial) se a atual ainda vale para o seu level.
        if newq and st.q and newq.req < st.q.req and st.q.req <= lvl then newq = st.q end
        if not (newq and st.q and newq.name == st.q.name and newq.idx == st.q.idx) then st.abandoned = false end
        st.q = newq or st.q
        if not newq and not st.q then
            setS("sem quest: " .. tostring(reason))
            task.wait(3)
            return
        end
    end
    local q = st.q

    if spec.useQuest then
        if questFrameVisible() and not questShows(q.mob) then
            setS("a quest ativa e de outro mob; abandonando antes de continuar")
            invoke("AbandonQuest")
            st.assumeUntil = 0
            st.abandoned = true
            task.wait(1.2)
            return
        end
        if st.needQuest or not questActive(q.mob) then
            if isSubName(q.name) and not nearSubmerged() then
                if not enterSubmerged(alive, setS) then task.wait(2) return end
                task.wait(2)
            end
            -- ACEITE RAPIDO: tenta pegar a proxima quest direto pelo comando do jogo (sem voltar ao NPC)
            local quick = false
            if not st.noRemote and not isSubName(q.name) then
                setS("Lv " .. lvl .. ": pegando a proxima quest (" .. q.mob .. ")")
                invoke("StartQuest", q.name, q.idx)
                for _ = 1, 15 do
                    task.wait(0.08)
                    if questFresh(q.mob) then quick = true break end
                end
                if quick then
                    st.needQuest = false
                    st.quickFail = 0
                else
                    st.quickFail = (st.quickFail or 0) + 1
                    if st.quickFail >= 2 then st.noRemote = true end
                end
            end
            if not quick then
            local spawns = spawnsFor(q.mob)
            local center
            if #spawns > 0 then
                local me0 = root()
                local base, bd0 = spawns[1].Position, math.huge
                for _, p in ipairs(spawns) do
                    local d = me0 and (p.Position - me0.Position).Magnitude or 0
                    if d < bd0 then base, bd0 = p.Position, d end
                end
                local sum, n = Vector3.new(0, 0, 0), 0
                for _, p in ipairs(spawns) do
                    if (p.Position - base).Magnitude <= 400 then sum = sum + p.Position n = n + 1 end
                end
                center = sum / math.max(n, 1)
            elseif spec.loc then
                for _, k in ipairs(spec.loc) do center = center or locationPos(k) end
            end
            if not center then
                -- sem spawn cadastrado: usa a posicao de um mob vivo desse tipo
                local live = mobsOf(q.mob)
                if live[1] then center = live[1].p.Position end
            end
            local arrived = false
            st.npcPos = st.npcPos or {}
            local npcKey = q.name .. ":" .. tostring(q.idx)
            if st.npcPos[npcKey] then center = st.npcPos[npcKey] end
            for step = 1, 40 do
                if not alive() then return end
                local r = root()
                if not r or not center then break end
                -- Underwater City etc.: passa pelo redemoinho antes de procurar o NPC
                if ensureRegion(center, alive, setS) then
                    r = root()
                    if not r then break end
                    local npc = st.npcPos[npcKey] and {Position = st.npcPos[npcKey]}
                        or findQuestNPC(center, step > 3 and 900 or 700)
                        or (step > 2 and findQuestNPC(center, 900, true) or nil)
                    if npc then
                        setS("Lv " .. lvl .. ": indo ao NPC da quest " .. q.name .. " (" .. q.mob .. ")")
                        moveTo(CFrame.new(npc.Position + Vector3.new(0, 3, 4)), Config.tweenSpeed, alive)
                        r = root()
                        if r and (r.Position - npc.Position).Magnitude < 25 then
                            arrived = true
                            st.lastNpcPos = npc.Position
                            break
                        end
                    else
                        local d = (r.Position - center).Magnitude
                        setS("Lv " .. lvl .. " | quest " .. q.name .. " (" .. q.mob .. ") | spawns: " .. #spawns .. " | faltam " .. math.floor(d) .. " studs")
                        if d < 60 then
                            task.wait(1.0)
                            if step > 4 then
                                -- chegou na area e nenhum NPC apareceu: tenta pegar a quest assim mesmo
                                arrived = true
                                st.lastNpcPos = nil
                                break
                            end
                        elseif d > 1500 and not isSubName(q.name) then
                            flyStaged(center, alive, 60)
                        else
                            moveTo(CFrame.new(center.X, center.Y + 4, center.Z), Config.tweenSpeed, alive)
                            task.wait(1)
                        end
                    end
                end
            end
            if not alive() then return end
            if not arrived then
                setS("nao consegui chegar ao NPC correto; nao vou iniciar uma quest no escuro")
                task.wait(1.5)
                return
            end
            invoke("StartQuest", q.name, q.idx)
            st.needQuest = false
            local confirmed = false
            setS("Lv " .. lvl .. ": quest " .. q.name .. " enviada, aguardando confirmacao...")
            for _ = 1, 40 do
                task.wait(0.08)
                if questFrameVisible() or questActive(q.mob) then confirmed = true break end
            end
            if confirmed then
                -- so guarda a posicao do NPC depois que a quest foi realmente aceita
                st.npcPos[npcKey] = st.lastNpcPos
            else
                st.npcPos[npcKey] = nil -- NPC errado/sem resposta: descarta o cache e procura de novo
                setS("nao confirmei a quest de " .. q.mob .. "; tentando novamente")
                st.assumeUntil = 0
                task.wait(0.3)
                return
            end
            end
        end
    end
    if not alive() then return end
    killQuestMobs(q, st, spec, lvl, alive, setS)
end

local alwaysTrue
do
local BONES_MOBS = {rebornskeleton = true, livingzombie = true, demonicsoul = true, posessedmummy = true, possessedmummy = true}
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
        invoke("CakePrinceSpawner")
        invoke("CakePrinceSpawner", true)
    end
    return false
end

alwaysTrue = function() return true end
regFeature("farm", 60, alwaysTrue, function(alive, setS)
    questStep("farm", {useQuest = true}, alive, setS)
end)
regFeature("bones", 60, alwaysTrue, function(alive, setS)
    questStep("bones", {useQuest = true, loc = {"haunted"}, filter = function(n) return BONES_MOBS[n] == true end}, alive, setS)
end)
regFeature("cake", 60, alwaysTrue, function(alive, setS)
    questStep("cake", {useQuest = false, loc = {"cakeland", "cake"}, pre = cakeBossStep,
        filter = function(n) return CAKE_MOBS[n] == true end}, alive, setS)
end)
regFeature("cakeQuest", 60, alwaysTrue, function(alive, setS)
    questStep("cakeQuest", {useQuest = true, loc = {"cakeland", "cake"},
        filter = function(n) return CAKE_MOBS[n] == true end}, alive, setS)
end)

end

--==================== BOSSES (Multi Farm) ====================
-- boss no mapa -> ataca; boss "estacionado" no ReplicatedStorage -> voa ate ele e espera
local function bossStep(names, label, alive, setS)
    local list = targetsByNames(names, {"Enemies"})
    if #list > 0 then
        local best, bd = nearestOf(list)
        local hp = best.hum and math.floor(best.hum.Health) or "?"
        local warn = ""
        if best.hum and Atk.hp == best.hum and os.clock() - Atk.lastDmg > 8 then
            warn = " | SEM DANO ha " .. math.floor(os.clock() - Atk.lastDmg) .. "s (ele pode estar invulneravel: faca os puzzles da quest antes)"
        end
        setS(label .. " encontrado (" .. math.floor(bd or 0) .. "m) | HP " .. hp .. " | " .. atkInfo() .. warn)
        -- boss forte: fica mais alto (o Moon alcanca 60 studs) e nunca cola nele, menos o Saber Expert
        local hov = math.max(Config.bossHeight, 28)
        local close = (label == "Saber Expert")
        if close then hov = Config.bossHeight end
        engage(best, alive, hov, Config.bossSkills, Config.tweenSpeed, 6, not close, setS)
        return true
    end
    for _, m in ipairs(RepS:GetChildren()) do
        if m:IsA("Model") then
            local n = norm(m.Name)
            for _, pat in ipairs(names) do
                if string.find(n, pat, 1, true) then
                    local part = partOf(m)
                    if part and part.Position.Magnitude > 100 then
                        local r = root()
                        local d = r and (r.Position - part.Position).Magnitude or 0
                        if d > 150 then
                            setS("indo ate " .. m.Name .. " (" .. math.floor(d) .. " studs)")
                            flyStaged(part.Position + Vector3.new(0, 60, 0), alive, 60)
                        else
                            setS("perto de " .. m.Name .. ", aguardando ele aparecer...")
                            task.wait(1.5)
                        end
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- Elite Hunter: vai ao Castle on the Sea, fala com o NPC, pega a quest e vai ate o boss
local lastEliteAsk = 0
local function eliteStep(alive, setS)
    detectSea()
    if SEA ~= 3 then setS("Elite Hunter so existe no Sea 3") task.wait(2) return end
    if bossStep({"diablo", "urban", "deandre"}, "Elite", alive, setS) then return end
    if os.clock() - lastEliteAsk < 12 then
        setS("aguardando o elite spawnar...")
        task.wait(1.5)
        return
    end
    local npc = approachNPC({"elitehunter"}, {"castleonthesea", "castle"}, alive, setS, "o Elite Hunter")
    if not npc or not alive() then return end
    setS("falando com o Elite Hunter...")
    lastEliteAsk = os.clock()
    invoke("EliteHunter")
    firePrompts(npc:FindFirstAncestorOfClass("Model"))
    task.wait(1.5)
    clickUi({"yes", "sim", "accept", "aceitar"}, true)
    task.wait(2.5)
end
regFeature("elite", 55, alwaysTrue, eliteStep)

local function bossFeature(key, names, label)
    regFeature(key, 20, function() return #targetsByNames(names, {"Enemies"}) > 0 end, function(alive, setS)
        local list = targetsByNames(names, {"Enemies"})
        if #list == 0 then return end
        local best, bd = nearestOf(list)
        setS(label .. " (" .. math.floor(bd or 0) .. "m) | " .. atkInfo())
        engage(best, alive, Config.bossHeight, Config.bossSkills, Config.tweenSpeed, 40)
    end)
end
bossFeature("killIndra", {"ripindra"}, "Rip Indra")
bossFeature("killReaper", {"soulreaper"}, "Soul Reaper")
bossFeature("killBeard", {"darkbeard"}, "Barba Negra")

-- AUTO FACTORY (Sea 2): quando o evento da Fabrica aparece, ataca o Core ate destruir
do
    local function coreTargets()
        local out = {}
        local en = workspace:FindFirstChild("Enemies")
        if en then
            for _, m in ipairs(en:GetChildren()) do
                if norm(m.Name) == "core" then
                    local h = m:FindFirstChildOfClass("Humanoid")
                    local part = partOf(m)
                    if part and (not h or h.Health > 0) then table.insert(out, {mdl = m, part = part, hum = h}) end
                end
            end
        end
        return out
    end
    regFeature("factory", 21, function()
        detectSea()
        return SEA == 2 and #coreTargets() > 0
    end, function(alive, setS)
        local list = coreTargets()
        if #list == 0 then return end
        local best, bd = nearestOf(list)
        setS("Fabrica: atacando o Core (" .. math.floor(bd or 0) .. "m) | " .. atkInfo())
        engage(best, alive, math.max(Config.bossHeight, 8), false, Config.tweenSpeed, 8)
    end)
end

-- invocar bosses / pads (uma vez e desliga)
local findTool, equipTool
do
function findTool(subs)
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
function equipTool(t)
    local h = hum()
    if h and t then pcall(function() h:EquipTool(t) end) end
end
local function interactNear(center, radius, patterns)
    local ok, parts = pcall(function() return workspace:GetPartBoundsInRadius(center, radius, OverlapParams.new()) end)
    if not ok or not parts then return 0 end
    local count, seen = 0, {}
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
local function summonFeature(key, o)
    regFeature(key, 30, function() return Config[key] end, function(alive, setS)
        detectSea()
        if o.sea and SEA ~= o.sea then setS("so funciona no Sea " .. o.sea) uiSet(key, false) return end
        local item = findTool(o.item)
        if not item then setS("voce nao tem o item: " .. o.itemName) uiSet(key, false) return end
        local pos
        for _, sub in ipairs(o.loc) do pos = pos or locationPos(sub) end
        if not pos then setS("nao achei " .. o.place .. " na lista de ilhas") uiSet(key, false) return end
        setS("indo para " .. o.place .. "...")
        if not moveTo(CFrame.new(pos + Vector3.new(0, 70, 0)), Config.tpSpeed, alive) then return end
        task.wait(1)
        equipTool(item)
        task.wait(0.5)
        local n = interactNear(pos, o.radius or 400, o.patterns)
        setS(n > 0 and ("acionei " .. n .. " objeto(s). Se o boss nao apareceu: " .. o.hint) or ("nao achei o local de invocar. " .. o.hint))
        uiSet(key, false)
    end)
end
summonFeature("sumIndra", {sea = 3, item = {"godschalice"}, itemName = "God's Chalice", loc = {"castleonthesea", "castle"},
    place = "o Castle on the Sea", patterns = {"pedestal", "chalice", "summon", "altar", "indra"},
    hint = "confira se os 3 botoes de Aura estao ativos."})
summonFeature("sumReaper", {sea = 3, item = {"hallowessence"}, itemName = "Hallow Essence", loc = {"hauntedcastle", "haunted"},
    place = "o Haunted Castle", patterns = {"altar", "summon", "hallow", "pedestal"}, hint = "o altar fica perto do mausoleu."})
summonFeature("sumBeard", {sea = 2, item = {"fistofdarkness"}, itemName = "Fist of Darkness", loc = {"darkarena", "dark"},
    place = "a Dark Arena", patterns = {"pedestal", "altar", "summon", "fist"}, hint = "o pedestal fica no meio da arena."})
regFeature("pads", 30, function() return Config.pads end, function(alive, setS)
    detectSea()
    if SEA ~= 3 then setS("so funciona no Sea 3") uiSet("pads", false) return end
    local pos = locationPos("castleonthesea") or locationPos("castle")
    if not pos then setS("nao achei o Castle on the Sea") uiSet("pads", false) return end
    setS("indo ao Castle on the Sea...")
    if not moveTo(CFrame.new(pos + Vector3.new(0, 70, 0)), Config.tpSpeed, alive) then return end
    task.wait(1)
    local n = interactNear(pos, 600, {"pad", "button", "haki", "aura", "plate"})
    setS("toquei em " .. n .. " pad(s). Cada pad precisa da cor de Aura correta.")
    uiSet("pads", false)
end)

end

regFeature("hopBeard", 65, alwaysTrue, function(alive, setS)
    if bossStep({"darkbeard"}, "Barba Negra", alive, setS) then return end
    for i = Config.hopDelay, 1, -1 do
        if not alive() then return end
        if #targetsByNames({"darkbeard"}, {"Enemies"}) > 0 then return end
        setS("Barba Negra nao esta aqui, trocando de servidor em " .. i .. "s")
        task.wait(1)
    end
    if alive() then serverHop(function(t) setS(t) end) end
    task.wait(10)
end)

--==================== SEA EVENTS ====================
local SEA_EVENTS
do
SEA_EVENTS = {
    {key = "sLev", label = "Kill Leviathan", names = {"leviathan"}},
    {key = "sLevSeg", label = "Kill Leviathan (segmentos)", names = {"leviathan"}, segments = true},
    {key = "sBeast", label = "Kill Sea Beast", names = {"seabeast"}},
    {key = "sShark", label = "Kill Terrorshark", names = {"terrorshark"}},
    {key = "sPiranha", label = "Kill Piranha", names = {"piranha"}},
    {key = "sFish", label = "Kill Fish Crew", names = {"fishcrew"}},
    {key = "sGhost", label = "Kill Haunted Shipwreck (Ghost Ship)",
        names = {"hauntedcrew", "ghostshark", "shipdeckhand", "shipengineer", "shipsteward", "shipofficer", "cursedcaptain"}},
}
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
                            local part = partOf(d)
                            local h = d:FindFirstChildOfClass("Humanoid")
                            if part and (not h or h.Health > 0) then table.insert(segs, {mdl = d, part = part, hum = h}) end
                        end
                    end
                end
            end
        end
    end
    if #segs > 0 then return segs end
    return all
end
local function seaTargets()
    local list = {}
    for _, ev in ipairs(SEA_EVENTS) do
        if Config[ev.key] then
            local found
            if ev.segments then found = leviathanTargets() else found = targetsByNames(ev.names) end
            for _, t in ipairs(found) do
                t.ev = ev.label
                table.insert(list, t)
            end
        end
    end
    return list
end
regFeature("sea", 25, function() return #seaTargets() > 0 end, function(alive, setS)
    local list = seaTargets()
    if #list == 0 then return end
    local best, bd = nearestOf(list)
    setS(best.ev .. " (" .. math.floor(bd or 0) .. "m) | " .. atkInfo())
    engage(best, alive, Config.seaHeight, Config.seaSkills, Config.seaSpeed, 30)
end, function()
    for _, ev in ipairs(SEA_EVENTS) do
        if Config[ev.key] then return true end
    end
    return false
end)

end

-- AUTO BOAT: vai ate o vendedor de barcos, compra o barco (repete ate aparecer), senta e navega pelo mar.
-- Quando aparece um monstro marcado em "Eventos", o barco para (a funcao "sea" tem prioridade maior),
-- voce sai do barco e mata com fast attack; depois o barco volta a navegar sozinho.
do
    local function boatSeat(b)
        return b:FindFirstChildWhichIsA("VehicleSeat", true) or b:FindFirstChildWhichIsA("Seat", true)
    end
    local function ownerState(b)
        local owner = b:FindFirstChild("Owner")
        if not owner then return "unknown" end
        local ok, v = pcall(function() return owner.Value end)
        if not ok then return "unknown" end
        if v == lp or v == lp.Name or v == lp.UserId or v == tostring(lp.UserId) then return "mine" end
        if v == nil or v == "" then return "unknown" end
        return "other"
    end
    local function myBoat()
        local bf = workspace:FindFirstChild("Boats")
        if not bf then return nil end
        local r = root()
        local fallback, fd
        for _, b in ipairs(bf:GetChildren()) do
            if b:IsA("Model") and boatSeat(b) then
                local st = ownerState(b)
                if st == "mine" then return b end
                if st == "unknown" and r then
                    local d = (b:GetPivot().Position - r.Position).Magnitude
                    if d < 120 and (not fd or d < fd) then fallback, fd = b, d end
                end
            end
        end
        return fallback
    end
    local function sitBoat(b)
        local seat = boatSeat(b)
        local h = hum()
        if not seat or not h then return false end
        for _ = 1, 4 do
            if h.SeatPart == seat then return true end
            local r = root()
            if not r then return false end
            r.CFrame = seat.CFrame * CFrame.new(0, 2.5, 0)
            pcall(function() seat:Sit(h) end)
            task.wait(0.5)
        end
        return h.SeatPart == seat
    end
    local function moveBoat(b, target, speed, alive)
        local seat = boatSeat(b)
        if not seat then return false end
        local start = b:GetPivot().Position
        local goal = Vector3.new(target.X, start.Y, target.Z)
        local dist = (goal - start).Magnitude
        if dist < 5 then return true end
        local look = CFrame.lookAt(start, goal)
        local rot = look - look.Position
        local duration = dist / math.max(speed, 20)
        local t0 = os.clock()
        local finished, cancelled = false, false
        local conn
        conn = RS.Heartbeat:Connect(function()
            local hh = hum()
            if Stopped or not b.Parent or (alive and not alive()) or not hh or hh.SeatPart ~= seat or os.clock() - t0 > duration + 5 then
                cancelled = true
                conn:Disconnect()
                return
            end
            local a = math.min((os.clock() - t0) / duration, 1)
            pcall(function()
                b:PivotTo(CFrame.new(start:Lerp(goal, a)) * rot)
                seat.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end)
            if a >= 1 then
                finished = true
                conn:Disconnect()
            end
        end)
        while not finished and not cancelled do task.wait() end
        return finished
    end
    local function landAt(pos)
        local ignore = {}
        if lp.Character then table.insert(ignore, lp.Character) end
        local bf = workspace:FindFirstChild("Boats")
        if bf then table.insert(ignore, bf) end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = ignore
        params.IgnoreWater = true
        local ok, hit = pcall(function()
            return workspace:Raycast(pos + Vector3.new(0, 2500, 0), Vector3.new(0, -5000, 0), params)
        end)
        return ok and hit ~= nil and hit.Position.Y > -60
    end
    local function pickWaypoint(b)
        local p = b:GetPivot().Position
        for _ = 1, 12 do
            local ang = math.random() * math.pi * 2
            local dist = math.random(1200, 2600)
            local tgt = p + Vector3.new(math.cos(ang) * dist, 0, math.sin(ang) * dist)
            local clear = true
            for i = 1, 8 do
                if landAt(p:Lerp(tgt, i / 8)) then clear = false break end
            end
            if clear then return tgt end
        end
        return nil
    end
    local BOAT = {wp = nil}
    table.insert(Sched.cleanups, function(key)
        if key == "autoBoat" then
            BOAT.wp = nil
            local h = hum()
            if h and h.SeatPart then h.Sit = false end
        end
    end)
    regFeature("autoBoat", 65, alwaysTrue, function(alive, setS)
        local b = myBoat()
        if b and b.Parent then
            if not sitBoat(b) then setS("nao consegui sentar no barco, tentando de novo") task.wait(1.5) return end
            if not BOAT.wp then BOAT.wp = pickWaypoint(b) end
            if not BOAT.wp then setS("sem rota livre de ilhas; aguardando") task.wait(2) return end
            local p = b:GetPivot().Position
            setS("navegando ate a proxima rota (" .. math.floor((BOAT.wp - p).Magnitude) .. "m) | esperando monstros do mar")
            if moveBoat(b, BOAT.wp, Config.boatSpeed, alive) then BOAT.wp = nil end
            return
        end
        -- sem barco: vai ao vendedor e compra (repete ate o barco aparecer)
        leaveSeat()
        local npc = approachNPC({"boatdealer"}, {}, alive, setS, "o vendedor de barcos (Luxury Boat Dealer)")
        if not npc or not alive() then return end
        for i = 1, 5 do
            if not alive() then return end
            setS("comprando o barco " .. Config.boatType .. " (tentativa " .. i .. "/5)")
            invoke("BuyBoat", Config.boatType)
            task.wait(1.3)
            if myBoat() then break end
        end
    end)
end

--==================== FRUIT ====================
local fkey, fruitList, touch, ownedLabel, captureBase, refreshOwned, fruitTools, toolName
do
function fkey(s)
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
function fruitList()
    local out = {}
    for _, v in ipairs(workspace:GetChildren()) do
        -- "Fruit1", "Fruit 2"... (Sea 1) nao e fruta: e uma missao secreta
        local secret = string.match(string.lower(v.Name), "^fruit%s*%d+$") ~= nil
        if not secret and (v:IsA("Tool") or v:IsA("Model")) and string.find(v.Name, "Fruit") then
            local part = v:FindFirstChild("Handle") or v:FindFirstChildWhichIsA("BasePart", true)
            if part then table.insert(out, {obj = v, part = part, name = fruitName(v)}) end
        end
    end
    return out
end
function touch(part)
    local r = root()
    if r and firetouchinterest then
        pcall(function()
            firetouchinterest(r, part, 0)
            task.wait(0.05)
            firetouchinterest(r, part, 1)
        end)
    end
end

local FR = {inv = {}, base = {}, skipped = {}, tries = {}, inited = false, lastRefresh = 0, noneSince = nil}
local function isOwned(name)
    local k = fkey(name)
    return FR.inv[k] ~= nil or FR.base[k] ~= nil
end
local function updateOwnedLabel()
    if not ownedLabel then return end
    local names = {}
    for _, n in pairs(FR.inv) do table.insert(names, n) end
    for k, n in pairs(FR.base) do
        if not FR.inv[k] then table.insert(names, n) end
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
function toolName(t) return t:GetAttribute("OriginalName") or t.Name end
function fruitTools()
    local out = {}
    for _, cont in ipairs({lp.Backpack, lp.Character}) do
        if cont then
            for _, tool in ipairs(cont:GetChildren()) do
                if isFruitTool(tool) then table.insert(out, tool) end
            end
        end
    end
    return out
end
function captureBase()
    FR.base = {}
    for _, tool in ipairs(fruitTools()) do
        local nm = toolName(tool)
        FR.base[fkey(nm)] = tostring(nm)
    end
end
function refreshOwned()
    local inv = invoke("getInventory")
    if type(inv) == "table" then
        local newInv = {}
        for _, it in pairs(inv) do
            if type(it) == "table" and it.Name then
                local nm = tostring(it.Name)
                if it.Type == "Blox Fruit" or string.find(nm, "%-") then newInv[fkey(nm)] = nm end
            end
        end
        FR.inv = newInv
    end
    updateOwnedLabel()
end
local function storeAll(setS)
    local rem = getRem()
    if not rem then setS("remote de armazenar nao encontrado") return false end
    local did = false
    for _, tool in ipairs(fruitTools()) do
        local nm = toolName(tool)
        if not isOwned(nm) and (FR.tries[tool] or 0) < 3 then
            FR.tries[tool] = (FR.tries[tool] or 0) + 1
            setS("armazenando " .. tostring(nm))
            pcall(function() return rem:InvokeServer("StoreFruit", nm, tool) end)
            did = true
            task.wait(0.6)
        end
    end
    if did then refreshOwned() end
    return did
end
local function bestFruit()
    local r = root()
    if not r then return nil end
    local best, bd
    for _, f in ipairs(fruitList()) do
        local u = FR.skipped[f.obj]
        if not (u and u > os.clock()) and not isOwned(f.name) then
            local d = (f.part.Position - r.Position).Magnitude
            if not bd or d < bd then best, bd = f, d end
        end
    end
    return best, bd
end

table.insert(Sched.cleanups, function(key)
    if key == "fruit" or key == "hop" then
        FR.skipped, FR.tries, FR.noneSince = {}, {}, nil
        FR.lastRefresh = 0
    end
end)
local GRIND_KEYS = {"farm", "chest", "bones", "cake", "cakeQuest", "elite", "hopBeard", "bartilo", "citizen", "saber", "sea2Quest", "sea3Quest", "raceV2", "raceV3",
    "autoBoat", "swYama", "swTushita", "swHallow", "swCanvander", "swTrident", "swBuddy", "swDagger", "swTwin"}
local function anyGrind()
    for _, k in ipairs(GRIND_KEYS) do
        if Config[k] then return true end
    end
    return false
end
regFeature("fruit", 10, function()
    if bestFruit() then return true end
    if Config.hop and not anyGrind() then return true end
    return false
end, function(alive, setS)
    if not FR.inited then
        FR.inited = true
        setS("detectando suas frutas...")
        captureBase()
        refreshOwned()
    end
    if os.clock() - FR.lastRefresh > 30 then
        FR.lastRefresh = os.clock()
        refreshOwned()
    end
    local best, bd = bestFruit()
    if not best then
        if Config.store then storeAll(setS) end
        FR.noneSince = FR.noneSince or os.clock()
        local left = math.max(0, Config.hopDelay - (os.clock() - FR.noneSince))
        if Config.hop then
            setS("nenhuma fruta nova aqui, trocando de servidor em " .. math.ceil(left) .. "s")
            if left <= 0 then
                serverHop(setS)
                FR.noneSince = os.clock()
            end
        else
            setS("nenhuma fruta nova no mapa")
        end
        task.wait(1)
        return
    end
    FR.noneSince = nil
    setS("indo ate " .. best.name .. " (" .. math.floor(bd) .. "m)")
    if moveTo(CFrame.new(best.part.Position + Vector3.new(0, 3, 0)), Config.fruitSpeed, alive) then
        setS("pegando " .. best.name)
        local before = #fruitTools()
        local t0 = os.clock()
        while alive() and best.obj.Parent and os.clock() - t0 < 5 do
            local rr = root()
            if rr and best.part.Parent then rr.CFrame = best.part.CFrame touch(best.part) end
            if #fruitTools() > before then break end
            task.wait(0.3)
        end
        task.wait(1)
    end
    if alive() and best.obj.Parent then FR.skipped[best.obj] = os.clock() + 60 end
    if Config.store then storeAll(setS) end
end)

end

-- AUTO ROLL GACHA (Cousin): gira de onde voce estiver, sem andar ate o NPC e sem interromper o farm.
-- Confere se veio fruta nova; se o jogo recusar (cooldown / sem Beli) espera mais antes de tentar de novo.
task.spawn(function()
    while not Stopped and gui.Parent do
        local wt = math.max(1.5, Config.gachaDelay)
        if Config.gacha then
            local before = #fruitTools()
            local chk = invoke("Cousin", "Check")
            local res = invoke("Cousin", "Buy")
            task.wait(1)
            local after = #fruitTools()
            local txt
            if res == nil then txt = "sem resposta"
            elseif type(res) == "table" then txt = "tabela"
            else txt = tostring(res) end
            if after > before then
                setSt("gacha", "girou! fruta nova na mochila (resposta: " .. txt .. ")")
            else
                setSt("gacha", "girou/tentou: resposta = " .. txt .. " | Check = " .. tostring(chk) .. " | se nao veio fruta: cooldown ou sem Beli")
                wt = math.max(wt, 8)
            end
        end
        task.wait(wt)
    end
end)

-- AUTO ARMAZENAR FRUTA: guarda no inventario toda fruta que aparecer na mochila/mao (gacha, fruta do chao, drop...)
do
    local tries = {}
    local function stillHere(tool)
        return tool.Parent ~= nil and (tool.Parent == lp.Backpack or tool.Parent == lp.Character)
    end
    task.spawn(function()
        while not Stopped and gui.Parent do
            if Config.autoStore then
                local list = fruitTools()
                local stored, failed = 0, 0
                for _, tool in ipairs(list) do
                    if (tries[tool] or 0) < 4 and stillHere(tool) then
                        tries[tool] = (tries[tool] or 0) + 1
                        -- a fruta precisa estar na mochila (nao na mao)
                        if tool.Parent == lp.Character then
                            local h = hum()
                            if h then pcall(function() h:UnequipTools() end) end
                            task.wait(0.25)
                        end
                        local orig = tool:GetAttribute("OriginalName")
                        local names = {}
                        if orig then names[#names + 1] = tostring(orig) end
                        names[#names + 1] = tool.Name
                        names[#names + 1] = (string.gsub(tool.Name, "%s*Fruit%s*$", ""))
                        for _, nm in ipairs(names) do
                            if not stillHere(tool) then break end
                            invoke("StoreFruit", nm, tool)
                            task.wait(0.4)
                        end
                        if stillHere(tool) then failed = failed + 1 else stored = stored + 1 end
                    end
                end
                if stored > 0 then
                    setSt("autoStore", "armazenou " .. stored .. " fruta(s) no inventario")
                elseif failed > 0 then
                    setSt("autoStore", "nao consegui armazenar " .. failed .. " fruta(s) (inventario cheio ou ja tem essa fruta)")
                elseif #list == 0 then
                    setSt("autoStore", "ligado: nenhuma fruta na mochila")
                end
            end
            task.wait(1.5)
        end
    end)
end

--==================== CHEST (so baus ativos; pega um e vai pro proximo; troca de ilha) ====================
local chestList
do
local chestNames = {Chest1 = "Bau", Chest2 = "Bau de Prata", Chest3 = "Bau de Ouro"}
local function badFlag(inst)
    local okA, attrs = pcall(function() return inst:GetAttributes() end)
    if okA and attrs then
        for k, val in pairs(attrs) do
            local lk = string.lower(k)
            if val == true and (string.find(lk, "disabled", 1, true) or string.find(lk, "collected", 1, true)
                or string.find(lk, "opened", 1, true) or string.find(lk, "taken", 1, true)) then
                return true
            end
        end
    end
    return false
end

function chestList()
    local out, seen = {}, {}

    local function add(v)
        if not v or seen[v] or not v.Parent then return end
        if not (v:IsA("Model") or v:IsA("BasePart")) then return end
        local part = partOf(v)
        if not part or not part:IsA("BasePart") or not part:IsDescendantOf(workspace) then return end
        if badFlag(v) or badFlag(part) then return end

        -- Guarda a instancia real do bau para evitar cadastrar simultaneamente
        -- o Model e uma de suas pecas.
        local model = v:IsA("BasePart") and v:FindFirstAncestorOfClass("Model") or v
        if model and model:IsA("Model") then
            local modelName = model.Name
            if chestNames[modelName] then
                v = model
                part = partOf(model) or part
            end
        end
        if seen[v] then return end
        seen[v] = true
        table.insert(out, {obj = v, part = part, name = chestNames[v.Name] or "Bau"})
    end

    -- Fonte 1: baus marcados pelo proprio jogo (CollectionService).
    pcall(function()
        for _, v in ipairs(CS:GetTagged("_ChestTagged")) do add(v) end
    end)
    -- Fonte 2: pasta Workspace.ChestModels (sem varrer Workspace.Map).
    local cm = workspace:FindFirstChild("ChestModels")
    if cm then
        for _, v in ipairs(cm:GetChildren()) do
            if v:IsA("Model") or v:IsA("BasePart") then add(v) end
        end
    end
    -- Fonte 3: baus soltos direto no Workspace (Chest1/Chest2/Chest3).
    for _, v in ipairs(workspace:GetChildren()) do
        if chestNames[v.Name] then add(v) end
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
            task.wait(0.02)
            firetouchinterest(r, p, 1)
        end)
    end
end
local function beli()
    local ok, v = pcall(function() return lp.Data.Beli.Value end)
    return ok and tonumber(v) or nil
end
local function islandsList()
    local out = {}
    local loc = locationsFolder()
    if not loc then return out end
    for _, p in ipairs(loc:GetChildren()) do
        if not isSubName(p.Name) and not string.match(p.Name, "^Island %d") then
            local okp, pos = pcall(function() return p:GetPivot().Position end)
            if okp then table.insert(out, {name = p.Name, pos = pos}) end
        end
    end
    return out
end

-- Raycast ignora a agua para nunca escolher o fundo do oceano como ponto de chegada.
local function chestGroundAt(pos)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {lp.Character}
    params.IgnoreWater = true
    local hit
    local ok = pcall(function()
        hit = workspace:Raycast(pos + Vector3.new(0, 2500, 0), Vector3.new(0, -5000, 0), params)
    end)
    if ok and hit and hit.Instance and hit.Position.Y > -100 then
        return hit.Position
    end
    return nil
end

-- Viaja primeiro por cima do mar e so depois desce ate o alvo.
local function chestSafeMove(targetPos, alive)
    local rr = root()
    if not rr then return false end
    -- Primeiro sobe verticalmente no ponto atual; nunca atravessa o mar em diagonal.
    local cruiseY = math.max(rr.Position.Y, targetPos.Y) + 220
    local lift = Vector3.new(rr.Position.X, cruiseY, rr.Position.Z)
    if not moveTo(CFrame.new(lift), Config.chestSpeed, alive) then return false end
    if not alive() then return false end
    -- Cruza ate o destino mantendo a altura de seguranca.
    local cruise = Vector3.new(targetPos.X, cruiseY, targetPos.Z)
    if not moveTo(CFrame.new(cruise), Config.chestSpeed, alive) then return false end
    if not alive() then return false end
    -- Desce somente sobre a posicao final da ilha/bau.
    return moveTo(CFrame.new(targetPos), Config.chestSpeed, alive)
end

local CH = {done = {}, visited = {}}
table.insert(Sched.cleanups, function(key)
    if key == "chest" then CH.done, CH.visited = {}, {} end
end)
local function posKey(part)
    local p = part.Position
    return math.floor(p.X / 10) .. "," .. math.floor(p.Z / 10)
end
regFeature("chest", 70, alwaysTrue, function(alive, setS)
    local r = root()
    if not r then setS("aguardando personagem") task.wait(1) return end
    local best, bd, total = nil, nil, 0
    for _, c in ipairs(chestList()) do
        total = total + 1
        local u1, u2 = CH.done[c.obj], CH.done[posKey(c.part)]
        if not ((u1 and u1 > os.clock()) or (u2 and u2 > os.clock())) then
            local d = (c.part.Position - r.Position).Magnitude
            if not bd or d < bd then best, bd = c, d end
        end
    end
    if best then
        setS("indo ate " .. best.name .. " (" .. math.floor(bd) .. "m)")
        if chestSafeMove(best.part.Position + Vector3.new(0, 3, 0), alive) then
            local b0 = beli()
            for _ = 1, 8 do
                if not alive() or not best.obj.Parent or not best.part.Parent then break end
                local rr = root()
                if rr and best.part.Parent then
                    -- fica em cima do bau (o toque do proprio personagem tambem conta) e forca o toque
                    rr.CFrame = CFrame.new(best.part.Position + Vector3.new(0, 1, 0))
                    touchChest(best.obj, best.part)
                end
                task.wait(0.25)
                local b1 = beli()
                if not best.obj.Parent or badFlag(best.obj) or (b0 ~= nil and b1 ~= nil and b1 > b0) then break end
            end
            task.wait(0.35)
            local b1 = beli()
            local collected = (not best.obj.Parent) or badFlag(best.obj)
                or (b0 ~= nil and b1 ~= nil and b1 > b0)
            local cooldown = collected and 120 or 8
            CH.done[best.obj] = os.clock() + cooldown
            CH.done[posKey(best.part)] = os.clock() + cooldown
            setS(collected and "bau coletado; procurando o proximo" or "nao confirmei a coleta; vou tentar novamente")
        end
        return
    end

    -- Sem bau alcancavel: viaja ate uma ilha e so a marca depois de chegar.
    local isl = islandsList()
    local nxt, nd
    for _, i in ipairs(isl) do
        local v = CH.visited[i.name]
        if not (v and v > os.clock()) then
            local d = (i.pos - r.Position).Magnitude
            if d > 180 and (not nd or d < nd) then nxt, nd = i, d end
        end
    end
    if not nxt then
        setS("volta concluida; reiniciando a busca por ilhas")
        CH.visited = {}
        task.wait(2)
        return
    end

    local ground = chestGroundAt(nxt.pos)
    if not ground then
        -- Marcador sem terreno abaixo (ex.: ponto no mar): pula sem viajar para o fundo.
        CH.visited[nxt.name] = os.clock() + 180
        setS("ponto " .. nxt.name .. " sem terreno; procurando outra ilha")
        task.wait(0.5)
        return
    end
    -- ilha atras de redemoinho (Underwater City): atravessa antes de voar
    if not ensureRegion(ground, alive, setS) then return end
    local landing = ground + Vector3.new(0, 18, 0)
    setS("indo para " .. nxt.name .. " por cima do mar")
    if not chestSafeMove(landing, alive) then return end
    if not alive() then return end
    -- Reescaneia somente depois de chegar acima da superficie da ilha.
    task.wait(0.8)
    local rr = root()
    local foundHere = false
    if rr then
        for _, c in ipairs(chestList()) do
            if (c.part.Position - rr.Position).Magnitude <= 700 then foundHere = true break end
        end
    end
    if not foundHere then CH.visited[nxt.name] = os.clock() + 180 end
end)

end

--==================== QUESTS: BARTILO e CITIZEN ====================
local BT = {step = 1}
table.insert(Sched.cleanups, function(key) if key == "bartilo" then BT.step = 1 end end)
regFeature("bartilo", 50, alwaysTrue, function(alive, setS)
    detectSea()
    if SEA ~= 2 then setS("a quest do Bartilo so existe no Sea 2") task.wait(2) return end
    if getLevel() < 850 then setS("precisa do level 850 (voce esta no " .. getLevel() .. ")") task.wait(2) return end
    local prog = invoke("BartiloQuestProgress", "Bartilo")
    local step = BT.step
    if type(prog) == "number" and prog >= 0 and prog <= 3 then step = prog + 1 end
    if step >= 3 then
        setS("falta a parte do Coliseu (soltar os gladiadores): faca manualmente")
        uiSet("bartilo", false)
        return
    end
    local mob = (step == 1) and "Swan Pirate" or "Jeremy"
    if step == 2 and bossStep({"jeremy"}, "Jeremy", alive, setS) then return end
    if questActive(mob) then
        if step == 1 then
            killQuestMobs({name = "BartiloQuest", idx = 1, mob = "Swan Pirate"}, {}, {loc = {"kingdomofrose", "rose"}},
                getLevel(), alive, setS)
        else
            setS("aguardando o Jeremy aparecer...")
            task.wait(1.5)
        end
        return
    end
    local npc = approachNPC({"bartilo"}, {"kingdomofrose", "rose"}, alive, setS, "o Bartilo")
    if not npc or not alive() then return end
    setS("falando com o Bartilo (parte " .. step .. ")")
    invoke("StartQuest", "BartiloQuest", step)
    firePrompts(npc:FindFirstAncestorOfClass("Model"))
    task.wait(2)
    if not questActive(mob) and type(prog) ~= "number" then BT.step = math.min(step + 1, 3) end
end)

regFeature("citizen", 50, alwaysTrue, function(alive, setS)
    detectSea()
    if SEA ~= 3 then setS("a Citizen Quest so existe no Sea 3") task.wait(2) return end
    if getLevel() < 1800 then setS("precisa do level 1800") task.wait(2) return end
    if bossStep({"captainelephant"}, "Captain Elephant", alive, setS) then return end
    local npc = approachNPC({"citizen"}, {"floatingturtle", "turtle"}, alive, setS, "o Citizen")
    if not npc or not alive() then return end
    setS("pegando a Citizen Quest...")
    invoke("StartQuest", "CitizenQuest", 1)
    firePrompts(npc:FindFirstAncestorOfClass("Model"))
    task.wait(1.5)
    clickUi({"yes", "sim", "accept", "aceitar"}, true)
    task.wait(2)
    setS("quest pega. Aguardando o Captain Elephant...")
    task.wait(3)
end)

--==================== QUEST SABER / SEGUNDO MAR / TERCEIRO MAR ====================
-- Melhor esforco: os nomes de NPC/boss/remotes abaixo sao os que o Blox Fruits costuma usar.
local TR = {t2 = 0, t3 = 0}
-- ===== helpers dos puzzles =====
local function mapPart(path)
    local cur = workspace:FindFirstChild("Map")
    for _, n in ipairs(path) do cur = cur and cur:FindFirstChild(n) end
    return cur
end
-- voa ate perto de pos (passa por redemoinho se precisar). true = ja esta perto (<= 25 studs)
local function flyTo(pos, alive, setS, label, up)
    local r = root()
    if not r then return false end
    if not ensureRegion(pos, alive, setS) then return false end
    r = root()
    if not r then return false end
    local d = (r.Position - pos).Magnitude
    if d <= 25 then return true end
    setS(label .. " (" .. math.floor(d) .. "m)")
    if d > 800 then
        flyStaged(pos + Vector3.new(0, up or 3, 0), alive, 60)
    else
        moveTo(CFrame.new(pos + Vector3.new(0, up or 3, 0)), Config.tweenSpeed, alive)
    end
    return false
end

-- ===== SABER (Sea 1) =====
-- Etapas (baseadas em scripts abertos do jogo): 1) 5 placas da Jungle  2) pegar a Torch e queimar a cortina do
-- Desert  3) Cup: GetCup/FillCup/SickMan  4) RichSon: Mob Leader e depois a Relic  5) Saber Expert.
local SB = {pressed = {}, torchAt = 0, torch = nil, lastCup = 0, lastClaim = 0}
table.insert(Sched.cleanups, function(key) if key == "saber" then SB.pressed = {} end end)
local JUNGLE_POS = Vector3.new(-1612.56, 36.98, 148.72)
local RELIC_POS = Vector3.new(-1404.92, 29.98, 3.81)
local SABER_ROOM = Vector3.new(-1458.9, 29.89, -50.63)
local MOBLEADER_POS = Vector3.new(-2844.73, 7.42, 5356.67)
local function plateParts()
    local out = {}
    local qp = mapPart({"Jungle", "QuestPlates"})
    if not qp then return out end
    for _, c in ipairs(qp:GetChildren()) do
        if c.Name ~= "Door" then
            local p = c:FindFirstChild("Button") or (c:IsA("BasePart") and c) or partOf(c)
            if p and p:IsA("BasePart") then table.insert(out, {obj = c, part = p}) end
        end
    end
    return out
end
local function findTorchPickup()
    if os.clock() - SB.torchAt < 10 then return SB.torch end
    SB.torchAt = os.clock()
    SB.torch = nil
    local n = 0
    for _, d in ipairs(workspace:GetDescendants()) do
        n = n + 1
        if n % 4000 == 0 then task.wait() end
        if norm(d.Name) == "torch" and (d:IsA("Tool") or d:IsA("Model") or d:IsA("BasePart"))
            and not (lp.Character and d:IsDescendantOf(lp.Character)) and not d:IsDescendantOf(lp.Backpack) then
            local part = d:IsA("Tool") and (d:FindFirstChild("Handle") or partOf(d)) or partOf(d)
            if part then SB.torch = part break end
        end
    end
    return SB.torch
end
local function haveSaber()
    for _, cont in ipairs({lp.Character, lp.Backpack}) do
        if cont then
            for _, t in ipairs(cont:GetChildren()) do
                if t:IsA("Tool") and norm(t.Name) == "saber" then return true end
            end
        end
    end
    return false
end
regFeature("saber", 50, alwaysTrue, function(alive, setS)
    detectSea()
    if SEA ~= 1 then setS("a Quest Saber so existe no Sea 1") task.wait(2) return end
    if getLevel() < 200 then setS("precisa do level 200 (voce esta no " .. getLevel() .. ")") task.wait(2) return end
    if haveSaber() then setS("voce ja tem a Saber!") uiSet("saber", false) return end

    local final = mapPart({"Jungle", "Final", "Part"})
    local door = mapPart({"Jungle", "QuestPlates", "Door"})
    -- o mapa so carrega perto de voce: se os objetos nao existem, vai para a Jungle
    if not final or not door then
        if flyTo(JUNGLE_POS, alive, setS, "Saber: indo para a Jungle carregar o puzzle") then
            setS("Saber: aguardando o mapa da Jungle carregar...")
            task.wait(1.5)
        end
        return
    end

    -- ETAPA 5: porta final aberta -> Saber Expert
    if final.Transparency ~= 0 or workspace.Enemies:FindFirstChild("Saber Expert") then
        if bossStep({"saberexpert"}, "Saber Expert", alive, setS) then return end
        if os.clock() - SB.lastClaim > 6 then
            SB.lastClaim = os.clock()
            invoke("ProQuestProgress", "PlaceRelic")
        end
        if flyTo(SABER_ROOM, alive, setS, "Saber: indo ate o Saber Expert", 8) then
            setS("Saber: aguardando o Saber Expert aparecer")
            task.wait(1.5)
        end
        return
    end

    -- ETAPA 1: placas da Jungle
    if door.Transparency == 0 then
        local plates = plateParts()
        if #plates == 0 then
            if flyTo(JUNGLE_POS, alive, setS, "Saber: procurando as placas da Jungle") then task.wait(1) end
            return
        end
        local r = root()
        local best, bd, left = nil, nil, 0
        for _, p in ipairs(plates) do
            if not SB.pressed[p.obj] then
                left = left + 1
                local d = r and (p.part.Position - r.Position).Magnitude or 0
                if not bd or d < bd then best, bd = p, d end
            end
        end
        if not best then
            -- apertou todas e a porta ainda esta fechada: espera um pouco e repete
            setS("Saber: todas as placas pressionadas, aguardando a porta abrir...")
            task.wait(2)
            if door.Transparency == 0 then SB.pressed = {} end
            return
        end
        setS("Saber: pressionando placa (" .. (#plates - left + 1) .. "/" .. #plates .. ")")
        if moveTo(CFrame.new(best.part.Position + Vector3.new(0, 3, 0)), Config.tweenSpeed, alive) then
            for _ = 1, 3 do
                local rr = root()
                if rr then rr.CFrame = CFrame.new(best.part.Position + Vector3.new(0, 1.5, 0)) end
                touch(best.part)
                task.wait(0.3)
            end
            SB.pressed[best.obj] = true
        end
        return
    end

    -- ETAPA 2: Torch -> queimar a cortina do Desert
    local burn = mapPart({"Desert", "Burn", "Part"})
    local fire = mapPart({"Desert", "Burn", "Fire"})
    local desert = locationPos("desert")
    if not burn then
        if desert then
            if flyTo(desert, alive, setS, "Saber: indo ao Desert (cortina)", 40) then task.wait(1) end
        else
            setS("Saber: nao achei o Desert; va ate la uma vez para carregar")
            task.wait(2)
        end
        return
    end
    if burn.Transparency == 0 then
        local torch = findTool({"torch"})
        if torch then
            equipTool(torch)
            local fpos = fire and fire.Position or burn.Position
            if flyTo(fpos, alive, setS, "Saber: levando a Torch ate a cortina", 4) then
                setS("Saber: queimando a cortina")
                local handle = torch:FindFirstChild("Handle") or (lp.Character and lp.Character:FindFirstChild("Torch") and lp.Character.Torch:FindFirstChild("Handle"))
                if handle and fire and firetouchinterest then
                    pcall(function() firetouchinterest(handle, fire, 0) task.wait(0.1) firetouchinterest(handle, fire, 1) end)
                end
                task.wait(1.5)
            end
        else
            local pick = findTorchPickup()
            if pick then
                if flyTo(pick.Position, alive, setS, "Saber: pegando a Torch", 3) then
                    touch(pick)
                    firePrompts(pick:FindFirstAncestorOfClass("Model") or pick.Parent)
                    task.wait(1)
                end
            else
                if flyTo(JUNGLE_POS, alive, setS, "Saber: procurando a Torch (porao da casa do NPC na Jungle)") then
                    setS("Saber: nao achei a Torch; desca a escada da casa do NPC na Jungle e chegue perto do buraco")
                    task.wait(2)
                end
            end
        end
        return
    end

    -- ETAPA 3: Cup (SickMan)
    local sick = invoke("ProQuestProgress", "SickMan")
    if sick ~= 0 then
        if os.clock() - SB.lastCup > 3 then
            SB.lastCup = os.clock()
            setS("Saber: pegando e enchendo o Cup (resposta do jogo: " .. tostring(sick) .. ")")
            invoke("ProQuestProgress", "GetCup")
            task.wait(0.5)
            local cup = findTool({"cup"})
            if cup then equipTool(cup) end
            task.wait(0.5)
            local cupInChar = lp.Character and lp.Character:FindFirstChild("Cup")
            if cupInChar then invoke("ProQuestProgress", "FillCup", cupInChar) end
            task.wait(1)
            invoke("ProQuestProgress", "SickMan")
        end
        task.wait(0.5)
        return
    end

    -- ETAPA 4: RichSon (Mob Leader e Relic)
    local rich = invoke("ProQuestProgress", "RichSon")
    if rich == nil then
        setS("Saber: iniciando a parte do RichSon")
        invoke("ProQuestProgress", "RichSon")
        task.wait(1)
        return
    elseif rich == 0 then
        if bossStep({"mobleader"}, "Mob Leader", alive, setS) then return end
        if flyTo(MOBLEADER_POS, alive, setS, "Saber: indo ate o Mob Leader", 40) then
            setS("Saber: aguardando o Mob Leader aparecer")
            task.wait(1.5)
        end
        return
    elseif rich == 1 then
        invoke("ProQuestProgress", "RichSon")
        local relic = findTool({"relic"})
        if relic then equipTool(relic) end
        if flyTo(RELIC_POS, alive, setS, "Saber: levando a Relic ate o pedestal", 4) then
            setS("Saber: colocando a Relic")
            invoke("ProQuestProgress", "PlaceRelic")
            task.wait(1.5)
        end
        return
    end
    setS("Saber: etapa desconhecida (RichSon = " .. tostring(rich) .. "). Me mande esse numero.")
    task.wait(2)
end)

-- ===== SECOND SEA (Sea 1 -> Sea 2) =====
-- Fluxo do jogo: Detective da a Key; com a Key na mao, a porta de gelo abre; so entao o Ice Admiral toma dano;
-- depois de mata-lo, o comando TravelDressrosa leva ao Sea 2.
local ICE_DOOR = Vector3.new(1347.71, 37.38, -1325.65)
regFeature("sea2Quest", 50, alwaysTrue, function(alive, setS)
    detectSea()
    if SEA ~= 1 then setS("a Quest do Segundo Mar so existe no Sea 1") task.wait(2) return end
    if getLevel() < 700 then setS("precisa do level 700 (voce esta no " .. getLevel() .. ")") task.wait(2) return end
    local door = mapPart({"Ice", "Door"})
    if not door then
        if flyTo(ICE_DOOR, alive, setS, "Segundo Mar: indo ate a porta de gelo") then
            setS("Segundo Mar: aguardando o mapa carregar...")
            task.wait(1.5)
        end
        return
    end
    local closed = door.CanCollide and door.Transparency == 0
    if closed then
        -- pede a chave ao Detective (funciona de longe), equipa e fica na porta ate ela abrir
        invoke("DressrosaQuestProgress", "Detective")
        local key = findTool({"key"})
        if key then equipTool(key) end
        if flyTo(ICE_DOOR, alive, setS, "Segundo Mar: levando a chave ate a porta de gelo", 3) then
            setS("Segundo Mar: chave " .. (key and "equipada" or "NAO encontrada (fale com o Detective em Middle Town)") .. ", aguardando a porta abrir")
            task.wait(1.5)
        end
        return
    end
    -- porta aberta: mata o Ice Admiral e viaja
    if bossStep({"iceadmiral"}, "Ice Admiral", alive, setS) then return end
    if os.clock() - TR.t2 > 5 then
        TR.t2 = os.clock()
        local res = invoke("TravelDressrosa")
        setS("Segundo Mar: porta aberta, sem Ice Admiral vivo; viajando (resposta: " .. tostring(res) .. ")")
    end
    if flyTo(ICE_DOOR, alive, setS, "Segundo Mar: voltando a porta", 3) then task.wait(1) end
end)

regFeature("sea3Quest", 50, alwaysTrue, function(alive, setS)
    detectSea()
    if SEA ~= 2 then setS("a Quest do Terceiro Mar so existe no Sea 2") task.wait(2) return end
    if getLevel() < 1500 then setS("precisa do level 1500 (voce esta no " .. getLevel() .. ")") task.wait(2) return end
    if bossStep({"donswan"}, "Don Swan", alive, setS) then return end
    setS("pegando a quest do Terceiro Mar...")
    invoke("ZQuestProgress", "Check")
    invoke("ZQuestProgress", "Begin")
    task.wait(1.5)
    if os.clock() - TR.t3 > 20 then
        TR.t3 = os.clock()
        setS("tentando viajar para o Terceiro Mar...")
        invoke("TravelZou")
    end
    task.wait(3)
end)

--==================== RACE ====================
local raceInfo
do
function raceInfo()
    local race, ver = "?", 1
    pcall(function() race = tostring(lp.Data.Race.Value) end)
    pcall(function() if lp.Data.Race:FindFirstChild("Evolved") then ver = 2 end end)
    return race, ver
end
local function flowerCount()
    local n = 0
    for _, cont in ipairs({lp.Backpack, lp.Character}) do
        if cont then
            for _, t in ipairs(cont:GetChildren()) do
                if t:IsA("Tool") and string.find(norm(t.Name), "flower", 1, true) then n = n + 1 end
            end
        end
    end
    return n
end
local RV = {accepted = false}
table.insert(Sched.cleanups, function(key) if key == "raceV2" or key == "raceV3" then RV.accepted = false end end)
regFeature("raceV2", 50, alwaysTrue, function(alive, setS)
    detectSea()
    local race, ver = raceInfo()
    if ver >= 2 then setS(race .. " ja esta na V2") uiSet("raceV2", false) return end
    if SEA ~= 2 then setS("a V2 e feita no Sea 2 (Alchemist)") task.wait(2) return end
    if getLevel() < 850 then setS("precisa do level 850") task.wait(2) return end
    local have = flowerCount()
    if have >= 3 then
        local npc = approachNPC({"alchemist"}, {"greenzone", "green"}, alive, setS, "o Alchemist")
        if not npc or not alive() then return end
        setS("entregando as flores...")
        invoke("Alchemist", "3")
        task.wait(2)
        return
    end
    if not RV.accepted then
        local npc = approachNPC({"alchemist"}, {"greenzone", "green"}, alive, setS, "o Alchemist")
        if not npc or not alive() then return end
        setS("pegando a quest do Alchemist...")
        invoke("Alchemist", "1")
        invoke("Alchemist", "2")
        firePrompts(npc:FindFirstAncestorOfClass("Model"))
        RV.accepted = true
        task.wait(1.5)
        return
    end
    for i = 1, 3 do
        local f = workspace:FindFirstChild("Flower" .. i)
        local part = f and partOf(f)
        if part then
            setS("coletando a flor " .. i .. " (" .. have .. "/3)")
            if moveTo(CFrame.new(part.Position + Vector3.new(0, 3, 0)), Config.tweenSpeed, alive) then
                touch(part)
                firePrompts(f)
                task.wait(1)
            end
            return
        end
    end
    setS("aguardando as flores (azul = noite, vermelha = dia) " .. have .. "/3 | farmando zumbis")
    questStep("raceZombie", {useQuest = true, loc = {"graveyard"}, filter = function(n) return n == "zombie" end}, alive, setS)
end)

regFeature("raceV3", 50, alwaysTrue, function(alive, setS)
    local race, ver = raceInfo()
    if ver < 2 then setS(race .. ": faca a V2 primeiro") task.wait(2) return end
    local npc = findNPC({"wenlocktoad", "wenlock"})
    if not npc then
        setS("V3: nao achei o NPC Wenlocktoad. Va ate ele uma vez (o script grava).")
        task.wait(3)
        return
    end
    local r = root()
    if r and (r.Position - npc.Position).Magnitude > 20 then
        setS("indo ate o Wenlocktoad...")
        moveTo(CFrame.new(npc.Position + Vector3.new(0, 3, 4)), Config.tweenSpeed, alive)
        return
    end
    invoke("Wenlocktoad", "1")
    firePrompts(npc:FindFirstAncestorOfClass("Model"))
    setS("falei com o Wenlocktoad. Conclua o trial da raca " .. race .. " (o jogo guia pela tela).")
    task.wait(4)
end)

end

--==================== RAIDS ====================
local RAID_TYPES
do
RAID_TYPES = {"Flame", "Ice", "Quake", "Light", "Dark", "Spider", "Rumble", "Magma", "Buddha", "Sand", "Phoenix", "Dough"}
local FRUIT_RANK = {rocket = 1, spin = 2, blade = 3, spring = 4, bomb = 5, smoke = 6, spike = 7, flame = 8, falcon = 9,
    ice = 10, sand = 11, dark = 12, diamond = 13, light = 14, rubber = 15, barrier = 16, ghost = 17, magma = 18}
local function hasChip() return findTool({"microchip"}) ~= nil end
local function raidIslands()
    local out = {}
    local loc = locationsFolder()
    if not loc then return out end
    for _, p in ipairs(loc:GetChildren()) do
        local n = string.match(p.Name, "^Island (%d)")
        if n then
            local ok, pos = pcall(function() return p:GetPivot().Position end)
            if ok then table.insert(out, {num = tonumber(n), pos = pos}) end
        end
    end
    table.sort(out, function(a, b) return a.num > b.num end)
    return out
end
local function inRaid() return #raidIslands() > 0 end
local function cheapestFruitTool()
    local best, br
    for _, t in ipairs(fruitTools()) do
        local rank = FRUIT_RANK[fkey(toolName(t))] or 99
        if not br or rank < br then best, br = t, rank end
    end
    if best and br < 99 then return best end
    return nil
end

regFeature("buyChip", 45, function() return Config.buyChip and not hasChip() and not inRaid() end, function(alive, setS)
    detectSea()
    if SEA == 1 then setS("raids so existem no Sea 2 e Sea 3") task.wait(2) return end
    local npc = approachNPC({"mysteriousscientist", "scientist"}, {"castleonthesea", "hotandcold", "castle"}, alive, setS, "o Cientista Misterioso")
    if not npc or not alive() then return end
    if Config.badFruit then
        local t = cheapestFruitTool()
        if t then
            setS("usando a fruta mais barata (" .. toolName(t) .. ") para o chip")
            equipTool(t)
            task.wait(0.6)
        end
    end
    setS("comprando o chip " .. Config.raidType .. "...")
    invoke("RaidsNpc", "Select", Config.raidType)
    task.wait(2)
    if hasChip() then setS("chip comprado!") else setS("nao consegui comprar o chip (sem beli/fruta?)") task.wait(4) end
end, function() return Config.buyChip end)

local raidBtnCache
local function findRaidButton()
    if raidBtnCache and raidBtnCache.Parent then return raidBtnCache end
    local map = workspace:FindFirstChild("Map")
    if not map then return nil end
    for _, d in ipairs(map:GetDescendants()) do
        if d:IsA("ClickDetector") then
            local pn = string.lower(d:GetFullName())
            if string.find(pn, "raidsummon", 1, true) then
                raidBtnCache = d
                return d
            end
        end
    end
    return nil
end
regFeature("raid", 40, function() return inRaid() or hasChip() end, function(alive, setS)
    if inRaid() then
        local list = targetsByNames({""}, {"Enemies"})
        if #list > 0 then
            local best, bd = nearestOf(list)
            setS("Raid: lutando (" .. #list .. " inimigos) | " .. atkInfo())
            engage(best, alive, farmHover(), false, Config.tweenSpeed, 15)
        else
            local isl = raidIslands()[1]
            if isl then
                setS("Raid: indo para a ilha " .. isl.num)
                moveTo(CFrame.new(isl.pos + Vector3.new(0, 40, 0)), Config.tweenSpeed, alive)
            end
            task.wait(0.5)
        end
        return
    end
    local btn = findRaidButton()
    if not btn then setS("botao de iniciar a raid nao encontrado (va ate o laboratorio de raid)") task.wait(3) return end
    local part = btn.Parent
    local pos = part and part:IsA("BasePart") and part.Position
    if pos then
        setS("indo ate o botao da raid...")
        if not moveTo(CFrame.new(pos + Vector3.new(0, 3, 4)), Config.tweenSpeed, alive) then return end
    end
    setS("iniciando a raid...")
    if fireclickdetector then pcall(fireclickdetector, btn) end
    task.wait(3)
end)

regFeature("awaken", 45, function() return Config.awaken end, function(alive, setS)
    setS("tentando despertar as habilidades da fruta...")
    local a = invoke("Awakener", "Check")
    task.wait(1)
    local b = invoke("Awakener", "Awaken")
    setS("resposta do jogo: " .. tostring(a) .. " / " .. tostring(b) .. " (precisa estar perto do Mysterious Entity)")
    uiSet("awaken", false)
end)

end

--==================== TRIALS (ativar V3/V4 automatico), ANTI AFK, WALK ON WATER ====================
task.spawn(function()
    while not Stopped and gui.Parent do
        if Config.actV3 or Config.actV4 then
            pcall(function()
                local c = lp.Character
                local e = c and c:FindFirstChild("RaceEnergy")
                local on = c and c:FindFirstChild("RaceTransformed")
                if e and e.Value >= 0.99 and not (on and on.Value) and VIM then
                    VIM:SendKeyEvent(true, Enum.KeyCode.Y, false, game)
                    task.wait(0.1)
                    VIM:SendKeyEvent(false, Enum.KeyCode.Y, false, game)
                end
            end)
        end
        task.wait(1)
    end
end)

keep(lp.Idled:Connect(function()
    pcall(function()
        VU:CaptureController()
        VU:ClickButton2(Vector2.new())
    end)
end))
task.spawn(function()
    local last = os.clock()
    while not Stopped and gui.Parent do
        if Config.afk and os.clock() - last >= Config.afkMin * 60 then
            last = os.clock()
            pcall(function()
                VU:CaptureController()
                VU:ClickButton1(Vector2.new(2, 2))
                if VIM then
                    local x, y = screenCenter()
                    VIM:SendMouseMoveEvent(x + 3, y + 3, game)
                end
            end)
        end
        task.wait(2)
    end
end)

do
local waterPart
keep(RS.Heartbeat:Connect(function()
    if not Config.walkWater then
        if waterPart then
            waterPart:Destroy()
            waterPart = nil
        end
        return
    end
    local r = root()
    if not r then return end
    if not waterPart then
        waterPart = new("Part", {
            Size = Vector3.new(26, 2, 26), Transparency = 1, Anchored = true, CanCollide = true, CanQuery = false,
            CanTouch = false, Name = "OrionWater",
        }, workspace)
    end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {lp.Character, waterPart}
    params.IgnoreWater = false
    local res = workspace:Raycast(r.Position, Vector3.new(0, -16, 0), params)
    local isWater = res and (res.Material == Enum.Material.Water or string.find(string.lower(res.Instance.Name), "water", 1, true))
    if isWater then
        waterPart.CFrame = CFrame.new(res.Position.X, res.Position.Y - 1, res.Position.Z)
    else
        waterPart.CFrame = CFrame.new(0, -10000, 0)
    end
end))
end

--==================== FPS BOOST ====================
local applyFps
do
local fpsHooked = false
local function killFx(d)
    if d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") or d:IsA("Smoke") or d:IsA("Fire") or d:IsA("Sparkles") then
        pcall(function() d.Enabled = false end)
    end
end
function applyFps()
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, e in ipairs(Lighting:GetChildren()) do
            if e:IsA("PostEffect") or e:IsA("Atmosphere") then e:Destroy() end
        end
        local t = workspace:FindFirstChildOfClass("Terrain")
        if t then
            t.WaterWaveSize = 0
            t.WaterWaveSpeed = 0
            t.WaterReflectance = 0
        end
    end)
    if not fpsHooked then
        fpsHooked = true
        keep(workspace.DescendantAdded:Connect(function(d)
            if Config.fpsBoost then killFx(d) end
        end))
    end
    task.spawn(function()
        local n = 0
        for _, d in ipairs(workspace:GetDescendants()) do
            n = n + 1
            if n % 1200 == 0 then task.wait() end
            killFx(d)
            if Config.fpsMax then
                if d:IsA("Decal") or d:IsA("Texture") then
                    pcall(function() d.Transparency = 1 end)
                elseif d:IsA("BasePart") and not (lp.Character and d:IsDescendantOf(lp.Character)) then
                    pcall(function()
                        d.Material = Enum.Material.SmoothPlastic
                        d.Reflectance = 0
                        d.CastShadow = false
                    end)
                end
            end
        end
    end)
end

end

--==================== ESP ====================
local clearESP
do
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
            Size = UDim2.fromOffset(170, 38), AlwaysOnTop = true, StudsOffset = Vector3.new(0, 3, 0), Adornee = adornee,
        }, gui)
        local lbl = new("TextLabel", {
            Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, TextColor3 = color,
            Font = Enum.Font.GothamBold, TextSize = 13, TextStrokeTransparency = 0.4,
        }, bb)
        local hl = nil
        if Config.espOutline and hlTarget then
            hl = new("Highlight", {
                Adornee = hlTarget, FillTransparency = 1, OutlineColor = color, DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
            }, gui)
        end
        t = {bb = bb, lbl = lbl, hl = hl}
        tags[k] = t
    end
    t.lbl.Text = label
    t.bb.Adornee = adornee
end
local function berryList()
    local out = {}
    pcall(function()
        for _, v in ipairs(CS:GetTagged("BerryBush")) do
            local part = partOf(v)
            if part then
                table.insert(out, {obj = v, part = part,
                    name = tostring(v:GetAttribute("BerryName") or v:GetAttribute("Berry") or v.Name)})
            end
        end
    end)
    return out
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
    if Config.espBerries then
        for _, b in ipairs(berryList()) do
            seen[b.obj] = true
            setTag(b.obj, b.part, nil, Color3.fromRGB(255, 120, 200), "Berry: " .. b.name .. dist(b.part))
        end
    end
    if Config.espIsland then
        local loc = locationsFolder()
        if loc then
            for _, p in ipairs(loc:GetChildren()) do
                local part = partOf(p)
                if part then
                    seen[p] = true
                    setTag(p, part, nil, Color3.fromRGB(150, 255, 170), p.Name .. dist(part))
                end
            end
        end
    end
    for k in pairs(tags) do
        if not seen[k] then removeTag(k) end
    end
end
function clearESP() for k in pairs(tags) do removeTag(k) end end
local accT = 0
keep(RS.Heartbeat:Connect(function(dt)
    accT = accT + dt
    if accT < 0.4 then return end
    accT = 0
    if Config.espPlayers or Config.espFruits or Config.espChests or Config.espBerries or Config.espIsland then
        pcall(refreshESP)
    else
        if next(tags) then clearESP() end
    end
end))
end

--==================== ITENS (espadas Sea 3 + loja) e EVENTO HALLOWEEN ====================
do
-- inventario (cache de 15s)
local INV = {t = 0, names = {}}
local function refreshInv(force)
    if not force and os.clock() - INV.t < 15 then return end
    INV.t = os.clock()
    local inv = invoke("getInventory")
    if type(inv) == "table" then
        local n = {}
        for _, it in pairs(inv) do
            if type(it) == "table" and it.Name then n[norm(it.Name)] = true end
        end
        INV.names = n
    end
end
local function ownsItem(name)
    refreshInv()
    local k = norm(name)
    if INV.names[k] then return true end
    return findTool({k}) ~= nil
end

-- ---------- espadas do Sea 3: cacar o boss que dropa ----------
local HUNTS = {
    {key = "swTushita", label = "Tushita", inv = "Tushita", boss = "Longma", names = {"longma"},
        desc = "Boss Longma (aparece junto do Rip Indra / enigma das tochas na Hydra Island).",
        hint = "invoque o Rip Indra em Multi Farm e faca o enigma das tochas"},
    {key = "swHallow", label = "Hallow Scythe", inv = "Hallow Scythe", boss = "Soul Reaper", names = {"soulreaper"},
        desc = "Drop do Soul Reaper no Haunted Castle.",
        hint = "use Summon Soul Reaper em Multi Farm (precisa de Hallow Essence)"},
    {key = "swCanvander", label = "Canvander", inv = "Canvander", boss = "Beautiful Pirate", names = {"beautifulpirate"},
        desc = "Drop do Beautiful Pirate no castelo da Floating Turtle.",
        hint = "va ate o castelo da Floating Turtle"},
    {key = "swTrident", label = "Spikey Trident", inv = "Spikey Trident", boss = "Cake Prince / Dough King", names = {"cakeprince", "doughking"},
        desc = "Drop do Cake Prince ou Dough King (Sea of Treats).",
        hint = "Cake Prince nasce farmando Cake Land; Dough King precisa do Sweet Chalice"},
    {key = "swBuddy", label = "Buddy Sword", inv = "Buddy Sword", boss = "Cake Guard / Drip Mama", names = {"cakeguard", "dripmama"},
        desc = "Drop dos Cake Guard / Drip Mama (Sea of Treats).",
        hint = "fique na Cake Land"},
    {key = "swDagger", label = "Dark Dagger", inv = "Dark Dagger", boss = "The Cursed Mummy", names = {"cursedmummy", "ripindra"},
        desc = "Drop do boss The Cursed Mummy / eventos relacionados.",
        hint = "aguarde o boss aparecer"},
    {key = "swTwin", label = "Twin Hooks", inv = "Twin Hooks", boss = "Captain Elephant", names = {"captainelephant"},
        desc = "Drop do Captain Elephant na Floating Turtle.",
        hint = "pegue a Citizen Quest para ele aparecer"},
}
T.items.Note("Espadas do Sea 3: ligue o toggle e o script vai atras do boss que dropa a espada. Quando ela entrar no inventario, o toggle desliga sozinho.")
local ownLbl = T.items.Note("Verificando suas espadas...")
T.items.Section("Espadas do Sea 3 (farm automatico)")

-- Yama: 30 Elite Hunters
local eliteProg, eliteProgAt = 0, 0
regFeature("swYama", 35, alwaysTrue, function(alive, setS)
    if ownsItem("Yama") then setS("voce ja tem a Yama") uiSet("swYama", false) return end
    detectSea()
    if SEA ~= 3 then setS("a Yama so existe no Sea 3 (Hydra Island)") task.wait(2) return end
    if os.clock() - eliteProgAt > 10 then
        eliteProgAt = os.clock()
        local p = invoke("EliteHunter", "Progress")
        if type(p) == "number" then eliteProg = p end
    end
    if eliteProg >= 30 then
        setS("30 Elites concluidos! Puxe a Yama no altar (passagem secreta da cachoeira, Hydra Island) manualmente")
        uiSet("swYama", false)
        return
    end
    eliteStep(alive, function(t) setS("Elites: " .. eliteProg .. "/30 | " .. t) end)
end)
T.items.Feature("Yama (30 Elite Hunters)", "swYama", "grind")

for _, h in ipairs(HUNTS) do
    regFeature(h.key, 35, alwaysTrue, function(alive, setS)
        if ownsItem(h.inv) then setS("voce ja tem " .. h.label) uiSet(h.key, false) return end
        if bossStep(h.names, h.boss, alive, setS) then return end
        setS("aguardando " .. h.boss .. " aparecer | " .. h.hint)
        task.wait(1.5)
    end)
    T.items.Feature(h.label .. " (" .. h.boss .. ")", h.key, "grind")
end
T.items.Note("Cursed Dual Katana (CDK): e uma espada mitica que se cria concluindo as quests da Yama e da Tushita (nivel 2200+ e 350 de maestria nas duas). Os puzzles sao manuais, entao nao ha toggle para ela.")

task.spawn(function()
    local list = {"Yama", "Tushita", "Cursed Dual Katana", "Hallow Scythe", "Canvander", "Spikey Trident", "Buddy Sword", "Dark Dagger", "Twin Hooks"}
    while not Stopped and gui.Parent do
        local parts = {}
        for _, nm in ipairs(list) do
            parts[#parts + 1] = (ownsItem(nm) and "[x] " or "[ ] ") .. nm
        end
        ownLbl.Text = "Suas espadas: " .. table.concat(parts, "  ")
        task.wait(20)
    end
end)

-- ---------- LOJA: compra pelo remote, de qualquer lugar ----------
local SHOP1 = {
    {label = "Katana", price = "1.000 Beli", where = "Ilha inicial (Pirata/Marinha)", buy = {"BuyItem", "Katana"}, inv = "Katana"},
    {label = "Cutlass", price = "1.000 Beli", where = "Ilha inicial", buy = {"BuyItem", "Cutlass"}, inv = "Cutlass"},
    {label = "Dual Katana", price = "12.000 Beli", where = "Pirate Village", buy = {"BuyItem", "Duel Katana"}, inv = "Dual Katana"},
    {label = "Iron Mace", price = "25.000 Beli", where = "Pirate Village", buy = {"BuyItem", "Iron Mace"}, inv = "Iron Mace"},
    {label = "Triple Katana", price = "60.000 Beli", where = "Frozen Village", buy = {"BuyItem", "Triple Katana"}, inv = "Triple Katana"},
    {label = "Pipe", price = "100.000 Beli", where = "Frozen Village", buy = {"BuyItem", "Pipe"}, inv = "Pipe"},
    {label = "Dual-Headed Blade", price = "400.000 Beli", where = "Skylands", buy = {"BuyItem", "Dual-Headed Blade"}, inv = "Dual-Headed Blade"},
    {label = "Soul Cane", price = "750.000 Beli", where = "Magma Village", buy = {"BuyItem", "Soul Cane"}, inv = "Soul Cane"},
    {label = "Bisento", price = "1.000.000 Beli", where = "Master Sword Dealer (Skylands)", buy = {"BuyItem", "Bisento"}, inv = "Bisento", confirm = true},
}
local SHOP2 = {
    {label = "Midnight Blade", price = "100 Ectoplasma", where = "El Admin (Cursed Ship)", buy = {"Ectoplasm", "Buy", 1}, inv = "Midnight Blade"},
    {label = "Shizu", price = "2.000.000 Beli", where = "Legendary Sword Dealer", buy = {"LegendarySwordDealer", "1"}, inv = "Shizu", confirm = true},
    {label = "Saishi", price = "2.000.000 Beli", where = "Legendary Sword Dealer", buy = {"LegendarySwordDealer", "3"}, inv = "Saishi", confirm = true},
    {label = "Oroshi", price = "2.000.000 Beli", where = "Legendary Sword Dealer", buy = {"LegendarySwordDealer", "2"}, inv = "Oroshi", confirm = true},
}
local pending = {}
local function shopButton(item)
    T.items.Button(item.label, item.price .. " | " .. item.where, "Comprar", function(b, d)
        local now = os.clock()
        if item.confirm and not (pending[item.label] and now - pending[item.label] < 5) then
            pending[item.label] = now
            b.Text = "Confirmar?"
            task.delay(5, function()
                if pending[item.label] == now then
                    pending[item.label] = nil
                    b.Text = "Comprar"
                end
            end)
            return
        end
        pending[item.label] = nil
        b.Text = "..."
        task.spawn(function()
            if ownsItem(item.inv) then
                d.Text = "voce ja tem " .. item.label
                b.Text = "Comprar"
                return
            end
            d.Text = "comprando " .. item.label .. "..."
            local res = invoke(unpack(item.buy))
            task.wait(1)
            refreshInv(true)
            if ownsItem(item.inv) then
                d.Text = "comprada! " .. item.label .. " esta no seu inventario"
            else
                d.Text = "o jogo nao entregou a espada (resposta: " .. tostring(res) .. ")"
            end
            b.Text = "Comprar"
        end)
    end)
end
T.items.Section("Loja - Sea 1 (compra de qualquer lugar)")
for _, it in ipairs(SHOP1) do shopButton(it) end
T.items.Section("Loja - Sea 2 / Legendary")
for _, it in ipairs(SHOP2) do shopButton(it) end
T.items.Note("Loja: apertar o botao manda a compra direto ao jogo, sem andar ate o NPC. As espadas de 1.000.000+ pedem um segundo clique em 'Confirmar?'. Se o jogo recusar, a resposta dele aparece na descricao do botao.")

-- ---------- EVENTO HALLOWEEN ----------
local HW = {list = {}, done = {}}
local function promptPart(d)
    local p = d.Parent
    if not p then return nil end
    if p:IsA("Attachment") then p = p.Parent end
    return p and partOf(p)
end
local function hwScan()
    local out = {}
    local n = 0
    for _, d in ipairs(workspace:GetDescendants()) do
        n = n + 1
        if n % 3000 == 0 then task.wait() end
        if d:IsA("ProximityPrompt") or d:IsA("ClickDetector") then
            local full = string.lower(d:GetFullName())
            local kind
            if string.find(full, "pumpkin", 1, true) then
                kind = "pumpkin"
            elseif string.find(full, "door", 1, true) and (string.find(full, "halloween", 1, true) or string.find(full, "trick", 1, true)
                or string.find(full, "treat", 1, true) or string.find(full, "knock", 1, true) or string.find(full, "house", 1, true)) then
                kind = "door"
            elseif string.find(full, "halloween", 1, true) and (string.find(full, "gacha", 1, true) or string.find(full, "roll", 1, true)
                or string.find(full, "spin", 1, true) or string.find(full, "wheel", 1, true) or string.find(full, "cauldron", 1, true)) then
                kind = "gacha"
            end
            if kind then
                local part = promptPart(d)
                local enabled = true
                if d:IsA("ProximityPrompt") then enabled = d.Enabled end
                if part and enabled then table.insert(out, {obj = d, part = part, kind = kind}) end
            end
        end
    end
    HW.list = out
end
task.spawn(function()
    while not Stopped and gui.Parent do
        if Config.halloween or Config.halloGacha then pcall(hwScan) else HW.list = {} end
        task.wait(8)
    end
end)
local function hwActivate(e)
    if e.obj:IsA("ProximityPrompt") then
        pcall(function() e.obj.HoldDuration = 0 end)
        if fireproximityprompt then pcall(fireproximityprompt, e.obj) end
    elseif fireclickdetector then
        pcall(fireclickdetector, e.obj)
    end
end
local function hwBest(kinds)
    local r = root()
    local best, bd
    for _, e in ipairs(HW.list) do
        local until_ = HW.done[e.obj]
        if kinds[e.kind] and e.obj.Parent and e.part.Parent and not (until_ and until_ > os.clock()) then
            local d = r and (e.part.Position - r.Position).Magnitude or 0
            -- portas tem prioridade sobre aboboras
            if e.kind == "door" then d = d - 100000 end
            if not bd or d < bd then best, bd = e, d end
        end
    end
    return best
end
regFeature("halloween", 35, function()
    return hwBest({door = true, pumpkin = true}) ~= nil or #targetsByNames({"pumpkin"}, {"Enemies"}) > 0
end, function(alive, setS)
    local mobs = targetsByNames({"pumpkin"}, {"Enemies"})
    if #mobs > 0 then
        local best, bd = nearestOf(mobs)
        setS("Halloween: quebrando abobora (" .. math.floor(bd or 0) .. "m) | " .. atkInfo())
        engage(best, alive, 8, false, Config.tweenSpeed, 6)
        return
    end
    local e = hwBest({door = true, pumpkin = true})
    if not e then setS("Halloween: nenhum alvo agora") task.wait(1.5) return end
    setS(e.kind == "door" and "Halloween: batendo na porta" or "Halloween: quebrando abobora")
    if moveTo(CFrame.new(e.part.Position + Vector3.new(0, 4, 0)), Config.tweenSpeed, alive) then
        equipWeapon()
        hwActivate(e)
        toolActivate()
        HW.done[e.obj] = os.clock() + (e.kind == "door" and 20 or 6)
        task.wait(0.4)
    end
end)
regFeature("halloGacha", 36, function() return hwBest({gacha = true}) ~= nil end, function(alive, setS)
    local e = hwBest({gacha = true})
    if not e then return end
    setS("Halloween Gacha: girando")
    if moveTo(CFrame.new(e.part.Position + Vector3.new(0, 4, 0)), Config.tweenSpeed, alive) then
        hwActivate(e)
        HW.done[e.obj] = os.clock() + 3
        task.wait(0.6)
    end
end)
task.spawn(function()
    while not Stopped and gui.Parent do
        if Config.halloween and #HW.list == 0 then setSt("halloween", "nenhum alvo de Halloween encontrado (o evento pode nao estar ativo)") end
        if Config.halloGacha and hwBest({gacha = true}) == nil then setSt("halloGacha", "nenhuma maquina de gacha de Halloween encontrada") end
        task.wait(3)
    end
end)
end

--==================== ABAS ====================
-- Farm Settings
T.cfg.Section("Ajustes de Click (liga/desliga na aba Main)")
T.cfg.Slider("Orion Click: golpes por frame", "1 = um golpe por frame (ja mais rapido que o Fast Click). Maior = mais rapido e mais arriscado.", 1, 12, "orionBurst")
T.cfg.Dropdown("Metodo", "Auto troca de metodo sozinho se nao causar dano.", {"Auto", "Moon", "All", "CombatFramework", "CombatFramework 2", "Remote", "Click"}, "atkMethod")
T.cfg.Slider("Intervalo do ataque (s)", "Menor = mais rapido.", 0.02, 0.2, "atkDelay")
T.cfg.Slider("Alcance do Moon (studs)", "Mobs dentro desse raio levam o golpe.", 20, 120, "moonRange")
T.cfg.Slider("Max. de mobs por golpe", "Quantos mobs o Moon acerta de uma vez.", 1, 20, "moonTargets")
T.cfg.Section("Farm")
T.cfg.Dropdown("Select Weapon", "Arma usada nos farms.", {"Melee", "Sword", "Gun", "Blox Fruit"}, "weapon")
T.cfg.Dropdown("Tween Option", "Metodo de movimento (Lerp e o mais suave).", {"Lerp", "Tween"}, "tweenMode")
T.cfg.Slider("Velocidade do Auto Chest", "studs/s (maximo 200).", 20, 200, "chestSpeed")
T.cfg.Slider("Farm Distance", "Altura/distancia ate o mob.", 3, 30, "farmDist")
T.cfg.Dropdown("Pos Method", "Onde ficar em relacao ao mob.", {"Above", "Behind", "Below"}, "posMethod")
T.cfg.Toggle("Clique do mouse (ultimo recurso)", "Desligado = o script NAO clica com o mouse; o ataque usa so fast attack e a ferramenta. Ligue so se o fast attack nao bater.", "mouseClick")
T.cfg.Toggle("Olhar para o mob", "Pode travar a camera.", "faceMob")
T.cfg.Section("Bring Mob")
T.cfg.Slider("Quantos mobs puxar", "Numero maximo de mobs puxados ao mesmo tempo (os mais proximos de voce).", 1, 30, "bringCount")
T.cfg.Slider("Alcance do Bring Mob (studs)", "So puxa mobs dentro desse raio de voce (mobs mais longe que o mapa carrega nao existem para o script).", 50, 1500, "bringDist")
T.cfg.Section("Geral")
T.cfg.Toggle("Noclip nas funcoes automaticas", "Atravessa paredes durante o farm.", "noclip")
T.cfg.Button("Menu", "Esconde o menu (RightShift tambem).", "Esconder", toggleMain)
T.cfg.Button("Fechar", "Fecha o Orion Hub.", "Fechar", destroyAll)

-- Main
T.main.Section("Auto Farm")
T.main.Feature("Auto Farm Level", "farm", "grind")
T.main.Feature("Auto Chest", "chest", "grind")
T.main.Section("Bones (Haunted Castle)")
T.main.Feature("Auto Bones", "bones", "grind")
T.main.Section("Katakuri (Cake Land)")
T.main.Feature("Auto Farm Katakuri", "cake", "grind")
T.main.Toggle("Ignorar Katakuri", "So farma os mobs, sem atacar o boss.", "ignoreKat")
T.main.Feature("Katakuri Quest", "cakeQuest", "grind")
T.main.Section("Evento de Halloween")
T.main.Feature("Auto Halloween Event", "halloween")
T.main.Feature("Auto Roll Gacha Halloween", "halloGacha")
T.main.Note("Halloween: quebra as aboboras e, quando a porta libera (horario do evento), vai bater nela. Se o evento nao estiver ativo no servidor, o status avisa que nao achou nada.")
T.main.Section("Ajustes rapidos (mais em Farm Settings)")
T.main.Slider("Tweening Speed", "Velocidade do tween em studs/s (maximo 200).", 20, 200, "tweenSpeed")
T.main.Toggle("Auto Haki", "Liga o Buso Haki automaticamente.", "haki")
T.main.Toggle("Fast Click", "Clique rapido nos mobs (troca de metodo sozinho se nao bater).", "fast")
T.main.Toggle("Orion Click", "Super click: um golpe por frame ou mais, mais rapido que o Fast Click (valores altos podem kickar).", "orionClick")
T.main.Toggle("Bring Mob", "Junta os mobs da quest num ponto abaixo de voce sem atrapalhar o Fast Attack (precisa de sethiddenproperty).", "bringMob")

-- Auto Status (agora na aba Main): coloca N pontos em cada status escolhido; a sobra vai para o status "da sobra"
T.main.Section("Auto Status")
T.main.MultiSelect("Select Status", "Escolha onde colocar os pontos (pode marcar varios).", {
    {label = "Soco (Melee)", key = "statMelee"}, {label = "Defesa (Defense)", key = "statDefense"},
    {label = "Sword", key = "statSword"}, {label = "Gun", key = "statGun"}, {label = "Fruta (Blox Fruit)", key = "statFruit"},
})
T.main.Slider("Pontos por status", "Quantos pontos vao em cada status escolhido a cada rodada (ex.: 1).", 1, 50, "statPer")
T.main.Dropdown("Sobra de pontos", "Para onde vao os pontos que sobrarem. Automatico = o status escolhido que esta mais baixo.",
    {"Automatico", "Melee", "Defense", "Sword", "Gun", "Demon Fruit"}, "statLeft")
local statsLbl = T.main.Note("Auto Status: desligado")
T.main.Toggle("Auto Status", "Distribui os pontos disponiveis: N em cada status marcado e a sobra no status da sobra.", "autoStats", function(on)
    if not on then statsLbl.Text = "Auto Status: desligado" end
end)
task.spawn(function()
    local STAT_LIST = {
        {key = "statMelee", name = "Melee"}, {key = "statDefense", name = "Defense"}, {key = "statSword", name = "Sword"},
        {key = "statGun", name = "Gun"}, {key = "statFruit", name = "Demon Fruit"},
    }
    local function statValue(nm)
        local ok, v = pcall(function() return lp.Data.Stats[nm].Level.Value end)
        return ok and tonumber(v) or nil
    end
    while not Stopped and gui.Parent do
        if Config.autoStats then
            local chosen = {}
            for _, st in ipairs(STAT_LIST) do
                if Config[st.key] then table.insert(chosen, st.name) end
            end
            local points = 0
            pcall(function() points = tonumber(lp.Data.Points.Value) or 0 end)
            if #chosen == 0 then
                statsLbl.Text = "Auto Status: marque pelo menos um status em Select Status"
            elseif points <= 0 then
                statsLbl.Text = "Auto Status: sem pontos disponiveis"
            else
                local remaining = points
                local per = math.max(1, math.floor(Config.statPer))
                local given = {}
                for _, nm in ipairs(chosen) do
                    local amt = math.min(per, remaining)
                    if amt > 0 then
                        invoke("AddPoint", nm, amt)
                        remaining = remaining - amt
                        table.insert(given, nm .. " +" .. amt)
                    end
                end
                if remaining > 0 then
                    local target = Config.statLeft
                    if target == "Automatico" or target == "" or target == nil then
                        target = chosen[1]
                        local low = statValue(chosen[1])
                        for _, nm in ipairs(chosen) do
                            local v = statValue(nm)
                            if v and (not low or v < low) then target, low = nm, v end
                        end
                    end
                    invoke("AddPoint", target, remaining)
                    table.insert(given, target .. " +" .. remaining .. " (sobra)")
                end
                statsLbl.Text = "Auto Status: " .. table.concat(given, " | ")
            end
        end
        task.wait(1.5)
    end
end)

-- Multi Farm
T.multi.Note("Multi Farm: combine alvos e atividades. Funcoes de prioridade (fruta, bosses) interrompem o farm e ele volta sozinho.")
T.multi.Section("Fabrica (Sea 2)")
T.multi.Feature("Auto Factory", "factory")
T.multi.Note("Auto Factory: quando o evento da Fabrica aparece no Sea 2, o script vai ate o Core e ataca ate destruir; depois o farm volta sozinho.")
T.multi.Section("Elite Hunter")
T.multi.Feature("Auto Elite Hunter", "elite", "grind")
T.multi.Section("Boss Rip Indra")
T.multi.Feature("Kill Rip Indra", "killIndra")
T.multi.Feature("Summon Rip Indra", "sumIndra")
T.multi.Feature("Auto Touch Pad Haki", "pads")
T.multi.Section("Boss Soul Reaper")
T.multi.Feature("Kill Soul Reaper", "killReaper")
T.multi.Feature("Summon Soul Reaper", "sumReaper")
T.multi.Section("Darkbeard")
T.multi.Feature("Kill Darkbeard", "killBeard")
T.multi.Feature("Summon Darkbeard", "sumBeard")
T.multi.Feature("Hop Server Darkbeard", "hopBeard", "grind")
T.multi.Slider("Altura nos bosses", "Distancia do boss.", 4, 40, "bossHeight")
T.multi.Toggle("Skills nos bosses", "Usa Z X C V.", "bossSkills")

-- Quests
T.quests.Section("Sea 1")
T.quests.Feature("Quest Saber", "saber", "grind")
T.quests.Feature("Quest Second Sea", "sea2Quest", "grind")
T.quests.Section("Sea 2")
T.quests.Feature("Auto Bartilo Quest", "bartilo", "grind")
T.quests.Feature("Quest Third Sea", "sea3Quest", "grind")
T.quests.Section("Sea 3")
T.quests.Feature("Auto Citizen Quest", "citizen", "grind")
T.quests.Note("Quest Saber / Second Sea / Third Sea: melhor esforco (ataca os bosses e usa os comandos do jogo); partes de puzzle sao manuais. Saber: o Saber Expert so toma dano depois dos puzzles (tochas, copo, Mob Leader); o status mostra o HP dele e avisa quando ele nao perde vida. Bartilo: Swan Pirates e Jeremy sao automaticos; a parte do Coliseu e manual. Citizen: pega a quest e mata o Captain Elephant.")

-- Race
local raceLbl = T.race.Note("Detectando sua raca...")
T.race.Section("Evolucao")
T.race.Feature("Auto Race V2 (Alchemist)", "raceV2", "grind")
T.race.Feature("Auto Race V3", "raceV3", "grind")
T.race.Note("V2: aceita a quest do Alchemist, junta as 3 flores e entrega. V3: vai ate o NPC e pede a quest; o trial da raca voce conclui seguindo o jogo.")
task.spawn(function()
    while not Stopped and gui.Parent do
        local race, ver = raceInfo()
        raceLbl.Text = "Sua raca: " .. race .. "  |  Versao: V" .. ver .. (ver >= 2 and " (evoluida)" or "")
        task.wait(3)
    end
end)

-- Raids
T.raids.Section("Chip")
T.raids.Dropdown("Select Raid", "Qual raid voce quer fazer.", RAID_TYPES, "raidType")
T.raids.Feature("Auto Buy Chip", "buyChip")
T.raids.Toggle("Pagar chip com fruta ruim", "Usa a fruta mais barata da mochila (nunca as boas) em vez de beli.", "badFruit")
T.raids.Section("Raid")
T.raids.Feature("Auto Farm Raid", "raid")
T.raids.Feature("Auto Awaken Fruit", "awaken")
T.raids.Note("Auto Raid inicia a raid sozinho quando voce tem o chip e, dentro dela, voa ate os inimigos com fast attack.")

-- Trials (aba Race)
T.race.Section("Transformacao da raca")
T.race.Toggle("Auto Ativar V3", "Aperta Y sozinho quando a energia da raca enche.", "actV3")
T.race.Toggle("Auto Ativar V4", "Mesmo para a V4.", "actV4")
T.race.Note("Ativa a transformacao da raca automaticamente durante o farm.")

-- Sea Event
T.sea.Note("Ligue um ou mais eventos e fique no mar. Ele espera o monstro aparecer, voa ate ele e ataca de cima.")
local seaStatus = T.sea.Note("Status: desligado")
statusSetters.sea = function(t) seaStatus.Text = "Status: " .. t end
T.sea.Section("Auto Boat")
T.sea.Feature("Auto Boat", "autoBoat", "grind")
T.sea.Dropdown("Tipo de barco", "Barco comprado no vendedor (Luxury Boat Dealer).", {"PirateBrigade", "PirateGrandBrigade", "MarineBrigade", "MarineGrandBrigade", "PirateSloop", "MarineSloop"}, "boatType")
T.sea.Slider("Velocidade do barco", "studs/s enquanto navega.", 30, 300, "boatSpeed")
T.sea.Note("Auto Boat: voa ate o vendedor de barcos, compra o barco (repete ate aparecer), senta e navega pelo mar. Quando um monstro marcado em Eventos aparece, o barco para, voce sai e mata com fast attack; depois ele volta a navegar. Ligue tambem os eventos abaixo.")
T.sea.Section("Eventos")
for _, ev in ipairs(SEA_EVENTS) do T.sea.Toggle(ev.label, "Ataca quando aparecer.", ev.key) end
T.sea.Section("Ajustes")
T.sea.Slider("Altura sobre o alvo", "Studs acima do monstro.", 10, 100, "seaHeight")
T.sea.Slider("Velocidade ate o alvo", "studs/s (maximo 200).", 20, 200, "seaSpeed")
T.sea.Toggle("Skills nos eventos", "Usa Z X C V (necessario no Leviathan).", "seaSkills")
T.sea.Toggle("Travar camera no alvo", "Opcional.", "aimCam")

-- Fruits
T.fruit.Section("Auto Find Fruit")
T.fruit.Feature("Auto Find Fruit", "fruit")
T.fruit.Toggle("Server Hop", "Troca de servidor quando nao tem fruta (so se nenhum farm estiver ligado).", "hop")
T.fruit.Toggle("Armazenar fruta", "Guarda a fruta no inventario ao pegar.", "store")
T.fruit.Slider("Esperar antes do hop (s)", "Tempo sem fruta antes de trocar.", 3, 30, "hopDelay")
T.fruit.Slider("Velocidade ate a fruta", "studs/s (maximo 200).", 20, 200, "fruitSpeed")
ownedLabel = T.fruit.Note("Minhas frutas detectadas: (ainda nao detectado)")
T.fruit.Button("Trocar de servidor", "Vai para outro servidor agora.", "Hop", function()
    serverHop(function(t) setSt("fruit", t) end)
end)
T.fruit.Button("Atualizar minhas frutas", "Le a mochila e o inventario.", "Atualizar", function() captureBase() refreshOwned() end)
T.fruit.Section("Gacha")
T.fruit.Feature("Auto Roll Gacha", "gacha")
T.fruit.Slider("Intervalo entre giros (s)", "Tempo entre um giro e outro (minimo 1.5).", 1.5, 10, "gachaDelay")
T.fruit.Feature("Auto Armazenar Fruta", "autoStore")
T.fruit.Note("Auto Armazenar Fruta: guarda no inventario qualquer fruta que cair na sua mochila (do gacha, do chao ou de drop), sem andar nem parar o farm.")
T.fruit.Note("Auto Roll Gacha: gira a fruta aleatoria (Cousin) de onde voce estiver, sem andar ate o NPC e sem parar o farm. Cada giro gasta Beli.")

-- Location
do
local tpStatus = T.loc.Note("Escolha uma ilha e ligue Teleport Island.")
local islandDD
local function loadIslands()
    detectSea()
    local names = {}
    local loc = locationsFolder()
    if loc then
        for _, p in ipairs(loc:GetChildren()) do
            if not string.match(p.Name, "^Island %d") then table.insert(names, p.Name) end
        end
    end
    table.sort(names)
    islandDD.setOptions(names)
    tpStatus.Text = #names == 0 and "Nao encontrei a lista de ilhas deste mar." or ((SEA > 0 and ("Sea " .. SEA) or "Mar") .. ": " .. #names .. " ilhas.")
end
T.loc.Section("Island Teleport")
T.loc.Toggle("ESP Island", "Mostra o nome e a distancia das ilhas.", "espIsland")
islandDD = T.loc.Dropdown("Select Island", "Seleciona a ilha para teleportar.", {}, "island", nil, 6)
loadIslands()
local tpGen = 0
T.loc.Toggle("Teleport Island", "Teleporta ate a ilha selecionada (Submerged Island entra pelo submarino; Underwater City pelo redemoinho).", "tpGo", function(on)
    tpGen = tpGen + 1
    local g = tpGen
    if not on then TpBusy = false return end
    task.spawn(function()
        local function alive() return tpGen == g and not Stopped end
        local name = Config.island
        TpBusy = true
        if name == "" then
            tpStatus.Text = "Escolha uma ilha primeiro."
        elseif isSubName(name) then
            tpStatus.Text = "Indo para a Submerged Island pelo Submarine Worker..."
            local ok = enterSubmerged(alive, function(t) tpStatus.Text = t end)
            if ok then tpStatus.Text = "Voce esta na Submerged Island." end
        else
            local loc = locationsFolder()
            local obj = loc and loc:FindFirstChild(name)
            local okp, pos = pcall(function() return obj:GetPivot().Position end)
            if okp then
                -- atravessa o redemoinho (Sea 1) se a ilha estiver do outro lado
                for _ = 1, 8 do
                    if not alive() then break end
                    if ensureRegion(pos, alive, function(t) tpStatus.Text = t end) then break end
                end
                tpStatus.Text = "Indo para " .. name .. "..."
                local done = alive() and moveTo(CFrame.new(pos + Vector3.new(0, 70, 0)), Config.tpSpeed, alive)
                tpStatus.Text = done and ("Chegou em " .. name) or "Teleporte cancelado"
            else
                tpStatus.Text = "Nao consegui ler a posicao dessa ilha."
            end
        end
        TpBusy = false
        if tpGen == g then uiSet("tpGo", false) end
    end)
end)
T.loc.Slider("Velocidade do teleporte", "studs/s (maximo 200).", 50, 200, "tpSpeed")
T.loc.Button("Atualizar ilhas", "Recarrega a lista do mar atual.", "Atualizar", loadIslands)
T.loc.Section("Viajar entre mares")
local function travel(arg, label)
    tpStatus.Text = "Viajando para " .. label .. "..."
    invoke(arg)
end
T.loc.Button("Sea 1", "Viaja para o primeiro mar.", "Ir", function() travel("TravelMain", "Sea 1") end)
T.loc.Button("Sea 2", "Viaja para o segundo mar.", "Ir", function() travel("TravelDressrosa", "Sea 2") end)
T.loc.Button("Sea 3", "Viaja para o terceiro mar.", "Ir", function() travel("TravelZou", "Sea 3") end)
end

-- ESP
T.esp.Toggle("ESP Players", "Marca os jogadores.", "espPlayers")
T.esp.Toggle("ESP Fruits", "Marca frutas no chao.", "espFruits")
T.esp.Toggle("ESP Chests", "Marca baus ativos.", "espChests")
T.esp.Toggle("ESP Berries", "Marca os arbustos de berries.", "espBerries")
T.esp.Toggle("Mostrar distancia", "Metros ate o alvo.", "espDist")
T.esp.Toggle("Contornos", "Contorno colorido em jogadores e frutas.", "espOutline", function() clearESP() end)

-- Player
T.player.Toggle("Speed", "Aumenta a velocidade de corrida.", "spdOn", function(v)
    if not v then
        local h = hum()
        if h then h.WalkSpeed = 16 end
    end
end)
T.player.Slider("Velocidade", "Valor do speed.", 16, 200, "speedVal")
T.player.Toggle("Modo CFrame", "Use se o jogo resetar a velocidade.", "cfm")
T.player.Toggle("Pulo infinito", "Pula varias vezes no ar.", "infj")
T.player.Toggle("Walk on Water", "Anda sobre a agua.", "walkWater")
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
keep(UIS.JumpRequest:Connect(function()
    if Config.infj then
        local h = hum()
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end))

-- Status (tempo do servidor e informacoes)
do
T.status.Section("Servidor")
local stServer = T.status.Note("Servidor online ha: ...")
local stScript = T.status.Note("Script ativo ha: ...")
local stPlayers = T.status.Note("Jogadores: ...")
local stPerf = T.status.Note("Ping / FPS: ...")
local stJob = T.status.Note("JobId: ...")
T.status.Section("Voce")
local stMe = T.status.Note("Sea / Level / Beli: ...")
local stOn = T.status.Note("Funcoes ligadas: nenhuma")
T.status.Note("O tempo do servidor e o tempo desde que o servidor foi criado (DistributedGameTime); o do script reinicia ao executar de novo.")
do
    local fps = 60
    keep(RS.RenderStepped:Connect(function(dt)
        if dt > 0 then fps = fps * 0.92 + (1 / dt) * 0.08 end
    end))
    local function fmt(sec)
        sec = math.max(0, math.floor(sec))
        local d = math.floor(sec / 86400)
        local h = math.floor((sec % 86400) / 3600)
        local m = math.floor((sec % 3600) / 60)
        local s = sec % 60
        if d > 0 then return string.format("%d dia(s) %02dh %02dmin %02ds", d, h, m, s) end
        return string.format("%02dh %02dmin %02ds", h, m, s)
    end
    task.spawn(function()
        while not Stopped and gui.Parent do
            stServer.Text = "Servidor online ha: " .. fmt(workspace.DistributedGameTime)
            stScript.Text = "Script ativo ha: " .. fmt(os.clock() - sessionStartedAt)
            local ping = "?"
            pcall(function()
                ping = tostring(math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()))
            end)
            stPlayers.Text = "Jogadores: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers
            stPerf.Text = "Ping: " .. ping .. " ms  |  FPS: " .. math.floor(fps)
            stJob.Text = "JobId: " .. tostring(game.JobId)
            local beli = "?"
            pcall(function() beli = tostring(lp.Data.Beli.Value) end)
            stMe.Text = "Sea " .. (SEA > 0 and SEA or "?") .. "  |  Level " .. getLevel() .. "  |  Beli " .. beli
            local on = {}
            for k, o in pairs(toggles) do
                if o.isOn() then table.insert(on, k) end
            end
            table.sort(on)
            stOn.Text = "Funcoes ligadas: " .. (#on == 0 and "nenhuma" or table.concat(on, ", "))
            task.wait(1)
        end
    end)
end

end

-- Anti AFK (em Diversos)
T.misc.Section("Anti AFK")
T.misc.Toggle("Anti AFK", "Clica na tela de tempos em tempos para o jogo nao te kickar.", "afk")
T.misc.Slider("Intervalo (minutos)", "A cada quantos minutos clicar.", 1, 10, "afkMin")
T.misc.Note("Alem do clique, o Anti AFK do Roblox (Idled) fica sempre ativo.")

-- Diversos
T.misc.Section("Desempenho")
T.misc.Toggle("FPS Boost", "Tira sombras, efeitos e particulas para deixar o Roblox liso.", "fpsBoost", function(on)
    if on then applyFps() end
end)
T.misc.Toggle("FPS Boost maximo", "Tambem simplifica materiais e texturas (nao desfaz sem reentrar).", "fpsMax")
T.misc.Button("Aplicar FPS Boost agora", "Executa a limpeza agora.", "Aplicar", applyFps)

do
-- Redeem Codes: tenta todos os codigos da lista (os expirados/usados sao recusados pelo jogo)
local REDEEM_CODES = {
    "Sub2Fer999", "Enyu_is_Pro", "Magicbus", "JCWK", "Starcodeheo", "Bluxxy", "fudd10", "fudd10_v2",
    "SUB2GAMERROBOT_EXP1", "Sub2NoobMaster123", "Sub2UncleKizaru", "Sub2Daigrock", "Axiore",
    "TantaiGaming", "StrawHatMaine", "Sub2OfficialNoobie", "TheGreatAce", "KITT_RESET", "Bignews",
    "UPD16", "UPD15", "UPD14", "UPD13", "UPD12", "UPD11", "UPD10", "NOMOREHACK", "GAMERROBOT_YT",
    "CODE_SERVICE", "ADMIN_TROLL", "kittgaming", "Chandler", "EXP_5B", "3BVISIT", "2BILLION",
    "THIRDSEA", "FOURTHSEA", "RESET_5B", "SECRET_ADMIN", "StaffBattle", "SUB2GAMERROBOT_RESET1",
}
local redeeming = false
local redeemLbl
redeemLbl = T.misc.Button("Redeem Codes", "Resgata todos os codigos disponiveis de uma vez.", "Resgatar", function()
    if redeeming then return end
    redeeming = true
    task.spawn(function()
        local remotes = RepS:FindFirstChild("Remotes")
        local rd = remotes and remotes:FindFirstChild("Redeem")
        if not rd then
            redeemLbl.Text = "Remote de codigos nao encontrado"
            redeeming = false
            return
        end
        local accepted, refused = 0, 0
        for i, code in ipairs(REDEEM_CODES) do
            if Stopped then break end
            redeemLbl.Text = "Resgatando " .. i .. "/" .. #REDEEM_CODES .. ": " .. code
            local ok, res = pcall(function() return rd:InvokeServer(code) end)
            local txt = string.lower(tostring(res))
            if not ok or res == nil or res == false or string.find(txt, "invalid", 1, true)
                or string.find(txt, "expired", 1, true) or string.find(txt, "already", 1, true)
                or string.find(txt, "used", 1, true) or string.find(txt, "not ", 1, true) then
                refused = refused + 1
            else
                accepted = accepted + 1
            end
            task.wait(0.6)
        end
        redeemLbl.Text = "Pronto: " .. accepted .. " aceito(s), " .. refused .. " recusado(s) (usados ou expirados)"
        redeeming = false
    end)
end)

end

--==================== INICIO ====================
local exName = "?"
pcall(function() if identifyexecutor then exName = tostring(identifyexecutor()) end end)
task.spawn(function()
    while not Stopped and gui.Parent do
        detectSea()
        infoTop.Text = "Blox Fruit · " .. VERSION .. " · " .. (SEA > 0 and ("Sea " .. SEA) or "Sea ?") .. " · Lv " .. getLevel() .. " · " .. exName
        task.wait(2)
    end
end)
if Config.fpsBoost then applyFps() end
selectTab(T.main)
startScheduler()
print("[" .. NAME .. "] carregado")
pcall(function()
    StarterGui:SetCore("SendNotification", {Title = NAME, Text = "Carregado! Use o botao redondo para abrir/fechar.", Duration = 5})
end)
