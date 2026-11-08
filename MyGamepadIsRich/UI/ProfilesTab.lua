-- Onglet « Profils » : la liste des profils (le profil actif marqué),
-- Utiliser / Nouveau / Copier / Renommer / Supprimer, et les fenêtres
-- d'export (texte à copier) et d'import (texte collé, aperçu, destination).
-- Noms et confirmations : UI.AskText / UI.Confirm (Widgets.lua).
local _, ns = ...
local L = ns.L
local UI = ns.UI

local P = ns.Profiles
local ROWS = 13
local ROW_H = 28
local LIST_W = 470
local READY = "|TInterface\\RaidFrame\\ReadyCheck-Ready:14:14|t"

local page, rows, selected, offset = nil, {}, nil, 0
local exportDialog, importDialog

local function RefreshUI()
    if ns.UI.RefreshAll then ns.UI.RefreshAll() end
end

local function AskName(prompt, initial, onOK)
    UI.AskText(prompt, initial, P.NAME_MAX, onOK)
end

local Confirm = UI.Confirm

-- Une fenêtre à nous, au-dessus de la fenêtre de configuration
local function Dialog(name, w, h, title)
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
local function TextArea(parent, y, height)
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

local function Check(parent, text)
    local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    cb:SetSize(24, 24)
    cb.label = UI.Text(cb, "GameFontHighlight", text)
    cb.label:SetPoint("LEFT", cb, "RIGHT", 2, 0)
    return cb
end

local function SetCheckEnabled(cb, on)
    cb:SetEnabled(on)
    cb.label:SetFontObject(on and "GameFontHighlight" or "GameFontDisable")
end

---------------------------------------------------------------------------
-- Export
---------------------------------------------------------------------------
local function RefreshExport()
    local d = exportDialog
    d.text = ns.Serialize.Export(d.id, { actions = d.actions:GetChecked(), hud = d.hud:GetChecked() }) or ""
    d.area.edit:SetText(d.text)
    d.area.edit:HighlightText()
    d.area.edit:SetFocus()
end

local function BuildExport()
    local d = Dialog("MyGamepadIsRichExport", 560, 330, "")
    d.actions = Check(d, L.EXPORT_ACTIONS)
    d.actions:SetPoint("TOPLEFT", 16, -42)
    d.actions:SetScript("OnClick", RefreshExport)
    d.hud = Check(d, L.EXPORT_HUD)
    d.hud:SetPoint("TOPLEFT", 16, -68)
    d.hud:SetScript("OnClick", RefreshExport)

    d.area = TextArea(d, -98, 160)
    -- (lecture seule : on garde le texte, et sa sélection pour Ctrl+C)
    d.area.edit:SetScript("OnTextChanged", function(self, userInput)
        if userInput then
            self:SetText(d.text or "")
            self:HighlightText()
        end
    end)
    d.area.edit:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)

    d.hint = UI.Text(d, "GameFontHighlightSmall", L.EXPORT_HINT)
    d.hint:SetPoint("TOPLEFT", d.area, "BOTTOMLEFT", 2, -8)
    d.hint:SetPoint("RIGHT", -16, 0)
    d.hint:SetJustifyH("LEFT")

    local close = UI.Button(d, L.CLOSE, 120)
    close:SetPoint("BOTTOM", 0, 12)
    close:SetScript("OnClick", function() d:Hide() end)
    d:Hide()
    exportDialog = d
end

local function OpenExport(id)
    if not exportDialog then BuildExport() end
    local d = exportDialog
    d.id = id
    d.title:SetText(L.EXPORT_TITLE:format(P.Name(id) or ""))
    d.actions:SetChecked(true)
    d.hud:SetChecked(false)
    d:Show()
    d:Raise()
    RefreshExport()
end

---------------------------------------------------------------------------
-- Import
---------------------------------------------------------------------------
local function FirstLine(text, max)
    local line = (text or ""):match("^[^\n]*") or ""
    if #line > max then line = ns.Utf8Cut(line, max - 3) .. "..." end
    return line
end

local function SummaryText(sum)
    local lines = { L.IMPORT_SUMMARY:format(sum.name, sum.controller, sum.keys, sum.actions) }
    if sum.hud then lines[#lines + 1] = L.IMPORT_SUMMARY_HUD end
    if #sum.macros > 0 then
        lines[#lines + 1] = "|cffff6060" .. L.IMPORT_MACROS:format(#sum.macros) .. "|r"
        for i = 1, math.min(3, #sum.macros) do
            lines[#lines + 1] = "   |cffffd100" .. FirstLine(sum.macros[i], 60):gsub("|", "||") .. "|r"
        end
        if #sum.macros > 3 then lines[#lines + 1] = "   ..." end
    end
    if #sum.commands > 0 then
        lines[#lines + 1] = L.IMPORT_COMMANDS:format(table.concat(sum.commands, ", "))
    end
    return table.concat(lines, "\n")
end

-- Le texte collé a changé : le lire, l'aperçu, les cases par défaut
local function ParseImport()
    local d = importDialog
    local data, info = ns.Serialize.Import(d.area.edit:GetText())
    d.data = data
    if not data then
        d.preview:SetText("|cffff6060" .. info .. "|r")
    else
        d.preview:SetText(SummaryText(info))
        if not d.nameEdited then d.name:SetText(P.UniqueName(data.name)) end
    end
    local ok = data ~= nil
    SetCheckEnabled(d.actions, ok and data.actions ~= nil)
    d.actions:SetChecked(ok and data.actions ~= nil)
    SetCheckEnabled(d.hud, ok and data.hud ~= nil)
    d.hud:SetChecked(false)
end

-- La destination (nouveau profil, ou remplacer celui choisi) et le bouton
local function RefreshImport()
    local d = importDialog
    local ok = d.data ~= nil
    local replace = d.mode == "replace"
    d.asNew:SetChecked(not replace)
    d.asReplace:SetChecked(replace)
    d.targetButton:SetText(d.target and P.Name(d.target) or "...")
    d.import:SetEnabled(ok and (not replace or (d.target and P.Get(d.target)) ~= nil))
end

local function DoImport()
    local d = importDialog
    local data = d.data
    if not data then return end
    local opts = { actions = d.actions:GetChecked() and data.actions ~= nil, hud = d.hud:GetChecked() and data.hud ~= nil }
    local function Finish(id)
        if not id then return end
        d:Hide()
        ns.Print(L.IMPORT_DONE:format(P.Name(id)))
        RefreshUI()
    end
    if d.mode == "replace" then
        local target = d.target
        Confirm(L.IMPORT_REPLACE_CONFIRM:format(P.Name(target) or ""), function()
            opts.target = target
            Finish(P.Import(data, opts))
        end)
    else
        opts.name = d.name:GetText()
        local id = P.Import(data, opts)
        if id then
            P.Switch(id)
            selected = id
        end
        Finish(id)
    end
end

local function PickTarget()
    local entries = {}
    for _, e in ipairs(P.List()) do
        entries[#entries + 1] = { label = e.name, sub = ns.ControllerName(ns.ControllerDef(e.controller)), action = e.id }
    end
    UI.PickFromList(L.IMPORT_PICK, entries, function(id)
        importDialog.target = id
        importDialog.mode = "replace"
        RefreshImport()
    end)
    local picker = _G.MyGamepadIsRichPicker
    if picker then picker:Raise() end
end

local function BuildImport()
    local d = Dialog("MyGamepadIsRichImport", 580, 470, L.IMPORT_TITLE)
    local paste = UI.Text(d, "GameFontNormal", L.IMPORT_PASTE)
    paste:SetPoint("TOPLEFT", 16, -42)
    d.area = TextArea(d, -60, 100)
    d.area.edit:SetScript("OnTextChanged", function()
        ParseImport()
        RefreshImport()
    end)

    d.preview = UI.Text(d, "GameFontHighlight")
    d.preview:SetPoint("TOPLEFT", d.area, "BOTTOMLEFT", 2, -10)
    d.preview:SetPoint("RIGHT", -16, 0)
    d.preview:SetHeight(130)
    d.preview:SetJustifyH("LEFT")
    d.preview:SetJustifyV("TOP")
    d.preview:SetSpacing(2)

    -- La destination
    d.asNew = Check(d, L.IMPORT_AS_NEW)
    d.asNew:SetPoint("TOPLEFT", 16, -312)
    d.asNew:SetScript("OnClick", function() d.mode = "new" RefreshImport() end)
    d.name = CreateFrame("EditBox", nil, d, "InputBoxTemplate")
    d.name:SetSize(220, 20)
    d.name:SetPoint("LEFT", d.asNew.label, "RIGHT", 14, 0)
    d.name:SetAutoFocus(false)
    d.name:SetMaxLetters(P.NAME_MAX)
    d.name:SetScript("OnTextChanged", function(_, userInput)
        if userInput then
            d.nameEdited = true
            d.mode = "new"
            RefreshImport()
        end
    end)
    d.name:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)

    d.asReplace = Check(d, L.IMPORT_REPLACE)
    d.asReplace:SetPoint("TOPLEFT", 16, -340)
    d.asReplace:SetScript("OnClick", function()
        d.mode = "replace"
        if d.target then RefreshImport() else PickTarget() RefreshImport() end
    end)
    d.targetButton = UI.Button(d, "...", 220, 22)
    d.targetButton:SetPoint("LEFT", d.asReplace.label, "RIGHT", 14, 0)
    d.targetButton:SetScript("OnClick", PickTarget)

    d.actions = Check(d, L.IMPORT_ACTIONS)
    d.actions:SetPoint("TOPLEFT", 16, -374)
    d.hud = Check(d, L.IMPORT_HUD)
    d.hud:SetPoint("TOPLEFT", 16, -400)

    d.import = UI.Button(d, L.IMPORT_DO, 140)
    d.import:SetPoint("BOTTOMRIGHT", d, "BOTTOM", -6, 12)
    d.import:SetScript("OnClick", DoImport)
    local cancel = UI.Button(d, L.CANCEL, 140)
    cancel:SetPoint("BOTTOMLEFT", d, "BOTTOM", 6, 12)
    cancel:SetScript("OnClick", function() d:Hide() end)
    d:Hide()
    importDialog = d
end

local function OpenImport()
    if not importDialog then BuildImport() end
    local d = importDialog
    d.mode, d.target, d.nameEdited, d.data = "new", nil, false, nil
    d.name:SetText("")
    d.area.edit:SetText("")
    d:Show()
    d:Raise()
    ParseImport()
    RefreshImport()
    d.area.edit:SetFocus()
end

---------------------------------------------------------------------------
-- L'onglet
---------------------------------------------------------------------------
local function Selected()
    if selected and P.Get(selected) then return selected end
    selected = P.ActiveID()
    return selected
end

local function Refresh()
    if not page then return end
    local list = P.List()
    local current = Selected()
    offset = math.max(0, math.min(offset, #list - ROWS))
    for i, row in ipairs(rows) do
        local e = list[offset + i]
        row.entry = e
        if e then
            local active = e.id == P.ActiveID()
            row.mark:SetText(active and READY or "")
            row.name:SetText(e.name .. (active and ("  |cff40ff40" .. L.PROFILE_ACTIVE .. "|r") or ""))
            row.sub:SetText(ns.ControllerName(ns.ControllerDef(e.controller)))
            row.sel:SetShown(e.id == current)
            row:Show()
        else
            row:Hide()
        end
    end
    page.scrollText:SetText(#list > ROWS
        and ("%d-%d / %d"):format(offset + 1, math.min(offset + ROWS, #list), #list) or "")
    local isActive = current == P.ActiveID()
    page.use:SetEnabled(not isActive)
    page.delete:SetEnabled(#list > 1)
end

local function Run(fn)
    return function()
        fn(Selected())
        Refresh()
    end
end

local function OnNew()
    -- (la manette d'abord : le nom proposé vient d'elle)
    local entries = {}
    for _, def in ipairs(ns.CONTROLLERS) do
        entries[#entries + 1] = { label = ns.ControllerName(def), sub = def.software, action = def.id }
    end
    UI.PickFromList(L.CONTROLLER_PICK, entries, function(controller)
        AskName(L.PROFILE_NAME_NEW, P.UniqueName(ns.ControllerName(ns.ControllerDef(controller))), function(name)
            local id = P.New(name, controller)
            selected = id
            if P.Switch(id, true) then
                ns.Print(L.PROFILE_CREATED:format(P.Name(id)))
                ns.UI.Show("buttons")
            end
            RefreshUI()
        end)
    end)
end

function UI.BuildProfilesPage(p)
    page = p
    local intro = UI.Text(p, "GameFontHighlight", L.PROFILES_INTRO)
    intro:SetPoint("TOPLEFT", 12, -8)
    intro:SetPoint("RIGHT", -12, 0)
    intro:SetJustifyH("LEFT")

    local listTop = -52
    for i = 1, ROWS do
        local row = CreateFrame("Button", nil, p)
        row:SetSize(LIST_W, ROW_H - 2)
        row:SetPoint("TOPLEFT", 12, listTop - (i - 1) * ROW_H)
        local bg = row:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(1, 1, 1, 0.04)
        row.sel = row:CreateTexture(nil, "BORDER")
        row.sel:SetAllPoints()
        row.sel:SetColorTexture(0.3, 0.6, 1, 0.25)
        row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD")
        row.mark = UI.Text(row, "GameFontHighlight")
        row.mark:SetPoint("LEFT", 6, 0)
        row.mark:SetWidth(18)
        row.name = UI.Text(row, "GameFontHighlight")
        row.name:SetPoint("LEFT", 28, 0)
        row.name:SetPoint("RIGHT", row, "RIGHT", -190, 0)
        row.name:SetJustifyH("LEFT")
        row.name:SetWordWrap(false)
        row.sub = UI.Text(row, "GameFontDisableSmall")
        row.sub:SetPoint("RIGHT", -8, 0)
        row.sub:SetWidth(180)
        row.sub:SetJustifyH("RIGHT")
        row.sub:SetWordWrap(false)
        row:SetScript("OnClick", function(self)
            if self.entry then selected = self.entry.id end
            Refresh()
        end)
        -- (double-clic : utiliser ce profil)
        row:SetScript("OnDoubleClick", function(self)
            if self.entry then P.Switch(self.entry.id) end
            RefreshUI()
        end)
        rows[i] = row
    end
    p:EnableMouseWheel(true)
    p:SetScript("OnMouseWheel", function(_, delta)
        offset = offset - delta * 3
        Refresh()
    end)
    p.scrollText = UI.Text(p, "GameFontDisableSmall")
    p.scrollText:SetPoint("TOPLEFT", 14, listTop - ROWS * ROW_H - 4)

    -- Les actions, à droite de la liste
    local x, y = LIST_W + 32, listTop
    local function Add(label, onClick, gap)
        y = y - (gap or 0)
        local b = UI.Button(p, label, 200, 24)
        b:SetPoint("TOPLEFT", x, y)
        b:SetScript("OnClick", onClick)
        y = y - 30
        return b
    end
    p.use = Add(L.PROFILE_USE, Run(function(id) P.Switch(id) RefreshUI() end))
    Add(L.PROFILE_NEW, OnNew, 12)
    Add(L.PROFILE_COPY, function()
        local id = Selected()
        AskName(L.PROFILE_NAME_COPY, P.UniqueName(L.PROFILE_COPY_SUFFIX:format(P.Name(id))), function(name)
            selected = P.Copy(id, name)
            RefreshUI()
        end)
    end)
    Add(L.PROFILE_RENAME, function()
        local id = Selected()
        AskName(L.PROFILE_NAME_RENAME:format(P.Name(id)), P.Name(id), function(name)
            P.Rename(id, name)
            RefreshUI()
        end)
    end)
    p.delete = Add(L.PROFILE_DELETE, function()
        local id = Selected()
        Confirm(L.PROFILE_DELETE_CONFIRM:format(P.Name(id)), function()
            if P.Delete(id) then selected = nil end
            RefreshUI()
        end)
    end)
    Add(L.PROFILE_EXPORT, function() OpenExport(Selected()) end, 12)
    Add(L.PROFILE_IMPORT, OpenImport)

    p.Refresh = Refresh
end
