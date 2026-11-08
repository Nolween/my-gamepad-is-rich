-- Textes de l'interface : un fichier par langue du client WoW
-- (Locales\xxXX.lua), l'anglais en repli pour toute clé absente.
-- Chaque fichier appelle ns.AddLocale(code, textes) ; seule la langue du
-- client est gardée. Locales\Init.lua choisit la table finale (ns.L).
--
-- Règle des traductions : les %s / %d gardent le même ordre que l'anglais
-- (string.format n'a pas d'arguments numérotés), et les commandes (/mgir...)
-- et noms de touches (F9, L5, LT...) ne se traduisent pas.
local _, ns = ...

local current = GetLocale and GetLocale() or "enUS"
-- (mêmes textes pour ces variantes)
local ALIASES = { enGB = "enUS", esMX = "esES" }
current = ALIASES[current] or current
ns.LOCALE = current

local english, chosen

-- (plusieurs appels pour une même langue s'ajoutent les uns aux autres)
local function Merge(into, from)
    if not into then return from end
    for k, v in pairs(from) do into[k] = v end
    return into
end

function ns.AddLocale(code, strings)
    if code == "enUS" then english = Merge(english, strings) end
    if code == current then chosen = Merge(chosen, strings) end
end

-- (appelé une fois, par Locales\Init.lua)
function ns.FinishLocales()
    english = english or {}
    local L = chosen or english
    if L ~= english then
        setmetatable(L, { __index = function(_, k) return english[k] or k end })
    else
        setmetatable(L, { __index = function(_, k) return k end })
    end
    ns.L = L
    ns.AddLocale, ns.FinishLocales = nil, nil
end
