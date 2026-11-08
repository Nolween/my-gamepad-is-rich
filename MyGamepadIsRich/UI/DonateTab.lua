-- Onglet « Soutenir » : un don PayPal facultatif, par QR code (à scanner
-- avec un téléphone) ou par le lien, à copier (WoW n'ouvre pas de navigateur).
local addonName, ns = ...
local L = ns.L
local UI = ns.UI

local DONATE_URL = "https://www.paypal.com/qrcodes/managed/07f4d316-e214-42f2-b49a-3b5027aa5b0b?utm_source=consweb_more"
local QR_TEXTURE = "Interface\\AddOns\\" .. addonName .. "\\Media\\PayPalQR"
local QR_SIZE = 240

-- Un champ qui montre le lien, sélectionné d'office, et qu'on ne peut que copier
local function LinkBox(parent, width)
    local edit = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    edit:SetSize(width, 24)
    edit:SetAutoFocus(false)
    edit:SetFontObject("ChatFontNormal")
    edit:SetText(DONATE_URL)
    edit:SetCursorPosition(0)
    edit:SetScript("OnTextChanged", function(self, userInput)
        if userInput then
            self:SetText(DONATE_URL)
            self:HighlightText()
        end
    end)
    edit:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
    edit:SetScript("OnEditFocusLost", function(self)
        self:HighlightText(0, 0)
        self:SetCursorPosition(0)
    end)
    edit:SetScript("OnMouseUp", function(self) self:HighlightText() end)
    edit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    edit:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    return edit
end

function UI.BuildDonatePage(page)
    local title = UI.Text(page, "GameFontNormalLarge", L.DONATE_TITLE)
    title:SetPoint("TOP", 0, -14)

    local intro = UI.Text(page, "GameFontHighlight", L.DONATE_INTRO)
    intro:SetPoint("TOP", title, "BOTTOM", 0, -12)
    intro:SetWidth(620)
    intro:SetJustifyH("CENTER")
    intro:SetSpacing(3)

    -- (le QR code sur fond blanc, cadré, pour qu'un téléphone le lise bien)
    local holder = UI.Panel(page)
    holder:SetSize(QR_SIZE + 16, QR_SIZE + 16)
    holder:SetPoint("TOP", intro, "BOTTOM", 0, -16)
    local qr = holder:CreateTexture(nil, "ARTWORK")
    qr:SetSize(QR_SIZE, QR_SIZE)
    qr:SetPoint("CENTER")
    qr:SetTexture(QR_TEXTURE)

    local scan = UI.Text(page, "GameFontNormal", L.DONATE_SCAN)
    scan:SetPoint("TOP", holder, "BOTTOM", 0, -10)

    local linkLabel = UI.Text(page, "GameFontHighlightSmall", L.DONATE_LINK)
    linkLabel:SetPoint("TOP", scan, "BOTTOM", 0, -16)
    local link = LinkBox(page, 600)
    link:SetPoint("TOP", linkLabel, "BOTTOM", 0, -4)

    local thanks = UI.Text(page, "GameFontDisableSmall", L.DONATE_THANKS)
    thanks:SetPoint("TOP", link, "BOTTOM", 0, -14)
    thanks:SetWidth(620)
    thanks:SetJustifyH("CENTER")

    page:SetScript("OnHide", function() link:ClearFocus() end)
end
