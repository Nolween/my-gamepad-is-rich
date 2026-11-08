-- HUD manette : remplace l'affichage de la barre croisée de Forever.
--
-- Étape 1 (affichage) : la barre de Forever (Blizzard_GamepadActionBars)
-- reste le moteur de ses couches (seul, LT, RT, LT+RT) et de ses actions du
-- jeu (sauter, interagir...). Elle est dessinée à alpha 0 par une animation
-- à nous : jamais une propriété de ses cadres (SetAlpha, Hide...), qui les
-- « teinterait » et casserait son code sécurisé (leçon d'Improved Forever).
-- Des caches à nous prennent la souris que ses boutons invisibles auraient
-- encore.
--
-- Le HUD reflète sa barre active (qu'elle change elle-même avec LT / RT, en
-- véhicule...) et y ajoute nos boutons : les combinaisons d'un modificateur
-- tant qu'on le maintient, et les boutons simples au
-- centre, avec l'action qui partira selon la gâchette tenue.
-- Hybride : la couche active en grand, toutes les couches en miniature.
--
-- Attribution rapide (hors combat) : clic sur une case = menu (sort, objet,
-- macro...) ou dépôt de ce que tient le curseur ; clic droit = vider. Clic
-- sur une miniature = cette couche en grand, pour la modifier. Une case de
-- la barre de Forever s'écrit dans son emplacement (comme son éditeur).
local _, ns = ...
local L = ns.L
local UI = ns.UI

local H = {}
ns.Hud = H

local function Secret(v)
    return type(issecretvalue) == "function" and issecretvalue(v)
end

---------------------------------------------------------------------------
-- Dimensions et ordres
---------------------------------------------------------------------------
local TILE = 48            -- (une case de la couche active)
local STEP = TILE + 6      -- (d'une case à sa voisine dans un groupe)
local CLUSTER = STEP * 2 + TILE
local GLYPH = 26           -- (le bouton de la manette sur une case)
local CENTER_W = 230
local MAIN_W = CLUSTER * 2 + CENTER_W + 32
local MAIN_H = CLUSTER + 18
local MINI, MINI_STEP = 18, 20
local CROSS = MINI_STEP * 2 + MINI
-- (une miniature : la croix, une colonne pour les boutons simples (3 par
-- colonne) si il y en a, A/B/X/Y ; sa largeur suit le nombre de boutons
-- simples, recalculée par Relayout)
local SIMPLE_PER_COL = 3
local CARD_W, CARD_H = CROSS * 2 + 8 + 12, CROSS + 32
local cardW = CARD_W

local function CardWidth(nSimple)
    if nSimple == 0 then return CARD_W end
    return CROSS * 2 + 12 + math.ceil(nSimple / SIMPLE_PER_COL) * MINI_STEP + 16
end
local STRIP_GAP = 6
local HEIGHT = MAIN_H + 14 + CARD_H
local PADDLE = 44
local IDLE_ALPHA = 0.8
-- Le HUD est dessiné au-dessus des caches posés sur la barre de Forever
-- (même strate qu'elle au minimum, niveau plus haut)
local HUD_LEVEL, COVER_MAX_LEVEL = 400, 380
local STRATA_ORDER = { BACKGROUND = 1, LOW = 2, MEDIUM = 3, HIGH = 4, DIALOG = 5 }

-- L'ordre des boutons dans un groupe de Forever : gauche, haut, droite, bas
local SPOTS = { { -1, 0 }, { 0, 1 }, { 1, 0 }, { 0, -1 } }
local DPAD_KEYS = { "PADDLEFT", "PADDUP", "PADDRIGHT", "PADDDOWN" }
local FACE_KEYS = { "PAD3", "PAD4", "PAD2", "PAD1" }
-- Les barres de Forever : rien, LT, RT, LT + RT (place dans sa page : 0-3)
local BARS = { "topBar", "leftBar", "rightBar", "bottomBar" }
local BAR_INDEX = { topBar = 0, leftBar = 1, rightBar = 2, bottomBar = 3 }
local BAR_KEYS = {
    topBar = {}, leftBar = { "PADLTRIGGER" }, rightBar = { "PADRTRIGGER" },
    bottomBar = { "PADLTRIGGER", "PADRTRIGGER" },
}
local LAYERS = { "base", "lt", "rt" }
local DIM_EDGE = { 0.38, 0.33, 0.24, 0.95 }
local GOLD_EDGE = { 1, 0.78, 0.2, 1 }
local EDIT_EDGE = { 0.3, 0.8, 1, 1 }

function H.Settings()
    ns.db.hud = ns.db.hud or {}
    local s = ns.db.hud
    if s.enabled == nil then s.enabled = true end
    s.scale = s.scale or 1
    -- (la bande des miniatures : sous la couche active, ou au-dessus)
    if s.strip ~= "top" then s.strip = "bottom" end
    -- (taille des miniatures, et nombre de lignes sur lesquelles les répartir)
    s.stripScale = s.stripScale or 1
    s.stripRows = s.stripRows or 1
    -- (l'ordre des miniatures : nil = celui de l'interface)
    if s.order ~= nil and type(s.order) ~= "table" then s.order = nil end
    return s
end

---------------------------------------------------------------------------
-- L'ordre des miniatures, choisi par le joueur : s.order, une liste de clés
-- (« bar:topBar », « mod:L5 », « mod:L5R5 »). Sans ordre choisi : celui de
-- l'interface. Une couche qui n'y est pas encore (modificateur ajouté...) se
-- place après sa voisine dans l'ordre de l'interface ; une couche qui
-- disparaît (bouton désactivé) garde sa place dans la liste pour son retour.
---------------------------------------------------------------------------
local ORDER_MAX = 80

local function LayerKey(e)
    if e.bar then return "bar:" .. e.bar end
    return "mod:" .. tostring(e.mod)
end
H.LayerKey = LayerKey

local function ValidKey(k)
    if type(k) ~= "string" then return false end
    local kind, id = k:match("^(%a+):(%w+)$")
    if kind == "bar" then return BAR_INDEX[id] ~= nil end
    if kind == "mod" then
        for _, m in ipairs(ns.MOD_ORDER) do if m == id then return true end end
        return ns.IsPair(id)
    end
    return false
end

-- primary dans son ordre, puis chaque clé de secondary absente, posée juste
-- après celle qui la précède dans secondary (au début s'il n'y en a pas)
local function MergeKeys(primary, secondary)
    local out, seen = {}, {}
    for _, k in ipairs(primary) do
        if not seen[k] then
            out[#out + 1] = k
            seen[k] = true
        end
    end
    local prev
    for _, k in ipairs(secondary) do
        if not seen[k] then
            local pos = 1
            if prev then
                for i, x in ipairs(out) do
                    if x == prev then pos = i + 1 break end
                end
            end
            table.insert(out, pos, k)
            seen[k] = true
        end
        prev = k
    end
    return out
end

-- Les couches dans l'ordre de l'interface : les barres du jeu (sauf celles
-- remplacées par les couches de l'addon), les couches des boutons de base
-- donnés à l'addon et leurs paires, puis les modificateurs et autres paires
local function DefaultLayers()
    local list = {}
    for _, name in ipairs(BARS) do
        if not ns.GameBarReplaced(name) then list[#list + 1] = { bar = name } end
    end
    local padLayers, extraLayers = ns.ModLayerLists()
    for _, ids in ipairs({ padLayers, extraLayers }) do
        for _, id in ipairs(ids) do list[#list + 1] = { mod = id } end
    end
    return list
end

-- Les couches du HUD, dans l'ordre choisi
function H.Layers()
    local list = DefaultLayers()
    local order = H.Settings().order
    if not order then return list end
    local byKey, defaults, present = {}, {}, {}
    for _, e in ipairs(list) do
        local k = LayerKey(e)
        byKey[k] = e
        defaults[#defaults + 1] = k
    end
    for _, k in ipairs(order) do
        if byKey[k] then present[#present + 1] = k end
    end
    local out = {}
    for _, k in ipairs(MergeKeys(present, defaults)) do out[#out + 1] = byKey[k] end
    return out
end

-- (keys : les couches présentes, dans leur nouvel ordre)
local function SaveOrder(keys)
    local s = H.Settings()
    local order = MergeKeys(keys, s.order or {})
    while #order > ORDER_MAX do table.remove(order) end
    s.order = order
end

function H.HasCustomOrder()
    return H.Settings().order ~= nil
end

function H.ResetOrder()
    H.Settings().order = nil
    H.Changed()
end

-- Déplace une couche de delta places (-1 : vers la gauche / le haut)
function H.MoveLayer(key, delta)
    local keys = {}
    for _, e in ipairs(H.Layers()) do keys[#keys + 1] = LayerKey(e) end
    local from
    for i, k in ipairs(keys) do if k == key then from = i end end
    local to = from and from + delta
    if not to or to < 1 or to > #keys then return end
    keys[from], keys[to] = keys[to], keys[from]
    SaveOrder(keys)
    H.Changed()
end

-- Pose une couche à la place d'une autre (glisser-déposer sur le HUD)
function H.MoveLayerTo(key, targetKey)
    if key == targetKey then return end
    local keys = {}
    for _, e in ipairs(H.Layers()) do keys[#keys + 1] = LayerKey(e) end
    local from, to
    for i, k in ipairs(keys) do
        if k == key then from = i end
        if k == targetKey then to = i end
    end
    if not (from and to) then return end
    table.remove(keys, from)
    table.insert(keys, to, key)
    SaveOrder(keys)
    H.Changed()
end

-- La hauteur réelle de la bande (lignes et taille comprises), posée par Relayout
local stripSpace = CARD_H

-- La hauteur sous la couche active : la bande, quand elle est en bas
local function MainY()
    return H.Settings().strip == "bottom" and (stripSpace + 14) or 0
end

local function PageUnit()
    local main = _G.GamepadMainActionBarFrame
    return main and main.PageUnit
end

local function EditMode()
    local m = _G.EditModeManagerFrame
    return m and m.IsEditModeActive and m:IsEditModeActive() or false
end

---------------------------------------------------------------------------
-- La barre de Forever cachée (animation à nous) et couverte (souris)
---------------------------------------------------------------------------
local fader = CreateFrame("Frame")
local fades = {}

local function Fade(region, hide)
    if not (region and region.GetObjectType) then return end
    local group = fades[region]
    if not group then
        if not hide then return end
        local ok, g = pcall(function()
            local g = fader:CreateAnimationGroup()
            local a = g:CreateAnimation("Alpha")
            a:SetTarget(region)
            a:SetFromAlpha(0)
            a:SetToAlpha(0)
            a:SetDuration(3600)
            g:SetLooping("REPEAT")
            return g
        end)
        if not ok or not g then return end
        group = g
        fades[region] = group
    end
    if hide and not group:IsPlaying() then
        group:Play()
    elseif not hide and group:IsPlaying() then
        group:Stop()
    end
end

-- (ses rectangles sont secrets en combat : gardés tels que posés avant)
local covers = {}
local function Cover(native, on)
    if not native or InCombatLockdown() then return end
    local f = covers[native]
    if not f then
        if not on then return end
        f = CreateFrame("Frame", nil, UIParent)
        f:EnableMouse(true)
        f:Hide()
        covers[native] = f
    end
    if not (on and native.IsVisible and native:IsVisible()) then
        f:Hide()
        return
    end
    local l, b, w, h = native:GetRect()
    if Secret(l) or Secret(b) or Secret(w) or Secret(h) then return end
    if not (l and b and w and h) then
        f:Hide()
        return
    end
    local k = native:GetEffectiveScale() / UIParent:GetEffectiveScale()
    if Secret(k) then return end
    f:ClearAllPoints()
    f:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", l * k, b * k)
    f:SetSize(w * k, h * k)
    -- (au-dessus des boutons de Forever, mais sous le HUD : sinon, là où son
    -- ancienne barre passe sous le nôtre, les caches prendraient la souris
    -- de nos cases)
    f:SetFrameStrata(native:GetFrameStrata())
    f:SetFrameLevel(math.min(native:GetFrameLevel() + 20, COVER_MAX_LEVEL))
    f:Show()
end

local function NativeParts(pu)
    return { pu.TopCenteredAnchor, pu.LeftCenteredAnchor, pu.RightCenteredAnchor, pu.BottomCenteredAnchor,
        pu.PageTracker, pu.LeftShoulderBackground, pu.RightShoulderBackground, pu.LeftShoulderIcon,
        pu.RightShoulderIcon, pu.LeftShoulderHighlight, pu.RightShoulderHighlight, pu.LeftClassAction,
        pu.RightClassAction, pu.LeftInputPrompt, pu.RightInputPrompt }
end

local function NativeBars(pu)
    local bars = pu.actionBars or {}
    return { bars.topBar, bars.leftBar, bars.rightBar, bars.bottomBar, pu.LeftClassAction, pu.RightClassAction }
end

-- Le bouton de Forever d'une barre : i = 1-4 la croix, 5-8 X/Y/B/A
local function Native(bar, i)
    local side = bar and (i <= 4 and bar.Left or bar.Right)
    return side and side["ActionButton" .. ((i - 1) % 4 + 1)]
end

---------------------------------------------------------------------------
-- Lecture : image, recharge, compteur
---------------------------------------------------------------------------
-- L'image d'un bouton de Forever : has, texture, atlas, icône (sa teinte)
local function NativePicture(native)
    if not native then return false end
    local special = native.SpecialActionIcon
    if special and special.IsShown and special:IsShown() then
        local atlas = special.GetAtlas and special:GetAtlas()
        if Secret(atlas) or (type(atlas) == "string" and atlas ~= "") then return true, nil, atlas end
        local tex = special:GetTexture()
        if Secret(tex) or tex then return true, tex end
    end
    local icon = native.icon
    if icon and icon.IsShown and icon:IsShown() then
        local tex = icon:GetTexture()
        if Secret(tex) or tex then return true, tex, nil, icon end
    end
    return false
end

local function SlotCooldown(slot)
    if C_ActionBar and C_ActionBar.GetActionCooldown then
        local ok, info = pcall(C_ActionBar.GetActionCooldown, slot)
        if ok and type(info) == "table" then return info.startTime, info.duration end
    elseif GetActionCooldown then
        local ok, s, d = pcall(GetActionCooldown, slot)
        if ok then return s, d end
    end
end

local function SpellCooldown(id)
    if C_Spell and C_Spell.GetSpellCooldown then
        local ok, info = pcall(C_Spell.GetSpellCooldown, id)
        if ok and type(info) == "table" then return info.startTime, info.duration end
    elseif GetSpellCooldown then
        local ok, s, d = pcall(GetSpellCooldown, id)
        if ok then return s, d end
    end
end

-- La recharge en « objet de durée » (API récente) : se donne au voile de
-- recharge même quand le jeu la rend secrète (illisible pour un addon)
local function SpellCooldownDuration(id)
    if C_Spell and C_Spell.GetSpellCooldownDuration then
        local ok, d = pcall(C_Spell.GetSpellCooldownDuration, id)
        if ok then return d end
    end
end

local function SlotCooldownDuration(slot)
    if C_ActionBar and C_ActionBar.GetActionCooldownDuration then
        local ok, d = pcall(C_ActionBar.GetActionCooldownDuration, slot)
        if ok then return d end
    end
end

local function ItemCooldown(id)
    local get = (C_Item and C_Item.GetItemCooldown) or GetItemCooldown
    if not get then return end
    local ok, s, d = pcall(get, id)
    if ok then return s, d end
end

-- Le sort qu'une de nos actions lance (pour sa recharge) : le sort lui-même,
-- celui d'une macro du jeu, ou le premier « /cast » d'une macro écrite
local castCache = {}
local function SpellFromName(name)
    if not name or name == "" then return nil end
    if castCache[name] == nil then
        local _, _, id = ns.Actions.SpellInfo(name)
        castCache[name] = id or false
    end
    return castCache[name] or nil
end

local function ActionSpell(action)
    local k = action.kind
    if k == "spell" or k == "mount" then return action.id end
    if k == "macro" and GetMacroSpell and GetMacroIndexByName then
        local index = GetMacroIndexByName(action.name)
        if index and index > 0 then
            local ok, spell = pcall(GetMacroSpell, index)
            if ok and type(spell) == "number" then return spell end
            if ok and type(spell) == "string" then return SpellFromName(spell) end
        end
    elseif k == "macrotext" and type(action.text) == "string" then
        -- (« /cast [conditions] Nom » : le nom, sans conditions ni rang)
        local line = action.text:match("/cast%s+([^\n]+)") or action.text:match("/use%s+([^\n]+)")
        if line then
            local name = strtrim((line:gsub("%b[]", ""):gsub("%(.-%)", ""):match("^[^;]*") or ""))
            return SpellFromName(name)
        end
    end
end

local function ItemCount(id)
    local get = (C_Item and C_Item.GetItemCount) or GetItemCount
    if not get then return 0 end
    local ok, n = pcall(get, id)
    return (ok and type(n) == "number" and not Secret(n)) and n or 0
end

---------------------------------------------------------------------------
-- Écriture : une action sur une case (hors combat)
---------------------------------------------------------------------------
-- target = { native = barName, i = 1-8 } | { combo = id, key = "PAD1" }
--        | { layer = "base" | "lt" | "rt", id = id }
local function Assign(target, action)
    if InCombatLockdown() then
        ns.Print(L.HUD_COMBAT)
        return
    end
    if target.native then
        -- (la barre de Forever : Bar.lua, comme la fenêtre de configuration ;
        -- « Seul » prend aussi ce que la barre du jeu ne tient pas)
        local ok, err = ns.Bar.SetView(target.native, target.i, action)
        if not ok and err then ns.Print(err) end
    elseif target.combo then
        ns.ButtonActions(target.combo).combos[target.key] = action
        ns.Apply()
    elseif target.layer then
        local a = ns.ButtonActions(target.id)
        a.layers[target.layer] = action
        if target.layer ~= "base" and action and ns.Actions.IsCommand(a.layers.base) then
            ns.Print(L.COMMAND_LT_RT)
        end
        ns.Apply()
    end
end

-- (« Seul » prend tout ; les couches LT / RT du jeu, seulement ce que la
-- barre du jeu tient)
local function FullTarget(target)
    return not target.native or target.native == ns.Bar.BASE_BAR
end

local function CommandAllowed(target)
    if target.native then return FullTarget(target) end
    if target.layer then return ns.Simple.CommandAllowed(ns.ButtonActions(target.id), target.layer) end
    return true
end

-- Le clic sur une case : dépôt du curseur, menu, ou vider (clic droit)
local function TileClick(t, button)
    local target = t.target
    if not target then return end
    if InCombatLockdown() then
        ns.Print(L.HUD_COMBAT)
        return
    end
    if button == "RightButton" then
        Assign(target, nil)
        return
    end
    if GetCursorInfo() then
        local action, err = ns.Actions.FromCursor()
        ClearCursor()
        if action then Assign(target, action) elseif err then ns.Print(err) end
        return
    end
    local set = function(action) Assign(target, action) end
    local full = FullTarget(target)
    local items = {
        { text = L.MENU_PICKUP_HINT, title = true },
        { text = L.MENU_SPELL, func = function()
            UI.PickFromList(L.SPELL_TITLE, ns.Actions.SpellbookEntries(), set)
        end },
        { text = L.MENU_ITEM, func = function()
            UI.PickFromList(L.ITEM_TITLE, ns.Actions.ItemEntries(), set)
        end },
        -- (sauter, annuler, rechercher, attaque auto, interagir)
        { text = L.MENU_GAME, disabled = not full, func = function()
            UI.PickFromList(L.GAME_TITLE, ns.Actions.GameEntries(CommandAllowed(target)), set)
        end },
        { text = L.MENU_MACROTEXT, disabled = not full, func = function()
            UI.EditMacro(nil, function(text)
                set(text ~= "" and { kind = "macrotext", text = text } or nil)
            end)
        end },
        { text = L.MENU_COMMAND, disabled = not CommandAllowed(target), func = function()
            UI.PickFromList(L.COMMAND_TITLE, ns.Actions.Commands(), set)
        end },
        { text = L.MENU_CLEAR, func = function() set(nil) end },
    }
    -- (des choix grisés : pourquoi, et comment les avoir)
    if not full then items[#items + 1] = { text = L.MENU_GAME_BAR_HINT, title = true } end
    UI.ShowMenu(t, items)
end

---------------------------------------------------------------------------
-- Une case
---------------------------------------------------------------------------
local function SetEdge(t, c)
    t.edge:SetColorTexture(c[1], c[2], c[3], c[4])
end

local function SetPicture(t, tex, atlas)
    if atlas then
        if not pcall(t.icon.SetAtlas, t.icon, atlas) then t.icon:Hide() return end
        t.icon:Show()
    elseif tex then
        if not pcall(t.icon.SetTexture, t.icon, tex) then t.icon:Hide() return end
        t.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        t.icon:Show()
    else
        t.icon:Hide()
    end
end

local function ClearCooldown(t)
    if not t.cdStart then return end
    if t.cooldown.Clear then t.cooldown:Clear() else t.cooldown:SetCooldown(0, 0) end
    t.cdStart, t.cdDuration = nil, nil
end

-- (aucune : rien ; la recharge globale s'affiche, comme sur les barres du
-- jeu). Une recharge secrète ne se lit ni ne se compare : elle est donnée
-- telle quelle au voile (objet de durée si le jeu en fournit un, sinon les
-- valeurs brutes)
local function SetCooldown(t, start, duration, durObj)
    if Secret(start) or Secret(duration) then
        local cd = t.cooldown
        local ok = durObj and cd.SetCooldownFromDurationObject and pcall(cd.SetCooldownFromDurationObject, cd, durObj)
        if not ok then ok = pcall(cd.SetCooldown, cd, start, duration) end
        -- (marque « une recharge est posée », pour ClearCooldown)
        t.cdStart, t.cdDuration = ok and true or nil, nil
        return
    end
    if type(start) ~= "number" or type(duration) ~= "number" or start <= 0 or duration <= 0 then
        ClearCooldown(t)
        return
    end
    if t.cdStart ~= start or t.cdDuration ~= duration then
        t.cdStart, t.cdDuration = start, duration
        t.cooldown:SetCooldown(start, duration)
    end
end

local function Tooltip(self)
    local ok
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    local native, a = self.native, self.action
    if native and native.action then
        ok = pcall(GameTooltip.SetAction, GameTooltip, native.action)
    elseif a then
        if a.kind == "spell" or a.kind == "mount" then
            ok = pcall(GameTooltip.SetSpellByID, GameTooltip, a.id)
        elseif a.kind == "item" or a.kind == "toy" then
            ok = pcall(GameTooltip.SetItemByID, GameTooltip, a.id)
        end
        if not ok then
            GameTooltip:SetText(ns.Actions.Label(a) or "", 1, 1, 1)
            ok = true
        end
    end
    if not ok then GameTooltip:SetText(L.EMPTY, 0.7, 0.7, 0.7) end
    if self.target and not InCombatLockdown() then
        GameTooltip:AddLine(L.HUD_TILE_HINT, 1, 0.82, 0, true)
    end
    GameTooltip:Show()
end

local mouseFrames = {} -- (ce qui prend la souris : rendu au cadre quand on déplace le HUD)

local function Tile(parent, size)
    local t = CreateFrame("Frame", nil, parent)
    t:SetSize(size, size)
    t.edge = t:CreateTexture(nil, "BACKGROUND")
    t.edge:SetAllPoints()
    t.inner = t:CreateTexture(nil, "BORDER")
    t.inner:SetPoint("TOPLEFT", 2, -2)
    t.inner:SetPoint("BOTTOMRIGHT", -2, 2)
    t.inner:SetColorTexture(0.04, 0.04, 0.035, 0.9)
    t.icon = t:CreateTexture(nil, "ARTWORK")
    t.icon:SetPoint("TOPLEFT", 2, -2)
    t.icon:SetPoint("BOTTOMRIGHT", -2, 2)
    SetEdge(t, DIM_EDGE)
    t.cooldown = CreateFrame("Cooldown", nil, t, "CooldownFrameTemplate")
    t.cooldown:SetAllPoints(t.icon)
    if t.cooldown.SetDrawEdge then t.cooldown:SetDrawEdge(false) end
    t.top = CreateFrame("Frame", nil, t)
    t.top:SetAllPoints()
    t.top:SetFrameLevel(t.cooldown:GetFrameLevel() + 2)
    t.count = t.top:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
    t.count:SetPoint("BOTTOMRIGHT", -3, 3)
    t.hl = t:CreateTexture(nil, "HIGHLIGHT")
    t.hl:SetAllPoints(t.icon)
    t.hl:SetColorTexture(1, 1, 1, 0.15)
    t:EnableMouse(true)
    t:SetScript("OnEnter", Tooltip)
    t:SetScript("OnLeave", function() GameTooltip:Hide() end)
    t:SetScript("OnMouseUp", TileClick)
    t:SetScript("OnReceiveDrag", function(self) TileClick(self, "LeftButton") end)
    mouseFrames[#mouseFrames + 1] = t
    return t
end

-- Une case qui reflète un bouton de Forever
local function MirrorNative(t, native)
    t.native, t.action = native, nil
    local has, tex, atlas, icon = NativePicture(native)
    if not has then
        SetPicture(t)
        t.count:SetText("")
        ClearCooldown(t)
        SetEdge(t, DIM_EDGE)
        return
    end
    SetPicture(t, tex, atlas)
    -- (sa teinte : inutilisable, hors de portée)
    if not (icon and pcall(t.icon.SetVertexColor, t.icon, icon:GetVertexColor())) then t.icon:SetVertexColor(1, 1, 1) end
    if not (icon and pcall(t.icon.SetDesaturated, t.icon, icon:IsDesaturated())) then t.icon:SetDesaturated(false) end
    local special = native.SpecialActionIcon
    if native.action and not (special and special:IsShown()) then
        local s, d = SlotCooldown(native.action)
        SetCooldown(t, s, d, (Secret(s) or Secret(d)) and SlotCooldownDuration(native.action) or nil)
    else
        local cd, s, d = native.cooldown, nil, nil
        if cd and cd.GetCooldownTimes and cd:IsShown() then
            local ok, a, b = pcall(cd.GetCooldownTimes, cd)
            if ok and not Secret(a) and not Secret(b) and type(a) == "number" and type(b) == "number" then
                s, d = a / 1000, b / 1000
            end
        end
        SetCooldown(t, s, d)
    end
    local count = native.Count
    if not pcall(t.count.SetText, t.count, count and count:IsShown() and count:GetText() or "") then
        t.count:SetText("")
    end
    local ok, pressed = pcall(function() return native:GetButtonState() == "PUSHED" end)
    local alert = native.SpellActivationAlert
    SetEdge(t, ((ok and pressed) or (alert and alert:IsShown())) and GOLD_EDGE or DIM_EDGE)
end

-- Une case qui montre une de nos actions (dim : couche vide qui reprend « Seul »)
local function MirrorAction(t, action, dim, lit)
    t.native, t.action = nil, action
    SetEdge(t, lit and GOLD_EDGE or DIM_EDGE)
    if not action then
        SetPicture(t)
        t.count:SetText("")
        ClearCooldown(t)
        return
    end
    SetPicture(t, ns.Actions.Icon(action))
    t.icon:SetVertexColor(dim and 0.6 or 1, dim and 0.6 or 1, dim and 0.6 or 1)
    t.icon:SetDesaturated(dim and true or false)
    local s, d, durObj
    local spell = ActionSpell(action)
    if spell then
        s, d = SpellCooldown(spell)
        if Secret(s) or Secret(d) then durObj = SpellCooldownDuration(spell) end
    elseif action.kind == "item" or action.kind == "toy" then
        s, d = ItemCooldown(action.id)
    end
    SetCooldown(t, s, d, durObj)
    local n = action.kind == "item" and ItemCount(action.id) or 0
    t.count:SetText(n > 1 and n or "")
end

---------------------------------------------------------------------------
-- Une étiquette de couche : des pastilles de boutons, ou un texte
---------------------------------------------------------------------------
local function Tag(parent, size, font)
    local tag = CreateFrame("Frame", nil, parent)
    tag:SetSize(10, size)
    tag.glyphs = { UI.CreateGlyph(tag, size), UI.CreateGlyph(tag, size) }
    tag.plus = UI.Text(tag, font, "+")
    tag.text = UI.Text(tag, font)
    tag.size = size
    return tag
end

local function SetTag(tag, keys, text)
    local size, x = tag.size, 0
    for _, g in ipairs(tag.glyphs) do g:Hide() end
    tag.plus:Hide()
    tag.text:Hide()
    for i, key in ipairs(keys or {}) do
        if i == 2 then
            tag.plus:ClearAllPoints()
            tag.plus:SetPoint("LEFT", x + 2, 0)
            tag.plus:Show()
            x = x + tag.plus:GetStringWidth() + 4
        end
        local g = tag.glyphs[i]
        g:SetKey(key)
        g:ClearAllPoints()
        g:SetPoint("LEFT", x, 0)
        g:Show()
        x = x + size
    end
    if text then
        tag.text:SetText(text)
        tag.text:ClearAllPoints()
        tag.text:SetPoint("LEFT", x + (x > 0 and 4 or 0), 0)
        tag.text:Show()
        x = x + (x > 0 and 4 or 0) + tag.text:GetStringWidth()
    end
    tag:SetWidth(math.max(x, 1))
end

local function EntryTag(tag, entry)
    if entry.bar then
        SetTag(tag, BAR_KEYS[entry.bar], entry.bar == "topBar" and L.LAYER_BASE or nil)
    elseif entry.mod then
        -- (une paire : ses deux boutons, « L5 + R5 »)
        local pair = ns.PairDef(entry.mod)
        SetTag(tag, pair and { pair.a, pair.b } or { entry.mod })
    else
        SetTag(tag, {}, nil)
    end
end

---------------------------------------------------------------------------
-- Construction (positions depuis le bas-milieu du cadre)
---------------------------------------------------------------------------
local holder, outline, moveHint
local strip -- (le cadre des miniatures : mis à l'échelle choisie)
local dpad, face = {}, {}
local cards, paddles, classTiles = {}, {}, {}
local titleTag
local dirty = true
local editing        -- (la couche modifiée : { bar = name } | { mod = id }, ou nil)
local paddleView = {} -- [id] = couche choisie à la souris pour un bouton simple

local function Cluster(cx, keys, store)
    for i, spot in ipairs(SPOTS) do
        local t = Tile(holder, TILE)
        t.x, t.y = cx + spot[1] * STEP, MAIN_H / 2 + spot[2] * STEP
        t.glyph = UI.CreateGlyph(t, GLYPH)
        t.glyph:SetFrameLevel(t.top:GetFrameLevel() + 1)
        t.glyph:SetPoint("CENTER", t, "CENTER", spot[1] * (TILE / 2 + 3), spot[2] * (TILE / 2 + 3))
        t.glyph:SetKey(keys[i])
        store[i] = t
    end
end

local function CardTooltip(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    -- (SetText : texte, r, g, b, alpha, retour à la ligne ; AddLine n'a pas d'alpha)
    GameTooltip:SetText(L.HUD_CARD_HINT, 1, 0.82, 0, 1, true)
    GameTooltip:AddLine(L.HUD_CARD_DRAG, 1, 0.82, 0, true)
    GameTooltip:Show()
end

-- Glisser une miniature sur une autre : elle prend sa place (hors combat).
-- Le relâchement d'un glisser ne compte pas comme un clic.
local dragCard, dragEnd = nil, 0

local function CardUnderMouse()
    for _, c in ipairs(cards) do
        if c:IsShown() and c:IsMouseOver() then return c end
    end
end

local function CardDragStart(self)
    if InCombatLockdown() then return end
    GameTooltip:Hide()
    dragCard = self
end

local function CardDragStop()
    local from = dragCard
    dragCard, dragEnd = nil, GetTime()
    if not from or InCombatLockdown() then return end
    local target = CardUnderMouse()
    if target and target ~= from and target.entry and from.entry then
        H.MoveLayerTo(LayerKey(from.entry), LayerKey(target.entry))
    end
end

local function Card()
    local c = CreateFrame("Frame", nil, strip)
    c:SetSize(CARD_W, CARD_H)
    c.edge = c:CreateTexture(nil, "BACKGROUND")
    c.edge:SetAllPoints()
    local bg = c:CreateTexture(nil, "BORDER")
    bg:SetPoint("TOPLEFT", 2, -2)
    bg:SetPoint("BOTTOMRIGHT", -2, 2)
    bg:SetColorTexture(0.02, 0.02, 0.02, 0.85)
    c.tag = Tag(c, 20, "GameFontNormal")
    c.tag:SetPoint("TOP", 0, -4)
    -- (une case miniature : un fond, l'icône par-dessus)
    local function Mini(r, g, b, a)
        local back = c:CreateTexture(nil, "BORDER", nil, 1)
        back:SetSize(MINI, MINI)
        back:SetColorTexture(r, g, b, a)
        local tex = c:CreateTexture(nil, "ARTWORK")
        tex:SetSize(MINI, MINI)
        tex:SetPoint("CENTER", back, "CENTER")
        tex.back = back
        return tex
    end
    c.minis = {}
    for i = 1, 8 do c.minis[i] = Mini(1, 1, 1, 0.1) end
    -- (les boutons simples : fond doré, pour les distinguer)
    c.simple = {}
    for i = 1, #ns.BUTTON_IDS + #ns.PAD_IDS do c.simple[i] = Mini(0.75, 0.55, 0.1, 0.25) end
    local hl = c:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints(bg)
    hl:SetColorTexture(1, 1, 1, 0.08)
    c:EnableMouse(true)
    c:SetScript("OnEnter", CardTooltip)
    c:SetScript("OnLeave", function() GameTooltip:Hide() end)
    c:RegisterForDrag("LeftButton")
    c:SetScript("OnDragStart", CardDragStart)
    c:SetScript("OnDragStop", CardDragStop)
    -- (clic : cette couche en grand pour la modifier ; encore : retour)
    c:SetScript("OnMouseUp", function(self)
        if dragCard or GetTime() == dragEnd then return end
        local e = self.entry
        if editing and editing.bar == e.bar and editing.mod == e.mod then
            editing = nil
        else
            editing = e
        end
    end)
    mouseFrames[#mouseFrames + 1] = c
    return c
end

-- Place les cases d'une miniature : croix à gauche, A/B/X/Y à droite, les
-- boutons simples entre les deux (nSimple : combien sont montrés)
local function LayoutCard(c, nSimple)
    c:SetSize(cardW, CARD_H)
    local cols = math.ceil(nSimple / SIMPLE_PER_COL)
    local middle = nSimple > 0 and (cols * MINI_STEP + 16) or 8
    for g = 0, 1 do
        for i, spot in ipairs(SPOTS) do
            local x = 6 + g * (CROSS + middle) + CROSS / 2 + spot[1] * MINI_STEP
            local y = 6 + CROSS / 2 + spot[2] * MINI_STEP
            local tex = c.minis[g * 4 + i]
            tex.back:ClearAllPoints()
            tex.back:SetPoint("CENTER", c, "BOTTOMLEFT", x, y)
        end
    end
    for k, tex in ipairs(c.simple) do
        local shown = k <= nSimple
        tex.back:SetShown(shown)
        if not shown then tex:Hide() end
        if shown then
            local col, row = math.floor((k - 1) / SIMPLE_PER_COL), (k - 1) % SIMPLE_PER_COL
            local inCol = math.min(SIMPLE_PER_COL, nSimple - col * SIMPLE_PER_COL)
            local x = 6 + CROSS + 8 + col * MINI_STEP + MINI_STEP / 2
            local y = 6 + CROSS / 2 + ((inCol - 1) / 2 - row) * MINI_STEP
            tex.back:ClearAllPoints()
            tex.back:SetPoint("CENTER", c, "BOTTOMLEFT", x, y)
        end
    end
end

local function Paddle()
    local p = Tile(holder, PADDLE)
    p.glyph = UI.CreateGlyph(p, 22)
    p.glyph:SetFrameLevel(p.top:GetFrameLevel() + 1)
    p.glyph:SetPoint("CENTER", p, "TOP", 0, 0)
    p.pips = {}
    local labels = { L.LAYER_BASE, "LT", "RT" }
    for i, layer in ipairs(LAYERS) do
        local pip = CreateFrame("Button", nil, holder)
        pip.text = UI.Text(pip, "GameFontHighlightSmall", labels[i])
        pip.text:SetPoint("CENTER")
        pip:SetSize(math.max(20, pip.text:GetStringWidth() + 6), 14)
        -- (clic : cette couche du bouton à l'écran, pour la modifier)
        pip:SetScript("OnClick", function()
            if not p.id then return end
            paddleView[p.id] = (paddleView[p.id] ~= layer) and layer or nil
        end)
        mouseFrames[#mouseFrames + 1] = pip
        p.pips[i] = pip
    end
    return p
end

local function Build()
    holder = CreateFrame("Frame", "MyGamepadIsRichHud", UIParent)
    holder:SetSize(MAIN_W, HEIGHT)
    strip = CreateFrame("Frame", nil, holder)
    strip:SetSize(CARD_W, CARD_H)
    -- (strate de la barre de Forever, au moins MEDIUM ; posée avant de créer
    -- les cases, qui prennent leur niveau du cadre)
    local strata = "MEDIUM"
    local main = _G.GamepadMainActionBarFrame
    local ok, theirs = pcall(function() return main and main:GetFrameStrata() end)
    if ok and type(theirs) == "string" and (STRATA_ORDER[theirs] or 0) > STRATA_ORDER[strata] then
        strata = theirs
    end
    holder:SetFrameStrata(strata)
    holder:SetFrameLevel(HUD_LEVEL)
    holder:SetClampedToScreen(true)
    holder:SetMovable(true)
    holder:RegisterForDrag("LeftButton")
    holder:SetScript("OnDragStart", holder.StartMoving)
    holder:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, rel, x, y = self:GetPoint()
        H.Settings().pos = { point, rel, x, y }
    end)
    holder:Hide()

    outline = holder:CreateTexture(nil, "BACKGROUND")
    outline:SetAllPoints()
    outline:SetColorTexture(1, 0.78, 0.2, 0.18)
    outline:Hide()
    moveHint = UI.Text(holder, "GameFontNormal", L.HUD_UNLOCKED)
    moveHint:SetPoint("BOTTOM", holder, "TOP", 0, 6)
    moveHint:Hide()

    local cx = CENTER_W / 2 + CLUSTER / 2
    Cluster(-cx, DPAD_KEYS, dpad)
    Cluster(cx, FACE_KEYS, face)

    titleTag = Tag(holder, 24, "GameFontNormalLarge")

    for i, side in ipairs({ { "PADLSHOULDER", "PADLTRIGGER" }, { "PADRSHOULDER", "PADRTRIGGER" } }) do
        local t = Tile(holder, 34)
        t.x, t.y = i == 1 and -50 or 50, 24
        t.tag = Tag(holder, 18, "GameFontNormalSmall")
        SetTag(t.tag, side)
        t.tag:SetPoint(i == 1 and "RIGHT" or "LEFT", t, i == 1 and "LEFT" or "RIGHT", i == 1 and -4 or 4, 0)
        classTiles[i] = t
    end
    H.Place()
end

-- La couche active posée au-dessus de la bande (en bas) ou dessous (en haut)
local function PlaceMain()
    local y0 = MainY()
    for _, t in ipairs(dpad) do t:SetPoint("CENTER", holder, "BOTTOM", t.x, y0 + t.y) end
    for _, t in ipairs(face) do t:SetPoint("CENTER", holder, "BOTTOM", t.x, y0 + t.y) end
    for _, t in ipairs(classTiles) do t:SetPoint("CENTER", holder, "BOTTOM", t.x, y0 + t.y) end
    titleTag:ClearAllPoints()
    titleTag:SetPoint("CENTER", holder, "BOTTOM", 0, y0 + MAIN_H - 14)
end

function H.Place()
    if not holder then return end
    local s = H.Settings()
    holder:ClearAllPoints()
    local pos = s.pos
    if pos then
        holder:SetPoint(pos[1], UIParent, pos[2], pos[3], pos[4])
    else
        holder:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 110)
    end
    holder:SetScale(s.scale)
end

-- Les couches en miniature et les boutons simples, selon la configuration
local function Relayout()
    dirty = false
    local s = H.Settings()
    local bottom = s.strip == "bottom"
    -- (dans l'ordre choisi par le joueur, ou celui de l'interface)
    local list = H.Layers()

    -- La bande : réparties sur 1 à 3 lignes (chacune centrée), à la taille choisie
    -- (chaque miniature montre aussi les boutons simples de sa couche)
    local nSimple = math.min(#ns.SimpleIDs(), #ns.BUTTON_IDS + #ns.PAD_IDS)
    cardW = CardWidth(nSimple)
    local rows = math.max(1, math.min(s.stripRows, #list))
    local perRow = math.ceil(#list / rows)
    local rowW = perRow * cardW + (perRow - 1) * STRIP_GAP
    local stripH = rows * CARD_H + (rows - 1) * STRIP_GAP
    strip:SetScale(s.stripScale)
    strip:SetSize(rowW, stripH)
    strip:ClearAllPoints()
    strip:SetPoint(bottom and "BOTTOM" or "TOP", holder, bottom and "BOTTOM" or "TOP", 0, 0)
    stripSpace = stripH * s.stripScale
    holder:SetWidth(math.max(MAIN_W, rowW * s.stripScale))
    holder:SetHeight(MAIN_H + 14 + stripSpace)
    for i, entry in ipairs(list) do
        local c = cards[i] or Card()
        cards[i] = c
        c.entry = entry
        local row, col = math.floor((i - 1) / perRow), (i - 1) % perRow
        local inRow = math.min(perRow, #list - row * perRow)
        local x = (rowW - (inRow * cardW + (inRow - 1) * STRIP_GAP)) / 2 + col * (cardW + STRIP_GAP)
        LayoutCard(c, nSimple)
        c:ClearAllPoints()
        c:SetPoint("TOPLEFT", strip, "TOPLEFT", x, -row * (CARD_H + STRIP_GAP))
        EntryTag(c.tag, entry)
        c:Show()
    end
    for i = #list + 1, #cards do cards[i]:Hide() end

    -- La couche active au-dessus (bande en bas) ou en dessous (bande en haut)
    PlaceMain()
    local y0 = MainY()
    -- (la couche modifiée n'existe plus : retour)
    if editing and editing.mod and not ns.IsModLayer(editing.mod) then editing = nil end
    if editing and editing.bar and ns.GameBarReplaced(editing.bar) then editing = nil end

    local simple = ns.SimpleIDs()
    local gapX = 76
    local x0 = -(#simple - 1) * gapX / 2
    for i, id in ipairs(simple) do
        local p = paddles[i] or Paddle()
        paddles[i] = p
        p.id = id
        p:ClearAllPoints()
        p:SetPoint("CENTER", holder, "BOTTOM", x0 + (i - 1) * gapX, y0 + MAIN_H / 2 + 10)
        p.glyph:SetKey(id)
        for k, pip in ipairs(p.pips) do
            pip:ClearAllPoints()
            pip:SetPoint("TOP", p, "BOTTOM", (k - 2) * 24, -4)
            pip:Show()
        end
        p:Show()
    end
    for i = #simple + 1, #paddles do
        paddles[i]:Hide()
        paddles[i].id = nil
        for _, pip in ipairs(paddles[i].pips) do pip:Hide() end
    end
end

---------------------------------------------------------------------------
-- État : gâchettes tenues, modificateur tenu, bouton simple pressé
---------------------------------------------------------------------------
local padIndex = {}
local function PadIndex(button)
    if padIndex[button] == nil then
        local ok, i = pcall(C_GamePad and C_GamePad.ButtonBindingToIndex or error, button)
        padIndex[button] = (ok and type(i) == "number") and (i + 1) or false
    end
    return padIndex[button] or nil
end

local function Triggers()
    -- (l'état réel de la manette, Focus.lua ; GetGamePadState n'existe pas
    -- partout)
    local down = ns.Focus and ns.Focus.PadsDown()
    if not down then return IsShiftKeyDown and IsShiftKeyDown() or false, false end
    return down.LT == true, down.RT == true
end

local pressed = {}
function H.Pressed(id, down)
    pressed[id] = down and true or nil
end

---------------------------------------------------------------------------
-- Mise à jour (20 fois par seconde)
---------------------------------------------------------------------------
local shown, unlocked = false, false

local function SetMini(tex, has, t, atlas)
    if has and atlas then
        pcall(tex.SetAtlas, tex, atlas)
        tex:Show()
    elseif has and t then
        pcall(tex.SetTexture, tex, t)
        tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)
        tex:Show()
    else
        tex:Hide()
    end
end

local CARD_SIMPLE_LAYER = { topBar = "base", leftBar = "lt", rightBar = "rt" }

local function SetCardMinis(c, pu)
    local entry = c.entry
    if entry.bar then
        local bar = pu.actionBars and pu.actionBars[entry.bar]
        local base = entry.bar == ns.Bar.BASE_BAR
        for i, tex in ipairs(c.minis) do
            local own = base and ns.Bar.Override(i)
            if own then
                SetMini(tex, true, ns.Actions.Icon(own))
            else
                local has, t, atlas = NativePicture(Native(bar, i))
                SetMini(tex, has, t, atlas)
            end
        end
    else
        local combos = ns.ButtonActions(entry.mod).combos
        for i, tex in ipairs(c.minis) do
            local action = combos[i <= 4 and DPAD_KEYS[i] or FACE_KEYS[i - 4]]
            SetMini(tex, action ~= nil, action and ns.Actions.Icon(action))
        end
    end
    -- (les boutons simples : leur case de cette couche ; une barre du jeu
    -- montre leur action seule, avec LT ou avec RT ; LT + RT n'en a pas)
    local simple = ns.SimpleIDs()
    for k, tex in ipairs(c.simple) do
        local sid = simple[k]
        local action
        if sid and entry.mod then
            action = ns.ButtonActions(entry.mod).combos[sid]
        elseif sid and CARD_SIMPLE_LAYER[entry.bar] then
            action = ns.ButtonActions(sid).layers[CARD_SIMPLE_LAYER[entry.bar]]
        end
        SetMini(tex, action ~= nil and tex.back:IsShown(), action and ns.Actions.Icon(action))
    end
end

local function SetCardState(c, active, edited, any)
    local edge = edited and EDIT_EDGE or (active and GOLD_EDGE or DIM_EDGE)
    c.edge:SetColorTexture(edge[1], edge[2], edge[3], edge[4])
    c:SetAlpha((active or edited) and 1 or (any and 0.6 or 0.9))
end

-- La couche en grand : un modificateur, ou une barre de Forever (par son nom
-- quand c'en est une des quatre, sinon celle qu'elle a active : véhicule...)
local function ShowLayer(pu, view)
    if view.mod then
        local combos = ns.ButtonActions(view.mod).combos
        for i = 1, 4 do
            MirrorAction(dpad[i], combos[DPAD_KEYS[i]])
            dpad[i].target = { combo = view.mod, key = DPAD_KEYS[i] }
            MirrorAction(face[i], combos[FACE_KEYS[i]])
            face[i].target = { combo = view.mod, key = FACE_KEYS[i] }
        end
        EntryTag(titleTag, view)
        return
    end
    local bar = view.bar and pu.actionBars and pu.actionBars[view.bar] or pu.activeBar
    -- (« Seul » : une case prise par l'addon montre son action)
    local base = view.bar == ns.Bar.BASE_BAR
    local function Mirror(t, i)
        local own = base and ns.Bar.Override(i)
        if own then MirrorAction(t, own) else MirrorNative(t, Native(bar, i)) end
        t.target = view.bar and { native = view.bar, i = i } or nil
    end
    for i = 1, 4 do
        Mirror(dpad[i], i)
        Mirror(face[i], i + 4)
    end
    EntryTag(titleTag, view)
end

local function Update(pu)
    if dirty then Relayout() end
    if editing and InCombatLockdown() then editing = nil end
    local lt, rt = Triggers()
    local mod = ns.Modifier.Held and ns.Modifier.Held()
    if mod and not ns.IsModLayer(mod) then mod = nil end

    -- La barre active de Forever, par son nom
    local active = pu.activeBar
    local activeName
    for _, name in ipairs(BARS) do
        if pu.actionBars and pu.actionBars[name] == active then activeName = name end
    end
    local live = mod and { mod = mod } or { bar = activeName }
    local view = editing or live
    ShowLayer(pu, view)

    local any = mod ~= nil or lt or rt
    if dragCard and InCombatLockdown() then dragCard = nil end
    local dropOn = dragCard and CardUnderMouse()
    for _, c in ipairs(cards) do
        if c:IsShown() then
            SetCardMinis(c, pu)
            local e = c.entry
            local isLive = (live.mod and e.mod == live.mod) or (not live.mod and live.bar and e.bar == live.bar)
            local isEdit = editing and e.bar == editing.bar and e.mod == editing.mod
            SetCardState(c, isLive, isEdit, any)
            -- (glisser en cours : la miniature tenue estompée, sa future place
            -- en bleu)
            if c == dragCard then
                c:SetAlpha(0.4)
            elseif dropOn == c then
                c.edge:SetColorTexture(EDIT_EDGE[1], EDIT_EDGE[2], EDIT_EDGE[3], EDIT_EDGE[4])
            end
        end
    end

    -- Boutons simples : l'action de la couche que la gâchette choisit
    -- (comme Simple.lua : LT d'abord), ou celle choisie à la souris
    -- (une couche de modificateur affichée : sa case pour ce bouton simple ;
    -- vide, le bouton garde son action habituelle, montrée estompée)
    local held = lt and "lt" or (rt and "rt" or nil)
    local modView = view.mod
    for _, p in ipairs(paddles) do
        if p:IsShown() and p.id then
            local layers = ns.ButtonActions(p.id).layers
            local layer = held or paddleView[p.id] or "base"
            local own = modView and ns.ButtonActions(modView).combos[p.id]
            if own then
                MirrorAction(p, own, false, pressed[p.id])
                p:SetAlpha(1)
            else
                local action = layers[layer]
                local fallback = (not action and layer ~= "base") or modView ~= nil
                MirrorAction(p, action or layers.base, fallback, pressed[p.id])
                p:SetAlpha((mod and not modView) and 0.5 or 1)
            end
            p.target = modView and { combo = modView, key = p.id } or { layer = layer, id = p.id }
            for k, id in ipairs(LAYERS) do
                local pip = p.pips[k]
                if id == layer then
                    pip.text:SetTextColor(1, 0.82, 0.1)
                elseif layers[id] then
                    pip.text:SetTextColor(0.85, 0.85, 0.85)
                else
                    pip.text:SetTextColor(0.45, 0.45, 0.45)
                end
            end
        end
    end

    -- Actions de classe (LB + LT, RB + RT), quand Forever en montre une
    for i, native in ipairs({ pu.LeftClassAction, pu.RightClassAction }) do
        local t = classTiles[i]
        local on = native ~= nil and native.IsShown and native:IsShown()
        t:SetShown(on and true or false)
        t.tag:SetShown(on and true or false)
        if on then MirrorNative(t, native) end
    end

    -- Estompé au repos : hors combat, rien de tenu, rien en cours de modification
    local busy = unlocked or editing ~= nil or InCombatLockdown() or any or holder:IsMouseOver()
    local want = busy and 1 or IDLE_ALPHA
    local now = holder:GetAlpha()
    if math.abs(now - want) > 0.01 then
        holder:SetAlpha(now + (want - now) * 0.35)
    end
end

local function Watch()
    if not ns.db then return end
    if not holder then Build() end
    local pu = PageUnit()
    local main = _G.GamepadMainActionBarFrame
    local on = H.Settings().enabled and pu ~= nil and main:IsVisible() and not EditMode()
    if pu then
        for _, part in ipairs(NativeParts(pu)) do Fade(part, on) end
        for _, bar in ipairs(NativeBars(pu)) do Cover(bar, on) end
    end
    if on ~= shown then
        shown = on
        holder:SetShown(on)
    end
    if on then Update(pu) end
end

---------------------------------------------------------------------------
-- Mode édition : n'importe quelle autre touche ou bouton de la manette le
-- quitte. Un cadre écoute seulement pendant l'édition (hors combat), et
-- laisse passer chaque appui au jeu, sauf Échap (qui n'ouvre alors pas le
-- menu du jeu). Les boutons de clic du curseur manette ne comptent pas :
-- ce sont eux qui cliquent les cases.
---------------------------------------------------------------------------
local editKeys, editKeysOn = nil, false

local function CursorButton(button)
    return button == ns.CVar("GamePadCursorLeftClick") or button == ns.CVar("GamePadCursorRightClick")
end

local function StopEditing()
    editing = nil
end

local function SetEditKeys(on)
    on = on and not InCombatLockdown()
    if on == editKeysOn then return end
    if not editKeys then
        editKeys = CreateFrame("Frame", nil, UIParent)
        editKeys:SetScript("OnKeyDown", function(self, key)
            if InCombatLockdown() then return end
            -- (Échap quitte l'édition sans ouvrir le menu du jeu)
            self:SetPropagateKeyboardInput(key ~= "ESCAPE")
            StopEditing()
        end)
        editKeys:SetScript("OnGamePadButtonDown", function(_, button)
            if CursorButton(button) then return end
            StopEditing()
        end)
        -- (le combat arrive : on ne garde pas un cadre clavier ouvert)
        editKeys:RegisterEvent("PLAYER_REGEN_DISABLED")
        editKeys:SetScript("OnEvent", function()
            StopEditing()
            if editKeysOn then
                editKeysOn = false
                editKeys:EnableKeyboard(false)
                if editKeys.EnableGamePadButton then editKeys:EnableGamePadButton(false) end
            end
        end)
    end
    editKeysOn = on
    if on then editKeys:SetPropagateKeyboardInput(true) end
    editKeys:EnableKeyboard(on)
    if editKeys.EnableGamePadButton then editKeys:EnableGamePadButton(on) end
end

-- Une erreur dans la mise à jour (20 fois par seconde) se répéterait sans
-- fin : le HUD s'arrête, rend sa barre au jeu, et le dit une seule fois
local broken = false

local function Restore()
    local pu = PageUnit()
    if pu then
        for _, part in ipairs(NativeParts(pu)) do pcall(Fade, part, false) end
        for _, bar in ipairs(NativeBars(pu)) do pcall(Cover, bar, false) end
    end
    if holder then holder:Hide() end
    shown = false
    editing = nil
    pcall(SetEditKeys, false)
end

local wait = 0
local watcher = CreateFrame("Frame")
watcher:SetScript("OnUpdate", function(_, elapsed)
    if broken then return end
    wait = wait - elapsed
    if wait > 0 then return end
    wait = 0.05
    local ok, err = pcall(function()
        Watch()
        -- (l'écoute des touches suit le mode édition, HUD affiché)
        SetEditKeys(shown and editing ~= nil)
    end)
    if not ok then
        broken = true
        pcall(Restore)
        ns.Print(L.HUD_ERROR:format(tostring(err)))
    end
end)
ns.OnApplied(function() dirty = true end)

-- L'ordre des couches a changé : le HUD se refait, la fenêtre aussi
function H.Changed()
    dirty = true
    if UI.RefreshAll then UI.RefreshAll() end
end

-- La bande des miniatures : "top" (au-dessus) ou "bottom" (dessous)
function H.SetStrip(pos)
    H.Settings().strip = (pos == "top") and "top" or "bottom"
    dirty = true
end

function H.Strip()
    return H.Settings().strip
end

-- Taille des miniatures (50 à 150 %)
function H.StripScale() return H.Settings().stripScale end

function H.SetStripScale(n)
    H.Settings().stripScale = math.max(0.5, math.min(1.5, math.floor(n * 20 + 0.5) / 20))
    dirty = true
end

-- Nombre de lignes de miniatures (1 à 3)
function H.StripRows() return H.Settings().stripRows end

function H.SetStripRows(n)
    H.Settings().stripRows = math.max(1, math.min(3, math.floor(n)))
    dirty = true
end

-- (pour l'onglet HUD de la fenêtre de configuration)
function H.IsEnabled() return H.Settings().enabled end
function H.SetEnabled(on) H.Settings().enabled = on and true or false end
function H.Scale() return H.Settings().scale end

function H.SetScale(n)
    local s = H.Settings()
    s.scale = math.max(0.5, math.min(2, math.floor(n * 20 + 0.5) / 20))
    H.Place()
end

function H.ResetPosition()
    local s = H.Settings()
    s.pos, s.scale = nil, 1
    H.Place()
end

-- Les réglages, pour un export de profil (copie), et leur retour d'un
-- import : seuls les champs connus, bornés comme les réglages à la main
local POINTS = {
    TOPLEFT = true, TOP = true, TOPRIGHT = true, LEFT = true, CENTER = true, RIGHT = true,
    BOTTOMLEFT = true, BOTTOM = true, BOTTOMRIGHT = true,
}

local function Clamp(n, lo, hi, default)
    if type(n) ~= "number" or n ~= n then return default end
    return math.max(lo, math.min(hi, n))
end

function H.ExportSettings()
    local s = H.Settings()
    local out = { enabled = s.enabled, scale = s.scale, strip = s.strip,
        stripScale = s.stripScale, stripRows = s.stripRows }
    if s.pos then out.pos = { s.pos[1], s.pos[2], s.pos[3], s.pos[4] } end
    if s.order then
        out.order = {}
        for i, k in ipairs(s.order) do out.order[i] = k end
    end
    return out
end

-- (un ordre importé : seulement des clés de couches connues, sans doublon)
local function CleanOrder(t)
    if type(t) ~= "table" then return nil end
    local out, seen = {}, {}
    for i = 1, math.min(#t, ORDER_MAX) do
        local k = t[i]
        if ValidKey(k) and not seen[k] then
            out[#out + 1] = k
            seen[k] = true
        end
    end
    return #out > 0 and out or nil
end

-- (t vient d'une chaîne d'import : n'importe quoi peut s'y trouver)
function H.CleanSettings(t)
    if type(t) ~= "table" then return nil end
    local out = {
        enabled = t.enabled ~= false,
        scale = Clamp(t.scale, 0.5, 2, 1),
        strip = (t.strip == "top") and "top" or "bottom",
        stripScale = Clamp(t.stripScale, 0.5, 1.5, 1),
        stripRows = math.floor(Clamp(t.stripRows, 1, 3, 1)),
    }
    local p = t.pos
    if type(p) == "table" and POINTS[p[1]] and POINTS[p[2]] then
        out.pos = { p[1], p[2], Clamp(p[3], -4000, 4000, 0), Clamp(p[4], -4000, 4000, 0) }
    end
    out.order = CleanOrder(t.order)
    return out
end

function H.ImportSettings(t)
    local clean = H.CleanSettings(t)
    if not clean then return end
    local s = H.Settings()
    for k, v in pairs(clean) do s[k] = v end
    s.pos = clean.pos
    s.order = clean.order
    H.Place()
    dirty = true
end

function H.IsUnlocked() return unlocked end

-- Déverrouiller (déplacer à la souris) / verrouiller
function H.SetUnlocked(on)
    if not holder then Build() end
    unlocked = on and true or false
    holder:EnableMouse(unlocked)
    -- (déverrouillé : les cases laissent la souris au cadre, qu'on déplace)
    for _, f in ipairs(mouseFrames) do f:EnableMouse(not unlocked) end
    outline:SetShown(unlocked)
    moveHint:SetShown(unlocked)
end

---------------------------------------------------------------------------
-- Commandes : /mgir hud [on | off | scale <n> | strip [top|bottom] | reset]
---------------------------------------------------------------------------
function H.Command(args)
    local s = H.Settings()
    local word, rest = (args or ""):match("^(%S*)%s*(.-)$")
    if word == "on" then
        s.enabled = true
        ns.Print(L.HUD_ON)
    elseif word == "off" then
        s.enabled = false
        ns.Print(L.HUD_OFF)
    elseif word == "scale" then
        local n = tonumber(rest)
        if n then s.scale = math.max(0.5, math.min(2, n)) end
        H.Place()
        ns.Print(L.HUD_SCALE:format(tostring(s.scale)))
    elseif word == "strip" then
        -- (/mgir hud strip [top | bottom], sans argument : bascule)
        local pos
        if rest == "top" or rest == "haut" then
            pos = "top"
        elseif rest == "bottom" or rest == "bas" then
            pos = "bottom"
        else
            pos = s.strip == "top" and "bottom" or "top"
        end
        H.SetStrip(pos)
        ns.Print(pos == "top" and L.HUD_STRIP_TOP or L.HUD_STRIP_BOTTOM)
    elseif word == "reset" then
        H.ResetPosition()
        ns.Print(L.HUD_LOCKED)
    else
        H.SetUnlocked(not unlocked)
        ns.Print(unlocked and L.HUD_UNLOCKED or L.HUD_LOCKED)
    end
end
