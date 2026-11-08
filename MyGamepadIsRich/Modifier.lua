-- Mode Modificateur : maintenir le bouton (sa touche, ex. F9) et appuyer sur
-- A/B/X/Y/croix lance l'action de la combinaison. Deux boutons d'une paire
-- (1 + 2, 3 + 4, 5 + 6) maintenus ensemble donnent une couche de plus.
--
-- Un aiguilleur sécurisé (SecureHandlerAttributeTemplate) possède les
-- liaisons de A/B/X/Y/croix. La touche de chaque modificateur est liée
-- (hors combat) à un petit gestionnaire sécurisé qui, à l'appui et au
-- relâchement, note dans l'aiguilleur « held-<bouton> » (son ordre
-- d'appui). Chaque changement d'attribut relance le code de l'aiguilleur
-- (environnement restreint de WoW, donc aussi en combat) : il choisit la
-- couche (la paire si les deux sont tenus, sinon le dernier pressé) et lie
-- A/B/X/Y/croix à ses boutons d'action, avec priorité sur la barre croisée
-- du jeu ; rien de tenu : il retire ces liaisons.
local _, ns = ...

local M = {}
ns.Modifier = M

local disp          -- l'aiguilleur
local handlers = {} -- [id] = gestionnaire de la touche d'un modificateur
local combos = {}   -- [couche .. touche] = bouton d'action
local written = {}  -- (attributs de couches posés au dernier Setup, à effacer)

-- (à chaque attribut changé : recalcul complet, idempotent)
-- Les gâchettes LT / RT données à l'addon passent aussi par ici, liées
-- seulement quand le jeu a le focus manette (les fenêtres de Forever gardent
-- leurs gâchettes) :
--   gâchette qui imite une touche (LT = Maj) : ses 8 combinaisons en accord
--     (« SHIFT-PAD1 »), « chord-* » ;
--   gâchette qui n'imite rien (RT) : sa touche va à son gestionnaire,
--     « hkey-* », et elle devient un modificateur comme les autres.
-- Une case vide d'une couche de gâchette ne fait rien (« swallow ») : sans
-- ça, l'action de la barre du jeu partirait.
local DISPATCH = [[
    self:ClearBindings()
    if not self:GetAttribute("gps-ingame") then return end
    local noop = self:GetAttribute("noop")
    for j = 1, self:GetAttribute("hcount") or 0 do
        local key, click = self:GetAttribute("hkey-" .. j), self:GetAttribute("hclick-" .. j)
        if key and click then self:SetBindingClick(true, key, click, "LeftButton") end
    end
    for j = 1, self:GetAttribute("chord-count") or 0 do
        local key = self:GetAttribute("chord-key-" .. j)
        local click = self:GetAttribute("chord-click-" .. j)
        local cmd = self:GetAttribute("chord-cmd-" .. j)
        if key and click then
            self:SetBindingClick(true, key, click, "LeftButton")
        elseif key and cmd then
            self:SetBinding(true, key, cmd)
        end
    end
    local best, bestOrder
    for j = 1, self:GetAttribute("count") or 0 do
        local id = self:GetAttribute("id" .. j)
        local o = id and self:GetAttribute("held-" .. id)
        if o and (not bestOrder or o > bestOrder) then
            best, bestOrder = id, o
        end
    end
    if not best then return end
    local layer = best
    local partner = self:GetAttribute("partner-" .. best)
    if partner and self:GetAttribute("held-" .. partner) then
        layer = self:GetAttribute("pairlayer-" .. best) or best
    end
    local swallow = noop and self:GetAttribute("swallow-" .. layer)
    for i = 1, 8 do
        local key = self:GetAttribute("key" .. i)
        local click = self:GetAttribute("click-" .. layer .. "-" .. i)
        local cmd = self:GetAttribute("cmd-" .. layer .. "-" .. i)
        if key and click then
            self:SetBindingClick(true, key, click, "LeftButton")
        elseif key and cmd then
            self:SetBinding(true, key, cmd)
        elseif key and swallow then
            self:SetBindingClick(true, key, noop, "LeftButton")
        end
    end
    -- (RT tenu par son gestionnaire, LT en accord : avec LT, c'est la paire)
    local extra = (layer == best) and self:GetAttribute("extra-" .. best)
    if extra then
        local prefix = self:GetAttribute("extraprefix-" .. best) or ""
        for i = 1, 8 do
            local key = self:GetAttribute("key" .. i)
            local click = self:GetAttribute("click-" .. extra .. "-" .. i)
            local cmd = self:GetAttribute("cmd-" .. extra .. "-" .. i)
            if key and click then
                self:SetBindingClick(true, prefix .. key, click, "LeftButton")
            elseif key and cmd then
                self:SetBinding(true, prefix .. key, cmd)
            elseif key and noop then
                self:SetBindingClick(true, prefix .. key, noop, "LeftButton")
            end
        end
    end
]]

-- (appui : noter l'ordre ; relâchement : effacer. La répétition
-- automatique d'une touche clavier maintenue ne change rien)
local ONCLICK = [[
    local disp = self:GetFrameRef("disp")
    local id = self:GetAttribute("gps-id")
    if not (disp and id) then return end
    if down then
        if not disp:GetAttribute("held-" .. id) then
            local o = (disp:GetAttribute("order") or 0) + 1
            disp:SetAttribute("order", o)
            disp:SetAttribute("held-" .. id, o)
        end
    else
        disp:SetAttribute("held-" .. id, nil)
    end
]]

-- (un bouton d'action reçoit les deux fronts ; il n'agit que sur celui
-- choisi, comme les boutons du jeu : ActionButtonUseKeyDown)
local EDGE = [[
    if not down ~= not self:GetAttribute("gps-down") then return false end
]]

-- Un bouton qui ne fait rien : les cases vides des couches de gâchette
local noop
local function Noop()
    if noop then return noop end
    noop = CreateFrame("Button", "MyGamepadIsRichNoop", UIParent, "SecureActionButtonTemplate")
    noop:SetSize(1, 1)
    noop:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -20, 20)
    noop:RegisterForClicks("AnyDown", "AnyUp")
    return noop
end

local function Dispatcher()
    if disp then return disp end
    disp = CreateFrame("Frame", "MyGamepadIsRichModDispatch", UIParent, "SecureHandlerAttributeTemplate")
    for i, key in ipairs(ns.PAD_KEYS) do disp:SetAttribute("key" .. i, key) end
    disp:SetAttribute("noop", Noop():GetName())
    disp:SetAttribute("gps-ingame", true)
    disp:SetAttribute("_onattributechanged", DISPATCH)
    return disp
end

-- Les modificateurs tenus, pour le HUD : le dernier pressé, ou sa paire
local held, order = {}, 0
local pairOf = {} -- [id] = paire active qui contient ce bouton

local function SetHeld(id, down)
    if down then
        if not held[id] then
            order = order + 1
            held[id] = order
        end
    else
        held[id] = nil
    end
end

local function Handler(id)
    local h = handlers[id]
    if h then return h end
    h = CreateFrame("Button", "MyGamepadIsRichMod" .. id, UIParent, "SecureHandlerClickTemplate")
    h:SetSize(1, 1)
    h:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -20, 20)
    h:RegisterForClicks("AnyDown", "AnyUp")
    h:SetAttribute("gps-id", id)
    SecureHandlerSetFrameRef(h, "disp", Dispatcher())
    h:SetAttribute("_onclick", ONCLICK)
    -- (pour le HUD ; un post-hook, sans effet sur le code sécurisé)
    h:HookScript("OnClick", function(_, _, down) SetHeld(id, down) end)
    handlers[id] = h
    return h
end

local function ComboButton(layer, key)
    local b = combos[layer .. key]
    if b then return b end
    b = CreateFrame("Button", "MyGamepadIsRich" .. layer .. "_" .. key, UIParent, "SecureActionButtonTemplate")
    b:SetSize(1, 1)
    b:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -20, 20)
    b:RegisterForClicks("AnyDown", "AnyUp")
    b:SetAttribute("type", "macro")
    SecureHandlerWrapScript(b, "OnClick", b, EDGE)
    combos[layer .. key] = b
    return b
end

local function Write(name, value)
    disp:SetAttribute(name, value)
    if value ~= nil then written[name] = true end
end

-- Les 8 combinaisons d'une couche (un bouton, ou une paire)
local function WriteLayer(layer, actions, onDown)
    for i, key in ipairs(ns.PAD_KEYS) do
        local action = actions.combos[key]
        if ns.Actions.IsCommand(action) then
            Write("cmd-" .. layer .. "-" .. i, action.command)
        elseif action then
            local macro, text = ns.Actions.Secure(action)
            if macro or text then
                local b = ComboButton(layer, key)
                b:SetAttribute("gps-down", onDown)
                b:SetAttribute("useOnKeyDown", onDown)
                b:SetAttribute("macro", macro)
                b:SetAttribute("macrotext", text)
                Write("click-" .. layer .. "-" .. i, b:GetName())
            end
        end
    end
end

---------------------------------------------------------------------------
-- Application (hors combat) : Begin, Setup pour chaque modificateur, Finish
---------------------------------------------------------------------------
local count = 0
local chordCount, hcount = 0, 0
local active = {}

function M.Begin()
    Dispatcher()
    for name in pairs(written) do disp:SetAttribute(name, nil) end
    wipe(written)
    for id in pairs(handlers) do disp:SetAttribute("held-" .. id, nil) end
    wipe(held)
    wipe(pairOf)
    wipe(active)
    count, chordCount, hcount = 0, 0, 0
    disp:SetAttribute("count", 0)
end

function M.Setup(owner, id, def, actions, onDown)
    local h = Handler(id)
    count = count + 1
    Write("id" .. count, id)
    disp:SetAttribute("count", count)
    WriteLayer(id, actions, onDown)
    active[id] = true
    SetOverrideBindingClick(owner, true, def.key, h:GetName(), "LeftButton")
end

-- Les paires dont les deux boutons sont des modificateurs
function M.Finish(onDown)
    for _, pair in ipairs(ns.PAIRS) do
        if active[pair.a] and active[pair.b] then
            Write("partner-" .. pair.a, pair.b)
            Write("partner-" .. pair.b, pair.a)
            Write("pairlayer-" .. pair.a, pair.id)
            Write("pairlayer-" .. pair.b, pair.id)
            WriteLayer(pair.id, ns.ButtonActions(pair.id), onDown)
            pairOf[pair.a], pairOf[pair.b] = pair.id, pair.id
        end
    end
end

---------------------------------------------------------------------------
-- Gâchettes LT / RT données à l'addon (couches LT, RT et LT + RT)
---------------------------------------------------------------------------
-- La touche qu'une gâchette imite (réglages GamePadEmulate* du jeu), ou nil
local EMULATE = { ALT = "GamePadEmulateAlt", CTRL = "GamePadEmulateCtrl", SHIFT = "GamePadEmulateShift" }
local function Emulated(button)
    for mod, cvar in pairs(EMULATE) do
        if ns.CVar(cvar) == button then return mod end
    end
end

-- Le préfixe d'une liaison, dans l'ordre du jeu : « ALT-CTRL-SHIFT- »
local function Prefix(a, b)
    local out = ""
    for _, mod in ipairs({ "ALT", "CTRL", "SHIFT" }) do
        if mod == a or mod == b then out = out .. mod .. "-" end
    end
    return out
end

-- Une couche en accord : ses cases liées à prefix .. bouton. Les vides ne
-- font rien (swallow), ou restent au jeu (pas de liaison).
local function WriteChord(layer, actions, prefix, onDown, swallow)
    for _, key in ipairs(ns.PAD_KEYS) do
        local action = actions.combos[key]
        local cmd, click
        if ns.Actions.IsCommand(action) then
            cmd = action.command
        else
            local macro, text
            if action then macro, text = ns.Actions.Secure(action) end
            if macro or text then
                local b = ComboButton(layer, key)
                b:SetAttribute("gps-down", onDown)
                b:SetAttribute("useOnKeyDown", onDown)
                b:SetAttribute("macro", macro)
                b:SetAttribute("macrotext", text)
                click = b:GetName()
            elseif swallow then
                click = Noop():GetName()
            end
        end
        if cmd or click then
            chordCount = chordCount + 1
            local n = chordCount
            Write("chord-key-" .. n, prefix .. key)
            if cmd then Write("chord-cmd-" .. n, cmd) else Write("chord-click-" .. n, click) end
        end
    end
    Write("chord-count", chordCount)
end

-- La couche « Seul » : les cases que l'addon prend au jeu (Bar.lua), liées
-- sans préfixe ; les autres restent au jeu
function M.Base(onDown)
    WriteChord("BASE", ns.ButtonActions("BASE"), "", onDown, false)
end

-- Une gâchette qui n'imite rien : un modificateur comme L5, dont la touche
-- n'est liée que quand le jeu a le focus manette
local function SetupTrigger(id, actions, onDown)
    local h = Handler(id)
    count = count + 1
    Write("id" .. count, id)
    disp:SetAttribute("count", count)
    WriteLayer(id, actions, onDown)
    Write("swallow-" .. id, true)
    active[id] = true
    hcount = hcount + 1
    Write("hkey-" .. hcount, ns.TRIGGER_KEY[id])
    Write("hclick-" .. hcount, h:GetName())
    Write("hcount", hcount)
end

function M.Triggers(owner, onDown)
    local mods = { LT = Emulated(ns.TRIGGER_KEY.LT), RT = Emulated(ns.TRIGGER_KEY.RT) }
    for _, id in ipairs({ "LT", "RT" }) do
        if mods[id] then
            WriteChord(id, ns.ButtonActions(id), mods[id] .. "-", onDown, true)
        else
            SetupTrigger(id, ns.ButtonActions(id), onDown)
        end
    end
    -- La paire LT + RT
    local pairID = ns.TRIGGER_PAIR.id
    local pairActions = ns.ButtonActions(pairID)
    if mods.LT and mods.RT then
        -- (les deux en accord : « CTRL-SHIFT-PAD1 »...)
        WriteChord(pairID, pairActions, Prefix(mods.LT, mods.RT), onDown, true)
    elseif not mods.LT and not mods.RT then
        -- (deux gestionnaires : une paire comme L5 + R5)
        Write("partner-LT", "RT")
        Write("partner-RT", "LT")
        Write("pairlayer-LT", pairID)
        Write("pairlayer-RT", pairID)
        WriteLayer(pairID, pairActions, onDown)
        Write("swallow-" .. pairID, true)
        pairOf.LT, pairOf.RT = pairID, pairID
    else
        -- (un gestionnaire, l'autre en accord : le gestionnaire tenu lie
        -- aussi les combinaisons en accord, vers la paire)
        local handler = mods.LT and "RT" or "LT"
        WriteLayer(pairID, pairActions, onDown)
        Write("extra-" .. handler, pairID)
        Write("extraprefix-" .. handler, (mods.LT or mods.RT) .. "-")
    end
end

-- (les liaisons appartiennent à l'aiguilleur et au propriétaire commun)
function M.Disable(id) end

-- Hors combat : le jeu a-t-il le focus manette ?
function M.SetInGame(inGame)
    if InCombatLockdown() then return end
    Dispatcher():SetAttribute("gps-ingame", inGame and true or false)
end

-- La couche tenue, pour le HUD : un bouton, ou sa paire si l'autre est tenu
function M.Held()
    local best, n
    for id, o in pairs(held) do
        if not n or o > n then best, n = id, o end
    end
    if not best then return nil end
    local pair = pairOf[best]
    local def = pair and ns.PairDef(pair)
    if def and held[def.a] and held[def.b] then return pair end
    return best
end
