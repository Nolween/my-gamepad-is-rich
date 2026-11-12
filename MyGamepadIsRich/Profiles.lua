-- Profils : une configuration complète par manette (la manette, ses boutons
-- et, pour chaque personnage, les actions). Un seul profil actif pour tout
-- le compte ; on en change à la main (WoW ne sait pas quelle manette est
-- branchée : toutes passent pour une manette Xbox).
--
--   MyGamepadIsRichDB.profile  = id du profil actif
--   MyGamepadIsRichDB.profiles = { [id] = { name, controller, buttons, pads, pairs } }
--   MyGamepadIsRichCharDB.profiles = { [id] = { actions, spec, specActions } }
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
-- (celles des paires seulement si elles existent : créées à la demande)
local function FillActions(actions)
    for _, id in ipairs(ns.LIST_IDS) do
        local a = actions[id]
        if type(a) ~= "table" and not ns.IsPair(id) then a = {} actions[id] = a end
        if type(a) == "table" then
            a.combos = a.combos or {}
            a.layers = a.layers or {}
            -- (appui long d'une version de test, retiré)
            a.holds = nil
        end
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

---------------------------------------------------------------------------
-- Spécialisations : chaque spé a ses actions, comme les barres du jeu.
-- c.actions reste le jeu d'actions utilisé (tout le reste de l'addon ne lit
-- que lui) ; c.spec dit à quelle spé il appartient, c.specActions garde
-- ceux des autres spés. Une spé jamais vue commence avec une copie des
-- actions de la précédente.
---------------------------------------------------------------------------
local function Number(fn)
    if type(fn) ~= "function" then return nil end
    local ok, n = pcall(fn)
    if ok and type(n) == "number" and n > 0 then return n end
end

-- La spé active : { key, index, talentGroup }, ou nil (pas de spés dans ce
-- jeu, ou pas encore connue au chargement)
local function CurrentSpec()
    local info = C_SpecializationInfo
    local spec = Number(info and info.GetSpecialization) or Number(GetSpecialization)
    if spec then return { key = "s" .. spec, index = spec } end
    -- (double spécialisation des versions Classic : le groupe de talents)
    local group = Number(info and info.GetActiveSpecGroup) or Number(GetActiveTalentGroup)
    if group then return { key = "g" .. group, group = group } end
end

function P.SpecName(spec)
    spec = spec or CurrentSpec()
    if not spec then return nil end
    if spec.index then
        local get = (C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo) or GetSpecializationInfo
        if get then
            local ok, _, name = pcall(get, spec.index)
            if ok and type(name) == "string" and name ~= "" then return name end
        end
        return L.SPEC_NUMBER:format(spec.index)
    end
    return L.SPEC_NUMBER:format(spec.group)
end

-- Range les actions en cours sous leur spé, et prend celles de la spé
-- active. Renvoie vrai si le jeu d'actions a changé (et vrai en second si la
-- spé est nouvelle : copie de la précédente).
local function SwapSpec(c, spec)
    if not spec then return false end
    if c.spec == nil then
        c.spec = spec.key
        return false
    end
    if c.spec == spec.key then return false end
    c.specActions = c.specActions or {}
    c.specActions[c.spec] = c.actions
    local saved = c.specActions[spec.key]
    c.specActions[spec.key] = nil
    c.actions = FillActions(saved or ns.DeepCopy(c.actions))
    c.spec = spec.key
    return true, saved == nil
end

-- Les actions de ce personnage pour un profil remplacées (import) : elles
-- vont à la spé active, celles des autres spés restent
local function SetCurrentActions(id, actions)
    local c = ns.char.profiles[id] or {}
    ns.char.profiles[id] = c
    local spec = CurrentSpec()
    if spec and c.spec and c.spec ~= spec.key and c.actions then
        c.specActions = c.specActions or {}
        c.specActions[c.spec] = c.actions
    end
    if c.specActions and spec then c.specActions[spec.key] = nil end
    c.actions = FillActions(actions)
    c.spec = spec and spec.key or c.spec
end

local function Select()
    ns.prof = ns.db.profiles[ns.db.profile]
    ns.cprof = CharProfile(ns.db.profile)
    -- (le dernier profil de ce personnage : repris à sa connexion si
    -- l'option « un profil par personnage » est cochée)
    ns.char.profile = ns.db.profile
    SwapSpec(ns.cprof, CurrentSpec())
end

-- Option : chaque personnage reprend, à sa connexion, le dernier profil
-- qu'il a utilisé (sinon : le profil utilisé en dernier sur le compte)
function P.PerCharacter()
    return ns.db.options.profilePerChar == true
end

function P.SetPerCharacter(on)
    ns.db.options.profilePerChar = on and true or nil
end

-- La spé a peut-être changé (connexion, changement de spé) : les actions de
-- la nouvelle sont appliquées. Hors combat (le jeu ne change pas de spé en
-- combat ; sinon, ns.Apply attend la fin du combat).
function P.SyncSpec()
    if not ns.cprof then return end
    local spec = CurrentSpec()
    local changed, fresh = SwapSpec(ns.cprof, spec)
    if not changed then return end
    ns.Apply(true)
    local name = P.SpecName(spec)
    ns.Print((fresh and L.SPEC_NEW or L.SPEC_SWITCHED):format(name))
end

---------------------------------------------------------------------------
-- Remplacer les actions de la spé active, avec une sauvegarde : /mgir undo
-- revient en arrière (une seule étape, pour la même spé). Sert à
-- /mgir reset, aux modèles de classe, à la copie depuis une autre spé et à
-- la copie / l'échange de couches.
---------------------------------------------------------------------------
local function Combat()
    if InCombatLockdown() then
        ns.Print(L.PROFILE_COMBAT)
        return true
    end
end

-- (les actions, elles : leur message)
local function ActionsCombat()
    if InCombatLockdown() then
        ns.Print(L.HUD_COMBAT)
        return true
    end
end
P.ActionsCombat = ActionsCombat

function P.Backup()
    if not ns.cprof then return end
    ns.cprof.backup = { spec = ns.cprof.spec, actions = ns.DeepCopy(ns.cprof.actions) }
end

function P.SetActions(actions)
    if not ns.cprof then return false end
    if ActionsCombat() then return false end
    P.Backup()
    ns.cprof.actions = FillActions(actions or {})
    ns.Apply(true)
    return true
end

-- Revient à la sauvegarde ; refaire /mgir undo annule l'annulation
function P.Undo()
    local c = ns.cprof
    if not c then return false end
    local saved = c.backup
    if not (saved and type(saved.actions) == "table") or saved.spec ~= c.spec then
        ns.Print(L.UNDO_NONE)
        return false
    end
    if ActionsCombat() then return false end
    c.backup = { spec = c.spec, actions = c.actions }
    c.actions = FillActions(saved.actions)
    ns.Apply(true)
    ns.Print(L.UNDO_DONE)
    return true
end

-- Le nombre d'actions posées (toutes couches)
function P.CountActions(actions)
    local n = 0
    for _, a in pairs(type(actions) == "table" and actions or {}) do
        if type(a) == "table" then
            for _ in pairs(a.combos or {}) do n = n + 1 end
            for _ in pairs(a.layers or {}) do n = n + 1 end
        end
    end
    return n
end

---------------------------------------------------------------------------
-- Modèles de classe : des jeux d'actions enregistrés pour tout le compte,
-- par classe, que les autres personnages de cette classe peuvent reprendre
-- (sans passer par l'export / import). Ni nom de personnage ni royaume.
--   MyGamepadIsRichDB.templates = { [CLASSE] = { [nom] = { actions, date } } }
---------------------------------------------------------------------------
local function ClassKey()
    local _, class = UnitClass("player")
    return class or "UNKNOWN"
end

function P.ClassName()
    local name = UnitClass("player")
    return name or "?"
end

local function ClassTemplates(create)
    if create then
        ns.db.templates = ns.db.templates or {}
        ns.db.templates[ClassKey()] = ns.db.templates[ClassKey()] or {}
    end
    return ns.db.templates and ns.db.templates[ClassKey()]
end

-- Les modèles de cette classe, triés par nom : { { name, count, date } }
function P.Templates()
    local out = {}
    for name, t in pairs(ClassTemplates(false) or {}) do
        if type(t) == "table" then
            out[#out + 1] = { name = name, count = P.CountActions(t.actions), date = t.date }
        end
    end
    table.sort(out, function(a, b) return a.name:lower() < b.name:lower() end)
    return out
end

-- Un nom de modèle propre (comme un nom de profil), ou nil
function P.CleanTemplateName(name)
    name = strtrim(tostring(name or "")):gsub("%c", ""):gsub("|", "")
    name = ns.Utf8Cut(name, P.NAME_MAX)
    return name ~= "" and name or nil
end

function P.HasTemplate(name)
    local list = ClassTemplates(false)
    return list ~= nil and list[name] ~= nil
end

-- Enregistre les actions de la spé active (remplace un modèle du même nom)
function P.SaveTemplate(name)
    name = P.CleanTemplateName(name)
    if not (name and ns.cprof) then return nil end
    ClassTemplates(true)[name] = {
        actions = ns.Serialize.PruneActions(ns.cprof.actions) or {},
        date = time(),
    }
    return name
end

function P.LoadTemplate(name)
    local t = (ClassTemplates(false) or {})[name]
    if type(t) ~= "table" then return false end
    return P.SetActions(ns.DeepCopy(t.actions or {}))
end

function P.DeleteTemplate(name)
    local list = ClassTemplates(false)
    if list then list[name] = nil end
end

-- Les autres spés de ce personnage déjà jouées avec ce profil :
-- { { key, name, count } }
function P.OtherSpecs()
    local out = {}
    local c = ns.cprof
    for key, actions in pairs(c and c.specActions or {}) do
        if key ~= c.spec and type(actions) == "table" then
            local index, group = key:match("^s(%d+)$"), key:match("^g(%d+)$")
            local spec = index and { index = tonumber(index) } or group and { group = tonumber(group) }
            if spec then
                out[#out + 1] = { key = key, name = P.SpecName(spec), count = P.CountActions(actions) }
            end
        end
    end
    table.sort(out, function(a, b) return a.key < b.key end)
    return out
end

function P.CopyFromSpec(key)
    local c = ns.cprof
    local actions = c and c.specActions and c.specActions[key]
    if type(actions) ~= "table" then return false end
    return P.SetActions(ns.DeepCopy(actions))
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

-- Les modes des boutons de base, les absents à leur mode par défaut
function P.FillPads(pads)
    local out = P.CleanPads(pads)
    for id, mode in pairs(ns.DEFAULT_PADS) do
        if out[id] == nil then out[id] = mode end
    end
    return out
end

-- Les paires choisies : { [id] = true }, ids connus seulement ; absentes
-- (profils et exports d'avant) : les paires par défaut
function P.CleanPairs(raw)
    local out = {}
    if type(raw) ~= "table" then
        for id in pairs(ns.DEFAULT_PAIRS) do out[id] = true end
        return out
    end
    for _, pair in ipairs(ns.ALL_PAIRS) do
        if raw[pair.id] == true then out[pair.id] = true end
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
        prof.pairs = P.CleanPairs(prof.pairs)
        -- (1.6 : les boutons restés au jeu passent une fois à leur mode par
        -- défaut — LT / RT modificateurs, LB / RB ciblage — car il n'y a plus
        -- de case « Jeu » ; leurs couches reprennent la barre du jeu,
        -- ns.CopyGameBars)
        if (tonumber(db.padDefaults) or 0) < 2 then
            prof.pads = P.FillPads(prof.pads)
        end
        if type(prof.name) ~= "string" or prof.name == "" then prof.name = L.PROFILE_DEFAULT end
    end
    db.padDefaults = 2
    if P.PerCharacter() and char.profile and db.profiles[char.profile] then db.profile = char.profile end
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
-- Changements (Combat : plus haut)
---------------------------------------------------------------------------
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
        pairs = P.CleanPairs(nil),
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
        pairs = P.CleanPairs(from.pairs),
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
    prof.pairs = P.CleanPairs(data.pairs)
    if opts.actions and data.actions then
        SetCurrentActions(id, ns.DeepCopy(data.actions))
    end
    if opts.hud and data.hud and ns.Hud then ns.Hud.ImportSettings(data.hud) end
    if id == ns.db.profile then
        Select()
        ns.Apply(true)
    end
    return id
end
