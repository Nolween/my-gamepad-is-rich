-- Fenêtre de configuration, organisée par tâche :
--   Actions : chaque couche (barre manette du jeu : seul, LT, RT, LT + RT ;
--             modificateurs et paires ; boutons simples), disposée comme la
--             manette : la croix à gauche, A/B/X/Y à droite (comme le HUD) ;
--   Boutons : les boutons supplémentaires (nom, touche, mode) et les paires ;
--   Profils : UI/ProfilesTab.lua (liste, export, import) ;
--   HUD     : affichage, miniatures, taille, position, bouton de la minimap ;
--   Test manette, Aide.
-- Et la page dans Options > AddOns.
local _, ns = ...
local L = ns.L
local UI = ns.UI

local WIDTH, HEIGHT = 820, 600
local LIST_W = 214
local frame, pages, tabs = nil, {}, {}
local currentTab = "actions"
local RefreshAll

local DPAD_KEYS = { "PADDLEFT", "PADDUP", "PADDRIGHT", "PADDDOWN" }
local FACE_KEYS = { "PAD3", "PAD4", "PAD2", "PAD1" }
local SPOTS = { { -1, 0 }, { 0, 1 }, { 1, 0 }, { 0, -1 } }

local function IsLoaded(name)
    if C_AddOns and C_AddOns.IsAddOnLoaded then return C_AddOns.IsAddOnLoaded(name) end
    return IsAddOnLoaded and IsAddOnLoaded(name)
end

local function ModeLabel(mode)
    if mode == "modifier" then return L.MODE_MODIFIER end
    if mode == "simple" then return L.MODE_SIMPLE end
    return L.MODE_OFF
end

local function Separator(parent, x1, y1, x2, y2)
    local t = parent:CreateTexture(nil, "BACKGROUND")
    t:SetColorTexture(1, 1, 1, 0.12)
    t:SetPoint("TOPLEFT", x1, y1)
    t:SetPoint("BOTTOMRIGHT", parent, "TOPLEFT", x2, y2)
    return t
end

-- Des pastilles de boutons à la suite (« LT + RT », « L5 + R5 »)
local function Tag(parent, size)
    local tag = CreateFrame("Frame", nil, parent)
    tag:SetSize(size, size)
    tag.size = size
    tag.glyphs = { UI.CreateGlyph(tag, size), UI.CreateGlyph(tag, size) }
    tag.plus = UI.Text(tag, "GameFontNormal", "+")
    return tag
end

local function SetTag(tag, keys)
    local x = 0
    for _, g in ipairs(tag.glyphs) do g:Hide() end
    tag.plus:Hide()
    for i, key in ipairs(keys) do
        if i == 2 then
            tag.plus:ClearAllPoints()
            tag.plus:SetPoint("LEFT", x + 2, 0)
            tag.plus:Show()
            x = x + tag.plus:GetStringWidth() + 4
        end
        local g = tag.glyphs[i]
        if g then
            g:SetKey(key)
            g:ClearAllPoints()
            g:SetPoint("LEFT", x, 0)
            g:Show()
            x = x + tag.size
        end
    end
    tag:SetWidth(math.max(x, 1))
end

---------------------------------------------------------------------------
-- Les couches : { bar = "leftBar" } | { mod = "L5" / "L5R5" } | { simple = "L4" }
---------------------------------------------------------------------------
local selected = { bar = "topBar" }

local function Same(a, b)
    return a ~= nil and b ~= nil and a.bar == b.bar and a.mod == b.mod and a.simple == b.simple
end

local function Sections()
    -- (la barre manette : ses couches LT / RT / LT + RT sont celles de
    -- l'addon quand le profil lui donne les gâchettes)
    local pad = { title = L.SECTION_PAD, items = {} }
    for _, name in ipairs(ns.Bar.NAMES) do
        if not ns.GameBarReplaced(name) then pad.items[#pad.items + 1] = { bar = name } end
    end
    if ns.TriggersOn() then
        for _, id in ipairs({ "LT", "RT", ns.TRIGGER_PAIR.id }) do pad.items[#pad.items + 1] = { mod = id } end
    end
    local mods = { title = L.SECTION_MODS, items = {}, empty = L.SECTION_MODS_EMPTY }
    for _, id in ipairs(ns.LIST_IDS) do
        if ns.IsModLayer(id) and not ns.TRIGGER_LAYERS[id] then mods.items[#mods.items + 1] = { mod = id } end
    end
    local simple = { title = L.SECTION_SIMPLE, items = {}, empty = L.SECTION_SIMPLE_EMPTY }
    for _, id in ipairs(ns.BUTTON_IDS) do
        local def = ns.Button(id)
        if def.mode == "simple" and def.key then simple.items[#simple.items + 1] = { simple = id } end
    end
    return { pad, mods, simple }
end

local function LayerKeys(layer)
    if layer.bar then return ns.Bar.KEYS[layer.bar] end
    local pair = layer.mod and ns.PairDef(layer.mod)
    if pair then return { pair.a, pair.b } end
    return { layer.mod or layer.simple }
end

local function LayerName(layer)
    if layer.bar == "topBar" then return L.LAYER_BASE end
    if layer.bar then
        local names = {}
        for _, key in ipairs(ns.Bar.KEYS[layer.bar]) do names[#names + 1] = ns.KeyLabel(key) end
        return table.concat(names, " + ")
    end
    return ns.ButtonLabel(layer.mod or layer.simple)
end

-- La phrase sous le titre : comment on déclenche cette couche
local function LayerDesc(layer)
    if layer.bar == "topBar" then return L.LAYER_DESC_BASE end
    if layer.bar then return L.LAYER_DESC_HOLD:format(LayerName(layer)) end
    local pair = layer.mod and ns.PairDef(layer.mod)
    if pair then return L.PAIR_DESC:format(ns.ButtonLabel(pair.a), ns.ButtonLabel(pair.b)) end
    if layer.mod then return L.LAYER_DESC_HOLD:format(LayerName(layer)) end
    return L.MODE_SIMPLE_DESC
end

-- Remplies / modifiables
local function LayerCount(layer)
    if layer.bar then return ns.Bar.CountView(layer.bar) end
    local actions = ns.ButtonActions(layer.mod or layer.simple)
    local n = 0
    if layer.mod then
        for _, key in ipairs(ns.PAD_KEYS) do if actions.combos[key] then n = n + 1 end end
        return n, 8
    end
    for _, l in ipairs(ns.LAYERS) do if actions.layers[l] then n = n + 1 end end
    return n, 3
end

-- (la couche choisie n'existe plus : retour à la première)
local function CheckSelected()
    for _, section in ipairs(Sections()) do
        for _, item in ipairs(section.items) do
            if Same(item, selected) then return end
        end
    end
    selected = { bar = "topBar" }
end

---------------------------------------------------------------------------
-- Onglet Actions : la liste des couches (gauche)
---------------------------------------------------------------------------
local list, entryPool, headerPool = nil, {}, {}

local function Entry(i)
    local e = entryPool[i]
    if e then return e end
    e = CreateFrame("Button", nil, list)
    e:SetSize(LIST_W - 16, 34)
    local bg = e:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(1, 1, 1, 0.04)
    e.sel = e:CreateTexture(nil, "BORDER")
    e.sel:SetAllPoints()
    e.sel:SetColorTexture(0.95, 0.7, 0.1, 0.25)
    e:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
    e.tag = Tag(e, 22)
    e.tag:SetPoint("LEFT", 6, 0)
    e.name = UI.Text(e, "GameFontNormal")
    e.name:SetPoint("LEFT", 70, 0)
    e.name:SetPoint("RIGHT", -44, 0)
    e.name:SetJustifyH("LEFT")
    e.name:SetWordWrap(false)
    e.count = UI.Text(e, "GameFontHighlightSmall")
    e.count:SetPoint("RIGHT", -8, 0)
    e:SetScript("OnClick", function(self)
        selected = self.layer
        RefreshAll()
    end)
    entryPool[i] = e
    return e
end

local function Header(i)
    local h = headerPool[i]
    if h then return h end
    h = UI.Text(list, "GameFontNormalSmall")
    h:SetJustifyH("LEFT")
    h:SetTextColor(0.6, 0.6, 0.6)
    headerPool[i] = h
    return h
end

local function RefreshList()
    local y, ne, nh = -4, 0, 0
    for _, section in ipairs(Sections()) do
        nh = nh + 1
        local h = Header(nh)
        h:ClearAllPoints()
        h:SetPoint("TOPLEFT", 10, y)
        h:SetText(section.title:upper())
        h:Show()
        y = y - 18
        if #section.items == 0 then
            nh = nh + 1
            local hint = Header(nh)
            hint:ClearAllPoints()
            hint:SetPoint("TOPLEFT", 14, y)
            hint:SetWidth(LIST_W - 24)
            hint:SetText(section.empty or "")
            hint:Show()
            y = y - hint:GetStringHeight() - 10
        end
        for _, item in ipairs(section.items) do
            ne = ne + 1
            local e = Entry(ne)
            e.layer = item
            e:ClearAllPoints()
            e:SetPoint("TOPLEFT", 8, y)
            SetTag(e.tag, LayerKeys(item))
            e.name:SetText(LayerName(item))
            local n, total = LayerCount(item)
            e.count:SetText(("%d/%d"):format(n, total))
            e.count:SetTextColor(n > 0 and 0.4 or 0.5, n > 0 and 0.9 or 0.5, n > 0 and 0.4 or 0.5)
            e.sel:SetShown(Same(item, selected))
            e:Show()
            y = y - 36
        end
        y = y - 8
    end
    for i = ne + 1, #entryPool do entryPool[i]:Hide() end
    for i = nh + 1, #headerPool do headerPool[i]:Hide() end
end

---------------------------------------------------------------------------
-- Onglet Actions : la couche choisie (droite)
---------------------------------------------------------------------------
local detail

-- Case i de la couche en croix : 1-4 la croix, 5-8 X/Y/B/A
local function CrossKey(i)
    return i <= 4 and DPAD_KEYS[i] or FACE_KEYS[i - 4]
end

local function GetCross(i)
    if selected.bar then return ns.Bar.GetView(selected.bar, i) end
    if selected.mod then return ns.ButtonActions(selected.mod).combos[CrossKey(i)] end
end

-- (« Seul » prend tout : la barre du jeu, ou l'addon pour le reste)
local function FullLayer()
    return selected.mod ~= nil or selected.bar == ns.Bar.BASE_BAR
end

local function SetCross(i, action)
    if selected.bar then
        local ok, err = ns.Bar.SetView(selected.bar, i, action)
        if not ok and err then ns.Print(err) end
    elseif selected.mod then
        ns.ButtonActions(selected.mod).combos[CrossKey(i)] = action
        ns.Apply()
    end
end

local function BuildDetail(page)
    detail = CreateFrame("Frame", nil, page)
    detail:SetPoint("TOPLEFT", LIST_W + 10, 0)
    detail:SetPoint("BOTTOMRIGHT", 0, 0)
    local w = WIDTH - 16 - LIST_W - 10

    detail.tag = Tag(detail, 30)
    detail.tag:SetPoint("TOPLEFT", 10, -8)
    detail.title = UI.Text(detail, "GameFontNormalLarge")
    detail.title:SetPoint("LEFT", detail.tag, "RIGHT", 10, 0)
    detail.count = UI.Text(detail, "GameFontHighlight")
    detail.count:SetPoint("TOPRIGHT", -14, -16)
    detail.desc = UI.Text(detail, "GameFontHighlight")
    detail.desc:SetPoint("TOPLEFT", 10, -48)
    detail.desc:SetWidth(w - 24)
    detail.desc:SetJustifyH("LEFT")

    -- La croix et A/B/X/Y, disposées comme la manette
    detail.cross = CreateFrame("Frame", nil, detail)
    detail.cross:SetPoint("TOPLEFT", 0, -96)
    detail.cross:SetSize(w, 250)
    local stepX, stepY = 84, 76
    local centers = { w / 2 - 148, w / 2 + 148 }
    detail.slots = {}
    for side = 1, 2 do
        local zone = detail.cross:CreateTexture(nil, "BACKGROUND")
        zone:SetSize(stepX * 3 + 10, stepY * 2 + 84)
        zone:SetPoint("CENTER", detail.cross, "TOPLEFT", centers[side], -125)
        zone:SetColorTexture(1, 1, 1, 0.03)
        for pos, spot in ipairs(SPOTS) do
            local i = (side - 1) * 4 + pos
            local slot = UI.CreateActionSlot(detail.cross, {
                get = function() return GetCross(i) end,
                set = function(action) SetCross(i, action) end,
                allowCommand = FullLayer,
                allowMacroText = FullLayer,
                locked = function()
                    return selected.bar ~= nil and selected.bar ~= ns.Bar.BASE_BAR and ns.Bar.IsGameSlot(selected.bar, i)
                end,
                -- (A/B/X/Y de « Seul » sans action de l'addon : celle du jeu)
                emptyLabel = function()
                    return selected.bar and ns.Bar.ShowsGameAction(selected.bar, i) and L.GAME_ACTION or nil
                end,
                disabledHint = function() return not FullLayer() and L.MENU_GAME_BAR_HINT or nil end,
                labelWidth = 80,
            })
            slot:SetPoint("CENTER", detail.cross, "TOPLEFT", centers[side] + spot[1] * stepX,
                -112 + spot[2] * stepY)
            local glyph = UI.CreateGlyph(slot, 22)
            glyph:SetPoint("CENTER", slot, "TOPLEFT", 0, 0)
            glyph:SetFrameLevel(slot:GetFrameLevel() + 5)
            glyph:SetKey(CrossKey(i))
            detail.slots[i] = slot
        end
    end

    -- Un bouton simple : seul, avec LT, avec RT
    detail.simple = CreateFrame("Frame", nil, detail)
    detail.simple:SetPoint("TOPLEFT", 0, -110)
    detail.simple:SetSize(w, 140)
    detail.simpleCells = {}
    local LAYER_KEY = { lt = "PADLTRIGGER", rt = "PADRTRIGGER" }
    for k, layer in ipairs(ns.LAYERS) do
        local cell = CreateFrame("Frame", nil, detail.simple)
        cell:SetSize(150, 120)
        cell:SetPoint("TOP", detail.simple, "TOPLEFT", w / 2 + (k - 2) * 170, 0)
        local bg = cell:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(1, 1, 1, 0.04)
        cell.tag = Tag(cell, 22)
        cell.tag:SetPoint("TOP", 0, -8)
        cell.layerKey = LAYER_KEY[layer]
        cell.text = UI.Text(cell, "GameFontNormal", L.LAYER_BASE)
        cell.text:SetPoint("TOP", 0, -12)
        cell.slot = UI.CreateActionSlot(cell, {
            get = function() return selected.simple and ns.ButtonActions(selected.simple).layers[layer] end,
            set = function(action)
                local a = ns.ButtonActions(selected.simple)
                a.layers[layer] = action
                if layer ~= "base" and action and ns.Actions.IsCommand(a.layers.base) then
                    ns.Print(L.COMMAND_LT_RT)
                end
                ns.Apply()
            end,
            allowCommand = function()
                return selected.simple ~= nil and ns.Simple.CommandAllowed(ns.ButtonActions(selected.simple), layer)
            end,
        })
        cell.slot:SetPoint("TOP", 0, -40)
        detail.simpleCells[k] = cell
    end

    detail.warning = UI.Text(detail, "GameFontRed")
    detail.warning:SetPoint("BOTTOMLEFT", 10, 30)
    detail.warning:SetPoint("RIGHT", -12, 0)
    detail.warning:SetJustifyH("LEFT")
    detail.hint = UI.Text(detail, "GameFontDisableSmall", L.SLOT_HINT)
    detail.hint:SetPoint("BOTTOMLEFT", 10, 10)
    detail.hint:SetPoint("RIGHT", -12, 0)
    detail.hint:SetJustifyH("LEFT")
end

local function RefreshDetail()
    SetTag(detail.tag, LayerKeys(selected))
    detail.title:SetText(LayerName(selected))
    detail.desc:SetText(LayerDesc(selected))
    local n, total = LayerCount(selected)
    detail.count:SetText(("%d/%d"):format(n, total))

    local isSimple = selected.simple ~= nil
    detail.cross:SetShown(not isSimple)
    detail.simple:SetShown(isSimple)
    if isSimple then
        for _, cell in ipairs(detail.simpleCells) do
            if cell.layerKey then
                SetTag(cell.tag, { cell.layerKey, selected.simple })
                cell.tag:Show()
                cell.text:Hide()
            else
                cell.tag:Hide()
                cell.text:Show()
            end
            cell.slot:Refresh()
        end
    else
        for _, slot in ipairs(detail.slots) do slot:Refresh() end
    end

    local warn
    if selected.bar and not ns.Bar.Available() then
        warn = L.BAR_UNAVAILABLE
    elseif ns.IsPending() then
        warn = L.APPLIED_AFTER_COMBAT
    end
    detail.warning:SetText(warn or "")
end

---------------------------------------------------------------------------
-- Onglet Boutons : la manette ; nom, touche, mode de chaque emplacement
-- (les boutons de la manette, puis les emplacements libres) ; les paires
---------------------------------------------------------------------------
local rows, pairRows = {}, {}
local buttonsWarning, controllerName, triggerChecks
local ROWS_TOP, ROW_STEP = -68, 50
local TRIGGERS_H = 30 -- (la ligne des gâchettes, sous les boutons)

-- La liste des manettes (préréglages), avec leur logiciel
local function PickController()
    local entries = {}
    for _, def in ipairs(ns.CONTROLLERS) do
        entries[#entries + 1] = { label = ns.ControllerName(def), sub = def.software, action = def.id }
    end
    UI.PickFromList(L.CONTROLLER_PICK, entries, function(id)
        ns.SetController(id)
        RefreshAll()
    end)
end

local function BuildButtons(page)
    local intro = UI.Text(page, "GameFontHighlight", L.BUTTONS_INTRO)
    intro:SetPoint("TOPLEFT", 12, -8)
    intro:SetPoint("RIGHT", -12, 0)
    intro:SetJustifyH("LEFT")

    -- La manette
    local label = UI.Text(page, "GameFontNormal", L.CONTROLLER_LABEL)
    label:SetPoint("TOPLEFT", 14, -42)
    controllerName = UI.Text(page, "GameFontHighlight")
    controllerName:SetPoint("LEFT", label, "RIGHT", 8, 0)
    local change = UI.Button(page, L.CONTROLLER_CHANGE, 140, 22)
    change:SetPoint("LEFT", controllerName, "RIGHT", 12, 0)
    change:SetScript("OnClick", PickController)

    for i, id in ipairs(ns.BUTTON_IDS) do
        local row = CreateFrame("Frame", nil, page)
        row:SetSize(WIDTH - 40, ROW_STEP - 4)
        row:SetPoint("TOPLEFT", 12, ROWS_TOP - (i - 1) * ROW_STEP)
        local bg = row:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(1, 1, 1, 0.04)

        row.glyph = UI.CreateGlyph(row, 34)
        row.glyph:SetPoint("LEFT", 10, 0)

        local name = CreateFrame("EditBox", nil, row, "InputBoxTemplate")
        name:SetSize(120, 20)
        name:SetPoint("TOPLEFT", 60, -5)
        name:SetAutoFocus(false)
        name:SetMaxLetters(24)
        local function SaveName(self)
            local text = strtrim(self:GetText() or "")
            ns.Button(id).name = (text ~= "") and text or nil
            self:ClearFocus()
            RefreshAll()
        end
        name:SetScript("OnEnterPressed", SaveName)
        name:SetScript("OnEditFocusLost", SaveName)
        name:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
        row.name = name

        local keyLabel = UI.Text(row, "GameFontNormal", L.KEY)
        keyLabel:SetPoint("TOPLEFT", 200, -8)
        row.key = UI.Text(row, "GameFontHighlight")
        row.key:SetPoint("LEFT", keyLabel, "RIGHT", 8, 0)
        row.key:SetWidth(170)
        row.key:SetJustifyH("LEFT")
        row.key:SetWordWrap(false)

        local detect = UI.Button(row, L.DETECT, 110, 22)
        detect:SetPoint("TOPRIGHT", -104, -4)
        detect:SetScript("OnClick", function() ns.Learn.Start(id, function() RefreshAll() end) end)
        local clear = UI.Button(row, L.CLEAR, 90, 22)
        clear:SetPoint("LEFT", detect, "RIGHT", 4, 0)
        clear:SetScript("OnClick", function()
            ns.Button(id).key = nil
            ns.Apply()
            RefreshAll()
        end)

        -- (le mode : une case à cocher par mode, son explication au survol)
        local modeLabel = UI.Text(row, "GameFontNormal", L.MODE)
        modeLabel:SetPoint("TOPLEFT", 60, -30)
        row.modes = {}
        local x = modeLabel:GetStringWidth() + 10
        local DESC = { modifier = L.MODE_MODIFIER_DESC, simple = L.MODE_SIMPLE_DESC, off = L.MODE_OFF_DESC }
        for _, mode in ipairs({ "modifier", "simple", "off" }) do
            local cb = CreateFrame("CheckButton", nil, row, "UICheckButtonTemplate")
            cb:SetSize(22, 22)
            cb:SetPoint("LEFT", modeLabel, "LEFT", x, 0)
            local text = UI.Text(cb, "GameFontHighlight", ModeLabel(mode))
            text:SetPoint("LEFT", cb, "RIGHT", 2, 0)
            cb:SetScript("OnClick", function()
                ns.Button(id).mode = mode
                ns.Apply()
                RefreshAll()
            end)
            cb:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOP")
                GameTooltip:SetText(ModeLabel(mode), 1, 0.82, 0)
                GameTooltip:AddLine(DESC[mode], 1, 1, 1, true)
                GameTooltip:Show()
            end)
            cb:SetScript("OnLeave", function() GameTooltip:Hide() end)
            row.modes[mode] = cb
            x = x + 30 + text:GetStringWidth() + 18
        end
        row.id = id
        rows[i] = row
    end

    -- Les gâchettes LT / RT : couches du jeu, ou modificateurs de l'addon
    -- (jamais des boutons simples)
    local ty = ROWS_TOP - #ns.BUTTON_IDS * ROW_STEP - 2
    local trow = CreateFrame("Frame", nil, page)
    trow:SetSize(WIDTH - 40, TRIGGERS_H - 4)
    trow:SetPoint("TOPLEFT", 12, ty)
    local tbg = trow:CreateTexture(nil, "BACKGROUND")
    tbg:SetAllPoints()
    tbg:SetColorTexture(1, 1, 1, 0.04)
    local ttag = Tag(trow, 20)
    ttag:SetPoint("LEFT", 10, 0)
    SetTag(ttag, { "PADLTRIGGER", "PADRTRIGGER" })
    local tlabel = UI.Text(trow, "GameFontNormal", L.TRIGGERS_LABEL)
    tlabel:SetPoint("LEFT", 76, 0)
    triggerChecks = {}
    local tx = 76 + tlabel:GetStringWidth() + 14
    local TDESC = { modifier = L.TRIGGERS_ADDON_DESC, off = L.TRIGGERS_GAME_DESC }
    for _, def in ipairs({ { "modifier", L.TRIGGERS_ADDON }, { "off", L.TRIGGERS_GAME } }) do
        local mode = def[1]
        local cb = CreateFrame("CheckButton", nil, trow, "UICheckButtonTemplate")
        cb:SetSize(22, 22)
        cb:SetPoint("LEFT", tx, 0)
        local text = UI.Text(cb, "GameFontHighlight", def[2])
        text:SetPoint("LEFT", cb, "RIGHT", 2, 0)
        cb:SetScript("OnClick", function()
            ns.SetTriggers(mode == "modifier")
            RefreshAll()
        end)
        cb:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(def[2], 1, 0.82, 0, 1, true)
            GameTooltip:AddLine(TDESC[mode], 1, 1, 1, true)
            GameTooltip:Show()
        end)
        cb:SetScript("OnLeave", function() GameTooltip:Hide() end)
        triggerChecks[mode] = cb
        tx = tx + 30 + text:GetStringWidth() + 18
    end

    -- Les paires
    local y = ty - TRIGGERS_H - 4
    local title = UI.Text(page, "GameFontNormal", L.PAIRS_TITLE)
    title:SetPoint("TOPLEFT", 14, y)
    for i, pair in ipairs(ns.PAIRS) do
        local row = CreateFrame("Frame", nil, page)
        row:SetSize(WIDTH - 40, 24)
        row:SetPoint("TOPLEFT", 12, y - 20 - (i - 1) * 26)
        row.tag = Tag(row, 20)
        row.tag:SetPoint("LEFT", 6, 0)
        row.text = UI.Text(row, "GameFontHighlight")
        row.text:SetPoint("LEFT", 76, 0)
        row.text:SetPoint("RIGHT", -6, 0)
        row.text:SetJustifyH("LEFT")
        row.pair = pair
        pairRows[i] = row
    end

    buttonsWarning = UI.Text(page, "GameFontNormalSmall")
    buttonsWarning:SetPoint("BOTTOMLEFT", 14, 10)
    buttonsWarning:SetPoint("RIGHT", -14, 0)
    buttonsWarning:SetJustifyH("LEFT")
end

local function RefreshButtons()
    controllerName:SetText(ns.ControllerName(ns.Controller()))
    for _, row in ipairs(rows) do
        local id, def = row.id, ns.Button(row.id)
        row.glyph:SetKey(id)
        if not row.name:HasFocus() then row.name:SetText(ns.ButtonLabel(id)) end
        row.key:SetText(def.key and ns.KeyLabel(def.key) or ("|cffff6060" .. L.KEY_NONE .. "|r"))
        for mode, cb in pairs(row.modes) do cb:SetChecked(def.mode == mode) end
    end
    local on = ns.TriggersOn()
    triggerChecks.modifier:SetChecked(on)
    triggerChecks.off:SetChecked(not on)
    for _, row in ipairs(pairRows) do
        local pair = row.pair
        SetTag(row.tag, { pair.a, pair.b })
        if ns.PairReady(pair.id) then
            row.text:SetText("|cff40ff40" .. L.PAIR_READY .. "|r")
        else
            row.text:SetText("|cff999999" .. L.PAIR_NEEDS:format(ns.ButtonLabel(pair.a), ns.ButtonLabel(pair.b)) .. "|r")
        end
    end
    local warn
    if ns.IsPending() then
        warn = "|cffff6060" .. L.APPLIED_AFTER_COMBAT .. "|r"
    elseif IsLoaded("ImprovedForever") then
        warn = "|cffffd100" .. L.IF_WARNING .. "|r"
    end
    buttonsWarning:SetText(warn or "")
end

---------------------------------------------------------------------------
-- Onglet HUD
---------------------------------------------------------------------------
local hud = {}

local function Check(parent, text, onClick)
    local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    cb:SetSize(24, 24)
    cb.text = UI.Text(cb, "GameFontHighlight", text)
    cb.text:SetPoint("LEFT", cb, "RIGHT", 4, 0)
    cb:SetScript("OnClick", function(self) onClick(self:GetChecked()) RefreshAll() end)
    return cb
end

local function BuildHudPage(page)
    local intro = UI.Text(page, "GameFontHighlight", L.HUD_INTRO)
    intro:SetPoint("TOPLEFT", 16, -10)
    intro:SetPoint("RIGHT", -16, 0)
    intro:SetJustifyH("LEFT")

    hud.enabled = Check(page, L.HUD_SHOW, function(on) ns.Hud.SetEnabled(on) end)
    hud.enabled:SetPoint("TOPLEFT", 16, -60)

    -- Miniatures : en bas / en haut
    local stripLabel = UI.Text(page, "GameFontNormal", L.TUTO_STRIP_LABEL)
    stripLabel:SetPoint("TOPLEFT", 20, -104)
    hud.strip = {}
    local x = stripLabel:GetStringWidth() + 14
    for _, def in ipairs({ { "bottom", L.TUTO_STRIP_BOTTOM }, { "top", L.TUTO_STRIP_TOP } }) do
        local pos = def[1]
        local cb = Check(page, def[2], function() ns.Hud.SetStrip(pos) end)
        cb:SetPoint("LEFT", stripLabel, "LEFT", x, 0)
        hud.strip[pos] = cb
        x = x + 34 + cb.text:GetStringWidth() + 20
    end

    -- (une valeur en % avec - et +)
    local function Stepper(y, label, get, set)
        local text = UI.Text(page, "GameFontNormal", label)
        text:SetPoint("TOPLEFT", 20, y)
        local minus = UI.Button(page, "-", 28, 22)
        minus:SetPoint("LEFT", text, "RIGHT", 12, 0)
        local value = UI.Text(page, "GameFontHighlightLarge")
        value:SetPoint("LEFT", minus, "RIGHT", 10, 0)
        value:SetWidth(60)
        local plus = UI.Button(page, "+", 28, 22)
        plus:SetPoint("LEFT", value, "RIGHT", 10, 0)
        minus:SetScript("OnClick", function() set(get() - 0.05) RefreshAll() end)
        plus:SetScript("OnClick", function() set(get() + 0.05) RefreshAll() end)
        return value
    end

    -- Miniatures : taille, nombre de lignes
    hud.stripSize = Stepper(-140, L.HUD_STRIP_SIZE, ns.Hud.StripScale, ns.Hud.SetStripScale)
    local rowsLabel = UI.Text(page, "GameFontNormal", L.HUD_STRIP_ROWS)
    rowsLabel:SetPoint("TOPLEFT", 20, -176)
    hud.rows = {}
    x = rowsLabel:GetStringWidth() + 14
    for n = 1, 3 do
        local cb = Check(page, tostring(n), function() ns.Hud.SetStripRows(n) end)
        cb:SetPoint("LEFT", rowsLabel, "LEFT", x, 0)
        hud.rows[n] = cb
        x = x + 34 + cb.text:GetStringWidth() + 20
    end

    -- Taille du HUD
    hud.size = Stepper(-220, L.HUD_SIZE, ns.Hud.Scale, ns.Hud.SetScale)

    -- Position
    hud.move = UI.Button(page, L.HUD_MOVE, 220, 26)
    hud.move:SetPoint("TOPLEFT", 20, -260)
    hud.move:SetScript("OnClick", function()
        ns.Hud.SetUnlocked(not ns.Hud.IsUnlocked())
        RefreshAll()
    end)
    local reset = UI.Button(page, L.HUD_RESET, 260, 26)
    reset:SetPoint("LEFT", hud.move, "RIGHT", 10, 0)
    reset:SetScript("OnClick", function() ns.Hud.ResetPosition() RefreshAll() end)
    hud.moveHint = UI.Text(page, "GameFontHighlightSmall", L.HUD_UNLOCKED)
    hud.moveHint:SetPoint("TOPLEFT", hud.move, "BOTTOMLEFT", 0, -6)
    hud.moveHint:SetPoint("RIGHT", -16, 0)
    hud.moveHint:SetJustifyH("LEFT")
    hud.moveHint:SetTextColor(0.5, 0.85, 1)

    -- Bouton de la minimap
    hud.minimap = Check(page, L.MINIMAP_SHOW, function(on) ns.MinimapButton.SetShown(on) end)
    hud.minimap:SetPoint("TOPLEFT", 16, -330)

    local tip = UI.Text(page, "GameFontDisableSmall", L.HUD_TILE_HINT .. "  -  " .. L.HUD_CARD_HINT)
    tip:SetPoint("BOTTOMLEFT", 16, 12)
    tip:SetPoint("RIGHT", -16, 0)
    tip:SetJustifyH("LEFT")
end

local function RefreshHudPage()
    hud.enabled:SetChecked(ns.Hud.IsEnabled())
    local strip = ns.Hud.Strip()
    for pos, cb in pairs(hud.strip) do cb:SetChecked(pos == strip) end
    hud.size:SetText(("%d %%"):format(math.floor(ns.Hud.Scale() * 100 + 0.5)))
    hud.stripSize:SetText(("%d %%"):format(math.floor(ns.Hud.StripScale() * 100 + 0.5)))
    local rows = ns.Hud.StripRows()
    for n, cb in pairs(hud.rows) do cb:SetChecked(n == rows) end
    local unlocked = ns.Hud.IsUnlocked()
    hud.move:SetText(unlocked and L.HUD_MOVE_DONE or L.HUD_MOVE)
    hud.moveHint:SetShown(unlocked)
    hud.minimap:SetChecked(ns.MinimapButton.IsShown())
end

---------------------------------------------------------------------------
-- Aide : les textes du tutoriel (une seule source à traduire)
---------------------------------------------------------------------------
local function BuildHelp(page)
    local replay = UI.Button(page, L.HELP_REPLAY, 220, 24)
    replay:SetPoint("TOPLEFT", 12, -6)
    replay:SetScript("OnClick", function() ns.Tutorial.Open(1) end)
    local scroll = CreateFrame("ScrollFrame", nil, page, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 12, -40)
    scroll:SetPoint("BOTTOMRIGHT", -32, 8)
    local child = CreateFrame("Frame", nil, scroll)
    child:SetSize(WIDTH - 80, 10)
    scroll:SetScrollChild(child)
    local text = UI.Text(child, "GameFontHighlight", ns.Tutorial.HelpText())
    text:SetPoint("TOPLEFT", 4, -4)
    text:SetWidth(WIDTH - 90)
    text:SetJustifyH("LEFT")
    text:SetSpacing(3)
    child:SetHeight(text:GetStringHeight() + 20)
    -- (le texte dépend de la manette choisie)
    page:SetScript("OnShow", function()
        text:SetText(ns.Tutorial.HelpText())
        child:SetHeight(text:GetStringHeight() + 20)
    end)
end

---------------------------------------------------------------------------
-- Fenêtre
---------------------------------------------------------------------------
local TAB_ORDER = { "actions", "buttons", "profiles", "hud", "test", "help" }
local TAB_W = math.floor((WIDTH - 28 - (#TAB_ORDER - 1) * 4) / #TAB_ORDER)
local titleText

function RefreshAll()
    if not (frame and frame:IsShown()) then return end
    -- (le titre : le profil utilisé)
    if titleText and ns.prof then titleText:SetText(L.TITLE .. "  -  " .. ns.prof.name) end
    if currentTab == "profiles" then
        pages.profiles.Refresh()
    elseif currentTab == "actions" then
        CheckSelected()
        RefreshList()
        RefreshDetail()
    elseif currentTab == "buttons" then
        RefreshButtons()
    elseif currentTab == "hud" then
        RefreshHudPage()
    elseif currentTab == "test" and pages.test.RefreshExtra then
        pages.test.RefreshExtra()
    end
end

local function SelectTab(name)
    -- (anciens noms d'onglets)
    if not pages[name] then name = "actions" end
    currentTab = name
    for key, page in pairs(pages) do page:SetShown(key == name) end
    for key, tab in pairs(tabs) do
        if key == name then tab:LockHighlight() else tab:UnlockHighlight() end
    end
    RefreshAll()
end

local function Build()
    local ok, f = pcall(CreateFrame, "Frame", "MyGamepadIsRichFrame", UIParent, "BasicFrameTemplateWithInset")
    if not ok or not f then
        f = UI.Panel(UIParent, "MyGamepadIsRichFrame")
        local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
        close:SetPoint("TOPRIGHT", -2, -2)
    end
    frame = f
    f:SetSize(WIDTH, HEIGHT)
    f:SetPoint("CENTER")
    f:SetFrameStrata("HIGH")
    f:SetToplevel(true)
    f:SetClampedToScreen(true)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    tinsert(UISpecialFrames, "MyGamepadIsRichFrame")

    local title = f.TitleText or (f.TitleContainer and f.TitleContainer.TitleText)
    if not title then
        title = UI.Text(f, "GameFontNormal")
        title:SetPoint("TOP", 0, -6)
    end
    title:SetText(L.TITLE)
    titleText = title

    local labels = { actions = L.TAB_ACTIONS, buttons = L.TAB_BUTTONS, profiles = L.TAB_PROFILES,
        hud = L.TAB_HUD, test = L.TAB_TEST, help = L.TAB_HELP }
    local prev
    for _, key in ipairs(TAB_ORDER) do
        local tab = UI.Button(f, labels[key], TAB_W, 24)
        if prev then tab:SetPoint("LEFT", prev, "RIGHT", 4, 0) else tab:SetPoint("TOPLEFT", 14, -30) end
        tab:SetScript("OnClick", function() SelectTab(key) end)
        tabs[key] = tab
        prev = tab

        local page = CreateFrame("Frame", nil, f)
        page:SetPoint("TOPLEFT", 8, -60)
        page:SetPoint("BOTTOMRIGHT", -8, 8)
        page:Hide()
        pages[key] = page
    end

    -- Actions : la liste à gauche, la couche à droite
    list = CreateFrame("Frame", nil, pages.actions)
    list:SetPoint("TOPLEFT", 0, 0)
    list:SetPoint("BOTTOMLEFT", 0, 0)
    list:SetWidth(LIST_W)
    Separator(pages.actions, LIST_W + 2, -4, LIST_W + 3, -(HEIGHT - 76))
    BuildDetail(pages.actions)

    BuildButtons(pages.buttons)
    UI.BuildProfilesPage(pages.profiles)
    BuildHudPage(pages.hud)
    UI.BuildTestPage(pages.test)
    BuildHelp(pages.help)

    f:SetScript("OnShow", RefreshAll)
    f:SetScript("OnHide", function() UI.HideMenu() end)
    ns.OnApplied(function() RefreshAll() end)
    -- (la barre du jeu a changé : sa couche est redessinée)
    local events = CreateFrame("Frame")
    events:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
    events:SetScript("OnEvent", function()
        if currentTab == "actions" then RefreshAll() end
    end)
    f:Hide()
end

function UI.Show(tab)
    if not ns.db then return end
    if not frame then Build() end
    frame:Show()
    SelectTab(tab or currentTab)
end

-- (pour l'onglet Profils et ses fenêtres)
function UI.RefreshAll() RefreshAll() end

function UI.Hide()
    if frame then frame:Hide() end
end

function UI.Toggle(tab)
    if frame and frame:IsShown() and not tab then
        frame:Hide()
    else
        UI.Show(tab)
    end
end

---------------------------------------------------------------------------
-- Page dans Options > AddOns
---------------------------------------------------------------------------
function UI.RegisterSettings()
    if UI.settingsRegistered then return end
    UI.settingsRegistered = true
    local panel = CreateFrame("Frame")
    panel.name = L.TITLE
    local title = UI.Text(panel, "GameFontNormalLarge", L.TITLE)
    title:SetPoint("TOPLEFT", 16, -16)
    local desc = UI.Text(panel, "GameFontHighlight", L.SETTINGS_DESC)
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
    desc:SetPoint("RIGHT", -16, 0)
    desc:SetJustifyH("LEFT")
    local open = UI.Button(panel, L.OPEN_CONFIG, 220, 26)
    open:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -16)
    open:SetScript("OnClick", function()
        if SettingsPanel and SettingsPanel:IsShown() and HideUIPanel then HideUIPanel(SettingsPanel) end
        UI.Show()
    end)
    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
        Settings.RegisterAddOnCategory(category)
    elseif InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(panel)
    end
end
