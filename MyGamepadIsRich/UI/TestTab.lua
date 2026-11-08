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
    intro:SetPoint("RIGHT", -16, 0)
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

    local function Push(key)
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
