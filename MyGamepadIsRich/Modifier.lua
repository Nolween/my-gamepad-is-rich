-- Mode Modificateur : maintenir le bouton (sa touche, ex. F9) et appuyer sur
-- A/B/X/Y/croix lance l'action de la combinaison. Deux boutons d'une paire
-- (L5 + R5, L4 + R4) maintenus ensemble donnent une couche de plus.
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
local DISPATCH = [[
    self:ClearBindings()
    if not self:GetAttribute("gps-ingame") then return end
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
    for i = 1, 8 do
        local key = self:GetAttribute("key" .. i)
        local click = self:GetAttribute("click-" .. layer .. "-" .. i)
        local cmd = self:GetAttribute("cmd-" .. layer .. "-" .. i)
        if key and click then
            self:SetBindingClick(true, key, click, "LeftButton")
        elseif key and cmd then
            self:SetBinding(true, key, cmd)
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

local function Dispatcher()
    if disp then return disp end
    disp = CreateFrame("Frame", "MyGamepadIsRichModDispatch", UIParent, "SecureHandlerAttributeTemplate")
    for i, key in ipairs(ns.PAD_KEYS) do disp:SetAttribute("key" .. i, key) end
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
local active = {}

function M.Begin()
    Dispatcher()
    for name in pairs(written) do disp:SetAttribute(name, nil) end
    wipe(written)
    for id in pairs(handlers) do disp:SetAttribute("held-" .. id, nil) end
    wipe(held)
    wipe(pairOf)
    wipe(active)
    count = 0
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
