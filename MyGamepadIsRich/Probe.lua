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
