-- Export / import d'un profil : une ligne de texte à copier-coller.
--
--   !MGIR1! + somme de contrôle (8 hexa) + base64(données sérialisées)
--
-- Le sérialiseur est fait maison et ne fait que lire : jamais de loadstring,
-- une chaîne reçue d'un inconnu ne peut pas exécuter de code. À l'import,
-- les données sont reconstruites champ par champ depuis une liste blanche
-- (emplacements, modes, touches, types d'action...) ; tout le reste est
-- ignoré. Le base64 survit aux copier-coller (Discord, forums) ; la somme de
-- contrôle repère une chaîne tronquée ou abîmée.
local _, ns = ...
local L = ns.L

local S = {}
ns.Serialize = S

local PREFIX = "!MGIR1!"
local FORMAT = 1
local MAX_TEXT = 100000   -- (une chaîne d'export fait quelques Ko)
local MAX_DEPTH = 12
local MAX_ITEMS = 4000
local floor = math.floor

---------------------------------------------------------------------------
-- Sérialisation : s<long>:<octets>  n<nombre>;  t  f  { clé valeur ... }
---------------------------------------------------------------------------
local function KeyOrder(a, b)
    local ta, tb = type(a), type(b)
    if ta ~= tb then return ta < tb end
    return a < b
end

local SERIALIZABLE = { string = true, number = true, boolean = true, table = true }

local function Write(v, out)
    local t = type(v)
    if t == "string" then
        out[#out + 1] = "s" .. #v .. ":" .. v
    elseif t == "number" then
        out[#out + 1] = "n" .. ("%.17g"):format(v) .. ";"
    elseif t == "boolean" then
        out[#out + 1] = v and "t" or "f"
    elseif t == "table" then
        out[#out + 1] = "{"
        -- (clés triées : la même config donne toujours la même chaîne)
        local keys = {}
        for k, val in pairs(v) do
            if (type(k) == "string" or type(k) == "number") and SERIALIZABLE[type(val)] then
                keys[#keys + 1] = k
            end
        end
        table.sort(keys, KeyOrder)
        for _, k in ipairs(keys) do
            Write(k, out)
            Write(v[k], out)
        end
        out[#out + 1] = "}"
    end
end

local function Serialize(v)
    local out = {}
    Write(v, out)
    return table.concat(out)
end

-- Renvoie valeur, position suivante ; position nil = chaîne invalide
local function Read(s, pos, depth, budget)
    budget.n = budget.n + 1
    if depth > MAX_DEPTH or budget.n > MAX_ITEMS then return nil, nil end
    local c = s:sub(pos, pos)
    if c == "s" then
        local len, start = s:match("^(%d+):()", pos + 1)
        if not len then return nil, nil end
        local stop = start + tonumber(len) - 1
        if stop > #s then return nil, nil end
        return s:sub(start, stop), stop + 1
    elseif c == "n" then
        local text, after = s:match("^([%d%.eE%+%-]+);()", pos + 1)
        local n = text and tonumber(text)
        if not n then return nil, nil end
        return n, after
    elseif c == "t" then
        return true, pos + 1
    elseif c == "f" then
        return false, pos + 1
    elseif c == "{" then
        local t = {}
        pos = pos + 1
        while true do
            if pos > #s then return nil, nil end
            if s:sub(pos, pos) == "}" then return t, pos + 1 end
            local k, v
            k, pos = Read(s, pos, depth + 1, budget)
            if not pos or (type(k) ~= "string" and type(k) ~= "number") then return nil, nil end
            v, pos = Read(s, pos, depth + 1, budget)
            if not pos then return nil, nil end
            t[k] = v
        end
    end
    return nil, nil
end

local function Deserialize(s)
    local v, pos = Read(s, 1, 0, { n = 0 })
    if not pos or pos ~= #s + 1 then return nil end
    return v
end

---------------------------------------------------------------------------
-- Base64 et somme de contrôle (Adler-32)
---------------------------------------------------------------------------
local ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local DEC = {}
for i = 1, 64 do DEC[ALPHA:byte(i)] = i - 1 end

local function Char64(n)
    return ALPHA:sub(n + 1, n + 1)
end

local function Encode(s)
    local out = {}
    for i = 1, #s, 3 do
        local a, b, c = s:byte(i, i + 2)
        local n = a * 65536 + (b or 0) * 256 + (c or 0)
        out[#out + 1] = Char64(floor(n / 262144) % 64) .. Char64(floor(n / 4096) % 64)
            .. (b and Char64(floor(n / 64) % 64) or "=") .. (c and Char64(n % 64) or "=")
    end
    return table.concat(out)
end

local function Decode(s)
    if #s % 4 ~= 0 then return nil end
    local out = {}
    for i = 1, #s, 4 do
        local n, pad = 0, 0
        for j = 0, 3 do
            local ch = s:byte(i + j)
            local v
            if ch == 61 then -- ("=" : seulement dans les 2 derniers caractères)
                if i + 3 ~= #s or j < 2 then return nil end
                pad, v = pad + 1, 0
            else
                if pad > 0 then return nil end
                v = DEC[ch]
                if not v then return nil end
            end
            n = n * 64 + v
        end
        out[#out + 1] = string.char(floor(n / 65536) % 256)
        if pad < 2 then out[#out + 1] = string.char(floor(n / 256) % 256) end
        if pad < 1 then out[#out + 1] = string.char(n % 256) end
    end
    return table.concat(out)
end

local function Checksum(s)
    local a, b = 1, 0
    for i = 1, #s do
        a = (a + s:byte(i)) % 65521
        b = (b + a) % 65521
    end
    return ("%04x%04x"):format(b, a)
end

local function Pack(data)
    local payload = Serialize(data)
    return PREFIX .. Checksum(payload) .. Encode(payload)
end

---------------------------------------------------------------------------
-- Nettoyage d'un import (liste blanche)
---------------------------------------------------------------------------
local MODES = { modifier = true, target_friend = true, target_enemy = true, simple = true, off = true }

-- Un texte affichable : ni caractère de contrôle ni « | » (codes couleur,
-- textures), coupé sans casser un caractère accentué
local function CleanString(s, max)
    if type(s) ~= "string" then return nil end
    s = strtrim((s:gsub("%c", ""):gsub("|", "")))
    s = ns.Utf8Cut(s, max)
    return s ~= "" and s or nil
end

local function CleanKey(k)
    if type(k) ~= "string" or #k > 32 or not k:match("^[%w%-]+$") then return nil end
    return k
end

local function CleanID(n)
    if type(n) ~= "number" or n ~= floor(n) or n <= 0 or n >= 2147483648 then return nil end
    return n
end

-- Une icône choisie : un numéro de fichier, ou un chemin de texture du jeu
local function CleanIcon(icon)
    if type(icon) == "number" then return CleanID(icon) end
    if type(icon) == "string" and #icon <= 128 and icon:match("^[Ii]nterface[\\/][%w_%-%.\\/]+$") then
        return icon
    end
    return nil
end

-- Les commandes WoW qui existent dans ce jeu
local knownCommands
local function KnownCommand(command)
    if not knownCommands then
        knownCommands = {}
        for _, e in ipairs(ns.Actions.Commands()) do knownCommands[e.action.command] = true end
    end
    return knownCommands[command]
end

-- Une action, d'après les types d'Actions.lua ; nil si invalide
local function CleanAction(a)
    if type(a) ~= "table" then return nil end
    local k = a.kind
    if k == "spell" then
        local id = CleanID(a.id)
        if id then return { kind = k, id = id, name = CleanString(a.name, 64), rank = CleanString(a.rank, 32) } end
    elseif k == "mount" then
        local id = CleanID(a.id)
        if id then return { kind = k, id = id, mountID = CleanID(a.mountID), name = CleanString(a.name, 64) } end
    elseif k == "item" or k == "toy" then
        local id = CleanID(a.id)
        if id then return { kind = k, id = id } end
    elseif k == "macro" or k == "equipset" then
        local name = CleanString(a.name, 64)
        if name then return { kind = k, name = name } end
    elseif k == "macrotext" then
        if type(a.text) == "string" and #a.text <= 255 then
            -- (les retours à la ligne restent : une commande par ligne)
            local text = a.text:gsub("\r", ""):gsub("[%z\1-\9\11-\31\127]", "")
            if strtrim(text) ~= "" then return { kind = k, text = text, icon = CleanIcon(a.icon) } end
        end
    elseif k == "game" then
        -- (une action de base connue : sa commande ou sa macro vient de l'addon)
        if type(a.id) == "string" and ns.Actions.GameDef(a.id) then return { kind = k, id = a.id } end
    elseif k == "command" then
        local c = a.command
        if type(c) == "string" and #c <= 64 and c:match("^[%w_]+$") and KnownCommand(c) then
            return { kind = k, command = c, icon = CleanIcon(a.icon) }
        end
    end
    return nil
end

local function CleanActions(raw)
    if type(raw) ~= "table" then return nil end
    local out, count = {}, 0
    for _, id in ipairs(ns.LIST_IDS) do
        local a = raw[id]
        if type(a) == "table" then
            local entry = { combos = {}, layers = {} }
            -- (cases : la croix et A/B/X/Y, puis une par bouton simple possible)
            for _, list in ipairs({ ns.PAD_KEYS, ns.BUTTON_IDS, ns.PAD_IDS }) do
                for _, slot in ipairs(list) do
                    local action = type(a.combos) == "table" and CleanAction(a.combos[slot])
                    if action then entry.combos[slot], count = action, count + 1 end
                end
            end
            for _, layer in ipairs(ns.LAYERS) do
                local action = type(a.layers) == "table" and CleanAction(a.layers[layer])
                if action then entry.layers[layer], count = action, count + 1 end
            end
            out[id] = entry
        end
    end
    return count > 0 and out or nil
end

local function Clean(raw)
    if type(raw) ~= "table" then return nil, L.IMPORT_DAMAGED end
    if raw.v ~= FORMAT then return nil, L.IMPORT_VERSION end
    local data = {
        name = CleanString(raw.name, ns.Profiles.NAME_MAX) or L.PROFILE_IMPORTED,
        controller = ns.ControllerDef(type(raw.controller) == "string" and raw.controller or nil).id,
        buttons = {},
        -- (boutons de base : modes connus seulement ; absents = mode par défaut)
        pads = ns.Profiles.FillPads(raw.pads),
        -- (paires choisies : ids connus seulement ; absentes = par défaut)
        pairs = ns.Profiles.CleanPairs(raw.pairs),
    }
    -- (exports 1.5 : « triggers = modifier » donnait LT et RT en modificateurs)
    if raw.triggers == "modifier" then
        data.pads.LT = data.pads.LT or "modifier"
        data.pads.RT = data.pads.RT or "modifier"
    end
    local buttons = type(raw.buttons) == "table" and raw.buttons or {}
    for _, slot in ipairs(ns.BUTTON_IDS) do
        local b = type(buttons[slot]) == "table" and buttons[slot] or {}
        local key = CleanKey(b.key)
        data.buttons[slot] = {
            mode = MODES[b.mode] and b.mode or ns.DEFAULT_BUTTONS[slot].mode,
            key = key,
            learned = key and true or nil,
            name = CleanString(b.name, 24),
            -- (modificateur verrouillable : un appui active, un autre quitte)
            latch = b.latch == true or nil,
        }
    end
    data.actions = CleanActions(raw.actions)
    if raw.hud ~= nil and ns.Hud then data.hud = ns.Hud.CleanSettings(raw.hud) end
    return data
end

---------------------------------------------------------------------------
-- Export
---------------------------------------------------------------------------
-- Les actions sans les couches vides ; nil s'il n'y en a aucune
local function PruneActions(actions)
    if type(actions) ~= "table" then return nil end
    local out, any = {}, false
    for _, id in ipairs(ns.LIST_IDS) do
        local a = actions[id]
        if type(a) == "table" and (next(a.combos or {}) or next(a.layers or {})) then
            out[id] = { combos = ns.DeepCopy(a.combos or {}), layers = ns.DeepCopy(a.layers or {}) }
            any = true
        end
    end
    return any and out or nil
end
S.PruneActions = PruneActions -- (aussi pour les modèles de classe, Profiles.lua)

-- opts.actions : celles de ce personnage ; opts.hud : les réglages du HUD
function S.Export(profileID, opts)
    local prof = ns.Profiles.Get(profileID)
    if not prof then return nil end
    opts = opts or {}
    local data = { v = FORMAT, name = prof.name, controller = prof.controller, buttons = {},
        pads = ns.Profiles.CleanPads(prof.pads), pairs = ns.Profiles.CleanPairs(prof.pairs) }
    for _, slot in ipairs(ns.BUTTON_IDS) do
        local b = prof.buttons[slot]
        data.buttons[slot] = { mode = b.mode, key = b.key, name = b.name, latch = b.latch or nil }
    end
    if opts.actions then
        local c = ns.char.profiles[profileID]
        data.actions = PruneActions(c and c.actions)
    end
    if opts.hud and ns.Hud then data.hud = ns.Hud.ExportSettings() end
    return Pack(data)
end

---------------------------------------------------------------------------
-- Import : renvoie les données nettoyées et leur résumé, ou nil + erreur
---------------------------------------------------------------------------
function S.Summary(data)
    local sum = {
        name = data.name,
        controller = ns.ControllerName(ns.ControllerDef(data.controller)),
        keys = 0, actions = 0, macros = {}, commands = {}, hud = data.hud ~= nil,
        pads = {},
    }
    -- (les boutons de base donnés à l'addon : « LB : Cible alliée »...)
    for _, id in ipairs(ns.PAD_IDS) do
        local mode = data.pads and data.pads[id]
        if mode then sum.pads[#sum.pads + 1] = id .. " : " .. ns.ModeLabel(mode) end
    end
    for _, slot in ipairs(ns.BUTTON_IDS) do
        if data.buttons[slot].key then sum.keys = sum.keys + 1 end
    end
    for _, id in ipairs(ns.LIST_IDS) do
        local a = data.actions and data.actions[id]
        if a then
            for _, group in ipairs({ a.combos, a.layers }) do
                for _, action in pairs(group) do
                    sum.actions = sum.actions + 1
                    if action.kind == "macrotext" then
                        sum.macros[#sum.macros + 1] = action.text
                    elseif action.kind == "command" then
                        sum.commands[#sum.commands + 1] = ns.Actions.CommandLabel(action.command)
                    end
                end
            end
        end
    end
    return sum
end

function S.Import(text)
    text = (text or ""):gsub("%s", "")
    if text == "" then return nil, L.IMPORT_EMPTY end
    if #text > MAX_TEXT then return nil, L.IMPORT_BAD end
    if text:sub(1, #PREFIX) ~= PREFIX then
        if text:match("^!MGIR%d+!") then return nil, L.IMPORT_VERSION end
        return nil, L.IMPORT_BAD
    end
    local sum, body = text:sub(#PREFIX + 1, #PREFIX + 8):lower(), text:sub(#PREFIX + 9)
    local payload = Decode(body)
    if not payload or Checksum(payload) ~= sum then return nil, L.IMPORT_DAMAGED end
    local data, err = Clean(Deserialize(payload))
    if not data then return nil, err end
    return data, S.Summary(data)
end

---------------------------------------------------------------------------
-- /mgir selftest : aller-retour du profil actif, et chaînes abîmées ou
-- forgées (outil de développement, comme /mgir probe)
---------------------------------------------------------------------------
function S.SelfTest()
    local fails = {}
    local function Check(ok, label)
        if not ok then fails[#fails + 1] = label end
    end

    -- Base64 : toutes les longueurs de reste
    for n = 0, 7 do
        local s = ("\0\255a\128z\1b"):sub(1, n)
        Check(Decode(Encode(s)) == s, "base64 " .. n)
    end

    -- Aller-retour du profil actif (actions et HUD compris)
    local id = ns.Profiles.ActiveID()
    local text = S.Export(id, { actions = true, hud = true })
    local data, info = S.Import(text)
    Check(data ~= nil, "import: " .. tostring(info))
    if data then
        Check(data.controller == ns.prof.controller, "controller")
        Check(Serialize(data.pads) == Serialize(ns.Profiles.FillPads(ns.prof.pads)), "pads")
        Check(Serialize(data.pairs) == Serialize(ns.Profiles.CleanPairs(ns.prof.pairs)), "pairs")
        for _, slot in ipairs(ns.BUTTON_IDS) do
            local a, b = ns.prof.buttons[slot], data.buttons[slot]
            Check(a.mode == b.mode and a.key == b.key and a.name == b.name
                and (a.latch == true) == (b.latch == true), "button " .. slot)
        end
        local c = ns.char.profiles[id]
        Check(Serialize(PruneActions(c and c.actions) or {}) == Serialize(data.actions or {}), "actions")
        Check(Serialize(ns.Hud.CleanSettings(ns.Hud.ExportSettings())) == Serialize(data.hud), "hud")
    end

    -- Chaînes abîmées
    Check(S.Import(text:sub(1, #text - 8)) == nil, "truncated")
    Check(S.Import(PREFIX .. "00000000" .. text:sub(#PREFIX + 9)) == nil, "checksum")
    Check(S.Import("hello") == nil, "garbage")
    Check(S.Import("!MGIR9!abcd") == nil, "version")
    Check(S.Import(PREFIX .. Checksum("x") .. Encode("x")) == nil, "not a table")

    -- Données forgées : tout ce qui n'est pas dans la liste blanche disparaît
    local forged = Pack({
        v = FORMAT, name = "A|cffff0000B\1", controller = "nope",
        buttons = { L5 = { mode = "weird", key = "F9 /run", latch = "yes" },
            R5 = { mode = "simple", key = "F10" }, L4 = { mode = "modifier", key = "F11", latch = true } },
        actions = { L5 = { combos = {
            PAD1 = { kind = "evil" },
            PAD2 = { kind = "macrotext", text = ("a"):rep(300) },
            PAD3 = { kind = "spell", id = 133 },
            PAD4 = { kind = "command", command = "NOT_A_BINDING" },
            PAD5 = { kind = "command", command = "JUMP", icon = 136243 },
            PAD6 = { kind = "macrotext", text = "/dance", icon = "Interface\\Icons\\X|cffff0000" },
        }, layers = { nope = { kind = "item", id = 6948 } } }, ZZ = { combos = {} } },
        hud = { scale = 99, strip = "side", pos = { "EVIL", "TOP", 1, 2 },
            order = { "bar:topBar", "evil", "mod:L5", "mod:L5", "bar:nope", "mod:ZZ", 7, "mod:L5R5" } },
        pads = { LB = "target_friend", RB = "evil", LT = 5, XX = "modifier" },
        pairs = { L5LT = true, ZZ = true, LBRB = "yes", L5L5 = true },
    })
    local d = S.Import(forged)
    Check(d ~= nil, "forged import")
    if d then
        Check(d.name == "Acffff0000B", "forged name")
        Check(d.controller == "other", "forged controller")
        Check(d.pads.LB == "target_friend" and d.pads.RB == "target_enemy" and d.pads.LT == "modifier" and d.pads.XX == nil, "forged pads")
        Check(Serialize(d.pairs) == Serialize({ L5LT = true }), "forged pairs")
        Check(d.buttons.L5.mode == ns.DEFAULT_BUTTONS.L5.mode and d.buttons.L5.key == nil, "forged L5")
        Check(d.buttons.R5.mode == "simple" and d.buttons.R5.key == "F10", "forged R5")
        Check(d.buttons.L5.latch == nil and d.buttons.L4.latch == true, "forged latch")
        local combos = d.actions and d.actions.L5 and d.actions.L5.combos or {}
        Check(combos.PAD1 == nil and combos.PAD2 == nil and combos.PAD4 == nil, "forged actions dropped")
        Check(combos.PAD3 and combos.PAD3.id == 133, "forged spell kept")
        Check(combos.PAD5 and combos.PAD5.icon == 136243, "icon kept")
        Check(combos.PAD6 and combos.PAD6.icon == nil, "forged icon dropped")
        Check(next(d.actions.L5.layers) == nil and d.actions.ZZ == nil, "forged layers")
        Check(d.hud.scale == 2 and d.hud.strip == "bottom" and d.hud.pos == nil, "forged hud")
        Check(Serialize(d.hud.order) == Serialize({ "bar:topBar", "mod:L5", "mod:L5R5" }), "forged hud order")
    end

    if #fails == 0 then
        ns.Print(L.SELFTEST_OK)
    else
        ns.Print(L.SELFTEST_FAIL:format(#fails, table.concat(fails, ", ")))
    end
end
