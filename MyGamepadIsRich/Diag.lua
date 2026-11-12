-- /mgir etat : l'état des couches à cet instant, dans le chat (à taper
-- quand une couche semble bloquée). Lecture seule.
--
-- Journal des couches : 10 fois par seconde (combat compris), l'état des
-- gâchettes et de la barre de Forever ; une ligne seulement quand il
-- change. Les 120 dernières lignes sont gardées dans
-- MyGamepadIsRichDB.diagLog (écrit par le jeu au /reload ou à la
-- déconnexion), pour comprendre une barre restée bloquée. Lecture seule :
-- rien n'est touché dans le jeu.
-- (les outils de relevé du développement sont dans Probe.lua, hors du .toc :
-- ajouter « Probe.lua » au .toc, après Diag.lua, pour /mgir probe)
local _, ns = ...

local D = {}
ns.Diag = D

local function S(v)
    if type(issecretvalue) == "function" and issecretvalue(v) then return "<hidden>" end
    if v == nil then return "nil" end
    local ok, s = pcall(tostring, v)
    return ok and s or "<?>"
end

-- La barre active de Forever, par son nom
local function ActiveBar()
    local pu = ns.Bar and ns.Bar.PageUnit()
    if not (pu and pu.actionBars) then return "?" end
    for _, name in ipairs(ns.Bar.NAMES or {}) do
        if pu.actionBars[name] ~= nil and pu.actionBars[name] == pu.activeBar then return name end
    end
    return "other"
end

-- (« BIND » : ce que la touche lance, liaisons prioritaires comprises)
local function Binding(key)
    local ok, action = pcall(GetBindingAction, key, true)
    if not ok then return "?" end
    action = S(action)
    -- (raccourcis : les boutons de l'addon et de Forever ont des noms longs)
    action = action:gsub("^CLICK MyGamepadIsRich", "mgir:"):gsub("^CLICK InputFunctionBindingButton_", "forever:")
        :gsub(":LeftButton$", "")
    return action ~= "" and action or "-"
end

local function Sorted(set)
    local out = {}
    for k, v in pairs(set or {}) do out[#out + 1] = (v == true) and k or (k .. "(" .. v .. ")") end
    table.sort(out)
    return #out > 0 and table.concat(out, " ") or "-"
end

function D.State()
    local function Line(label, value) ns.Print(label .. " : " .. value) end
    Line("focus jeu (Forever)", S(ns.Focus.InGame()) .. ", addon " .. S(ns.Modifier.InGameAttribute())
        .. ", combat " .. S(InCombatLockdown()))
    Line("en pause (véhicule, mascottes)", S(ns.Modifier.Suspended()))
    Line("nouveaux rangs", ns.Uprank and ns.Uprank.Auto() and "remplacés sans demander" or "demander")
    Line("vibrations", not (ns.Rumble and ns.Rumble.Available()) and "impossibles (C_GamePad.SetVibration absent)"
        or ns.Rumble.Enabled() and "oui" or "désactivées")
    Line("tenus pour l'addon", Sorted(ns.Modifier.HeldState()))
    Line("couche de l'addon", S(ns.Modifier.Held()))
    local down = ns.Focus.PadsDown()
    Line("enfoncés sur la manette", down and Sorted(down) or "?")
    Line("barre active de Forever", ActiveBar())
    -- (appui bref : allié / ennemi suivant à chaque appui, ou seulement
    -- sans cible valide quand le code sécurisé n'a pas d'horloge)
    local tap = ns.Modifier.TapMode()
    Line("ciblage, appui bref", tap == "clock" and "le plus proche puis le suivant (horloge)"
        or tap == "timer" and "le plus proche puis le suivant (minuteur)"
        or tap == "watch" and "le plus proche puis le suivant (surveillance d'unité, et stick au relâchement)"
        or tap == "stick" and "le plus proche puis le suivant, sauf stick incliné au relâchement"
        or tap == "safe" and "seulement sans cible valide (ni horloge ni minuteur)"
        or "? (à vérifier hors combat)")
    -- (le code protégé peut-il lire la manette : boutons, sticks ?)
    if not InCombatLockdown() and SecureHandlerExecute then
        local probe = D.padProbe or CreateFrame("Frame", nil, UIParent, "SecureHandlerBaseTemplate")
        D.padProbe = probe
        local ok = pcall(SecureHandlerExecute, probe, [[
            local state = GetGamePadState and GetGamePadState()
            self:SetAttribute("gps-pad", state and 1 or 0)
            self:SetAttribute("gps-sticks", state and state.sticks and 1 or 0)
        ]])
        Line("manette lue par le code protégé", ok and (S(probe:GetAttribute("gps-pad") == 1)
            .. ", sticks " .. S(probe:GetAttribute("gps-sticks") == 1)) or "erreur")
    end
    -- (les sticks : nom de configuration et position, pour la visée)
    local api = C_GamePad
    if type(api) == "table" and api.GetDeviceMappedState and api.GetActiveDeviceID then
        local okID, devID = pcall(api.GetActiveDeviceID)
        local ok, state = pcall(api.GetDeviceMappedState, okID and devID or nil)
        if ok and type(state) == "table" and type(state.sticks) == "table" then
            local parts = {}
            for i, s in ipairs(state.sticks) do
                local okName, name = pcall(api.StickIndexToConfigName or error, i - 1)
                local x = type(s) == "table" and tonumber(s.x) or 0
                local y = type(s) == "table" and tonumber(s.y) or 0
                local len = type(s) == "table" and tonumber(s.len)
                parts[#parts + 1] = ("%d:%s(%.2f,%.2f,%s)"):format(i, okName and S(name) or "?", x, y,
                    len and ("%.2f"):format(len) or "-")
            end
            Line("sticks", table.concat(parts, " "))
        else
            Line("sticks", "?")
        end
    end
    Line("stick droit lu pour la visée", S(ns.Focus.RightStick and ns.Focus.RightStick()))
    Line("A est lié à", S(GetBindingAction("PAD1", true)))
    for _, id in ipairs(ns.PAD_IDS) do
        Line(id .. " est lié à", Binding(ns.PAD_KEY[id]))
    end
end

---------------------------------------------------------------------------
-- Journal
---------------------------------------------------------------------------
local LOG_MAX = 120
local lastLine
local t0

local function Log(text)
    if not ns.db then return end
    t0 = t0 or GetTime()
    local log = ns.db.diagLog
    if type(log) ~= "table" then
        log = {}
        ns.db.diagLog = log
    end
    log[#log + 1] = ("%s %.2f %s"):format(date("%H:%M:%S"), GetTime() - t0, text)
    while #log > LOG_MAX do table.remove(log, 1) end
end
D.Log = Log

local function Snapshot()
    local down = ns.Focus.PadsDown()
    local parts = {
        "bar=" .. ActiveBar(),
        "pad=" .. (down and Sorted(down) or "?"),
        "held=" .. Sorted(ns.Modifier.HeldState()),
        "layer=" .. S(ns.Modifier.Held()),
        "ingame=" .. S(ns.Focus.InGame()) .. "/" .. S(ns.Modifier.InGameAttribute()),
        "combat=" .. (InCombatLockdown() and "1" or "0"),
        "suspend=" .. (ns.Modifier.Suspended() and "1" or "0"),
    }
    for _, id in ipairs(ns.PAD_IDS) do
        if ns.PadTaken(id) then parts[#parts + 1] = id .. "=" .. Binding(ns.PAD_KEY[id]) end
    end
    return table.concat(parts, " ")
end

local watcher = CreateFrame("Frame")
local wait = 0
watcher:SetScript("OnUpdate", function(_, elapsed)
    wait = wait - elapsed
    if wait > 0 then return end
    wait = 0.1
    if not (ns.db and ns.prof) then return end
    local ok, line = pcall(Snapshot)
    if not ok then return end
    if line ~= lastLine then
        lastLine = line
        Log(line)
    end
end)

watcher:RegisterEvent("PLAYER_LOGIN")
watcher:RegisterEvent("PLAYER_REGEN_DISABLED")
watcher:RegisterEvent("PLAYER_REGEN_ENABLED")
-- (la cible : pour voir si l'appui bref d'un bouton de ciblage la change)
watcher:RegisterEvent("PLAYER_TARGET_CHANGED")
watcher:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_LOGIN" then
        Log("== connexion " .. ns.Version())
    elseif event == "PLAYER_TARGET_CHANGED" then
        local okName, name = pcall(UnitName, "target")
        local okFriend, friend = pcall(UnitIsFriend, "player", "target")
        local okPlayer, isPlayer = pcall(UnitIsPlayer, "target")
        Log("cible " .. (okName and S(name) or "?") .. " ami=" .. (okFriend and S(friend) or "?")
            .. " joueur=" .. (okPlayer and S(isPlayer) or "?"))
    else
        Log("event " .. event)
    end
end)

ns.OnApplied(function(waiting)
    Log(waiting and "apply (après le combat)" or ("apply, appui bref : " .. S(ns.Modifier.TapMode and ns.Modifier.TapMode())))
end)
