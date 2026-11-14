-- HUD en grille : une autre disposition du HUD (Hud.lua), choisie dans
-- l'onglet HUD, le tutoriel ou le petit bouton du HUD.
--
-- Une ligne par couche (dans l'ordre du HUD), les boutons toujours dans le
-- même ordre : la croix puis X, Y, B, A (gauche, haut, droite, bas), puis les
-- boutons simples. Leurs pastilles en tête de chaque colonne, sur un fond de
-- leur couleur. Au-dessus (réglable), le rappel : la couche utilisée en
-- grand, alignée sur les colonnes. La couche utilisée passe en doré (et
-- grossit, sans rappel) ; une couche bloquée (Focus.lua) en rouge ; la
-- couche agrandie pour la modifier en bleu. Les couches se répartissent sur
-- 1 à 3 colonnes, et la grille a sa propre taille.
--
-- Les cases sont celles du HUD (même dessin, même info-bulle, même clic :
-- menu, dépôt du curseur, clic droit = vider), toutes modifiables
-- directement. Clic sur le nom d'une ligne : elle grossit (bleu) pour viser
-- plus facilement ; glisser ce nom sur une autre ligne : l'ordre change.
local _, ns = ...
local L = ns.L
local UI = ns.UI

local G = {}
ns.HudGrid = G

local SLOT, GAP, GROUP_GAP = 40, 4, 12 -- (une colonne, entre deux, entre deux groupes)
local BIG, SMALL = 40, 30              -- (une case de la ligne utilisée / des autres)
local ROW_BIG, ROW_SMALL, ROW_GAP = 46, 34, 2
local LABEL_W = 62                     -- (le nom de la ligne : ses pastilles)
local HEADER_H = 40                    -- (les en-têtes des colonnes)
local PAD = 8
local BLOCK_GAP = 18                   -- (entre deux colonnes de couches)
local GLYPH = 20                       -- (les pastilles du nom d'une ligne)
local HEAD_GLYPH = 30                  -- (le bouton en tête de colonne)
-- (le rappel de la couche utilisée : ses cases, plus grandes que celles de
-- la grille, chacune avec son bouton au-dessus ; son nom à gauche)
local RECALL_TILE, RECALL_STEP, RECALL_GROUP = 52, 58, 16
local RECALL_LABEL, RECALL_GLYPH, RECALL_KEY = 76, 26, 26
-- (au-dessus de chaque case, son bouton sur un fond de sa couleur, comme
-- les en-têtes des colonnes)
local RECALL_CAP = 30
local RECALL_H = RECALL_TILE + RECALL_CAP + 14
local RECALL_TILE_Y = -(RECALL_CAP + 2) / 2 -- (la case sous son bouton)

-- La couleur de chaque en-tête : A/B/X/Y à leur couleur (celle de la
-- manette : Xbox, ou PlayStation), la croix en gris, les boutons simples en
-- doré (comme leurs pastilles)
local FACE_COLORS = {
    xbox = { PAD1 = { 0.3, 0.75, 0.2 }, PAD2 = { 0.85, 0.2, 0.2 }, PAD3 = { 0.2, 0.45, 0.9 }, PAD4 = { 0.95, 0.75, 0.1 } },
    ps = { PAD1 = { 0.35, 0.55, 0.95 }, PAD2 = { 0.9, 0.25, 0.3 }, PAD3 = { 0.85, 0.45, 0.75 }, PAD4 = { 0.25, 0.75, 0.6 } },
}
local DPAD_COLOR = { 0.6, 0.6, 0.65 }
local SIMPLE_COLOR = { 0.75, 0.55, 0.1 }

local function HeadColor(key, k)
    if k > 8 then return SIMPLE_COLOR end
    local faces = FACE_COLORS[UI.GlyphStyle()] or FACE_COLORS.xbox
    return faces[key] or DPAD_COLOR
end

-- Les colonnes de la croix et de X/Y/B/A : leur bouton, et leur case dans
-- une barre de Forever (1-4 la croix, 5-8 X/Y/B/A). Les deux groupes dans
-- le même ordre, celui de Forever : gauche, haut, droite, bas (la même
-- place pour les deux pouces, quelle que soit la manette)
local COLS = {
    { key = "PADDLEFT", i = 1 }, { key = "PADDUP", i = 2 }, { key = "PADDRIGHT", i = 3 }, { key = "PADDDOWN", i = 4 },
    { key = "PAD3", i = 5 }, { key = "PAD4", i = 6 }, { key = "PAD2", i = 7 }, { key = "PAD1", i = 8 },
}
local NCOLS = #COLS
-- (une barre de Forever qui n'est pas une des quatre : véhicule...)
local SPECIAL = { special = true }

local K -- (ce que le HUD prête : Hud.lua, H.Kit)
local holder, frame, back, hint
local headers = {}   -- [bloc] = { en-têtes : fond, barre, pastille }
local rows = {}      -- (les lignes, réutilisées)
local classTiles = {}
local entries, simple = {}, {}
local cols, scale = 1, 1
-- (au-dessus des en-têtes, centré : la couche utilisée en grand ; la ligne
-- de cette couche dans la grille reste alors en petit. Séparé de la grille,
-- il se place où on veut, HUD déverrouillé, comme les miniatures)
local recall, recallOn = nil, true
local recallDetached, recallPos = false, nil
local unlocked = false
local editing        -- (la clé de la couche agrandie pour la modifier, ou nil)
local signature      -- (couche utilisée, couche modifiée : la place change avec)
local tick = 0
local dragRow, dragEnd = nil, 0

-- Le centre d'une colonne, depuis la gauche d'un bloc
local function ColX(k)
    local x = LABEL_W + 8 + (k - 1) * (SLOT + GAP) + SLOT / 2
    if k > 4 then x = x + GROUP_GAP end
    if k > NCOLS then x = x + GROUP_GAP end
    return x
end

-- Le centre d'une case du rappel, depuis sa gauche
local function RecallX(k)
    local x = RECALL_LABEL + 10 + (k - 1) * RECALL_STEP + RECALL_TILE / 2
    if k > 4 then x = x + RECALL_GROUP end
    if k > NCOLS then x = x + RECALL_GROUP end
    return x
end

local function KeyOf(e)
    return e.special and "special" or K.LayerKey(e)
end

---------------------------------------------------------------------------
-- Une ligne
---------------------------------------------------------------------------
local function RowUnderMouse()
    for _, r in ipairs(rows) do
        if r:IsShown() and not r.entry.special and r:IsMouseOver() then return r end
    end
end

local function LabelTooltip(self)
    local r = self.row
    if not r or r.entry.special or InCombatLockdown() then return end
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:SetText(L.HUD_ROW_HINT, 1, 0.82, 0, 1, true)
    GameTooltip:AddLine(L.HUD_ROW_DRAG, 1, 0.82, 0, true)
    GameTooltip:Show()
end

local function Row()
    local r = CreateFrame("Frame", nil, frame)
    r.edge = r:CreateTexture(nil, "BACKGROUND")
    r.edge:SetAllPoints()
    r.fill = r:CreateTexture(nil, "BACKGROUND", nil, 1)
    r.fill:SetPoint("TOPLEFT", 2, -2)
    r.fill:SetPoint("BOTTOMRIGHT", -2, 2)
    local label = CreateFrame("Button", nil, r)
    label:SetPoint("TOPLEFT", 0, 0)
    label:SetPoint("BOTTOMLEFT", 0, 0)
    label:SetWidth(LABEL_W + 4)
    label.row = r
    local hl = label:CreateTexture(nil, "HIGHLIGHT")
    hl:SetPoint("TOPLEFT", 2, -2)
    hl:SetPoint("BOTTOMRIGHT", 0, 2)
    hl:SetColorTexture(1, 1, 1, 0.08)
    r.tag = K.Tag(label, GLYPH, "GameFontNormal")
    r.tag:SetPoint("LEFT", 6, 0)
    label:RegisterForDrag("LeftButton")
    label:SetScript("OnEnter", LabelTooltip)
    label:SetScript("OnLeave", function() GameTooltip:Hide() end)
    -- (clic : cette ligne en grand pour la modifier ; encore : retour)
    label:SetScript("OnClick", function(self)
        if dragRow or GetTime() == dragEnd or InCombatLockdown() then return end
        local row = self.row
        if row.entry.special then return end
        editing = (editing ~= row.key) and row.key or nil
    end)
    -- (glisser sur une autre ligne : elle prend sa place, hors combat)
    label:SetScript("OnDragStart", function(self)
        if InCombatLockdown() or self.row.entry.special then return end
        GameTooltip:Hide()
        dragRow = self.row
    end)
    label:SetScript("OnDragStop", function()
        local from = dragRow
        dragRow, dragEnd = nil, GetTime()
        if not from or InCombatLockdown() then return end
        local target = RowUnderMouse()
        if target and target ~= from then ns.Hud.MoveLayerTo(from.key, target.key) end
    end)
    K.mouseFrames[#K.mouseFrames + 1] = label
    if ns.Hud.IsUnlocked() then label:EnableMouse(false) end
    r.label = label
    r.tiles = {}
    return r
end

local function RowTile(r, k)
    local t = r.tiles[k]
    if t then return t end
    t = K.Tile(r, SMALL)
    if ns.Hud.IsUnlocked() then t:EnableMouse(false) end
    r.tiles[k] = t
    return t
end

-- Ce qu'une case modifie (comme sur le HUD) : nil pour une case qui ne se
-- modifie pas (véhicule ; boutons simples sur LT + RT, qui n'en ont pas)
local function TargetOf(e, k)
    if e.special then return nil end
    local sid = k > NCOLS and simple[k - NCOLS] or nil
    if e.bar then
        if not sid then return { native = e.bar, i = COLS[k].i } end
        local layer = K.CARD_SIMPLE_LAYER[e.bar]
        return layer and { layer = layer, id = sid } or nil
    end
    return { combo = e.mod, key = sid or COLS[k].key }
end

-- Le rappel : une ligne comme les autres (fond, bord, pastilles, cases),
-- sans clic ni glisser sur son nom. Enfant de la grille (il en suit
-- l'affichage, la transparence et la taille) ; séparé, il se glisse à la
-- souris quand le HUD est déverrouillé
local function RecallRow()
    local r = CreateFrame("Frame", nil, frame)
    r.edge = r:CreateTexture(nil, "BACKGROUND")
    r.edge:SetAllPoints()
    r.fill = r:CreateTexture(nil, "BACKGROUND", nil, 1)
    r.fill:SetPoint("TOPLEFT", 2, -2)
    r.fill:SetPoint("BOTTOMRIGHT", -2, 2)
    r.outline = r:CreateTexture(nil, "BACKGROUND", nil, -1)
    r.outline:SetPoint("TOPLEFT", -4, 4)
    r.outline:SetPoint("BOTTOMRIGHT", 4, -4)
    r.outline:SetColorTexture(1, 0.78, 0.2, 0.18)
    r.outline:Hide()
    r.tag = K.Tag(r, RECALL_GLYPH, "GameFontNormalLarge")
    r.tag:SetPoint("LEFT", 8, 0)
    r.tiles = {}
    r:SetClampedToScreen(true)
    r:SetMovable(true)
    r:RegisterForDrag("LeftButton")
    r:SetScript("OnDragStart", r.StartMoving)
    r:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, rel, x, y = self:GetPoint()
        if point then
            recallPos = { point, rel, x, y }
            ns.Hud.Settings().gridRecallPos = recallPos
        end
    end)
    r:EnableMouse(false)
    return r
end

-- Une case du rappel : celle d'une ligne, avec au-dessus son bouton sur un
-- fond de sa couleur (et une barre de cette couleur dessous)
local function RecallTile(k)
    local t = RowTile(recall, k)
    if not t.cap then
        local cap = CreateFrame("Frame", nil, recall)
        cap:SetSize(RECALL_TILE, RECALL_CAP)
        cap:SetPoint("BOTTOM", t, "TOP", 0, 2)
        cap.back = cap:CreateTexture(nil, "BACKGROUND")
        cap.back:SetAllPoints()
        cap.bar = cap:CreateTexture(nil, "BORDER")
        cap.bar:SetPoint("BOTTOMLEFT")
        cap.bar:SetPoint("BOTTOMRIGHT")
        cap.bar:SetHeight(3)
        t.keyGlyph = UI.CreateGlyph(cap, RECALL_KEY)
        t.keyGlyph:SetPoint("CENTER", 0, 1)
        t.cap = cap
    end
    return t
end

local function SetRowColor(r, c)
    if c then
        r.edge:SetColorTexture(c[1], c[2], c[3], 0.95)
        r.fill:SetColorTexture(c[1] * 0.25, c[2] * 0.25, c[3] * 0.25, 0.55)
    else
        r.edge:SetColorTexture(0, 0, 0, 0)
        r.fill:SetColorTexture(0, 0, 0, 0)
    end
end

---------------------------------------------------------------------------
-- La place de chaque ligne (quand la couche utilisée ou modifiée change)
---------------------------------------------------------------------------
local function Layout(liveKey, special, force)
    local list = {}
    if special then list[1] = SPECIAL end
    for _, e in ipairs(entries) do list[#list + 1] = e end
    local n = NCOLS + #simple
    local blockW = ColX(n) + SLOT / 2 + 6
    local per = math.max(1, math.ceil(#list / math.max(1, math.min(cols, #list))))
    local blocks = math.max(1, math.ceil(#list / per))

    local gridW = blocks * blockW + (blocks - 1) * BLOCK_GAP

    -- Le rappel : la couche utilisée (avant la première mise à jour : la
    -- première ligne). Dans la grille, tout en haut et centré ; séparé, à sa
    -- place (par défaut au-dessus de la grille)
    local top, innerW = PAD, gridW
    if recallOn then
        recall = recall or RecallRow()
        local e = list[1]
        for _, x in ipairs(list) do
            if KeyOf(x) == liveKey then e = x end
        end
        recall.entry, recall.key = e, KeyOf(e)
        local recallW = RecallX(n) + RECALL_TILE / 2 + 10
        recall:SetSize(recallW, RECALL_H)
        recall:ClearAllPoints()
        if recallDetached then
            local p = recallPos
            if p then
                recall:SetPoint(p[1], UIParent, p[2], p[3], p[4])
            else
                recall:SetPoint("BOTTOM", frame, "TOP", 0, 44)
            end
        else
            innerW = math.max(gridW, recallW)
            recall:SetPoint("TOP", frame, "TOP", 0, -PAD)
            top = PAD + RECALL_H + 8
        end
        if e.special then K.SetTag(recall.tag, {}, "...") else K.EntryTag(recall.tag, e) end
        for k = 1, n do
            local t = RecallTile(k)
            t:SetSize(RECALL_TILE, RECALL_TILE)
            t:ClearAllPoints()
            -- (plus bas que le milieu : la place de son bouton au-dessus)
            t:SetPoint("CENTER", recall, "LEFT", RecallX(k), RECALL_TILE_Y)
            t.target = TargetOf(e, k)
            t:SetAlpha((t.target or e.special) and 1 or 0.3)
            local key = k <= NCOLS and COLS[k].key or simple[k - NCOLS]
            local c = HeadColor(key, k)
            t.cap.back:SetColorTexture(c[1], c[2], c[3], 0.3)
            t.cap.bar:SetColorTexture(c[1], c[2], c[3], 1)
            if force or t.keyGlyph.key ~= key then t.keyGlyph:SetKey(key) end
            t.cap:Show()
            t:Show()
        end
        for k = n + 1, #recall.tiles do
            recall.tiles[k]:Hide()
            recall.tiles[k].cap:Hide()
        end
        recall:EnableMouse(unlocked and recallDetached)
        recall.outline:SetShown(unlocked and recallDetached)
        recall:Show()
    elseif recall then
        recall:Hide()
    end
    -- (la grille centrée sous le rappel quand il est plus large qu'elle)
    local x0 = PAD + (innerW - gridW) / 2

    local y = 0
    for i, e in ipairs(list) do
        local r = rows[i] or Row()
        rows[i] = r
        local b, idx = math.floor((i - 1) / per), (i - 1) % per
        if idx == 0 then y = 0 end
        local key = KeyOf(e)
        -- (avec le rappel, la couche utilisée reste en petit dans la grille)
        local big = (key == liveKey and not recallOn) or key == editing
        local h = big and ROW_BIG or ROW_SMALL
        r.entry, r.key = e, key
        r:SetSize(blockW, h)
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", frame, "TOPLEFT", x0 + b * (blockW + BLOCK_GAP), -(top + HEADER_H + y))
        y = y + h + ROW_GAP
        if e.special then K.SetTag(r.tag, {}, "...") else K.EntryTag(r.tag, e) end
        local size = big and BIG or SMALL
        for k = 1, n do
            local t = RowTile(r, k)
            t:SetSize(size, size)
            t:ClearAllPoints()
            t:SetPoint("CENTER", r, "LEFT", ColX(k), 0)
            t.target = TargetOf(e, k)
            -- (une case sans objet : LT + RT n'a pas de boutons simples)
            t:SetAlpha((t.target or e.special) and 1 or 0.3)
            t:Show()
        end
        for k = n + 1, #r.tiles do r.tiles[k]:Hide() end
        r:Show()
    end
    for i = #list + 1, #rows do rows[i]:Hide() end

    -- (en tête de chaque bloc : les boutons de ses colonnes, en grand, sur un
    -- fond de leur couleur avec une barre de cette couleur dessous)
    for b = 1, 3 do
        local heads = headers[b]
        if not heads then
            heads = {}
            headers[b] = heads
        end
        for k = 1, math.max(n, #heads) do
            local head = heads[k]
            if k <= n and b <= blocks then
                if not head then
                    head = CreateFrame("Frame", nil, frame)
                    head:SetSize(SLOT, HEADER_H - 4)
                    head.back = head:CreateTexture(nil, "BACKGROUND")
                    head.back:SetAllPoints()
                    head.bar = head:CreateTexture(nil, "BORDER")
                    head.bar:SetPoint("BOTTOMLEFT")
                    head.bar:SetPoint("BOTTOMRIGHT")
                    head.bar:SetHeight(3)
                    head.glyph = UI.CreateGlyph(head, HEAD_GLYPH)
                    head.glyph:SetPoint("CENTER", 0, 1)
                    heads[k] = head
                end
                head:ClearAllPoints()
                head:SetPoint("TOP", frame, "TOPLEFT", x0 + (b - 1) * (blockW + BLOCK_GAP) + ColX(k), -top)
                local key = k <= NCOLS and COLS[k].key or simple[k - NCOLS]
                local c = HeadColor(key, k)
                head.back:SetColorTexture(c[1], c[2], c[3], 0.3)
                head.bar:SetColorTexture(c[1], c[2], c[3], 1)
                -- (redessinée à chaque changement de configuration : nom d'un
                -- bouton...; sinon seulement quand sa colonne change)
                if force or head.glyph.key ~= key then head.glyph:SetKey(key) end
                head:Show()
            elseif head then
                head:Hide()
            end
        end
    end

    -- (la hauteur : toutes les lignes en petit, plus la place des lignes en
    -- grand (la couche utilisée sans rappel, celle qu'on modifie) : elle ne
    -- change pas quand l'une ou l'autre change, et la grille ne bouge pas sous
    -- la souris)
    local grow = (ROW_BIG - ROW_SMALL) * (recallOn and 1 or 2)
    local rowsH = per * ROW_SMALL + (per - 1) * ROW_GAP + grow
    local w = PAD * 2 + innerW
    local h = top + HEADER_H + rowsH + PAD
    frame:SetSize(w, h)
    holder:SetSize(w * scale, h * scale)
end

---------------------------------------------------------------------------
-- Les cases d'une ligne
---------------------------------------------------------------------------
local function FillRow(r, pu, live)
    local e, n = r.entry, NCOLS + #simple
    if e.special then
        for k = 1, n do
            local t = r.tiles[k]
            if k <= NCOLS then K.MirrorNative(t, K.Native(pu.activeBar, COLS[k].i)) else K.MirrorAction(t, nil) end
        end
        return
    end
    if e.bar then
        local bar = pu.actionBars and pu.actionBars[e.bar]
        local base = e.bar == ns.Bar.BASE_BAR
        for k, col in ipairs(COLS) do
            local own = base and ns.Bar.Override(col.i)
            if own then K.MirrorAction(r.tiles[k], own) else K.MirrorNative(r.tiles[k], K.Native(bar, col.i)) end
        end
        -- (les boutons simples : leur action seule, avec LT ou avec RT ; une
        -- couche vide ne fait rien, sauf une commande WoW seule, liée
        -- directement, qui part aussi avec LT / RT (estompée))
        local layer = K.CARD_SIMPLE_LAYER[e.bar]
        for j, sid in ipairs(simple) do
            local t = r.tiles[NCOLS + j]
            if layer then
                local actions = ns.ButtonActions(sid)
                local action = actions.layers[layer]
                local fallback = not action and layer ~= "base" and ns.Actions.IsCommand(actions.layers.base)
                    and ns.Simple.CommandAllowed(actions, "base")
                K.MirrorAction(t, action or (fallback and actions.layers.base or nil), fallback,
                    live and K.pressed[sid])
            else
                K.MirrorAction(t, nil)
            end
        end
        return
    end
    local combos = ns.ButtonActions(e.mod).combos
    for k, col in ipairs(COLS) do K.MirrorAction(r.tiles[k], combos[col.key]) end
    for j, sid in ipairs(simple) do
        K.MirrorAction(r.tiles[NCOLS + j], combos[sid], false, live and K.pressed[sid])
    end
end

---------------------------------------------------------------------------
-- Construction, affichage
---------------------------------------------------------------------------
function G.Build(parent)
    if frame then return end
    K = ns.Hud.Kit
    holder = parent
    unlocked = ns.Hud.IsUnlocked()
    frame = CreateFrame("Frame", nil, holder)
    frame:SetPoint("TOPLEFT", holder, "TOPLEFT", 0, 0)
    frame:SetSize(10, 10)
    back = frame:CreateTexture(nil, "BACKGROUND", nil, -1)
    back:SetAllPoints()
    back:SetColorTexture(0.02, 0.02, 0.02, 0.6)
    -- (au-dessus de la grille : le bouton à appuyer quand une couche est
    -- bloquée, à gauche ; les actions de classe de Forever, à droite)
    hint = UI.Text(frame, "GameFontNormal")
    hint:SetTextColor(1, 0.25, 0.2)
    hint:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", PAD, 6)
    hint:Hide()
    for i, side in ipairs({ { "PADLSHOULDER", "PADLTRIGGER" }, { "PADRSHOULDER", "PADRTRIGGER" } }) do
        local t = K.Tile(frame, 28)
        t.tag = K.Tag(frame, 16, "GameFontNormalSmall")
        K.SetTag(t.tag, side)
        t.tag:SetPoint("RIGHT", t, "LEFT", -3, 0)
        classTiles[i] = t
    end
    classTiles[2]:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -PAD, 4)
    classTiles[1]:SetPoint("RIGHT", classTiles[2].tag, "LEFT", -10, 0)
    frame:Hide()
end

function G.SetShown(on)
    if frame then frame:SetShown(on and true or false) end
end

-- La configuration a changé (couches, boutons simples, réglages de la grille)
function G.Relayout(s)
    if not frame then return end
    cols, scale, recallOn = s.gridCols, s.gridScale, s.gridRecall
    recallDetached, recallPos = s.gridRecallDetached, s.gridRecallPos
    frame:SetScale(scale)
    entries = ns.Hud.Layers()
    simple = {}
    for i, id in ipairs(ns.SimpleIDs()) do
        if i <= #ns.BUTTON_IDS + #ns.PAD_IDS then simple[i] = id end
    end
    -- (la couche modifiée n'existe plus : retour)
    if editing then
        local found = false
        for _, e in ipairs(entries) do
            if K.LayerKey(e) == editing then found = true end
        end
        if not found then editing = nil end
    end
    signature = nil
    Layout(nil, false, true)
end

-- HUD déverrouillé : le rappel séparé se glisse à la souris (bordé de doré)
function G.SetUnlocked(on)
    unlocked = on and true or false
    if not recall then return end
    recall:EnableMouse(unlocked and recallDetached)
    recall.outline:SetShown(unlocked and recallDetached)
end

-- Le coin bas-gauche du rappel affiché (pour le séparer sans qu'il bouge)
function G.RecallCorner()
    if recall and recall:IsVisible() then return recall:GetLeft(), recall:GetBottom() end
end

-- La souris est-elle sur le rappel séparé ? (les petits boutons du HUD)
function G.MouseOver()
    return recall ~= nil and recallDetached and recall:IsVisible() and recall:IsMouseOver() or false
end

function G.Editing() return editing ~= nil end

function G.StopEditing() editing = nil end

---------------------------------------------------------------------------
-- Mise à jour (20 fois par seconde, Hud.lua). st : la couche tenue (mod),
-- la barre active de Forever (activeName), quelque chose de tenu (any), la
-- couche bloquée (stuckBar, stuckPads, stuckText).
-- La ligne utilisée et celle modifiée suivent à chaque fois ; les autres,
-- une fois sur quatre (cinq fois par seconde : recharges, portée...)
---------------------------------------------------------------------------
function G.Update(pu, st)
    if not (frame and frame:IsShown()) then return end
    if editing and InCombatLockdown() then editing = nil end
    if dragRow and InCombatLockdown() then dragRow = nil end
    local special = st.mod == nil and st.activeName == nil
    local liveKey = st.mod and ("mod:" .. st.mod) or (st.activeName and ("bar:" .. st.activeName)) or "special"
    local sig = liveKey .. "|" .. tostring(editing)
    local full = false
    if sig ~= signature then
        signature = sig
        Layout(liveKey, special)
        full = true
    end
    tick = (tick + 1) % 4
    if tick == 0 then full = true end
    local dropOn = dragRow and RowUnderMouse()
    for _, r in ipairs(rows) do
        if not r:IsShown() then break end
        local e = r.entry
        local live = r.key == liveKey
        local isEdit = editing ~= nil and r.key == editing
        if full or live or isEdit then FillRow(r, pu, live) end
        local stuck = not e.special and K.IsStuckEntry(e, st.stuckBar, st.stuckPads)
        local c = isEdit and K.EDIT_EDGE or (stuck and K.STUCK_EDGE or (live and K.GOLD_EDGE or nil))
        -- (glisser en cours : la ligne tenue estompée, sa future place en bleu)
        if dropOn == r and r ~= dragRow then c = K.EDIT_EDGE end
        SetRowColor(r, c)
        local alpha = (live or isEdit or stuck) and 1 or (st.any and 0.5 or 0.85)
        if r == dragRow then alpha = 0.4 end
        r:SetAlpha(alpha)
    end

    -- Le rappel : la couche utilisée, à chaque fois ; doré, rouge si bloquée
    if recallOn and recall and recall:IsShown() then
        FillRow(recall, pu, true)
        local e = recall.entry
        local stuck = not e.special and K.IsStuckEntry(e, st.stuckBar, st.stuckPads)
        SetRowColor(recall, stuck and K.STUCK_EDGE or K.GOLD_EDGE)
    end

    -- Couche bloquée : le bouton à appuyer, avec un léger battement
    if st.stuckText then
        hint:SetText(st.stuckText)
        hint:SetAlpha(0.65 + 0.35 * math.abs(math.sin(GetTime() * 3)))
    end
    hint:SetShown(st.stuckText ~= nil)

    -- Actions de classe (LB + LT, RB + RT), quand Forever en montre une
    for i, native in ipairs({ pu.LeftClassAction, pu.RightClassAction }) do
        local t = classTiles[i]
        local on = native ~= nil and native.IsShown and native:IsShown() and true or false
        t:SetShown(on)
        t.tag:SetShown(on)
        if on then K.MirrorNative(t, native) end
    end
end
