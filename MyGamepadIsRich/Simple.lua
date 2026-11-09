-- Mode Bouton simple : la touche du bouton lance une action, une autre si LT
-- est maintenu, une autre si RT est maintenu. Une couche vide ne fait rien
-- (sauf une commande WoW seule, liée directement à la touche : elle part
-- aussi avec LT / RT). Les gâchettes sont lues dans le code sécurisé
-- (GetGamePadState, comme Improved Forever), donc ça marche en combat.
local _, ns = ...

local S = {}
ns.Simple = S

local buttons = {} -- [id] = bouton d'action

local PRECLICK = [[
    if not down ~= not self:GetAttribute("gps-down") then return false end
    local layer = "base"
    local state = GetGamePadState()
    local pad = state and state.buttons
    if pad then
        local lt, rt = self:GetAttribute("gps-lt"), self:GetAttribute("gps-rt")
        if lt and pad[lt] then
            layer = "lt"
        elseif rt and pad[rt] then
            layer = "rt"
        end
    end
    if not self:GetAttribute("has-" .. layer) then return false end
    self:SetAttribute("type", "macro")
    self:SetAttribute("macro", self:GetAttribute(layer .. "-macro"))
    self:SetAttribute("macrotext", self:GetAttribute(layer .. "-macrotext"))
]]

-- La place d'un bouton dans GetGamePadState().buttons
local function PadIndex(button)
    if not (C_GamePad and C_GamePad.ButtonBindingToIndex) then return nil end
    local ok, index = pcall(C_GamePad.ButtonBindingToIndex, button)
    return ok and index and (index + 1) or nil
end

local function Button(id)
    local b = buttons[id]
    if b then return b end
    b = CreateFrame("Button", "MyGamepadIsRichSimple" .. id, UIParent, "SecureActionButtonTemplate")
    b:SetSize(1, 1)
    b:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -20, 20)
    b:RegisterForClicks("AnyDown", "AnyUp")
    b:SetAttribute("type", "macro")
    SecureHandlerWrapScript(b, "OnClick", b, PRECLICK)
    -- (pour le HUD : la case s'allume pendant l'appui)
    b:HookScript("OnClick", function(_, _, down)
        if ns.Hud then ns.Hud.Pressed(id, down) end
    end)
    buttons[id] = b
    return b
end

-- Une commande WoW n'est possible que seule (couche « Seul » sans LT/RT)
function S.CommandAllowed(actions, layer)
    if layer ~= "base" then return false end
    return not actions.layers.lt and not actions.layers.rt
end

-- Hors combat : prépare le bouton et dit quoi lier à sa touche. Renvoie le
-- nom du bouton à cliquer, ou nil et la commande WoW (une commande seule),
-- ou rien (aucune action)
function S.Prepare(id, actions, onDown)
    local base = actions.layers.base
    -- Une commande seule : liaison directe
    if ns.Actions.IsCommand(base) and S.CommandAllowed(actions, "base") then
        return nil, ns.Actions.CommandOf(base)
    end
    local b = Button(id)
    b:SetAttribute("gps-down", onDown)
    b:SetAttribute("useOnKeyDown", onDown)
    -- (LT / RT en bouton simple ne lisent pas leur propre gâchette : elle est
    -- forcément enfoncée quand on appuie dessus)
    b:SetAttribute("gps-lt", id ~= "LT" and PadIndex("PADLTRIGGER") or nil)
    b:SetAttribute("gps-rt", id ~= "RT" and PadIndex("PADRTRIGGER") or nil)
    local any = false
    for _, layer in ipairs(ns.LAYERS) do
        local action = actions.layers[layer]
        local macro, text
        if action and not ns.Actions.IsCommand(action) then
            macro, text = ns.Actions.Secure(action)
        end
        b:SetAttribute(layer .. "-macro", macro)
        b:SetAttribute(layer .. "-macrotext", text)
        b:SetAttribute("has-" .. layer, (macro or text) and true or nil)
        if macro or text then any = true end
    end
    if any then return b:GetName() end
end

-- Un bouton supplémentaire : sa touche (du logiciel de la manette) liée tout
-- le temps
function S.Setup(owner, id, def, actions, onDown)
    local click, command = S.Prepare(id, actions, onDown)
    if click then
        SetOverrideBindingClick(owner, true, def.key, click, "LeftButton")
    elseif command then
        SetOverrideBinding(owner, true, def.key, command)
    end
end

function S.Disable(id)
    -- (les liaisons appartiennent au propriétaire commun, vidé par ns.Apply)
end
