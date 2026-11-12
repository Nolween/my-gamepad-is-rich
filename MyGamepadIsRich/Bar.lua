-- La barre manette de Forever (Blizzard_GamepadActionBars) : ses quatre
-- barres (rien, LT, RT, LT + RT) de 8 emplacements, la croix (1-4 : gauche,
-- haut, droite, bas) et A/B/X/Y (5-8 : X, Y, B, A). Lecture et écriture de
-- ses emplacements (hors combat), comme son propre éditeur ; la fenêtre de
-- configuration et le HUD passent par ici.
-- Sur la barre sans gâchette, A/B/X/Y gardent les actions du jeu (sauter,
-- interagir...) : ces emplacements ne s'écrivent pas.
local _, ns = ...
local L = ns.L

local B = {}
ns.Bar = B

B.NAMES = { "topBar", "leftBar", "rightBar", "bottomBar" }
B.INDEX = { topBar = 0, leftBar = 1, rightBar = 2, bottomBar = 3 }
B.KEYS = {
    topBar = {}, leftBar = { "PADLTRIGGER" }, rightBar = { "PADRTRIGGER" },
    bottomBar = { "PADLTRIGGER", "PADRTRIGGER" },
}
-- Le bouton de la manette de chaque case 1-8 (croix, puis X, Y, B, A)
B.PAD_KEYS = { "PADDLEFT", "PADDUP", "PADDRIGHT", "PADDDOWN", "PAD3", "PAD4", "PAD2", "PAD1" }

local function Util()
    return _G.GamepadActionBarBindingUtil
end

function B.PageUnit()
    local main = _G.GamepadMainActionBarFrame
    return main and main.PageUnit
end

function B.Available()
    local pu = B.PageUnit()
    return Util() ~= nil and pu ~= nil and pu.GetCurrentPage ~= nil
end

-- L'emplacement d'action (PlaceAction / GetActionInfo) d'une case, ou nil
function B.Storage(bar, i)
    local util, pu = Util(), B.PageUnit()
    if not (util and pu and B.INDEX[bar]) then return nil end
    local slot = B.INDEX[bar] * 8 + i
    local ok, bindable = pcall(util.IsBindablePageUnitSlotID, slot)
    if not (ok and bindable) then return nil end
    local okp, page = pcall(pu.GetCurrentPage, pu)
    if not okp then return nil end
    local oks, storage = pcall(util.GetGamepadStorageSlotIndexFromPageAndPageUnitSlotID, page, slot)
    return (oks and type(storage) == "number") and storage or nil
end

-- Une case réservée au jeu (A/B/X/Y sans gâchette)
function B.IsGameSlot(bar, i)
    if not B.Available() then return false end
    local util = Util()
    local ok, bindable = pcall(util.IsBindablePageUnitSlotID, B.INDEX[bar] * 8 + i)
    return ok and not bindable
end

-- Ce que tient une case : une action (Actions.lua), ou nil
function B.Get(bar, i)
    local storage = B.Storage(bar, i)
    if not storage then return nil end
    local kind, id = GetActionInfo(storage)
    if kind == "spell" and id then
        return { kind = "spell", id = id, name = ns.Actions.SpellInfo(id) }
    elseif kind == "item" and id then
        return { kind = "item", id = id }
    elseif kind == "macro" and id then
        local name = GetMacroInfo(id)
        if name then return { kind = "macro", name = name } end
    end
    -- (autre chose : monture, compagnon... montré tel quel)
    if kind or (GetActionTexture and GetActionTexture(storage)) then
        return { kind = "slot", slot = storage }
    end
    return nil
end

-- (la barre ne prend que ce qu'un emplacement d'action prend)
local function Pickup(action)
    local k = action.kind
    if k == "spell" or k == "mount" then
        return (C_Spell and C_Spell.PickupSpell) or PickupSpell, action.id
    elseif k == "item" or k == "toy" then
        return (C_Item and C_Item.PickupItem) or PickupItem, action.id
    elseif k == "macro" then
        return PickupMacro, action.name
    end
end

-- Pose (ou vide : action nil) une case. Renvoie true, ou nil et un message.
function B.Set(bar, i, action)
    if InCombatLockdown() then return nil, L.HUD_COMBAT end
    local util = Util()
    local storage = B.Storage(bar, i)
    if not (util and storage) then
        return nil, B.Available() and L.HUD_GAME_SLOT or L.BAR_UNAVAILABLE
    end
    if not action then
        pcall(util.ClearActionFromGamepadSlot, storage)
        return true
    end
    if action.kind == "slot" then return true end
    local pickup, arg = Pickup(action)
    if not pickup then return nil, L.HUD_KIND end
    local ok = pcall(util.AssignActionToGamepadStandardSlot, storage, pickup, arg)
    ClearCursor()
    if not ok then return nil, L.HUD_KIND end
    return true
end

-- Nombre de cases remplies (et de cases modifiables)
function B.Count(bar)
    local n, total = 0, 0
    for i = 1, 8 do
        if not B.IsGameSlot(bar, i) then
            total = total + 1
            if B.Get(bar, i) then n = n + 1 end
        end
    end
    return n, total
end

---------------------------------------------------------------------------
-- La couche « Seul » entièrement configurable : ce que la barre du jeu ne
-- sait pas tenir (macro écrite à la main, commande WoW, ensemble
-- d'équipement), et toute action sur A/B/X/Y (réservés au jeu), va dans la
-- couche « BASE » de l'addon. Elle ne prend que les cases remplies (liées
-- par Modifier.lua quand le jeu a le focus manette) ; les autres restent
-- au jeu. Vider une case de l'addon rend celle du jeu.
---------------------------------------------------------------------------
B.BASE_BAR = "topBar"

-- L'action de l'addon sur la case i de « Seul », ou nil
function B.Override(i)
    local actions = ns.ButtonActions and ns.cprof and ns.ButtonActions("BASE")
    return actions and actions.combos[B.PAD_KEYS[i]]
end

local function SetOverride(i, action)
    ns.ButtonActions("BASE").combos[B.PAD_KEYS[i]] = action
    ns.Apply()
end

-- Ce que la barre du jeu peut tenir
function B.Holds(action)
    -- (un sort ou un objet avec une cible choisie est une macro de l'addon :
    -- la barre du jeu ne le tient pas)
    if ns.Actions.IsUnit(action.unit) then return false end
    return Pickup(action) ~= nil
end

-- Ce que montre une case : l'action de l'addon, sinon celle du jeu
function B.GetView(bar, i)
    if bar == B.BASE_BAR then
        local own = B.Override(i)
        if own then return own end
    end
    return B.Get(bar, i)
end

-- Pose une case. « Seul » : la barre du jeu quand elle peut, sinon l'addon.
-- Renvoie true, ou nil et un message.
function B.SetView(bar, i, action)
    if bar ~= B.BASE_BAR then return B.Set(bar, i, action) end
    if InCombatLockdown() then return nil, L.HUD_COMBAT end
    if not action then
        -- (vider : d'abord l'action de l'addon, qui rend celle du jeu)
        if B.Override(i) then
            SetOverride(i, nil)
            return true
        end
        if B.IsGameSlot(bar, i) then return true end
        return B.Set(bar, i, nil)
    end
    if action.kind ~= "slot" and (B.IsGameSlot(bar, i) or not B.Holds(action) or not B.Storage(bar, i)) then
        SetOverride(i, action)
        return true
    end
    -- (la barre du jeu le tient : on y écrit, et l'addon rend la main)
    local ok, err = B.Set(bar, i, action)
    if ok and B.Override(i) then SetOverride(i, nil) end
    return ok, err
end

-- Le nom de l'action du jeu sur la case i (sauter...), d'après la liaison
-- de sa touche sans celles de l'addon ; nil si le jeu ne la nomme pas
function B.GameActionName(i)
    local key = B.PAD_KEYS[i]
    if not (key and GetBindingAction) then return nil end
    local ok, command = pcall(GetBindingAction, key, false)
    if not ok or type(command) ~= "string" or command == "" then return nil end
    if issecretvalue and issecretvalue(command) then return nil end
    local name = _G["BINDING_NAME_" .. command]
    if type(name) == "string" and not (issecretvalue and issecretvalue(name)) and name ~= "" then return name end
end

-- Une case réservée au jeu sans action de l'addon (A/B/X/Y de « Seul »)
function B.ShowsGameAction(bar, i)
    return bar == B.BASE_BAR and B.IsGameSlot(bar, i) and not B.Override(i)
end

-- Comme Count, toutes les cases de « Seul » étant modifiables
function B.CountView(bar)
    if bar ~= B.BASE_BAR then return B.Count(bar) end
    local n = 0
    for i = 1, 8 do
        if B.Override(i) or B.Get(bar, i) then n = n + 1 end
    end
    return n, 8
end
