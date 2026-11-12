-- Petits éléments d'interface maison (aucune dépendance aux menus du jeu,
-- dont l'API change d'une version à l'autre) : menu contextuel, fenêtre de
-- macro, sélecteur de commande WoW.
local _, ns = ...
local L = ns.L
local UI = ns.UI

local BACKDROP = {
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
}

-- Un cadre avec fond (BackdropTemplate si présent)
function UI.Panel(parent, name, strata)
    local f = CreateFrame("Frame", name, parent, BackdropTemplateMixin and "BackdropTemplate" or nil)
    if f.SetBackdrop then
        f:SetBackdrop(BACKDROP)
        f:SetBackdropColor(0.06, 0.06, 0.08, 0.96)
        f:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
    else
        local bg = f:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(0.06, 0.06, 0.08, 0.96)
    end
    if strata then f:SetFrameStrata(strata) end
    return f
end

function UI.Button(parent, text, width, height)
    local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    b:SetSize(width or 100, height or 22)
    b:SetText(text)
    return b
end

function UI.Text(parent, font, text)
    local fs = parent:CreateFontString(nil, "OVERLAY", font or "GameFontHighlight")
    if text then fs:SetText(text) end
    return fs
end

-- Une info-bulle sur un réglage : son nom (en or), puis ce qu'il fait. title
-- et text peuvent être des fonctions (texte qui dépend de l'état).
function UI.Tip(frame, title, text)
    frame:HookScript("OnEnter", function(self)
        local t = type(title) == "function" and title() or title
        local d = type(text) == "function" and text() or text
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(t or "", 1, 0.82, 0, 1, true)
        if d then GameTooltip:AddLine(d, 1, 1, 1, true) end
        GameTooltip:Show()
    end)
    frame:HookScript("OnLeave", function() GameTooltip:Hide() end)
end

-- Un titre de section : texte doré, et un trait jusqu'au bord droit (right :
-- décalage depuis le bord droit du parent)
function UI.Section(parent, text, x, y, right)
    local title = UI.Text(parent, "GameFontNormalLarge", text)
    title:SetPoint("TOPLEFT", x, y)
    local line = parent:CreateTexture(nil, "ARTWORK")
    line:SetColorTexture(1, 0.82, 0, 0.25)
    line:SetHeight(1)
    -- (le trait au milieu de la ligne du titre, jusqu'au bord droit)
    line:SetPoint("LEFT", title, "RIGHT", 8, 0)
    line:SetPoint("RIGHT", parent, "TOPRIGHT", -(right or 16), y - 8)
    return title
end

---------------------------------------------------------------------------
-- Fenêtres à nous (export / import, rapport de manette, nouveautés)
---------------------------------------------------------------------------
-- Une fenêtre à nous, au-dessus de la fenêtre de configuration
function UI.Dialog(name, w, h, title)
    local d = UI.Panel(UIParent, name, "HIGH")
    d:SetSize(w, h)
    d:SetPoint("CENTER", 0, 20)
    d:EnableMouse(true)
    d:SetToplevel(true)
    d:SetMovable(true)
    d:RegisterForDrag("LeftButton")
    d:SetScript("OnDragStart", d.StartMoving)
    d:SetScript("OnDragStop", d.StopMovingOrSizing)
    d:SetFrameLevel(50)
    tinsert(UISpecialFrames, name)
    d.title = UI.Text(d, "GameFontNormalLarge", title)
    d.title:SetPoint("TOP", 0, -12)
    return d
end

-- Une zone de texte multi-ligne qui défile, sur toute la largeur de parent,
-- à y pixels sous son haut
function UI.TextArea(parent, y, height)
    local box = UI.Panel(parent)
    box:SetHeight(height)
    box:SetPoint("TOPLEFT", 14, y)
    box:SetPoint("TOPRIGHT", -14, y)
    local scroll = CreateFrame("ScrollFrame", nil, box, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 8, -8)
    scroll:SetPoint("BOTTOMRIGHT", -28, 8)
    local edit = CreateFrame("EditBox", nil, scroll)
    edit:SetMultiLine(true)
    edit:SetAutoFocus(false)
    edit:SetFontObject("ChatFontNormal")
    edit:SetMaxLetters(0)
    if edit.SetMaxBytes then edit:SetMaxBytes(0) end
    -- (largeur du texte : celle de la fenêtre, moins marges et ascenseur)
    edit:SetWidth(parent:GetWidth() - 28 - 36)
    edit:SetHeight(height - 16)
    scroll:SetScrollChild(edit)
    scroll:SetScript("OnSizeChanged", function(_, w) edit:SetWidth(math.max(10, w)) end)
    edit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    box:EnableMouse(true)
    box:SetScript("OnMouseDown", function() edit:SetFocus() end)
    box.edit = edit
    return box
end

---------------------------------------------------------------------------
-- Menu contextuel
---------------------------------------------------------------------------
local menu, blocker
local MENU_ROWS = 10

local function HideMenu()
    if menu then menu:Hide() end
    if blocker then blocker:Hide() end
end
UI.HideMenu = HideMenu

local function BuildMenu()
    blocker = CreateFrame("Button", nil, UIParent)
    blocker:SetAllPoints(UIParent)
    blocker:SetFrameStrata("FULLSCREEN_DIALOG")
    blocker:RegisterForClicks("AnyUp")
    blocker:SetScript("OnClick", HideMenu)
    blocker:Hide()

    menu = UI.Panel(UIParent, nil, "FULLSCREEN_DIALOG")
    menu:SetFrameLevel(blocker:GetFrameLevel() + 10)
    menu:SetClampedToScreen(true)
    menu.rows = {}
    for i = 1, MENU_ROWS do
        local row = CreateFrame("Button", nil, menu)
        row:SetHeight(20)
        row:SetPoint("TOPLEFT", 8, -8 - (i - 1) * 20)
        row:SetPoint("RIGHT", -8, 0)
        row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
        row.text = UI.Text(row, "GameFontHighlight")
        row.text:SetPoint("LEFT", 4, 0)
        row.text:SetJustifyH("LEFT")
        row:SetScript("OnClick", function(self)
            HideMenu()
            if self.func then self.func() end
        end)
        menu.rows[i] = row
    end
    menu:Hide()
end

-- items = { { text = "...", func = fn, disabled = bool, title = bool }, ... }
function UI.ShowMenu(anchor, items)
    if not menu then BuildMenu() end
    local width = 160
    for i = 1, MENU_ROWS do
        local row, item = menu.rows[i], items[i]
        if item then
            row.text:SetText(item.text)
            row.func = (not item.disabled and not item.title) and item.func or nil
            if item.title then
                row.text:SetFontObject("GameFontNormalSmall")
            elseif item.disabled then
                row.text:SetFontObject("GameFontDisable")
            else
                row.text:SetFontObject("GameFontHighlight")
            end
            row:SetEnabled(row.func ~= nil)
            row:Show()
            width = math.max(width, row.text:GetStringWidth() + 24)
        else
            row:Hide()
        end
    end
    menu:SetSize(width, 16 + math.min(#items, MENU_ROWS) * 20)
    menu:ClearAllPoints()
    menu:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -2)
    blocker:Show()
    menu:Show()
end

---------------------------------------------------------------------------
-- Fenêtre de macro
---------------------------------------------------------------------------
local macroDialog

local function BuildMacroDialog()
    local d = UI.Panel(UIParent, "MyGamepadIsRichMacroDialog", "DIALOG")
    d:SetSize(380, 210)
    d:SetPoint("CENTER")
    d:EnableMouse(true)
    d:SetToplevel(true)
    d.title = UI.Text(d, "GameFontNormal", L.MACRO_TITLE)
    d.title:SetPoint("TOP", 0, -12)
    d.help = UI.Text(d, "GameFontHighlightSmall", L.MACRO_HELP)
    d.help:SetPoint("TOP", d.title, "BOTTOM", 0, -6)

    local box = UI.Panel(d)
    box:SetPoint("TOPLEFT", 14, -52)
    box:SetPoint("BOTTOMRIGHT", -14, 44)
    local edit = CreateFrame("EditBox", nil, box)
    edit:SetMultiLine(true)
    edit:SetMaxLetters(255)
    edit:SetAutoFocus(false)
    edit:SetFontObject("ChatFontNormal")
    edit:SetPoint("TOPLEFT", 8, -8)
    edit:SetPoint("BOTTOMRIGHT", -8, 8)
    edit:SetScript("OnEscapePressed", function() d:Hide() end)
    box:EnableMouse(true)
    box:SetScript("OnMouseDown", function() edit:SetFocus() end)
    d.edit = edit

    local ok = UI.Button(d, L.OK, 100)
    ok:SetPoint("BOTTOMRIGHT", d, "BOTTOM", -6, 12)
    ok:SetScript("OnClick", function()
        local text = strtrim(edit:GetText() or "")
        d:Hide()
        if d.onOK then d.onOK(text) end
    end)
    local cancel = UI.Button(d, L.CANCEL, 100)
    cancel:SetPoint("BOTTOMLEFT", d, "BOTTOM", 6, 12)
    cancel:SetScript("OnClick", function() d:Hide() end)
    d:Hide()
    macroDialog = d
end

function UI.EditMacro(initial, onOK)
    if not macroDialog then BuildMacroDialog() end
    macroDialog.onOK = onOK
    macroDialog.edit:SetText(initial or "")
    macroDialog:Show()
    macroDialog.edit:SetFocus()
end

---------------------------------------------------------------------------
-- Petites boîtes : un texte à saisir (nom de profil), une confirmation.
-- Maison plutôt que StaticPopup, dont l'API change selon la version du jeu.
---------------------------------------------------------------------------
local askDialog, confirmDialog

local function SmallDialog(name, height)
    local d = UI.Panel(UIParent, name, "DIALOG")
    d:SetSize(380, height)
    d:SetPoint("CENTER", 0, 120)
    d:EnableMouse(true)
    d:SetToplevel(true)
    d:SetFrameLevel(100)
    tinsert(UISpecialFrames, name)
    d.text = UI.Text(d, "GameFontHighlight")
    d.text:SetPoint("TOP", 0, -16)
    d.text:SetWidth(340)
    d.text:SetJustifyH("CENTER")
    d.ok = UI.Button(d, L.OK, 120)
    d.ok:SetPoint("BOTTOMRIGHT", d, "BOTTOM", -6, 12)
    d.cancel = UI.Button(d, L.CANCEL, 120)
    d.cancel:SetPoint("BOTTOMLEFT", d, "BOTTOM", 6, 12)
    d.cancel:SetScript("OnClick", function() d:Hide() end)
    d:Hide()
    return d
end

local function BuildAsk()
    local d = SmallDialog("MyGamepadIsRichAskDialog", 120)
    local edit = CreateFrame("EditBox", nil, d, "InputBoxTemplate")
    edit:SetSize(300, 20)
    edit:SetPoint("BOTTOM", 0, 46)
    edit:SetAutoFocus(false)
    local function Accept()
        local text = strtrim(edit:GetText() or "")
        if text == "" then return end
        d:Hide()
        if d.onOK then d.onOK(text) end
    end
    edit:SetScript("OnEnterPressed", Accept)
    edit:SetScript("OnEscapePressed", function() d:Hide() end)
    d.ok:SetScript("OnClick", Accept)
    d.edit = edit
    askDialog = d
end

-- Demande un texte : onOK(texte) quand il est validé (jamais vide)
function UI.AskText(prompt, initial, maxLetters, onOK)
    if not askDialog then BuildAsk() end
    local d = askDialog
    d.onOK = onOK
    d.text:SetText(prompt)
    d.edit:SetMaxLetters(maxLetters or 0)
    d.edit:SetText(initial or "")
    d:Show()
    d:Raise()
    d.edit:SetFocus()
    d.edit:HighlightText()
end

-- Demande une confirmation : onOK() si on valide (okLabel, cancelLabel :
-- le texte des boutons, sinon OK / Annuler)
function UI.Confirm(text, onOK, okLabel, cancelLabel)
    if not confirmDialog then
        confirmDialog = SmallDialog("MyGamepadIsRichConfirmDialog", 130)
        confirmDialog.ok:SetScript("OnClick", function()
            confirmDialog:Hide()
            if confirmDialog.onOK then confirmDialog.onOK() end
        end)
    end
    local d = confirmDialog
    d.onOK = onOK
    d.ok:SetText(okLabel or L.OK)
    d.cancel:SetText(cancelLabel or L.CANCEL)
    d.text:SetText(text)
    -- (hauteur selon le texte, qui change avec la langue)
    d:SetHeight(math.max(110, d.text:GetStringHeight() + 70))
    d:Show()
    d:Raise()
end

---------------------------------------------------------------------------
-- Liste à choisir (sorts, objets, commandes WoW) : icônes, sections,
-- recherche, molette pour défiler
---------------------------------------------------------------------------
local picker
local PICKER_ROWS = 16

-- (seuls les champs texte comptent : une valeur d'un autre type, venue d'un
-- autre addon par exemple, ne doit pas casser la recherche)
local function Matches(text, query)
    return type(text) == "string" and text:lower():find(query, 1, true) ~= nil
end

local function Filter(all, query)
    query = (query or ""):lower()
    if query == "" then return all end
    local out = {}
    for _, e in ipairs(all) do
        if not e.header and (Matches(e.label, query) or Matches(e.sub, query) or Matches(e.search, query)) then
            out[#out + 1] = e
        end
    end
    return out
end

local function RefreshPicker()
    local list = picker.list
    local maxOffset = math.max(0, #list - PICKER_ROWS)
    picker.offset = math.min(math.max(picker.offset, 0), maxOffset)
    picker.empty:SetShown(#list == 0)
    for i = 1, PICKER_ROWS do
        local row = picker.rows[i]
        local e = list[picker.offset + i]
        row.entry = e
        if not e then
            row:Hide()
        elseif e.header then
            row.icon:Hide()
            row.text:SetPoint("LEFT", 4, 0)
            row.text:SetFontObject("GameFontNormal")
            row.text:SetText(e.header)
            row.sub:SetText("")
            row:SetEnabled(false)
            row:Show()
        else
            if e.icon then
                row.icon:SetTexture(e.icon)
                row.icon:Show()
                row.text:SetPoint("LEFT", 28, 0)
            else
                row.icon:Hide()
                row.text:SetPoint("LEFT", 8, 0)
            end
            row.text:SetFontObject(e.unusable and "GameFontDisable" or "GameFontHighlight")
            row.text:SetText(e.label)
            row.sub:SetText(e.sub or "")
            row:SetEnabled(true)
            row:Show()
        end
    end
    picker.scrollText:SetText(#list > PICKER_ROWS
        and ("%d-%d / %d"):format(picker.offset + 1, math.min(picker.offset + PICKER_ROWS, #list), #list) or "")
end

local function BuildPicker()
    local p = UI.Panel(UIParent, "MyGamepadIsRichPicker", "DIALOG")
    p:SetSize(460, 466)
    p:SetPoint("CENTER")
    p:EnableMouse(true)
    p:SetToplevel(true)
    p.title = UI.Text(p, "GameFontNormalLarge")
    p.title:SetPoint("TOP", 0, -12)

    local label = UI.Text(p, "GameFontNormalSmall", L.SEARCH)
    label:SetPoint("TOPLEFT", 16, -42)
    local search = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
    search:SetSize(280, 20)
    search:SetPoint("LEFT", label, "RIGHT", 10, 0)
    search:SetAutoFocus(false)
    search:SetScript("OnTextChanged", function(self)
        if not picker then return end
        picker.list = Filter(picker.all, self:GetText())
        picker.offset = 0
        RefreshPicker()
    end)
    search:SetScript("OnEscapePressed", function() p:Hide() end)
    p.search = search

    p.rows = {}
    for i = 1, PICKER_ROWS do
        local row = CreateFrame("Button", nil, p)
        row:SetHeight(22)
        row:SetPoint("TOPLEFT", 14, -68 - (i - 1) * 22)
        row:SetPoint("RIGHT", -14, 0)
        row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(20, 20)
        row.icon:SetPoint("LEFT", 4, 0)
        row.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        row.text = UI.Text(row, "GameFontHighlight")
        row.text:SetPoint("LEFT", 28, 0)
        row.text:SetPoint("RIGHT", row, "RIGHT", -120, 0)
        row.text:SetJustifyH("LEFT")
        row.text:SetWordWrap(false)
        row.sub = UI.Text(row, "GameFontDisableSmall")
        row.sub:SetPoint("RIGHT", -4, 0)
        row.sub:SetWidth(112)
        row.sub:SetJustifyH("RIGHT")
        row.sub:SetWordWrap(false)
        row:SetScript("OnClick", function(self)
            local e = self.entry
            if not e or e.header then return end
            p:Hide()
            if p.onPick then p.onPick(e.action) end
        end)
        p.rows[i] = row
    end
    p.empty = UI.Text(p, "GameFontDisable", L.LIST_EMPTY)
    p.empty:SetPoint("TOP", 0, -100)

    p:EnableMouseWheel(true)
    p:SetScript("OnMouseWheel", function(_, delta)
        picker.offset = picker.offset - delta * 3
        RefreshPicker()
    end)

    p.scrollText = UI.Text(p, "GameFontDisableSmall")
    p.scrollText:SetPoint("BOTTOMLEFT", 16, 18)
    local cancel = UI.Button(p, L.CANCEL, 100)
    cancel:SetPoint("BOTTOM", 0, 12)
    cancel:SetScript("OnClick", function() p:Hide() end)
    p:Hide()
    picker = p
end

-- entries : { { header = "..." } | { label, sub, icon, action, search, unusable } }
-- onPick(action) quand une ligne est choisie
function UI.PickFromList(title, entries, onPick)
    if not picker then BuildPicker() end
    picker.title:SetText(title)
    picker.onPick = onPick
    picker.all = entries or {}
    picker.list = picker.all
    picker.offset = 0
    picker.search:SetText("")
    RefreshPicker()
    picker:Show()
    picker.search:SetFocus()
end

---------------------------------------------------------------------------
-- Choix d'une icône (commande WoW, macro écrite) : les icônes de macro du
-- jeu en grille ; la recherche donne les icônes des sorts du grimoire et des
-- objets portés dont le nom correspond, ou un numéro d'icône
---------------------------------------------------------------------------
local iconPicker
local ICON_COLS, ICON_ROWS, ICON_SIZE, ICON_GAP = 10, 7, 36, 4
local allIcons

-- Toutes les icônes de macro du jeu, une fois chacune (numéros de fichier ;
-- un ancien client donne des noms, sous Interface\Icons)
local function AllIcons()
    if allIcons then return allIcons end
    local list, seen = {}, {}
    local function addFrom(fn)
        if type(fn) ~= "function" then return end
        local t = {}
        local ok, r = pcall(fn, t)
        if not ok then return end
        if type(r) == "table" then t = r end
        for _, v in ipairs(t) do
            if type(v) == "string" and not v:find("[\\/]") then v = "Interface\\Icons\\" .. v end
            if (type(v) == "number" or type(v) == "string") and not seen[v] then
                seen[v] = true
                list[#list + 1] = { icon = v }
            end
        end
    end
    addFrom(GetLooseMacroIcons)
    addFrom(GetLooseMacroItemIcons)
    addFrom(GetMacroIcons)
    addFrom(GetMacroItemIcons)
    allIcons = list
    return list
end

local function SearchIcons(query)
    query = strtrim(query or ""):lower()
    if query == "" then return AllIcons() end
    local out, seen = {}, {}
    local function add(icon, label)
        if icon and not seen[icon] then
            seen[icon] = true
            out[#out + 1] = { icon = icon, label = label }
        end
    end
    local n = tonumber(query)
    if n and n > 0 and n == math.floor(n) then add(n, tostring(n)) end
    -- (un nom de fichier d'icône, comme sur Wowhead : inv_misc_map_01)
    if query:find("_") and query:match("^[%w_%-]+$") then add(ns.Actions.IconFromName(query), query) end
    -- (les commandes WoW, les sorts, les objets : lus une fois par ouverture
    -- de la fenêtre)
    local p = iconPicker
    if not p.sources then
        p.sources = { ns.Actions.CommandIconEntries(), ns.Actions.SpellbookEntries(), ns.Actions.ItemEntries() }
    end
    for _, list in ipairs(p.sources) do
        for _, e in ipairs(list) do
            if not e.header and Matches(e.label, query) then add(e.icon, e.label) end
        end
    end
    return out
end

local function RefreshIcons()
    local p = iconPicker
    local list = p.list
    local perPage = ICON_COLS * ICON_ROWS
    local totalRows = math.ceil(#list / ICON_COLS)
    p.row = math.min(math.max(p.row, 0), math.max(0, totalRows - ICON_ROWS))
    p.empty:SetShown(#list == 0)
    for i, cell in ipairs(p.cells) do
        local e = list[p.row * ICON_COLS + i]
        cell.entry = e
        if e then
            cell.icon:SetTexture(e.icon)
            cell.current:SetShown(p.selected ~= nil and e.icon == p.selected)
            cell:Show()
        else
            cell:Hide()
        end
    end
    local first = p.row * ICON_COLS + 1
    p.scrollText:SetText(#list > perPage
        and ("%d-%d / %d"):format(first, math.min(first + perPage - 1, #list), #list) or "")
end

local function BuildIconPicker()
    local width = 28 + ICON_COLS * (ICON_SIZE + ICON_GAP) - ICON_GAP
    local p = UI.Panel(UIParent, "MyGamepadIsRichIconPicker", "DIALOG")
    p:SetSize(width, 124 + ICON_ROWS * (ICON_SIZE + ICON_GAP) + 48)
    p:SetPoint("CENTER")
    p:EnableMouse(true)
    p:SetToplevel(true)
    tinsert(UISpecialFrames, "MyGamepadIsRichIconPicker")
    p.title = UI.Text(p, "GameFontNormalLarge", L.ICON_TITLE)
    p.title:SetPoint("TOP", 0, -12)

    local label = UI.Text(p, "GameFontNormalSmall", L.SEARCH)
    label:SetPoint("TOPLEFT", 16, -42)
    local search = CreateFrame("EditBox", nil, p, "InputBoxTemplate")
    search:SetSize(width - 120, 20)
    search:SetPoint("LEFT", label, "RIGHT", 10, 0)
    search:SetAutoFocus(false)
    search:SetScript("OnTextChanged", function(self)
        if not iconPicker then return end
        iconPicker.list = SearchIcons(self:GetText())
        iconPicker.row = 0
        RefreshIcons()
    end)
    search:SetScript("OnEscapePressed", function() p:Hide() end)
    p.search = search
    local hint = UI.Text(p, "GameFontDisableSmall", L.ICON_HINT)
    hint:SetPoint("TOPLEFT", 16, -66)
    hint:SetPoint("RIGHT", -16, 0)
    hint:SetJustifyH("LEFT")

    p.cells = {}
    for i = 1, ICON_COLS * ICON_ROWS do
        local col, row = (i - 1) % ICON_COLS, math.floor((i - 1) / ICON_COLS)
        local cell = CreateFrame("Button", nil, p)
        cell:SetSize(ICON_SIZE, ICON_SIZE)
        cell:SetPoint("TOPLEFT", 14 + col * (ICON_SIZE + ICON_GAP), -100 - row * (ICON_SIZE + ICON_GAP))
        cell.icon = cell:CreateTexture(nil, "ARTWORK")
        cell.icon:SetAllPoints()
        cell.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        -- (l'icône déjà choisie : un cadre doré)
        cell.current = cell:CreateTexture(nil, "OVERLAY")
        cell.current:SetPoint("TOPLEFT", -3, 3)
        cell.current:SetPoint("BOTTOMRIGHT", 3, -3)
        cell.current:SetColorTexture(1, 0.82, 0, 0.45)
        cell.current:Hide()
        cell:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
        cell:SetScript("OnClick", function(self)
            if not self.entry then return end
            p:Hide()
            if p.onPick then p.onPick(self.entry.icon) end
        end)
        cell:SetScript("OnEnter", function(self)
            if not (self.entry and self.entry.label) then return end
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(self.entry.label, 1, 1, 1)
            GameTooltip:Show()
        end)
        cell:SetScript("OnLeave", function() GameTooltip:Hide() end)
        p.cells[i] = cell
    end
    p.empty = UI.Text(p, "GameFontDisable", L.LIST_EMPTY)
    p.empty:SetPoint("TOP", 0, -142)

    p:EnableMouseWheel(true)
    p:SetScript("OnMouseWheel", function(_, delta)
        iconPicker.row = iconPicker.row - delta * 2
        RefreshIcons()
    end)

    p.scrollText = UI.Text(p, "GameFontDisableSmall")
    p.scrollText:SetPoint("BOTTOMLEFT", 16, 18)
    local default = UI.Button(p, L.ICON_DEFAULT, 130)
    default:SetPoint("BOTTOMRIGHT", p, "BOTTOM", -6, 12)
    default:SetScript("OnClick", function()
        p:Hide()
        if p.onPick then p.onPick(nil) end
    end)
    local cancel = UI.Button(p, L.CANCEL, 100)
    cancel:SetPoint("BOTTOMLEFT", p, "BOTTOM", 6, 12)
    cancel:SetScript("OnClick", function() p:Hide() end)
    p:Hide()
    iconPicker = p
end

-- onPick(icon) quand une icône est choisie (nil : l'icône par défaut) ;
-- selected : l'icône actuelle, encadrée
function UI.PickIcon(selected, onPick)
    if not iconPicker then BuildIconPicker() end
    local p = iconPicker
    p.onPick = onPick
    p.selected = selected
    p.sources = nil
    p.list = AllIcons()
    p.row = 0
    p.search:SetText("")
    RefreshIcons()
    p:Show()
    p:Raise()
    p.search:SetFocus()
end
