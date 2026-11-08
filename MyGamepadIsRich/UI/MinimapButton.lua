-- Bouton autour de la minimap (sans bibliothèque) :
--   clic gauche : configuration ; clic droit : déverrouiller / verrouiller
--   le HUD ; Maj + clic gauche : tutoriel ; glisser : le déplacer autour de
--   la minimap (ronde ou carrée). /mgir minimap : le masquer / le remontrer.
-- Aussi dans le menu des addons de la minimap, quand le client en a un.
local _, ns = ...
local L = ns.L

local MB = {}
ns.MinimapButton = MB

local ICON = "Interface\\Icons\\INV_Misc_EngGizmos_20"
local button

local function Settings()
    ns.db.minimap = ns.db.minimap or {}
    local s = ns.db.minimap
    if s.angle == nil then s.angle = 220 end
    return s
end

local function Atan2(y, x)
    if math.atan2 then return math.atan2(y, x) end
    return math.atan(y, x)
end

-- Sur le bord de la minimap, à son angle (carrée : sur le bord du carré)
local function Place()
    local a = math.rad(Settings().angle)
    local x, y = math.cos(a), math.sin(a)
    local shape = GetMinimapShape and GetMinimapShape() or "ROUND"
    if shape == "SQUARE" then
        x = math.max(-1, math.min(1, x * 1.4142))
        y = math.max(-1, math.min(1, y * 1.4142))
    end
    local w = Minimap:GetWidth() / 2 + 10
    local h = Minimap:GetHeight() / 2 + 10
    button:ClearAllPoints()
    button:SetPoint("CENTER", Minimap, "CENTER", x * w, y * h)
end

local function Drag()
    local mx, my = Minimap:GetCenter()
    local scale = Minimap:GetEffectiveScale()
    local cx, cy = GetCursorPosition()
    if not (mx and my and cx and cy) then return end
    Settings().angle = math.deg(Atan2(cy / scale - my, cx / scale - mx))
    Place()
end

local function Click(_, mouse)
    if mouse == "RightButton" then
        ns.Hud.Command("")
    elseif IsShiftKeyDown() then
        ns.Tutorial.Open(1)
    else
        ns.UI.Toggle()
    end
end

local function Build()
    button = CreateFrame("Button", "MyGamepadIsRichMinimapButton", Minimap)
    button:SetSize(31, 31)
    button:SetFrameStrata("MEDIUM")
    button:SetFrameLevel(8)
    button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    button:RegisterForDrag("LeftButton")
    button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    local bg = button:CreateTexture(nil, "BACKGROUND")
    bg:SetSize(20, 20)
    bg:SetPoint("TOPLEFT", 7, -5)
    bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetSize(17, 17)
    icon:SetPoint("TOPLEFT", 7, -6)
    icon:SetTexture(ICON)
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    button.icon = icon
    local border = button:CreateTexture(nil, "OVERLAY")
    border:SetSize(53, 53)
    border:SetPoint("TOPLEFT")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    button:SetScript("OnClick", Click)
    button:SetScript("OnMouseDown", function() icon:SetTexCoord(0.12, 0.88, 0.12, 0.88) end)
    button:SetScript("OnMouseUp", function() icon:SetTexCoord(0.08, 0.92, 0.08, 0.92) end)
    button:SetScript("OnDragStart", function(self)
        self:LockHighlight()
        self:SetScript("OnUpdate", Drag)
        GameTooltip:Hide()
    end)
    button:SetScript("OnDragStop", function(self)
        self:UnlockHighlight()
        self:SetScript("OnUpdate", nil)
        icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    end)
    button:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:SetText(L.TITLE, 1, 0.82, 0)
        GameTooltip:AddLine(L.MINIMAP_LEFT, 1, 1, 1)
        GameTooltip:AddLine(L.MINIMAP_RIGHT, 1, 1, 1)
        GameTooltip:AddLine(L.MINIMAP_SHIFT, 1, 1, 1)
        GameTooltip:AddLine(L.MINIMAP_DRAG, 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

function MB.Refresh()
    if not button then return end
    if Settings().hide then
        button:Hide()
    else
        Place()
        button:Show()
    end
end

function MB.IsShown()
    return not Settings().hide
end

function MB.SetShown(on)
    Settings().hide = not on
    if not button and Minimap then Build() end
    MB.Refresh()
end

-- /mgir minimap
function MB.Toggle()
    local s = Settings()
    s.hide = not s.hide
    if not button then Build() end
    MB.Refresh()
    ns.Print(s.hide and L.MINIMAP_HIDDEN or L.MINIMAP_SHOWN)
end

-- (à la connexion)
function MB.Init()
    if not Minimap then return end
    if not button then Build() end
    MB.Refresh()
    -- Le menu des addons de la minimap, s'il existe sur ce client
    local compartment = _G.AddonCompartmentFrame
    if compartment and compartment.RegisterAddon and not MB.registered then
        MB.registered = pcall(compartment.RegisterAddon, compartment, {
            text = L.TITLE,
            icon = ICON,
            notCheckable = true,
            func = function() ns.UI.Toggle() end,
        })
    end
end
