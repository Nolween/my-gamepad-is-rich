-- Manettes : un préréglage par modèle connu. Il donne un nom aux boutons
-- supplémentaires, dit combien la manette en a et quel logiciel leur fait
-- envoyer une touche clavier (seul moyen pour WoW de les voir, voir README).
--
-- Les emplacements internes (ns.BUTTON_IDS : L5, R5, L4, R4, EX1, EX2) ne
-- changent jamais, pour garder les données sauvegardées : une manette à N
-- boutons nomme les N premiers (le tutoriel ne montre qu'eux) ; les autres
-- restent des emplacements libres (« Bouton 5 »...), utilisables comme
-- avant. Les emplacements 1 + 2, 3 + 4 et 5 + 6 forment les paires.
local _, ns = ...
local L = ns.L

-- names    : noms des boutons, dans l'ordre des emplacements (gauche puis
--            droite, du plus facile à maintenir au moins facile) ;
--            renommables dans l'onglet Boutons
-- software : logiciel de la marque qui configure les boutons (nil : on ne
--            le connaît pas, le tutoriel dit « le logiciel de ta manette »)
-- keys     : on sait que ce logiciel donne une touche clavier aux boutons
--            (sinon le tutoriel propose Steam Input / reWASD en repli)
-- steam    : pas de logiciel de la marque sur PC : Steam Input directement
ns.CONTROLLERS = {
    { id = "gamesir_g7pro", name = "GameSir G7 Pro", software = "GameSir Nexus", keys = true,
        names = { "L5", "R5", "L4", "R4" } },
    { id = "gamesir", name = "GameSir (G7 SE, Cyclone 2, Kaleid...)", software = "GameSir Nexus",
        names = { "L4", "R4" } },
    -- (P3 / P1 : palettes du haut ; P4 / P2 : du bas)
    { id = "xbox_elite", name = "Xbox Elite Series 2 / Core", software = "Xbox Accessories",
        names = { "P3", "P1", "P4", "P2" } },
    { id = "dualsense_edge", name = "PlayStation DualSense Edge", steam = true,
        names = { "LP", "RP" } },
    { id = "steam", name = "Steam Controller / Steam Deck", software = "Steam Input", keys = true, steam = true,
        names = { "L4", "R4", "L5", "R5" } },
    { id = "scuf_envision", name = "SCUF Envision Pro", software = "iCUE",
        names = { "P1", "P2", "P3", "P4", "G1", "G2" } },
    { id = "razer_wolverine", name = "Razer Wolverine V3 Pro / V2 Pro",
        names = { "M1", "M2", "M3", "M4", "M5", "M6" } },
    { id = "8bitdo_ultimate", name = "8BitDo Ultimate 2", software = "8BitDo Ultimate Software",
        names = { "L4", "R4", "PL", "PR" } },
    { id = "flydigi", name = "Flydigi Vader 4 Pro / Apex 4", software = "Flydigi Space Station",
        names = { "M1", "M2", "M3", "M4", "C", "Z" } },
    { id = "victrix_bfg", name = "Victrix Pro BFG", software = "Victrix Control Hub",
        names = { "P1", "P2", "P3", "P4" } },
    { id = "nacon_rev5", name = "Nacon Revolution 5 Pro",
        names = { "P1", "P2", "P3", "P4" } },
    { id = "turtlebeach_ultra", name = "Turtle Beach Stealth Ultra",
        names = { "P1", "P2", "P3", "P4" } },
    -- (toujours en dernier : toute autre manette, les 6 emplacements)
    { id = "other", names = { "E1", "E2", "E3", "E4", "E5", "E6" } },
}

local byID = {}
for _, def in ipairs(ns.CONTROLLERS) do byID[def.id] = def end
local OTHER = byID.other

-- Préréglage d'une manette (une manette inconnue : « Autre manette »)
function ns.ControllerDef(id)
    return byID[id] or OTHER
end

-- La manette choisie
function ns.Controller()
    return ns.ControllerDef(ns.db and ns.db.controller)
end

function ns.ControllerName(def)
    return def.name or L.CONTROLLER_OTHER
end

-- Les emplacements que la manette nomme (ses boutons), dans l'ordre
function ns.ActiveIDs()
    local out, n = {}, #ns.Controller().names
    for i, id in ipairs(ns.BUTTON_IDS) do
        if i > n then break end
        out[i] = id
    end
    return out
end

local function SlotIndex(id)
    for i, slot in ipairs(ns.BUTTON_IDS) do
        if slot == id then return i end
    end
end

-- Le nom qu'a un emplacement sur la manette choisie (nil : emplacement libre)
local function NameOn(def, id)
    local i = SlotIndex(id)
    return i and def.names[i]
end

function ns.SlotName(id)
    return NameOn(ns.Controller(), id)
end

-- Le libellé d'un emplacement libre : « Bouton 5 »
function ns.SpareName(id)
    return L.EXTRA .. " " .. (SlotIndex(id) or 0)
end

-- Mode conseillé : deux boutons = deux modificateurs (et leur paire) ;
-- sinon la première paire en modificateurs, le reste en boutons simples
local function Suggested(i, count)
    if count <= 2 or i <= 2 then return "modifier" end
    return "simple"
end

function ns.ApplySuggestedModes()
    local ids = ns.ActiveIDs()
    for i, id in ipairs(ids) do ns.db.buttons[id].mode = Suggested(i, #ids) end
    ns.Apply()
end

-- Changer de manette : ses noms remplacent ceux donnés à la main, ses modes
-- conseillés s'appliquent à ses boutons. Les touches de ses boutons restent
-- (le logiciel envoie souvent les mêmes). Un bouton de l'ancienne manette
-- qui devient un emplacement libre est vidé et désactivé, pour que sa
-- touche ne reste pas liée ; les emplacements déjà libres ne changent pas.
function ns.SetController(id)
    if not ns.db then return end
    local old, new = ns.Controller(), ns.ControllerDef(id)
    if old.id == new.id then return end
    ns.db.controller = new.id
    for _, slot in ipairs(ns.BUTTON_IDS) do
        local b = ns.db.buttons[slot]
        b.name = nil
        if NameOn(old, slot) and not NameOn(new, slot) then
            b.key, b.learned, b.mode = nil, nil, "off"
        end
    end
    ns.ApplySuggestedModes()
end
