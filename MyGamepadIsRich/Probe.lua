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

function P.Run()
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
