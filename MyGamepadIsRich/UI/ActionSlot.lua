-- Emplacement d'action : glisser-déposer (sort, objet, macro, monture,
-- jouet, ensemble d'équipement), clic pour le menu, clic droit pour vider.
local _, ns = ...
local L = ns.L
local UI = ns.UI

local SIZE = 40

-- opts = {
--   get = fn() -> action, set = fn(action),
--   allowCommand = fn() -> bool (commande WoW possible ?),
--   allowMacroText = fn() -> bool (macro écrite à la main possible ?),
--   locked = fn() -> bool (case réservée au jeu : ni pose, ni vidage),
--   emptyLabel = fn() -> texte d'une case vide (sinon « Vide »),
--   gameIcon = fn() -> texture, atlas d'une case vide qui garde l'action du
--              jeu (sauter...), montrée à la place du « + »,
--   disabledHint = fn() -> texte qui dit pourquoi des choix du menu sont grisés,
--   found = fn(action) -> bool (trouvée par une recherche : bord doré),
--   kinds = { spell = true, ... } (une branche d'une action composée : ces
--           types seulement, par le menu comme par dépôt),
--   allowUnit = bool (avec kinds : la cible du sort se choisit),
--   labelWidth = n,
-- }
local function Allowed(fn)
    return not fn or fn()
end

function UI.CreateActionSlot(parent, opts)
    local slot = CreateFrame("Button", nil, parent)
    slot:SetSize(SIZE, SIZE)
    slot:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    slot:RegisterForDrag("LeftButton")
    slot.opts = opts

    local border = slot:CreateTexture(nil, "BACKGROUND", nil, 0)
    border:SetPoint("TOPLEFT", -3, 3)
    border:SetPoint("BOTTOMRIGHT", 3, -3)
    border:SetColorTexture(0.45, 0.42, 0.35, 0.9)
    slot.border = border
    local bg = slot:CreateTexture(nil, "BACKGROUND", nil, 1)
    bg:SetPoint("TOPLEFT", -2, 2)
    bg:SetPoint("BOTTOMRIGHT", 2, -2)
    bg:SetColorTexture(0, 0, 0, 0.75)

    slot.icon = slot:CreateTexture(nil, "ARTWORK")
    slot.icon:SetAllPoints()
    slot.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    slot.plus = UI.Text(slot, "GameFontDisableLarge", "+")
    slot.plus:SetPoint("CENTER")
    slot.lock = UI.Text(slot, "GameFontDisableSmall", L.GAME_ACTION)
    slot.lock:SetPoint("CENTER")
    slot:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    -- (cible choisie « @ », action selon le contexte « / », étape d'un cycle)
    slot.badge = UI.Text(slot, "GameFontNormalSmall")
    slot.badge:SetPoint("TOPLEFT", 1, -1)

    slot.label = UI.Text(slot, "GameFontHighlightSmall")
    slot.label:SetPoint("TOP", slot, "BOTTOM", 0, -4)
    slot.label:SetWidth(opts.labelWidth or 84)
    slot.label:SetHeight(24)
    slot.label:SetJustifyV("TOP")
    slot.label:SetWordWrap(true)

    local function Locked()
        return slot.opts.locked and slot.opts.locked()
    end

    function slot:Refresh()
        if Locked() then
            self.icon:Hide()
            self.plus:Hide()
            self.lock:Show()
            self.label:SetText("")
            self.badge:SetText("")
            self.border:SetColorTexture(0.3, 0.3, 0.3, 0.6)
            return
        end
        self.lock:Hide()
        local action = self.opts.get()
        self.badge:SetText(ns.Actions.Badge(action) or "")
        -- (trouvée par la recherche de l'onglet Actions : bord doré)
        if action and self.opts.found and self.opts.found(action) then
            self.border:SetColorTexture(1, 0.82, 0, 1)
        else
            self.border:SetColorTexture(0.45, 0.42, 0.35, 0.9)
        end
        if action then
            self.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
            self.icon:SetTexture(ns.Actions.Icon(action))
            self.icon:Show()
            self.plus:Hide()
            self.label:SetText(ns.Actions.Label(action) or "")
            self.label:SetFontObject("GameFontHighlightSmall")
            -- (un sort que ce personnage ne connaît pas : grisé, teinté de rouge)
            local known = ns.Actions.IsKnown(action)
            self.icon:SetDesaturated(not known)
            self.icon:SetVertexColor(1, known and 1 or 0.35, known and 1 or 0.35)
            if not known then self.label:SetTextColor(1, 0.35, 0.35) end
        else
            -- (l'action du jeu que la case garde : son image, comme le HUD)
            local tex, atlas
            if self.opts.gameIcon then tex, atlas = self.opts.gameIcon() end
            local shown = false
            if atlas then
                shown = pcall(self.icon.SetAtlas, self.icon, atlas)
            elseif tex then
                self.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
                shown = pcall(self.icon.SetTexture, self.icon, tex)
            end
            if shown then
                self.icon:SetDesaturated(false)
                self.icon:SetVertexColor(1, 1, 1)
                self.icon:Show()
                self.plus:Hide()
            else
                self.icon:Hide()
                self.plus:Show()
            end
            self.label:SetText(self.opts.emptyLabel and self.opts.emptyLabel() or L.EMPTY)
            self.label:SetFontObject(shown and "GameFontHighlightSmall" or "GameFontDisableSmall")
        end
    end

    local function Set(action)
        slot.opts.set(action)
        slot:Refresh()
        if GameTooltip:IsOwned(slot) then slot:GetScript("OnEnter")(slot) end
    end

    local function Accept()
        if Locked() then
            ClearCursor()
            ns.Print(L.HUD_GAME_SLOT)
            return
        end
        local action, err = ns.Actions.FromCursor()
        if action and slot.opts.kinds and not slot.opts.kinds[action.kind] then
            -- (une branche d'une action composée : sorts et objets seulement)
            action, err = nil, L.SLOT_KIND_REFUSED
        end
        if action then
            ClearCursor()
            Set(action)
        elseif err then
            ClearCursor()
            ns.Print(err)
        end
    end

    local function Menu()
        local commandOK = Allowed(slot.opts.allowCommand)
        local macroOK = Allowed(slot.opts.allowMacroText)
        -- (des choix grisés : pourquoi, et comment les avoir)
        local hint = slot.opts.disabledHint and slot.opts.disabledHint()
        UI.ShowMenu(slot, UI.ActionMenuItems({
            current = slot.opts.get(), set = Set,
            macroOK = macroOK, commandOK = commandOK,
            kinds = slot.opts.kinds, unitOK = slot.opts.allowUnit,
            hint = hint and not (commandOK and macroOK) and hint or nil,
        }))
    end

    slot:SetScript("OnReceiveDrag", Accept)
    slot:SetScript("OnClick", function(_, mouse)
        if Locked() then
            ns.Print(L.HUD_GAME_SLOT)
        elseif GetCursorInfo() then
            Accept()
        elseif mouse == "RightButton" then
            if slot.opts.get() then Set(nil) end
        else
            Menu()
        end
    end)

    slot:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if Locked() then
            GameTooltip:SetText(L.GAME_ACTION, 1, 1, 1)
            GameTooltip:AddLine(L.HUD_GAME_SLOT, 0.8, 0.8, 0.8, true)
            GameTooltip:Show()
            return
        end
        local action = self.opts.get()
        if action then
            local shown = false
            -- (une action composée : l'info-bulle de ce qui partirait maintenant)
            local now = ns.Actions.Resolve(action) or action
            if (now.kind == "spell" or now.kind == "mount") and GameTooltip.SetSpellByID then
                shown = pcall(GameTooltip.SetSpellByID, GameTooltip, now.id)
            elseif (now.kind == "item" or now.kind == "toy") and GameTooltip.SetItemByID then
                shown = pcall(GameTooltip.SetItemByID, GameTooltip, now.id)
            elseif now.kind == "slot" and GameTooltip.SetAction then
                shown = pcall(GameTooltip.SetAction, GameTooltip, now.slot)
            elseif now.kind == "best" and GameTooltip.SetItemByID then
                -- (l'objet qui partira)
                local item = ns.Actions.BestItem(now.cat)
                shown = item ~= nil and pcall(GameTooltip.SetItemByID, GameTooltip, item)
            end
            if not shown then
                GameTooltip:SetText(ns.Actions.Label(action) or "", 1, 1, 1)
                if action.kind == "best" then GameTooltip:AddLine(L.BEST_NONE, 0.7, 0.7, 0.7) end
            elseif now.kind == "spell" then
                ns.Actions.AddRankToTooltip(GameTooltip, now)
            end
            if not ns.Actions.IsKnown(action) then GameTooltip:AddLine(L.SPELL_UNKNOWN, 1, 0.35, 0.35, true) end
            GameTooltip:AddLine(action.kind == "best" and ns.Actions.Label(action) or ns.Actions.KindLabel(action),
                0.6, 0.8, 1)
            -- (cible choisie, condition et branches, étapes d'un cycle)
            ns.Actions.AddDetailsToTooltip(GameTooltip, action)
            if action.kind == "best" then GameTooltip:AddLine(L.BEST_DESC, 0.9, 0.9, 0.9, true) end
            if action.kind == "macrotext" then GameTooltip:AddLine(action.text, 0.9, 0.9, 0.9, true) end
        else
            local label = self.opts.emptyLabel and self.opts.emptyLabel()
            GameTooltip:SetText(label or L.EMPTY, 0.7, 0.7, 0.7)
            -- (A/B/X/Y de « Seul » : l'action du jeu reste tant que la case
            -- n'a pas d'action de l'addon)
            if self.opts.gameIcon and self.opts.gameIcon() then
                GameTooltip:AddLine(L.HUD_GAME_SLOT, 0.8, 0.8, 0.8, true)
            end
        end
        GameTooltip:AddLine(L.SLOT_HINT, 1, 0.82, 0, true)
        GameTooltip:Show()
    end)
    slot:SetScript("OnLeave", function() GameTooltip:Hide() end)

    slot:Refresh()
    return slot
end

---------------------------------------------------------------------------
-- Le menu d'une case : le même dans l'onglet Couches, sur le HUD et dans
-- les fenêtres des actions composées.
-- ctx = {
--   current = l'action de la case, ou nil ; set = fn(action),
--   macroOK = bool (une macro de l'addon est possible sur cette case),
--   commandOK = bool (une commande WoW aussi),
--   kinds = { spell = true, ... } (une branche ou une étape : ces types
--           seulement ; le menu se réduit aux sorts et aux objets),
--   unitOK = bool (avec kinds : la cible se choisit),
--   clearAlways = bool (« Vider » même sans action de l'addon : une case
--                 de la barre du jeu),
--   hint = le texte qui dit pourquoi des choix sont grisés, ou nil,
-- }
---------------------------------------------------------------------------
function UI.ActionMenuItems(ctx)
    local A = ns.Actions
    local current, set, kinds = ctx.current, ctx.set, ctx.kinds
    local macroOK = ctx.macroOK and not kinds

    -- (une branche : seulement les types permis)
    local function Only(entries)
        if not kinds then return entries end
        local out = {}
        for _, e in ipairs(entries) do
            if e.header or (e.action and kinds[e.action.kind]) then out[#out + 1] = e end
        end
        return out
    end

    local items = {
        { text = kinds and L.MENU_PICKUP_CAST or L.MENU_PICKUP_HINT, title = true },
        { text = L.MENU_SPELL, func = function()
            UI.PickFromList(L.SPELL_TITLE, Only(A.SpellbookEntries()), set)
        end },
        { text = L.MENU_ITEM, func = function()
            UI.PickFromList(L.ITEM_TITLE, Only(A.ItemEntries()), set)
        end },
    }
    local function Add(item) items[#items + 1] = item end

    if not kinds then
        -- (le meilleur objet des sacs de ce type : une macro de l'addon)
        Add({ text = L.MENU_BEST, disabled = not macroOK, func = function()
            UI.PickFromList(L.BEST_TITLE, A.BestEntries(), set)
        end })
        -- (sauter, annuler, rechercher, attaque auto, interagir)
        Add({ text = L.MENU_GAME, disabled = not macroOK, func = function()
            UI.PickFromList(L.GAME_TITLE, A.GameEntries(ctx.commandOK), set)
        end })
        Add({ text = L.MENU_MACROTEXT, disabled = not macroOK, func = function()
            local initial = current and current.kind == "macrotext" and current.text
            if not initial and current then
                local _, text = A.Secure(current)
                initial = text
            end
            -- (une macro écrite tient 255 caractères : pas le texte, plus long,
            -- d'une action de l'addon)
            if initial and #initial > 255 then initial = nil end
            UI.EditMacro(initial, function(text)
                set(text ~= "" and { kind = "macrotext", text = text } or nil)
            end)
        end })
        Add({ text = L.MENU_COMMAND, disabled = not ctx.commandOK, func = function()
            UI.PickFromList(L.COMMAND_TITLE, A.Commands(), set)
        end })
    end

    -- (un sort ou un objet : sur moi, le focus, un membre du groupe...)
    if not kinds or ctx.unitOK then
        Add({ text = L.MENU_UNIT, disabled = not (A.CanSetUnit(current) and (macroOK or ctx.unitOK)), func = function()
            UI.PickFromList(L.UNIT_TITLE, A.UnitEntries(current), function(choice)
                set(A.WithUnit(current, choice.unit or nil))
            end)
        end })
    end

    if not kinds then
        -- (deux actions et une condition ; plusieurs actions à la suite)
        Add({ text = L.MENU_COND, disabled = not macroOK, func = function() UI.EditCond(current, set) end })
        Add({ text = L.MENU_SEQ, disabled = not macroOK, func = function() UI.EditSeq(current, set) end })
        -- (commande WoW, macro écrite : une icône au choix)
        Add({ text = L.MENU_ICON, disabled = not A.CanSetIcon(current), func = function()
            UI.PickIcon(current.icon, function(icon) set(A.WithIcon(current, icon)) end)
        end })
    end

    Add({ text = L.MENU_CLEAR, disabled = current == nil and not ctx.clearAlways, func = function() set(nil) end })
    if ctx.hint then Add({ text = ctx.hint, title = true }) end
    return items
end

---------------------------------------------------------------------------
-- Fenêtres des actions composées : chacune a des cases comme les autres,
-- limitées aux sorts et aux objets. OK rend l'action à la case d'origine.
---------------------------------------------------------------------------
local SLOT_Y = -150

local function ComposedDialog(name, width, title, help)
    local d = UI.Dialog(name, width, 290, title)
    d.help = UI.Text(d, "GameFontHighlightSmall", help)
    d.help:SetPoint("TOP", d.title, "BOTTOM", 0, -8)
    d.help:SetWidth(width - 40)
    d.help:SetJustifyH("CENTER")
    d.ok = UI.Button(d, L.OK, 120)
    d.ok:SetPoint("BOTTOMRIGHT", d, "BOTTOM", -6, 12)
    local cancel = UI.Button(d, L.CANCEL, 120)
    cancel:SetPoint("BOTTOMLEFT", d, "BOTTOM", 6, 12)
    cancel:SetScript("OnClick", function() d:Hide() end)
    d:Hide()
    return d
end

-- Une ligne « libellé : [bouton] » qui ouvre une liste à choisir
local function ChoiceRow(d, y, text)
    local label = UI.Text(d, "GameFontNormal", text)
    label:SetPoint("TOPRIGHT", d, "TOP", -70, y - 5)
    local button = UI.Button(d, "", 230, 24)
    button:SetPoint("TOPLEFT", d, "TOP", -60, y)
    return button
end

-- Action selon le contexte : une condition, l'action si elle est vraie,
-- l'action sinon (une des deux peut rester vide)
local condDialog

local function BuildCondDialog()
    local A = ns.Actions
    local d = ComposedDialog("MyGamepadIsRichCondDialog", 460, L.COND_TITLE, L.COND_HELP)
    d.pick = ChoiceRow(d, -84, L.COND_IF)
    d.pick:SetScript("OnClick", function()
        UI.PickFromList(L.COND_TITLE, A.CondEntries(), function(choice)
            d.cond = choice.cond
            d:Refresh()
        end)
    end)
    local function Branch(key, title, x)
        local text = UI.Text(d, "GameFontNormal", title)
        text:SetPoint("TOP", d, "TOP", x, SLOT_Y + 22)
        local slot = UI.CreateActionSlot(d, {
            get = function() return d[key] end,
            set = function(action) d[key] = action end,
            kinds = A.COND_KINDS, allowUnit = true,
            emptyLabel = function() return L.COND_NOTHING end,
            labelWidth = 190,
        })
        slot:SetPoint("TOP", d, "TOP", x, SLOT_Y)
        return slot
    end
    d.slotA = Branch("a", L.COND_THEN, -110)
    d.slotB = Branch("b", L.COND_ELSE, 110)
    function d:Refresh()
        self.pick:SetText(A.CondLabel(self.cond))
        self.slotA:Refresh()
        self.slotB:Refresh()
    end
    d.ok:SetScript("OnClick", function()
        if not (d.a or d.b) then
            ns.Print(L.COND_NEED_ACTION)
            return
        end
        d:Hide()
        if d.onOK then d.onOK({ kind = "cond", cond = d.cond, a = d.a, b = d.b }) end
    end)
    condDialog = d
end

-- current : l'action de la case (une action selon le contexte à modifier ;
-- un sort ou un objet devient la première branche)
function UI.EditCond(current, onOK)
    if not condDialog then BuildCondDialog() end
    local A, d = ns.Actions, condDialog
    d.onOK = onOK
    d.cond, d.a, d.b = A.CONDS[1].id, nil, nil
    if current and current.kind == "cond" then
        if A.CondDef(current.cond) then d.cond = current.cond end
        d.a, d.b = current.a, current.b
    elseif current and A.COND_KINDS[current.kind] then
        d.a = current
    end
    d:Refresh()
    d:Show()
    d:Raise()
end

-- Action cyclique : 2 à 4 sorts ou objets, le suivant à chaque appui, et
-- quand revenir au premier
local seqDialog

local function BuildSeqDialog()
    local A = ns.Actions
    local d = ComposedDialog("MyGamepadIsRichSeqDialog", 520, L.SEQ_TITLE, L.SEQ_HELP)
    d.pick = ChoiceRow(d, -84, L.SEQ_RESET)
    d.pick:SetScript("OnClick", function()
        UI.PickFromList(L.SEQ_RESET, A.SeqResetEntries(), function(choice)
            d.reset = choice.reset or nil
            d:Refresh()
        end)
    end)
    d.steps, d.slots = {}, {}
    for i = 1, A.SEQ_MAX do
        local x = (i - (A.SEQ_MAX + 1) / 2) * 120
        local number = UI.Text(d, "GameFontNormal", tostring(i))
        number:SetPoint("TOP", d, "TOP", x, SLOT_Y + 22)
        local slot = UI.CreateActionSlot(d, {
            get = function() return d.steps[i] end,
            set = function(action) d.steps[i] = action end,
            kinds = A.SEQ_KINDS,
            labelWidth = 112,
        })
        slot:SetPoint("TOP", d, "TOP", x, SLOT_Y)
        d.slots[i] = slot
    end
    function d:Refresh()
        self.pick:SetText(A.SeqResetLabel(self.reset))
        for _, slot in ipairs(self.slots) do slot:Refresh() end
    end
    d.ok:SetScript("OnClick", function()
        -- (les cases vides entre deux étapes sont sautées)
        local steps = {}
        for i = 1, A.SEQ_MAX do
            if d.steps[i] then steps[#steps + 1] = d.steps[i] end
        end
        if #steps < 2 then
            ns.Print(L.SEQ_NEED_TWO)
            return
        end
        d:Hide()
        if d.onOK then d.onOK({ kind = "seq", steps = steps, reset = d.reset }) end
    end)
    seqDialog = d
end

-- current : l'action de la case (un cycle à modifier ; un sort ou un objet
-- devient la première étape, sans sa cible choisie : un cycle n'en a pas)
function UI.EditSeq(current, onOK)
    if not seqDialog then BuildSeqDialog() end
    local A, d = ns.Actions, seqDialog
    d.onOK = onOK
    d.reset = nil
    for i = 1, A.SEQ_MAX do d.steps[i] = nil end
    if current and current.kind == "seq" then
        if A.IsSeqReset(current.reset) then d.reset = current.reset end
        for i = 1, A.SEQ_MAX do
            local step = type(current.steps) == "table" and current.steps[i]
            if type(step) == "table" and A.SEQ_KINDS[step.kind] then d.steps[i] = step end
        end
    elseif current and A.SEQ_KINDS[current.kind] then
        d.steps[1] = current.unit and A.WithUnit(current, nil) or current
    end
    d:Refresh()
    d:Show()
    d:Raise()
end
