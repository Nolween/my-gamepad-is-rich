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

---------------------------------------------------------------------------
-- Menu contextuel
---------------------------------------------------------------------------
local menu, blocker
local MENU_ROWS = 8

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

-- Demande une confirmation : onOK() si on valide
function UI.Confirm(text, onOK)
    if not confirmDialog then
        confirmDialog = SmallDialog("MyGamepadIsRichConfirmDialog", 130)
        confirmDialog.ok:SetScript("OnClick", function()
            confirmDialog:Hide()
            if confirmDialog.onOK then confirmDialog.onOK() end
        end)
    end
    local d = confirmDialog
    d.onOK = onOK
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

local function Filter(all, query)
    query = (query or ""):lower()
    if query == "" then return all end
    local out = {}
    for _, e in ipairs(all) do
        if not e.header and (e.label:lower():find(query, 1, true)
            or (e.sub and e.sub:lower():find(query, 1, true))
            or (e.search and e.search:lower():find(query, 1, true))) then
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
