-- /mgir probe : relevé de la configuration manette du client (liaisons,
-- CVars, barre croisée de Forever), écrit dans MyGamepadIsRichDB.probe.
-- Lecture seule : ne modifie rien du jeu (aucune propriété de ses cadres).
-- Le jeu écrit le fichier au /reload. À retirer une fois l'interface faite.
local _, ns = ...

local P = {}
ns.Probe = P

local function Secret(v)
    return type(issecretvalue) == "function" and issecretvalue(v)
end

local function S(v)
    if Secret(v) then return "<hidden>" end
    if v == nil then return "nil" end
    local ok, s = pcall(tostring, v)
    return ok and s or "<?>"
end

local PADS = {
    "PAD1", "PAD2", "PAD3", "PAD4", "PAD5", "PAD6",
    "PADDUP", "PADDDOWN", "PADDLEFT", "PADDRIGHT",
    "PADLSHOULDER", "PADRSHOULDER", "PADLTRIGGER", "PADRTRIGGER",
    "PADLSTICK", "PADRSTICK", "PADBACK", "PADFORWARD", "PADSOCIAL", "PADSYSTEM",
    "PADPADDLE1", "PADPADDLE2", "PADPADDLE3", "PADPADDLE4",
    "NUMPAD1", "NUMPAD2", "NUMPAD3", "NUMPAD4",
}
local PREFIXES = { "", "SHIFT-", "CTRL-", "ALT-", "CTRL-SHIFT-", "ALT-SHIFT-", "ALT-CTRL-" }

local COMMANDS = {
    "JUMP", "INTERACTTARGET", "INTERACTMOUSEOVER", "TARGETNEARESTENEMY", "TARGETSCANENEMY",
    "TARGETPREVIOUSENEMY", "TARGETNEARESTFRIEND", "TOGGLEAUTORUN", "TOGGLEGAMEMENU",
    "GAMEPADLEFTMOD", "GAMEPADRIGHTMOD", "TOGGLEWORLDMAP", "OPENALLBAGS",
}

local function Keys(command)
    if not GetBindingKey then return "" end
    local list = { GetBindingKey(command) }
    for i, k in ipairs(list) do list[i] = S(k) end
    return table.concat(list, ", ")
end

local function TableKeys(t)
    local list = {}
    if type(t) ~= "table" then return "" end
    for k, v in pairs(t) do list[#list + 1] = S(k) .. "=" .. type(v) end
    local mt = getmetatable(t)
    if type(mt) == "table" and type(mt.__index) == "table" then
        for k, v in pairs(mt.__index) do list[#list + 1] = "^" .. S(k) .. "=" .. type(v) end
    end
    table.sort(list)
    return table.concat(list, " ")
end

-- delay : secondes d'attente avant le relevé (le temps de fermer le chat,
-- dont la saisie change l'état des liaisons de Forever)
function P.Run(delay)
    if delay and delay > 0 and C_Timer then
        ns.Print(("Relevé dans %d s : ferme le chat et place-toi."):format(delay))
        C_Timer.After(delay, function() P.Run() end)
        return
    end
    local log = {}
    local function W(fmt, ...)
        local ok, line = pcall(string.format, fmt, ...)
        log[#log + 1] = ok and line or fmt
    end

    local version, build, _, toc = GetBuildInfo()
    W("client %s build %s toc %s", S(version), S(build), S(toc))
    W("issecretvalue %s, combat %s", type(issecretvalue), S(InCombatLockdown()))

    -- Liaisons des boutons de la manette (et des touches du pavé numérique)
    W("== bindings")
    for _, key in ipairs(PADS) do
        local parts = {}
        for _, prefix in ipairs(PREFIXES) do
            local action = GetBindingAction(prefix .. key, true)
            if action and action ~= "" then parts[#parts + 1] = prefix .. key .. "=" .. S(action) end
        end
        W("%s : %s", key, #parts > 0 and table.concat(parts, "  ") or "-")
    end

    W("== commands")
    for i = 1, 12 do
        local c = "GAMEPADACTIONBUTTON" .. i
        W("%s : %s", c, Keys(c))
    end
    for _, c in ipairs(COMMANDS) do W("%s : %s", c, Keys(c)) end
    -- Toutes les commandes dont le nom parle de manette
    if GetNumBindings then
        for i = 1, GetNumBindings() do
            local command, category, key1, key2 = GetBinding(i)
            if command and (command:find("GAMEPAD") or command:find("PAD") or (key1 and tostring(key1):find("^PAD"))) then
                W("binding %s [%s] %s %s", S(command), S(category), S(key1), S(key2))
            end
        end
    end

    W("== cvars")
    for _, name in ipairs({ "GamePadEnable", "GamePadEmulateShift", "GamePadEmulateCtrl", "GamePadEmulateAlt",
        "GamePadEmulateTapWindowMs", "ActionButtonUseKeyDown", "GamePadCursorAutoEnable", "GamePadCursorLeftClick",
        "GamePadCursorRightClick", "GamePadFaceButtonMap", "GamePadAbbreviatedBindingReverse", "GamePadSingleActiveID",
        "gamepadUIEnabled", "GamePadUIEnabled", "GamePadAnalogMovement" }) do
        W("%s = %s", name, S(ns.CVar(name)))
    end

    W("== C_GamePad")
    W("%s", TableKeys(C_GamePad))
    if C_GamePad and C_GamePad.GetActiveDeviceID then
        local ok, id = pcall(C_GamePad.GetActiveDeviceID)
        W("active device %s", S(ok and id))
        if ok and id and C_GamePad.GetDeviceMappedState then
            local ok2, st = pcall(C_GamePad.GetDeviceMappedState, id)
            if ok2 and type(st) == "table" then
                W("mapped: buttons %s axes %s sticks %s", S(st.buttonCount or (st.buttons and #st.buttons)),
                    S(st.axisCount or (st.axes and #st.axes)), S(st.stickCount or (st.sticks and #st.sticks)))
            end
        end
    end
    for _, b in ipairs({ "PAD1", "PADDUP", "PADLSHOULDER", "PADLTRIGGER", "PADRTRIGGER", "PADPADDLE1" }) do
        local ok, i = pcall(C_GamePad and C_GamePad.ButtonBindingToIndex or error, b)
        W("index %s = %s", b, S(ok and i))
    end

    -- État au moment du relevé (ex. près d'un PNJ) : barre active, focus
    -- manette, cases de « Seul » prises par l'addon
    W("== state")
    local mainFrame = _G.GamepadMainActionBarFrame
    local pageUnit = mainFrame and mainFrame.PageUnit
    if type(pageUnit) == "table" then
        local activeName = "?"
        for _, name in ipairs({ "topBar", "leftBar", "rightBar", "bottomBar" }) do
            if pageUnit.actionBars and pageUnit.actionBars[name] == pageUnit.activeBar then activeName = name end
        end
        W("activeBar %s (%s)", activeName, S(pageUnit.activeBar and pageUnit.activeBar.GetName and pageUnit.activeBar:GetName()))
    end
    W("ingame %s", S(ns.Focus and ns.Focus.InGame()))
    local manager = GamepadSharedUtility and GamepadSharedUtility.InputBindingManager
    if manager and manager.IsOnlyCoreBindingSetActive then
        local ok, v = pcall(manager.IsOnlyCoreBindingSetActive, manager)
        W("IsOnlyCoreBindingSetActive %s %s", S(ok), S(v))
    end
    -- Le gestionnaire de liaisons de Forever : le jeu en haut de la pile,
    -- la pile, le jeu de base (sauter, annuler...) et les liaisons actives
    local function Dump(label, t, depth)
        if type(t) ~= "table" then W("%s = %s", label, S(t)) return end
        local n = 0
        for k, v in pairs(t) do
            n = n + 1
            if n > 40 then W("%s ...", label) break end
            if type(v) == "table" and depth > 0 then
                Dump(label .. "." .. S(k), v, depth - 1)
            else
                W("%s.%s = %s", label, S(k), type(v) == "table" and ("{" .. TableKeys(v) .. "}") or S(v))
            end
        end
    end
    if manager then
        if manager.PeekName then
            local ok, name = pcall(manager.PeekName, manager)
            W("PeekName %s %s", S(ok), S(name))
        end
        -- (le nom de chaque jeu de la pile, et ce que chaque touche fait)
        if type(manager.bindingSetStack) == "table" then
            for idx, set in ipairs(manager.bindingSetStack) do
                local keys = {}
                if type(set.bindings) == "table" then
                    for key in pairs(set.bindings) do keys[#keys + 1] = S(key) end
                end
                table.sort(keys)
                W("pile %d %s : %s", idx, S(set.name), table.concat(keys, " "))
            end
        end
        if type(manager.activeBindings) == "table" then
            local lines = {}
            for key, b in pairs(manager.activeBindings) do
                if type(b) == "table" then
                    lines[#lines + 1] = ("%s -> %s [%s] click=%s set=%s"):format(S(key), S(b.name), S(b.type),
                        S(b.buttonToClick), S(type(b.set) == "table" and b.set.name))
                end
            end
            table.sort(lines)
            for _, line in ipairs(lines) do W("liaison %s", line) end
        end
        Dump("stack", manager.bindingSetStack, 2)
        Dump("coreSet", manager.coreSet, 2)
        Dump("activeBindings", manager.activeBindings, 1)
    end

    -- Les boutons A/B/X/Y (côté droit) de la barre « Seul » de Forever
    local top = type(pageUnit) == "table" and pageUnit.actionBars and pageUnit.actionBars.topBar
    for j = 1, 4 do
        local b = top and top.Right and top.Right["ActionButton" .. j]
        if b then
            local parts = {}
            for _, attr in ipairs({ "type", "action", "macro", "macrotext", "spell", "item", "clickbutton", "binding" }) do
                local okA, v = pcall(b.GetAttribute, b, attr)
                if okA and v ~= nil then parts[#parts + 1] = attr .. "=" .. S(type(v) == "table" and (v.GetName and v:GetName()) or v) end
            end
            local icon = b.icon or b.Icon
            local tex = icon and icon.GetTexture and icon:GetTexture()
            local atlas = icon and icon.GetAtlas and icon:GetAtlas()
            W("seul droite %d %s : %s ; icone %s atlas %s ; champs %s", j, S(b.GetName and b:GetName()),
                table.concat(parts, " "), S(tex), S(atlas), TableKeys(b):sub(1, 400))
        end
    end

    for i = 1, 8 do
        local own = ns.Bar and ns.Bar.Override(i)
        local storage = ns.Bar and ns.Bar.Storage("topBar", i)
        local kind, id = nil, nil
        if storage then kind, id = GetActionInfo(storage) end
        W("seul %d %s : addon %s, jeu %s:%s (storage %s, gameSlot %s)", i, S(ns.Bar and ns.Bar.PAD_KEYS[i]),
            own and (S(own.kind) .. ":" .. S(own.id or own.name or own.command)) or "-",
            S(kind), S(id), S(storage), S(ns.Bar and ns.Bar.IsGameSlot("topBar", i)))
    end

    -- Ciblage de Forever : son API et sa logique (fonctions, valeurs)
    W("== targeting")
    W("C_GamepadTargeting: %s", TableKeys(C_GamepadTargeting))
    W("GamepadTargetLogic: %s", TableKeys(GamepadTargetLogic))
    if type(GamepadTargetLogic) == "table" then
        for k, v in pairs(GamepadTargetLogic) do
            if type(v) ~= "function" then
                W("logic.%s = %s", S(k), type(v) == "table" and ("{" .. TableKeys(v):sub(1, 300) .. "}") or S(v))
            end
        end
    end
    -- (les fonctions sans argument qui lisent un état, appelées sans risque)
    if type(C_GamepadTargeting) == "table" then
        for k, fn in pairs(C_GamepadTargeting) do
            if type(fn) == "function" and type(k) == "string" and (k:find("^Get") or k:find("^Is") or k:find("^Has")) then
                local ok, a, b = pcall(fn)
                W("api %s() -> %s %s %s", k, S(ok), S(a), S(b))
            end
        end
    end
    for _, name in ipairs({ "SoftTargetEnemy", "SoftTargetFriend", "SoftTargetInteract", "SoftTargetForce",
        "SoftTargetMatchLocked", "GamePadTargetingEnabled", "gamepadTargeting" }) do
        W("cvar %s = %s", name, S(ns.CVar(name)))
    end

    -- Recharges : valeurs brutes, secrètes ou non, et API d'objet de durée
    W("== cooldowns")
    local function Sec(v) return type(issecretvalue) == "function" and issecretvalue(v) and "SECRET" or S(v) end
    W("api C_Spell.GetSpellCooldownDuration %s, C_ActionBar.GetActionCooldownDuration %s, SetCooldownFromDurationObject %s",
        S(C_Spell and C_Spell.GetSpellCooldownDuration ~= nil), S(C_ActionBar and C_ActionBar.GetActionCooldownDuration ~= nil),
        S(CreateFrame("Cooldown").SetCooldownFromDurationObject ~= nil))
    for i = 1, 8 do
        local storage = ns.Bar and ns.Bar.Storage("topBar", i)
        if storage then
            local start, duration
            if C_ActionBar and C_ActionBar.GetActionCooldown then
                local ok, info = pcall(C_ActionBar.GetActionCooldown, storage)
                if ok and type(info) == "table" then start, duration = info.startTime, info.duration end
            elseif GetActionCooldown then
                local ok, s, d = pcall(GetActionCooldown, storage)
                if ok then start, duration = s, d end
            end
            local kind, id = GetActionInfo(storage)
            W("cd case %d (%s %s) : start %s duration %s", i, S(kind), S(id), Sec(start), Sec(duration))
            if kind == "spell" and id then
                local ok, info = pcall(C_Spell and C_Spell.GetSpellCooldown or GetSpellCooldown, id)
                if ok and type(info) == "table" then
                    W("cd sort %s : start %s duration %s enabled %s", S(id), Sec(info.startTime), Sec(info.duration), Sec(info.isEnabled))
                else
                    W("cd sort %s : %s", S(id), S(ok and info))
                end
            end
        end
    end

    -- Barre croisée de Forever
    W("== crossbar")
    local main = _G.GamepadMainActionBarFrame
    local util = _G.GamepadActionBarBindingUtil
    W("GamepadMainActionBarFrame %s, util %s", type(main), type(util))
    if type(util) == "table" then W("util: %s", TableKeys(util)) end
    if type(main) == "table" then
        W("main: %s", TableKeys(main))
        local pu = main.PageUnit
        if type(pu) == "table" then
            W("PageUnit: %s", TableKeys(pu))
            local ok, page = pcall(pu.GetCurrentPage, pu)
            W("current page %s", S(ok and page))
            if ok and util and util.GetGamepadStorageSlotIndexFromPageAndPageUnitSlotID then
                for _, pg in ipairs({ page, 1 }) do
                    for slot = 1, 40 do
                        local okb, bindable = pcall(util.IsBindablePageUnitSlotID, slot)
                        local oks, storage = pcall(util.GetGamepadStorageSlotIndexFromPageAndPageUnitSlotID, pg, slot)
                        local info = ""
                        if oks and type(storage) == "number" and not Secret(storage) then
                            local kind, id, sub = GetActionInfo(storage)
                            info = S(kind) .. ":" .. S(id) .. ":" .. S(sub)
                        end
                        W("page %s slot %d bindable %s storage %s %s", S(pg), slot, S(okb and bindable),
                            S(oks and storage), info)
                    end
                end
            end
        end
        if main.GetChildren then
            local names = {}
            for _, child in ipairs({ main:GetChildren() }) do
                names[#names + 1] = S(child.GetName and child:GetName()) .. "(" .. S(child.GetObjectType and child:GetObjectType()) .. ")"
            end
            W("children: %s", table.concat(names, " "))
        end
    end

    -- Les globales liées à la manette (cadres, utilitaires)
    W("== globals")
    local found = {}
    for name, value in pairs(_G) do
        if type(name) == "string" and (name:find("Gamepad") or name:find("GamePad") or name:find("Crossbar")
            or name:find("CrossBar")) and not name:find("^BINDING_") then
            found[#found + 1] = name .. ":" .. type(value)
        end
    end
    table.sort(found)
    for i = 1, #found, 6 do
        W("%s", table.concat(found, "  ", i, math.min(i + 5, #found)))
    end
    local manager = GamepadSharedUtility and GamepadSharedUtility.InputBindingManager
    if manager then W("InputBindingManager: %s", TableKeys(manager)) end

    ns.db.probe = log
    ns.Print(("Relevé fait (%d lignes). Tape /reload pour l'enregistrer."):format(#log))
end

---------------------------------------------------------------------------
-- /mgir probe watch : pendant 25 s, note ce qui se passe quand on appuie
-- (boutons internes de Forever, actions de classe LB + LT / RB + RT, focus
-- manette, sorts lancés). Post-hooks seulement (hooksecurefunc, HookScript),
-- sans toucher aux cadres du jeu. Écrit dans MyGamepadIsRichDB.probeWatch.
---------------------------------------------------------------------------
local watching, watchLog, watchStart = false, nil, 0
local hooked = false
local rawHooked = setmetatable({}, { __mode = "k" }) -- (cadres déjà écoutés)
local MAX_LINES = 400

local function WL(fmt, ...)
    if not watching or #watchLog >= MAX_LINES then return end
    local ok, line = pcall(string.format, fmt, ...)
    watchLog[#watchLog + 1] = ("%.2f "):format(GetTime() - watchStart) .. (ok and line or fmt)
end

local CLASS_BUTTONS = { "GamepadMainActionBarFramePageUnitLeftClassAction", "GamepadMainActionBarFramePageUnitRightClassAction" }
local INPUT_BUTTONS = { "PADLSHOULDER", "PADRSHOULDER", "PADLTRIGGER", "PADRTRIGGER", "PAD1", "PAD2", "PAD3", "PAD4" }
local ATTRS = { "type", "action", "spell", "macro", "macrotext", "clickbutton", "unit", "useOnKeyDown", "pressAndHoldAction" }
-- (méthodes trop fréquentes pour être notées)
local NOISY = { "Update", "Refresh", "^Get", "^Is", "^Has", "^Should", "^Can", "OnEvent", "Tick", "Evaluate" }

local function Quiet(name)
    for _, p in ipairs(NOISY) do
        if name:find(p) then return true end
    end
    return false
end

-- Toutes les méthodes (non fréquentes) d'un objet : notées à l'appel
local function HookMethods(obj, label)
    if type(obj) ~= "table" then return 0 end
    local names, n = {}, 0
    local seen = {}
    local function collect(t)
        for k, v in pairs(t) do
            if type(k) == "string" and type(v) == "function" and not seen[k] and not Quiet(k) then
                seen[k] = true
                names[#names + 1] = k
            end
        end
    end
    collect(obj)
    local mt = getmetatable(obj)
    if type(mt) == "table" and type(mt.__index) == "table" then collect(mt.__index) end
    for _, k in ipairs(names) do
        if type(obj[k]) == "function" and pcall(hooksecurefunc, obj, k, function(_, a, b)
            WL("%s:%s(%s, %s)", label, k, S(a), S(b))
        end) then n = n + 1 end
    end
    return n
end

local function Attrs(b)
    local parts = {}
    for _, a in ipairs(ATTRS) do
        local ok, v = pcall(b.GetAttribute, b, a)
        if ok and v ~= nil then parts[#parts + 1] = a .. "=" .. S(v) end
    end
    return table.concat(parts, " ")
end

local function HookAll()
    if hooked then return end
    hooked = true
    for _, name in ipairs(CLASS_BUTTONS) do
        local b = _G[name]
        if b and b.HookScript then
            local short = name:match("PageUnit(.*)$")
            b:HookScript("OnClick", function(self, button, down)
                WL("CLICK %s %s down=%s [%s]", short, S(button), S(down), Attrs(self))
            end)
            pcall(b.HookScript, b, "PreClick", function(_, button, down)
                WL("preclick %s %s down=%s", short, S(button), S(down))
            end)
            local n = HookMethods(b, short)
            WL("hooked %s : %d methods", short, n)
        end
    end
    for _, key in ipairs(INPUT_BUTTONS) do
        local b = _G["InputFunctionBindingButton_" .. key]
        if b and b.HookScript then
            b:HookScript("OnClick", function(_, button, down) WL("input %s %s down=%s", key, S(button), S(down)) end)
        end
    end
    local pu = ns.Bar and ns.Bar.PageUnit()
    WL("hooked PageUnit : %d methods", HookMethods(pu, "PageUnit"))
    local manager = GamepadSharedUtility and GamepadSharedUtility.InputBindingManager
    WL("hooked InputBindingManager : %d methods", HookMethods(manager, "IBM"))
    local logic = _G.GamepadTargetLogic
    WL("hooked GamepadTargetLogic : %d methods", HookMethods(logic, "GTL"))

    local ev = CreateFrame("Frame")
    ev:RegisterEvent("MODIFIER_STATE_CHANGED")
    ev:RegisterUnitEvent("UNIT_SPELLCAST_SENT", "player")
    ev:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
    ev:SetScript("OnEvent", function(_, event, a, b, c, d)
        if event == "MODIFIER_STATE_CHANGED" then
            WL("modifier %s %s", S(a), S(b))
        else
            local id = event == "UNIT_SPELLCAST_SENT" and d or c
            WL("%s spell %s (%s)", event, S(id), S(ns.Actions.SpellInfo(id)))
        end
    end)
end

-- (les changements de focus manette, de couche tenue et de liaison effective)
local watcher = CreateFrame("Frame")
local lastState
watcher:SetScript("OnUpdate", function()
    if not watching then return end
    if GetTime() - watchStart > 25 then
        watching = false
        watcher:Hide()
        ns.db.probeWatch = watchLog
        ns.Print(("Relevé terminé (%d lignes). Tape /reload pour l'enregistrer."):format(#watchLog))
        return
    end
    local held = ns.Modifier.Held and ns.Modifier.Held()
    local state = ("ingame=%s held=%s LT=%s LB=%s"):format(S(ns.Focus.InGame()), S(held),
        S(GetBindingAction("PADLTRIGGER", true)), S(GetBindingAction("PADLSHOULDER", true)))
    if state ~= lastState then
        lastState = state
        WL("state %s", state)
    end
end)
watcher:Hide()

function P.Watch()
    watchLog, watchStart, lastState = {}, GetTime(), nil
    watching = true
    for _, name in ipairs(CLASS_BUTTONS) do
        local b = _G[name]
        if b then
            WL("%s shown=%s protected=%s [%s]", name, S(b:IsShown()), S(b.IsProtected and b:IsProtected()), Attrs(b))
            WL("keys %s", TableKeys(b))
        end
    end
    WL("mixin %s", TableKeys(_G.GamepadClassActionButtonMixin))
    -- Ce qui reçoit la manette avant les raccourcis : les cadres qui
    -- écoutent ses boutons (notés à chaque appui), et l'état de ciblage
    local logic = _G.GamepadTargetLogic
    WL("GTL type=%s keys %s", S(type(logic) == "table" and logic.GetObjectType and logic:GetObjectType()), TableKeys(logic))
    WL("GamepadTargetingState %s", TableKeys(_G.GamepadTargetingState))
    if type(logic) == "table" and type(logic.hudModifierBindings) == "table" then
        for k, v in pairs(logic.hudModifierBindings) do
            WL("GTL hudModifierBindings %s = %s %s", S(k), S(v), type(v) == "table" and TableKeys(v) or "")
        end
    end
    local f = EnumerateFrames and EnumerateFrames()
    local n = 0
    while f and n < 20000 do
        n = n + 1
        local ok, on = pcall(function() return f.IsGamePadButtonEnabled and f:IsGamePadButtonEnabled() end)
        -- (valeur cachée par le jeu : cadre ignoré)
        if ok and not Secret(on) and on == true then
            local okp, prop = pcall(f.GetPropagateKeyboardInput, f)
            local okr, prot = pcall(f.IsProtected, f)
            local okn, rawName = pcall(function() return f.GetDebugName and f:GetDebugName() or f:GetName() end)
            local name = S(okn and rawName or "?")
            WL("gamepad frame %s shown=%s propagate=%s protected=%s", name, S((select(2, pcall(f.IsShown, f)))), S(okp and prop),
                S(okr and prot))
            -- (écouté seulement s'il a déjà un script : en poser un
            -- ferait garder les appuis par ce cadre, sans liaisons)
            local okh, has = pcall(f.GetScript, f, "OnGamePadButtonDown")
            if not rawHooked[f] and okh and has then
                rawHooked[f] = true
                pcall(f.HookScript, f, "OnGamePadButtonDown", function(_, b) WL("raw down %s -> %s", S(b), name) end)
                pcall(f.HookScript, f, "OnGamePadButtonUp", function(_, b) WL("raw up %s -> %s", S(b), name) end)
            end
        end
        f = EnumerateFrames(f)
    end
    WL("frames scanned %d", n)
    -- Les réglages (CVars) de la manette, avec leur valeur
    if C_Console and C_Console.GetAllCommands then
        local okc, all = pcall(C_Console.GetAllCommands)
        if okc and type(all) == "table" then
            for _, c in ipairs(all) do
                local cname = type(c) == "table" and c.command
                if type(cname) == "string" and (cname:lower():find("gamepad") or cname:lower():find("modifier")
                    or cname:lower():find("classaction") or cname:lower():find("flyout")) then
                    WL("cvar %s = %s", cname, S(ns.CVar(cname)))
                end
            end
        end
    end
    HookAll()
    -- Tous les événements du jeu pendant le relevé (sauf les très fréquents)
    if not P.eventFrame then
        local NOISY_EVENTS = { "^COMBAT_LOG", "^UNIT_", "^CHAT_MSG", "^ACTIONBAR_UPDATE", "^SPELL_UPDATE", "^BAG_",
            "^UPDATE_", "^CURSOR", "^NAME_PLATE", "^PLAYER_STARTED", "^PLAYER_STOPPED", "^COMPANION_UPDATE",
            "^SPELL_ACTIVATION", "^MODIFIER_STATE", "^WORLD_CURSOR", "^PLAYER_SOFT", "^ACTION_RANGE", "^ACTION_USABLE",
            "^GLOBAL_MOUSE", "^QUEST_LOG", "^LOSS_OF_CONTROL", "^CVAR_UPDATE" }
        local ef = CreateFrame("Frame")
        ef:SetScript("OnEvent", function(_, event, ...)
            for _, p in ipairs(NOISY_EVENTS) do
                if event:find(p) then return end
            end
            local args = {}
            for i = 1, math.min(select("#", ...), 4) do args[i] = S((select(i, ...))) end
            WL("event %s %s", event, table.concat(args, " "))
        end)
        P.eventFrame = ef
    end
    P.eventFrame:RegisterAllEvents()
    C_Timer.After(26, function() P.eventFrame:UnregisterAllEvents() end)
    watcher:Show()
    ns.Print("Relevé pendant 25 s : ferme le chat, puis LB + LT, LB seul, LT seul, RB + RT (tranquillement).")
end
