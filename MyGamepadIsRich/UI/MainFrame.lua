-- Fenêtre de configuration, organisée par tâche :
--   Actions : chaque couche (barre manette du jeu : seul, LT, RT, LT + RT ;
--             modificateurs et paires ; boutons simples), disposée comme la
--             manette : la croix à gauche, A/B/X/Y à droite (comme le HUD) ;
--   Boutons : les boutons supplémentaires (nom, touche, mode) et les paires ;
--   Profils : UI/ProfilesTab.lua (liste, export, import) ;
--   HUD     : affichage, miniatures, taille, position, bouton de la minimap ;
--   Test manette, Aide ;
--   Soutenir : UI/DonateTab.lua (don PayPal, QR code et lien).
-- Et la page dans Options > AddOns.
local _, ns = ...
local L = ns.L
local UI = ns.UI

local WIDTH, HEIGHT = 820, 600
local LIST_W = 214
local frame, pages, tabs = nil, {}, {}
local currentTab = "actions"
local RefreshAll
-- (onglet Couches : la hauteur de la phrase d'accueil)
local ACTIONS_TOP = 26

local DPAD_KEYS = { "PADDLEFT", "PADDUP", "PADDRIGHT", "PADDDOWN" }
local FACE_KEYS = { "PAD3", "PAD4", "PAD2", "PAD1" }
local SPOTS = { { -1, 0 }, { 0, 1 }, { 1, 0 }, { 0, -1 } }

local function IsLoaded(name)
    if C_AddOns and C_AddOns.IsAddOnLoaded then return C_AddOns.IsAddOnLoaded(name) end
    return IsAddOnLoaded and IsAddOnLoaded(name)
end

local ModeLabel = ns.ModeLabel

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
    -- l'addon quand le profil lui donne les gâchettes ; LB / RB aussi)
    local pad = { title = L.SECTION_PAD, items = {} }
    for _, name in ipairs(ns.Bar.NAMES) do
        if not ns.GameBarReplaced(name) then pad.items[#pad.items + 1] = { bar = name } end
    end
    local padLayers, extraLayers = ns.ModLayerLists()
    for _, id in ipairs(padLayers) do pad.items[#pad.items + 1] = { mod = id } end
    local mods = { title = L.SECTION_MODS, items = {}, empty = L.SECTION_MODS_EMPTY }
    for _, id in ipairs(extraLayers) do mods.items[#mods.items + 1] = { mod = id } end
    local simple = { title = L.SECTION_SIMPLE, items = {}, empty = L.SECTION_SIMPLE_EMPTY }
    for _, id in ipairs(ns.SimpleIDs()) do simple.items[#simple.items + 1] = { simple = id } end
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

-- Les boutons simples dans la couche choisie : leur case (couche de
-- modificateur), ou leur propre couche Seul / LT / RT (barre du jeu)
local BAR_SIMPLE_LAYER = { topBar = "base", leftBar = "lt", rightBar = "rt" }

---------------------------------------------------------------------------
-- « Où est ce sort ? » : le texte cherché (en minuscules, "" : pas de
-- recherche). Les couches qui ont une action dont le nom le contient
-- montrent leur nombre de cases trouvées ; ces cases ont un bord doré.
---------------------------------------------------------------------------
local searchText = ""

local function Found(action)
    if searchText == "" or not action then return false end
    local label = ns.Actions.Label(action)
    return type(label) == "string" and label:lower():find(searchText, 1, true) ~= nil
end

local function FoundCount(layer)
    local n = 0
    local function Count(action) if Found(action) then n = n + 1 end end
    if layer.bar then
        for i = 1, 8 do Count(ns.Bar.GetView(layer.bar, i)) end
        local own = BAR_SIMPLE_LAYER[layer.bar]
        if own then
            for _, sid in ipairs(ns.SimpleIDs()) do Count(ns.ButtonActions(sid).layers[own]) end
        end
    elseif layer.mod then
        for _, action in pairs(ns.ButtonActions(layer.mod).combos) do Count(action) end
    elseif layer.simple then
        for _, action in pairs(ns.ButtonActions(layer.simple).layers) do Count(action) end
    end
    return n
end

---------------------------------------------------------------------------
-- Onglet Actions : la liste des couches (gauche)
---------------------------------------------------------------------------
local list, entryPool, headerPool = nil, {}, {}
local LIST_TOP = -34 -- (au-dessus : le champ de recherche)

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
    local y, ne, nh = LIST_TOP, 0, 0
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
            if searchText ~= "" then
                -- (recherche : le nombre de cases trouvées, en doré ; les
                -- couches sans rien de trouvé, estompées)
                local found = FoundCount(item)
                e.count:SetText(found > 0 and found or "")
                e.count:SetTextColor(1, 0.82, 0)
                e:SetAlpha(found > 0 and 1 or 0.4)
            else
                local n, total = LayerCount(item)
                e.count:SetText(("%d/%d"):format(n, total))
                e.count:SetTextColor(n > 0 and 0.4 or 0.5, n > 0 and 0.9 or 0.5, n > 0 and 0.4 or 0.5)
                e:SetAlpha(1)
            end
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

local function SimpleGet(sid)
    if not sid then return nil end
    if selected.mod then return ns.ButtonActions(selected.mod).combos[sid] end
    local layer = BAR_SIMPLE_LAYER[selected.bar]
    return layer and ns.ButtonActions(sid).layers[layer]
end

local function SimpleSet(sid, action)
    if not sid then return end
    if selected.mod then
        ns.ButtonActions(selected.mod).combos[sid] = action
    else
        local layer = BAR_SIMPLE_LAYER[selected.bar]
        if not layer then return end
        local a = ns.ButtonActions(sid)
        a.layers[layer] = action
        if layer ~= "base" and action and ns.Actions.IsCommand(a.layers.base) then ns.Print(L.COMMAND_LT_RT) end
    end
    ns.Apply()
end

local function SimpleCommandAllowed(sid)
    if not sid then return false end
    if selected.mod then return true end
    local layer = BAR_SIMPLE_LAYER[selected.bar]
    return layer ~= nil and ns.Simple.CommandAllowed(ns.ButtonActions(sid), layer)
end

-- Remplissage rapide d'une couche de modificateur : ses cases vides (la
-- croix, puis X/Y/B/A) reçoivent la pierre de foyer, les bijoux et les
-- consommables des sacs qui n'y sont pas déjà
local function EmptyCrossSlots()
    if not selected.mod then return 0 end
    local combos, n = ns.ButtonActions(selected.mod).combos, 0
    for i = 1, 8 do
        if not combos[CrossKey(i)] then n = n + 1 end
    end
    return n
end

local function QuickFill()
    if not selected.mod then return end
    if InCombatLockdown() then
        ns.Print(L.HUD_COMBAT)
        return
    end
    local combos = ns.ButtonActions(selected.mod).combos
    local function Present(action)
        for _, a in pairs(combos) do
            if ns.Actions.Same(a, action) then return true end
        end
    end
    local queue = {}
    for _, action in ipairs(ns.Actions.QuickFillActions()) do
        if not Present(action) then queue[#queue + 1] = action end
    end
    local placed = 0
    for i = 1, 8 do
        local key = CrossKey(i)
        if not combos[key] and #queue > 0 then
            combos[key] = table.remove(queue, 1)
            placed = placed + 1
        end
    end
    if placed == 0 then
        ns.Print(L.QUICKFILL_NONE)
        return
    end
    ns.Print(L.QUICKFILL_DONE:format(placed))
    ns.Apply()
end

-- Copier / échanger une couche de combinaisons (modificateur, ciblage,
-- paire) avec une autre : ses 8 cases et celles des boutons simples. Avec
-- une sauvegarde : /mgir undo.
local function ComboCount(id)
    local n = 0
    for _ in pairs(ns.ButtonActions(id).combos) do n = n + 1 end
    return n
end

local function LayerOps()
    local from = selected.mod
    if not from or ns.Profiles.ActionsCombat() then return end
    local targets = {}
    local pad, extra = ns.ModLayerLists()
    for _, ids in ipairs({ pad, extra }) do
        for _, id in ipairs(ids) do
            if id ~= from then targets[#targets + 1] = id end
        end
    end
    if #targets == 0 then
        ns.Print(L.LAYER_COPY_NONE)
        return
    end
    local entries = {}
    for _, op in ipairs({ "copy", "swap" }) do
        entries[#entries + 1] = { header = op == "copy" and L.LAYER_COPY_TO or L.LAYER_SWAP_WITH }
        for _, id in ipairs(targets) do
            local n = ComboCount(id)
            entries[#entries + 1] = {
                label = ns.ButtonLabel(id),
                sub = n > 0 and L.ACTION_COUNT:format(n) or L.EMPTY,
                search = id,
                action = { op = op, to = id },
            }
        end
    end
    UI.PickFromList(L.LAYER_COPY_TITLE:format(ns.ButtonLabel(from)), entries, function(choice)
        local fromName, toName = ns.ButtonLabel(from), ns.ButtonLabel(choice.to)
        local function Do()
            if ns.Profiles.ActionsCombat() then return end
            ns.Profiles.Backup()
            local a, b = ns.ButtonActions(from), ns.ButtonActions(choice.to)
            if choice.op == "copy" then
                b.combos = ns.DeepCopy(a.combos)
                ns.Print(L.LAYER_COPIED:format(fromName, toName) .. " " .. L.UNDO_HINT)
            else
                a.combos, b.combos = b.combos, a.combos
                ns.Print(L.LAYER_SWAPPED:format(fromName, toName) .. " " .. L.UNDO_HINT)
            end
            ns.Apply()
        end
        local n = ComboCount(choice.to)
        if choice.op == "copy" and n > 0 then
            UI.Confirm(L.LAYER_COPY_CONFIRM:format(toName, n, fromName), Do)
        else
            Do()
        end
    end)
end

-- Modèles de classe (au compte) et copie depuis une autre spé : tout le
-- jeu d'actions de la spé active est remplacé, avec une sauvegarde
local function TemplatesMenu()
    local P = ns.Profiles
    if P.ActionsCombat() then return end
    local class = P.ClassName()
    local templates, specs = P.Templates(), P.OtherSpecs()
    local entries = {
        { header = L.TPL_SECTION_SAVE },
        { label = L.TPL_SAVE, sub = class, action = { op = "save" } },
    }
    if #templates > 0 then
        entries[#entries + 1] = { header = L.TPL_SECTION_LOAD:format(class) }
        for _, t in ipairs(templates) do
            entries[#entries + 1] = { label = t.name, sub = L.ACTION_COUNT:format(t.count),
                action = { op = "load", name = t.name } }
        end
    end
    if #specs > 0 then
        entries[#entries + 1] = { header = L.TPL_SECTION_SPEC }
        for _, s in ipairs(specs) do
            entries[#entries + 1] = { label = s.name, sub = L.ACTION_COUNT:format(s.count),
                action = { op = "spec", key = s.key, name = s.name } }
        end
    end
    -- (les sorts que ce personnage ne connaît pas, dans la spé active)
    local unknown = #ns.Actions.UnknownSpots(ns.cprof.actions)
    if unknown > 0 then
        entries[#entries + 1] = { header = L.UNKNOWN_SECTION }
        entries[#entries + 1] = { label = L.UNKNOWN_REMOVE, sub = L.ACTION_COUNT:format(unknown),
            action = { op = "unknown" } }
    end
    if #templates > 0 then
        entries[#entries + 1] = { header = L.TPL_SECTION_DELETE }
        for _, t in ipairs(templates) do
            entries[#entries + 1] = { label = t.name, action = { op = "delete", name = t.name } }
        end
    end
    local spec = P.SpecName() or class
    UI.PickFromList(L.TPL_TITLE, entries, function(choice)
        if choice.op == "save" then
            UI.AskText(L.TPL_SAVE_PROMPT:format(class), spec, P.NAME_MAX, function(text)
                local name = P.CleanTemplateName(text)
                if not name then return end
                local function Save()
                    P.SaveTemplate(name)
                    ns.Print(L.TPL_SAVED:format(name, class))
                end
                if P.HasTemplate(name) then UI.Confirm(L.TPL_REPLACE_CONFIRM:format(name), Save) else Save() end
            end)
        elseif choice.op == "load" then
            UI.Confirm(L.TPL_LOAD_CONFIRM:format(choice.name, spec), function()
                if P.LoadTemplate(choice.name) then
                    ns.Print(L.TPL_LOADED:format(choice.name) .. " " .. L.UNDO_HINT)
                end
            end)
        elseif choice.op == "spec" then
            UI.Confirm(L.SPEC_COPY_CONFIRM:format(choice.name, spec), function()
                if P.CopyFromSpec(choice.key) then
                    ns.Print(L.SPEC_COPIED:format(choice.name) .. " " .. L.UNDO_HINT)
                end
            end)
        elseif choice.op == "unknown" then
            UI.Confirm(L.UNKNOWN_CONFIRM:format(unknown, spec), function()
                if P.ActionsCombat() then return end
                P.Backup()
                local spots = ns.Actions.UnknownSpots(ns.cprof.actions)
                for _, s in ipairs(spots) do s.list[s.key] = nil end
                ns.Apply()
                ns.Print(L.UNKNOWN_REMOVED:format(#spots) .. " " .. L.UNDO_HINT)
            end)
        elseif choice.op == "delete" then
            UI.Confirm(L.TPL_DELETE_CONFIRM:format(choice.name), function()
                P.DeleteTemplate(choice.name)
                ns.Print(L.TPL_DELETED:format(choice.name))
            end)
        end
    end)
end

local function BuildDetail(page)
    detail = CreateFrame("Frame", nil, page)
    detail:SetPoint("TOPLEFT", LIST_W + 10, -ACTIONS_TOP)
    detail:SetPoint("BOTTOMRIGHT", 0, 0)
    local w = WIDTH - 16 - LIST_W - 10

    detail.tag = Tag(detail, 30)
    detail.tag:SetPoint("TOPLEFT", 10, -8)
    detail.title = UI.Text(detail, "GameFontNormalLarge")
    detail.title:SetPoint("LEFT", detail.tag, "RIGHT", 10, 0)
    detail.count = UI.Text(detail, "GameFontHighlight")
    detail.count:SetPoint("TOPRIGHT", -14, -16)
    -- (une couche de modificateur : ses cases vides remplies d'un coup avec
    -- les objets utiles des sacs)
    detail.fill = UI.Button(detail, L.QUICKFILL_BUTTON, 180, 22)
    detail.fill:SetPoint("RIGHT", detail.count, "LEFT", -12, 0)
    detail.fill:SetScript("OnClick", QuickFill)
    detail.fill:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText(L.QUICKFILL_BUTTON, 1, 0.82, 0, 1, true)
        GameTooltip:AddLine(L.QUICKFILL_DESC, 1, 1, 1, true)
        GameTooltip:Show()
    end)
    detail.fill:SetScript("OnLeave", function() GameTooltip:Hide() end)
    -- (une couche de combinaisons : copiée vers une autre, ou échangée)
    detail.ops = UI.Button(detail, L.LAYER_COPY_BUTTON, 150, 22)
    detail.ops:SetScript("OnClick", LayerOps)
    detail.ops:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
        GameTooltip:SetText(L.LAYER_COPY_BUTTON, 1, 0.82, 0, 1, true)
        GameTooltip:AddLine(L.LAYER_COPY_DESC, 1, 1, 1, true)
        GameTooltip:Show()
    end)
    detail.ops:SetScript("OnLeave", function() GameTooltip:Hide() end)
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
                    if not (selected.bar and ns.Bar.ShowsGameAction(selected.bar, i)) then return nil end
                    -- (le nom : celui de la liaison, sinon l'info-bulle de Forever)
                    return ns.Bar.GameActionName(i) or (ns.Hud and ns.Hud.GameName and ns.Hud.GameName(i))
                        or L.GAME_ACTION
                end,
                -- (son image : celle du bouton de Forever, comme sur le HUD)
                gameIcon = function()
                    if not (selected.bar and ns.Bar.ShowsGameAction(selected.bar, i)) then return nil end
                    if ns.Hud and ns.Hud.GamePicture then return ns.Hud.GamePicture(i) end
                end,
                disabledHint = function() return not FullLayer() and L.MENU_GAME_BAR_HINT or nil end,
                found = Found,
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

    -- Sous la croix : une case par bouton simple, dans cette couche
    detail.simpleRow = CreateFrame("Frame", nil, detail)
    detail.simpleRow:SetPoint("TOPLEFT", 0, -352)
    detail.simpleRow:SetSize(w, 130)
    local rowTitle = UI.Text(detail.simpleRow, "GameFontNormal", L.SECTION_SIMPLE)
    rowTitle:SetPoint("TOPLEFT", 10, 0)
    detail.simpleSlots = {}
    for k = 1, #ns.BUTTON_IDS + #ns.PAD_IDS do
        -- (la case se rafraîchit à sa création, avant que slot soit posé)
        local slot
        local function Sid() return slot and slot.sid end
        slot = UI.CreateActionSlot(detail.simpleRow, {
            get = function() return SimpleGet(Sid()) end,
            set = function(action) SimpleSet(Sid(), action) end,
            allowCommand = function() return SimpleCommandAllowed(Sid()) end,
            -- (vide dans une couche de modificateur : le bouton ne fait rien
            -- tant que la couche est tenue)
            found = Found,
            labelWidth = 62,
        })
        slot:SetPoint("CENTER", detail.simpleRow, "TOPLEFT", 44 + ((k - 1) % 8) * 66, -44 - math.floor((k - 1) / 8) * 70)
        slot.glyph = UI.CreateGlyph(slot, 20)
        slot.glyph:SetPoint("CENTER", slot, "TOPLEFT", 0, 0)
        slot.glyph:SetFrameLevel(slot:GetFrameLevel() + 5)
        detail.simpleSlots[k] = slot
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
            found = Found,
        })
        cell.slot:SetPoint("TOP", 0, -40)
        detail.simpleCells[k] = cell
    end

    -- Sous ses couches : la case du bouton simple dans chaque couche de
    -- modificateur, de ciblage ou de paire (les mêmes que la rangée
    -- « Boutons simples » de ces couches)
    detail.modRow = CreateFrame("Frame", nil, detail)
    detail.modRow:SetPoint("TOPLEFT", 0, -256)
    detail.modRow:SetSize(w, 150)
    local modTitle = UI.Text(detail.modRow, "GameFontNormal", L.SIMPLE_MOD_ROW)
    modTitle:SetPoint("TOPLEFT", 10, 0)
    detail.modSlots = {}
    for k = 1, 18 do
        local slot
        local function Mod() return slot and slot.mod end
        slot = UI.CreateActionSlot(detail.modRow, {
            get = function()
                return Mod() and selected.simple and ns.ButtonActions(Mod()).combos[selected.simple]
            end,
            set = function(action)
                if not (Mod() and selected.simple) then return end
                ns.ButtonActions(Mod()).combos[selected.simple] = action
                ns.Apply()
            end,
            found = Found,
            labelWidth = 58,
        })
        slot:SetPoint("CENTER", detail.modRow, "TOPLEFT", 40 + ((k - 1) % 9) * 62,
            -56 - math.floor((k - 1) / 9) * 86)
        slot.tag = Tag(slot, 18)
        slot.tag:SetPoint("BOTTOM", slot, "TOP", 0, 4)
        detail.modSlots[k] = slot
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
    detail.fill:SetShown(EmptyCrossSlots() > 0)
    detail.ops:SetShown(selected.mod ~= nil)
    detail.ops:ClearAllPoints()
    if detail.fill:IsShown() then
        detail.ops:SetPoint("RIGHT", detail.fill, "LEFT", -6, 0)
    else
        detail.ops:SetPoint("RIGHT", detail.count, "LEFT", -12, 0)
    end

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
    -- (bouton simple : sa case dans chaque couche de modificateur)
    local mods = {}
    if isSimple then
        local pad, extra = ns.ModLayerLists()
        for _, list in ipairs({ pad, extra }) do
            for _, id in ipairs(list) do mods[#mods + 1] = id end
        end
    end
    detail.modRow:SetShown(#mods > 0)
    for k, slot in ipairs(detail.modSlots) do
        slot.mod = mods[k]
        slot:SetShown(slot.mod ~= nil)
        if slot.mod then
            SetTag(slot.tag, LayerKeys({ mod = slot.mod }))
            slot:Refresh()
        end
    end

    -- (les cases des boutons simples : couche de modificateur, ou Seul / LT / RT)
    local simpleIDs = ns.SimpleIDs()
    local showSimple = not isSimple and #simpleIDs > 0
        and (selected.mod ~= nil or BAR_SIMPLE_LAYER[selected.bar] ~= nil)
    detail.simpleRow:SetShown(showSimple)
    for k, slot in ipairs(detail.simpleSlots) do
        slot.sid = showSimple and simpleIDs[k] or nil
        slot:SetShown(slot.sid ~= nil)
        if slot.sid then
            slot.glyph:SetKey(ns.PAD_KEY[slot.sid] or slot.sid)
            slot:Refresh()
        end
    end

    local warn
    if selected.bar and not ns.Bar.Available() then
        warn = L.BAR_UNAVAILABLE
    elseif ns.IsPending() then
        warn = L.APPLIED_AFTER_COMBAT
    elseif selected.mod and ns.IsClassActionPair(selected.mod) then
        warn = L.PAIR_CLASS_WARN_LONG:format(ns.ButtonLabel(selected.mod))
    end
    detail.warning:SetText(warn or "")
end

---------------------------------------------------------------------------
-- Onglet Boutons : la manette ; puis, dans une liste qui défile, une ligne
-- par bouton de la manette (nom, touche, mode ; les emplacements libres
-- seulement s'ils ont une touche), une ligne par bouton de base (LT, RT, LB,
-- RB : mode seulement), et l'état des paires
---------------------------------------------------------------------------
local rows, padRows, pairRows = {}, {}, {}
local buttonsWarning, controllerName, btnList, padTitle, extraTitle, pairsTitle, pairsHint
local ROW_STEP = 47
local LIST_WIDTH = WIDTH - 16 - 34
local PAIR_STEP = 28

-- Une ligne de paire : case à cocher, icônes des deux boutons, leurs noms
local function PairRow(i)
    local row = pairRows[i]
    if row then return row end
    row = CreateFrame("Frame", nil, btnList)
    row:SetSize(LIST_WIDTH - 4, PAIR_STEP - 2)
    local bg = row:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(1, 1, 1, 0.04)
    row.check = CreateFrame("CheckButton", nil, row, "UICheckButtonTemplate")
    row.check:SetSize(24, 24)
    row.check:SetPoint("LEFT", 6, 0)
    row.check:SetScript("OnClick", function(self)
        if row.pair then ns.SetPairEnabled(row.pair.id, self:GetChecked()) end
        RefreshAll()
    end)
    row.tag = Tag(row, 20)
    row.tag:SetPoint("LEFT", 36, 0)
    row.text = UI.Text(row, "GameFontHighlight")
    row.text:SetPoint("LEFT", 106, 0)
    row.text:SetPoint("RIGHT", -6, 0)
    row.text:SetJustifyH("LEFT")
    -- (LB + LT, RB + RT : l'avertissement en entier au survol)
    row:EnableMouse(true)
    row:SetScript("OnEnter", function(self)
        if not (self.pair and ns.IsClassActionPair(self.pair.id)) then return end
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(ns.ButtonLabel(self.pair.id), 1, 0.82, 0)
        GameTooltip:AddLine(L.PAIR_CLASS_WARN_LONG:format(ns.ButtonLabel(self.pair.id)), 1, 0.5, 0.13, true)
        GameTooltip:Show()
    end)
    row:SetScript("OnLeave", function() GameTooltip:Hide() end)
    pairRows[i] = row
    return row
end

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

-- Une ligne : fond, icône, et la ligne des modes (une case par mode, son
-- explication au survol). onPick(mode) quand on coche.
local function ModeRow(parent, modes, onPick)
    local row = CreateFrame("Frame", nil, parent)
    row:SetSize(LIST_WIDTH - 4, ROW_STEP - 4)
    local bg = row:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(1, 1, 1, 0.04)
    row.glyph = UI.CreateGlyph(row, 34)
    row.glyph:SetPoint("LEFT", 10, 0)
    local modeLabel = UI.Text(row, "GameFontNormal", L.MODE)
    modeLabel:SetPoint("TOPLEFT", 60, -27)
    row.modes = {}
    local x = modeLabel:GetStringWidth() + 10
    for _, mode in ipairs(modes) do
        local cb = CreateFrame("CheckButton", nil, row, "UICheckButtonTemplate")
        cb:SetSize(22, 22)
        cb:SetPoint("LEFT", modeLabel, "LEFT", x, 0)
        local text = UI.Text(cb, "GameFontHighlight", ModeLabel(mode))
        text:SetPoint("LEFT", cb, "RIGHT", 2, 0)
        cb.label = text
        cb:SetScript("OnClick", function()
            onPick(mode)
            RefreshAll()
        end)
        cb:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(ModeLabel(mode), 1, 0.82, 0, 1, true)
            GameTooltip:AddLine(ns.ModeDesc(mode), 1, 1, 1, true)
            if self.isDefault then GameTooltip:AddLine(L.MODE_IS_DEFAULT, 0.25, 1, 0.25, true) end
            GameTooltip:Show()
        end)
        cb:SetScript("OnLeave", function() GameTooltip:Hide() end)
        row.modes[mode] = cb
        x = x + 26 + text:GetStringWidth() + 12
    end
    return row
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
    UI.Tip(change, L.CONTROLLER_CHANGE, L.TIP_CONTROLLER)
    -- (l'explication des types de boutons : l'étape du tutoriel)
    local typesHelp = UI.Button(page, L.BUTTONS_TYPES_HELP, 190, 22)
    typesHelp:SetPoint("TOPRIGHT", -14, -38)
    typesHelp:SetScript("OnClick", function() ns.Tutorial.Open("types") end)
    UI.Tip(typesHelp, L.BUTTONS_TYPES_HELP, L.TIP_TYPES)
    -- (ce que WoW reçoit de chaque bouton : la vue de test, sans onglet)
    local test = UI.Button(page, L.TEST_OPEN, 170, 22)
    test:SetPoint("RIGHT", typesHelp, "LEFT", -6, 0)
    test:SetScript("OnClick", function() SelectTab("test") end)
    UI.Tip(test, L.TEST_OPEN, L.TIP_TEST)

    -- La liste qui défile
    local scroll = CreateFrame("ScrollFrame", nil, page, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 12, -64)
    scroll:SetPoint("BOTTOMRIGHT", -30, 28)
    btnList = CreateFrame("Frame", nil, scroll)
    btnList:SetSize(LIST_WIDTH, 10)
    scroll:SetScrollChild(btnList)

    -- Les boutons de la manette : nom, touche (Détecter / Effacer), mode
    for i, id in ipairs(ns.BUTTON_IDS) do
        local row = ModeRow(btnList, ns.MODES, function(mode)
            ns.Button(id).mode = mode
            ns.Apply()
        end)

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
        row.key:SetWidth(130)
        row.key:SetJustifyH("LEFT")
        row.key:SetWordWrap(false)

        -- (modificateur seulement : verrouillable, un appui active la
        -- couche et le suivant la quitte)
        local latch = CreateFrame("CheckButton", nil, row, "UICheckButtonTemplate")
        latch:SetSize(22, 22)
        latch:SetPoint("TOPLEFT", 378, -3)
        latch.label = UI.Text(latch, "GameFontHighlight", L.LATCH)
        latch.label:SetPoint("LEFT", latch, "RIGHT", 2, 0)
        latch.label:SetWidth(130)
        latch.label:SetJustifyH("LEFT")
        latch.label:SetWordWrap(false)
        latch:SetScript("OnClick", function(self)
            ns.Button(id).latch = self:GetChecked() and true or nil
            ns.Apply()
            RefreshAll()
        end)
        latch:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(L.LATCH, 1, 0.82, 0, 1, true)
            GameTooltip:AddLine(L.LATCH_DESC, 1, 1, 1, true)
            GameTooltip:Show()
        end)
        latch:SetScript("OnLeave", function() GameTooltip:Hide() end)
        row.latch = latch

        local detect = UI.Button(row, L.DETECT, 110, 22)
        detect:SetPoint("TOPRIGHT", -104, -4)
        detect:SetScript("OnClick", function() ns.Learn.Start(id, function() RefreshAll() end) end)
        UI.Tip(detect, L.DETECT, L.TIP_DETECT)
        local clear = UI.Button(row, L.CLEAR, 90, 22)
        clear:SetPoint("LEFT", detect, "RIGHT", 4, 0)
        clear:SetScript("OnClick", function()
            ns.Button(id).key = nil
            ns.Apply()
            RefreshAll()
        end)
        UI.Tip(clear, L.CLEAR, L.TIP_CLEAR)
        row.id = id
        rows[i] = row
    end

    -- Les boutons de base : leur nom et leur mode (leur touche est celle de
    -- la manette : ni détection ni effacement)
    padTitle = UI.Text(btnList, "GameFontNormal", L.PADS_LABEL)
    extraTitle = UI.Text(btnList, "GameFontNormal", L.TEST_EXTRA)
    for i, id in ipairs(ns.PAD_IDS) do
        local row = ModeRow(btnList, ns.PAD_MODES, function(mode) ns.SetPadMode(id, mode) end)
        row.glyph:SetKey(ns.PAD_KEY[id])
        row.name = UI.Text(row, "GameFontHighlightLarge", id)
        row.name:SetPoint("TOPLEFT", 64, -6)
        row.hint = UI.Text(row, "GameFontDisable", L.PAD_HINT)
        row.hint:SetPoint("LEFT", row.name, "RIGHT", 12, 0)
        -- (son mode par défaut, celui du jeu : en vert)
        local default = row.modes[ns.DEFAULT_PADS[id]]
        if default then
            default.isDefault = true
            default.label:SetTextColor(0.25, 1, 0.25)
        end
        row.id = id
        padRows[i] = row
    end

    -- Les paires : toutes celles de deux modificateurs, à cocher (lignes
    -- créées à la demande par RefreshButtons)
    pairsTitle = UI.Text(btnList, "GameFontNormal", L.PAIRS_TITLE)
    pairsHint = UI.Text(btnList, "GameFontDisable")
    pairsHint:SetWidth(LIST_WIDTH - 12)
    pairsHint:SetJustifyH("LEFT")

    -- (ce qui empêche un bouton ou une case de marcher, Check.lua)
    local check = UI.Button(page, L.CHECK_BUTTON, 210, 22)
    check:SetPoint("BOTTOMRIGHT", -14, 4)
    check:SetScript("OnClick", function() ns.Check.Show() end)
    UI.Tip(check, L.CHECK_BUTTON, L.TIP_CHECK)

    buttonsWarning = UI.Text(page, "GameFontNormalSmall")
    buttonsWarning:SetPoint("BOTTOMLEFT", 14, 10)
    buttonsWarning:SetPoint("RIGHT", check, "LEFT", -10, 0)
    buttonsWarning:SetJustifyH("LEFT")
end

local function RefreshButtons()
    controllerName:SetText(ns.ControllerName(ns.Controller()))
    local y = 0
    local visible = {}
    for _, id in ipairs(ns.VisibleIDs()) do visible[id] = true end

    -- Les boutons de base d'abord
    padTitle:ClearAllPoints()
    padTitle:SetPoint("TOPLEFT", 2, y - 6)
    y = y - 24
    for _, row in ipairs(padRows) do
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 0, y)
        y = y - ROW_STEP
        row.name:SetText(ns.ButtonLabel(row.id))
        local current = ns.PadMode(row.id)
        for mode, cb in pairs(row.modes) do cb:SetChecked(current == mode) end
    end

    -- Puis les boutons supplémentaires de la manette
    extraTitle:ClearAllPoints()
    extraTitle:SetPoint("TOPLEFT", 2, y - 6)
    y = y - 26
    for _, row in ipairs(rows) do
        local id, def = row.id, ns.Button(row.id)
        row:SetShown(visible[id] == true)
        if visible[id] then
            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", 0, y)
            y = y - ROW_STEP
            row.glyph:SetKey(id)
            if not row.name:HasFocus() then row.name:SetText(ns.ButtonLabel(id)) end
            row.key:SetText(def.key and ns.KeyLabel(def.key) or ("|cffff6060" .. L.KEY_NONE .. "|r"))
            for mode, cb in pairs(row.modes) do cb:SetChecked(def.mode == mode) end
            row.latch:SetShown(def.mode == "modifier")
            row.latch:SetChecked(def.latch == true)
        end
    end

    pairsTitle:ClearAllPoints()
    pairsTitle:SetPoint("TOPLEFT", 2, y - 6)
    y = y - 24
    -- (toutes les paires de deux modificateurs prêts : cochée = utilisée ;
    -- plus, grisées, celles d'un modificateur avec un bouton de base resté
    -- au jeu : cochables d'avance, actives quand il devient modificateur)
    local function Waiting(id)
        return ns.PAD_KEY[id] ~= nil and ns.PadMode(id) == "game"
    end
    local possible = {}
    for _, pair in ipairs(ns.ALL_PAIRS) do
        local a, b = ns.IsModLayer(pair.a), ns.IsModLayer(pair.b)
        if (a and b) or (a and Waiting(pair.b)) or (b and Waiting(pair.a)) then
            possible[#possible + 1] = pair
        end
    end
    pairsHint:SetText(#possible > 0 and L.PAIRS_HINT or L.PAIRS_NONE)
    pairsHint:ClearAllPoints()
    pairsHint:SetPoint("TOPLEFT", 6, y)
    y = y - pairsHint:GetStringHeight() - 8
    for i, pair in ipairs(possible) do
        local row = PairRow(i)
        row.pair = pair
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 0, y)
        row:Show()
        y = y - PAIR_STEP
        row.check:SetChecked(ns.PairEnabled(pair.id))
        SetTag(row.tag, { pair.a, pair.b })
        local label = ns.ButtonLabel(pair.id)
        if not ns.PairPossible(pair.id) then
            local wait = Waiting(pair.a) and pair.a or pair.b
            label = "|cff999999" .. label .. "  ·  " .. L.PAIR_WAITS:format(ns.ButtonLabel(wait)) .. "|r"
        elseif not ns.PairEnabled(pair.id) then
            label = "|cff999999" .. label .. "|r"
        end
        -- (LB + LT, RB + RT : Forever y met déjà son action de classe)
        if ns.IsClassActionPair(pair.id) then label = label .. "  |cffff8020(!) " .. L.PAIR_CLASS_WARN .. "|r" end
        row.text:SetText(label)
        row.text:SetWordWrap(false)
    end
    for i = #possible + 1, #pairRows do
        pairRows[i]:Hide()
        pairRows[i].pair = nil
    end
    btnList:SetHeight(-y + 8)

    local warn
    local targeting = ns.TargetingWarning()
    if ns.IsPending() then
        warn = "|cffff6060" .. L.APPLIED_AFTER_COMBAT .. "|r"
    elseif targeting then
        warn = "|cffff6060" .. targeting .. "|r"
    elseif IsLoaded("ImprovedForever") then
        warn = "|cffffd100" .. L.IF_WARNING .. "|r"
    end
    buttonsWarning:SetText(warn or "")
end

---------------------------------------------------------------------------
-- Onglet HUD
---------------------------------------------------------------------------
local hud = {}
-- (la liste d'ordre des miniatures : colonne de droite de l'onglet)
local ORDER_X, ORDER_W, ORDER_H, ORDER_ROW = 540, 236, 330, 28

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
    -- (la colonne de gauche s'arrête avant l'ordre des miniatures)
    local leftRight = WIDTH - 16 - (ORDER_X - 20)

    -- (une valeur en %, réglée avec une barre à curseur ; les barres des
    -- deux sections commencent à la même place, après le plus long libellé)
    local sliderX = 0
    for _, label in ipairs({ L.HUD_STRIP_SIZE, L.HUD_SIZE, L.HUD_IDLE_ALPHA }) do
        local probe = UI.Text(page, "GameFontNormal", label)
        sliderX = math.max(sliderX, probe:GetStringWidth())
        probe:Hide()
    end
    sliderX = 20 + sliderX + 18
    local function Percent(v) return ("%d %%"):format(math.floor(v * 100 + 0.5)) end
    local function SliderRow(y, label, set, tip, minValue, maxValue)
        local text = UI.Text(page, "GameFontNormal", label)
        text:SetPoint("TOPLEFT", 20, y)
        local slider = UI.Slider(page, 200, minValue, maxValue, 0.05, set, Percent)
        slider:SetPoint("LEFT", page, "TOPLEFT", sliderX, y - 7)
        UI.Tip(slider, label, tip)
        return slider
    end

    -- Les miniatures des couches : disposition, taille, lignes
    UI.Section(page, L.HUD_SECTION_STRIP, 16, -48, leftRight)
    local layoutLabel = UI.Text(page, "GameFontNormal", L.HUD_LAYOUT_LABEL)
    layoutLabel:SetPoint("TOPLEFT", 20, -82)
    hud.detached = Check(page, L.HUD_DETACH, function(on) ns.Hud.SetDetached(on) end)
    hud.detached:SetPoint("LEFT", layoutLabel, "LEFT", layoutLabel:GetStringWidth() + 14, 0)
    UI.Tip(hud.detached, L.HUD_DETACH, L.TIP_HUD_DETACH)
    hud.vertical = Check(page, L.HUD_VERTICAL, function(on) ns.Hud.SetVertical(on) end)
    hud.vertical:SetPoint("LEFT", hud.detached.text, "RIGHT", 20, 0)
    UI.Tip(hud.vertical, L.HUD_VERTICAL, L.TIP_HUD_VERTICAL)
    hud.hidden = Check(page, L.HUD_HIDE_STRIP, function(on) ns.Hud.SetStripHidden(on) end)
    hud.hidden:SetPoint("LEFT", hud.vertical.text, "RIGHT", 20, 0)
    UI.Tip(hud.hidden, L.HUD_HIDE_STRIP, L.TIP_HUD_HIDDEN)

    hud.stripSize = SliderRow(-118, L.HUD_STRIP_SIZE, ns.Hud.SetStripScale, L.TIP_HUD_STRIP_SIZE, 0.5, 1.5)
    local rowsLabel = UI.Text(page, "GameFontNormal", L.HUD_STRIP_ROWS)
    rowsLabel:SetPoint("TOPLEFT", 20, -154)
    hud.rowsLabel = rowsLabel
    hud.rows = {}
    local x = rowsLabel:GetStringWidth() + 14
    do
        -- (« Lignes » ou « Colonnes » : la place des cases suit le plus long)
        local probe = UI.Text(page, "GameFontNormal", L.HUD_STRIP_COLS)
        x = math.max(x, probe:GetStringWidth() + 14)
        probe:Hide()
    end
    for n = 1, 3 do
        local cb = Check(page, tostring(n), function() ns.Hud.SetStripRows(n) end)
        cb:SetPoint("LEFT", rowsLabel, "LEFT", x, 0)
        UI.Tip(cb, function() return hud.rowsLabel:GetText() end, L.TIP_HUD_ROWS)
        hud.rows[n] = cb
        x = x + 34 + cb.text:GetStringWidth() + 20
    end

    -- Le HUD : taille, opacité au repos, position
    UI.Section(page, L.HUD_SECTION_PLACE, 16, -200, leftRight)
    hud.size = SliderRow(-234, L.HUD_SIZE, ns.Hud.SetScale, L.TIP_HUD_SIZE, 0.5, 2)
    hud.idle = SliderRow(-268, L.HUD_IDLE_ALPHA, ns.Hud.SetIdleAlpha, L.TIP_HUD_IDLE_ALPHA, 0, 1)
    hud.move = UI.Button(page, L.HUD_MOVE, 220, 26)
    hud.move:SetPoint("TOPLEFT", 20, -302)
    hud.move:SetScript("OnClick", function()
        ns.Hud.SetUnlocked(not ns.Hud.IsUnlocked())
        RefreshAll()
    end)
    UI.Tip(hud.move, function() return hud.move:GetText() end, L.TIP_HUD_MOVE)
    local reset = UI.Button(page, L.HUD_RESET, 260, 26)
    reset:SetPoint("LEFT", hud.move, "RIGHT", 10, 0)
    reset:SetScript("OnClick", function() ns.Hud.ResetPosition() RefreshAll() end)
    UI.Tip(reset, L.HUD_RESET, L.TIP_HUD_RESET)
    hud.moveHint = UI.Text(page, "GameFontHighlightSmall", L.HUD_UNLOCKED)
    hud.moveHint:SetPoint("TOPLEFT", hud.move, "BOTTOMLEFT", 0, -6)
    hud.moveHint:SetPoint("RIGHT", page, "LEFT", ORDER_X - 20, 0)
    hud.moveHint:SetJustifyH("LEFT")
    hud.moveHint:SetTextColor(0.5, 0.85, 1)

    -- L'aide-mémoire : toutes les couches en grand (aussi /mgir carte, et une
    -- action de base à poser sur une case)
    local sheet = UI.Button(page, L.SHEET_BUTTON, 260, 26)
    sheet:SetPoint("BOTTOMLEFT", 20, 40)
    sheet:SetScript("OnClick", function() ns.Hud.ToggleSheet() end)
    UI.Tip(sheet, L.SHEET_BUTTON, L.TIP_SHEET)

    local tip = UI.Text(page, "GameFontDisableSmall", L.HUD_TILE_HINT .. "  -  " .. L.HUD_CARD_HINT)
    tip:SetPoint("BOTTOMLEFT", 16, 12)
    tip:SetPoint("RIGHT", page, "LEFT", ORDER_X - 20, 0)
    tip:SetJustifyH("LEFT")

    -- Ordre des miniatures (colonne de droite) : flèches, ou glisser sur le HUD
    local orderLabel = UI.Text(page, "GameFontNormal", L.HUD_ORDER)
    orderLabel:SetPoint("TOPLEFT", ORDER_X, -60)
    orderLabel:SetPoint("RIGHT", -16, 0)
    orderLabel:SetJustifyH("LEFT")
    local back = page:CreateTexture(nil, "BACKGROUND")
    back:SetColorTexture(1, 1, 1, 0.03)
    back:SetPoint("TOPLEFT", ORDER_X - 4, -80)
    back:SetPoint("BOTTOMRIGHT", page, "TOPLEFT", ORDER_X + ORDER_W + 26, -(80 + ORDER_H))
    local scroll = CreateFrame("ScrollFrame", nil, page, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", ORDER_X, -82)
    scroll:SetSize(ORDER_W, ORDER_H - 4)
    hud.orderChild = CreateFrame("Frame", nil, scroll)
    hud.orderChild:SetSize(ORDER_W, 10)
    scroll:SetScrollChild(hud.orderChild)
    hud.orderRows = {}

    hud.orderReset = UI.Button(page, L.HUD_ORDER_RESET, ORDER_W, 24)
    hud.orderReset:SetPoint("TOPLEFT", ORDER_X, -(88 + ORDER_H))
    hud.orderReset:SetScript("OnClick", function() ns.Hud.ResetOrder() RefreshAll() end)
    local orderHint = UI.Text(page, "GameFontHighlightSmall", L.HUD_ORDER_HINT)
    orderHint:SetPoint("TOPLEFT", hud.orderReset, "BOTTOMLEFT", 0, -6)
    orderHint:SetPoint("RIGHT", -16, 0)
    orderHint:SetJustifyH("LEFT")
    orderHint:SetTextColor(0.7, 0.7, 0.7)
end

-- Une ligne de la liste d'ordre : pastilles, nom, flèches haut / bas
local function ArrowButton(parent, dir)
    local b = CreateFrame("Button", nil, parent)
    b:SetSize(24, 24)
    local base = "Interface\\ChatFrame\\UI-ChatIcon-Scroll" .. dir
    b:SetNormalTexture(base .. "-Up")
    b:SetPushedTexture(base .. "-Down")
    b:SetDisabledTexture(base .. "-Disabled")
    b:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    return b
end

local function OrderRow(i)
    local r = hud.orderRows[i]
    if r then return r end
    r = CreateFrame("Frame", nil, hud.orderChild)
    r:SetSize(ORDER_W - 4, ORDER_ROW - 2)
    local bg = r:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(1, 1, 1, 0.05)
    r.num = UI.Text(r, "GameFontDisableSmall")
    r.num:SetPoint("LEFT", 4, 0)
    r.num:SetWidth(16)
    r.tag = Tag(r, 20)
    r.tag:SetPoint("LEFT", 22, 0)
    r.name = UI.Text(r, "GameFontHighlight")
    r.name:SetPoint("LEFT", 80, 0)
    r.name:SetPoint("RIGHT", -54, 0)
    r.name:SetJustifyH("LEFT")
    r.name:SetWordWrap(false)
    r.down = ArrowButton(r, "Down")
    r.down:SetPoint("RIGHT", -2, 0)
    r.up = ArrowButton(r, "Up")
    r.up:SetPoint("RIGHT", r.down, "LEFT", -2, 0)
    r.up:SetScript("OnClick", function(self) ns.Hud.MoveLayer(self:GetParent().key, -1) RefreshAll() end)
    r.down:SetScript("OnClick", function(self) ns.Hud.MoveLayer(self:GetParent().key, 1) RefreshAll() end)
    hud.orderRows[i] = r
    return r
end

local function RefreshOrder()
    local layers = ns.Hud.Layers()
    for i, layer in ipairs(layers) do
        local r = OrderRow(i)
        r.key = ns.Hud.LayerKey(layer)
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", 2, -(i - 1) * ORDER_ROW)
        r.num:SetText(i)
        SetTag(r.tag, LayerKeys(layer))
        r.name:SetText(LayerName(layer))
        r.up:SetEnabled(i > 1)
        r.down:SetEnabled(i < #layers)
        r:Show()
    end
    for i = #layers + 1, #hud.orderRows do hud.orderRows[i]:Hide() end
    hud.orderChild:SetHeight(math.max(10, #layers * ORDER_ROW))
    hud.orderReset:SetEnabled(ns.Hud.HasCustomOrder())
end

local function RefreshHudPage()
    local detached, vertical = ns.Hud.Detached(), ns.Hud.Vertical()
    hud.detached:SetChecked(detached)
    hud.vertical:SetChecked(vertical)
    -- (cachées : séparées / en colonne sans objet)
    local hidden = ns.Hud.StripHidden()
    hud.hidden:SetChecked(hidden)
    for _, cb in ipairs({ hud.detached, hud.vertical }) do
        cb:SetEnabled(not hidden)
        cb:SetAlpha(hidden and 0.4 or 1)
    end
    hud.rowsLabel:SetText(vertical and L.HUD_STRIP_COLS or L.HUD_STRIP_ROWS)
    -- (sans rappeler le réglage : seulement le curseur et sa valeur)
    hud.idle:SetValueQuiet(ns.Hud.IdleAlpha())
    hud.size:SetValueQuiet(ns.Hud.Scale())
    hud.stripSize:SetValueQuiet(ns.Hud.StripScale())
    local rows = ns.Hud.StripRows()
    for n, cb in pairs(hud.rows) do cb:SetChecked(n == rows) end
    local unlocked = ns.Hud.IsUnlocked()
    hud.move:SetText(unlocked and L.HUD_MOVE_DONE or L.HUD_MOVE)
    hud.moveHint:SetShown(unlocked)
    RefreshOrder()
end

---------------------------------------------------------------------------
-- Onglet Options : les réglages généraux (ni bouton, ni couche, ni HUD)
---------------------------------------------------------------------------
local opt = {}

local function BuildOptionsPage(page)
    local intro = UI.Text(page, "GameFontHighlight", L.OPTIONS_INTRO)
    intro:SetPoint("TOPLEFT", 16, -10)
    intro:SetPoint("RIGHT", -16, 0)
    intro:SetJustifyH("LEFT")

    -- Confort : nouveaux rangs de sorts, vibrations
    UI.Section(page, L.COMFORT_TITLE, 16, -48)
    opt.uprank = Check(page, L.UPRANK_AUTO, function(on) ns.Uprank.SetAuto(on) end)
    opt.uprank:SetPoint("TOPLEFT", 16, -80)
    opt.uprank.text:SetPoint("RIGHT", page, "RIGHT", -16, 0)
    opt.uprank.text:SetJustifyH("LEFT")
    UI.Tip(opt.uprank, L.UPRANK_AUTO, L.TIP_UPRANK)
    -- (vibrations : seulement si le jeu sait faire vibrer la manette)
    opt.vibration = Check(page, L.VIBRATION_OPTION, function(on)
        ns.Rumble.SetEnabled(on)
        if on then ns.Rumble.Play("on") end
    end)
    opt.vibration:SetPoint("TOPLEFT", opt.uprank, "BOTTOMLEFT", 0, -10)
    opt.vibration.text:SetPoint("RIGHT", page, "RIGHT", -16, 0)
    opt.vibration.text:SetJustifyH("LEFT")
    UI.Tip(opt.vibration, L.VIBRATION_OPTION, L.TIP_VIBRATION)

    -- Interface : le bouton de la minimap
    UI.Section(page, L.OPTIONS_SECTION_UI, 16, -170)
    opt.minimap = Check(page, L.MINIMAP_SHOW, function(on) ns.MinimapButton.SetShown(on) end)
    opt.minimap:SetPoint("TOPLEFT", 16, -202)
    UI.Tip(opt.minimap, L.MINIMAP_SHOW, L.TIP_MINIMAP)
end

local function RefreshOptionsPage()
    opt.uprank:SetChecked(ns.Uprank.Auto())
    opt.vibration:SetShown(ns.Rumble.Available())
    opt.vibration:SetChecked(ns.Rumble.Enabled())
    opt.minimap:SetChecked(ns.MinimapButton.IsShown())
end

---------------------------------------------------------------------------
-- Aide : les textes du tutoriel (une seule source à traduire)
---------------------------------------------------------------------------
-- Onglet Aide : un sommaire à gauche (les sections du tutoriel, puis les
-- commandes), la section choisie à droite ; le texte dépend de la manette
local HELP_LIST_W = 210
local helpSection = 1

local function BuildHelp(page)
    local intro = UI.Text(page, "GameFontHighlight", L.HELP_INTRO)
    intro:SetPoint("TOPLEFT", 12, -10)
    intro:SetPoint("RIGHT", -440, 0)
    intro:SetJustifyH("LEFT")
    local replay = UI.Button(page, L.HELP_REPLAY, 200, 24)
    replay:SetPoint("TOPRIGHT", -12, -6)
    replay:SetScript("OnClick", function() ns.Tutorial.Open(1) end)
    -- (un bouton ou une case qui ne marche pas : la vérification le dit)
    local check = UI.Button(page, L.CHECK_BUTTON, 210, 24)
    check:SetPoint("RIGHT", replay, "LEFT", -6, 0)
    check:SetScript("OnClick", function() ns.Check.Show() end)
    UI.Tip(check, L.CHECK_BUTTON, L.TIP_CHECK)

    local scroll = CreateFrame("ScrollFrame", nil, page, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", HELP_LIST_W + 24, -44)
    scroll:SetPoint("BOTTOMRIGHT", -32, 8)
    local child = CreateFrame("Frame", nil, scroll)
    child:SetSize(WIDTH - HELP_LIST_W - 90, 10)
    scroll:SetScrollChild(child)
    local title = UI.Text(child, "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 4, -4)
    local text = UI.Text(child, "GameFontHighlight")
    text:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
    text:SetWidth(WIDTH - HELP_LIST_W - 100)
    text:SetJustifyH("LEFT")
    text:SetSpacing(3)
    Separator(page, HELP_LIST_W + 14, -44, HELP_LIST_W + 15, -(HEIGHT - 76))

    local buttons = {}
    local function Show()
        local sections = ns.Tutorial.HelpSections()
        helpSection = math.max(1, math.min(helpSection, #sections))
        for i, b in ipairs(buttons) do
            local sec = sections[i]
            b:SetShown(sec ~= nil)
            if sec then
                b:SetText(sec.title)
                if i == helpSection then b:LockHighlight() else b:UnlockHighlight() end
            end
        end
        local sec = sections[helpSection]
        title:SetText(sec and sec.title or "")
        text:SetText(sec and sec.text or "")
        child:SetHeight(title:GetStringHeight() + text:GetStringHeight() + 30)
        scroll:SetVerticalScroll(0)
    end
    for i = 1, 14 do
        local b = UI.Button(page, "", HELP_LIST_W, 24)
        b:SetPoint("TOPLEFT", 12, -44 - (i - 1) * 28)
        local fs = b:GetFontString()
        if fs then
            fs:SetWidth(HELP_LIST_W - 12)
            fs:SetWordWrap(false)
        end
        b:SetScript("OnClick", function()
            helpSection = i
            Show()
        end)
        buttons[i] = b
    end
    -- (le texte dépend de la manette choisie)
    page:SetScript("OnShow", Show)
    Show()
end

---------------------------------------------------------------------------
-- Fenêtre
---------------------------------------------------------------------------
-- (de gauche à droite : l'ordre dans lequel on configure ; « test », sans
-- onglet, s'ouvre depuis Boutons, dont l'onglet reste allumé)
local TAB_ORDER = { "buttons", "actions", "hud", "options", "profiles", "help", "donate" }
local PAGE_KEYS = { "buttons", "actions", "hud", "options", "profiles", "help", "donate", "test" }
local TAB_OF = { test = "buttons" }
local TAB_GAP = 4
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
    elseif currentTab == "options" then
        RefreshOptionsPage()
    elseif currentTab == "test" and pages.test.RefreshExtra then
        pages.test.RefreshExtra()
    end
end

local function SelectTab(name)
    -- (anciens noms d'onglets)
    if not pages[name] then name = "actions" end
    currentTab = name
    -- (retenu pour la prochaine ouverture ; pas le test, ouvert de passage)
    if ns.db and name ~= "test" then ns.db.options.tab = name end
    for key, page in pairs(pages) do page:SetShown(key == name) end
    local lit = TAB_OF[name] or name
    for key, tab in pairs(tabs) do
        if key == lit then tab:LockHighlight() else tab:UnlockHighlight() end
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
        hud = L.TAB_HUD, options = L.TAB_OPTIONS, help = L.TAB_HELP, donate = L.TAB_DONATE }
    local prev
    for _, key in ipairs(TAB_ORDER) do
        local tab = UI.Button(f, labels[key], 100, 24)
        if prev then tab:SetPoint("LEFT", prev, "RIGHT", TAB_GAP, 0) else tab:SetPoint("TOPLEFT", 14, -30) end
        tab:SetScript("OnClick", function() SelectTab(key) end)
        tabs[key] = tab
        prev = tab
    end
    for _, key in ipairs(PAGE_KEYS) do
        local page = CreateFrame("Frame", nil, f)
        page:SetPoint("TOPLEFT", 8, -60)
        page:SetPoint("BOTTOMRIGHT", -8, 8)
        page:Hide()
        pages[key] = page
    end
    -- (chaque onglet à la largeur de son texte, la place restante partagée :
    -- les noms longs de certaines langues tiennent)
    local natural, total = {}, 0
    for _, key in ipairs(TAB_ORDER) do
        local fs = tabs[key]:GetFontString()
        natural[key] = (fs and fs:GetStringWidth() or 80) + 16
        total = total + natural[key]
    end
    local extra = (WIDTH - 28 - (#TAB_ORDER - 1) * TAB_GAP - total) / #TAB_ORDER
    for _, key in ipairs(TAB_ORDER) do
        tabs[key]:SetWidth(math.floor(natural[key] + extra))
    end

    -- Couches : une phrase d'accueil ; dessous, la liste à gauche, la couche
    -- à droite
    local actionsIntro = UI.Text(pages.actions, "GameFontHighlight", L.ACTIONS_INTRO)
    actionsIntro:SetPoint("TOPLEFT", 12, -6)
    actionsIntro:SetPoint("RIGHT", -12, 0)
    actionsIntro:SetJustifyH("LEFT")
    list = CreateFrame("Frame", nil, pages.actions)
    list:SetPoint("TOPLEFT", 0, -ACTIONS_TOP)
    list:SetPoint("BOTTOMLEFT", 0, 0)
    list:SetWidth(LIST_W)
    -- (au-dessus de la liste : « Où est ce sort ? », la recherche d'une action)
    local okSearch, search = pcall(CreateFrame, "EditBox", nil, list, "SearchBoxTemplate")
    if not (okSearch and search) then search = CreateFrame("EditBox", nil, list, "InputBoxTemplate") end
    search:SetSize(LIST_W - 24, 20)
    search:SetPoint("TOPLEFT", 14, -6)
    search:SetAutoFocus(false)
    search:SetMaxLetters(40)
    if search.Instructions then search.Instructions:SetText(L.SEARCH_HINT) end
    search:HookScript("OnTextChanged", function(self)
        local text = strtrim(self:GetText() or ""):lower()
        if text == searchText then return end
        searchText = text
        RefreshAll()
    end)
    search:SetScript("OnEscapePressed", function(self)
        self:SetText("")
        self:ClearFocus()
    end)
    search:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    search:HookScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(L.SEARCH_HINT, 1, 0.82, 0)
        GameTooltip:AddLine(L.SEARCH_DESC, 1, 1, 1, true)
        GameTooltip:Show()
    end)
    search:HookScript("OnLeave", function() GameTooltip:Hide() end)
    -- (sous la liste : modèles de classe et copie depuis une autre spé)
    local templates = UI.Button(list, L.TPL_BUTTON, LIST_W - 16, 22)
    templates:SetPoint("BOTTOM", 0, 6)
    templates:SetScript("OnClick", TemplatesMenu)
    templates:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(L.TPL_BUTTON, 1, 0.82, 0, 1, true)
        GameTooltip:AddLine(L.TPL_DESC, 1, 1, 1, true)
        GameTooltip:Show()
    end)
    templates:SetScript("OnLeave", function() GameTooltip:Hide() end)
    Separator(pages.actions, LIST_W + 2, -ACTIONS_TOP - 4, LIST_W + 3, -(HEIGHT - 76))
    BuildDetail(pages.actions)

    BuildButtons(pages.buttons)
    UI.BuildProfilesPage(pages.profiles)
    BuildHudPage(pages.hud)
    BuildOptionsPage(pages.options)
    UI.BuildTestPage(pages.test)
    local back = UI.Button(pages.test, L.TEST_BACK, 180, 22)
    back:SetPoint("TOPRIGHT", -16, -8)
    back:SetScript("OnClick", function() SelectTab("buttons") end)
    BuildHelp(pages.help)
    UI.BuildDonatePage(pages.donate)

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
    if not frame then
        currentTab = ns.db.options.tab or "buttons"
        Build()
    end
    frame:Show()
    SelectTab(tab or currentTab)
end

-- Ouvre l'onglet Couches sur la couche d'un bouton, d'une paire ou de
-- « Seul » (« BASE ») : pour « Y aller » de la vérification (Check.lua)
function UI.ShowLayer(id)
    if id == "BASE" then
        selected = { bar = "topBar" }
    elseif ns.IsModLayer(id) then
        selected = { mod = id }
    else
        selected = { simple = id }
    end
    UI.Show("actions")
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
    local function CloseSettings()
        if SettingsPanel and SettingsPanel:IsShown() and HideUIPanel then HideUIPanel(SettingsPanel) end
    end
    local open = UI.Button(panel, L.OPEN_CONFIG, 220, 26)
    open:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -16)
    open:SetScript("OnClick", function()
        CloseSettings()
        UI.Show()
    end)
    local replay = UI.Button(panel, L.HELP_REPLAY, 220, 26)
    replay:SetPoint("LEFT", open, "RIGHT", 12, 0)
    replay:SetScript("OnClick", function()
        CloseSettings()
        ns.Tutorial.Open(1)
    end)
    -- Les types de boutons, expliqués (les textes du tutoriel)
    local typesTitle = UI.Text(panel, "GameFontNormalLarge", L.TUTO_TYPES_TITLE)
    typesTitle:SetPoint("TOPLEFT", open, "BOTTOMLEFT", 0, -24)
    local types = UI.Text(panel, "GameFontHighlight")
    types:SetPoint("TOPLEFT", typesTitle, "BOTTOMLEFT", 0, -10)
    types:SetPoint("RIGHT", -16, 0)
    types:SetJustifyH("LEFT")
    types:SetSpacing(2)
    local pairsTitle_ = UI.Text(panel, "GameFontNormalLarge", L.TUTO_PAIRS_TITLE)
    pairsTitle_:SetPoint("TOPLEFT", types, "BOTTOMLEFT", 0, -18)
    local pairsText = UI.Text(panel, "GameFontHighlight", L.TUTO_PAIRS_TEXT)
    pairsText:SetPoint("TOPLEFT", pairsTitle_, "BOTTOMLEFT", 0, -10)
    pairsText:SetPoint("RIGHT", -16, 0)
    pairsText:SetJustifyH("LEFT")
    panel:SetScript("OnShow", function()
        types:SetText(ns.Tutorial.TypesText())
        pairsText:SetText(L.TUTO_PAIRS_TEXT .. "\n\n" .. ns.Tutorial.ClassPairNote())
    end)
    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
        Settings.RegisterAddOnCategory(category)
    elseif InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(panel)
    end
end
