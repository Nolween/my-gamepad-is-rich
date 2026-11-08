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
    TUTO_SUGGESTED = "Usa le modalità consigliate",
    HELP_REPLAY = "Rivedi il tutorial",

    TUTO_WELCOME_TITLE = "Benvenuto in My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "Per ogni pulsante, clicca su |cffffd100Rileva|r, poi premi quel pulsante sul controller. "
        .. "Il tasto inviato appare accanto.",


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
    LAYER_DESC_BASE = "A, B, X, Y e la croce senza tenere premuto nulla. A, B, X e Y mantengono le azioni del gioco (saltare, interagire...).",
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
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("itIT", {
    CONTROLLER_LABEL = "Controller:",
    CONTROLLER_CHANGE = "Cambia...",
    CONTROLLER_PICK = "Scegli il tuo controller",
    CONTROLLER_OTHER = "Altro controller",
    EXTRA = "Pulsante",
    SOFTWARE_GENERIC = "il software del tuo controller",
    SETTINGS_DESC = "Configura i pulsanti aggiuntivi del tuo controller (palette posteriori, grilletti extra). Comando: /mgir",
    BUTTONS_INTRO = "Il tuo controller e i suoi pulsanti aggiuntivi: il tasto che ognuno invia e cosa fa. Passa sopra una modalità per vedere cosa fa.",
    TEST_INTRO = "Premi un pulsante qualsiasi: ciò che WoW riceve si illumina. Se i tuoi pulsanti aggiuntivi non mostrano nulla, assegna loro dei tasti nel software del tuo controller (vedi Aiuto).",
    LEARN_MODKEY = "Attenzione: %s è un tasto Maiusc / Ctrl / Alt; nel software del tuo controller meglio un tasto come F9-F12.",

    TUTO_WELCOME_TEXT = "Questo addon porta in WoW i pulsanti aggiuntivi del tuo controller: palette posteriori, grilletti o pulsanti extra "
        .. "(GameSir, Xbox Elite, DualSense Edge, SCUF, 8BitDo, Flydigi...).\n\n"
        .. "Ognuno può essere un modificatore da tenere premuto (8 nuove combinazioni con A, B, X, Y e la croce direzionale) "
        .. "o un pulsante semplice con i propri strati LT e RT.\n\n"
        .. "Questo tutorial dura circa due minuti. Puoi uscire in qualsiasi momento e riaprirlo con |cffffd100/mgir tuto|r.",

    TUTO_CONTROLLER_TITLE = "Passo 1: Il tuo controller",
    TUTO_CONTROLLER_TEXT = "Scegli il tuo controller: l'addon userà i nomi dei suoi pulsanti e ti dirà quale software li configura. "
        .. "Non è nell'elenco? Scegli |cffffd100Altro controller|r (fino a 6 pulsanti, che puoi rinominare).",

    TUTO_SOFTWARE_TITLE = "Passo 2: Far inviare un tasto ai pulsanti",
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

    TUTO_DETECT_TITLE = "Passo 3: Rileva i tuoi pulsanti",
    TUTO_DETECT_ALL = "|cff40ff40Tutti i tuoi pulsanti sono rilevati.|r",
    TUTO_DETECT_MISSING = "Non succede nulla quando premi? Controlla il tasto del pulsante nel software del tuo controller (passo 2) e riprova.",

    TUTO_MODES_TITLE = "Passo 4: Scegli una modalità",
    TUTO_MODES_TEXT = "|cffffd100Modificatore|r: tieni premuto il pulsante, poi premi A, B, X, Y o la croce. 8 azioni per pulsante, come LT e RT.\n"
        .. "|cffffd100Pulsante semplice|r: un'azione, più una con LT tenuto premuto e una con RT tenuto premuto.\n"
        .. "|cffffd100Disattivato|r: il tasto resta libero.\n\n"
        .. "Consiglio: modificatori sui pulsanti più facili da tenere premuti, pulsanti semplici sugli altri.",
    TUTO_PAIRS_TEXT = "|cffffd100Coppie|r: i pulsanti vanno in coppie sinistra + destra. Se entrambi i pulsanti di una coppia sono modificatori, "
        .. "tenerli premuti insieme dà 8 combinazioni in più.",

    TUTO_ACTIONS_TITLE = "Passo 5: Posiziona le tue azioni",

    TUTO_HUD_TEXT = "L'addon sostituisce la barra del controller del gioco con il proprio HUD, in basso sullo schermo:\n\n"
        .. "- |cffffd100In grande|r: lo strato che stai usando, croce a sinistra, A/B/X/Y a destra. Tieni premuto LT, RT o un modificatore e cambia.\n"
        .. "- |cffffd100Nella striscia|r (in basso, o in alto con /mgir hud strip): tutti gli strati in miniatura (Da solo, LT, RT, LT+RT, i tuoi modificatori e coppie); quello tenuto si illumina.\n"
        .. "- |cffffd100Al centro|r: i tuoi pulsanti semplici, con l'azione che partirà in base al grilletto tenuto.\n\n"
        .. "Si attenua fuori dal combattimento quando non tieni premuto nulla.\n"
        .. "|cffffd100/mgir hud|r: spostarlo  -  |cffffd100/mgir hud scale 1.2|r: dimensione  -  |cffffd100/mgir hud off|r: tornare alla barra del gioco",
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
