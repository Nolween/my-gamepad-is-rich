-- Italiano
local _, ns = ...

ns.AddLocale("itIT", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "Pulsanti",
    TAB_TEST = "Test controller",
    TAB_HELP = "Aiuto",

    EXTRA = "Pulsante",
    NAME = "Nome:",
    KEY = "Tasto:",
    KEY_NONE = "non impostato",
    DETECT = "Rileva",
    CLEAR = "Cancella",
    MODE = "Modalità:",
    MODE_MODIFIER = "Modificatore",
    MODE_SIMPLE = "Pulsante semplice",
    MODE_OFF = "Disattivato",
    MODE_MODIFIER_DESC = "Tieni premuto questo pulsante e premi A, B, X, Y o la croce direzionale: 8 nuove combinazioni, come LT/RT.",
    MODE_SIMPLE_DESC = "Un'azione, più una con LT tenuto premuto e una con RT tenuto premuto. Uno strato vuoto usa l'azione \"Da solo\".",
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
    LEARN_MODKEY = "Attenzione: %s è un tasto Maiusc / Ctrl / Alt; in GameSir Nexus meglio un tasto come F9-F12.",
    LEARN_BOUND = "Nota: %s era assegnato a \"%s\" in WoW; finché questo addon lo usa, ha la precedenza l'addon.",

    TEST_INTRO = "Premi un pulsante qualsiasi: ciò che WoW riceve si illumina. Se L5 / R5 / L4 / R4 non mostrano nulla, assegna loro dei tasti in GameSir Nexus (vedi Aiuto).",
    TEST_STANDARD = "Pulsanti standard",
    TEST_EXTRA = "Pulsanti aggiuntivi",
    TEST_LOG = "Ultimi input",
    TEST_GAME = "gioco",
    TEST_UNKNOWN = "non assegnato",

    IF_WARNING = "Improved Forever è caricato: se usa anche uno di questi tasti, vince l'ultima assegnazione applicata.",
    OPEN_CONFIG = "Apri la configurazione",
    SETTINGS_DESC = "Configura i pulsanti aggiuntivi del tuo GameSir G7 Pro (L5/R5, L4/R4). Comando: /mgir",
    LOADED = "caricato. Scrivi /mgir per configurare i pulsanti aggiuntivi.",
    SLASH_HELP = "/mgir : apri  |  /mgir test : test controller  |  /mgir tuto : tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : azzera le azioni di questo personaggio",
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
    TUTO_SUGGESTED = "Usa le modalità consigliate",
    HELP_REPLAY = "Rivedi il tutorial",

    TUTO_WELCOME_TITLE = "Benvenuto in My Gamepad Is Rich",
    TUTO_WELCOME_TEXT = "Questo addon porta in WoW i pulsanti aggiuntivi del tuo GameSir G7 Pro:\n\n"
        .. "|cffffd100L5 / R5|r: i terzi grilletti\n"
        .. "|cffffd100L4 / R4|r: le palette posteriori\n\n"
        .. "Ognuno può essere un modificatore da tenere premuto (8 nuove combinazioni con A, B, X, Y e la croce direzionale) "
        .. "o un pulsante semplice con i propri strati LT e RT.\n\n"
        .. "Questo tutorial dura circa due minuti. Puoi uscire in qualsiasi momento e riaprirlo con |cffffd100/mgir tuto|r.",

    TUTO_NEXUS_TITLE = "Passo 1: GameSir Nexus",
    TUTO_NEXUS_TEXT = "Windows vede il G7 Pro come un controller Xbox 360. Questa modalità trasmette solo i pulsanti standard, "
        .. "quindi WoW non riceve mai L5, R5, L4 e R4. La soluzione: far loro inviare un tasto della tastiera.\n\n"
        .. "1. Collega il controller e apri |cffffd100GameSir Nexus|r (Microsoft Store).\n"
        .. "2. Apri la pagina di mappatura dei pulsanti.\n"
        .. "3. Assegna a L5, R5, L4 e R4 un tasto che non usi in WoW. Buone scelte: |cffffd100F9, F10, F11, F12|r "
        .. "o il tastierino numerico (con Bloc Num attivo).\n"
        .. "4. Evita Maiusc, Ctrl e Alt: cambierebbero le tue altre assegnazioni.\n"
        .. "5. Salva il profilo sul controller.\n\n"
        .. "Fatto? Passa al passo successivo.",

    TUTO_DETECT_TITLE = "Passo 2: Rileva i tuoi pulsanti",
    TUTO_DETECT_TEXT = "Per ogni pulsante, clicca su |cffffd100Rileva|r, poi premi quel pulsante sul controller. "
        .. "Il tasto inviato appare accanto.",
    TUTO_DETECT_ALL = "|cff40ff40Tutti e quattro i pulsanti sono rilevati.|r",
    TUTO_DETECT_MISSING = "Non succede nulla quando premi? Controlla il tasto del pulsante in GameSir Nexus e riprova.",

    TUTO_MODES_TITLE = "Passo 3: Scegli una modalità",
    TUTO_MODES_TEXT = "|cffffd100Modificatore|r: tieni premuto il pulsante, poi premi A, B, X, Y o la croce. 8 azioni per pulsante, come LT e RT.\n"
        .. "|cffffd100Pulsante semplice|r: un'azione, più una con LT tenuto premuto e una con RT tenuto premuto.\n"
        .. "|cffffd100Disattivato|r: il tasto resta libero.\n\n"
        .. "Consiglio: modificatori su L5 e R5 (facili da tenere premuti), pulsanti semplici su L4 e R4.",

    TUTO_ACTIONS_TITLE = "Passo 4: Posiziona le tue azioni",
    TUTO_ACTIONS_TEXT = "Nella finestra di configurazione, ogni pulsante mostra i suoi spazi.\n\n"
        .. "- Trascina un incantesimo dal libro degli incantesimi, un oggetto dalle borse, una macro, una cavalcatura o un giocattolo su uno spazio.\n"
        .. "- Oppure clic destro su uno spazio: scegli un incantesimo o un oggetto della borsa, scrivi una macro, scegli un comando di WoW (come Corsa automatica) o svuotalo.\n\n"
        .. "Le azioni sono salvate per personaggio; tasti e modalità per tutto l'account. "
        .. "Tutto funziona in combattimento; solo le modifiche fatte in combattimento aspettano che finisca.",

    TUTO_DONE_TITLE = "Tutto pronto",
    TUTO_DONE_TEXT = "Apri la configurazione per posizionare le tue prime azioni.\n\n"
        .. "|cffffd100/mgir|r: apri la configurazione\n"
        .. "|cffffd100/mgir test|r: test controller, per vedere cosa riceve WoW\n"
        .. "|cffffd100/mgir tuto|r: questo tutorial\n"
        .. "|cffffd100/mgir reset|r: svuota le azioni di questo personaggio",
})

-- HUD
ns.AddLocale("itIT", {
    HUD_UNLOCKED = "HUD sbloccato: trascinalo con il mouse. Scrivi di nuovo /mgir hud per bloccarlo.",
    HUD_LOCKED = "HUD bloccato.",
    HUD_ON = "HUD visibile: sostituisce la barra del controller del gioco.",
    HUD_OFF = "HUD nascosto: torna la barra del controller del gioco. Scrivi /mgir hud on per mostrarlo di nuovo.",
    HUD_SCALE = "Dimensione dell'HUD: %s",
    TUTO_HUD_TITLE = "Il tuo HUD del controller",
    TUTO_HUD_TEXT = "L'addon sostituisce la barra del controller del gioco con il proprio HUD, in basso sullo schermo:\n\n"
        .. "- |cffffd100In grande|r: lo strato che stai usando, croce a sinistra, A/B/X/Y a destra. Tieni premuto LT, RT, L5 o R5 e cambia.\n"
        .. "- |cffffd100Nella striscia|r (in basso, o in alto con /mgir hud strip): tutti gli strati in miniatura (Da solo, LT, RT, LT+RT, L5, R5); quello tenuto si illumina.\n"
        .. "- |cffffd100Al centro|r: L4 e R4, con l'azione che partirà in base al grilletto tenuto.\n\n"
        .. "Si attenua fuori dal combattimento quando non tieni premuto nulla.\n"
        .. "|cffffd100/mgir hud|r: spostarlo  -  |cffffd100/mgir hud scale 1.2|r: dimensione  -  |cffffd100/mgir hud off|r: tornare alla barra del gioco",
})

-- HUD : attribution rapide
ns.AddLocale("itIT", {
    HUD_COMBAT = "Non puoi cambiare le azioni in combattimento.",
    HUD_GAME_SLOT = "Questo pulsante mantiene l'azione del gioco (saltare, interagire...).",
    HUD_KIND = "La barra del gioco accetta solo incantesimi, oggetti, cavalcature e macro dell'elenco delle macro.",
    HUD_EDITING = "Modifica di questo strato: clicca su uno spazio per assegnarlo, clic destro per svuotarlo. Clicca di nuovo sulla miniatura per tornare.",
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

-- Paires de modificateurs (L5 + R5, L4 + R4)
ns.AddLocale("itIT", {
    PAIR_READY = "Coppia · tieni entrambi",
    PAIR_NOT_READY = "Coppia · non disponibile",
    PAIR_DESC = "Tieni premuti %s e %s insieme, poi premi A, B, X, Y o la croce: 8 combinazioni in più.",
    PAIR_NEEDS = "Per usare questa coppia, %s e %s devono essere entrambi in modalità Modificatore, con un tasto.",
    TUTO_PAIRS_TEXT = "|cffffd100Coppie|r: se L5 e R5 sono entrambi modificatori, tenerli premuti insieme dà 8 combinazioni in più. Lo stesso per L4 + R4.",
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
    LAYER_DESC_BASE = "A, B, X, Y e la croce senza tenere premuto nulla. A, B, X e Y mantengono le azioni del gioco (saltare, interagire...).",
    LAYER_DESC_HOLD = "Tieni premuto %s, poi premi A, B, X, Y o la croce.",
    BUTTONS_INTRO = "I tuoi pulsanti aggiuntivi: il tasto che GameSir Nexus invia e cosa fa ognuno. Passa sopra una modalità per vedere cosa fa.",
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
})
