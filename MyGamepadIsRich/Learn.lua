-- « Détecter » : capture la prochaine touche clavier ou le prochain bouton
-- manette reçu par WoW et l'attribue à un bouton supplémentaire.
local _, ns = ...
local L = ns.L

local Learn = {}
ns.Learn = Learn

local MODIFIER_KEYS = {
    LSHIFT = true, RSHIFT = true, LCTRL = true, RCTRL = true, LALT = true, RALT = true,
    SHIFT = true, CTRL = true, ALT = true,
}
-- (ces boutons de la manette ne sont pas des boutons supplémentaires)
local IGNORED_PAD = { PADFORWARD = true, PADBACK = true, PADSYSTEM = true }

local overlay, targetID, onDone, armedAt

local function Finish(key)
    overlay:EnableKeyboard(false)
    if overlay.EnableGamePadButton then overlay:EnableGamePadButton(false) end
    overlay:Hide()
    local id, cb = targetID, onDone
    targetID, onDone = nil, nil
    if not (key and id) then return end

    local label = ns.ButtonLabel(id)
    -- Une touche, un seul bouton
    local other = ns.ButtonOfKey(key)
    if other and other ~= id then
        ns.prof.buttons[other].key = nil
        ns.Print(L.LEARN_TAKEN:format(ns.KeyLabel(key), ns.ButtonLabel(other)))
    end
    if MODIFIER_KEYS[key] then ns.Print(L.LEARN_MODKEY:format(key)) end
    local bound = GetBindingAction and GetBindingAction(key)
    if bound and bound ~= "" then
        ns.Print(L.LEARN_BOUND:format(ns.KeyLabel(key), ns.Actions.CommandLabel(bound)))
    end
    ns.prof.buttons[id].key = key
    ns.prof.buttons[id].learned = true
    ns.Print(L.LEARN_DONE:format(label, ns.KeyLabel(key)))
    ns.Apply()
    if cb then cb(key) end
end

local function Build()
    overlay = CreateFrame("Frame", "MyGamepadIsRichLearn", UIParent)
    overlay:SetFrameStrata("FULLSCREEN_DIALOG")
    overlay:SetAllPoints(UIParent)
    overlay:EnableMouse(true)
    local bg = overlay:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0, 0, 0, 0.6)
    local text = overlay:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    text:SetPoint("CENTER")
    text:SetJustifyH("CENTER")
    overlay.text = text
    overlay:Hide()

    overlay:SetScript("OnKeyDown", function(self, key)
        if GetTime() < armedAt then return end
        if key == "ESCAPE" then Finish(nil) return end
        Finish(key)
    end)
    overlay:SetScript("OnGamePadButtonDown", function(self, button)
        if GetTime() < armedAt or IGNORED_PAD[button] then return end
        Finish(button)
    end)
    -- (un clic annule)
    overlay:SetScript("OnMouseDown", function() Finish(nil) end)
end

function Learn.Start(id, callback)
    if InCombatLockdown() then ns.Print(L.LEARN_COMBAT) return end
    if not overlay then Build() end
    targetID, onDone = id, callback
    armedAt = GetTime() + 0.2
    overlay.text:SetText(L.LEARN_PROMPT:format(ns.ButtonLabel(id)))
    overlay:Show()
    overlay:EnableKeyboard(true)
    if overlay.SetPropagateKeyboardInput then overlay:SetPropagateKeyboardInput(false) end
    if overlay.EnableGamePadButton then overlay:EnableGamePadButton(true) end
end

function Learn.IsActive()
    return overlay and overlay:IsShown()
end
