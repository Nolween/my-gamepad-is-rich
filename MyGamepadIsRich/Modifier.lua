-- Mode Modificateur : maintenir le bouton (sa touche, ex. F9) et appuyer sur
-- A/B/X/Y/croix lance l'action de la combinaison. Deux modificateurs d'une
-- paire choisie (L5 + R5, LT + RT, L5 + LT...) maintenus ensemble donnent
-- une couche de plus.
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
-- Liées seulement quand le jeu a le focus manette (les fenêtres de Forever
-- et le curseur gardent leurs boutons) :
--   « hkey-* » / « hcmd-* » : les touches des boutons de base donnés à
--     l'addon (LT, RT, LB, RB) et des boutons de ciblage, vers leur bouton
--     ou une commande ;
--   « chord-* » : les cases de « Seul » prises au jeu (Bar.lua).
-- Une case vide d'une couche de bouton de base ne fait rien (« swallow ») :
-- sans ça, l'action de la barre du jeu partirait.
local DISPATCH = [[
    self:ClearBindings()
    if not self:GetAttribute("gps-ingame") then return end
    -- (véhicule, barre de remplacement, combat de mascottes : tout reste au
    -- jeu ; « state-suspend » vient d'un pilote d'état, combat compris)
    if self:GetAttribute("state-suspend") == "1" then return end
    local noop = self:GetAttribute("noop")
    for j = 1, self:GetAttribute("hcount") or 0 do
        local key, click = self:GetAttribute("hkey-" .. j), self:GetAttribute("hclick-" .. j)
        -- (« giveback » : rendu à Forever pour un appui, voir Focus.lua)
        if key and click and not self:GetAttribute("giveback-" .. key) then
            self:SetBindingClick(true, key, click, "LeftButton")
        end
    end
    for j = 1, self:GetAttribute("hcmdcount") or 0 do
        local key, cmd = self:GetAttribute("hcmdkey-" .. j), self:GetAttribute("hcmd-" .. j)
        if key and cmd and not self:GetAttribute("giveback-" .. key) then self:SetBinding(true, key, cmd) end
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
    -- (une paire : le dernier pressé, avec le plus récent des autres boutons
    -- tenus qui forme une paire choisie avec lui)
    local layer, po = best, nil
    for j = 1, self:GetAttribute("count") or 0 do
        local id = self:GetAttribute("id" .. j)
        local o = id and id ~= best and self:GetAttribute("held-" .. id)
        if o and (not po or o > po) then
            local pl = self:GetAttribute("pair-" .. best .. "-" .. id)
            if pl then layer, po = pl, o end
        end
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
    -- (les boutons simples : leur case dans cette couche ; vide, le bouton
    -- ne fait rien tant que la couche est tenue)
    for j = 1, self:GetAttribute("skcount") or 0 do
        local sid, key = self:GetAttribute("skid-" .. j), self:GetAttribute("skkey-" .. j)
        local click = sid and self:GetAttribute("click-" .. layer .. "-" .. sid)
        local cmd = sid and self:GetAttribute("cmd-" .. layer .. "-" .. sid)
        if key and click then
            self:SetBindingClick(true, key, click, "LeftButton")
        elseif key and cmd then
            self:SetBinding(true, key, cmd)
        elseif key and noop then
            self:SetBindingClick(true, key, noop, "LeftButton")
        end
    end
]]

-- (appui : noter l'ordre ; relâchement : effacer. La répétition
-- automatique d'une touche clavier maintenue ne change rien)
-- Verrouillable (« gps-latch ») : un appui active la couche, le suivant la
-- quitte ; le relâchement ne compte pas.
local ONCLICK = [[
    local disp = self:GetFrameRef("disp")
    local id = self:GetAttribute("gps-id")
    if not (disp and id) then return end
    if self:GetAttribute("gps-latch") then
        -- (un appui compte une fois : la répétition d'une touche maintenue
        -- ne bascule pas à nouveau)
        if not down then
            self:SetAttribute("gps-isdown", nil)
            return
        end
        if self:GetAttribute("gps-isdown") then return end
        self:SetAttribute("gps-isdown", true)
        if disp:GetAttribute("held-" .. id) then
            disp:SetAttribute("held-" .. id, nil)
        else
            local o = (disp:GetAttribute("order") or 0) + 1
            disp:SetAttribute("order", o)
            disp:SetAttribute("held-" .. id, o)
        end
        return
    end
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
    -- (un raccourci est parti : un bouton de ciblage tenu ne reciblera pas
    -- au relâchement)
    local disp = self:GetFrameRef("disp")
    if disp and not disp:GetAttribute("comboused") then disp:SetAttribute("comboused", true) end
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

-- Pilote d'état : « 1 » dans un véhicule, avec une barre de remplacement ou
-- de possession, ou en combat de mascottes. Une condition que ce jeu ne
-- connaît pas ferait échouer tout le pilote : on garde la plus longue liste
-- qui s'enregistre.
local SUSPEND_CONDITIONS = {
    "[vehicleui][overridebar][possessbar][petbattle] 1; 0",
    "[vehicleui][overridebar][possessbar] 1; 0",
    "[vehicleui] 1; 0",
}

local function RegisterSuspend(frame)
    if not RegisterStateDriver then return end
    for _, cond in ipairs(SUSPEND_CONDITIONS) do
        local ok = pcall(RegisterStateDriver, frame, "suspend", cond)
        if ok then
            M.suspendCondition = cond
            return
        end
    end
end

local function Dispatcher()
    if disp then return disp end
    disp = CreateFrame("Frame", "MyGamepadIsRichModDispatch", UIParent, "SecureHandlerAttributeTemplate")
    for i, key in ipairs(ns.PAD_KEYS) do disp:SetAttribute("key" .. i, key) end
    disp:SetAttribute("noop", Noop():GetName())
    disp:SetAttribute("gps-ingame", true)
    disp:SetAttribute("_onattributechanged", DISPATCH)
    RegisterSuspend(disp)
    return disp
end

-- Les modificateurs tenus, pour le HUD : le dernier pressé, ou sa paire
local held, order = {}, 0
local pairOf = {} -- [a][b] = paire active de ces deux boutons

-- Le bouton de ciblage qui a allumé le ciblage du moteur (voir plus bas)
local engineOwner
local EngineTargeting -- (défini plus bas)

local function SetHeld(id, down)
    if ns.Diag then ns.Diag.Log((down and "appui " or "relâché ") .. id) end
    if down then
        if not held[id] then
            order = order + 1
            held[id] = order
        end
        -- (un autre bouton pressé pendant le ciblage : c'est une paire, le
        -- ciblage du moteur s'éteint — avec LT ou RT tenu, Forever ouvrirait
        -- son action de classe, LB + LT / RB + RT)
        if engineOwner and engineOwner ~= id then
            engineOwner = nil
            EngineTargeting(nil)
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
    -- (pour le HUD ; un post-hook, sans effet sur le code sécurisé.
    -- Verrouillable : comme le code sécurisé, l'appui bascule)
    h:HookScript("OnClick", function(self, _, down)
        if self.latch then
            if not down then
                self.isDown = nil
            elseif not self.isDown then
                self.isDown = true
                SetHeld(id, not held[id])
            end
        else
            SetHeld(id, down)
        end
    end)
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
    SecureHandlerSetFrameRef(b, "disp", Dispatcher())
    SecureHandlerWrapScript(b, "OnClick", b, EDGE)
    combos[layer .. key] = b
    return b
end

local function Write(name, value)
    disp:SetAttribute(name, value)
    if value ~= nil then written[name] = true end
end

-- Les 8 combinaisons d'une couche (un bouton, ou une paire)
-- Les boutons simples (id, touche), pour leurs cases dans les couches
local simpleKeys = {}

-- Une case d'une couche : « click-<couche>-<n> » (bouton) ou « cmd-... »
local function WriteSlot(layer, slot, buttonKey, action, onDown)
    if ns.Actions.IsCommand(action) then
        Write("cmd-" .. layer .. "-" .. slot, ns.Actions.CommandOf(action))
    elseif action then
        local macro, text = ns.Actions.Secure(action)
        if macro or text then
            local b = ComboButton(layer, buttonKey)
            b:SetAttribute("gps-down", onDown)
            b:SetAttribute("useOnKeyDown", onDown)
            b:SetAttribute("macro", macro)
            b:SetAttribute("macrotext", text)
            Write("click-" .. layer .. "-" .. slot, b:GetName())
        end
    end
end

-- Les 8 combinaisons d'une couche, et une case par bouton simple
local function WriteLayer(layer, actions, onDown)
    for i, key in ipairs(ns.PAD_KEYS) do
        WriteSlot(layer, i, key, actions.combos[key], onDown)
    end
    for _, s in ipairs(simpleKeys) do
        WriteSlot(layer, s.id, s.id, actions.combos[s.id], onDown)
    end
end

-- La liste des boutons simples : { { id, key }, ... } (après Begin)
function M.SetSimpleKeys(list)
    simpleKeys = list
    for j, s in ipairs(list) do
        Write("skid-" .. j, s.id)
        Write("skkey-" .. j, s.key)
    end
    Write("skcount", #list)
end

---------------------------------------------------------------------------
-- Application (hors combat) : Begin, Setup pour chaque modificateur, Finish
---------------------------------------------------------------------------
local count = 0
local chordCount, hcount, hcmdCount = 0, 0, 0
local active = {}

function M.Begin()
    Dispatcher()
    for name in pairs(written) do disp:SetAttribute(name, nil) end
    wipe(written)
    for id in pairs(handlers) do disp:SetAttribute("held-" .. id, nil) end
    wipe(held)
    if engineOwner then
        engineOwner = nil
        EngineTargeting(nil)
    end
    wipe(pairOf)
    wipe(active)
    count, chordCount, hcount, hcmdCount = 0, 0, 0, 0
    disp:SetAttribute("count", 0)
end

function M.Setup(owner, id, def, actions, onDown)
    local h = Handler(id)
    h.latch = def.latch == true
    h.isDown = nil
    h:SetAttribute("gps-latch", h.latch or nil)
    h:SetAttribute("gps-isdown", nil)
    count = count + 1
    Write("id" .. count, id)
    disp:SetAttribute("count", count)
    WriteLayer(id, actions, onDown)
    active[id] = true
    SetOverrideBindingClick(owner, true, def.key, h:GetName(), "LeftButton")
end

---------------------------------------------------------------------------
-- Boutons de ciblage (modes « Ciblage allié » / « Ciblage ennemi »), comme
-- LB / RB dans Forever (essai) :
--   appui     : le bouton est tenu (sa couche de 8 raccourcis, comme un
--               modificateur) et le ciblage du moteur s'allume
--               (C_GamepadTargeting : le stick droit vise au lieu de la
--               caméra) ;
--   relâché   : le ciblage du moteur s'éteint ; après un appui bref sans
--               raccourci, une macro sécurisée cible l'allié / l'ennemi le
--               plus proche (/targetfriend, /targetenemy). Après un appui
--               maintenu (visée au stick), la cible choisie reste.
-- Forever, lui, déclenche son ciblage sur l'état Ctrl que LB imite (un addon
-- ne peut pas l'imiter) : on appelle donc le moteur directement.
---------------------------------------------------------------------------
local TARGET_MACRO = { target_friend = "/targetfriend", target_enemy = "/targetenemy" }
-- (sans horloge dans le code sécurisé : on ne recible que si la cible
-- actuelle n'est pas déjà un allié / ennemi vivant)
local TARGET_MACRO_SAFE = {
    target_friend = "/targetfriend [@target,nohelp][@target,dead]",
    target_enemy = "/targetenemy [@target,noharm][@target,dead]",
}
-- (au-delà, l'appui est « maintenu » : visée au stick, pas de reciblage)
local TAP_SECONDS = 0.3

-- (appui : tenu, et l'heure de l'appui ; relâché : plus tenu, et l'action
-- — le ciblage du plus proche — part seulement après un appui bref sans
-- raccourci. Le bouton n'agit qu'au relâchement : useOnKeyDown = false)
local TARGET_CLICK = [[
    local disp = self:GetFrameRef("disp")
    local id = self:GetAttribute("gps-id")
    if not (disp and id) then return false end
    if down then
        if not disp:GetAttribute("held-" .. id) then
            local o = (disp:GetAttribute("order") or 0) + 1
            disp:SetAttribute("order", o)
            disp:SetAttribute("comboused", nil)
            disp:SetAttribute("held-" .. id, o)
            if self:GetAttribute("gps-tap") then self:SetAttribute("gps-since", GetTime()) end
        end
        -- (rien ne part à l'appui : le bouton n'agit qu'au relâchement)
        return
    end
    disp:SetAttribute("held-" .. id, nil)
    if disp:GetAttribute("comboused") then return false end
    -- (maintenu : la cible a été visée au stick, elle reste. Mesuré ici,
    -- ou par le témoin « maintenu » montré hors code sécurisé)
    local tap, since = self:GetAttribute("gps-tap"), self:GetAttribute("gps-since")
    if tap and since and GetTime() - since > tap then return false end
    local flag = self:GetAttribute("gps-useflag") and self:GetFrameRef("gps-flag")
    if flag and flag:IsShown() then return false end
]]

-- Sans horloge dans le code sécurisé : un témoin « maintenu », un petit cadre
-- ordinaire montré hors code sécurisé quand l'appui dure (permis en combat :
-- il n'est pas protégé), que le code sécurisé lit au relâchement
local aimFlag
local function AimFlag()
    if not aimFlag then
        aimFlag = CreateFrame("Frame", nil, UIParent)
        aimFlag:SetSize(1, 1)
        aimFlag:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -20, 20)
        aimFlag:Hide()
    end
    return aimFlag
end

-- Le code sécurisé a-t-il une horloge (GetTime) ? Vérifié une fois, hors
-- combat (en combat avant la première vérification : nil)
local secureClock
local function SecureClock()
    if secureClock == nil and not InCombatLockdown() then
        local probe = CreateFrame("Frame", nil, UIParent, "SecureHandlerBaseTemplate")
        local ok = pcall(SecureHandlerExecute, probe,
            [[self:SetAttribute("gps-clock", GetTime and GetTime() and true or nil)]])
        secureClock = ok and probe:GetAttribute("gps-clock") == true
    end
    return secureClock
end
M.SecureClock = SecureClock

-- Le code sécurisé voit-il le témoin montré / caché ? Vérifié une fois, hors
-- combat, dans les deux états (en combat avant la vérification : nil)
local flagWorks
local function FlagWorks()
    if flagWorks == nil and not InCombatLockdown() then
        local probe = CreateFrame("Frame", nil, UIParent, "SecureHandlerBaseTemplate")
        local flag = AimFlag()
        local function Read()
            probe:SetAttribute("gps-shown", nil)
            local ok = pcall(SecureHandlerExecute, probe, [[
                local f = self:GetFrameRef("flag")
                self:SetAttribute("gps-shown", f and (f:IsShown() and 1 or 0) or nil)
            ]])
            return ok and probe:GetAttribute("gps-shown")
        end
        local ok = pcall(SecureHandlerSetFrameRef, probe, "flag", flag)
        flag:Show()
        local shown = ok and Read()
        flag:Hide()
        local hidden = ok and Read()
        flagWorks = shown == 1 and hidden == 0
    end
    return flagWorks
end

-- Comment un appui bref est reconnu : "clock" (horloge du code sécurisé),
-- "flag" (témoin), "safe" (aucun : reciblage seulement sans cible valide),
-- ou nil (pas encore vérifié, en combat)
function M.TapMode()
    local clock = SecureClock()
    if clock then return "clock" end
    local flag = FlagWorks()
    if flag then return "flag" end
    if clock == nil or flag == nil then return nil end
    return "safe"
end

-- La valeur de filtre du moteur pour un ciblage (énumération du jeu si on la
-- trouve ; sinon 1 = allié, relevé quand LB est tenu, et 2 = ennemi)
local filterCache = {}
local function TargetFilter(mode)
    if filterCache[mode] ~= nil then return filterCache[mode] end
    local found
    for name, t in pairs(Enum or {}) do
        if type(name) == "string" and name:find("Target") and type(t) == "table" then
            for k, v in pairs(t) do
                if type(k) == "string" and type(v) == "number" then
                    if mode == "target_friend" and (k:find("Friend") or k:find("Ally")) then found = found or v end
                    if mode == "target_enemy" and (k:find("Hostile") or k:find("Enemy")) then found = found or v end
                end
            end
        end
    end
    filterCache[mode] = found or (mode == "target_friend" and 1 or 2)
    return filterCache[mode]
end

-- (hors code sécurisé : allume / éteint le ciblage du moteur)
function EngineTargeting(mode)
    local api = C_GamepadTargeting
    if type(api) ~= "table" then return end
    if mode then
        if api.SetFilter then pcall(api.SetFilter, TargetFilter(mode)) end
        if api.Enable then pcall(api.Enable) end
    elseif api.Disable then
        pcall(api.Disable)
    end
end

local targeters = {}
local function Targeter(id)
    local b = targeters[id]
    if b then return b end
    b = CreateFrame("Button", "MyGamepadIsRichTarget" .. id, UIParent, "SecureActionButtonTemplate")
    b:SetSize(1, 1)
    b:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -20, 20)
    b:RegisterForClicks("AnyDown", "AnyUp")
    b:SetAttribute("type", "macro")
    -- (l'action part au relâchement : le script l'arrête à l'appui)
    b:SetAttribute("useOnKeyDown", false)
    b:SetAttribute("gps-id", id)
    SecureHandlerSetFrameRef(b, "disp", Dispatcher())
    SecureHandlerWrapScript(b, "OnClick", b, TARGET_CLICK)
    -- (le ciblage du moteur — viser au stick droit — seulement quand ce
    -- bouton est le seul tenu : avec un autre, c'est une paire. Forever
    -- ouvre son action de classe si le ciblage s'allume pendant que LT ou
    -- RT est tenu)
    -- (témoin « maintenu » : caché à l'appui, montré si l'appui dure plus de
    -- TAP_SECONDS, caché au relâchement — après la lecture sécurisée)
    local press = 0
    b:HookScript("OnClick", function(self, _, down)
        if down and not held[id] and self.useFlag then
            press = press + 1
            local mine = press
            AimFlag():Hide()
            C_Timer.After(TAP_SECONDS, function()
                if press == mine and held[id] then AimFlag():Show() end
            end)
        elseif not down and self.useFlag then
            press = press + 1
            AimFlag():Hide()
        end
        if down then
            local alone = true
            for other in pairs(held) do
                if other ~= id then alone = false end
            end
            SetHeld(id, true)
            if alone then
                engineOwner = id
                EngineTargeting(self.targetMode)
            end
        else
            SetHeld(id, false)
            if engineOwner == id then
                engineOwner = nil
                EngineTargeting(nil)
            end
        end
    end)
    targeters[id] = b
    return b
end

function M.SetupTargeting(owner, id, def, actions, onDown)
    local b = Targeter(id)
    b.targetMode = def.mode
    -- (appui bref reconnu : l'allié / ennemi suivant à chaque appui ; sinon
    -- reciblage seulement sans cible valide)
    local mode = M.TapMode()
    b.useFlag = mode == "flag"
    if b.useFlag then SecureHandlerSetFrameRef(b, "gps-flag", AimFlag()) end
    b:SetAttribute("gps-useflag", b.useFlag or nil)
    b:SetAttribute("gps-tap", mode == "clock" and TAP_SECONDS or nil)
    b:SetAttribute("gps-since", nil)
    b:SetAttribute("macrotext", ((mode == "clock" or mode == "flag") and TARGET_MACRO or TARGET_MACRO_SAFE)[def.mode])
    count = count + 1
    Write("id" .. count, id)
    disp:SetAttribute("count", count)
    WriteLayer(id, actions, onDown)
    active[id] = true
    -- (la touche va au bouton de ciblage, quand le jeu a le focus manette)
    hcount = hcount + 1
    Write("hkey-" .. hcount, def.key)
    Write("hclick-" .. hcount, b:GetName())
    Write("hcount", hcount)
end

-- Les paires choisies dont les deux boutons sont des modificateurs
-- (n'importe lesquels : L5 + R5, LT + RT, L5 + LT, LB + RT...)
function M.Finish(onDown)
    for _, pair in ipairs(ns.ALL_PAIRS) do
        local a, b = pair.a, pair.b
        if active[a] and active[b] and ns.PairEnabled(pair.id) then
            Write("pair-" .. a .. "-" .. b, pair.id)
            Write("pair-" .. b .. "-" .. a, pair.id)
            WriteLayer(pair.id, ns.ButtonActions(pair.id), onDown)
            -- (avec un bouton de base : ses cases vides ne font rien, comme
            -- la couche du bouton de base)
            if ns.PAD_KEY[a] or ns.PAD_KEY[b] then Write("swallow-" .. pair.id, true) end
            pairOf[a] = pairOf[a] or {}
            pairOf[b] = pairOf[b] or {}
            pairOf[a][b], pairOf[b][a] = pair.id, pair.id
        end
    end
end

-- Une couche en accord : ses cases liées à prefix .. bouton. Les vides ne
-- font rien (swallow), ou restent au jeu (pas de liaison).
local function WriteChord(layer, actions, prefix, onDown, swallow)
    for _, key in ipairs(ns.PAD_KEYS) do
        local action = actions.combos[key]
        local cmd, click
        if ns.Actions.IsCommand(action) then
            cmd = ns.Actions.CommandOf(action)
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

---------------------------------------------------------------------------
-- Boutons de base (LT, RT, LB, RB) donnés à l'addon : leur touche n'est
-- liée que quand le jeu a le focus manette (les fenêtres de Forever et le
-- curseur gardent leurs gâchettes et LB / RB). Leur imitation de Maj / Ctrl
-- est coupée par Core.lua (ns.SyncEmulation) : ce sont des boutons ordinaires.
---------------------------------------------------------------------------
-- (une touche vers un bouton, ou vers une commande WoW, liée par l'aiguilleur)
local function GateClick(key, name)
    hcount = hcount + 1
    Write("hkey-" .. hcount, key)
    Write("hclick-" .. hcount, name)
    Write("hcount", hcount)
end

local function GateCommand(key, command)
    hcmdCount = hcmdCount + 1
    Write("hcmdkey-" .. hcmdCount, key)
    Write("hcmd-" .. hcmdCount, command)
    Write("hcmdcount", hcmdCount)
end

-- Un modificateur comme L5 ; ses cases vides ne font rien
local function SetupPadModifier(id, actions, onDown)
    local h = Handler(id)
    count = count + 1
    Write("id" .. count, id)
    disp:SetAttribute("count", count)
    WriteLayer(id, actions, onDown)
    Write("swallow-" .. id, true)
    active[id] = true
    GateClick(ns.PAD_KEY[id], h:GetName())
end

function M.Pads(owner, onDown)
    for _, id in ipairs(ns.PAD_IDS) do
        local mode = ns.PadMode(id)
        local actions = ns.ButtonActions(id)
        if mode == "modifier" then
            SetupPadModifier(id, actions, onDown)
        elseif mode == "target_friend" or mode == "target_enemy" then
            M.SetupTargeting(owner, id, { key = ns.PAD_KEY[id], mode = mode }, actions, onDown)
            Write("swallow-" .. id, true)
        elseif mode == "simple" then
            local click, command = ns.Simple.Prepare(id, actions, onDown)
            if click then
                GateClick(ns.PAD_KEY[id], click)
            elseif command then
                GateCommand(ns.PAD_KEY[id], command)
            end
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

function M.InGameAttribute()
    return disp and disp:GetAttribute("gps-ingame")
end

-- Véhicule, barre de remplacement, combat de mascottes : l'addon s'efface
function M.Suspended()
    return disp ~= nil and disp:GetAttribute("state-suspend") == "1"
end

-- Un bouton noté tenu (par l'aiguilleur sécurisé, ou pour le HUD)
function M.IsHeld(id)
    return held[id] ~= nil or (disp ~= nil and disp:GetAttribute("held-" .. id) ~= nil)
end

-- Hors combat : un bouton noté tenu alors qu'il est relâché (son
-- relâchement est parti ailleurs) redevient relâché
function M.Release(id)
    if InCombatLockdown() or not disp then return end
    held[id] = nil
    if disp:GetAttribute("held-" .. id) ~= nil then disp:SetAttribute("held-" .. id, nil) end
    if engineOwner == id then
        engineOwner = nil
        EngineTargeting(nil)
    end
end

-- Les boutons notés tenus : { [id] = "hud" / "secure" / "both" }
function M.HeldState()
    local out = {}
    for id in pairs(held) do out[id] = "hud" end
    if disp then
        for j = 1, disp:GetAttribute("count") or 0 do
            local id = disp:GetAttribute("id" .. j)
            if id and disp:GetAttribute("held-" .. id) ~= nil then
                out[id] = out[id] and "both" or "secure"
            end
        end
    end
    return out
end

-- La couche tenue, pour le HUD : un bouton, ou sa paire si l'autre est tenu
function M.Held()
    local best, n
    for id, o in pairs(held) do
        if not n or o > n then best, n = id, o end
    end
    if not best then return nil end
    -- (comme l'aiguilleur : la paire avec le plus récent des autres tenus)
    local layer, po = best, nil
    for id, o in pairs(held) do
        local pair = id ~= best and pairOf[best] and pairOf[best][id]
        if pair and (not po or o > po) then layer, po = pair, o end
    end
    return layer
end

-- Hors combat : rendre (on) ou reprendre des boutons de base à Forever, le
-- temps qu'il reçoive un appui complet (il était resté sur leur barre)
function M.GiveBack(ids, on)
    if InCombatLockdown() then return end
    local d = Dispatcher()
    for _, id in ipairs(ids) do
        local key = ns.PAD_KEY[id]
        if key then d:SetAttribute("giveback-" .. key, on and true or nil) end
    end
end
