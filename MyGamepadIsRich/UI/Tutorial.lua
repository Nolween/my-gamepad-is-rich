-- Tutoriel : une fenêtre pas à pas, montrée au premier lancement (une fois
-- par compte et par version du tutoriel), revue avec /mgir tuto ou depuis
-- l'onglet Aide, qui reprend les mêmes textes (T.HelpText).
-- Étapes : bienvenue (le principe des couches), choix de la manette, les
-- types de boutons, les boutons de base (LT, RT, LB, RB), puis — seulement
-- si la manette a des boutons en plus — logiciel de la manette, détection
-- et type de ces boutons ; ensuite les paires, la pose des actions, le
-- HUD, fin. Les étapes interactives agissent en direct.
-- À la manette : A = Suivant, B = Précédent (cadre qui prend la manette
-- tant que la fenêtre est ouverte, comme le conseille Improved Forever).
local _, ns = ...
local L = ns.L
local UI = ns.UI

local T = {}
ns.Tutorial = T

-- (à augmenter quand le tutoriel change assez pour être remontré à tous)
T.VERSION = 2

local ROW_H = 38 -- (une ligne de bouton, détection et modes)
local WIDTH, MIN_HEIGHT = 720, 360
local TEXT_WIDTH = WIDTH - 56
local READY = "|TInterface\\RaidFrame\\ReadyCheck-Ready:14:14|t "
local GREEN = { 0.25, 1, 0.25 }

local frame, current, finished
local quietUntil = 0 -- (manette ignorée juste après une détection)

local ModeLabel = ns.ModeLabel

local function Mark()
    if ns.db then ns.db.tutorialSeen = T.VERSION end
end

---------------------------------------------------------------------------
-- Les types de boutons : une carte par type (tutoriel), ou un texte (Aide,
-- page des options)
---------------------------------------------------------------------------
local TYPES = {
    { modes = { "modifier" }, how = "TYPE_MODIFIER_HOW", use = "TYPE_MODIFIER_FOR", color = { 0.35, 0.75, 1 } },
    { modes = { "target_friend", "target_enemy" }, how = "TYPE_TARGET_HOW", use = "TYPE_TARGET_FOR",
        color = { 0.3, 0.95, 0.4 } },
    { modes = { "simple" }, how = "TYPE_SIMPLE_HOW", use = "TYPE_SIMPLE_FOR", color = { 1, 0.75, 0.2 } },
    { modes = { "off" }, how = "TYPE_OFF_HOW", use = "TYPE_OFF_FOR", color = { 0.6, 0.6, 0.6 } },
}

local function TypeName(t)
    local names = {}
    for _, mode in ipairs(t.modes) do names[#names + 1] = ModeLabel(mode) end
    return table.concat(names, " / ")
end

local function Hex(c)
    return ("|cff%02x%02x%02x"):format(c[1] * 255, c[2] * 255, c[3] * 255)
end

function T.TypesText()
    local parts = {}
    for _, t in ipairs(TYPES) do
        parts[#parts + 1] = Hex(t.color) .. TypeName(t) .. "|r\n" .. L[t.how] .. "\n|cffaaaaaa" .. L[t.use] .. "|r"
    end
    return table.concat(parts, "\n\n")
end

local function BuildTypes(c)
    c.cards = {}
    for i, t in ipairs(TYPES) do
        local card = CreateFrame("Frame", nil, c)
        card:SetWidth(TEXT_WIDTH)
        local bg = card:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(1, 1, 1, 0.05)
        local stripe = card:CreateTexture(nil, "BORDER")
        stripe:SetPoint("TOPLEFT")
        stripe:SetPoint("BOTTOMLEFT")
        stripe:SetWidth(4)
        stripe:SetColorTexture(t.color[1], t.color[2], t.color[3], 0.9)
        card.name = UI.Text(card, "GameFontNormalLarge", TypeName(t))
        card.name:SetTextColor(t.color[1], t.color[2], t.color[3])
        card.name:SetPoint("TOPLEFT", 14, -6)
        card.how = UI.Text(card, "GameFontHighlight", L[t.how])
        card.how:SetPoint("TOPLEFT", card.name, "BOTTOMLEFT", 0, -4)
        card.how:SetWidth(TEXT_WIDTH - 24)
        card.how:SetJustifyH("LEFT")
        card.use = UI.Text(card, "GameFontHighlightSmall", L[t.use])
        card.use:SetTextColor(0.7, 0.7, 0.7)
        card.use:SetPoint("TOPLEFT", card.how, "BOTTOMLEFT", 0, -3)
        card.use:SetWidth(TEXT_WIDTH - 24)
        card.use:SetJustifyH("LEFT")
        c.cards[i] = card
    end
    return 10
end

-- (hauteurs selon la langue : calculées quand l'étape est montrée)
local function RefreshTypes(c)
    local y = 0
    for _, card in ipairs(c.cards) do
        local h = 6 + card.name:GetStringHeight() + 4 + card.how:GetStringHeight() + 3
            + card.use:GetStringHeight() + 8
        card:SetHeight(h)
        card:ClearAllPoints()
        card:SetPoint("TOPLEFT", 0, -y)
        y = y + h + 6
    end
    return y
end

---------------------------------------------------------------------------
-- Contenus des étapes interactives (build : crée, renvoie la hauteur ;
-- refresh : met à jour, et renvoie la hauteur si elle dépend de la manette)
---------------------------------------------------------------------------
local Refresh -- (défini plus bas)

-- Le choix de la manette : une case par préréglage, sur deux colonnes
local function BuildController(c)
    c.checks = {}
    local colW, rowH = TEXT_WIDTH / 2, 24
    local perCol = math.ceil(#ns.CONTROLLERS / 2)
    for i, def in ipairs(ns.CONTROLLERS) do
        local col, row = math.floor((i - 1) / perCol), (i - 1) % perCol
        local cb = CreateFrame("CheckButton", nil, c, "UICheckButtonTemplate")
        cb:SetSize(24, 24)
        cb:SetPoint("TOPLEFT", col * colW, -row * rowH)
        local text = UI.Text(cb, "GameFontHighlight", ns.ControllerName(def))
        text:SetPoint("LEFT", cb, "RIGHT", 2, 0)
        text:SetWidth(colW - 34)
        text:SetJustifyH("LEFT")
        text:SetWordWrap(false)
        cb:SetScript("OnClick", function()
            ns.SetController(def.id)
            Refresh()
        end)
        c.checks[def.id] = cb
    end
    return perCol * rowH
end

local function RefreshController(c)
    local id = ns.Controller().id
    for key, cb in pairs(c.checks) do cb:SetChecked(key == id) end
end

-- La manette a-t-elle des boutons supplémentaires ? (sinon, leurs étapes
-- sont sautées)
local function HasExtra()
    return #ns.ActiveIDs() > 0
end

-- Le texte de l'étape « logiciel », selon la manette choisie
function T.SetupText()
    local def = ns.Controller()
    -- (manette standard : pas de bouton supplémentaire, rien à configurer)
    if #def.names == 0 then return L.TUTO_NO_EXTRA end
    local names = {}
    for _, id in ipairs(ns.ActiveIDs()) do names[#names + 1] = ns.ButtonLabel(id) end
    local list = table.concat(names, ", ")
    local text = L.TUTO_SOFTWARE_WHY .. "\n\n"
    if def.steam then return text .. L.TUTO_SOFTWARE_STEAM:format(list) end
    local software = def.software or L.SOFTWARE_GENERIC
    text = text .. L.TUTO_SOFTWARE_VENDOR:format(software, list)
    if not def.keys then text = text .. "\n\n" .. L.TUTO_SOFTWARE_ALT:format(software) end
    return text
end

local function StartLearn(id)
    ns.Learn.Start(id, function() Refresh() end)
end

-- (les lignes des 6 emplacements existent ; on montre celles de la manette)
local function ShowRows(c)
    local ids = ns.ActiveIDs()
    for i, row in ipairs(c.rows) do
        row.id = ids[i]
        row:SetShown(row.id ~= nil)
    end
    return ids
end

local function RowFrame(c, i)
    local row = CreateFrame("Frame", nil, c)
    row:SetSize(TEXT_WIDTH, 34)
    row:SetPoint("TOPLEFT", 0, -(i - 1) * ROW_H)
    local bg = row:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(1, 1, 1, 0.05)
    row.glyph = UI.CreateGlyph(row, 26)
    row.glyph:SetPoint("LEFT", 6, 0)
    row.name = UI.Text(row, "GameFontNormal")
    row.name:SetPoint("LEFT", row.glyph, "RIGHT", 10, 0)
    row.name:SetJustifyH("LEFT")
    row.name:SetWordWrap(false)
    return row
end

local function BuildDetect(c)
    c.rows = {}
    for i in ipairs(ns.BUTTON_IDS) do
        local row = RowFrame(c, i)
        row.name:SetWidth(110)
        row.key = UI.Text(row, "GameFontHighlight")
        row.key:SetPoint("LEFT", row.name, "RIGHT", 8, 0)
        row.key:SetPoint("RIGHT", -150, 0)
        row.key:SetJustifyH("LEFT")
        row.key:SetWordWrap(false)
        row.btn = UI.Button(row, L.DETECT, 136, 24)
        row.btn:SetPoint("RIGHT", -6, 0)
        row.btn:SetScript("OnClick", function() if row.id then StartLearn(row.id) end end)
        c.rows[i] = row
    end
    c.status = UI.Text(c, "GameFontHighlightSmall")
    c.status:SetWidth(TEXT_WIDTH)
    c.status:SetJustifyH("LEFT")
    return #ns.BUTTON_IDS * ROW_H + 30
end

local function RefreshDetect(c)
    local all = true
    local ids = ShowRows(c)
    c.status:ClearAllPoints()
    c.status:SetPoint("TOPLEFT", 0, -#ids * ROW_H - 6)
    for i, id in ipairs(ids) do
        local row, def = c.rows[i], ns.Button(id)
        row.glyph:SetKey(id)
        row.name:SetText(ns.ButtonLabel(id))
        if def.key then
            row.key:SetText(READY .. ns.KeyLabel(def.key))
        else
            row.key:SetText("|cffff6060" .. L.KEY_NONE .. "|r")
            all = false
        end
    end
    if #ids == 0 then
        c.status:SetText(L.TUTO_NO_EXTRA)
    else
        c.status:SetText(all and L.TUTO_DETECT_ALL or L.TUTO_DETECT_MISSING)
    end
    return #ids * ROW_H + 30
end

-- Les cases de type d'une ligne (largeur des colonnes selon la langue ;
-- en petit si elles ne tiennent pas). onPick(row, mode) quand on coche ;
-- defaults[id] : le type par défaut d'un bouton, en vert.
local function ModeChecks(c, rows, modes, startX, onPick)
    local measure = UI.Text(c, "GameFontHighlight")
    local widths, total = {}, 0
    for i, mode in ipairs(modes) do
        measure:SetText(ModeLabel(mode))
        widths[i] = measure:GetStringWidth()
        total = total + 24 + widths[i] + 10
    end
    measure:Hide()
    local font, scale = "GameFontHighlight", 1
    if total > TEXT_WIDTH - startX then
        font = "GameFontHighlightSmall"
        scale = 0.85
    end
    for _, row in ipairs(rows) do
        row.checks = {}
        local x = startX
        for i, mode in ipairs(modes) do
            local cb = CreateFrame("CheckButton", nil, row, "UICheckButtonTemplate")
            cb:SetSize(24, 24)
            cb:SetPoint("LEFT", x, 0)
            cb.label = UI.Text(cb, font, ModeLabel(mode))
            cb.label:SetPoint("LEFT", cb, "RIGHT", 1, 0)
            cb:SetScript("OnClick", function() if row.id then onPick(row, mode) end end)
            cb:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOP")
                GameTooltip:SetText(ModeLabel(mode), 1, 0.82, 0, 1, true)
                GameTooltip:AddLine(ns.ModeDesc(mode), 1, 1, 1, true)
                if self.isDefault then GameTooltip:AddLine(L.MODE_IS_DEFAULT, GREEN[1], GREEN[2], GREEN[3], true) end
                GameTooltip:Show()
            end)
            cb:SetScript("OnLeave", function() GameTooltip:Hide() end)
            row.checks[mode] = cb
            x = x + 24 + widths[i] * scale + 10
        end
    end
end

-- Le type des boutons supplémentaires
local function BuildModes(c)
    c.rows = {}
    for i in ipairs(ns.BUTTON_IDS) do
        local row = RowFrame(c, i)
        row.name:SetWidth(70)
        c.rows[i] = row
    end
    ModeChecks(c, c.rows, ns.MODES, 116, function(row, mode)
        ns.Button(row.id).mode = mode
        ns.Apply()
        Refresh()
    end)
    c.suggest = UI.Button(c, L.TUTO_SUGGESTED, 240, 24)
    c.suggest:SetScript("OnClick", function()
        ns.ApplySuggestedModes()
        Refresh()
    end)
    return #ns.BUTTON_IDS * ROW_H + 34
end

local function RefreshModes(c)
    local ids = ShowRows(c)
    c.suggest:ClearAllPoints()
    c.suggest:SetPoint("TOPLEFT", 0, -#ids * ROW_H - 6)
    for i, id in ipairs(ids) do
        local row, def = c.rows[i], ns.Button(id)
        row.glyph:SetKey(id)
        row.name:SetText(ns.ButtonLabel(id))
        for mode, cb in pairs(row.checks) do cb:SetChecked(def.mode == mode) end
    end
    return #ids * ROW_H + 34
end

-- Le type des boutons de base (LT, RT, LB, RB) : le type par défaut en vert
local function BuildPads(c)
    c.rows = {}
    for i, id in ipairs(ns.PAD_IDS) do
        local row = RowFrame(c, i)
        row.name:SetWidth(50)
        row.id = id
        c.rows[i] = row
    end
    ModeChecks(c, c.rows, ns.PAD_MODES, 96, function(row, mode)
        ns.SetPadMode(row.id, mode)
        Refresh()
    end)
    for _, row in ipairs(c.rows) do
        local default = row.checks[ns.DEFAULT_PADS[row.id]]
        if default then
            default.isDefault = true
            default.label:SetTextColor(GREEN[1], GREEN[2], GREEN[3])
        end
    end
    c.reset = UI.Button(c, L.TUTO_PADS_DEFAULT, 240, 24)
    c.reset:SetPoint("TOPLEFT", 0, -#ns.PAD_IDS * ROW_H - 6)
    c.reset:SetScript("OnClick", function()
        for _, id in ipairs(ns.PAD_IDS) do ns.SetPadMode(id, ns.DEFAULT_PADS[id]) end
        Refresh()
    end)
    return #ns.PAD_IDS * ROW_H + 34
end

local function RefreshPads(c)
    for _, row in ipairs(c.rows) do
        row.glyph:SetKey(row.id)
        row.name:SetText(ns.ButtonLabel(row.id))
        local mode = ns.PadMode(row.id)
        for m, cb in pairs(row.checks) do cb:SetChecked(m == mode) end
    end
end

-- Les paires : toutes celles de deux boutons prêts, à cocher (deux colonnes).
-- Appuyer sur un bouton de la manette met ses paires en vert ; sur deux
-- ensemble, leur paire (le vert reste après le relâchement, pour cocher à
-- la souris).
local PAIR_ROW = 24
local pressed, pressOrder = {}, 0 -- [id] = ordre d'appui (boutons tenus)
local pairFocus = {}              -- (les 1 ou 2 derniers boutons pressés)

local function BuildPairs(c)
    c.rows = {}
    c.press = UI.Text(c, "GameFontHighlight", L.TUTO_PAIRS_PRESS)
    c.press:SetTextColor(GREEN[1], GREEN[2], GREEN[3])
    c.press:SetPoint("TOPLEFT", 0, 0)
    c.press:SetWidth(TEXT_WIDTH)
    c.press:SetJustifyH("LEFT")
    c.none = UI.Text(c, "GameFontDisable", L.PAIRS_NONE)
    c.none:SetPoint("TOPLEFT", 0, -4)
    c.none:SetWidth(TEXT_WIDTH)
    c.none:SetJustifyH("LEFT")
    return 30
end

local function PairCheck(c, i)
    local cb = c.rows[i]
    if cb then return cb end
    cb = CreateFrame("CheckButton", nil, c, "UICheckButtonTemplate")
    cb:SetSize(24, 24)
    cb.hl = cb:CreateTexture(nil, "BACKGROUND")
    cb.hl:SetPoint("LEFT", cb, "LEFT", -2, 0)
    cb.hl:SetSize(TEXT_WIDTH / 2 - 12, PAIR_ROW - 2)
    cb.hl:SetColorTexture(GREEN[1], GREEN[2], GREEN[3], 0.18)
    cb.label = UI.Text(cb, "GameFontHighlight")
    cb.label:SetPoint("LEFT", cb, "RIGHT", 2, 0)
    cb:SetScript("OnClick", function(self)
        if self.pair then ns.SetPairEnabled(self.pair.id, self:GetChecked()) end
        Refresh()
    end)
    c.rows[i] = cb
    return cb
end

-- (une ligne en vert : la paire des deux boutons pressés, ou toutes celles
-- du bouton pressé)
local function Focused(pair)
    local a, b = pairFocus[1], pairFocus[2]
    if a and b then return ns.PairOf(a, b) == pair end
    return a ~= nil and (pair.a == a or pair.b == a)
end

local function RefreshPairs(c)
    local list = {}
    for _, pair in ipairs(ns.ALL_PAIRS) do
        if ns.PairPossible(pair.id) then list[#list + 1] = pair end
    end
    c.none:SetShown(#list == 0)
    c.press:SetShown(#list > 0)
    local top = #list > 0 and (c.press:GetStringHeight() + 10) or 0
    local perCol = math.ceil(#list / 2)
    for i, pair in ipairs(list) do
        local cb = PairCheck(c, i)
        local col, row = math.floor((i - 1) / perCol), (i - 1) % perCol
        cb:ClearAllPoints()
        cb:SetPoint("TOPLEFT", col * (TEXT_WIDTH / 2), -top - row * PAIR_ROW)
        cb.pair = pair
        cb:SetChecked(ns.PairEnabled(pair.id))
        cb.label:SetText(ns.ButtonLabel(pair.id))
        local lit = Focused(pair)
        cb.hl:SetShown(lit)
        if lit then
            cb.label:SetTextColor(GREEN[1], GREEN[2], GREEN[3])
        else
            cb.label:SetTextColor(1, 1, 1)
        end
        cb:Show()
    end
    for i = #list + 1, #c.rows do
        c.rows[i]:Hide()
        c.rows[i].pair = nil
    end
    return #list == 0 and 30 or top + perCol * PAIR_ROW + 4
end

-- Un bouton de la manette pressé / relâché pendant l'étape des paires :
-- un bouton de base (manette) ou supplémentaire (sa touche clavier)
local function PairPress(id, down)
    if not id then return end
    if down then
        if not pressed[id] then
            pressOrder = pressOrder + 1
            pressed[id] = pressOrder
        end
        -- (les deux derniers tenus, le plus récent d'abord)
        local list = {}
        for held in pairs(pressed) do list[#list + 1] = held end
        table.sort(list, function(x, y) return pressed[x] > pressed[y] end)
        pairFocus = { list[1], list[2] }
        Refresh()
    else
        pressed[id] = nil
    end
end

-- Le HUD : où va la bande des miniatures (en bas par défaut), appliqué tout de suite
local STRIP = { { "bottom", "TUTO_STRIP_BOTTOM" }, { "top", "TUTO_STRIP_TOP" } }

local function BuildHud(c)
    local label = UI.Text(c, "GameFontNormal", L.TUTO_STRIP_LABEL)
    label:SetPoint("TOPLEFT", 0, -6)
    c.checks = {}
    local x = label:GetStringWidth() + 14
    for _, def in ipairs(STRIP) do
        local pos = def[1]
        local cb = CreateFrame("CheckButton", nil, c, "UICheckButtonTemplate")
        cb:SetSize(24, 24)
        cb:SetPoint("LEFT", label, "LEFT", x, 0)
        local text = UI.Text(cb, "GameFontHighlight", L[def[2]])
        text:SetPoint("LEFT", cb, "RIGHT", 2, 0)
        cb:SetScript("OnClick", function()
            if ns.Hud then ns.Hud.SetStrip(pos) end
            Refresh()
        end)
        c.checks[pos] = cb
        x = x + 30 + text:GetStringWidth() + 24
    end
    return 30
end

local function RefreshHud(c)
    local pos = ns.Hud and ns.Hud.Strip() or "bottom"
    for key, cb in pairs(c.checks) do cb:SetChecked(key == pos) end
end

---------------------------------------------------------------------------
-- Les étapes (skip : sautée tant que la fonction renvoie vrai)
---------------------------------------------------------------------------
local function NoExtra() return not HasExtra() end

local STEPS = {
    { key = "welcome", title = "TUTO_WELCOME_TITLE", text = "TUTO_WELCOME_TEXT" },
    { key = "controller", title = "TUTO_CONTROLLER_TITLE", text = "TUTO_CONTROLLER_TEXT", build = BuildController,
        refresh = RefreshController },
    { key = "types", title = "TUTO_TYPES_TITLE", text = "TUTO_TYPES_TEXT", build = BuildTypes, refresh = RefreshTypes,
        helpExtra = T.TypesText },
    { key = "pads", title = "TUTO_PADS_TITLE", text = "TUTO_PADS_TEXT", build = BuildPads, refresh = RefreshPads },
    { key = "software", title = "TUTO_SOFTWARE_TITLE", textFn = T.SetupText, skip = NoExtra },
    { key = "detect", title = "TUTO_DETECT_TITLE", text = "TUTO_DETECT_TEXT", build = BuildDetect,
        refresh = RefreshDetect, help = "TUTO_DETECT_MISSING", skip = NoExtra },
    { key = "modes", title = "TUTO_MODES_TITLE", text = "TUTO_MODES_TEXT", build = BuildModes, refresh = RefreshModes,
        skip = NoExtra },
    { key = "pairs", title = "TUTO_PAIRS_TITLE", text = "TUTO_PAIRS_TEXT", build = BuildPairs, refresh = RefreshPairs },
    { key = "actions", title = "TUTO_ACTIONS_TITLE", text = "TUTO_ACTIONS_TEXT" },
    { key = "hud", title = "TUTO_HUD_TITLE", text = "TUTO_HUD_TEXT", build = BuildHud, refresh = RefreshHud },
    { key = "done", title = "TUTO_DONE_TITLE", text = "TUTO_DONE_TEXT" },
}

local function Skipped(s)
    return s.skip ~= nil and s.skip()
end

local function StepText(s)
    return s.textFn and s.textFn() or L[s.text]
end

-- Le texte de l'onglet Aide : les étapes (sauf la bienvenue et la fin), à la suite
function T.HelpText()
    local parts = { L.TUTO_WELCOME_TEXT:match("^(.-)\n\n[^\n]*$") or L.TUTO_WELCOME_TEXT }
    for i = 2, #STEPS - 1 do
        local s = STEPS[i]
        if not Skipped(s) then
            local block = "|cffffd100" .. L[s.title] .. "|r\n" .. StepText(s)
            if s.helpExtra then block = block .. "\n\n" .. s.helpExtra() end
            if s.help then block = block .. "\n" .. L[s.help] end
            parts[#parts + 1] = block
        end
    end
    parts[#parts + 1] = "|cffffd100" .. L.TUTO_DONE_TITLE .. "|r\n" .. L.TUTO_DONE_TEXT
    return table.concat(parts, "\n\n")
end

---------------------------------------------------------------------------
-- La fenêtre
---------------------------------------------------------------------------
local function PadEnabled()
    return ns.CVar("GamePadEnable") == "1"
end

local function SetPadInput(on)
    if frame and frame.EnableGamePadButton then pcall(frame.EnableGamePadButton, frame, on and true or false) end
end

-- La position d'une étape parmi celles montrées, et leur nombre
local function Position(i)
    local n, pos = 0, 0
    for k, s in ipairs(STEPS) do
        if not Skipped(s) then
            n = n + 1
            if k == i then pos = n end
        end
    end
    return pos, n
end

local function Show(i)
    local was = current
    current = math.max(1, math.min(#STEPS, i))
    local step = STEPS[current]
    -- (étape des paires : touches des boutons supplémentaires lues ;
    -- en y arrivant, plus rien en vert)
    if step.key == "pairs" and was ~= current then
        wipe(pressed)
        pairFocus = {}
    end
    if not InCombatLockdown() then pcall(frame.EnableKeyboard, frame, step.key == "pairs") end
    for _, s in ipairs(STEPS) do
        if s.content then s.content:Hide() end
    end
    frame.stepTitle:SetText(L[step.title])
    frame.body:SetText(StepText(step))

    local contentHeight = 0
    if step.build then
        if not step.content then
            step.content = CreateFrame("Frame", nil, frame)
            step.content:SetSize(TEXT_WIDTH, 10)
            step.height = step.build(step.content)
        end
        step.content:ClearAllPoints()
        step.content:SetPoint("TOPLEFT", frame.body, "BOTTOMLEFT", 0, -16)
        step.content:Show()
        -- (hauteur selon la manette choisie, sinon celle de la construction)
        local height = step.refresh and step.refresh(step.content) or step.height
        step.content:SetHeight(height)
        contentHeight = height + 16
    end

    local pos, n = Position(current)
    frame.progress:SetText(("%d / %d"):format(pos, n))
    frame.back:SetEnabled(current > 1)
    frame.next:SetText(current == #STEPS and L.TUTO_FINISH or L.TUTO_NEXT)

    -- (hauteur selon le texte, qui change avec la langue)
    local height = 44 + frame.stepTitle:GetStringHeight() + 14 + frame.body:GetStringHeight()
        + contentHeight + 70
    frame:SetHeight(math.max(MIN_HEIGHT, height))
end

-- (le contenu change de hauteur : paires, boutons de la manette...)
function Refresh()
    if not (frame and frame:IsShown() and current) then return end
    local step = STEPS[current]
    if step.refresh and step.content then Show(current) end
end

local function Next()
    local i = current + 1
    while i <= #STEPS and Skipped(STEPS[i]) do i = i + 1 end
    if i <= #STEPS then
        Show(i)
    else
        finished = true
        Mark()
        frame:Hide()
        ns.UI.Show("actions")
    end
end

local function Back()
    local i = current - 1
    while i > 1 and Skipped(STEPS[i]) do i = i - 1 end
    if i >= 1 then Show(i) end
end

-- Une indication de bouton de manette à gauche d'un bouton
local function PadHint(button, key)
    local g = UI.CreateGlyph(button, 20)
    g:SetPoint("RIGHT", button, "LEFT", -4, 0)
    g:SetKey(key)
    return g
end

local function Build()
    local ok, f = pcall(CreateFrame, "Frame", "MyGamepadIsRichTutorial", UIParent, "BasicFrameTemplateWithInset")
    if not ok or not f then
        f = UI.Panel(UIParent, "MyGamepadIsRichTutorial")
        local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -2, -2)
    end
    frame = f
    f:SetSize(WIDTH, MIN_HEIGHT)
    f:SetPoint("CENTER", 0, 40)
    f:SetFrameStrata("DIALOG")
    f:SetToplevel(true)
    f:SetClampedToScreen(true)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    tinsert(UISpecialFrames, "MyGamepadIsRichTutorial")

    local title = f.TitleText or (f.TitleContainer and f.TitleContainer.TitleText)
    if not title then
        title = UI.Text(f, "GameFontNormal")
        title:SetPoint("TOP", 0, -6)
    end
    title:SetText(L.TITLE .. " - " .. L.TUTO_TITLE)

    f.stepTitle = UI.Text(f, "GameFontNormalLarge")
    f.stepTitle:SetPoint("TOPLEFT", 28, -42)
    f.stepTitle:SetWidth(TEXT_WIDTH)
    f.stepTitle:SetJustifyH("LEFT")

    f.body = UI.Text(f, "GameFontHighlight")
    f.body:SetPoint("TOPLEFT", f.stepTitle, "BOTTOMLEFT", 0, -14)
    f.body:SetWidth(TEXT_WIDTH)
    f.body:SetJustifyH("LEFT")
    f.body:SetSpacing(3)

    f.skip = UI.Button(f, L.TUTO_SKIP, 170, 24)
    f.skip:SetPoint("BOTTOMLEFT", 16, 16)
    f.skip:SetScript("OnClick", function() f:Hide() end)

    f.next = UI.Button(f, L.TUTO_NEXT, 180, 24)
    f.next:SetPoint("BOTTOMRIGHT", -16, 16)
    f.next:SetScript("OnClick", Next)
    f.back = UI.Button(f, L.TUTO_BACK, 120, 24)
    f.back:SetPoint("RIGHT", f.next, "LEFT", -32, 0)
    f.back:SetScript("OnClick", Back)

    f.progress = UI.Text(f, "GameFontDisable")
    f.progress:SetPoint("RIGHT", f.back, "LEFT", -34, 0)

    f.padHints = { PadHint(f.next, "PAD1"), PadHint(f.back, "PAD2") }

    -- Manette : A = Suivant, B = Précédent ; à l'étape des paires, LT, RT,
    -- LB et RB allument leurs paires
    local padOf = {}
    for id, key in pairs(ns.PAD_KEY) do padOf[key] = id end
    local function OnPairsStep() return current and STEPS[current].key == "pairs" end
    -- (ne rien laisser passer au jeu, ou laisser passer cette touche :
    -- vaut aussi pour les boutons de la manette)
    local function Propagate(self, on)
        if not InCombatLockdown() then pcall(self.SetPropagateKeyboardInput, self, on) end
    end
    f:SetScript("OnGamePadButtonDown", function(self, button)
        Propagate(self, false)
        if ns.Learn.IsActive() or GetTime() < quietUntil then return end
        if OnPairsStep() and padOf[button] then PairPress(padOf[button], true) return end
        if button == "PAD1" then Next() elseif button == "PAD2" then Back() end
    end)
    f:SetScript("OnGamePadButtonUp", function(_, button)
        if padOf[button] then PairPress(padOf[button], false) end
    end)
    -- (étape des paires : les boutons supplémentaires arrivent en touches
    -- clavier ; gardées par la fenêtre, les autres touches vont au jeu)
    f:SetScript("OnKeyDown", function(self, key)
        local id = OnPairsStep() and (ns.ButtonOfKey(key) or padOf[key])
        Propagate(self, not id)
        if id then PairPress(id, true) end
    end)
    f:SetScript("OnKeyUp", function(_, key) PairPress(ns.ButtonOfKey(key) or padOf[key], false) end)
    Propagate(f, false)
    f:EnableKeyboard(false)
    SetPadInput(false) -- (poser le script l'active : on le coupe tout de suite)
    f:SetScript("OnUpdate", function()
        if ns.Learn.IsActive() then quietUntil = GetTime() + 0.4 end
    end)

    f:SetScript("OnShow", function()
        finished = false
        local pad = PadEnabled()
        for _, g in ipairs(f.padHints) do g:SetShown(pad) end
        SetPadInput(pad)
    end)
    f:SetScript("OnHide", function()
        SetPadInput(false)
        if not InCombatLockdown() then pcall(f.EnableKeyboard, f, false) end
        wipe(pressed)
        if not finished then
            Mark()
            ns.Print(L.TUTO_REOPEN)
        end
    end)
    ns.OnApplied(Refresh)
    f:Hide()
end

-- Ouvre le tutoriel à une étape (son numéro ou sa clé : « types »...),
-- sinon à la première
function T.Open(step)
    if not ns.db then return end
    if not frame then Build() end
    if ns.UI.Hide then ns.UI.Hide() end
    local index = 1
    if type(step) == "number" then
        index = step
    elseif type(step) == "string" then
        for i, s in ipairs(STEPS) do
            if s.key == step then index = i end
        end
    end
    frame:Show()
    Show(index)
end

-- Au premier lancement (ou après une nouvelle version du tutoriel) ; en
-- combat, attend sa fin
local waiter
function T.MaybeShow()
    if not ns.db or (ns.db.tutorialSeen or 0) >= T.VERSION then return end
    if InCombatLockdown() then
        if not waiter then
            waiter = CreateFrame("Frame")
            waiter:SetScript("OnEvent", function(self)
                self:UnregisterAllEvents()
                T.MaybeShow()
            end)
        end
        waiter:RegisterEvent("PLAYER_REGEN_ENABLED")
        return
    end
    T.Open(1)
end
