-- Le focus manette de Forever : quand une de ses fenêtres manette (sacs,
-- carte...) a le focus, A/B/X/Y lui appartiennent et nos combinaisons se
-- taisent. Lu toutes les 0,1 s (jamais de callback dans ses listes, ce qui
-- pourrait corrompre son code sécurisé), comme Improved Forever. En combat,
-- les combinaisons restent actives quoi qu'il arrive (les attributs ne
-- peuvent plus changer).
--
-- Les boutons de base donnés à l'addon (LT, RT, LB, RB) ne lui sont liés que
-- quand le jeu a le focus. Un bouton enfoncé d'un côté et relâché de l'autre
-- laisserait une couche bloquée (chez l'addon, ou la barre de Forever) :
-- le focus ne change donc pas tant qu'un de ces boutons est enfoncé, et un
-- bouton noté tenu alors qu'il est relâché sur la manette est libéré.
local _, ns = ...

local F = {}
ns.Focus = F

local inCombat = false

function F.InGame()
    if inCombat then return true end
    local manager = GamepadSharedUtility and GamepadSharedUtility.InputBindingManager
    if not (manager and manager.IsOnlyCoreBindingSetActive) then return true end
    local ok, active = pcall(manager.IsOnlyCoreBindingSetActive, manager)
    if not ok then return true end
    return active and true or false
end

-- L'état physique des boutons de base : { LT = true, ... } (enfoncés), ou
-- nil si le jeu ne le donne pas
local padIndex = {}
local function PadIndex(key)
    if padIndex[key] == nil then
        local ok, i = pcall(C_GamePad and C_GamePad.ButtonBindingToIndex or error, key)
        padIndex[key] = (ok and type(i) == "number") and (i + 1) or false
    end
    return padIndex[key] or nil
end

-- (la manette active, ou toutes réunies ; GetGamePadState n'existe pas
-- partout)
local function PadButtons()
    local api = C_GamePad
    if type(api) == "table" and api.GetDeviceMappedState then
        for _, getID in ipairs({ api.GetActiveDeviceID, api.GetCombinedDeviceID }) do
            local okID, id = pcall(getID or error)
            if okID and id then
                local ok, state = pcall(api.GetDeviceMappedState, id)
                if ok and type(state) == "table" and type(state.buttons) == "table" then return state.buttons end
            end
        end
    end
    if GetGamePadState then
        local ok, state = pcall(GetGamePadState)
        if ok and type(state) == "table" and type(state.buttons) == "table" then return state.buttons end
    end
end

-- Le stick droit : son inclinaison (0 au centre, 1 au bord), ou nil si le
-- jeu ne la donne pas. Sa place dans l'état de la manette vient du nom de
-- configuration de chaque stick (« Right »...), sinon la 2e place
local rightStick
local function RightStickIndex(count)
    if rightStick ~= nil then return rightStick or nil end
    rightStick = false
    local api = C_GamePad
    if type(api) == "table" and api.StickIndexToConfigName then
        for i = 1, count do
            local ok, name = pcall(api.StickIndexToConfigName, i - 1)
            if ok and type(name) == "string" then
                local n = name:lower()
                if n:find("right") or n:find("rstick") or n:find("camera") or n:find("look") then
                    rightStick = i
                    break
                end
            end
        end
    end
    if not rightStick and count >= 2 then rightStick = 2 end
    return rightStick or nil
end

-- La place du stick droit dans l'état de la manette (aussi celle de
-- GetGamePadState, lu par le code protégé), ou nil
function F.RightStickIndex()
    local api = C_GamePad
    if not (type(api) == "table" and api.GetDeviceMappedState and api.GetActiveDeviceID) then return nil end
    local okID, id = pcall(api.GetActiveDeviceID)
    local ok, state = pcall(api.GetDeviceMappedState, okID and id or nil)
    local sticks = ok and type(state) == "table" and state.sticks
    if type(sticks) ~= "table" then return rightStick or nil end
    return RightStickIndex(#sticks)
end

function F.RightStick()
    local api = C_GamePad
    if not (type(api) == "table" and api.GetDeviceMappedState) then return nil end
    for _, getID in ipairs({ api.GetActiveDeviceID, api.GetCombinedDeviceID }) do
        local okID, id = pcall(getID or error)
        if okID and id then
            local ok, state = pcall(api.GetDeviceMappedState, id)
            local sticks = ok and type(state) == "table" and state.sticks
            if type(sticks) == "table" then
                local i = RightStickIndex(#sticks)
                local s = i and sticks[i]
                if type(s) == "table" then
                    local x, y = tonumber(s.x) or 0, tonumber(s.y) or 0
                    return tonumber(s.len) or math.sqrt(x * x + y * y)
                end
                return nil
            end
        end
    end
end

function F.PadsDown()
    local buttons = PadButtons()
    if not buttons then return nil end
    local out = {}
    for id, key in pairs(ns.PAD_KEY) do
        local i = PadIndex(key)
        if i and buttons[i] then out[id] = true end
    end
    return out
end

-- Un bouton de base donné à l'addon est-il enfoncé ?
local function TakenPadDown(down)
    if not down then return false end
    for id in pairs(down) do
        if ns.PadTaken(id) then return true end
    end
    return false
end

-- Pousse l'état vers les modificateurs (hors combat seulement)
function F.Push()
    if InCombatLockdown() then return end
    ns.Modifier.SetInGame(F.InGame())
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:SetScript("OnEvent", function(_, event)
    inCombat = event == "PLAYER_REGEN_DISABLED"
    -- (PLAYER_REGEN_DISABLED arrive juste avant le verrouillage : dernier
    -- moment pour reprendre un bouton rendu à Forever, sans quoi sa couche
    -- de l'addon manquerait pendant tout le combat)
    if inCombat then F.TakeBack() end
    if not InCombatLockdown() then ns.Modifier.SetInGame(F.InGame()) end
end)

-- (un bouton relâché depuis un moment mais encore noté tenu : libéré)
local GRACE = 0.3
local releasedSince = {}

local function Reconcile(down)
    if not down then return end
    local now = GetTime()
    for _, id in ipairs(ns.PAD_IDS) do
        if down[id] or not ns.Modifier.IsHeld(id) then
            releasedSince[id] = nil
        elseif not releasedSince[id] then
            releasedSince[id] = now
        elseif now - releasedSince[id] > GRACE then
            releasedSince[id] = nil
            ns.Modifier.Release(id)
        end
    end
end

-- Forever resté sur sa barre LT / RT / LT + RT (il a reçu l'appui, pas le
-- relâchement) alors que ces boutons sont à l'addon et que rien n'est tenu :
-- on lui rend ces boutons pour un appui, ce qui le remet sur « Seul »
local STUCK_PADS = { leftBar = { "LT" }, rightBar = { "RT" }, bottomBar = { "LT", "RT" } }
local stuckSince, givenBack, warned

local function ForeverBar()
    local pu = ns.Bar and ns.Bar.PageUnit()
    if not (pu and pu.actionBars) then return nil end
    for name in pairs(STUCK_PADS) do
        if pu.actionBars[name] ~= nil and pu.actionBars[name] == pu.activeBar then return name end
    end
end

-- Les boutons rendus à Forever repassent à l'addon (Forever revenu, ou
-- combat qui commence)
function F.TakeBack()
    if not givenBack or InCombatLockdown() then return end
    if ns.Diag then ns.Diag.Log("reprise " .. table.concat(givenBack, "+")) end
    ns.Modifier.GiveBack(givenBack, false)
    givenBack, warned, stuckSince = nil, nil, nil
end

local function CheckStuck(down, inGame)
    local bar = ForeverBar()
    local pads = bar and STUCK_PADS[bar]
    if givenBack then
        -- (Forever est revenu : les boutons repassent à l'addon)
        if not pads then F.TakeBack() end
        return
    end
    local stuck = pads and inGame and down and not next(down) and not next(ns.Modifier.HeldState())
    if stuck then
        for _, id in ipairs(pads) do
            if not ns.PadTaken(id) then stuck = false end
        end
    end
    if not stuck then
        stuckSince = nil
        return
    end
    stuckSince = stuckSince or GetTime()
    if GetTime() - stuckSince < 0.5 then return end
    stuckSince = nil
    givenBack = pads
    if ns.Diag then ns.Diag.Log("bloqué sur " .. bar .. " : rendu à Forever " .. table.concat(pads, "+")) end
    ns.Modifier.GiveBack(pads, true)
    if not warned then
        warned = true
        local names = {}
        for _, id in ipairs(pads) do names[#names + 1] = ns.ButtonLabel(id) end
        local label = table.concat(names, " + ")
        ns.Print(ns.L.FOREVER_STUCK:format(label, label))
    end
end

-- Forever vérifie ses gâchettes à chaque ACTIONBAR_SLOT_CHANGED (un sceau de
-- paladin, une forme... en provoquent un) en lisant l'état réel de la
-- manette : si LT ou RT, donné à l'addon, est tenu à ce moment, il passe sur
-- sa barre LT / RT, puis n'en revient pas au relâchement (il ne le reçoit
-- pas). Tant que LT ou RT est à l'addon, sa barre n'a rien à vérifier (les
-- couches de l'addon remplacent ses barres LT / RT) : elle est désabonnée de
-- cet événement, et réabonnée quand ils reviennent au jeu. Hors combat ;
-- réaffirmé régulièrement si Forever se réabonne de lui-même.
local SLOT_EVENT = "ACTIONBAR_SLOT_CHANGED"
local slotEventCut = false

function F.SyncForeverEvents()
    if InCombatLockdown() then return end
    local pu = ns.Bar and ns.Bar.PageUnit()
    if not (pu and pu.IsEventRegistered) then return end
    -- (en pause — véhicule, mascottes — LT et RT sont à Forever : il reçoit
    -- leur relâchement, il peut garder l'événement)
    local cut = ns.prof ~= nil and (ns.PadTaken("LT") or ns.PadTaken("RT")) and not ns.Modifier.Suspended()
    local okR, registered = pcall(pu.IsEventRegistered, pu, SLOT_EVENT)
    if not okR then return end
    if cut and registered then
        if pcall(pu.UnregisterEvent, pu, SLOT_EVENT) then
            if not slotEventCut and ns.Diag then ns.Diag.Log("Forever désabonné de " .. SLOT_EVENT) end
            slotEventCut = true
        end
    elseif not cut and slotEventCut then
        -- (seulement s'il l'était avant nous)
        if pcall(pu.RegisterEvent, pu, SLOT_EVENT) then
            if ns.Diag then ns.Diag.Log("Forever réabonné à " .. SLOT_EVENT) end
            slotEventCut = false
        end
    end
end

local last, wait = nil, 0
frame:SetScript("OnUpdate", function(_, elapsed)
    wait = wait - elapsed
    if wait > 0 then return end
    wait = 0.1
    if not ns.db or InCombatLockdown() then return end
    F.SyncForeverEvents()
    local down = F.PadsDown()
    Reconcile(down)
    -- (en pause, les gâchettes sont à Forever : rien à débloquer)
    CheckStuck(down, last ~= false and F.InGame() and not ns.Modifier.Suspended())
    local now = F.InGame()
    if now ~= last then
        -- (un bouton de base de l'addon enfoncé : on attend son relâchement,
        -- pour qu'il revienne à qui a reçu l'appui)
        if last ~= nil and TakenPadDown(down) then return end
        last = now
        ns.Modifier.SetInGame(now)
    end
end)
