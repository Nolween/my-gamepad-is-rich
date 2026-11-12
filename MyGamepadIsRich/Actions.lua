-- Actions : ce qu'un emplacement lance. Une action est une table :
--   { kind = "spell",     id = spellID, name = "..." }
--   { kind = "mount",     id = spellID, mountID = n, name = "..." }
--   { kind = "item",      id = itemID }
--   { kind = "toy",       id = itemID }
--   { kind = "macro",     name = "nom de macro" }
--   { kind = "macrotext", text = "/cast ..." }
--   { kind = "equipset",  name = "..." }
--   { kind = "command",   command = "TOGGLEAUTORUN" }  (binding WoW)
-- Tout sauf "command" passe par un bouton sécurisé de type macro (comme
-- Improved Forever, éprouvé sur Forever) : ça marche en combat.
local _, ns = ...
local L = ns.L

local A = {}
ns.Actions = A

local QUESTION = 134400 -- icône « ? »
local ICON_MACROTEXT = "Interface\\Icons\\INV_Misc_Note_01"
local ICON_COMMAND = "Interface\\Icons\\INV_Misc_Key_03"
local ICON_EQUIPSET = "Interface\\Icons\\INV_Chest_Chain_04"

---------------------------------------------------------------------------
-- Infos du jeu (API récente d'abord, ancienne en repli)
---------------------------------------------------------------------------
function A.SpellInfo(spell)
    if not spell then return nil end
    if C_Spell and C_Spell.GetSpellInfo then
        local info = C_Spell.GetSpellInfo(spell)
        if info then return info.name, info.iconID, info.spellID end
        return nil
    end
    if GetSpellInfo then
        local name, _, icon, _, _, _, spellID = GetSpellInfo(spell)
        return name, icon, spellID
    end
end

-- Le sous-texte d'un sort (« Rang 3 » sur Classic), ou nil
function A.SpellRank(spellID)
    if not spellID then return nil end
    local get = (C_Spell and C_Spell.GetSpellSubtext) or GetSpellSubtext
    local ok, text = pcall(get or error, spellID)
    if ok and type(text) == "string" and not (issecretvalue and issecretvalue(text)) and text ~= "" then return text end
end

---------------------------------------------------------------------------
-- Sorts inconnus : un sort posé que ce personnage ne connaît pas (autre
-- talent, autre spé, modèle d'un personnage plus haut niveau). Connu : son
-- rang est connu, ou, sans rang choisi, un sort du même nom est dans le
-- grimoire (/cast Nom prend alors le rang connu). Dans le doute (API
-- absente, valeur secrète) : connu, pour ne rien signaler à tort. Mis en
-- cache jusqu'au prochain SPELLS_CHANGED.
---------------------------------------------------------------------------
local knownCache, bookNames = {}, nil

local function IsSecret(v)
    return issecretvalue ~= nil and issecretvalue(v)
end

-- vrai (connu), faux (inconnu), nil (on ne sait pas)
local function KnownByID(id)
    local any = false
    for _, get in ipairs({ C_SpellBook and C_SpellBook.IsSpellKnown, IsPlayerSpell, IsSpellKnown }) do
        if type(get) == "function" then
            local ok, v = pcall(get, id)
            if ok and not IsSecret(v) then
                if v then return true end
                any = true
            end
        end
    end
    if any then return false end
end

local function BookNames()
    if bookNames then return bookNames end
    bookNames = {}
    for _, e in ipairs(A.SpellbookEntries()) do
        local name = e.action and A.SpellInfo(e.action.id)
        if type(name) == "string" and not IsSecret(name) then bookNames[name] = true end
    end
    return bookNames
end

function A.IsKnown(action)
    if not (action and action.kind == "spell" and type(action.id) == "number") then return true end
    local key = action.rank and (action.id .. "|" .. action.rank) or action.id
    if knownCache[key] ~= nil then return knownCache[key] end
    local known = KnownByID(action.id)
    if known == false and not action.rank then
        local name = A.SpellInfo(action.id) or action.name
        if type(name) == "string" and not IsSecret(name) and BookNames()[name] then known = true end
    end
    known = known ~= false
    knownCache[key] = known
    return known
end

-- Les cases de ce jeu d'actions dont le sort est inconnu : { list, key }
function A.UnknownSpots(actions)
    local out = {}
    for _, a in pairs(actions or {}) do
        if type(a) == "table" then
            for _, list in ipairs({ a.combos, a.layers }) do
                if type(list) == "table" then
                    for key, action in pairs(list) do
                        if not A.IsKnown(action) then out[#out + 1] = { list = list, key = key } end
                    end
                end
            end
        end
    end
    return out
end

local spellEvents = CreateFrame("Frame")
spellEvents:RegisterEvent("SPELLS_CHANGED")
spellEvents:SetScript("OnEvent", function()
    wipe(knownCache)
    bookNames = nil
end)

-- Le rang d'un sort dans une info-bulle (« Rang 3 », en gris à droite du
-- nom, comme le grimoire ; sinon une ligne de plus). action : un sort de
-- l'addon ({ kind = "spell", id, rank }) ; le rang retenu, sinon celui du sort.
function A.AddRankToTooltip(tooltip, action)
    if not (tooltip and action and action.kind == "spell") then return end
    local rank = action.rank or A.SpellRank(action.id)
    if type(rank) ~= "string" or rank == "" then return end
    local right = tooltip.GetName and _G[(tooltip:GetName() or "") .. "TextRight1"]
    if right then
        -- (déjà affiché par le jeu : rien à faire ; une valeur cachée par le
        -- jeu fait échouer la lecture, on ajoute alors une ligne)
        local ok, state = pcall(function()
            local text = right:IsShown() and right:GetText()
            if text == rank then return "same" end
            if not text or text == "" then return "free" end
            return "used"
        end)
        if ok and state == "same" then return end
        if ok and state == "free" then
            right:SetText(rank)
            right:SetTextColor(0.5, 0.5, 0.5)
            right:Show()
            return
        end
    end
    tooltip:AddLine(rank, 0.5, 0.5, 0.5)
end

local function ItemName(id)
    local get = (C_Item and C_Item.GetItemNameByID) or GetItemInfo
    return get and get(id)
end

local function ItemIcon(id)
    local get = (C_Item and C_Item.GetItemIconByID) or GetItemIcon
    return get and get(id)
end

local function MountInfo(mountID)
    if not (C_MountJournal and mountID) then return nil end
    if C_MountJournal.GetMountInfoByID then
        local name, spellID, icon = C_MountJournal.GetMountInfoByID(mountID)
        if name then return name, spellID, icon end
    end
    if C_MountJournal.GetDisplayedMountInfo then
        local name, spellID, icon = C_MountJournal.GetDisplayedMountInfo(mountID)
        if name then return name, spellID, icon end
    end
end

---------------------------------------------------------------------------
-- Depuis le curseur (glisser-déposer)
---------------------------------------------------------------------------
-- Renvoie une action, ou nil + message
function A.FromCursor()
    if not GetCursorInfo then return nil end
    local kind, a, b, c, d = GetCursorInfo()
    if not kind then return nil end
    if kind == "spell" then
        -- ("spell", index du grimoire, type de grimoire, spellID[, baseSpellID])
        local spellID = (type(c) == "number" and c) or (type(d) == "number" and d) or nil
        if not spellID and C_SpellBook and C_SpellBook.GetSpellBookItemInfo and type(a) == "number" then
            local ok, info = pcall(C_SpellBook.GetSpellBookItemInfo, a, b)
            if ok and type(info) == "table" then spellID = info.spellID or info.actionID end
        end
        local name = A.SpellInfo(spellID)
        if spellID and name then
            -- (un rang inférieur glissé depuis le grimoire : le garder)
            local rank
            for _, e in ipairs(A.SpellbookEntries()) do
                if e.action and e.action.id == spellID then rank = e.action.rank; break end
            end
            return { kind = "spell", id = spellID, name = name, rank = rank }
        end
    elseif kind == "item" then
        if type(a) == "number" then return { kind = "item", id = a } end
    elseif kind == "toy" then
        if type(a) == "number" then return { kind = "toy", id = a } end
    elseif kind == "macro" then
        local name = GetMacroInfo and GetMacroInfo(a)
        if name then return { kind = "macro", name = name } end
    elseif kind == "mount" then
        local name, spellID = MountInfo(a)
        if name and spellID then return { kind = "mount", id = spellID, mountID = a, name = name } end
    elseif kind == "companion" then
        -- (anciens clients : "companion", index, "MOUNT")
        if b == "MOUNT" and GetCompanionInfo then
            local _, name, spellID = GetCompanionInfo("MOUNT", a)
            if name and spellID then return { kind = "mount", id = spellID, name = name } end
        end
    elseif kind == "equipmentset" then
        if a then return { kind = "equipset", name = tostring(a) } end
    end
    return nil, L.CURSOR_UNSUPPORTED
end

---------------------------------------------------------------------------
-- Actions de base : celles de Forever sur A/B/X/Y, refaites avec le jeu,
-- pour les poser où on veut ({ kind = "game", id = "jump" }...)
--   command : une commande WoW (liée directement), ou
--   text    : une macro (bouton sécurisé)
---------------------------------------------------------------------------
A.GAME = {
    { id = "jump", command = "JUMP", icon = "Interface\\Icons\\Spell_Magic_FeatherFall" },
    { id = "cancel", text = "/stopcasting\n/stopspelltarget\n/cleartarget",
        icon = "Interface\\Buttons\\UI-GroupLoot-Pass-Up" },
    -- (rechercher = clic droit sur la cible : interagir avec la cible)
    { id = "search", command = "INTERACTTARGET", icon = "Interface\\Icons\\INV_Misc_Spyglass_02" },
    { id = "attack", text = "/startattack", spell = 6603, icon = "Interface\\Icons\\INV_Sword_04" },
    { id = "interact", command = "INTERACTTARGET", icon = "Interface\\GossipFrame\\GossipGossipIcon" },
    -- (une macro, pas la commande TARGETSELF : possible sur toutes les cases)
    { id = "targetself", text = "/target player", icon = "Interface\\Icons\\INV_Misc_Head_Human_01" },
    -- (cible et focus : des macros, possibles sur toutes les cases)
    { id = "targetlast", text = "/targetlasttarget", icon = "Interface\\Buttons\\UI-RefreshButton" },
    { id = "assist", text = "/assist", icon = "Interface\\Icons\\Ability_Hunter_MarkedForDeath" },
    { id = "focus", text = "/focus", icon = "Interface\\Icons\\Ability_Hunter_FocusedAim" },
    { id = "targetfocus", text = "/target focus", icon = "Interface\\Icons\\Ability_Hunter_FocusFire" },
    { id = "follow", text = "/follow", icon = "Interface\\Icons\\Ability_Tracking" },
    -- (les sacs : comme la commande « Ouvrir tous les sacs », mais en macro)
    { id = "openbags", text = "/run ToggleAllBags()", icon = "Interface\\Icons\\INV_Misc_Bag_08" },
    { id = "dismount", text = "/dismount", icon = "Interface\\Icons\\Spell_Nature_Swiftness" },
    -- (une monture favorite au hasard : seulement si le jeu a le journal
    -- des montures)
    { id = "randommount", text = "/run C_MountJournal.SummonByID(0)", icon = "Interface\\Icons\\Ability_Mount_RidingHorse",
        available = function() return C_MountJournal ~= nil and C_MountJournal.SummonByID ~= nil end },
}

-- Marqueurs de raid sur la cible (/tm, en combat aussi). Le marquage
-- rapide pose le suivant à chaque appui (crâne, croix, carré...) : la
-- première ligne de sa macro (A.MARK_QUICK, ignorée par le jeu) le signale
-- au code sécurisé, qui fait tourner le numéro (Modifier.lua, Simple.lua)
A.MARK_QUICK = "#mgirmark"
local MARK_ICON = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_"
A.GAME[#A.GAME + 1] = { id = "markquick", text = A.MARK_QUICK .. "\n/tm 8", icon = MARK_ICON .. "8" }
for n = 8, 1, -1 do
    A.GAME[#A.GAME + 1] = { id = "mark" .. n, text = "/tm " .. n, icon = MARK_ICON .. n, raidTarget = n }
end
A.GAME[#A.GAME + 1] = { id = "markclear", text = "/tm 0", icon = "Interface\\Buttons\\UI-StopButton" }

local GAME_BY_ID = {}
for _, def in ipairs(A.GAME) do GAME_BY_ID[def.id] = def end

function A.GameDef(id)
    return GAME_BY_ID[id]
end

-- Les icônes des commandes WoW courantes (les autres : une clé)
local COMMAND_ICONS = {
    JUMP = "Interface\\Icons\\Spell_Magic_FeatherFall",
    INTERACTTARGET = "Interface\\GossipFrame\\GossipGossipIcon",
    INTERACTMOUSEOVER = "Interface\\GossipFrame\\GossipGossipIcon",
    TOGGLEAUTORUN = "Interface\\Icons\\Ability_Rogue_Sprint",
    TARGETNEARESTENEMY = "Interface\\Icons\\Ability_Hunter_SniperShot",
    TARGETSCANENEMY = "Interface\\Icons\\Ability_Hunter_SniperShot",
    TOGGLEGAMEMENU = "Interface\\Buttons\\UI-GroupLoot-Pass-Up",
    TOGGLEWORLDMAP = "Interface\\Icons\\INV_Misc_Map_01",
    TOGGLEBATTLEFIELDMINIMAP = "Interface\\Icons\\INV_Misc_Map02",
    OPENALLBAGS = "Interface\\Icons\\INV_Misc_Bag_08",
    TOGGLEBACKPACK = "Interface\\Icons\\INV_Misc_Bag_08",
    TOGGLESPELLBOOK = "Interface\\Icons\\INV_Misc_Book_09",
    TOGGLEQUESTLOG = "Interface\\Icons\\INV_Scroll_03",
    TOGGLECHARACTER0 = "Interface\\Icons\\INV_Chest_Cloth_17",
    TOGGLEACHIEVEMENT = "Interface\\Icons\\Achievement_General",
    TOGGLEGROUPFINDER = "Interface\\Icons\\INV_Misc_GroupNeedMore",
    TOGGLELFGPARENT = "Interface\\Icons\\INV_Misc_GroupNeedMore",
    TOGGLECOLLECTIONS = "Interface\\Icons\\Ability_Mount_RidingHorse",
    TOGGLEMOUNTJOURNAL = "Interface\\Icons\\Ability_Mount_RidingHorse",
}

-- Une icône par son chemin (ou son nom sous Interface\Icons, comme sur
-- Wowhead : « inv_misc_map_01 ») : son numéro de fichier si le jeu la
-- connaît, nil sinon. Sans moyen de vérifier (ancien client) : le chemin
local knownIcons = {}
function A.IconFromName(name)
    if type(name) ~= "string" or name == "" then return nil end
    local path = name:find("[\\/]") and name or ("Interface\\Icons\\" .. name)
    if not GetFileIDFromPath then return path end
    if knownIcons[path] == nil then
        local ok, id = pcall(GetFileIDFromPath, path)
        knownIcons[path] = ok and type(id) == "number" and id > 0 and id or false
    end
    return knownIcons[path] or nil
end

-- L'icône par défaut d'une commande WoW, ou nil
local function CommandIcon(command)
    local path = COMMAND_ICONS[command]
    return path and A.IconFromName(path)
end

-- Les icônes par défaut des commandes WoW, pour la recherche d'icône
-- ({ label, icon })
function A.CommandIconEntries()
    local out = {}
    for command in pairs(COMMAND_ICONS) do
        local icon = CommandIcon(command)
        if icon then out[#out + 1] = { label = A.CommandLabel(command), icon = icon } end
    end
    return out
end

local function SpellIcon(id)
    if C_Spell and C_Spell.GetSpellTexture then return C_Spell.GetSpellTexture(id) end
    return GetSpellTexture and GetSpellTexture(id)
end

---------------------------------------------------------------------------
-- Libellé et icône
---------------------------------------------------------------------------
function A.Label(action)
    if not action then return nil end
    local k = action.kind
    if k == "spell" or k == "mount" then
        local name = A.SpellInfo(action.id) or action.name or ("spell:" .. tostring(action.id))
        if action.rank then name = name .. " (" .. action.rank .. ")" end
        return name
    elseif k == "item" or k == "toy" then
        return ItemName(action.id) or ("item:" .. tostring(action.id))
    elseif k == "macro" or k == "equipset" then
        return action.name
    elseif k == "macrotext" then
        local first = (action.text or ""):match("^[^\n]*") or ""
        return first ~= "" and first or L.KIND_macrotext
    elseif k == "command" then
        return A.CommandLabel(action.command)
    elseif k == "game" then
        -- (un marqueur : son nom dans le jeu, « Crâne »...)
        local def = GAME_BY_ID[action.id]
        if def and def.raidTarget then
            local name = _G["RAID_TARGET_" .. def.raidTarget]
            if type(name) ~= "string" or (issecretvalue and issecretvalue(name)) then name = tostring(def.raidTarget) end
            return L.GAME_mark:format(name)
        end
        return L["GAME_" .. tostring(action.id)]
    elseif k == "slot" then
        -- (ce que tient un emplacement de la barre du jeu, d'un autre type)
        local text = GetActionText and GetActionText(action.slot)
        return (type(text) == "string" and text ~= "") and text or L.KIND_slot
    elseif k == "best" then
        return L["BEST_" .. tostring(action.cat)]
    end
end

-- Les actions sans icône à elles (commande WoW, macro écrite à la main) :
-- une icône au choix du joueur (action.icon : numéro de fichier ou chemin)
local CUSTOM_ICON = { command = true, macrotext = true }

function A.CanSetIcon(action)
    return action ~= nil and CUSTOM_ICON[action.kind] == true
end

-- Une copie de l'action avec cette icône (nil : l'icône par défaut)
function A.WithIcon(action, icon)
    local copy = {}
    for k, v in pairs(action) do copy[k] = v end
    copy.icon = icon
    return copy
end

function A.Icon(action)
    if not action then return nil end
    local k = action.kind
    if action.icon and CUSTOM_ICON[k] then return action.icon end
    if k == "spell" or k == "mount" then
        return select(2, A.SpellInfo(action.id)) or QUESTION
    elseif k == "item" or k == "toy" then
        return ItemIcon(action.id) or QUESTION
    elseif k == "macro" then
        local _, icon = GetMacroInfo(action.name)
        return icon or QUESTION
    elseif k == "macrotext" then
        return ICON_MACROTEXT
    elseif k == "command" then
        return CommandIcon(action.command) or ICON_COMMAND
    elseif k == "game" then
        local def = GAME_BY_ID[action.id]
        if not def then return QUESTION end
        return (def.spell and SpellIcon(def.spell)) or def.icon
    elseif k == "slot" then
        return (GetActionTexture and GetActionTexture(action.slot)) or QUESTION
    elseif k == "best" then
        return A.BestIcon(action.cat)
    elseif k == "equipset" then
        if C_EquipmentSet and C_EquipmentSet.GetEquipmentSetID and C_EquipmentSet.GetEquipmentSetInfo then
            local setID = C_EquipmentSet.GetEquipmentSetID(action.name)
            if setID then
                local _, icon = C_EquipmentSet.GetEquipmentSetInfo(setID)
                if icon then return icon end
            end
        end
        return ICON_EQUIPSET
    end
    return QUESTION
end

function A.KindLabel(action)
    return action and L["KIND_" .. action.kind] or ""
end

---------------------------------------------------------------------------
-- Pour le bouton sécurisé : macro (nom d'une macro du jeu) ou macrotext
---------------------------------------------------------------------------
function A.Secure(action)
    if not action then return nil end
    local k = action.kind
    if k == "spell" or k == "mount" then
        local name = A.SpellInfo(action.id) or action.name
        -- (un rang inférieur choisi exprès : sinon /cast prend le plus haut)
        if name and action.rank then name = name .. "(" .. action.rank .. ")" end
        return nil, name and ("/cast " .. name)
    elseif k == "item" or k == "toy" then
        return nil, "/use item:" .. tostring(action.id)
    elseif k == "macro" then
        if action.name and GetMacroIndexByName and GetMacroIndexByName(action.name) > 0 then
            return action.name, nil
        end
        return nil
    elseif k == "macrotext" then
        local text = action.text
        return nil, (text and text ~= "") and text or nil
    elseif k == "equipset" then
        return nil, "/equipset " .. action.name
    elseif k == "game" then
        local def = GAME_BY_ID[action.id]
        return nil, def and def.text
    elseif k == "best" then
        -- (sans objet dans les sacs : une ligne qui ne fait rien, pour que la
        -- case reste à l'addon et ne lance pas l'action du jeu)
        return nil, A.BestMacro(action.cat) or "#mgirbest"
    end
    return nil -- ("command" : binding direct, pas de bouton)
end

-- La commande WoW d'une action (commande, ou action de base qui en est une)
function A.CommandOf(action)
    if not action then return nil end
    if action.kind == "command" then return action.command end
    if action.kind == "game" then
        local def = GAME_BY_ID[action.id]
        return def and def.command
    end
end

function A.IsCommand(action)
    return A.CommandOf(action) ~= nil
end

-- La liste « Action de base... » (sans celles qui sont des commandes WoW
-- quand la case n'en accepte pas)
function A.GameEntries(commandOK)
    local entries = {}
    for _, def in ipairs(A.GAME) do
        if (commandOK or not def.command) and (not def.available or def.available()) then
            local action = { kind = "game", id = def.id }
            entries[#entries + 1] = { label = A.Label(action), icon = A.Icon(action), action = action }
        end
    end
    return entries
end

---------------------------------------------------------------------------
-- Listes à choisir : sorts du grimoire, objets des sacs / équipés
-- (entrées : { header = "..." } ou { label, sub, icon, action })
---------------------------------------------------------------------------
-- Tous les sorts actifs du grimoire, une fois chacun, dans l'ordre du livre
-- (API récente ou ancienne : méthode d'Improved Forever, éprouvée sur Forever)
-- Un sort à plusieurs rangs (Classic) a une entrée par rang : le rang est
-- ajouté au libellé. Un rang inférieur au plus haut connu est retenu dans
-- l'action (/cast Nom(Rang 1)) ; le plus haut ne l'est pas, pour suivre les
-- rangs appris ensuite.
function A.SpellbookEntries()
    local entries, seen, lastTab, byName = {}, {}, nil, {}
    local function add(name, icon, tab, spellID, rank)
        if not (name and spellID) or seen[spellID] then return end
        seen[spellID] = true
        if tab ~= lastTab then
            entries[#entries + 1] = { header = tab or L.KIND_spell }
            lastTab = tab
        end
        local e = {
            label = name, sub = tab, icon = icon,
            action = { kind = "spell", id = spellID, name = name },
            rank = (type(rank) == "string" and rank ~= "") and rank or nil,
        }
        entries[#entries + 1] = e
        local same = byName[name]
        if not same then same = {}; byName[name] = same end
        same[#same + 1] = e
    end
    local modern = C_SpellBook and C_SpellBook.GetNumSpellBookSkillLines and Enum and Enum.SpellBookSpellBank
    local bank = modern and Enum.SpellBookSpellBank.Player
    local SPELL = modern and Enum.SpellBookItemType and Enum.SpellBookItemType.Spell
    -- (un emplacement du grimoire, API récente ou ancienne)
    local function addSlot(index, tab, bookType)
        if modern then
            local ok, item = pcall(C_SpellBook.GetSpellBookItemInfo, index, bank)
            if ok and item and item.itemType == SPELL and not item.isPassive then
                add(item.name, item.iconID, tab, item.spellID or item.actionID, item.subName)
            end
        else
            local ok, itemType, spellID = pcall(GetSpellBookItemInfo, index, bookType)
            if ok and itemType == "SPELL" and not (IsPassiveSpell and IsPassiveSpell(index, bookType)) then
                local name, rank = GetSpellBookItemName(index, bookType)
                add(name, GetSpellBookItemTexture(index, bookType), tab, spellID, rank)
            end
        end
    end
    if modern then
        for line = 1, C_SpellBook.GetNumSpellBookSkillLines() or 0 do
            local info = C_SpellBook.GetSpellBookSkillLineInfo(line)
            if info and not info.offSpecID and not info.shouldHide then
                for index = info.itemIndexOffset + 1, info.itemIndexOffset + info.numSpellBookItems do
                    addSlot(index, info.name)
                end
            end
        end
    elseif GetNumSpellTabs and GetSpellBookItemInfo then
        for tab = 1, GetNumSpellTabs() or 0 do
            local tabName, _, offset, numSlots = GetSpellTabInfo(tab)
            for index = (offset or 0) + 1, (offset or 0) + (numSlots or 0) do
                addSlot(index, tabName, "spell")
            end
        end
    end
    -- Les métiers (onglet à part du grimoire depuis Cataclysm : découverte
    -- d'herbes, de gisements, pêche, cuisine, archéologie...). Avant, ils
    -- sont dans l'onglet Général, déjà parcouru
    if GetProfessions and GetProfessionInfo and (modern or GetSpellBookItemInfo) then
        local bookType = BOOKTYPE_PROFESSION or "professions"
        -- (métier 1, métier 2, archéologie, pêche, cuisine : nil s'il manque)
        local profs = { GetProfessions() }
        for k = 1, 5 do
            local prof = profs[k]
            local ok, name, _, _, _, numSpells, spellOffset
            if prof then ok, name, _, _, _, numSpells, spellOffset = pcall(GetProfessionInfo, prof) end
            if ok and name and numSpells and spellOffset then
                for i = 1, numSpells do addSlot(spellOffset + i, name, bookType) end
            end
        end
    end
    -- (le grimoire range les rangs du plus bas au plus haut : le dernier est
    -- le plus haut connu)
    for _, same in pairs(byName) do
        if #same > 1 then
            for i, e in ipairs(same) do
                local rank = e.rank or A.SpellRank(e.action.id)
                e.label = e.label .. " (" .. (rank or ("#" .. i)) .. ")"
                if rank and i < #same then e.action.rank = rank end
            end
        end
    end
    for _, e in ipairs(entries) do e.rank = nil end
    return entries
end

local function ContainerSlots(bag)
    if C_Container and C_Container.GetContainerNumSlots then return C_Container.GetContainerNumSlots(bag) or 0 end
    return GetContainerNumSlots and GetContainerNumSlots(bag) or 0
end

local function ContainerItemID(bag, slot)
    if C_Container and C_Container.GetContainerItemID then return C_Container.GetContainerItemID(bag, slot) end
    return GetContainerItemID and GetContainerItemID(bag, slot)
end

local function ItemSpell(id)
    local get = (C_Item and C_Item.GetItemSpell) or GetItemSpell
    return get and get(id)
end

local function IsEquippable(id)
    local get = (C_Item and C_Item.IsEquippableItem) or IsEquippableItem
    return get and get(id)
end

local function ItemCount(id)
    local get = (C_Item and C_Item.GetItemCount) or GetItemCount
    return get and get(id) or 0
end

-- Objets utilisables équipés (bijoux...), puis tous les objets des sacs :
-- utilisables d'abord, puis les autres (un équipement s'équipe avec /use)
function A.ItemEntries()
    local entries, seen = {}, {}
    local function entry(id)
        local count = ItemCount(id)
        return {
            label = ItemName(id) or ("item:" .. id),
            sub = count > 1 and ("x" .. count) or nil,
            icon = ItemIcon(id),
            action = { kind = "item", id = id },
        }
    end

    local equipped = {}
    for slot = 1, 19 do
        local id = GetInventoryItemID and GetInventoryItemID("player", slot)
        if id and not seen[id] and ItemSpell(id) then
            seen[id] = true
            equipped[#equipped + 1] = entry(id)
        end
    end

    local usable, other = {}, {}
    for bag = 0, NUM_BAG_SLOTS or 4 do
        for slot = 1, ContainerSlots(bag) do
            local id = ContainerItemID(bag, slot)
            if id and not seen[id] then
                seen[id] = true
                if ItemSpell(id) then
                    usable[#usable + 1] = entry(id)
                else
                    local e = entry(id)
                    e.unusable = not IsEquippable(id)
                    other[#other + 1] = e
                end
            end
        end
    end
    local function byName(a, b) return a.label < b.label end
    table.sort(usable, byName)
    table.sort(other, byName)

    local function section(title, list)
        if #list == 0 then return end
        entries[#entries + 1] = { header = title }
        for _, e in ipairs(list) do entries[#entries + 1] = e end
    end
    section(L.ITEMS_EQUIPPED, equipped)
    section(L.ITEMS_USABLE, usable)
    section(L.ITEMS_OTHER, other)
    return entries
end

---------------------------------------------------------------------------
-- Remplissage rapide : les objets utiles à avoir sous la main, dans l'ordre
-- où les poser. La pierre de foyer, les bijoux utilisables équipés, puis les
-- consommables des sacs : potions, nourriture et boissons, bandages,
-- élixirs et flacons, autres. Seulement des objets qui ont un effet à
-- l'utilisation (pas d'équipement, pas d'objet de quête).
---------------------------------------------------------------------------
local HEARTHSTONE = 6948
local CONSUMABLE = 0
-- (sous-classes des consommables, par priorité : potion, nourriture et
-- boisson, bandage, élixir, flacon ; les autres après)
local CONSUMABLE_ORDER = { [1] = 1, [5] = 2, [7] = 3, [2] = 4, [3] = 5 }

local function ItemClass(id)
    local get = (C_Item and C_Item.GetItemInfoInstant) or GetItemInfoInstant
    if not get then return nil end
    local ok, _, _, _, _, _, classID, subclassID = pcall(get, id)
    if ok then return classID, subclassID end
end

---------------------------------------------------------------------------
-- Consommables intelligents ({ kind = "best", cat = "heal" }...) : le
-- meilleur objet de ce type présent dans les sacs. La macro essaie les
-- meilleurs d'abord (une ligne /use par objet, jusqu'à BEST_LINES) : une
-- pile épuisée en combat passe à la suivante (le temps de recharge commun
-- des potions empêche d'en boire deux). La liste suit les sacs, hors
-- combat (ns.Apply quand elle change).
-- Le type d'un objet vient de son sort, comparé aux sorts de référence du
-- jeu (noms traduits par le jeu lui-même) : « Potion de soins », « Rendre le
-- mana », « Nourriture », « Boisson » ; les bandages par leur sous-classe ;
-- sinon, pour une potion, le mot « vie » / « mana » de sa description.
---------------------------------------------------------------------------
A.BEST_CATS = { "heal", "mana", "food", "drink", "bandage" }
local BEST_LINES = 5
local BEST_ICON = {
    heal = "Interface\\Icons\\INV_Potion_54", mana = "Interface\\Icons\\INV_Potion_76",
    food = "Interface\\Icons\\INV_Misc_Food_15", drink = "Interface\\Icons\\INV_Drink_07",
    bandage = "Interface\\Icons\\INV_Misc_Bandage_15",
}
-- (sorts de référence : Potion de soins, Rendre le mana, Nourriture,
-- Boisson, Nourriture et boisson)
local BEST_REF = { heal = { 439, 440, 441, 2024, 4042 }, mana = { 437, 438, 2023, 11903 },
    food = { 433, 434, 435 }, drink = { 430, 431, 432 }, both = { 18234 } }
local POTION, FOOD, BANDAGE = 1, 5, 7

local refNames
local function RefNames()
    if refNames then return refNames end
    refNames = {}
    for cat, ids in pairs(BEST_REF) do
        for _, id in ipairs(ids) do
            local name = A.SpellInfo(id)
            if type(name) == "string" and not IsSecret(name) then refNames[name] = cat end
        end
    end
    return refNames
end

local function Mentions(text, word)
    if type(text) ~= "string" or IsSecret(text) or type(word) ~= "string" or word == "" then return false end
    return text:lower():find(word:lower(), 1, true) ~= nil
end

-- Les types d'un objet : { heal = true, ... } ou nil
local itemCats = {}
local function ItemCats(id)
    if itemCats[id] ~= nil then return itemCats[id] or nil end
    local classID, subclassID = ItemClass(id)
    local cats
    if classID == CONSUMABLE then
        local spellName, spellID = ItemSpell(id)
        local ref = type(spellName) == "string" and not IsSecret(spellName) and RefNames()[spellName]
        if subclassID == BANDAGE then
            cats = { bandage = true }
        elseif ref == "both" then
            cats = { food = true, drink = true }
        elseif ref then
            cats = { [ref] = true }
        elseif subclassID == POTION and spellID then
            local desc = C_Spell and C_Spell.GetSpellDescription and select(2, pcall(C_Spell.GetSpellDescription, spellID))
            local heal, mana = Mentions(desc, _G.HEALTH), Mentions(desc, _G.MANA)
            if heal or mana then cats = { heal = heal or nil, mana = mana or nil } end
        end
    end
    -- (un objet pas encore chargé par le jeu : redemandé plus tard)
    if cats or ItemName(id) then itemCats[id] = cats or false end
    return cats
end

local function ItemLevels(id)
    local get = (C_Item and C_Item.GetItemInfo) or GetItemInfo
    if not get then return 0, 0 end
    local ok, _, _, _, level, minLevel = pcall(get, id)
    if not ok then return 0, 0 end
    return tonumber(minLevel) or 0, tonumber(level) or 0
end

-- Les objets de ce type dans les sacs, le meilleur d'abord : utilisable à
-- ce niveau, niveau requis le plus haut, puis niveau d'objet
local bestCache = {}
function A.BestItems(cat)
    if bestCache[cat] then return bestCache[cat] end
    local found, seen = {}, {}
    local myLevel = UnitLevel and UnitLevel("player") or 0
    for bag = 0, NUM_BAG_SLOTS or 4 do
        for slot = 1, ContainerSlots(bag) do
            local id = ContainerItemID(bag, slot)
            if id and not seen[id] then
                seen[id] = true
                local cats = ItemCats(id)
                if cats and cats[cat] then
                    local minLevel, level = ItemLevels(id)
                    found[#found + 1] = { id = id, ok = minLevel <= myLevel, min = minLevel, level = level }
                end
            end
        end
    end
    table.sort(found, function(a, b)
        if a.ok ~= b.ok then return a.ok end
        if a.min ~= b.min then return a.min > b.min end
        if a.level ~= b.level then return a.level > b.level end
        return a.id > b.id
    end)
    local out = {}
    for i, e in ipairs(found) do out[i] = e.id end
    bestCache[cat] = out
    return out
end

-- L'objet qui partira, ou nil (aucun dans les sacs)
function A.BestItem(cat)
    return A.BestItems(cat)[1]
end

function A.BestIcon(cat)
    local id = A.BestItem(cat)
    return (id and ItemIcon(id)) or BEST_ICON[cat] or QUESTION
end

function A.BestMacro(cat)
    local lines = {}
    for i, id in ipairs(A.BestItems(cat)) do
        if i > BEST_LINES then break end
        lines[#lines + 1] = "/use item:" .. id
    end
    return #lines > 0 and table.concat(lines, "\n") or nil
end

-- La liste « Consommable intelligent... »
function A.BestEntries()
    local entries = {}
    for _, cat in ipairs(A.BEST_CATS) do
        local action = { kind = "best", cat = cat }
        local id = A.BestItem(cat)
        entries[#entries + 1] = {
            label = A.Label(action),
            sub = id and (ItemName(id) or ("item:" .. id)) or L.BEST_NONE,
            icon = A.BestIcon(cat),
            action = action,
        }
    end
    return entries
end

-- (les sacs ont changé : la liste est refaite ; si celle d'un consommable
-- intelligent change, les liaisons sont remises, hors combat)
local bestSignature
local function BestSignature()
    local parts = {}
    for _, cat in ipairs(A.BEST_CATS) do parts[#parts + 1] = table.concat(A.BestItems(cat), ",") end
    return table.concat(parts, "|")
end

local bagEvents = CreateFrame("Frame")
local bagWait = false
local function BagsChanged()
    bagWait = false
    if InCombatLockdown() then return end -- (repris à la fin du combat)
    wipe(bestCache)
    local sig = BestSignature()
    if sig ~= bestSignature then
        bestSignature = sig
        if ns.db then ns.Apply(true) end
    end
end
for _, event in ipairs({ "BAG_UPDATE_DELAYED", "PLAYER_REGEN_ENABLED", "PLAYER_LEVEL_UP", "GET_ITEM_INFO_RECEIVED" }) do
    pcall(bagEvents.RegisterEvent, bagEvents, event)
end
bagEvents:SetScript("OnEvent", function(_, event)
    -- (un objet chargé par le jeu : son type peut enfin se lire)
    if event == "GET_ITEM_INFO_RECEIVED" then
        for id, v in pairs(itemCats) do if v == false then itemCats[id] = nil end end
    end
    if bagWait then return end
    bagWait = true
    if C_Timer then C_Timer.After(1, BagsChanged) else BagsChanged() end
end)

function A.QuickFillActions()
    local out, seen = {}, {}
    local function add(id)
        if seen[id] then return end
        seen[id] = true
        out[#out + 1] = { kind = "item", id = id }
    end
    if ItemCount(HEARTHSTONE) > 0 then add(HEARTHSTONE) end
    for _, slot in ipairs({ 13, 14 }) do
        local id = GetInventoryItemID and GetInventoryItemID("player", slot)
        if id and ItemSpell(id) then add(id) end
    end
    -- (les consommables intelligents avant les objets un par un : leurs
    -- objets n'ont plus besoin d'une case à eux)
    for _, cat in ipairs(A.BEST_CATS) do
        local items = A.BestItems(cat)
        if #items > 0 then
            out[#out + 1] = { kind = "best", cat = cat }
            for _, id in ipairs(items) do seen[id] = true end
        end
    end
    local found = {}
    for bag = 0, NUM_BAG_SLOTS or 4 do
        for slot = 1, ContainerSlots(bag) do
            local id = ContainerItemID(bag, slot)
            if id and not seen[id] and not found[id] and ItemSpell(id) then
                local classID, subclassID = ItemClass(id)
                if classID == CONSUMABLE then
                    found[id] = { id = id, rank = CONSUMABLE_ORDER[subclassID] or 9, name = ItemName(id) or "" }
                end
            end
        end
    end
    local list = {}
    for _, e in pairs(found) do list[#list + 1] = e end
    table.sort(list, function(a, b)
        if a.rank ~= b.rank then return a.rank < b.rank end
        if a.name ~= b.name then return a.name < b.name end
        return a.id < b.id
    end)
    for _, e in ipairs(list) do add(e.id) end
    return out
end

-- Deux actions identiques (même type, même sort / objet / macro...)
function A.Same(a, b)
    if not (a and b) or a.kind ~= b.kind then return false end
    return a.id == b.id and a.name == b.name and a.text == b.text and a.command == b.command and a.cat == b.cat
end

---------------------------------------------------------------------------
-- Commandes WoW (les bindings du jeu)
---------------------------------------------------------------------------
-- Un texte lu dans les globales du jeu : seulement si c'en est un (un autre
-- addon peut avoir une table ou une fonction sous ce nom), sinon fallback
local function GlobalText(name, fallback)
    local v = name and _G[name]
    if type(v) == "string" and not (issecretvalue and issecretvalue(v)) then return v end
    return fallback
end

function A.CommandLabel(command)
    if not command then return "" end
    return GlobalText("BINDING_NAME_" .. command, command)
end

local commandCache
function A.Commands()
    if commandCache then return commandCache end
    local list = {}
    local n = GetNumBindings and GetNumBindings() or 0
    for i = 1, n do
        local command, category = GetBinding(i)
        if type(command) == "string" and command ~= "" and not command:find("^HEADER_") then
            -- (la catégorie : son nom traduit, ou tel quel)
            local sub = type(category) == "string" and GlobalText(category, category) or ""
            list[#list + 1] = {
                label = A.CommandLabel(command),
                sub = sub,
                search = command,
                action = { kind = "command", command = command },
            }
        end
    end
    commandCache = list
    return list
end
