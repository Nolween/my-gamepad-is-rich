-- Cœur : données sauvegardées, application des bindings, file hors combat,
-- commandes slash.
local ADDON, ns = ...
local L = ns.L

MyGamepadIsRich = ns -- (accès global : raccourci clavier, débogage)

-- Les boutons supplémentaires gérés, dans l'ordre de l'interface
ns.BUTTON_IDS = { "L5", "R5", "L4", "R4", "EX1", "EX2" }

-- Les paires : deux modificateurs tenus ensemble = une couche de plus
ns.PAIRS = {
    { id = "L5R5", a = "L5", b = "R5" },
    { id = "L4R4", a = "L4", b = "R4" },
}

-- Tout ce qui a des actions : les boutons, puis les paires
ns.LIST_IDS = {}
for _, id in ipairs(ns.BUTTON_IDS) do ns.LIST_IDS[#ns.LIST_IDS + 1] = id end
for _, pair in ipairs(ns.PAIRS) do ns.LIST_IDS[#ns.LIST_IDS + 1] = pair.id end

function ns.PairDef(id)
    for _, pair in ipairs(ns.PAIRS) do
        if pair.id == id then return pair end
    end
end

function ns.IsPair(id)
    return ns.PairDef(id) ~= nil
end

-- Une paire est utilisable si ses deux boutons sont des modificateurs avec une touche
function ns.PairReady(id)
    local pair = ns.PairDef(id)
    if not (pair and ns.db) then return false end
    local a, b = ns.db.buttons[pair.a], ns.db.buttons[pair.b]
    return a.mode == "modifier" and a.key ~= nil and b.mode == "modifier" and b.key ~= nil
end

-- Une couche de combinaisons utilisable : un modificateur, ou une paire prête
function ns.IsModLayer(id)
    if ns.IsPair(id) then return ns.PairReady(id) end
    local def = ns.db and ns.db.buttons[id]
    return def ~= nil and def.mode == "modifier" and def.key ~= nil
end

-- Les boutons de la manette combinés avec un modificateur
ns.PAD_KEYS = { "PAD1", "PAD2", "PAD3", "PAD4", "PADDUP", "PADDDOWN", "PADDLEFT", "PADDRIGHT" }

-- Les couches d'un bouton simple
ns.LAYERS = { "base", "lt", "rt" }

local DEFAULT_BUTTONS = {
    L5 = { mode = "modifier" },
    R5 = { mode = "modifier" },
    -- (pas de touche par défaut : en XInput le jeu ne voit pas les palettes,
    -- la touche vient de GameSir Nexus et se règle avec « Détecter »)
    L4 = { mode = "simple" },
    R4 = { mode = "simple" },
    EX1 = { mode = "off" },
    EX2 = { mode = "off" },
}

local DEFAULT_NAMES = { L5 = "L5", R5 = "R5", L4 = "L4", R4 = "R4" }

function ns.Print(msg)
    print("|cff33ff99My Gamepad Is Rich|r : " .. tostring(msg))
end

---------------------------------------------------------------------------
-- Données
---------------------------------------------------------------------------
local function InitDB()
    MyGamepadIsRichDB = MyGamepadIsRichDB or {}
    local db = MyGamepadIsRichDB
    db.buttons = db.buttons or {}
    for _, id in ipairs(ns.BUTTON_IDS) do
        if not db.buttons[id] then
            local d = DEFAULT_BUTTONS[id]
            db.buttons[id] = { mode = d.mode, key = d.key }
        end
        -- (anciennes versions : PADPADDLE1/2 par défaut, jamais reçues par le
        -- jeu ; elles cachaient l'avertissement « touche non définie »)
        local b = db.buttons[id]
        if b.key and b.key:match("^PADPADDLE%d$") and not b.learned then
            b.key = nil
        end
    end
    db.options = db.options or {}

    MyGamepadIsRichCharDB = MyGamepadIsRichCharDB or {}
    local char = MyGamepadIsRichCharDB
    char.actions = char.actions or {}
    for _, id in ipairs(ns.LIST_IDS) do
        char.actions[id] = char.actions[id] or {}
        char.actions[id].combos = char.actions[id].combos or {}
        char.actions[id].layers = char.actions[id].layers or {}
    end
    ns.db, ns.char = db, char
end

function ns.Button(id)
    return ns.db.buttons[id]
end

function ns.ButtonActions(id)
    return ns.char.actions[id]
end

function ns.ButtonLabel(id)
    local pair = ns.PairDef(id)
    if pair then return ns.ButtonLabel(pair.a) .. " + " .. ns.ButtonLabel(pair.b) end
    local b = ns.db and ns.db.buttons[id]
    if b and b.name and b.name ~= "" then return b.name end
    if DEFAULT_NAMES[id] then return DEFAULT_NAMES[id] end
    local n = id:match("^EX(%d)$")
    return L.EXTRA .. " " .. ((tonumber(n) or 0) + 4)
end

-- Le bouton supplémentaire qui utilise une touche, ou nil
function ns.ButtonOfKey(key)
    if not key or not ns.db then return nil end
    for _, id in ipairs(ns.BUTTON_IDS) do
        if ns.db.buttons[id].key == key then return id end
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
    for _, id in ipairs(ns.BUTTON_IDS) do
        local def = ns.db.buttons[id]
        local actions = ns.char.actions[id]
        ns.Simple.Disable(id)
        if def.key and def.key ~= "" then
            if def.mode == "modifier" then
                ns.Modifier.Setup(owner, id, def, actions, onDown)
            elseif def.mode == "simple" then
                ns.Simple.Setup(owner, id, def, actions, onDown)
            end
        end
    end
    -- (les paires : après tous les modificateurs)
    ns.Modifier.Finish(onDown)
    if ns.Focus then ns.Focus.Push() end
    for _, fn in ipairs(listeners) do pcall(fn, false) end
    return true
end

function ns.IsPending() return pending end

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
    msg = strtrim((msg or ""):lower())
    local word, rest = msg:match("^(%S*)%s*(.-)$")
    if word == "hud" then
        ns.Hud.Command(rest)
    elseif msg == "minimap" then
        ns.MinimapButton.Toggle()
    elseif msg == "probe" then
        ns.Probe.Run()
    elseif msg == "tuto" or msg == "tutorial" or msg == "tutoriel" then
        ns.Tutorial.Open(1)
    elseif msg == "test" then
        ns.UI.Show("test")
    elseif msg == "reset" then
        if InCombatLockdown() then ns.Print(L.APPLIED_AFTER_COMBAT) return end
        for _, id in ipairs(ns.LIST_IDS) do
            ns.char.actions[id] = { combos = {}, layers = {} }
        end
        ns.Apply()
        ns.Print(L.RESET_DONE)
    elseif msg == "help" or msg == "?" then
        ns.Print(L.SLASH_HELP)
    else
        ns.UI.Toggle()
    end
end
