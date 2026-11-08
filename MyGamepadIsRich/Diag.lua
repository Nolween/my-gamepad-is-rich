-- /mgir etat : l'état des couches à cet instant, dans le chat (à taper
-- quand une couche semble bloquée). Lecture seule.
-- (les outils de relevé du développement sont dans Probe.lua, hors du .toc :
-- ajouter « Probe.lua » au .toc, après Diag.lua, pour /mgir probe)
local _, ns = ...

local D = {}
ns.Diag = D

local function S(v)
    if type(issecretvalue) == "function" and issecretvalue(v) then return "<hidden>" end
    if v == nil then return "nil" end
    local ok, s = pcall(tostring, v)
    return ok and s or "<?>"
end

function D.State()
    local function Line(label, value) ns.Print(label .. " : " .. value) end
    Line("focus jeu (Forever)", S(ns.Focus.InGame()) .. ", addon " .. S(ns.Modifier.InGameAttribute())
        .. ", combat " .. S(InCombatLockdown()))
    local heldList = {}
    for id, where in pairs(ns.Modifier.HeldState()) do heldList[#heldList + 1] = id .. "(" .. where .. ")" end
    table.sort(heldList)
    Line("tenus pour l'addon", #heldList > 0 and table.concat(heldList, " ") or "aucun")
    Line("couche de l'addon", S(ns.Modifier.Held()))
    local down = ns.Focus.PadsDown()
    local downList = {}
    for id in pairs(down or {}) do downList[#downList + 1] = id end
    table.sort(downList)
    Line("enfoncés sur la manette", down and (#downList > 0 and table.concat(downList, " ") or "aucun") or "?")
    local pu = ns.Bar and ns.Bar.PageUnit()
    local active = "?"
    if pu and pu.actionBars then
        for _, name in ipairs(ns.Bar.NAMES or {}) do
            if pu.actionBars[name] == pu.activeBar then active = name end
        end
    end
    Line("barre active de Forever", active)
    Line("A est lié à", S(GetBindingAction("PAD1", true)))
    Line("LT est lié à", S(GetBindingAction("PADLTRIGGER", true)))
end
