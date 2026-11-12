-- « Vérifier ma configuration » : ce qui empêche un bouton ou une case de
-- marcher, en une liste, avec de quoi le corriger ou y aller. Rien n'est
-- changé sans un clic sur le bouton d'une ligne.
--   /mgir check (ou verifier), le bouton de l'onglet Boutons et de l'onglet Aide
-- Seuls les boutons et les couches utilisés sont regardés : une couche d'un
-- bouton désactivé ou d'une paire décochée garde ses actions sans rien gêner.
local _, ns = ...
local L = ns.L

local C = {}
ns.Check = C

-- Les niveaux, du plus grave au moins grave, et leur couleur
local LEVELS = { error = 1, warn = 2, info = 3 }
local COLORS = { error = { 1, 0.3, 0.3 }, warn = { 1, 0.75, 0.2 }, info = { 0.5, 0.8, 1 } }

---------------------------------------------------------------------------
-- Où est une case : « L5 + A », « Seul : A », « L4 (LT +) »
---------------------------------------------------------------------------
local LAYER_LABEL = { base = "LAYER_BASE", lt = "LAYER_LT", rt = "LAYER_RT" }

local function SlotLabel(key)
    for _, pad in ipairs(ns.PAD_KEYS) do
        if pad == key then return ns.KeyLabel(key) end
    end
    return ns.ButtonLabel(key)
end

-- (isLayer : une couche Seul / LT / RT d'un bouton simple)
local function Where(id, key, isLayer)
    if isLayer then
        if key == "base" then return ns.ButtonLabel(id) end
        return ns.ButtonLabel(id) .. " (" .. L[LAYER_LABEL[key] or "LAYER_BASE"] .. ")"
    end
    if id == "BASE" then return L.LAYER_BASE .. " : " .. SlotLabel(key) end
    return ns.ButtonLabel(id) .. " + " .. SlotLabel(key)
end

-- Les cases utilisées de la spé active : fn(list, key, action, id, isLayer)
local function EachSlot(fn)
    local actions = ns.cprof and ns.cprof.actions
    if type(actions) ~= "table" then return end
    local simple = {}
    for _, id in ipairs(ns.SimpleIDs()) do simple[id] = true end
    local padKey = {}
    for _, key in ipairs(ns.PAD_KEYS) do padKey[key] = true end
    for _, id in ipairs(ns.LIST_IDS) do
        local a = actions[id]
        if type(a) == "table" then
            -- (les 8 combinaisons d'une couche, et une case par bouton simple)
            if type(a.combos) == "table" and (id == "BASE" or ns.IsModLayer(id)) then
                for key, action in pairs(a.combos) do
                    if type(action) == "table" and (padKey[key] or simple[key]) then
                        fn(a.combos, key, action, id, false)
                    end
                end
            end
            -- (les couches Seul / LT / RT d'un bouton simple)
            if type(a.layers) == "table" and simple[id] then
                for key, action in pairs(a.layers) do
                    if type(action) == "table" then fn(a.layers, key, action, id, true) end
                end
            end
        end
    end
end

---------------------------------------------------------------------------
-- Les contrôles : chacun ajoute des lignes
--   { level, text, fixLabel, fix = fn, tab = "buttons", layer = id }
---------------------------------------------------------------------------
local function CheckButtons(add)
    local byKey = {}
    for _, id in ipairs(ns.BUTTON_IDS) do
        local def = ns.Button(id)
        -- (un emplacement que la manette n'a pas ne compte pas)
        if def.mode ~= "off" and not def.key and ns.SlotName(id) then
            add({ level = "warn", text = L.CHECK_NO_KEY:format(ns.ButtonLabel(id)), tab = "buttons" })
        end
        if def.mode ~= "off" and def.key then
            local other = byKey[def.key]
            if other then
                add({ level = "error", tab = "buttons",
                    text = L.CHECK_SAME_KEY:format(ns.ButtonLabel(other), ns.ButtonLabel(id), ns.KeyLabel(def.key)) })
            else
                byKey[def.key] = id
            end
        end
    end
    local warning = ns.TargetingWarning()
    if warning then add({ level = "warn", text = warning, tab = "buttons" }) end
end

local function CheckPairs(add)
    local function Ready(id)
        -- (un modificateur prêt : sa couche existe seule)
        return ns.IsModLayer(id)
    end
    for _, pair in ipairs(ns.ALL_PAIRS) do
        if ns.PairEnabled(pair.id) then
            local a, b = Ready(pair.a), Ready(pair.b)
            if a ~= b then
                -- (une moitié de paire : l'autre bouton n'est pas un modificateur)
                local missing = a and pair.b or pair.a
                add({ level = "warn", tab = "buttons", fixLabel = L.CHECK_UNCHECK,
                    text = L.CHECK_PAIR_HALF:format(ns.ButtonLabel(pair.id), ns.ButtonLabel(missing)),
                    fix = function() ns.SetPairEnabled(pair.id, false) end })
            elseif a and b and ns.IsClassActionPair(pair.id) then
                add({ level = "warn", tab = "buttons", fixLabel = L.CHECK_UNCHECK,
                    text = L.PAIR_CLASS_WARN_LONG:format(ns.ButtonLabel(pair.id)),
                    fix = function() ns.SetPairEnabled(pair.id, false) end })
            end
        end
    end
end

local function Clear(list, key)
    return function()
        if ns.Profiles.ActionsCombat() then return end
        ns.Profiles.Backup()
        list[key] = nil
        ns.Apply()
        ns.Print(L.CHECK_CLEARED .. " " .. L.UNDO_HINT)
    end
end

local function CheckSlots(add)
    local A = ns.Actions
    EachSlot(function(list, key, action, id, isLayer)
        local where = Where(id, key, isLayer)
        if action.kind == "macro" then
            -- (une macro du jeu supprimée ou renommée : la case ne fait rien)
            if GetMacroIndexByName and (GetMacroIndexByName(action.name) or 0) == 0 then
                add({ level = "error", layer = id, fixLabel = L.CHECK_CLEAR, fix = Clear(list, key),
                    text = L.CHECK_MACRO_GONE:format(where, tostring(action.name)) })
            end
        elseif action.kind == "equipset" then
            local get = C_EquipmentSet and C_EquipmentSet.GetEquipmentSetID
            if get then
                local ok, setID = pcall(get, action.name)
                if ok and not setID then
                    add({ level = "error", layer = id, fixLabel = L.CHECK_CLEAR, fix = Clear(list, key),
                        text = L.CHECK_SET_GONE:format(where, tostring(action.name)) })
                end
            end
        elseif action.kind == "cond" or action.kind == "seq" then
            -- (aucune branche ou étape valide : la case ne fait rien)
            local _, text = A.Secure(action)
            if not text then
                add({ level = "error", layer = id, fixLabel = L.CHECK_CLEAR, fix = Clear(list, key),
                    text = L.CHECK_COMPOSED_EMPTY:format(where) })
            end
        end
        -- (un objet qui n'est ni dans les sacs ni équipé ; aussi dans une
        -- action composée)
        A.EachLeaf(list, key, function(_, _, leaf)
            if leaf.kind == "item" and type(leaf.id) == "number" then
                local ok, n = pcall(A.ItemCount, leaf.id)
                if ok and type(n) == "number" and not (issecretvalue and issecretvalue(n)) and n == 0 then
                    add({ level = "info", layer = id, text = L.CHECK_ITEM_GONE:format(where, A.Label(leaf) or "?") })
                end
            end
        end)
    end)

    -- Une commande WoW sur « Seul » d'un bouton simple qui a des couches LT / RT
    for _, id in ipairs(ns.SimpleIDs()) do
        local actions = ns.ButtonActions(id)
        if A.IsCommand(actions.layers.base) and not ns.Simple.CommandAllowed(actions, "base") then
            add({ level = "warn", layer = id, text = ns.ButtonLabel(id) .. " : " .. L.COMMAND_LT_RT })
        end
    end
end

local function CheckSpells(add)
    local A, P = ns.Actions, ns.Profiles
    local unknown = #A.UnknownSpots(ns.cprof.actions)
    if unknown > 0 then
        add({ level = "warn", fixLabel = L.CHECK_REMOVE, text = L.CHECK_UNKNOWN:format(unknown),
            fix = function()
                local spec = P.SpecName() or P.ClassName()
                ns.UI.Confirm(L.UNKNOWN_CONFIRM:format(unknown, spec), function()
                    if P.ActionsCombat() then return end
                    P.Backup()
                    local spots = A.UnknownSpots(ns.cprof.actions)
                    for _, s in ipairs(spots) do s.list[s.key] = nil end
                    ns.Apply()
                    ns.Print(L.UNKNOWN_REMOVED:format(#spots) .. " " .. L.UNDO_HINT)
                end)
            end })
    end
    local lower = ns.Uprank and ns.Uprank.LowerCount() or 0
    if lower > 0 then
        add({ level = "info", fixLabel = L.CHECK_REPLACE, text = L.CHECK_LOWER_RANKS:format(lower),
            fix = function() ns.Uprank.CheckAll() end })
    end
end

-- Un bouton supplémentaire réglé mais sans aucune action
local function CheckEmpty(add)
    local simple = ns.SimpleIDs()
    for _, id in ipairs(ns.BUTTON_IDS) do
        local def = ns.Button(id)
        if def.key and def.mode ~= "off" then
            local actions = ns.ButtonActions(id)
            local any = false
            if def.mode == "simple" then
                any = next(actions.layers) ~= nil
            else
                for _, key in ipairs(ns.PAD_KEYS) do
                    if actions.combos[key] then any = true end
                end
                for _, sid in ipairs(simple) do
                    if actions.combos[sid] then any = true end
                end
            end
            if not any then
                add({ level = "info", layer = id, text = L.CHECK_EMPTY_BUTTON:format(ns.ButtonLabel(id)) })
            end
        end
    end
end

local function CheckState(add)
    -- (l'appui bref d'un bouton de ciblage ne se mesure pas dans ce jeu)
    local targeting = false
    for _, id in ipairs(ns.BUTTON_IDS) do
        local def = ns.Button(id)
        if def.key and (def.mode == "target_friend" or def.mode == "target_enemy") then targeting = true end
    end
    for _, id in ipairs(ns.PAD_IDS) do
        local mode = ns.PadMode(id)
        if mode == "target_friend" or mode == "target_enemy" then targeting = true end
    end
    if targeting and ns.Modifier.TapMode and ns.Modifier.TapMode() == "safe" then
        add({ level = "info", text = L.CHECK_TAP_SAFE })
    end
    if ns.IsPending() then add({ level = "info", text = L.APPLIED_AFTER_COMBAT }) end
end

-- Toutes les lignes, les plus graves d'abord
function C.Run()
    local lines = {}
    if not (ns.db and ns.prof and ns.cprof) then return lines end
    local function add(line)
        line.order = #lines
        lines[#lines + 1] = line
    end
    -- (un contrôle en erreur n'arrête pas les autres)
    for _, check in ipairs({ CheckButtons, CheckPairs, CheckSlots, CheckSpells, CheckEmpty, CheckState }) do
        local ok, err = pcall(check, add)
        if not ok and ns.Diag then ns.Diag.Log("vérification : " .. tostring(err)) end
    end
    table.sort(lines, function(a, b)
        local x, y = LEVELS[a.level] or 3, LEVELS[b.level] or 3
        if x ~= y then return x < y end
        return a.order < b.order
    end)
    return lines
end

---------------------------------------------------------------------------
-- La fenêtre
---------------------------------------------------------------------------
local ROWS, ROW_H = 8, 46
local WIDTH = 640
local win

local function Refresh()
    if not (win and win:IsShown()) then return end
    local lines = C.Run()
    win.lines = lines
    local maxOffset = math.max(0, #lines - ROWS)
    win.offset = math.min(math.max(win.offset or 0, 0), maxOffset)
    local counts = { error = 0, warn = 0, info = 0 }
    for _, line in ipairs(lines) do counts[line.level] = (counts[line.level] or 0) + 1 end
    if #lines == 0 then
        win.summary:SetText(L.CHECK_ALL_GOOD)
        win.summary:SetTextColor(0.4, 1, 0.4)
    else
        win.summary:SetText(L.CHECK_SUMMARY:format(counts.error + counts.warn, counts.info))
        win.summary:SetTextColor(1, 1, 1)
    end
    for i = 1, ROWS do
        local row, line = win.rows[i], lines[win.offset + i]
        row.line = line
        row:SetShown(line ~= nil)
        if line then
            local c = COLORS[line.level] or COLORS.info
            row.dot:SetColorTexture(c[1], c[2], c[3], 1)
            row.text:SetText(line.text)
            local label = line.fix and (line.fixLabel or L.CHECK_FIX) or ((line.tab or line.layer) and L.CHECK_GO)
            row.button:SetShown(label ~= nil)
            if label then row.button:SetText(label) end
        end
    end
    win.scrollText:SetText(#lines > ROWS
        and ("%d-%d / %d"):format(win.offset + 1, math.min(win.offset + ROWS, #lines), #lines) or "")
end

local function Build()
    local UI = ns.UI
    win = UI.Dialog("MyGamepadIsRichCheckDialog", WIDTH, 120 + ROWS * ROW_H, L.CHECK_TITLE)
    win.summary = UI.Text(win, "GameFontHighlight")
    win.summary:SetPoint("TOP", win.title, "BOTTOM", 0, -8)
    win.summary:SetWidth(WIDTH - 40)
    win.rows = {}
    for i = 1, ROWS do
        local row = CreateFrame("Frame", nil, win)
        row:SetHeight(ROW_H - 4)
        row:SetPoint("TOPLEFT", 16, -64 - (i - 1) * ROW_H)
        row:SetPoint("RIGHT", -16, 0)
        local back = row:CreateTexture(nil, "BACKGROUND")
        back:SetAllPoints()
        back:SetColorTexture(1, 1, 1, 0.04)
        row.dot = row:CreateTexture(nil, "ARTWORK")
        row.dot:SetSize(6, ROW_H - 12)
        row.dot:SetPoint("LEFT", 4, 0)
        row.button = UI.Button(row, "", 130, 24)
        row.button:SetPoint("RIGHT", -6, 0)
        row.text = UI.Text(row, "GameFontHighlightSmall")
        row.text:SetPoint("LEFT", row.dot, "RIGHT", 8, 0)
        row.text:SetPoint("RIGHT", row.button, "LEFT", -10, 0)
        row.text:SetHeight(ROW_H - 8)
        row.text:SetJustifyH("LEFT")
        row.text:SetJustifyV("MIDDLE")
        row.text:SetWordWrap(true)
        row.button:SetScript("OnClick", function()
            local line = row.line
            if not line then return end
            if line.fix then
                line.fix()
                Refresh()
            elseif line.layer and UI.ShowLayer then
                UI.ShowLayer(line.layer)
            elseif line.tab then
                UI.Show(line.tab)
            end
        end)
        win.rows[i] = row
    end
    win:EnableMouseWheel(true)
    win:SetScript("OnMouseWheel", function(_, delta)
        win.offset = (win.offset or 0) - delta
        Refresh()
    end)
    win.scrollText = UI.Text(win, "GameFontDisableSmall")
    win.scrollText:SetPoint("BOTTOMLEFT", 16, 18)
    local again = UI.Button(win, L.CHECK_AGAIN, 180, 24)
    again:SetPoint("BOTTOMRIGHT", win, "BOTTOM", -6, 12)
    again:SetScript("OnClick", Refresh)
    local close = UI.Button(win, L.CLOSE, 120, 24)
    close:SetPoint("BOTTOMLEFT", win, "BOTTOM", 6, 12)
    close:SetScript("OnClick", function() win:Hide() end)
    win:SetScript("OnShow", Refresh)
    -- (une correction appliquée, un réglage changé à côté : la liste suit)
    ns.OnApplied(function() Refresh() end)
    win:Hide()
end

function C.Show()
    if not (ns.db and ns.UI and ns.UI.Dialog) then return end
    if not win then Build() end
    win.offset = 0
    win:Show()
    win:Raise()
    Refresh()
end
