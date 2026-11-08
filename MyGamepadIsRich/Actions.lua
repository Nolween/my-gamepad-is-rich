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
        if spellID and name then return { kind = "spell", id = spellID, name = name } end
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
}
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
}

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
        return A.SpellInfo(action.id) or action.name or ("spell:" .. tostring(action.id))
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
        return L["GAME_" .. tostring(action.id)]
    elseif k == "slot" then
        -- (ce que tient un emplacement de la barre du jeu, d'un autre type)
        local text = GetActionText and GetActionText(action.slot)
        return (type(text) == "string" and text ~= "") and text or L.KIND_slot
    end
end

function A.Icon(action)
    if not action then return nil end
    local k = action.kind
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
        return COMMAND_ICONS[action.command] or ICON_COMMAND
    elseif k == "game" then
        local def = GAME_BY_ID[action.id]
        if not def then return QUESTION end
        return (def.spell and SpellIcon(def.spell)) or def.icon
    elseif k == "slot" then
        return (GetActionTexture and GetActionTexture(action.slot)) or QUESTION
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
        if commandOK or not def.command then
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
function A.SpellbookEntries()
    local entries, seen, lastTab = {}, {}, nil
    local function add(name, icon, tab, spellID)
        if not (name and spellID) or seen[spellID] then return end
        seen[spellID] = true
        if tab ~= lastTab then
            entries[#entries + 1] = { header = tab or L.KIND_spell }
            lastTab = tab
        end
        entries[#entries + 1] = {
            label = name, sub = tab, icon = icon,
            action = { kind = "spell", id = spellID, name = name },
        }
    end
    if C_SpellBook and C_SpellBook.GetNumSpellBookSkillLines and Enum and Enum.SpellBookSpellBank then
        local bank = Enum.SpellBookSpellBank.Player
        local SPELL = Enum.SpellBookItemType and Enum.SpellBookItemType.Spell
        for line = 1, C_SpellBook.GetNumSpellBookSkillLines() or 0 do
            local info = C_SpellBook.GetSpellBookSkillLineInfo(line)
            if info and not info.offSpecID and not info.shouldHide then
                for index = info.itemIndexOffset + 1, info.itemIndexOffset + info.numSpellBookItems do
                    local item = C_SpellBook.GetSpellBookItemInfo(index, bank)
                    if item and item.itemType == SPELL and not item.isPassive then
                        add(item.name, item.iconID, info.name, item.spellID or item.actionID)
                    end
                end
            end
        end
    elseif GetNumSpellTabs and GetSpellBookItemInfo then
        for tab = 1, GetNumSpellTabs() or 0 do
            local tabName, _, offset, numSlots = GetSpellTabInfo(tab)
            for index = (offset or 0) + 1, (offset or 0) + (numSlots or 0) do
                local itemType, spellID = GetSpellBookItemInfo(index, "spell")
                if itemType == "SPELL" and not (IsPassiveSpell and IsPassiveSpell(index, "spell")) then
                    add(GetSpellBookItemName(index, "spell"), GetSpellBookItemTexture(index, "spell"), tabName, spellID)
                end
            end
        end
    end
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
