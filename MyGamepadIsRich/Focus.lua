-- Le focus manette de Forever : quand une de ses fenêtres manette (sacs,
-- carte...) a le focus, A/B/X/Y lui appartiennent et nos combinaisons se
-- taisent. Lu toutes les 0,1 s (jamais de callback dans ses listes, ce qui
-- pourrait corrompre son code sécurisé), comme Improved Forever. En combat,
-- les combinaisons restent actives quoi qu'il arrive (les attributs ne
-- peuvent plus changer).
local _, ns = ...

local F = {}
ns.Focus = F

local inCombat = false

function F.InGame()
    if inCombat then return true end
    local manager = GamepadSharedUtility and GamepadSharedUtility.InputBindingManager
    if not (manager and manager.IsOnlyCoreBindingSetActive) then return true end
    local ok, active = pcall(manager.IsOnlyCoreBindingSetActive, manager)
    if not ok then return true end
    return active and true or false
end

-- Pousse l'état vers les modificateurs (hors combat seulement)
function F.Push()
    if InCombatLockdown() then return end
    ns.Modifier.SetInGame(F.InGame())
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:SetScript("OnEvent", function(_, event)
    inCombat = event == "PLAYER_REGEN_DISABLED"
    -- (PLAYER_REGEN_DISABLED arrive juste avant le verrouillage)
    if not InCombatLockdown() then ns.Modifier.SetInGame(F.InGame()) end
end)

local last, wait = nil, 0
frame:SetScript("OnUpdate", function(_, elapsed)
    wait = wait - elapsed
    if wait > 0 then return end
    wait = 0.1
    if not ns.db or InCombatLockdown() then return end
    local now = F.InGame()
    if now ~= last then
        last = now
        ns.Modifier.SetInGame(now)
    end
end)
