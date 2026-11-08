-- Cœur : données sauvegardées, application des bindings, file hors combat,
-- commandes slash.
local ADDON, ns = ...
local L = ns.L

MyGamepadIsRich = ns -- (accès global : raccourci clavier, débogage)

-- Les emplacements des boutons supplémentaires, dans l'ordre de l'interface.
-- Identifiants internes, fixes (données sauvegardées) : leurs noms affichés
-- viennent de la manette choisie (Controllers.lua), qui en utilise 2 à 6.
ns.BUTTON_IDS = { "L5", "R5", "L4", "R4", "EX1", "EX2" }

-- Les paires : deux modificateurs tenus ensemble = une couche de plus
ns.PAIRS = {
    { id = "L5R5", a = "L5", b = "R5" },
    { id = "L4R4", a = "L4", b = "R4" },
    { id = "EX1EX2", a = "EX1", b = "EX2" },
}

-- Les boutons de base de la manette (LT, RT, LB, RB) : chacun reste au jeu
-- (« game », par défaut) ou est donné à l'addon dans un mode de bouton
-- (modificateur, ciblage, bouton simple). Leurs paires (LT + RT, LB + RB)
-- sont à part de ns.PAIRS.
ns.PAD_IDS = { "LT", "RT", "LB", "RB" }
ns.PAD_KEY = { LT = "PADLTRIGGER", RT = "PADRTRIGGER", LB = "PADLSHOULDER", RB = "PADRSHOULDER" }
ns.TRIGGER_KEY = ns.PAD_KEY -- (ancien nom)
ns.PAD_PAIRS = {
    { id = "LTRT", a = "LT", b = "RT" },
    { id = "LBRB", a = "LB", b = "RB" },
}
ns.TRIGGER_PAIR = ns.PAD_PAIRS[1]
ns.TRIGGER_LAYERS = { LT = true, RT = true, LTRT = true, LB = true, RB = true, LBRB = true }
-- (la barre du jeu que la couche d'une gâchette remplace)
ns.TRIGGER_BAR = { LT = "leftBar", RT = "rightBar", LTRT = "bottomBar" }

-- Tout ce qui a des actions : les boutons, les paires, les boutons de base
-- et leurs paires, puis « BASE » (les cases de la couche « Seul » que
-- l'addon prend au jeu, Bar.lua)
ns.LIST_IDS = {}
for _, id in ipairs(ns.BUTTON_IDS) do ns.LIST_IDS[#ns.LIST_IDS + 1] = id end
for _, pair in ipairs(ns.PAIRS) do ns.LIST_IDS[#ns.LIST_IDS + 1] = pair.id end
for _, id in ipairs({ "LT", "RT", "LTRT", "LB", "RB", "LBRB", "BASE" }) do ns.LIST_IDS[#ns.LIST_IDS + 1] = id end

function ns.PairDef(id)
    for _, pair in ipairs(ns.PAD_PAIRS) do
        if pair.id == id then return pair end
    end
    for _, pair in ipairs(ns.PAIRS) do
        if pair.id == id then return pair end
    end
end

function ns.IsPair(id)
    return ns.PairDef(id) ~= nil
end

-- Les modes qui font d'un bouton un modificateur (une couche de 8
-- combinaisons) : modificateur, et les deux modes de ciblage
ns.MOD_MODES = { modifier = true, target_friend = true, target_enemy = true }

-- Les modes d'un bouton, dans l'ordre de l'interface, et leurs libellés ;
-- un bouton de base a « game » en plus (au jeu), à la place de « off »
ns.MODES = { "modifier", "target_friend", "target_enemy", "simple", "off" }
ns.PAD_MODES = { "game", "modifier", "target_friend", "target_enemy", "simple" }
local MODE_LABEL = {
    modifier = "MODE_MODIFIER", target_friend = "MODE_TARGET_FRIEND", target_enemy = "MODE_TARGET_ENEMY",
    simple = "MODE_SIMPLE", off = "MODE_OFF", game = "MODE_GAME",
}

-- Le mode d'un bouton de base dans le profil actif
function ns.PadMode(id)
    local pads = ns.prof and ns.prof.pads
    return pads and pads[id] or "game"
end

-- Un bouton de base est-il donné à l'addon ?
function ns.PadTaken(id)
    return ns.PadMode(id) ~= "game"
end

-- (ancien nom : LT / RT donnés à l'addon)
function ns.TriggersOn()
    return ns.PadTaken("LT") or ns.PadTaken("RT")
end

-- Une barre du jeu (LT, RT, LT + RT) remplacée : sa gâchette est à l'addon
-- (LT + RT : l'une ou l'autre, le jeu ne peut plus faire la paire)
function ns.GameBarReplaced(bar)
    if bar == "leftBar" then return ns.PadTaken("LT") end
    if bar == "rightBar" then return ns.PadTaken("RT") end
    if bar == "bottomBar" then return ns.PadTaken("LT") or ns.PadTaken("RT") end
    return false
end

function ns.ModeLabel(mode)
    return L[MODE_LABEL[mode] or "MODE_OFF"]
end

function ns.ModeDesc(mode)
    return L[(MODE_LABEL[mode] or "MODE_OFF") .. "_DESC"]
end

-- Un modificateur prêt : un bouton en mode modificateur (ou ciblage) avec
-- une touche, ou un bouton de base dans un de ces modes
local function ModReady(id)
    if ns.PAD_KEY[id] then return ns.MOD_MODES[ns.PadMode(id)] or false end
    local def = ns.prof and ns.prof.buttons[id]
    return def ~= nil and ns.MOD_MODES[def.mode] and def.key ~= nil or false
end

-- Une paire est utilisable si ses deux boutons sont des modificateurs avec une touche
function ns.PairReady(id)
    local pair = ns.PairDef(id)
    return pair ~= nil and ModReady(pair.a) and ModReady(pair.b)
end

-- Une couche de combinaisons utilisable : un modificateur, ou une paire prête
function ns.IsModLayer(id)
    if ns.IsPair(id) then return ns.PairReady(id) end
    return ModReady(id)
end

-- Les boutons de la manette combinés avec un modificateur
ns.PAD_KEYS = { "PAD1", "PAD2", "PAD3", "PAD4", "PADDUP", "PADDDOWN", "PADDLEFT", "PADDRIGHT" }

-- Les couches d'un bouton simple
ns.LAYERS = { "base", "lt", "rt" }

-- Les modes d'un profil neuf (pas de touche par défaut : en XInput le jeu
-- ne voit pas les palettes, la touche vient du logiciel de la manette et se
-- règle avec « Détecter »)
ns.DEFAULT_BUTTONS = {
    L5 = { mode = "modifier" },
    R5 = { mode = "modifier" },
    L4 = { mode = "simple" },
    R4 = { mode = "simple" },
    EX1 = { mode = "off" },
    EX2 = { mode = "off" },
}

function ns.Print(msg)
    print("|cff33ff99My Gamepad Is Rich|r : " .. tostring(msg))
end

-- Les max premiers octets d'un texte UTF-8, sans couper un caractère
-- (accent, idéogramme) en deux
function ns.Utf8Cut(s, max)
    if #s <= max then return s end
    s = s:sub(1, max)
    -- (le dernier caractère commencé : son octet de tête dit sa longueur)
    for i = #s, math.max(1, #s - 3), -1 do
        local b = s:byte(i)
        if b < 0x80 then return s end
        if b >= 0xC0 then
            local need = (b >= 0xF0 and 4) or (b >= 0xE0 and 3) or 2
            if #s - i + 1 < need then return s:sub(1, i - 1) end
            return s
        end
    end
    return s
end

-- Copie profonde (tables de données : chaînes, nombres, booléens, tables)
function ns.DeepCopy(t)
    if type(t) ~= "table" then return t end
    local out = {}
    for k, v in pairs(t) do out[k] = ns.DeepCopy(v) end
    return out
end

---------------------------------------------------------------------------
-- Données : le compte (MyGamepadIsRichDB) et le personnage
-- (MyGamepadIsRichCharDB). La manette, les boutons et les actions vivent
-- dans les profils (Profiles.lua) : ns.prof est le profil actif (compte),
-- ns.cprof ses actions pour ce personnage.
---------------------------------------------------------------------------
local function InitDB()
    MyGamepadIsRichDB = MyGamepadIsRichDB or {}
    MyGamepadIsRichCharDB = MyGamepadIsRichCharDB or {}
    local db, char = MyGamepadIsRichDB, MyGamepadIsRichCharDB
    db.options = db.options or {}
    ns.db, ns.char = db, char
    ns.Profiles.Init()
end

function ns.Button(id)
    return ns.prof.buttons[id]
end

function ns.ButtonActions(id)
    return ns.cprof.actions[id]
end

function ns.ButtonLabel(id)
    local pair = ns.PairDef(id)
    if pair then return ns.ButtonLabel(pair.a) .. " + " .. ns.ButtonLabel(pair.b) end
    if ns.TRIGGER_KEY[id] then return id end
    local b = ns.prof and ns.prof.buttons[id]
    if b and b.name and b.name ~= "" then return b.name end
    return ns.SlotName(id) or ns.SpareName(id)
end

-- Le bouton supplémentaire qui utilise une touche, ou nil
function ns.ButtonOfKey(key)
    if not key or not ns.prof then return nil end
    for _, id in ipairs(ns.BUTTON_IDS) do
        if ns.prof.buttons[id].key == key then return id end
    end
end

-- Nom lisible d'une touche ("F9", "A", "Palette 1"...)
local PAD_NAMES = {
    PAD1 = "A", PAD2 = "B", PAD3 = "X", PAD4 = "Y", PAD5 = "Pad5", PAD6 = "Pad6",
    PADLSHOULDER = "LB", PADRSHOULDER = "RB", PADLTRIGGER = "LT", PADRTRIGGER = "RT",
    PADLSTICK = "L3", PADRSTICK = "R3",
    PADBACK = "View", PADFORWARD = "Menu", PADSOCIAL = "Share", PADSYSTEM = "Xbox",
}
local DPAD_NAMES = { PADDUP = "DPAD_UP", PADDDOWN = "DPAD_DOWN", PADDLEFT = "DPAD_LEFT", PADDRIGHT = "DPAD_RIGHT" }

function ns.KeyLabel(key)
    if not key then return L.KEY_NONE end
    if PAD_NAMES[key] then return PAD_NAMES[key] end
    if DPAD_NAMES[key] then return L[DPAD_NAMES[key]] end
    local paddle = key:match("^PADPADDLE(%d)$")
    if paddle then return L.PADDLE:format(paddle) end
    if GetBindingText then
        local ok, text = pcall(GetBindingText, key)
        if ok and text and text ~= "" then return text end
    end
    return key
end

function ns.CVar(name)
    local get = (C_CVar and C_CVar.GetCVar) or GetCVar
    return get and get(name)
end

-- Les actions des boutons agissent à l'appui ou au relâchement, comme les
-- boutons d'action du jeu
function ns.UseKeyDown()
    return ns.CVar("ActionButtonUseKeyDown") ~= "0"
end

---------------------------------------------------------------------------
-- Application (hors combat seulement : règle de WoW)
---------------------------------------------------------------------------
local owner = CreateFrame("Frame", "MyGamepadIsRichBindingOwner")
ns.bindingOwner = owner
local pending = false
local listeners = {}
local lastTargetWarning -- (le dernier avertissement de ciblage donné)

function ns.OnApplied(fn) listeners[#listeners + 1] = fn end

function ns.Apply(quiet)
    if not ns.db then return end
    if InCombatLockdown() then
        if not pending and not quiet then ns.Print(L.APPLIED_AFTER_COMBAT) end
        pending = true
        for _, fn in ipairs(listeners) do pcall(fn, true) end
        return false
    end
    pending = false
    ClearOverrideBindings(owner)
    local onDown = ns.UseKeyDown()
    ns.Modifier.Begin()
    -- (les boutons simples ont une case dans chaque couche de modificateur)
    local simpleKeys = {}
    for _, id in ipairs(ns.SimpleIDs()) do
        simpleKeys[#simpleKeys + 1] = { id = id, key = ns.PAD_KEY[id] or ns.Button(id).key }
    end
    ns.Modifier.SetSimpleKeys(simpleKeys)
    for _, id in ipairs(ns.BUTTON_IDS) do
        local def = ns.prof.buttons[id]
        local actions = ns.cprof.actions[id]
        ns.Simple.Disable(id)
        if def.key and def.key ~= "" then
            if def.mode == "modifier" then
                ns.Modifier.Setup(owner, id, def, actions, onDown)
            elseif def.mode == "target_friend" or def.mode == "target_enemy" then
                ns.Modifier.SetupTargeting(owner, id, def, actions, onDown)
            elseif def.mode == "simple" then
                ns.Simple.Setup(owner, id, def, actions, onDown)
            end
        end
    end
    -- (les cases de « Seul » prises au jeu, les boutons de base, puis les
    -- paires : après tous les modificateurs)
    ns.Modifier.Base(onDown)
    local cut = ns.SyncEmulation()
    if cut then ns.Print(L.EMULATION_OFF:format(cut)) end
    ns.Modifier.Pads(owner, onDown)
    ns.Modifier.Finish(onDown)
    -- (plus de ciblage allié / ennemi : on le dit une fois, quand ça arrive)
    local warning = ns.TargetingWarning()
    if warning and warning ~= lastTargetWarning then ns.Print(warning) end
    lastTargetWarning = warning
    if ns.Focus then ns.Focus.Push() end
    for _, fn in ipairs(listeners) do pcall(fn, false) end
    return true
end

function ns.IsPending() return pending end

---------------------------------------------------------------------------
-- Boutons de base donnés à l'addon
---------------------------------------------------------------------------
-- Un bouton qui imite Maj / Ctrl / Alt (réglages GamePadEmulate* : LT = Maj
-- et LB = Ctrl chez Forever) n'envoie son propre appui que s'il est tapé
-- brièvement, et l'état Ctrl de LB déclenche le ciblage de Forever. Tant
-- qu'un tel bouton est donné à l'addon, son imitation est coupée ; elle est
-- remise quand il revient au jeu (ou par /mgir restore). Le réglage
-- d'origine est gardé dans MyGamepadIsRichDB.emulation.
local EMULATE_CVARS = { "GamePadEmulateShift", "GamePadEmulateCtrl", "GamePadEmulateAlt" }

local function SetCVarValue(name, value)
    local set = (C_CVar and C_CVar.SetCVar) or SetCVar
    if set then pcall(set, name, value) end
end

-- Renvoie le bouton de base dont l'imitation vient d'être coupée, ou nil
function ns.SyncEmulation()
    ns.db.emulation = ns.db.emulation or {}
    local saved, cut = ns.db.emulation, nil
    for _, cvar in ipairs(EMULATE_CVARS) do
        local current = ns.CVar(cvar)
        local original = saved[cvar] or current
        local pad
        for id, key in pairs(ns.PAD_KEY) do
            if key == original then pad = id end
        end
        if pad and ns.PadTaken(pad) then
            if current ~= "none" then
                saved[cvar] = original
                SetCVarValue(cvar, "none")
                cut = pad
            end
        elseif saved[cvar] then
            SetCVarValue(cvar, saved[cvar])
            saved[cvar] = nil
        end
    end
    return cut
end

-- /mgir restore : les boutons de base du profil rendus au jeu, et les
-- imitations de Maj / Ctrl / Alt remises (à faire avant de désactiver l'addon)
function ns.RestorePads()
    if InCombatLockdown() then ns.Print(L.APPLIED_AFTER_COMBAT) return end
    if ns.prof then ns.prof.pads = {} end
    for cvar, value in pairs(ns.db.emulation or {}) do SetCVarValue(cvar, value) end
    ns.db.emulation = {}
    ns.Apply(true)
    ns.Print(L.RESTORE_DONE)
end

-- Les couches de l'addon encore vides reprennent ce que la barre du jeu
-- avait sur LT, RT ou LT + RT (sorts, objets, macros de la liste)
local function CopyGameBar(layer)
    local bar = ns.TRIGGER_BAR[layer]
    if not (bar and ns.Bar and ns.Bar.Available()) then return 0 end
    local combos = ns.ButtonActions(layer).combos
    if next(combos) then return 0 end
    local copied = 0
    for i, key in ipairs(ns.Bar.PAD_KEYS) do
        local action = ns.Bar.Get(bar, i)
        if action and action.kind ~= "slot" then
            combos[key] = action
            copied = copied + 1
        end
    end
    return copied
end

-- Le mode d'un bouton de base (« game » : rendu au jeu)
function ns.SetPadMode(id, mode)
    if not (ns.prof and ns.PAD_KEY[id]) then return end
    ns.prof.pads = ns.prof.pads or {}
    ns.prof.pads[id] = (mode ~= "game") and mode or nil
    if ns.MOD_MODES[mode] then
        local copied = CopyGameBar(id)
        if ns.PairReady("LTRT") then copied = copied + CopyGameBar("LTRT") end
        if copied > 0 then ns.Print(L.TRIGGERS_COPIED:format(copied)) end
    end
    ns.Apply()
end

-- Reste-t-il un ciblage allié / ennemi ? LB / RB au jeu (le ciblage de
-- Forever), ou un bouton en mode ciblage (un supplémentaire avec sa touche,
-- ou un bouton de base)
function ns.TargetingCoverage()
    local friend = ns.PadMode("LB") == "game"
    local enemy = ns.PadMode("RB") == "game"
    for _, id in ipairs(ns.BUTTON_IDS) do
        local def = ns.Button(id)
        if def.key then
            if def.mode == "target_friend" then friend = true end
            if def.mode == "target_enemy" then enemy = true end
        end
    end
    for _, id in ipairs(ns.PAD_IDS) do
        local mode = ns.PadMode(id)
        if mode == "target_friend" then friend = true end
        if mode == "target_enemy" then enemy = true end
    end
    return friend, enemy
end

-- Le texte d'avertissement s'il manque un ciblage, sinon nil
function ns.TargetingWarning()
    local friend, enemy = ns.TargetingCoverage()
    if not friend and not enemy then return L.TARGET_MISSING_BOTH end
    if not friend then return L.TARGET_MISSING_FRIEND end
    if not enemy then return L.TARGET_MISSING_ENEMY end
end

-- Les boutons en bouton simple, dans l'ordre : les supplémentaires (avec une
-- touche), puis les boutons de base
function ns.SimpleIDs()
    local out = {}
    for _, id in ipairs(ns.BUTTON_IDS) do
        local def = ns.Button(id)
        if def.mode == "simple" and def.key then out[#out + 1] = id end
    end
    for _, id in ipairs(ns.PAD_IDS) do
        if ns.PadMode(id) == "simple" then out[#out + 1] = id end
    end
    return out
end

---------------------------------------------------------------------------
-- Événements
---------------------------------------------------------------------------
local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:RegisterEvent("CVAR_UPDATE")
events:RegisterEvent("UPDATE_MACROS")
events:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 == ADDON then InitDB() end
    elseif event == "PLAYER_LOGIN" then
        if not ns.db then InitDB() end
        ns.Apply(true)
        ns.Print(L.LOADED)
        if ns.UI and ns.UI.RegisterSettings then ns.UI.RegisterSettings() end
        if ns.MinimapButton then ns.MinimapButton.Init() end
        -- (premier lancement : le tutoriel, une fois l'écran de chargement passé)
        if C_Timer and ns.Tutorial then C_Timer.After(3, ns.Tutorial.MaybeShow) end
    elseif event == "PLAYER_REGEN_ENABLED" then
        if pending then ns.Apply(true) end
    elseif event == "CVAR_UPDATE" then
        if arg1 == "ActionButtonUseKeyDown" or arg1 == "ACTION_BUTTON_USE_KEY_DOWN" then ns.Apply(true) end
    elseif event == "UPDATE_MACROS" then
        if ns.db then ns.Apply(true) end
    end
end)

---------------------------------------------------------------------------
-- Commandes
---------------------------------------------------------------------------
function MyGamepadIsRich_Toggle(tab)
    if ns.UI and ns.UI.Toggle then ns.UI.Toggle(tab) end
end

_G.BINDING_HEADER_MYGAMEPADISRICH = "My Gamepad Is Rich"
_G.BINDING_NAME_MYGAMEPADISRICH_TOGGLE = L.OPEN_CONFIG

SLASH_MYGAMEPADISRICH1 = "/mgir"
SLASH_MYGAMEPADISRICH2 = "/gps" -- (ancien nom de la commande)
SlashCmdList.MYGAMEPADISRICH = function(msg)
    local raw = strtrim(msg or "")
    msg = raw:lower()
    local word, rest = msg:match("^(%S*)%s*(.-)$")
    if word == "profil" or word == "profile" then
        -- (/mgir profil <nom> : le nom tel que tapé, casse comprise)
        local name = raw:match("^%S+%s+(.+)$")
        if name then ns.Profiles.SwitchByName(name) else ns.UI.Show("profiles") end
    elseif msg == "profils" or msg == "profiles" then
        ns.UI.Show("profiles")
    elseif msg == "selftest" then
        ns.Serialize.SelfTest()
    elseif msg == "restore" then
        ns.RestorePads()
    elseif word == "hud" then
        ns.Hud.Command(rest)
    elseif msg == "minimap" then
        ns.MinimapButton.Toggle()
    elseif word == "probe" then
        -- (/mgir probe 5 : relevé dans 5 secondes)
        ns.Probe.Run(tonumber(rest))
    elseif msg == "tuto" or msg == "tutorial" or msg == "tutoriel" then
        ns.Tutorial.Open(1)
    elseif msg == "test" then
        ns.UI.Show("test")
    elseif msg == "reset" then
        if InCombatLockdown() then ns.Print(L.APPLIED_AFTER_COMBAT) return end
        for _, id in ipairs(ns.LIST_IDS) do
            ns.cprof.actions[id] = { combos = {}, layers = {} }
        end
        ns.Apply()
        ns.Print(L.RESET_DONE)
    elseif msg == "help" or msg == "?" then
        ns.Print(L.SLASH_HELP)
    else
        ns.UI.Toggle()
    end
end
