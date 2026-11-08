-- Profils : une configuration complète par manette (la manette, ses boutons
-- et, pour chaque personnage, les actions). Un seul profil actif pour tout
-- le compte ; on en change à la main (WoW ne sait pas quelle manette est
-- branchée : toutes passent pour une manette Xbox).
--
--   MyGamepadIsRichDB.profile  = id du profil actif
--   MyGamepadIsRichDB.profiles = { [id] = { name, controller, buttons } }
--   MyGamepadIsRichCharDB.profiles = { [id] = { actions } }
--
-- Des identifiants, pas des noms : renommer ne touche pas aux données des
-- autres personnages (l'addon ne les voit pas). Le profil actif n'est
-- référencé qu'en mémoire (ns.prof, ns.cprof) : une table partagée dans les
-- SavedVariables serait écrite en double par le jeu.
local _, ns = ...
local L = ns.L

local P = {}
ns.Profiles = P

P.NAME_MAX = 32

local counter = 0
local function NewID()
    local id
    repeat
        counter = counter + 1
        id = ("p%d%03d"):format(time(), counter % 1000)
    until not ns.db.profiles[id]
    return id
end

-- Les 6 emplacements d'un profil, complétés et nettoyés
local function FillButtons(buttons)
    for _, id in ipairs(ns.BUTTON_IDS) do
        if type(buttons[id]) ~= "table" then
            buttons[id] = { mode = ns.DEFAULT_BUTTONS[id].mode }
        end
        -- (anciennes versions : PADPADDLE1/2 par défaut, jamais reçues par le
        -- jeu ; elles cachaient l'avertissement « touche non définie »)
        local b = buttons[id]
        if b.key and b.key:match("^PADPADDLE%d$") and not b.learned then b.key = nil end
    end
    return buttons
end

-- Les actions d'un profil pour ce personnage : toutes les couches présentes
local function FillActions(actions)
    for _, id in ipairs(ns.LIST_IDS) do
        local a = actions[id]
        if type(a) ~= "table" then a = {} actions[id] = a end
        a.combos = a.combos or {}
        a.layers = a.layers or {}
    end
    return actions
end

local function CharProfile(id)
    local c = ns.char.profiles[id]
    if not c then
        c = {}
        ns.char.profiles[id] = c
    end
    c.actions = FillActions(c.actions or {})
    return c
end

local function Select()
    ns.prof = ns.db.profiles[ns.db.profile]
    ns.cprof = CharProfile(ns.db.profile)
end

-- Les modes des boutons de base (LT, RT, LB, RB) : seulement les modes
-- connus, « game » (au jeu) n'étant pas noté
local PAD_MODE_OK = { modifier = true, target_friend = true, target_enemy = true, simple = true }
function P.CleanPads(pads)
    local out = {}
    if type(pads) == "table" then
        for _, id in ipairs(ns.PAD_IDS) do
            if PAD_MODE_OK[pads[id]] then out[id] = pads[id] end
        end
    end
    return out
end

---------------------------------------------------------------------------
-- Chargement : migration, profil par défaut, nettoyage
---------------------------------------------------------------------------
function P.Init()
    local db, char = ns.db, ns.char
    db.profiles = db.profiles or {}
    if not next(db.profiles) then
        -- (1.3 et avant : la manette et les boutons à la racine. Avant les
        -- manettes (1.2), l'addon ne gérait que la G7 Pro ; une première
        -- installation choisit sa manette dans le tutoriel)
        local controller = db.controller or (db.buttons and "gamesir_g7pro") or "other"
        local id = NewID()
        db.profiles[id] = {
            name = ns.ControllerName(ns.ControllerDef(controller)),
            controller = controller,
            buttons = db.buttons or {},
        }
        if db.buttons then db.legacyProfile = id end
        db.controller, db.buttons = nil, nil
        db.profile = id
    end
    for _, prof in pairs(db.profiles) do
        prof.controller = ns.ControllerDef(prof.controller).id
        prof.buttons = FillButtons(type(prof.buttons) == "table" and prof.buttons or {})
        -- (boutons de base : au jeu tant qu'on ne les donne pas à l'addon ;
        -- 1.5 : « triggers = modifier » donnait LT et RT en modificateurs)
        prof.pads = P.CleanPads(prof.pads)
        if prof.triggers == "modifier" then
            prof.pads.LT = prof.pads.LT or "modifier"
            prof.pads.RT = prof.pads.RT or "modifier"
        end
        prof.triggers = nil
        -- (1.6 : LB / RB passent une fois en ciblage allié / ennemi, s'ils
        -- étaient au jeu ; un « Jeu » choisi ensuite est gardé)
        if not db.padDefaults then
            for id, mode in pairs(ns.DEFAULT_PADS) do
                if prof.pads[id] == nil then prof.pads[id] = mode end
            end
        end
        if type(prof.name) ~= "string" or prof.name == "" then prof.name = L.PROFILE_DEFAULT end
    end
    db.padDefaults = 1
    if not db.profiles[db.profile] then db.profile = P.List()[1].id end

    char.profiles = char.profiles or {}
    -- (ce personnage n'est pas revenu depuis la 1.3 : ses actions vont au
    -- profil né de la migration, ou à défaut au profil actif)
    if char.actions then
        local target = (db.legacyProfile and db.profiles[db.legacyProfile]) and db.legacyProfile or db.profile
        if not char.profiles[target] then char.profiles[target] = { actions = char.actions } end
        char.actions = nil
    end
    -- (les actions des profils supprimés depuis un autre personnage)
    for id in pairs(char.profiles) do
        if not db.profiles[id] then char.profiles[id] = nil end
    end
    Select()
end

---------------------------------------------------------------------------
-- Lecture
---------------------------------------------------------------------------
-- Les profils, triés par nom : { { id, name, controller }, ... }
function P.List()
    local out = {}
    for id, prof in pairs(ns.db.profiles) do
        out[#out + 1] = { id = id, name = prof.name, controller = prof.controller }
    end
    table.sort(out, function(a, b)
        local x, y = a.name:lower(), b.name:lower()
        if x ~= y then return x < y end
        return a.id < b.id
    end)
    return out
end

function P.Count()
    local n = 0
    for _ in pairs(ns.db.profiles) do n = n + 1 end
    return n
end

function P.ActiveID() return ns.db.profile end

function P.Get(id) return ns.db.profiles[id] end

function P.Name(id)
    local prof = ns.db.profiles[id]
    return prof and prof.name
end

-- Le profil qui porte ce nom (sans tenir compte de la casse), ou nil
function P.FindByName(name)
    name = strtrim(name or ""):lower()
    for id, prof in pairs(ns.db.profiles) do
        if prof.name:lower() == name then return id end
    end
end

-- Un nom propre et unique : « Nom », sinon « Nom (2) », « Nom (3) »...
function P.UniqueName(name, exceptID)
    name = strtrim(tostring(name or ""))
    name = name:gsub("%c", ""):gsub("|", "")
    if name == "" then name = L.PROFILE_DEFAULT end
    name = ns.Utf8Cut(name, P.NAME_MAX)
    local function Taken(n)
        local id = P.FindByName(n)
        return id ~= nil and id ~= exceptID
    end
    if not Taken(name) then return name end
    local i = 2
    while true do
        local suffix = " (" .. i .. ")"
        local candidate = ns.Utf8Cut(name, P.NAME_MAX - #suffix) .. suffix
        if not Taken(candidate) then return candidate end
        i = i + 1
    end
end

---------------------------------------------------------------------------
-- Changements
---------------------------------------------------------------------------
local function Combat()
    if InCombatLockdown() then
        ns.Print(L.PROFILE_COMBAT)
        return true
    end
end

function P.Switch(id, quiet)
    if not ns.db.profiles[id] then return false end
    if id == ns.db.profile then return true end
    if Combat() then return false end
    ns.db.profile = id
    Select()
    ns.Apply(true)
    if not quiet then ns.Print(L.PROFILE_SWITCHED:format(ns.prof.name)) end
    return true
end

function P.SwitchByName(name)
    local id = P.FindByName(name)
    if not id then
        ns.Print(L.PROFILE_UNKNOWN:format(name))
        return false
    end
    return P.Switch(id)
end

-- Un profil neuf pour une manette (modes conseillés, pas de touche) ;
-- renvoie son id
function P.New(name, controllerID)
    local id = NewID()
    local prof = {
        name = P.UniqueName(name),
        controller = ns.ControllerDef(controllerID).id,
        buttons = FillButtons({}),
        pads = {},
    }
    ns.SuggestModes(prof)
    ns.db.profiles[id] = prof
    return id
end

-- Une copie : la manette, les boutons, et les actions de ce personnage (les
-- autres personnages ne sont pas lisibles d'ici) ; renvoie son id
function P.Copy(fromID, name)
    local from = ns.db.profiles[fromID]
    if not from then return nil end
    local id = NewID()
    ns.db.profiles[id] = {
        name = P.UniqueName(name),
        controller = from.controller,
        buttons = ns.DeepCopy(from.buttons),
        pads = P.CleanPads(from.pads),
    }
    local actions = ns.char.profiles[fromID] and ns.char.profiles[fromID].actions
    ns.char.profiles[id] = { actions = FillActions(ns.DeepCopy(actions or {})) }
    return id
end

function P.Rename(id, name)
    local prof = ns.db.profiles[id]
    if not prof then return false end
    prof.name = P.UniqueName(name, id)
    return true
end

-- Supprimer (jamais le dernier ; le profil actif : on passe d'abord à un autre)
function P.Delete(id)
    if not ns.db.profiles[id] then return false end
    if P.Count() <= 1 then
        ns.Print(L.PROFILE_LAST)
        return false
    end
    if id == ns.db.profile then
        if Combat() then return false end
        for _, entry in ipairs(P.List()) do
            if entry.id ~= id then
                P.Switch(entry.id)
                break
            end
        end
    end
    ns.db.profiles[id] = nil
    ns.char.profiles[id] = nil
    if ns.db.legacyProfile == id then ns.db.legacyProfile = nil end
    return true
end

-- Un import (données déjà nettoyées par ns.Serialize.Import) :
--   opts.target  : id du profil à remplacer, sinon un nouveau profil
--   opts.name    : nom du nouveau profil
--   opts.actions : prendre les actions (pour ce personnage)
--   opts.hud     : appliquer les réglages du HUD
-- Remplacer sans prendre les actions garde celles du profil remplacé.
-- Renvoie l'id du profil, ou nil.
function P.Import(data, opts)
    local id = opts.target
    if id and not ns.db.profiles[id] then return nil end
    if id == ns.db.profile and Combat() then return nil end
    if not id then
        id = NewID()
        ns.db.profiles[id] = { name = P.UniqueName(opts.name or data.name) }
    end
    local prof = ns.db.profiles[id]
    prof.controller = ns.ControllerDef(data.controller).id
    prof.buttons = FillButtons(ns.DeepCopy(data.buttons))
    prof.pads = P.CleanPads(data.pads)
    if opts.actions and data.actions then
        ns.char.profiles[id] = { actions = FillActions(ns.DeepCopy(data.actions)) }
    end
    if opts.hud and data.hud and ns.Hud then ns.Hud.ImportSettings(data.hud) end
    if id == ns.db.profile then
        Select()
        ns.Apply(true)
    end
    return id
end
