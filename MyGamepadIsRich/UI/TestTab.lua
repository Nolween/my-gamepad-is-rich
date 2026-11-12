-- Onglet « Test manette » : affiche en direct ce que WoW reçoit (boutons de
-- la manette et touches clavier, dont celles que le logiciel de la manette
-- fait envoyer aux boutons supplémentaires).
local _, ns = ...
local L = ns.L
local UI = ns.UI

local STANDARD = {
    "PAD1", "PAD2", "PAD3", "PAD4", "PADDUP", "PADDDOWN", "PADDLEFT", "PADDRIGHT",
    "PADLSHOULDER", "PADRSHOULDER", "PADLTRIGGER", "PADRTRIGGER", "PADLSTICK", "PADRSTICK",
    "PADBACK", "PADFORWARD", "PADPADDLE1", "PADPADDLE2", "PADPADDLE3", "PADPADDLE4",
}
local LOG_LINES = 9
local PER_ROW = 10

local function Lamp(parent, key)
    local f = CreateFrame("Frame", nil, parent)
    f:SetSize(52, 50)
    f.lit = f:CreateTexture(nil, "BACKGROUND")
    f.lit:SetAllPoints()
    f.lit:SetColorTexture(0.2, 0.9, 0.3, 0.35)
    f.lit:Hide()
    f.glyph = UI.CreateGlyph(f, 26)
    f.glyph:SetPoint("TOP", 0, -3)
    f.glyph:SetKey(key)
    f.text = UI.Text(f, "GameFontHighlightSmall")
    f.text:SetPoint("TOP", f.glyph, "BOTTOM", 0, -2)
    f.text:SetWidth(52)
    f.text:SetWordWrap(false)
    f.text:SetText(ns.KeyLabel(key))
    return f
end

function UI.BuildTestPage(page)
    local intro = UI.Text(page, "GameFontHighlight", L.TEST_INTRO)
    intro:SetPoint("TOPLEFT", 16, -12)
    intro:SetPoint("RIGHT", -210, 0)
    intro:SetJustifyH("LEFT")

    local std = UI.Text(page, "GameFontNormal", L.TEST_STANDARD)
    std:SetPoint("TOPLEFT", 16, -56)
    local lamps = {}
    for i, key in ipairs(STANDARD) do
        local lamp = Lamp(page, key)
        local col, row = (i - 1) % PER_ROW, math.floor((i - 1) / PER_ROW)
        lamp:SetPoint("TOPLEFT", 16 + col * 56, -76 - row * 54)
        lamps[key] = lamp
    end

    local ext = UI.Text(page, "GameFontNormal", L.TEST_EXTRA)
    ext:SetPoint("TOPLEFT", 16, -196)
    local extra = {}
    for i, id in ipairs(ns.BUTTON_IDS) do
        local f = CreateFrame("Frame", nil, page)
        f:SetSize(100, 50)
        f:SetPoint("TOPLEFT", 16 + (i - 1) * 104, -216)
        f.lit = f:CreateTexture(nil, "BACKGROUND")
        f.lit:SetAllPoints()
        f.lit:SetColorTexture(0.95, 0.7, 0.1, 0.35)
        f.lit:Hide()
        f.glyph = UI.CreateGlyph(f, 26)
        f.glyph:SetPoint("TOP", 0, -3)
        f.text = UI.Text(f, "GameFontHighlightSmall")
        f.text:SetPoint("TOP", f.glyph, "BOTTOM", 0, -2)
        f.text:SetWidth(98)
        f.text:SetWordWrap(false)
        f.id = id
        extra[id] = f
    end

    local logTitle = UI.Text(page, "GameFontNormal", L.TEST_LOG)
    logTitle:SetPoint("TOPLEFT", 16, -278)
    local lines = {}
    for i = 1, LOG_LINES do
        local fs = UI.Text(page, "GameFontHighlightSmall")
        fs:SetPoint("TOPLEFT", 24, -296 - (i - 1) * 15)
        fs:SetJustifyH("LEFT")
        lines[i] = fs
    end
    local log = {}

    local function RefreshExtra()
        -- (les boutons de la manette, et un emplacement libre seulement s'il
        -- a une touche ; placés à la suite)
        for _, f in pairs(extra) do f:Hide() end
        for i, id in ipairs(ns.VisibleIDs()) do
            local f, def = extra[id], ns.Button(id)
            f:ClearAllPoints()
            f:SetPoint("TOPLEFT", 16 + (i - 1) * 104, -216)
            f:Show()
            f.glyph:SetKey(id)
            local mode = ns.ModeLabel(def.mode)
            f.text:SetText((def.key and ns.KeyLabel(def.key) or L.TEST_UNKNOWN) .. " · " .. mode)
        end
    end

    -- (ce que la page a reçu depuis l'ouverture du jeu : pour le rapport)
    local seenExtra, seenPad, seenOther, nOther = {}, {}, {}, 0
    local function Remember(key)
        local id = ns.ButtonOfKey(key)
        if id then
            seenExtra[id] = true
        elseif key:find("^PAD") then
            seenPad[key] = true
        elseif not seenOther[key] and nOther < 20 then
            seenOther[key] = true
            nOther = nOther + 1
        end
    end

    -- Un rapport à copier (Discord, GitHub...) : la manette choisie, ce que
    -- chaque bouton envoie et ce que WoW en a reçu. En anglais technique,
    -- lisible quelle que soit la langue du joueur ; aucune donnée
    -- personnelle (ni nom de personnage, ni royaume).
    local function Report()
        local lines = {}
        local function Add(fmt, ...) lines[#lines + 1] = fmt:format(...) end
        local version, build = "?", "?"
        if GetBuildInfo then version, build = GetBuildInfo() end
        Add("My Gamepad Is Rich %s | WoW %s (%s) | %s", ns.Version(), tostring(version), tostring(build),
            GetLocale and GetLocale() or "?")
        local def = ns.Controller()
        Add("Controller: %s (%s)", def.id, ns.ControllerName(def))
        for _, id in ipairs(ns.VisibleIDs()) do
            local b = ns.Button(id)
            Add("%s \"%s\": key=%s mode=%s received=%s", id, ns.ButtonLabel(id), b.key or "-", b.mode,
                seenExtra[id] and "yes" or "no")
        end
        local pads = {}
        for _, id in ipairs(ns.PAD_IDS) do pads[#pads + 1] = id .. "=" .. ns.PadMode(id) end
        Add("Base buttons: %s", table.concat(pads, " "))
        local function Keys(set)
            local out = {}
            for k in pairs(set) do out[#out + 1] = k end
            table.sort(out)
            return #out > 0 and table.concat(out, " ") or "-"
        end
        Add("Gamepad buttons received: %s", Keys(seenPad))
        Add("Other keys received: %s", Keys(seenOther))
        Add("Works / does not work: ")
        -- (le journal des couches, Diag.lua : l'état des boutons et des
        -- barres, rien de personnel ; les dernières lignes seulement)
        local log = type(ns.db.diagLog) == "table" and ns.db.diagLog or {}
        if #log > 0 then
            Add("")
            Add("Recent log:")
            for i = math.max(1, #log - 39), #log do lines[#lines + 1] = tostring(log[i]) end
        end
        return table.concat(lines, "\n")
    end

    local reportDialog
    local function OpenReport()
        if not reportDialog then
            local d = UI.Dialog("MyGamepadIsRichReport", 560, 380, L.REPORT_TITLE)
            local hint = UI.Text(d, "GameFontHighlight", L.REPORT_HINT)
            hint:SetPoint("TOPLEFT", 16, -40)
            hint:SetPoint("RIGHT", -16, 0)
            hint:SetJustifyH("LEFT")
            d.area = UI.TextArea(d, -84, 240)
            d.area.edit:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
            local close = UI.Button(d, L.CLOSE, 120, 24)
            close:SetPoint("BOTTOM", 0, 12)
            close:SetScript("OnClick", function() d:Hide() end)
            reportDialog = d
        end
        reportDialog.area.edit:SetText(Report())
        reportDialog:Show()
        reportDialog.area.edit:SetFocus()
        reportDialog.area.edit:HighlightText()
    end

    local reportButton = UI.Button(page, L.REPORT_BUTTON, 200, 22)
    reportButton:SetPoint("TOPRIGHT", -16, -274)
    reportButton:SetScript("OnClick", OpenReport)
    UI.Tip(reportButton, L.REPORT_BUTTON, L.TIP_REPORT)

    local function Push(key)
        Remember(key)
        local id = ns.ButtonOfKey(key)
        local who = id and ("|cffffd100" .. ns.ButtonLabel(id) .. "|r")
            or (key:find("^PAD") and ("|cff88ff88" .. L.TEST_GAME .. "|r"))
            or ("|cff999999" .. L.TEST_UNKNOWN .. "|r")
        table.insert(log, 1, ("%s  %s  ->  %s"):format(date("%H:%M:%S"), ns.KeyLabel(key) .. (key ~= ns.KeyLabel(key) and (" (" .. key .. ")") or ""), who))
        while #log > LOG_LINES do table.remove(log) end
        for i = 1, LOG_LINES do lines[i]:SetText(log[i] or "") end
    end

    local function Light(key, on)
        if lamps[key] then lamps[key].lit:SetShown(on) end
        local id = ns.ButtonOfKey(key)
        if id then extra[id].lit:SetShown(on) end
    end

    local function Down(_, key)
        Light(key, true)
        Push(key)
    end
    local function Up(_, key) Light(key, false) end

    -- (la page laisse passer les touches au jeu ; ce réglage est interdit en
    -- combat : sans lui, on n'écoute pas, pour ne jamais avaler une touche)
    local propagates = false
    local function EnsurePropagate()
        if propagates then return true end
        if not page.SetPropagateKeyboardInput then propagates = true return true end
        if InCombatLockdown() then return false end
        page:SetPropagateKeyboardInput(true)
        propagates = true
        return true
    end
    page:SetScript("OnKeyDown", Down)
    page:SetScript("OnKeyUp", Up)
    page:SetScript("OnGamePadButtonDown", Down)
    page:SetScript("OnGamePadButtonUp", Up)
    page:SetScript("OnShow", function(self)
        RefreshExtra()
        if not EnsurePropagate() then return end
        self:EnableKeyboard(true)
        if self.EnableGamePadButton then self:EnableGamePadButton(true) end
    end)
    page:SetScript("OnHide", function(self)
        self:EnableKeyboard(false)
        if self.EnableGamePadButton then self:EnableGamePadButton(false) end
        for _, lamp in pairs(lamps) do lamp.lit:Hide() end
        for _, f in pairs(extra) do f.lit:Hide() end
    end)
    page.RefreshExtra = RefreshExtra
end
