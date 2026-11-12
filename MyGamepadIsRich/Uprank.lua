-- Nouveaux rangs : quand un sort est appris (maître de classe...) et qu'un
-- rang inférieur du même sort est posé quelque part, on propose de le
-- remplacer : dans les actions de l'addon (toutes les couches, tous les
-- profils et toutes les spés de ce personnage) et sur les barres du jeu (la
-- barre manette de Forever comprise). Un rang inférieur choisi exprès dans
-- l'addon (« Nom (Rang 1) » dans la liste des sorts) n'est pas proposé.
-- Rien ne change sans la réponse du joueur ; hors combat seulement.
local _, ns = ...
local L = ns.L

local U = {}
ns.Uprank = U

local MAX_ACTION_SLOT = 180

local function Plain(v, kind)
    if issecretvalue and issecretvalue(v) then return nil end
    if type(v) == (kind or "number") then return v end
end

local function SpellName(id)
    if not id then return nil end
    if C_Spell and C_Spell.GetSpellName then
        local ok, name = pcall(C_Spell.GetSpellName, id)
        if ok and Plain(name, "string") then return name end
    end
    local ok, name = pcall(ns.Actions.SpellInfo, id)
    return ok and Plain(name, "string") or nil
end

-- Le numéro du rang (« Rang 3 » : 3), ou nil
local function RankNumber(id)
    local rank = ns.Actions.SpellRank(id)
    return rank and tonumber(rank:match("%d+"))
end

-- Vrai si le grimoire range ce sort parmi les rangs bas (nil : il ne sait pas)
local function BookLowRank(id)
    local book = C_SpellBook
    if not (book and book.FindSpellBookSlotForSpell and book.IsSpellBookItemLowRank) then return nil end
    local ok, slot, bank = pcall(book.FindSpellBookSlotForSpell, id)
    if not (ok and Plain(slot)) then return nil end
    local okLow, low = pcall(book.IsSpellBookItemLowRank, slot, bank)
    if not okLow or (issecretvalue and issecretvalue(low)) then return nil end
    return low and true or false
end

local function Passive(id)
    local get = (C_Spell and C_Spell.IsSpellPassive) or IsPassiveSpell
    if not get then return false end
    local ok, passive = pcall(get, id)
    return ok and not (issecretvalue and issecretvalue(passive)) and passive and true or false
end

-- Le sort old est-il un rang plus bas que new ?
local function Lower(old, new)
    local a, b = RankNumber(old), RankNumber(new)
    if a and b then return a < b end
    -- (sans numéro de rang : le grimoire ; sinon le sort appris est le plus
    -- récent, donc le plus haut)
    local low = BookLowRank(old)
    if low ~= nil then return low end
    return true
end

-- (un sort de la barre du jeu connu du joueur : pas un sort du familier)
local function Known(id)
    local get = (C_SpellBook and C_SpellBook.IsSpellKnown) or IsSpellKnown
    if not get then return true end
    local ok, known = pcall(get, id)
    if not ok or (issecretvalue and issecretvalue(known)) then return true end
    return known and true or false
end

---------------------------------------------------------------------------
-- Où sont les rangs inférieurs
---------------------------------------------------------------------------
-- news : { [nom du sort] = spellID du nouveau rang }
local function NewRankFor(id, news)
    local name = SpellName(id)
    local new = name and news[name]
    if new and new ~= id and Lower(id, new) then return new end
end

-- Les actions de l'addon : { list, key, new }
local function AddonSpots(news, out)
    local profiles = ns.char and ns.char.profiles
    if type(profiles) ~= "table" then return end
    local function Scan(actions)
        if type(actions) ~= "table" then return end
        for _, a in pairs(actions) do
            if type(a) == "table" then
                for _, list in ipairs({ a.combos, a.layers }) do
                    if type(list) == "table" then
                        for key in pairs(list) do
                            -- (les branches d'une action selon le contexte et les
                            -- étapes d'un cycle comptent aussi : chaque sort est
                            -- remplacé là où il est)
                            ns.Actions.EachLeaf(list, key, function(where, at, action)
                                -- (un rang choisi exprès garde son rang)
                                if action.kind == "spell" and not action.rank and type(action.id) == "number" then
                                    local new = NewRankFor(action.id, news)
                                    if new then out[#out + 1] = { list = where, key = at, old = action.id, new = new } end
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
    for _, c in pairs(profiles) do
        if type(c) == "table" then
            Scan(c.actions)
            if type(c.specActions) == "table" then
                for _, actions in pairs(c.specActions) do Scan(actions) end
            end
        end
    end
end

-- Les barres du jeu : { slot, bar, i, new } (bar, i : une case de la barre
-- manette de Forever, écrite par son propre outil)
local function GameSpots(news, out)
    if not GetActionInfo then return end
    local seen = {}
    local function Check(slot, bar, i)
        if seen[slot] then return end
        seen[slot] = true
        local ok, kind, id = pcall(GetActionInfo, slot)
        id = ok and kind == "spell" and Plain(id)
        if not id or not Known(id) then return end
        local new = NewRankFor(id, news)
        if new then out[#out + 1] = { slot = slot, bar = bar, i = i, old = id, new = new } end
    end
    local B = ns.Bar
    if B and B.Available() then
        for _, bar in ipairs(B.NAMES) do
            for i = 1, 8 do
                local slot = B.Storage(bar, i)
                if slot then Check(slot, bar, i) end
            end
        end
    end
    for slot = 1, MAX_ACTION_SLOT do Check(slot) end
end

local function Spots(news)
    local addon, game = {}, {}
    AddonSpots(news, addon)
    GameSpots(news, game)
    return addon, game
end

---------------------------------------------------------------------------
-- Remplacement
---------------------------------------------------------------------------
local function Replace(news)
    local addon, game = Spots(news)
    local nAddon, nGame = 0, 0
    for _, s in ipairs(addon) do
        local action = s.list[s.key]
        if type(action) == "table" and action.id == s.old then
            action.id = s.new
            action.name = SpellName(s.new) or action.name
            nAddon = nAddon + 1
        end
    end
    local pickup = (C_Spell and C_Spell.PickupSpell) or PickupSpell
    for _, s in ipairs(game) do
        local done
        if s.bar then
            done = ns.Bar.Set(s.bar, s.i, { kind = "spell", id = s.new })
        elseif pickup and PlaceAction then
            done = pcall(pickup, s.new) and GetCursorInfo() and pcall(PlaceAction, s.slot)
            ClearCursor()
        end
        if done then nGame = nGame + 1 end
    end
    if ns.Diag then ns.Diag.Log(("nouveau rang posé : %d addon, %d jeu"):format(nAddon, nGame)) end
    -- (liaisons de l'addon et fenêtres remises à jour)
    if nAddon + nGame > 0 then
        ns.Apply(true)
        if ns.Rumble then ns.Rumble.Play("done") end
    end
    ns.Print(L.UPRANK_DONE:format(nAddon, nGame))
end

---------------------------------------------------------------------------
-- La question
---------------------------------------------------------------------------
local learned = {}  -- (sorts appris, pas encore regardés)
local asking        -- (nouveaux rangs en attente de réponse ou de remplacement)
local scheduled
local events = CreateFrame("Frame")

local function SpellText(id)
    local name = SpellName(id) or ("#" .. id)
    local rank = ns.Actions.SpellRank(id)
    return "|cff71d5ff" .. name .. "|r" .. (rank and (" (" .. rank .. ")") or "")
end

-- (placer une action demande d'être hors combat, le curseur vide)
local function TryReplace()
    if not asking then return end
    if InCombatLockdown() or GetCursorInfo() then
        events:RegisterEvent("CURSOR_CHANGED")
        return
    end
    events:UnregisterEvent("CURSOR_CHANGED")
    local news = asking
    asking = nil
    Replace(news)
end

-- Option : remplacer sans demander
function U.Auto()
    return ns.db ~= nil and ns.db.options.uprank == "auto"
end

function U.SetAuto(on)
    ns.db.options.uprank = on and "auto" or nil
end

-- manual : demandé par /mgir rangs (dit quand il n'y a rien à remplacer)
local function Ask(manual)
    if not asking then return end
    if InCombatLockdown() then return end -- (reposée à la fin du combat)
    local addon, game = Spots(asking)
    if #addon == 0 and #game == 0 then
        asking = nil
        if manual == true then ns.Print(L.UPRANK_NONE) end
        return
    end
    if U.Auto() then
        TryReplace()
        return
    end
    -- (une autre confirmation de l'addon est ouverte : la question attend)
    local open = _G.MyGamepadIsRichConfirmDialog
    if open and open:IsShown() then
        if C_Timer then C_Timer.After(2, Ask) end
        return
    end
    local spells, seen = {}, {}
    for _, list in ipairs({ addon, game }) do
        for _, s in ipairs(list) do
            if not seen[s.new] then
                seen[s.new] = true
                spells[#spells + 1] = SpellText(s.new)
            end
        end
    end
    local text = L.UPRANK_ASK:format(table.concat(spells, ", "), #addon, #game)
    if not (ns.UI and ns.UI.Confirm) then return end
    local news = asking
    ns.UI.Confirm(text, function()
        asking = news
        TryReplace()
    end, L.UPRANK_REPLACE, L.UPRANK_KEEP)
    -- (sans réponse « Remplacer », on n'y revient pas)
    asking = nil
end

local function Check()
    scheduled = false
    if not (ns.db and ns.char) then wipe(learned) return end
    local news = asking or {}
    for id in pairs(learned) do
        local name = SpellName(id)
        -- (un rang bas appris, un passif : rien à remplacer)
        if name and not Passive(id) and BookLowRank(id) ~= true then
            local cur = news[name]
            if not cur or (RankNumber(id) or 0) > (RankNumber(cur) or 0) then news[name] = id end
        end
    end
    wipe(learned)
    if not next(news) then return end
    asking = news
    Ask()
end

-- /mgir rangs : tous les sorts du grimoire, à leur rang le plus haut (le
-- grimoire range les rangs du plus bas au plus haut ; un rang inférieur y
-- garde son rang dans l'action)
local function BookNews(news)
    for _, e in ipairs(ns.Actions.SpellbookEntries()) do
        local action = e.action
        if action and action.kind == "spell" and not action.rank and type(action.id) == "number" then
            local name = SpellName(action.id)
            if name and not Passive(action.id) and BookLowRank(action.id) ~= true then news[name] = action.id end
        end
    end
    return news
end

function U.CheckAll()
    if not (ns.db and ns.char) then return end
    if InCombatLockdown() then
        ns.Print(L.HUD_COMBAT)
        return
    end
    asking = BookNews(asking or {})
    Ask(true)
end

-- Le nombre de rangs inférieurs posés (actions de l'addon et barres du jeu),
-- sans rien demander : pour « Vérifier ma configuration ». 0 en combat.
function U.LowerCount()
    if not (ns.db and ns.char) or InCombatLockdown() then return 0 end
    local addon, game = Spots(BookNews({}))
    return #addon + #game
end

-- (plusieurs sorts achetés d'affilée chez le maître : une seule question)
local function Schedule()
    if scheduled then return end
    scheduled = true
    if C_Timer then C_Timer.After(1.5, Check) else Check() end
end

-- (selon la version du jeu, l'un ou l'autre ; en enregistrer un inconnu
-- est une erreur)
for _, name in ipairs({ "LEARNED_SPELL_IN_SKILL_LINE", "LEARNED_SPELL_IN_TAB" }) do
    pcall(events.RegisterEvent, events, name)
end
events:RegisterEvent("PLAYER_REGEN_ENABLED")
events:SetScript("OnEvent", function(_, event, spellID)
    if event == "CURSOR_CHANGED" then
        TryReplace()
    elseif event == "PLAYER_REGEN_ENABLED" then
        -- (une réponse donnée pendant le combat, ou une question à poser)
        if events:IsEventRegistered("CURSOR_CHANGED") then TryReplace() else Ask() end
    else
        spellID = Plain(spellID)
        if spellID then
            learned[spellID] = true
            Schedule()
        end
    end
end)
