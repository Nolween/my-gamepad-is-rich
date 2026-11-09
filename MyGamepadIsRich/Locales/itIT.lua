-- Italiano
local _, ns = ...

ns.AddLocale("itIT", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "Pulsanti",
    TAB_TEST = "Test controller",
    TAB_HELP = "Aiuto",

    NAME = "Nome:",
    KEY = "Tasto:",
    KEY_NONE = "non impostato",
    DETECT = "Rileva",
    CLEAR = "Cancella",
    MODE_MODIFIER = "Modificatore",
    MODE_SIMPLE = "Pulsante semplice",
    MODE_OFF = "Disattivato",
    MODE_MODIFIER_DESC = "Tieni premuto questo pulsante e premi A, B, X, Y o la croce direzionale: 8 nuove combinazioni, come LT/RT.",
    MODE_SIMPLE_DESC = "Un'azione, più una con LT tenuto premuto e una con RT tenuto premuto. Uno strato vuoto non fa nulla.",
    MODE_OFF_DESC = "Questo pulsante non fa nulla: il suo tasto resta libero.",
    LAYER_BASE = "Da solo",
    LAYER_LT = "LT +",
    LAYER_RT = "RT +",
    SLOT_HINT = "Trascina un incantesimo, oggetto, macro o cavalcatura su uno spazio. Clic destro: altre opzioni.",
    EMPTY = "Vuoto",
    NO_KEY_WARNING = "Prima imposta il tasto: clicca su \"Rileva\" e premi il pulsante.",

    MENU_SPELL = "Scegli un incantesimo...",
    MENU_ITEM = "Scegli un oggetto della borsa...",
    SPELL_TITLE = "Incantesimi del personaggio",
    ITEM_TITLE = "Oggetti nelle borse",
    ITEMS_EQUIPPED = "Equipaggiati (utilizzabili)",
    ITEMS_USABLE = "Utilizzabili",
    ITEMS_OTHER = "Altri oggetti",
    LIST_EMPTY = "Niente da mostrare.",
    MENU_MACROTEXT = "Scrivi una macro...",
    MENU_COMMAND = "Comando di WoW...",
    MENU_ICON = "Cambia icona...",
    ICON_TITLE = "Scegli un'icona",
    ICON_HINT = "Cerca per incantesimo, oggetto o comando di WoW, oppure scrivi il nome file di un'icona (come su Wowhead: inv_misc_map_01).",
    ICON_DEFAULT = "Icona predefinita",
    MENU_CLEAR = "Svuota",
    MENU_PICKUP_HINT = "Oppure rilascia qui un incantesimo / oggetto / macro / cavalcatura",
    MACRO_TITLE = "Testo della macro",
    MACRO_HELP = "Un comando per riga, es. /cast Palla di Fuoco  (max 255 caratteri)",
    OK = "OK",
    CANCEL = "Annulla",
    COMMAND_TITLE = "Comando di WoW",
    SEARCH = "Cerca:",
    COMMAND_LT_RT = "Un comando di WoW funziona solo sullo strato \"Da solo\" di un pulsante senza strati LT/RT.",

    KIND_spell = "Incantesimo",
    KIND_item = "Oggetto",
    KIND_toy = "Giocattolo",
    KIND_mount = "Cavalcatura",
    KIND_macro = "Macro",
    KIND_macrotext = "Macro personalizzata",
    KIND_command = "Comando di WoW",
    KIND_equipset = "Set di equipaggiamento",

    CURSOR_UNSUPPORTED = "Questo non può andare su un pulsante (solo incantesimi, oggetti, giocattoli, cavalcature, macro, set di equipaggiamento).",
    APPLIED_AFTER_COMBAT = "In combattimento: le modifiche saranno applicate alla fine del combattimento.",
    APPLIED = "Modifiche applicate.",
    LEARN_PROMPT = "Premi il pulsante del controller per |cffffd100%s|r\n\n(Esc per annullare)",
    LEARN_COMBAT = "Impossibile rilevare un pulsante in combattimento.",
    LEARN_DONE = "%s ora è sul tasto %s.",
    LEARN_TAKEN = "Il tasto %s era usato da %s: rimosso.",
    LEARN_BOUND = "Nota: %s era assegnato a \"%s\" in WoW; finché questo addon lo usa, ha la precedenza l'addon.",

    TEST_STANDARD = "Pulsanti standard",
    TEST_EXTRA = "Pulsanti aggiuntivi",
    TEST_LOG = "Ultimi input",
    TEST_GAME = "gioco",
    TEST_UNKNOWN = "non assegnato",

    IF_WARNING = "Improved Forever è caricato: se usa anche uno di questi tasti, vince l'ultima assegnazione applicata.",
    OPEN_CONFIG = "Apri la configurazione",
    LOADED = "caricato. Scrivi /mgir per configurare i pulsanti aggiuntivi.",
    RESET_DONE = "Le azioni di questo personaggio sono state azzerate.",

    DPAD_UP = "Croce su",
    DPAD_DOWN = "Croce giù",
    DPAD_LEFT = "Croce sinistra",
    DPAD_RIGHT = "Croce destra",
    PADDLE = "Paletta %s",

    TUTO_TITLE = "Tutorial",
    TUTO_NEXT = "Avanti",
    TUTO_BACK = "Indietro",
    TUTO_SKIP = "Salta il tutorial",
    TUTO_FINISH = "Apri la configurazione",
    TUTO_REOPEN = "Tutorial chiuso. Scrivi /mgir tuto per rivederlo.",
    HELP_REPLAY = "Rivedi il tutorial",

    TUTO_WELCOME_TITLE = "Benvenuto in My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "Per ogni pulsante, clicca su |cffffd100Rileva|r, poi premi quel pulsante sul controller. "
        .. "Il tasto inviato appare accanto.",



    TUTO_DONE_TITLE = "Tutto pronto",
})

-- HUD
ns.AddLocale("itIT", {
    HUD_UNLOCKED = "HUD sbloccato: trascinalo con il mouse. Scrivi di nuovo /mgir hud per bloccarlo.",
    HUD_LOCKED = "HUD bloccato.",
    HUD_ON = "HUD visibile: sostituisce la barra del controller del gioco.",
    HUD_OFF = "HUD nascosto: torna la barra del controller del gioco. Scrivi /mgir hud on per mostrarlo di nuovo.",
    HUD_SCALE = "Dimensione dell'HUD: %s",
    TUTO_HUD_TITLE = "Il tuo HUD del controller",
})

-- HUD : attribution rapide
ns.AddLocale("itIT", {
    HUD_COMBAT = "Non puoi cambiare le azioni in combattimento.",
    HUD_GAME_SLOT = "Questo pulsante mantiene l'azione del gioco (saltare, interagire...).",
    HUD_KIND = "La barra del gioco accetta solo incantesimi, oggetti, cavalcature e macro dell'elenco delle macro.",
    HUD_EDITING = "Modifica di questo strato: clicca su uno spazio per assegnarlo, clic destro per svuotarlo. Clicca di nuovo sulla miniatura, o premi qualsiasi altro pulsante o tasto, per tornare.",
    HUD_TILE_HINT = "Clic: assegna  -  Clic destro: svuota",
    HUD_CARD_HINT = "Clic: modifica questo strato",
})

-- HUD : bande des miniatures
ns.AddLocale("itIT", {
    HUD_STRIP_TOP = "Miniature degli strati ora sopra l'HUD. Scrivi /mgir hud strip per cambiare.",
    HUD_STRIP_BOTTOM = "Miniature degli strati ora sotto l'HUD. Scrivi /mgir hud strip per cambiare.",
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("itIT", {
    TUTO_STRIP_LABEL = "Miniature degli strati:",
    TUTO_STRIP_BOTTOM = "In basso (consigliato)",
    TUTO_STRIP_TOP = "In alto",
})

-- Bouton de la minimap
ns.AddLocale("itIT", {
    MINIMAP_LEFT = "Clic sinistro: apri la configurazione",
    MINIMAP_RIGHT = "Clic destro: sblocca / blocca l'HUD per spostarlo",
    MINIMAP_SHIFT = "Maiusc + clic sinistro: tutorial",
    MINIMAP_DRAG = "Trascina: sposta questo pulsante intorno alla minimappa",
    MINIMAP_HIDDEN = "Pulsante della minimappa nascosto. Scrivi /mgir minimap per mostrarlo di nuovo.",
    MINIMAP_SHOWN = "Pulsante della minimappa visibile.",
})

-- Paires de modificateurs
ns.AddLocale("itIT", {
    PAIR_READY = "Coppia · tieni entrambi",
    PAIR_NOT_READY = "Coppia · non disponibile",
    PAIR_DESC = "Tieni premuti %s e %s insieme, poi premi A, B, X, Y o la croce: 8 combinazioni in più.",
    PAIR_NEEDS = "Per usare questa coppia, %s e %s devono essere entrambi in modalità Modificatore, con un tasto.",
})

-- Fenêtre de configuration (onglets Actions, Boutons, HUD)
ns.AddLocale("itIT", {
    TAB_ACTIONS = "Azioni",
    TAB_HUD = "HUD",
    SECTION_PAD = "Barra del controller",
    SECTION_MODS = "Modificatori",
    SECTION_MODS_EMPTY = "Ancora nessuno: imposta un pulsante su Modificatore nella scheda Pulsanti.",
    SECTION_SIMPLE = "Pulsanti semplici",
    SECTION_SIMPLE_EMPTY = "Ancora nessuno: imposta un pulsante su Pulsante semplice nella scheda Pulsanti.",
    LAYER_DESC_BASE = "A, B, X, Y e la croce senza tenere nulla. Qui va tutto: ciò che la barra del gioco non può contenere (macro scritta a mano, comando di WoW) lo prende l'addon. A, B, X e Y mantengono le azioni del gioco (saltare, interagire...) finché non metti le tue.",
    LAYER_DESC_HOLD = "Tieni premuto %s, poi premi A, B, X, Y o la croce.",
    PAIRS_TITLE = "Coppie (due modificatori tenuti insieme)",
    HUD_INTRO = "L'HUD sostituisce la barra del controller del gioco: lo strato in uso in grande, tutti gli strati in miniatura.",
    HUD_SHOW = "Mostra l'HUD (al posto della barra del controller del gioco)",
    HUD_SIZE = "Dimensione:",
    HUD_MOVE = "Sposta l'HUD",
    HUD_MOVE_DONE = "Blocca l'HUD",
    HUD_RESET = "Ripristina posizione e dimensione",
    MINIMAP_SHOW = "Pulsante intorno alla minimappa",
    GAME_ACTION = "Gioco",
    BAR_UNAVAILABLE = "La barra del controller del gioco non è disponibile (l'interfaccia controller è attiva?).",
    KIND_slot = "Azione",
    SLOT_HINT = "Trascina un incantesimo, oggetto, macro o cavalcatura su uno spazio. Clic: menu. Clic destro: svuota.",
})

-- HUD : taille et lignes des miniatures
ns.AddLocale("itIT", {
    HUD_STRIP_SIZE = "Dimensione delle miniature:",
    HUD_STRIP_ROWS = "Righe di miniature:",
    HUD_ORDER = "Ordine delle miniature:",
    HUD_ORDER_RESET = "Ordine predefinito",
    HUD_ORDER_HINT = "Frecce: sposta uno strato. Sull'HUD puoi anche trascinare una miniatura su un'altra.",
    HUD_CARD_DRAG = "Trascina: spostala (su un'altra miniatura)",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("itIT", {
    CONTROLLER_LABEL = "Controller:",
    CONTROLLER_CHANGE = "Cambia...",
    CONTROLLER_PICK = "Scegli il tuo controller",
    CONTROLLER_OTHER = "Altro controller",
    EXTRA = "Pulsante",
    SOFTWARE_GENERIC = "il software del tuo controller",
    TEST_INTRO = "Premi un pulsante qualsiasi: ciò che WoW riceve si illumina. Se i tuoi pulsanti aggiuntivi non mostrano nulla, assegna loro dei tasti nel software del tuo controller (vedi Aiuto).",
    LEARN_MODKEY = "Attenzione: %s è un tasto Maiusc / Ctrl / Alt; nel software del tuo controller meglio un tasto come F9-F12.",



    TUTO_SOFTWARE_WHY = "Windows vede la maggior parte dei controller come un controller Xbox (XInput). Questa modalità trasmette solo i pulsanti standard, "
        .. "quindi WoW non riceve mai quelli aggiuntivi. La soluzione: far inviare a ognuno un tasto della tastiera.",
    TUTO_SOFTWARE_VENDOR = "1. Collega il controller e apri |cffffd100%s|r.\n"
        .. "2. Apri la pagina di mappatura dei pulsanti.\n"
        .. "3. Assegna a ogni pulsante aggiuntivo (%s) un tasto che non usi in WoW. Buone scelte: |cffffd100F9, F10, F11, F12|r "
        .. "o il tastierino numerico (con Bloc Num attivo).\n"
        .. "4. Evita Maiusc, Ctrl e Alt: cambierebbero le tue altre assegnazioni.\n"
        .. "5. Salva il profilo (sul controller, se il software lo consente).",
    TUTO_SOFTWARE_ALT = "Se %s non riesce ad assegnare un tasto a questi pulsanti, usa |cffffd100Steam Input|r: aggiungi WoW (o il launcher Battle.net) "
        .. "a Steam come gioco non Steam, avvialo da Steam e assegna un tasto a ogni pulsante nella sua configurazione del controller. "
        .. "Funziona anche |cffffd100reWASD|r (a pagamento), senza Steam.",
    TUTO_SOFTWARE_STEAM = "1. In |cffffd100Steam|r, aggiungi WoW (o il launcher Battle.net) come gioco non Steam "
        .. "(Giochi > Aggiungi alla libreria un gioco non di Steam) e avvialo da Steam.\n"
        .. "2. Apri la sua configurazione del controller (overlay di Steam o impostazioni del controller del gioco in Steam).\n"
        .. "3. Assegna a ogni pulsante aggiuntivo (%s) un tasto che non usi in WoW. Buone scelte: |cffffd100F9, F10, F11, F12|r.\n"
        .. "4. Evita Maiusc, Ctrl e Alt: cambierebbero le tue altre assegnazioni.\n\n"
        .. "|cffffd100reWASD|r (a pagamento) fa lo stesso senza Steam.",

    TUTO_DETECT_ALL = "|cff40ff40Tutti i tuoi pulsanti sono rilevati.|r",



})

-- Profils : liste, export, import
ns.AddLocale("itIT", {
    TAB_PROFILES = "Profili",
    PROFILES_INTRO = "Un profilo contiene un controller, i suoi pulsanti e, per ogni personaggio, le sue azioni. Si usa un solo profilo alla volta, per tutto l'account. L'HUD è comune a tutti i profili.",
    PROFILE_ACTIVE = "in uso",
    PROFILE_USE = "Usa questo profilo",
    PROFILE_NEW = "Nuovo...",
    PROFILE_COPY = "Copia...",
    PROFILE_RENAME = "Rinomina...",
    PROFILE_DELETE = "Elimina",
    PROFILE_EXPORT = "Esporta...",
    PROFILE_IMPORT = "Importa...",
    PROFILE_DEFAULT = "Profilo",
    PROFILE_IMPORTED = "Profilo importato",
    PROFILE_COPY_SUFFIX = "%s (copia)",
    PROFILE_NAME_NEW = "Nome del nuovo profilo:",
    PROFILE_NAME_COPY = "Nome della copia:",
    PROFILE_NAME_RENAME = "Nuovo nome per «%s»:",
    PROFILE_DELETE_CONFIRM = "Eliminare il profilo «%s»? I suoi pulsanti e le azioni di tutti i tuoi personaggi per questo profilo andranno persi.",
    PROFILE_SWITCHED = "Profilo in uso: %s.",
    PROFILE_UNKNOWN = "Nessun profilo si chiama «%s». Scrivi /mgir profiles per vederli.",
    PROFILE_COMBAT = "Non puoi cambiare profilo in combattimento.",
    PROFILE_LAST = "È il tuo unico profilo: non può essere eliminato.",
    PROFILE_CREATED = "Profilo «%s» creato e in uso. Imposta i suoi tasti nella scheda Pulsanti.",

    EXPORT_TITLE = "Esporta «%s»",
    EXPORT_ACTIONS = "Includi le azioni di questo personaggio",
    EXPORT_HUD = "Includi le impostazioni dell'HUD",
    EXPORT_HINT = "Il testo è selezionato: Ctrl+C per copiarlo, poi incollalo dove vuoi (Discord, un file di testo...). Si importa con il pulsante Importa della scheda Profili.",
    CLOSE = "Chiudi",

    IMPORT_TITLE = "Importa un profilo",
    IMPORT_PASTE = "Incolla qui il testo esportato (Ctrl+V):",
    IMPORT_EMPTY = "Incolla un testo esportato per vedere cosa contiene.",
    IMPORT_BAD = "Questo non è un testo esportato da My Gamepad Is Rich.",
    IMPORT_VERSION = "Questo testo viene da un'altra versione dell'addon e non può essere letto.",
    IMPORT_DAMAGED = "Questo testo è danneggiato o incompleto: copialo di nuovo, per intero.",
    IMPORT_SUMMARY = "Profilo «%s», controller: %s\n%d pulsante/i con un tasto, %d azione/i",
    IMPORT_SUMMARY_HUD = "Contiene impostazioni dell'HUD.",
    IMPORT_MACROS = "Attenzione: %d macro scritta/e a mano. Leggile prima di usarle:",
    IMPORT_COMMANDS = "Comandi di WoW: %s",
    IMPORT_AS_NEW = "Nuovo profilo:",
    IMPORT_REPLACE = "Sostituisci:",
    IMPORT_PICK = "Profilo da sostituire",
    IMPORT_ACTIONS = "Importa le azioni (per questo personaggio)",
    IMPORT_HUD = "Applica le impostazioni dell'HUD",
    IMPORT_DO = "Importa",
    IMPORT_REPLACE_CONFIRM = "Sostituire il profilo «%s»? Il suo controller e i suoi pulsanti saranno sovrascritti, e anche le sue azioni per questo personaggio se le importi.",
    IMPORT_DONE = "Profilo «%s» importato.",

    SELFTEST_OK = "Autotest: tutto a posto.",
    SELFTEST_FAIL = "Autotest: %d problema/i: %s",
    SLASH_HELP = "/mgir : apri  |  /mgir profile <nome> : cambia profilo  |  /mgir test : test controller  |  /mgir tuto : tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : azzera le azioni di questo personaggio",
})

-- HUD : arrêt après une erreur
ns.AddLocale("itIT", {
    HUD_ERROR = "Errore dell'HUD: resta fermo fino al /reload (torna la barra del gioco). Per favore segnala questo messaggio: %s",
})

-- Gâchettes LT / RT données à l'addon
ns.AddLocale("itIT", {
    TRIGGERS_LABEL = "Grilletti LT / RT:",
    TRIGGERS_ADDON = "Modificatori dell'addon",
    TRIGGERS_GAME = "Strati del gioco",
    TRIGGERS_ADDON_DESC = "Tieni premuto LT o RT (o entrambi) e premi A, B, X, Y o la croce: le azioni dell'addon, con tutto ciò che permette (macro scritte a mano, comandi di WoW). Sostituiscono gli strati LT, RT e LT + RT della barra del controller del gioco; una casella vuota non fa nulla. LB e RB non cambiano.",
    TRIGGERS_GAME_DESC = "LT e RT mantengono gli strati della barra del controller del gioco (modificabili dalla scheda Azioni).",
    TRIGGERS_COPIED = "%d azione/i degli strati LT / RT del gioco copiata/e in quelli dell'addon.",
    IMPORT_SUMMARY_TRIGGERS = "LT / RT: modificatori dell'addon.",
})

-- Menu d'une case : pourquoi des choix sont grisés
ns.AddLocale("itIT", {
    MENU_GAME_BAR_HINT = "Macro scritte, comandi di WoW: dai LT / RT all'addon (scheda Pulsanti, Pulsanti di base)",
})

-- Actions de base (celles de Forever sur A/B/X/Y)
ns.AddLocale("itIT", {
    MENU_GAME = "Azione di base...",
    GAME_TITLE = "Azioni di base",
    KIND_game = "Azione di base",
    GAME_jump = "Saltare",
    GAME_cancel = "Annulla (incantesimo, bersaglio)",
    GAME_search = "Cerca (clic destro sul bersaglio)",
    GAME_attack = "Attacco automatico",
    GAME_interact = "Interagisci",
})

-- Modes de ciblage (comme LB / RB dans Forever)
ns.AddLocale("itIT", {
    MODE_TARGET_FRIEND = "Alleato",
    MODE_TARGET_ENEMY = "Nemico",
    MODE_TARGET_FRIEND_DESC = "Come LB in Forever: una pressione breve seleziona l'alleato più vicino; tienilo premuto e mira con lo stick destro per sceglierne uno. Tenuto premuto è anche un modificatore: A, B, X, Y e la croce lanciano le sue 8 scorciatoie.",
    MODE_TARGET_ENEMY_DESC = "Come RB in Forever: una pressione breve seleziona il nemico più vicino; tienilo premuto e mira con lo stick destro per sceglierne uno. Tenuto premuto è anche un modificatore: A, B, X, Y e la croce lanciano le sue 8 scorciatoie.",
    TARGET_UNAVAILABLE = "Il sistema di bersaglio di Forever non è disponibile: %s funziona come un semplice modificatore.",
})

-- Onglet « Soutenir » (don PayPal)
ns.AddLocale("itIT", {
    TAB_DONATE = "Sostieni",
    DONATE_TITLE = "Sostieni My Gamepad Is Rich",
    DONATE_INTRO = "My Gamepad Is Rich è gratuito e lo resterà. Se ti è utile e vuoi ringraziarmi, puoi farmi una donazione su PayPal, dell'importo che preferisci.",
    DONATE_SCAN = "Scansiona il codice QR con il telefono",
    DONATE_LINK = "Oppure copia il link (Ctrl+C) e incollalo nel browser:",
    DONATE_THANKS = "Le donazioni sono del tutto facoltative e non sbloccano nulla: tutte le funzioni restano disponibili per tutti. Grazie per il tuo sostegno!",
})

-- Boutons de base (LT, RT, LB, RB)
ns.AddLocale("itIT", {
    MODE_GAME = "Gioco",
    MODE_GAME_DESC = "Questo pulsante mantiene il suo ruolo nel gioco (LT / RT: strati della barra del controller; LB / RB: il sistema di bersaglio di Forever).",
    PADS_LABEL = "Pulsanti di base:",
    PADS_PICK = "%s: scegli una modalità",
    IMPORT_SUMMARY_PADS = "Pulsanti di base dati all'addon: %s",
    EMULATION_OFF = "%s non imita più Maiusc / Ctrl finché appartiene all'addon. Viene ripristinata da sola alla disconnessione.",
    RESTORE_DONE = "Pulsanti di base restituiti al gioco e imitazione di Maiusc / Ctrl ripristinata.",
})

-- Plus aucun ciblage allié / ennemi configuré
ns.AddLocale("itIT", {
    TARGET_MISSING_FRIEND = "Nessun pulsante seleziona gli alleati: rimetti LB su «Gioco», o un pulsante su «Alleato» (scheda Pulsanti).",
    TARGET_MISSING_ENEMY = "Nessun pulsante seleziona i nemici: rimetti RB su «Gioco», o un pulsante su «Nemico» (scheda Pulsanti).",
    TARGET_MISSING_BOTH = "Nessun pulsante seleziona alleati o nemici: rimetti LB / RB su «Gioco», o dei pulsanti su «Alleato» / «Nemico» (scheda Pulsanti).",
})

-- Onglet Boutons : mention des boutons de base
ns.AddLocale("itIT", {
    PAD_HINT = "pulsante del controller: niente da rilevare",
})

-- Case vide d'un bouton simple dans une couche : son action habituelle
ns.AddLocale("itIT", {
    SIMPLE_USUAL = "Solito",
})

-- Manettes standard (sans bouton supplémentaire), noms PlayStation
ns.AddLocale("itIT", {
    TUTO_NO_EXTRA = "Questo controller non ha pulsanti aggiuntivi: qui non c'è nulla da configurare. Puoi dare altri ruoli a LT, RT, LB e RB (Pulsanti di base, nella scheda Pulsanti).",
    PS_CROSS = "Croce",
    PS_CIRCLE = "Cerchio",
    PS_SQUARE = "Quadrato",
    PS_TRIANGLE = "Triangolo",
})

-- Paires libres (deux modificateurs quelconques)
ns.AddLocale("itIT", {
})

-- Paire avec un bouton de base resté au jeu
ns.AddLocale("itIT", {
})

-- Boutons de base : mode par défaut
ns.AddLocale("itIT", {
    MODE_IS_DEFAULT = "Predefinito per questo pulsante: funziona come nel gioco.",
})

-- Tutoriel : les types de boutons, boutons de base, paires ; options
ns.AddLocale("itIT", {
    MODE = "Tipo:",
    TUTO_WELCOME_TEXT = "Questo addon ti permette di scegliere cosa fa ogni pulsante del tuo controller: i pulsanti aggiuntivi (palette posteriori, grilletti extra: GameSir, Xbox Elite, DualSense Edge, SCUF...) e i pulsanti di base LT, RT, LB e RB.\n\n|cffffd100Il principio: gli strati.|r Da soli, A, B, X, Y e la croce lanciano 8 azioni. Tieni premuto un pulsante (LT, RT, una paletta...) e quegli stessi 8 pulsanti lanciano altre 8 azioni: è un nuovo strato. Ogni pulsante tenuto premuto ne dà uno.\n\nQuesto tutorial dura circa due minuti. Puoi uscire in qualsiasi momento e riaprirlo con |cffffd100/mgir tuto|r.",
    TUTO_CONTROLLER_TITLE = "Il tuo controller",
    TUTO_CONTROLLER_TEXT = "Scegli il tuo controller: l'addon usa i nomi dei suoi pulsanti aggiuntivi e ti indica il software che li configura. Un normale controller Xbox o PlayStation, senza pulsanti extra? Sceglilo comunque: potrai configurare LT, RT, LB e RB. Non è nella lista? Scegli |cffffd100Altro controller|r (fino a 6 pulsanti, che puoi rinominare).",
    TUTO_TYPES_TITLE = "I 4 tipi di pulsante",
    TUTO_TYPES_TEXT = "Ogni pulsante riceve un tipo, che dice cosa fa. Lo scegli nei passi successivi, e in qualsiasi momento nella scheda |cffffd100Pulsanti|r (passa il mouse su un tipo per rileggerne la spiegazione).",
    TYPE_MODIFIER_HOW = "Tienilo premuto, poi premi A, B, X, Y o la croce: uno strato di 8 azioni. Da solo non fa nulla.",
    TYPE_MODIFIER_FOR = "Per: i pulsanti facili da tenere premuti. Predefinito per LT e RT, come nel gioco.",
    TYPE_TARGET_HOW = "Una pressione breve seleziona l'alleato (o il nemico) più vicino; tienilo premuto e mira con lo stick destro per sceglierne un altro. Tenuto con A, B, X, Y o la croce: 8 scorciatoie, come un modificatore.",
    TYPE_TARGET_FOR = "Per: cure e incantesimi su un bersaglio. Predefinito per LB (alleato) e RB (nemico), come nel gioco.",
    TYPE_SIMPLE_HOW = "Una pressione lancia un'azione. Con LT o RT tenuto premuto, ne lancia un'altra. Ha anche una casella in ogni strato di modificatore.",
    TYPE_SIMPLE_FOR = "Per: un incantesimo che lanci spesso, una pozione, una cavalcatura.",
    TYPE_OFF_HOW = "Il pulsante non fa nulla: il suo tasto resta libero per altro.",
    TYPE_OFF_FOR = "Per: i pulsanti aggiuntivi che non usi (i pulsanti di base non hanno questo tipo).",
    TUTO_SOFTWARE_TITLE = "Far inviare un tasto ai pulsanti aggiuntivi",
    TUTO_DETECT_TITLE = "Rileva i tuoi pulsanti aggiuntivi",
    TUTO_DETECT_MISSING = "Non succede nulla quando premi? Controlla il tasto del pulsante nel software del controller, poi riprova.",
    TUTO_MODES_TITLE = "Il tipo dei tuoi pulsanti aggiuntivi",
    TUTO_MODES_TEXT = "Scegli il tipo di ogni pulsante aggiuntivo (passa il mouse su un tipo per vedere cosa fa).\nConsiglio: modificatori sui pulsanti più facili da tenere premuti, pulsanti semplici sugli altri. |cffffd100Usa i tipi consigliati|r lo fa per te.",
    TUTO_SUGGESTED = "Usa i tipi consigliati",
    TUTO_PADS_TITLE = "I tuoi pulsanti di base: LT, RT, LB, RB",
    TUTO_PADS_TEXT = "Di base (in verde) funzionano come nel gioco: LT e RT sono modificatori, LB seleziona gli alleati e RB i nemici. Le azioni della barra del controller del gioco vengono copiate nei loro strati. Puoi cambiarli: per esempio RB come pulsante semplice, o LB come modificatore.",
    TUTO_PADS_DEFAULT = "Torna ai tipi predefiniti",
    TUTO_PAIRS_TITLE = "Coppie: due pulsanti tenuti insieme",
    TUTO_PAIRS_TEXT = "Tieni premuti due pulsanti insieme (modificatori o di selezione bersaglio): un altro strato di 8 azioni. Due pulsanti qualsiasi possono formare una coppia: L5 + R5, LT + RT, LB + LT... Spunta quelle che vuoi (potrai cambiarle nella scheda |cffffd100Pulsanti|r). Predefinite: le coppie sinistra + destra.",
    TUTO_ACTIONS_TITLE = "Posiziona le tue azioni",
    TUTO_ACTIONS_TEXT = "Nella scheda |cffffd100Azioni|r: a sinistra, tutti i tuoi strati (Da solo, LT, RT, i tuoi modificatori e coppie); a destra, lo strato scelto, disposto come il controller.\n\n- Trascina un incantesimo dal libro degli incantesimi, un oggetto dalle borse, una macro, una cavalcatura o un giocattolo su una casella.\n- Oppure clicca su una casella: scegliere un incantesimo o un oggetto, scrivere una macro, scegliere un comando di WoW (Corsa automatica...) o un'azione di base (Salta, Interagisci...). Clic destro: svuota.\n- La riga sotto la croce: le caselle dei tuoi pulsanti semplici in quello strato.\n\nPuoi anche cliccare su una miniatura di strato nell'HUD per modificarla lì.\n\nLe azioni sono salvate per personaggio; tipi e tasti nel profilo, per tutto l'account. Tutto funziona in combattimento; solo le modifiche fatte in combattimento aspettano la sua fine.",
    TUTO_HUD_TEXT = "L'addon sostituisce la barra del controller del gioco con il proprio HUD:\n\n- |cffffd100In grande|r: lo strato che stai usando, croce a sinistra, A/B/X/Y a destra. Tieni premuto un pulsante e cambia.\n- |cffffd100Le miniature|r: tutti i tuoi strati, con al centro le caselle dei tuoi pulsanti semplici; quello tenuto si illumina. Clicca su una per modificarla.\n- |cffffd100Al centro|r: i tuoi pulsanti semplici, con l'azione che lanceranno.\n\nImpostazioni (dimensione, posizione, miniature): scheda |cffffd100HUD|r. |cffffd100/mgir hud off|r: torna alla barra del gioco.",
    TUTO_DONE_TEXT = "Apri la configurazione per posizionare le tue prime azioni.\n\n|cffffd100/mgir|r: apri la configurazione\n|cffffd100/mgir test|r: test del controller, per vedere cosa riceve WoW\n|cffffd100/mgir tuto|r: questo tutorial\n|cffffd100/mgir reset|r: svuota le azioni di questo personaggio\n|cffffd100/mgir restore|r: restituisci LT, RT, LB e RB al gioco",
    SETTINGS_DESC = "Scegli cosa fa ogni pulsante del tuo controller: pulsanti aggiuntivi (palette posteriori, grilletti extra) e pulsanti di base (LT, RT, LB, RB). Comando: /mgir",
    BUTTONS_INTRO = "Scegli il tipo di ogni pulsante: passa il mouse su un tipo per vedere cosa fa. In verde: il tipo predefinito dei pulsanti di base, che funziona come nel gioco.",
    BUTTONS_TYPES_HELP = "I tipi di pulsante",
    PAIRS_HINT = "Spunta le coppie da usare: tenere premuti i due pulsanti insieme dà 8 azioni in più. Due modificatori o pulsanti di selezione bersaglio qualsiasi possono formare una coppia (L5 + LT, LB + RT...).",
    PAIRS_NONE = "Imposta almeno due pulsanti come Modificatore, Alleato o Nemico per formare coppie.",
    PAIR_WAITS = "%s è su Gioco: impostalo su Modificatore, Alleato o Nemico (sopra)",
})

-- Tutoriel, paires : appuyer sur les boutons pour les trouver
ns.AddLocale("itIT", {
    TUTO_PAIRS_PRESS = "Premi un pulsante del controller: le sue coppie si illuminano di verde. Premi due pulsanti insieme: si illumina la loro coppia.",
})

-- LB + LT et RB + RT : l'action de classe de Forever
ns.AddLocale("itIT", {
    PAIR_CLASS_WARN = "attiva anche l'azione di classe di Forever",
    PAIR_CLASS_WARN_LONG = "Attenzione: %s attiva anche l'azione di classe di Forever (spesso una ruota di incantesimi che prende il controllo di A, B, X e Y finché è aperta; B la chiude). L'addon non può impedirlo: meglio scegliere un'altra coppia.",
    PAIR_CLASS_NOTE = "%s e %s attivano anche l'azione di classe di Forever (spesso una ruota di incantesimi che prende il controllo di A, B, X e Y). L'addon non può impedirlo: meglio scegliere altre coppie.",
})

-- Forever resté sur sa barre LT / RT
ns.AddLocale("itIT", {
    FOREVER_STUCK = "Forever è rimasto sulla sua barra %s (il rilascio di un pulsante è andato perso). Premi %s una volta per tornare a «Da solo».",
})

-- 1.1.0 : spés, état des actions sur le HUD, profils, remplissage rapide, rapport
ns.AddLocale("itIT", {
    SPEC_NUMBER = "Specializzazione %d",
    SPEC_SWITCHED = "Azioni della specializzazione «%s».",
    SPEC_NEW = "Nuova specializzazione «%s»: parte con una copia delle azioni della precedente.",
    PROFILE_PER_CHAR = "Ricorda il profilo di ogni personaggio",
    PROFILE_PER_CHAR_DESC = "All'accesso, ogni personaggio riprende l'ultimo profilo che ha usato. Senza questa opzione, tutti prendono l'ultimo profilo usato sull'account.",
    REPORT_BUTTON = "Copia un rapporto",
    REPORT_TITLE = "Rapporto del controller",
    REPORT_HINT = "Premi prima ogni pulsante nella scheda Test, poi copia questo testo (Ctrl+C) e invialo all'autore dell'addon, con ciò che funziona e ciò che non funziona. Aiuta a confermare le impostazioni di altri controller. Non contiene nomi di personaggi né di reami.",
    WHATSNEW_TITLE = "Novità di My Gamepad Is Rich",
    QUICKFILL_BUTTON = "Riempi gli spazi vuoti",
    QUICKFILL_DESC = "Mette negli spazi vuoti di questo strato la pietra del ritorno, i monili utilizzabili indossati e i consumabili delle borse (pozioni, cibo, bende, elisir...), tranne quelli già presenti. Clic destro su uno spazio per svuotarlo.",
    QUICKFILL_DONE = "Spazi riempiti: %d.",
    QUICKFILL_NONE = "Niente da mettere: nessun oggetto utilizzabile nelle borse che non sia già su questo strato.",
})

-- 1.1.0 : modèles de classe, copie de couches, verrou, annulation, véhicules
ns.AddLocale("itIT", {
    SLASH_HELP = "/mgir : apri  |  /mgir profile <nome> : cambia profilo  |  /mgir test : test controller  |  /mgir tuto : tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : azzera le azioni di questo personaggio  |  /mgir undo : annulla l'ultima modifica delle azioni",
    LEARN_PAD_REFUSED = "%s è un pulsante di base del controller: l'addon lo combina o lo configura da sé. Premi il pulsante aggiuntivo (il tasto inviato dal suo software).",
    RESET_CONFIRM = "Svuotare tutte le azioni di questo personaggio nel profilo attuale?",
    RESET_CONFIRM_SPEC = "Svuotare tutte le azioni di questo personaggio per la specializzazione «%s», nel profilo attuale?",
    UNDO_HINT = "/mgir undo per tornare indietro.",
    UNDO_DONE = "Azioni ripristinate come prima dell'ultima modifica.",
    UNDO_NONE = "Niente da annullare per questa specializzazione.",
    ACTION_COUNT = "%d azione/i",
    LAYER_COPY_BUTTON = "Copia / scambia…",
    LAYER_COPY_DESC = "Copia le azioni di questo strato in un altro strato, oppure scambia le azioni dei due strati (gli 8 spazi e quelli dei pulsanti semplici).",
    LAYER_COPY_TITLE = "Strato %s",
    LAYER_COPY_TO = "Copia in",
    LAYER_SWAP_WITH = "Scambia con",
    LAYER_COPY_NONE = "Nessun altro strato di combinazioni: prima rendi un altro pulsante un modificatore.",
    LAYER_COPY_CONFIRM = "Sostituire le azioni dello strato %s (%d) con quelle di %s?",
    LAYER_COPIED = "%s copiato in %s.",
    LAYER_SWAPPED = "%s e %s scambiati.",
    TPL_BUTTON = "Modelli e specializzazioni…",
    TPL_DESC = "Modelli di classe: salva le azioni di questa specializzazione per tutto l'account, poi caricale su un altro personaggio della stessa classe. Puoi anche copiare le azioni di un'altra specializzazione. Le azioni lasciate sulla barra del gioco non sono incluse.",
    TPL_TITLE = "Modelli e specializzazioni",
    TPL_SECTION_SAVE = "Salva",
    TPL_SAVE = "Salva queste azioni come modello…",
    TPL_SECTION_LOAD = "Carica un modello (%s)",
    TPL_SECTION_SPEC = "Copia da una specializzazione",
    TPL_SECTION_DELETE = "Elimina un modello",
    TPL_SAVE_PROMPT = "Nome del modello (per tutti i personaggi %s dell'account):",
    TPL_SAVED = "Modello «%s» salvato per %s.",
    TPL_REPLACE_CONFIRM = "Sostituire il modello «%s»?",
    TPL_LOAD_CONFIRM = "Caricare il modello «%s»? Sostituisce le azioni di %s.",
    TPL_LOADED = "Modello «%s» caricato.",
    TPL_DELETE_CONFIRM = "Eliminare il modello «%s» per tutti i personaggi di questa classe?",
    TPL_DELETED = "Modello «%s» eliminato.",
    SPEC_COPY_CONFIRM = "Copiare le azioni di «%s»? Sostituiscono le azioni di %s.",
    SPEC_COPIED = "Azioni di «%s» copiate.",
    LATCH = "Bloccabile",
    LATCH_DESC = "Una pressione attiva lo strato di questo modificatore, la successiva lo disattiva: non serve tenerlo premuto. Un altro modificatore tenuto premuto prende il controllo finché è premuto. Qualsiasi modifica delle impostazioni lo sblocca. Solo pulsanti aggiuntivi (non LT, RT, LB, RB).",
})

-- 1.1.0 : notes de version (tout ce qui a changé depuis la 1.0.0)
ns.AddLocale("itIT", {
    WHATSNEW_1_1_5 = "• Bersaglio alleato / nemico: in combattimento il pulsante non resta più premuto dopo il rilascio (l'HUD restava sul suo strato e lo stick continuava a mirare). Una pressione breve passa ancora al bersaglio successivo e una lunga mantiene il bersaglio scelto.",
    WHATSNEW_1_1_4 = "• Bersaglio alleato / nemico: ogni pressione breve passa al bersaglio successivo, anche se ne hai già uno, anche dove il gioco non fornisce l'ora all'addon. Una pressione lunga mantiene il bersaglio scelto con lo stick.\n• /mgir etat indica come viene riconosciuta una pressione breve.",
    WHATSNEW_1_1_3 = "• Bersaglio alleato / nemico: il bersaglio scelto con lo stick resta quando rilasci il pulsante. Solo una pressione breve seleziona il più vicino.",
    WHATSNEW_1_1_2 = "• Un comando di WoW o una macro scritta a mano può usare l'icona che preferisci: clic sulla casella, \"Cambia icona...\". La ricerca trova le icone dei tuoi incantesimi, dei tuoi oggetti e dei comandi di WoW, oppure un'icona dal suo nome file (come su Wowhead: inv_misc_map_01).\n• I comandi più comuni hanno una propria icona al posto della chiave: mappa del mondo, borse, libro degli incantesimi, registro missioni, personaggio, imprese, ricerca gruppi, collezioni.",
    WHATSNEW_1_1_1 = "• Pulsante semplice: uno strato vuoto (LT, RT o un modificatore) ora non fa nulla e resta vuoto nell'HUD, invece di usare l'azione \"Da solo\". Unica eccezione: un comando di WoW messo su \"Da solo\".\n• L'elenco degli incantesimi include ora quelli di professione: Trova erbe, Trova minerali, Pesca, Cucina, Archeologia…",
    WHATSNEW_1_1_0 = "• HUD: le azioni dell'addon appaiono come sulle barre del gioco. Rosse fuori portata, blu senza risorse sufficienti, grigie se inutilizzabili, bordo dorato durante un proc, cariche rimanenti, illuminate mentre sono attive (attacco automatico, forma...).\n• HUD: l'ordine delle miniature degli strati si può scegliere (frecce della scheda HUD, oppure trascina una miniatura su un'altra).\n• Ogni specializzazione ha le sue azioni. Una nuova specializzazione parte con una copia delle azioni della precedente.\n• Scheda Azioni: «Riempi gli spazi vuoti» mette pietra del ritorno, monili e consumabili delle borse su uno strato di modificatore, e «Copia / scambia…» copia uno strato di combinazioni in un altro, oppure scambia due strati.\n• Modelli di classe: salva le tue azioni per tutto l'account, poi caricale su un altro personaggio della stessa classe («Modelli e specializzazioni…» sotto l'elenco degli strati). Puoi anche copiare le azioni di un'altra specializzazione.\n• Modificatore bloccabile (scheda Pulsanti): una pressione attiva lo strato, la successiva lo disattiva.\n• /mgir reset chiede conferma, e /mgir undo torna indietro dopo un azzeramento, un modello o una copia di specializzazione o di strato.\n• Profili: opzione «Ricorda il profilo di ogni personaggio».\n• Strati bloccati: un pulsante di base dato all'addon resta a chi ha ricevuto la pressione finché non viene rilasciato, e Forever non resta più bloccato sulla sua barra RT (o LT), per esempio dopo un incantesimo lanciato con RT + A come un sigillo del paladino.\n• Veicoli, barre sostitutive e scontri tra mascotte: l'addon si fa da parte e i pulsanti del gioco funzionano, anche in combattimento.\n• Non serve più /mgir restore prima di disattivare l'addon: a ogni disconnessione, LT e LB ritrovano l'imitazione di Maiusc / Ctrl, e l'addon la toglie di nuovo all'accesso.\n• Rileva rifiuta A, B, X, Y, la croce e LT, RT, LB, RB (premuti per errore, diventerebbero il tasto di un pulsante aggiuntivo).\n• Scheda Test controller: «Copia un rapporto» (con il registro recente degli strati), da inviare per aiutare a confermare altri controller. /mgir etat mostra lo stato degli strati.\n• /mgir news: rivedere questa finestra.",
})
