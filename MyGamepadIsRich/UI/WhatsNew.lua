-- « Nouveautés » : après une mise à jour, une fenêtre dit ce qui a changé
-- (une fois). Pas à la première installation : le tutoriel s'en charge.
-- On la revoit avec /mgir news.
local _, ns = ...
local L = ns.L
local UI = ns.UI

local W = {}
ns.WhatsNew = W

-- Les versions qui ont des nouveautés à montrer, de la plus récente à la
-- plus ancienne (clé du texte dans les Locales). Une note par version
-- publiée : la 1.1.0 reprend tout ce qui a changé depuis la 1.0.0.
local NOTES = {
    { version = "1.3.0", text = "WHATSNEW_1_3_0" },
    { version = "1.2.0", text = "WHATSNEW_1_2_0" },
    { version = "1.1.6", text = "WHATSNEW_1_1_6" },
    { version = "1.1.5", text = "WHATSNEW_1_1_5" },
    { version = "1.1.4", text = "WHATSNEW_1_1_4" },
    { version = "1.1.3", text = "WHATSNEW_1_1_3" },
    { version = "1.1.2", text = "WHATSNEW_1_1_2" },
    { version = "1.1.1", text = "WHATSNEW_1_1_1" },
    { version = "1.1.0", text = "WHATSNEW_1_1_0" },
}

-- « 1.10.2 » > « 1.9 » : comparaison nombre par nombre
local function Newer(a, b)
    local x, y = {}, {}
    for n in tostring(a):gmatch("%d+") do x[#x + 1] = tonumber(n) end
    for n in tostring(b):gmatch("%d+") do y[#y + 1] = tonumber(n) end
    for i = 1, math.max(#x, #y) do
        local p, q = x[i] or 0, y[i] or 0
        if p ~= q then return p > q end
    end
    return false
end

-- Le texte des versions plus récentes que since (toutes si since est nil)
local function Text(since)
    local parts = {}
    for _, note in ipairs(NOTES) do
        if not since or Newer(note.version, since) then
            parts[#parts + 1] = "|cffffd100" .. note.version .. "|r\n" .. L[note.text]
        end
    end
    return #parts > 0 and table.concat(parts, "\n\n") or nil
end

-- Où donner son avis (les tickets du dépôt), montré sous les nouveautés
local FEEDBACK_URL = "https://github.com/Nolween/my-gamepad-is-rich/issues"

local dialog
function W.Open(since)
    local text = Text(since)
    if not text then return end
    if not dialog then
        local d = UI.Dialog("MyGamepadIsRichWhatsNew", 540, 450, L.WHATSNEW_TITLE)
        local scroll = CreateFrame("ScrollFrame", nil, d, "UIPanelScrollFrameTemplate")
        scroll:SetPoint("TOPLEFT", 18, -44)
        scroll:SetPoint("BOTTOMRIGHT", -36, 118)
        local body = CreateFrame("Frame", nil, scroll)
        body:SetSize(540 - 18 - 36, 10)
        d.text = UI.Text(body, "GameFontHighlight")
        d.text:SetPoint("TOPLEFT")
        d.text:SetWidth(540 - 18 - 36)
        d.text:SetJustifyH("LEFT")
        d.text:SetSpacing(2)
        scroll:SetScrollChild(body)
        d.body = body
        local close = UI.Button(d, L.CLOSE, 120, 24)
        close:SetPoint("BOTTOM", 0, 14)
        close:SetScript("OnClick", function() d:Hide() end)
        -- (sous les nouveautés : un avis, une idée, un bug ? Le lien à copier,
        -- remis tel quel si on le modifie)
        local line = d:CreateTexture(nil, "ARTWORK")
        line:SetColorTexture(1, 0.82, 0, 0.25)
        line:SetHeight(1)
        line:SetPoint("BOTTOMLEFT", 18, 108)
        line:SetPoint("BOTTOMRIGHT", -18, 108)
        local feedback = UI.Text(d, "GameFontNormal", L.WHATSNEW_FEEDBACK)
        feedback:SetPoint("BOTTOMLEFT", 20, 74)
        feedback:SetPoint("RIGHT", -20, 0)
        feedback:SetJustifyH("LEFT")
        local link = CreateFrame("EditBox", nil, d, "InputBoxTemplate")
        link:SetSize(540 - 60, 20)
        link:SetPoint("BOTTOM", 0, 48)
        link:SetAutoFocus(false)
        link:SetText(FEEDBACK_URL)
        link:SetCursorPosition(0)
        link:SetScript("OnTextChanged", function(self, user)
            if user then self:SetText(FEEDBACK_URL) self:HighlightText() end
        end)
        link:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
        link:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
        link:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
        dialog = d
    end
    dialog.text:SetText(text)
    dialog.body:SetHeight(dialog.text:GetStringHeight() + 4)
    dialog:Show()
end

-- À la connexion : la fenêtre si l'addon a été mis à jour depuis la
-- dernière fois (le tutoriel, s'il s'ouvre, passe avant : rien d'autre)
function W.MaybeShow()
    -- (en combat : ce sera pour la prochaine connexion)
    if not ns.db or InCombatLockdown() then return end
    local current, last = ns.Version(), ns.db.lastVersion
    ns.db.lastVersion = current
    if ns.Tutorial and (ns.db.tutorialSeen or 0) < ns.Tutorial.VERSION then return end
    -- (rien de noté : installé avant que l'addon ne retienne sa version,
    -- donc une mise à jour depuis la 1.0.0, la seule publiée sans elle)
    if last == nil then last = "1.0.0" end
    if Newer(current, last) then W.Open(last) end
end
