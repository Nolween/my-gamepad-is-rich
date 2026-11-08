-- Tutoriel : une fenêtre pas à pas, montrée au premier lancement (une fois
-- par compte et par version du tutoriel), revue avec /mgir tuto ou depuis
-- l'onglet Aide, qui reprend les mêmes textes (T.HelpText).
-- Étapes : bienvenue, GameSir Nexus, détection des boutons (en direct),
-- choix des modes (en direct), pose des actions, fin.
-- À la manette : A = Suivant, B = Précédent (cadre qui prend la manette
-- tant que la fenêtre est ouverte, comme le conseille Improved Forever).
local _, ns = ...
local L = ns.L
local UI = ns.UI

local T = {}
ns.Tutorial = T

-- (à augmenter quand le tutoriel change assez pour être remontré à tous)
T.VERSION = 1

local MAIN = { "L5", "R5", "L4", "R4" }
local MODES = { "modifier", "simple", "off" }
local SUGGESTED = { L5 = "modifier", R5 = "modifier", L4 = "simple", R4 = "simple" }
local WIDTH, MIN_HEIGHT = 640, 360
local TEXT_WIDTH = WIDTH - 56
local READY = "|TInterface\\RaidFrame\\ReadyCheck-Ready:14:14|t "

local frame, current, finished
local quietUntil = 0 -- (manette ignorée juste après une détection)

local function ModeLabel(mode)
    if mode == "modifier" then return L.MODE_MODIFIER end
    if mode == "simple" then return L.MODE_SIMPLE end
    return L.MODE_OFF
end

local function Mark()
    if ns.db then ns.db.tutorialSeen = T.VERSION end
end

---------------------------------------------------------------------------
-- Contenus des étapes interactives (build : crée, renvoie la hauteur ;
-- refresh : met à jour)
---------------------------------------------------------------------------
local Refresh -- (défini plus bas)

local function BuildWelcome(c)
    for i, id in ipairs(MAIN) do
        local g = UI.CreateGlyph(c, 40)
        g:SetPoint("TOPLEFT", (i - 1) * 56, 0)
        g:SetKey(id)
    end
    return 44
end

local function StartLearn(id)
    ns.Learn.Start(id, function() Refresh() end)
end

local function BuildDetect(c)
    c.rows = {}
    for i, id in ipairs(MAIN) do
        local row = CreateFrame("Frame", nil, c)
        row:SetSize(TEXT_WIDTH, 34)
        row:SetPoint("TOPLEFT", 0, -(i - 1) * 38)
        local bg = row:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(1, 1, 1, 0.05)
        row.glyph = UI.CreateGlyph(row, 26)
        row.glyph:SetPoint("LEFT", 6, 0)
        row.name = UI.Text(row, "GameFontNormal")
        row.name:SetPoint("LEFT", row.glyph, "RIGHT", 10, 0)
        row.name:SetWidth(110)
        row.name:SetJustifyH("LEFT")
        row.key = UI.Text(row, "GameFontHighlight")
        row.key:SetPoint("LEFT", row.name, "RIGHT", 8, 0)
        row.key:SetPoint("RIGHT", -150, 0)
        row.key:SetJustifyH("LEFT")
        row.key:SetWordWrap(false)
        row.btn = UI.Button(row, L.DETECT, 136, 24)
        row.btn:SetPoint("RIGHT", -6, 0)
        row.btn:SetScript("OnClick", function() StartLearn(id) end)
        c.rows[i] = row
    end
    c.status = UI.Text(c, "GameFontHighlightSmall")
    c.status:SetPoint("TOPLEFT", 0, -#MAIN * 38 - 6)
    c.status:SetWidth(TEXT_WIDTH)
    c.status:SetJustifyH("LEFT")
    return #MAIN * 38 + 30
end

local function RefreshDetect(c)
    local all = true
    for i, id in ipairs(MAIN) do
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
    c.status:SetText(all and L.TUTO_DETECT_ALL or L.TUTO_DETECT_MISSING)
end

local function SetMode(id, mode)
    ns.Button(id).mode = mode
    ns.Apply()
    Refresh()
end

local function BuildModes(c)
    c.rows = {}
    -- (colonnes à la largeur des libellés, qui changent avec la langue)
    local col = {}
    local measure = UI.Text(c, "GameFontHighlight")
    for i, mode in ipairs(MODES) do
        measure:SetText(ModeLabel(mode))
        col[i] = 28 + measure:GetStringWidth() + 14
    end
    measure:Hide()
    for i, id in ipairs(MAIN) do
        local row = CreateFrame("Frame", nil, c)
        row:SetSize(TEXT_WIDTH, 34)
        row:SetPoint("TOPLEFT", 0, -(i - 1) * 38)
        local bg = row:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(1, 1, 1, 0.05)
        row.glyph = UI.CreateGlyph(row, 26)
        row.glyph:SetPoint("LEFT", 6, 0)
        row.name = UI.Text(row, "GameFontNormal")
        row.name:SetPoint("LEFT", row.glyph, "RIGHT", 10, 0)
        row.name:SetWidth(90)
        row.name:SetJustifyH("LEFT")
        row.checks = {}
        local x = 150
        for m, mode in ipairs(MODES) do
            local cb = CreateFrame("CheckButton", nil, row, "UICheckButtonTemplate")
            cb:SetSize(24, 24)
            cb:SetPoint("LEFT", x, 0)
            local text = UI.Text(cb, "GameFontHighlight", ModeLabel(mode))
            text:SetPoint("LEFT", cb, "RIGHT", 2, 0)
            cb:SetScript("OnClick", function() SetMode(id, mode) end)
            row.checks[mode] = cb
            x = x + col[m]
        end
        c.rows[i] = row
    end
    local suggest = UI.Button(c, L.TUTO_SUGGESTED, 240, 24)
    suggest:SetPoint("TOPLEFT", 0, -#MAIN * 38 - 6)
    suggest:SetScript("OnClick", function()
        for id, mode in pairs(SUGGESTED) do ns.Button(id).mode = mode end
        ns.Apply()
        Refresh()
    end)
    return #MAIN * 38 + 34
end

local function RefreshModes(c)
    for i, id in ipairs(MAIN) do
        local row, def = c.rows[i], ns.Button(id)
        row.glyph:SetKey(id)
        row.name:SetText(ns.ButtonLabel(id))
        for mode, cb in pairs(row.checks) do cb:SetChecked(def.mode == mode) end
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
    local current = ns.Hud and ns.Hud.Strip() or "bottom"
    for pos, cb in pairs(c.checks) do cb:SetChecked(pos == current) end
end

---------------------------------------------------------------------------
-- Les étapes
---------------------------------------------------------------------------
local STEPS = {
    { title = "TUTO_WELCOME_TITLE", text = "TUTO_WELCOME_TEXT", build = BuildWelcome },
    { title = "TUTO_NEXUS_TITLE", text = "TUTO_NEXUS_TEXT" },
    { title = "TUTO_DETECT_TITLE", text = "TUTO_DETECT_TEXT", build = BuildDetect, refresh = RefreshDetect,
        help = "TUTO_DETECT_MISSING" },
    { title = "TUTO_MODES_TITLE", text = "TUTO_MODES_TEXT", extra = "TUTO_PAIRS_TEXT",
        build = BuildModes, refresh = RefreshModes },
    { title = "TUTO_ACTIONS_TITLE", text = "TUTO_ACTIONS_TEXT" },
    { title = "TUTO_HUD_TITLE", text = "TUTO_HUD_TEXT", build = BuildHud, refresh = RefreshHud },
    { title = "TUTO_DONE_TITLE", text = "TUTO_DONE_TEXT" },
}

-- Le texte d'une étape (et son paragraphe en plus)
local function StepText(s)
    return L[s.text] .. (s.extra and ("\n\n" .. L[s.extra]) or "")
end

-- Le texte de l'onglet Aide : les étapes (sauf la bienvenue), à la suite
function T.HelpText()
    local parts = {}
    for i = 2, #STEPS do
        local s = STEPS[i]
        local block = "|cffffd100" .. L[s.title] .. "|r\n" .. StepText(s)
        if s.help then block = block .. "\n" .. L[s.help] end
        parts[#parts + 1] = block
    end
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

local function Show(i)
    current = math.max(1, math.min(#STEPS, i))
    local step = STEPS[current]
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
            step.content:SetHeight(step.height)
        end
        step.content:ClearAllPoints()
        step.content:SetPoint("TOPLEFT", frame.body, "BOTTOMLEFT", 0, -16)
        step.content:Show()
        if step.refresh then step.refresh(step.content) end
        contentHeight = step.height + 16
    end

    frame.progress:SetText(("%d / %d"):format(current, #STEPS))
    frame.back:SetEnabled(current > 1)
    frame.next:SetText(current == #STEPS and L.TUTO_FINISH or L.TUTO_NEXT)

    -- (hauteur selon le texte, qui change avec la langue)
    local height = 44 + frame.stepTitle:GetStringHeight() + 14 + frame.body:GetStringHeight()
        + contentHeight + 70
    frame:SetHeight(math.max(MIN_HEIGHT, height))
end

function Refresh()
    if not (frame and frame:IsShown() and current) then return end
    local step = STEPS[current]
    if step.refresh and step.content then step.refresh(step.content) end
end

local function Next()
    if current < #STEPS then
        Show(current + 1)
    else
        finished = true
        Mark()
        frame:Hide()
        ns.UI.Show("actions")
    end
end

local function Back()
    if current > 1 then Show(current - 1) end
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

    -- Manette : A = Suivant, B = Précédent
    f:SetScript("OnGamePadButtonDown", function(_, button)
        if ns.Learn.IsActive() or GetTime() < quietUntil then return end
        if button == "PAD1" then Next() elseif button == "PAD2" then Back() end
    end)
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
        if not finished then
            Mark()
            ns.Print(L.TUTO_REOPEN)
        end
    end)
    ns.OnApplied(Refresh)
    f:Hide()
end

-- Ouvre le tutoriel (à l'étape donnée, sinon la première)
function T.Open(step)
    if not ns.db then return end
    if not frame then Build() end
    if ns.UI.Hide then ns.UI.Hide() end
    frame:Show()
    Show(step or 1)
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
