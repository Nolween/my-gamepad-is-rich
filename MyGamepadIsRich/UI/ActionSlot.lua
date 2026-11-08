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
--   disabledHint = fn() -> texte qui dit pourquoi des choix du menu sont grisés,
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
            self.border:SetColorTexture(0.3, 0.3, 0.3, 0.6)
            return
        end
        self.lock:Hide()
        self.border:SetColorTexture(0.45, 0.42, 0.35, 0.9)
        local action = self.opts.get()
        if action then
            self.icon:SetTexture(ns.Actions.Icon(action))
            self.icon:Show()
            self.plus:Hide()
            self.label:SetText(ns.Actions.Label(action) or "")
            self.label:SetFontObject("GameFontHighlightSmall")
        else
            self.icon:Hide()
            self.plus:Show()
            self.label:SetText(self.opts.emptyLabel and self.opts.emptyLabel() or L.EMPTY)
            self.label:SetFontObject("GameFontDisableSmall")
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
        if action then
            ClearCursor()
            Set(action)
        elseif err then
            ClearCursor()
            ns.Print(err)
        end
    end

    local function Menu()
        local current = slot.opts.get()
        local commandOK = Allowed(slot.opts.allowCommand)
        local macroOK = Allowed(slot.opts.allowMacroText)
        local items = {
            { text = L.MENU_PICKUP_HINT, title = true },
            { text = L.MENU_SPELL, func = function()
                UI.PickFromList(L.SPELL_TITLE, ns.Actions.SpellbookEntries(), Set)
            end },
            { text = L.MENU_ITEM, func = function()
                UI.PickFromList(L.ITEM_TITLE, ns.Actions.ItemEntries(), Set)
            end },
            -- (sauter, annuler, rechercher, attaque auto, interagir)
            { text = L.MENU_GAME, disabled = not macroOK, func = function()
                UI.PickFromList(L.GAME_TITLE, ns.Actions.GameEntries(commandOK), Set)
            end },
            { text = L.MENU_MACROTEXT, disabled = not macroOK, func = function()
                local initial = current and current.kind == "macrotext" and current.text
                if not initial and current then
                    local _, text = ns.Actions.Secure(current)
                    initial = text
                end
                UI.EditMacro(initial, function(text)
                    Set(text ~= "" and { kind = "macrotext", text = text } or nil)
                end)
            end },
            { text = L.MENU_COMMAND, disabled = not commandOK, func = function()
                UI.PickFromList(L.COMMAND_TITLE, ns.Actions.Commands(), Set)
            end },
            { text = L.MENU_CLEAR, disabled = current == nil, func = function() Set(nil) end },
        }
        -- (des choix grisés : pourquoi, et comment les avoir)
        local hint = slot.opts.disabledHint and slot.opts.disabledHint()
        if hint and not (commandOK and macroOK) then items[#items + 1] = { text = hint, title = true } end
        UI.ShowMenu(slot, items)
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
            if (action.kind == "spell" or action.kind == "mount") and GameTooltip.SetSpellByID then
                shown = pcall(GameTooltip.SetSpellByID, GameTooltip, action.id)
            elseif (action.kind == "item" or action.kind == "toy") and GameTooltip.SetItemByID then
                shown = pcall(GameTooltip.SetItemByID, GameTooltip, action.id)
            elseif action.kind == "slot" and GameTooltip.SetAction then
                shown = pcall(GameTooltip.SetAction, GameTooltip, action.slot)
            end
            if not shown then
                GameTooltip:SetText(ns.Actions.Label(action) or "", 1, 1, 1)
            end
            GameTooltip:AddLine(ns.Actions.KindLabel(action), 0.6, 0.8, 1)
            if action.kind == "macrotext" then GameTooltip:AddLine(action.text, 0.9, 0.9, 0.9, true) end
        else
            GameTooltip:SetText(L.EMPTY, 0.7, 0.7, 0.7)
        end
        GameTooltip:AddLine(L.SLOT_HINT, 1, 0.82, 0, true)
        GameTooltip:Show()
    end)
    slot:SetScript("OnLeave", function() GameTooltip:Hide() end)

    slot:Refresh()
    return slot
end
