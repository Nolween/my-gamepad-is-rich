-- Vibrations de la manette : un petit retour quand un modificateur
-- verrouillable s'allume (une vibration) ou s'éteint (deux), et quand un
-- nouveau rang de sort est posé. Seulement si le
-- jeu donne C_GamePad.SetVibration ; option « Vibrations » (onglet HUD,
-- bloc Confort), cochée par défaut. Code non protégé : marche en combat.
local _, ns = ...

local R = {}
ns.Rumble = R

function R.Available()
    return type(C_GamePad) == "table" and type(C_GamePad.SetVibration) == "function"
end

function R.Enabled()
    return R.Available() and ns.db ~= nil and ns.db.options.vibration ~= false
end

function R.SetEnabled(on)
    ns.db.options.vibration = (not on) and false or nil
end

-- Chaque motif : des impulsions { durée, intensité }, séparées par GAP
local GAP = 0.07
local PATTERNS = {
    on = { { 0.10, 0.6 } },
    off = { { 0.06, 0.5 }, { 0.06, 0.5 } },
    done = { { 0.18, 0.5 } },
}

local function Start(intensity)
    pcall(C_GamePad.SetVibration, "Low", intensity)
end

local function Stop()
    if C_GamePad.StopVibration then pcall(C_GamePad.StopVibration) else Start(0) end
end

function R.Play(kind)
    if not R.Enabled() then return end
    local pattern = PATTERNS[kind]
    if not pattern then return end
    if not C_Timer then
        Start(pattern[1][2])
        return
    end
    local t = 0
    for _, pulse in ipairs(pattern) do
        local duration, intensity = pulse[1], pulse[2]
        if t == 0 then Start(intensity) else C_Timer.After(t, function() Start(intensity) end) end
        t = t + duration
        C_Timer.After(t, Stop)
        t = t + GAP
    end
end
