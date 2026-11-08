-- Icônes des boutons : les atlas Xbox du jeu (ceux qu'utilise Forever,
-- liste d'Improved Forever), sinon une pastille de texte.
local _, ns = ...

ns.UI = ns.UI or {}
local UI = ns.UI

local ATLAS = {
    PAD1 = { "gamepad-xbox1-buttona-normal", "Gamepad_Ltr_A_64" },
    PAD2 = { "gamepad-xbox1-buttonb-normal", "Gamepad_Ltr_B_64" },
    PAD3 = { "gamepad-xbox1-buttonx-normal", "Gamepad_Ltr_X_64" },
    PAD4 = { "gamepad-xbox1-buttony-normal", "Gamepad_Ltr_Y_64" },
    PADLSHOULDER = { "gamepad-xbox1-trigger-lb-normal", "Gamepad_Ltr_LShoulder_64", "Gamepad_Gen_LShoulder_64" },
    PADRSHOULDER = { "gamepad-xbox1-trigger-rb-normal", "Gamepad_Ltr_RShoulder_64", "Gamepad_Gen_RShoulder_64" },
    PADLTRIGGER = { "gamepad-xbox1-trigger-lt-normal", "Gamepad_Ltr_LTrigger_64", "Gamepad_Gen_LTrigger_64" },
    PADRTRIGGER = { "gamepad-xbox1-trigger-rt-normal", "Gamepad_Ltr_RTrigger_64", "Gamepad_Gen_RTrigger_64" },
    PADLSTICK = { "gamepad-xbox1-stick-l3-normal", "Gamepad_Gen_LStickIn_64" },
    PADRSTICK = { "gamepad-xbox1-stick-r3-normal", "Gamepad_Gen_RStickIn_64" },
    PADDUP = { "gamepad-xbox1-dpadup-normal", "Gamepad_Ltr_Up_64", "Gamepad_Gen_Up_64" },
    PADDDOWN = { "gamepad-xbox1-dpaddown-normal", "Gamepad_Ltr_Down_64", "Gamepad_Gen_Down_64" },
    PADDLEFT = { "gamepad-xbox1-dpadleft-normal", "Gamepad_Ltr_Left_64", "Gamepad_Gen_Left_64" },
    PADDRIGHT = { "gamepad-xbox1-dpadright-normal", "Gamepad_Ltr_Right_64", "Gamepad_Gen_Right_64" },
    PADBACK = { "gamepad-xbox1-view-normal", "Gamepad_Ltr_View_64", "Gamepad_Gen_Back_64" },
    PADFORWARD = { "gamepad-xbox1-menu-normal", "Gamepad_Ltr_Menu_64", "Gamepad_Gen_Forward_64" },
    PADSOCIAL = { "gamepad-xbox1-share-normal", "Gamepad_Ltr_Share_64", "Gamepad_Gen_Share_64" },
    PADSYSTEM = { "gamepad-xbox1-xblogo-normal", "Gamepad_Ltr_System_64", "Gamepad_Gen_System_64" },
}

-- Couleurs des boutons de façade (pastilles de repli)
local COLORS = {
    PAD1 = { 0.3, 0.75, 0.2 }, PAD2 = { 0.85, 0.2, 0.2 },
    PAD3 = { 0.2, 0.45, 0.9 }, PAD4 = { 0.95, 0.75, 0.1 },
}

-- Manette PlayStation : ses symboles (croix, rond, carré, triangle) et ses
-- gâchettes ; sinon les icônes génériques du jeu, jamais les lettres Xbox
local PS_ATLAS = {
    PAD1 = { "Gamepad_Shp_Cross_64" },
    PAD2 = { "Gamepad_Shp_Circle_64" },
    PAD3 = { "Gamepad_Shp_Square_64" },
    PAD4 = { "Gamepad_Shp_Triangle_64" },
    PADLSHOULDER = { "Gamepad_Shp_LShoulder_64" },
    PADRSHOULDER = { "Gamepad_Shp_RShoulder_64" },
    PADLTRIGGER = { "Gamepad_Shp_LTrigger_64" },
    PADRTRIGGER = { "Gamepad_Shp_RTrigger_64" },
    PADBACK = { "Gamepad_Shp_Back_64" },
    PADFORWARD = { "Gamepad_Shp_Forward_64" },
    PADSYSTEM = { "Gamepad_Shp_System_64" },
}

-- Le style des icônes : celui de la manette choisie (« ps », sinon Xbox)
function UI.GlyphStyle()
    local def = ns.Controller and ns.prof and ns.Controller()
    return def and def.glyphs or "xbox"
end

local atlasCache = {}
local function FindAtlas(key)
    local style = UI.GlyphStyle()
    local cacheKey = style .. key
    if atlasCache[cacheKey] ~= nil then return atlasCache[cacheKey] or nil end
    local candidates = {}
    if style == "ps" then
        for _, name in ipairs(PS_ATLAS[key] or {}) do candidates[#candidates + 1] = name end
        for _, name in ipairs(ATLAS[key] or {}) do
            if not (name:find("xbox") or name:find("_Ltr_")) then candidates[#candidates + 1] = name end
        end
    else
        candidates = ATLAS[key] or {}
    end
    local found = false
    for _, name in ipairs(candidates) do
        if C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(name) then
            found = name
            break
        end
    end
    atlasCache[cacheKey] = found
    return found or nil
end

-- Toutes les icônes créées, pour les redessiner quand on change de manette
-- (style Xbox / PlayStation)
local allGlyphs = setmetatable({}, { __mode = "k" })

function UI.RefreshGlyphs()
    for g in pairs(allGlyphs) do
        if g.key then g:SetKey(g.key) end
    end
end

local BASE_PAD = { PADLTRIGGER = true, PADRTRIGGER = true, PADLSHOULDER = true, PADRSHOULDER = true }

-- Libellé court d'une touche / d'un bouton supplémentaire pour la pastille
local SHORT = { PADDUP = "^", PADDDOWN = "v", PADDLEFT = "<", PADDRIGHT = ">" }
local function ShortLabel(key)
    local pair = ns.PairDef and ns.PairDef(key)
    if pair then return ns.ButtonLabel(pair.a) .. "+" .. ns.ButtonLabel(pair.b) end
    if ns.prof and ns.prof.buttons[key] then return ns.ButtonLabel(key) end
    if SHORT[key] then return SHORT[key] end
    local paddle = key:match("^PADPADDLE(%d)$")
    if paddle then return "P" .. paddle end
    return ns.KeyLabel(key)
end

-- Une icône de bouton : frame:SetKey("PAD1") ou frame:SetKey("L5") (emplacement
-- supplémentaire, pastille dorée)
function UI.CreateGlyph(parent, size)
    local f = CreateFrame("Frame", nil, parent)
    f:SetSize(size, size)
    f.tex = f:CreateTexture(nil, "ARTWORK")
    f.tex:SetAllPoints()
    f.badge = f:CreateTexture(nil, "BACKGROUND")
    f.badge:SetAllPoints()
    f.text = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.text:SetPoint("CENTER")

    function f:SetKey(key)
        self.key = key
        -- (les gâchettes de l'addon, « LT » / « RT » : l'icône du jeu)
        local pad = ns.TRIGGER_KEY and ns.TRIGGER_KEY[key] or key
        -- (les boutons de base, LT / RT / LB / RB : une pastille comme les
        -- boutons supplémentaires, pas l'image du jeu)
        local basePad = BASE_PAD[pad]
        local atlas = not basePad and (ATLAS[pad] or PS_ATLAS[pad]) and FindAtlas(pad)
        if atlas then
            self.tex:SetAtlas(atlas)
            self.tex:Show()
            self.badge:Hide()
            self.text:SetText("")
            return
        end
        self.tex:Hide()
        self.badge:Show()
        local extra = basePad or (ns.prof and (ns.prof.buttons[key] or (ns.IsPair and ns.IsPair(key))))
        local c = COLORS[key] or (extra and { 0.75, 0.55, 0.1 }) or { 0.25, 0.25, 0.25 }
        self.badge:SetColorTexture(c[1], c[2], c[3], 0.9)
        self.text:SetWidth(size + 16)
        self.text:SetWordWrap(false)
        self.text:SetText(ShortLabel(pad))
    end

    allGlyphs[f] = true
    return f
end

-- (après chaque application de la configuration : si le style a changé,
-- autre manette ou autre profil, toutes les icônes sont redessinées)
local lastStyle
ns.OnApplied(function()
    local style = UI.GlyphStyle()
    if style ~= lastStyle then
        lastStyle = style
        UI.RefreshGlyphs()
    end
end)
