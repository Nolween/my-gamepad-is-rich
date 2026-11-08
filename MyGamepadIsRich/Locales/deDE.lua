-- Deutsch
local _, ns = ...

ns.AddLocale("deDE", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "Tasten",
    TAB_TEST = "Controller-Test",
    TAB_HELP = "Hilfe",

    NAME = "Name:",
    KEY = "Taste:",
    KEY_NONE = "nicht festgelegt",
    DETECT = "Erkennen",
    CLEAR = "Löschen",
    MODE = "Modus:",
    MODE_MODIFIER = "Modifikator",
    MODE_SIMPLE = "Einfache Taste",
    MODE_OFF = "Deaktiviert",
    MODE_MODIFIER_DESC = "Halte diese Taste gedrückt und drücke A, B, X, Y oder das Steuerkreuz: 8 neue Kombinationen, wie bei LT/RT.",
    MODE_SIMPLE_DESC = "Eine Aktion, dazu eine mit gehaltenem LT und eine mit gehaltenem RT. Eine leere Ebene nutzt die Aktion „Allein“.",
    MODE_OFF_DESC = "Diese Taste macht nichts: ihre Belegung bleibt frei.",
    LAYER_BASE = "Allein",
    LAYER_LT = "LT +",
    LAYER_RT = "RT +",
    SLOT_HINT = "Ziehe einen Zauber, Gegenstand, ein Makro oder Reittier auf einen Platz. Rechtsklick: mehr Optionen.",
    EMPTY = "Leer",
    NO_KEY_WARNING = "Lege zuerst die Taste fest: Klicke auf „Erkennen“ und drücke die Taste.",

    MENU_SPELL = "Zauber wählen...",
    MENU_ITEM = "Gegenstand aus der Tasche wählen...",
    SPELL_TITLE = "Zauber des Charakters",
    ITEM_TITLE = "Gegenstände in den Taschen",
    ITEMS_EQUIPPED = "Angelegt (benutzbar)",
    ITEMS_USABLE = "Benutzbar",
    ITEMS_OTHER = "Andere Gegenstände",
    LIST_EMPTY = "Nichts anzuzeigen.",
    MENU_MACROTEXT = "Makro schreiben...",
    MENU_COMMAND = "WoW-Befehl...",
    MENU_CLEAR = "Leeren",
    MENU_PICKUP_HINT = "Oder lege hier einen Zauber / Gegenstand / Makro / Reittier ab",
    MACRO_TITLE = "Makrotext",
    MACRO_HELP = "Ein Befehl pro Zeile, z. B. /cast Feuerball  (max. 255 Zeichen)",
    OK = "OK",
    CANCEL = "Abbrechen",
    COMMAND_TITLE = "WoW-Befehl",
    SEARCH = "Suchen:",
    COMMAND_LT_RT = "Ein WoW-Befehl funktioniert nur auf der Ebene „Allein“ einer Taste ohne LT/RT-Ebene.",

    KIND_spell = "Zauber",
    KIND_item = "Gegenstand",
    KIND_toy = "Spielzeug",
    KIND_mount = "Reittier",
    KIND_macro = "Makro",
    KIND_macrotext = "Eigenes Makro",
    KIND_command = "WoW-Befehl",
    KIND_equipset = "Ausrüstungsset",

    CURSOR_UNSUPPORTED = "Das kann nicht auf eine Taste (nur Zauber, Gegenstände, Spielzeuge, Reittiere, Makros, Ausrüstungssets).",
    APPLIED_AFTER_COMBAT = "Im Kampf: Änderungen werden nach dem Kampf übernommen.",
    APPLIED = "Änderungen übernommen.",
    LEARN_PROMPT = "Drücke die Controller-Taste für |cffffd100%s|r\n\n(Esc zum Abbrechen)",
    LEARN_COMBAT = "Im Kampf kann keine Taste erkannt werden.",
    LEARN_DONE = "%s liegt jetzt auf der Taste %s.",
    LEARN_TAKEN = "Die Taste %s wurde von %s benutzt: dort entfernt.",
    LEARN_BOUND = "Hinweis: %s war in WoW mit „%s“ belegt; solange dieses Addon sie nutzt, hat das Addon Vorrang.",

    TEST_STANDARD = "Standardtasten",
    TEST_EXTRA = "Zusatztasten",
    TEST_LOG = "Letzte Eingaben",
    TEST_GAME = "Spiel",
    TEST_UNKNOWN = "nicht zugewiesen",

    IF_WARNING = "Improved Forever ist geladen: Nutzt es auch eine dieser Tasten, gewinnt die zuletzt gesetzte Belegung.",
    OPEN_CONFIG = "Konfiguration öffnen",
    LOADED = "geladen. Gib /mgir ein, um deine Zusatztasten einzurichten.",
    RESET_DONE = "Die Aktionen dieses Charakters wurden zurückgesetzt.",

    DPAD_UP = "Steuerkreuz oben",
    DPAD_DOWN = "Steuerkreuz unten",
    DPAD_LEFT = "Steuerkreuz links",
    DPAD_RIGHT = "Steuerkreuz rechts",
    PADDLE = "Paddel %s",

    TUTO_TITLE = "Tutorial",
    TUTO_NEXT = "Weiter",
    TUTO_BACK = "Zurück",
    TUTO_SKIP = "Tutorial überspringen",
    TUTO_FINISH = "Konfiguration öffnen",
    TUTO_REOPEN = "Tutorial geschlossen. Gib /mgir tuto ein, um es erneut zu sehen.",
    TUTO_SUGGESTED = "Empfohlene Modi verwenden",
    HELP_REPLAY = "Tutorial erneut ansehen",

    TUTO_WELCOME_TITLE = "Willkommen bei My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "Klicke für jede Taste auf |cffffd100Erkennen|r und drücke dann diese Taste am Controller. "
        .. "Die gesendete Taste erscheint daneben.",


    TUTO_ACTIONS_TEXT = "Im Konfigurationsfenster zeigt jede Taste ihre Plätze.\n\n"
        .. "- Ziehe einen Zauber aus dem Zauberbuch, einen Gegenstand aus den Taschen, ein Makro, Reittier oder Spielzeug auf einen Platz.\n"
        .. "- Oder Rechtsklick auf einen Platz: Zauber oder Taschengegenstand wählen, Makro schreiben, WoW-Befehl wählen (z. B. Automatisch laufen) oder leeren.\n\n"
        .. "Aktionen werden pro Charakter gespeichert, Tasten und Modi für den ganzen Account. "
        .. "Alles funktioniert im Kampf; nur Änderungen während des Kampfes warten auf sein Ende.",

    TUTO_DONE_TITLE = "Alles bereit",
    TUTO_DONE_TEXT = "Öffne die Konfiguration, um deine ersten Aktionen festzulegen.\n\n"
        .. "|cffffd100/mgir|r: Konfiguration öffnen\n"
        .. "|cffffd100/mgir test|r: Controller-Test, um zu sehen, was WoW empfängt\n"
        .. "|cffffd100/mgir tuto|r: dieses Tutorial\n"
        .. "|cffffd100/mgir reset|r: Aktionen dieses Charakters löschen",
})

-- HUD
ns.AddLocale("deDE", {
    HUD_UNLOCKED = "HUD entsperrt: Ziehe es mit der Maus. Gib erneut /mgir hud ein, um es zu sperren.",
    HUD_LOCKED = "HUD gesperrt.",
    HUD_ON = "HUD angezeigt: Es ersetzt die Controller-Leiste des Spiels.",
    HUD_OFF = "HUD ausgeblendet: Die Controller-Leiste des Spiels ist zurück. Gib /mgir hud on ein, um es wieder anzuzeigen.",
    HUD_SCALE = "HUD-Größe: %s",
    TUTO_HUD_TITLE = "Dein Controller-HUD",
})

-- HUD : attribution rapide
ns.AddLocale("deDE", {
    HUD_COMBAT = "Aktionen können im Kampf nicht geändert werden.",
    HUD_GAME_SLOT = "Diese Taste behält die Aktion des Spiels (Springen, Interagieren...).",
    HUD_KIND = "Die Leiste des Spiels nimmt nur Zauber, Gegenstände, Reittiere und Makros aus der Makroliste.",
    HUD_EDITING = "Ebene bearbeiten: Klicke auf einen Platz, um ihn zu belegen, Rechtsklick zum Leeren. Klicke erneut auf die Miniatur oder drücke eine andere Taste, um zurückzukehren.",
    HUD_TILE_HINT = "Klick: belegen  -  Rechtsklick: leeren",
    HUD_CARD_HINT = "Klick: diese Ebene bearbeiten",
})

-- HUD : bande des miniatures
ns.AddLocale("deDE", {
    HUD_STRIP_TOP = "Ebenen-Miniaturen jetzt über dem HUD. Gib /mgir hud strip ein, um zu wechseln.",
    HUD_STRIP_BOTTOM = "Ebenen-Miniaturen jetzt unter dem HUD. Gib /mgir hud strip ein, um zu wechseln.",
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("deDE", {
    TUTO_STRIP_LABEL = "Ebenen-Miniaturen:",
    TUTO_STRIP_BOTTOM = "Unten (empfohlen)",
    TUTO_STRIP_TOP = "Oben",
})

-- Bouton de la minimap
ns.AddLocale("deDE", {
    MINIMAP_LEFT = "Linksklick: Konfiguration öffnen",
    MINIMAP_RIGHT = "Rechtsklick: HUD entsperren / sperren, um es zu verschieben",
    MINIMAP_SHIFT = "Umschalt + Linksklick: Tutorial",
    MINIMAP_DRAG = "Ziehen: diese Taste um die Minikarte verschieben",
    MINIMAP_HIDDEN = "Minikarten-Taste ausgeblendet. Gib /mgir minimap ein, um sie wieder anzuzeigen.",
    MINIMAP_SHOWN = "Minikarten-Taste angezeigt.",
})

-- Paires de modificateurs
ns.AddLocale("deDE", {
    PAIR_READY = "Paar · beide halten",
    PAIR_NOT_READY = "Paar · nicht verfügbar",
    PAIR_DESC = "Halte %s und %s zusammen und drücke A, B, X, Y oder das Steuerkreuz: 8 weitere Kombinationen.",
    PAIR_NEEDS = "Für dieses Paar müssen %s und %s beide im Modus Modifikator sein, mit einer Taste.",
})

-- Fenêtre de configuration (onglets Actions, Boutons, HUD)
ns.AddLocale("deDE", {
    TAB_ACTIONS = "Aktionen",
    TAB_HUD = "HUD",
    SECTION_PAD = "Controller-Leiste",
    SECTION_MODS = "Modifikatoren",
    SECTION_MODS_EMPTY = "Noch keine: Stelle eine Taste im Reiter Tasten auf Modifikator.",
    SECTION_SIMPLE = "Einfache Tasten",
    SECTION_SIMPLE_EMPTY = "Noch keine: Stelle eine Taste im Reiter Tasten auf Einfache Taste.",
    LAYER_DESC_BASE = "A, B, X, Y und das Steuerkreuz, ohne etwas zu halten. Alles ist möglich: Was die Leiste des Spiels nicht halten kann (selbst geschriebenes Makro, WoW-Befehl), übernimmt das Addon. A, B, X und Y behalten die Aktionen des Spiels (Springen, Interagieren...), bis du eigene festlegst.",
    LAYER_DESC_HOLD = "Halte %s und drücke dann A, B, X, Y oder das Steuerkreuz.",
    PAIRS_TITLE = "Paare (zwei gemeinsam gehaltene Modifikatoren)",
    HUD_INTRO = "Das HUD ersetzt die Controller-Leiste des Spiels: die genutzte Ebene groß, alle Ebenen als Miniatur.",
    HUD_SHOW = "HUD anzeigen (statt der Controller-Leiste des Spiels)",
    HUD_SIZE = "Größe:",
    HUD_MOVE = "HUD verschieben",
    HUD_MOVE_DONE = "HUD sperren",
    HUD_RESET = "Position und Größe zurücksetzen",
    MINIMAP_SHOW = "Taste an der Minikarte",
    GAME_ACTION = "Spiel",
    BAR_UNAVAILABLE = "Die Controller-Leiste des Spiels ist nicht verfügbar (ist die Controller-Oberfläche aktiv?).",
    KIND_slot = "Aktion",
    SLOT_HINT = "Ziehe einen Zauber, Gegenstand, ein Makro oder Reittier auf einen Platz. Klick: Menü. Rechtsklick: leeren.",
})

-- HUD : taille et lignes des miniatures
ns.AddLocale("deDE", {
    HUD_STRIP_SIZE = "Größe der Miniaturen:",
    HUD_STRIP_ROWS = "Zeilen der Miniaturen:",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("deDE", {
    CONTROLLER_LABEL = "Controller:",
    CONTROLLER_CHANGE = "Ändern...",
    CONTROLLER_PICK = "Wähle deinen Controller",
    CONTROLLER_OTHER = "Anderer Controller",
    EXTRA = "Taste",
    SOFTWARE_GENERIC = "die Software deines Controllers",
    SETTINGS_DESC = "Richte die Zusatztasten deines Controllers ein (Rückseiten-Paddel, zusätzliche Trigger). Befehl: /mgir",
    BUTTONS_INTRO = "Dein Controller und seine Zusatztasten: die Taste, die jede sendet, und was sie tut. Fahre über einen Modus, um zu sehen, was er macht.",
    TEST_INTRO = "Drücke eine beliebige Taste: Was WoW empfängt, leuchtet auf. Zeigen deine Zusatztasten nichts an, belege sie in der Software deines Controllers mit Tastaturtasten (siehe Hilfe).",
    LEARN_MODKEY = "Achtung: %s ist eine Umschalt- / Strg- / Alt-Taste; nimm in der Software deines Controllers lieber eine Taste wie F9-F12.",

    TUTO_WELCOME_TEXT = "Dieses Addon bringt die Zusatztasten deines Controllers in WoW: Rückseiten-Paddel, zusätzliche Trigger oder Schultertasten "
        .. "(GameSir, Xbox Elite, DualSense Edge, SCUF, 8BitDo, Flydigi...).\n\n"
        .. "Jede davon kann ein gehaltener Modifikator sein (8 neue Kombinationen mit A, B, X, Y und dem Steuerkreuz) "
        .. "oder eine einfache Taste mit eigenen LT- und RT-Ebenen.\n\n"
        .. "Dieses Tutorial dauert etwa zwei Minuten. Du kannst es jederzeit verlassen und mit |cffffd100/mgir tuto|r wieder öffnen.",

    TUTO_CONTROLLER_TITLE = "Schritt 1: Dein Controller",
    TUTO_CONTROLLER_TEXT = "Wähle deinen Controller: Das Addon übernimmt dann die Namen seiner Tasten und sagt dir, mit welcher Software du sie einrichtest. "
        .. "Nicht in der Liste? Wähle |cffffd100Anderer Controller|r (bis zu 6 Tasten, die du umbenennen kannst).",

    TUTO_SOFTWARE_TITLE = "Schritt 2: Tastaturtasten zuweisen",
    TUTO_SOFTWARE_WHY = "Windows erkennt die meisten Controller als Xbox-Controller (XInput). Dieser Modus überträgt nur die Standardtasten, "
        .. "daher empfängt WoW die Zusatztasten nie. Die Lösung: Jede soll eine Tastaturtaste senden.",
    TUTO_SOFTWARE_VENDOR = "1. Schließe den Controller an und öffne |cffffd100%s|r.\n"
        .. "2. Öffne die Seite für die Tastenbelegung.\n"
        .. "3. Gib jeder Zusatztaste (%s) eine Tastaturtaste, die du in WoW nicht nutzt. Gute Wahl: |cffffd100F9, F10, F11, F12|r "
        .. "oder der Ziffernblock (mit aktivem Num-Lock).\n"
        .. "4. Vermeide Umschalt, Strg und Alt: Sie würden deine anderen Belegungen verändern.\n"
        .. "5. Speichere das Profil (auf dem Controller, wenn die Software das anbietet).",
    TUTO_SOFTWARE_ALT = "Kann %s diesen Tasten keine Tastaturtaste geben, nutze |cffffd100Steam Input|r: Füge WoW (oder den Battle.net-Launcher) "
        .. "als Nicht-Steam-Spiel zu Steam hinzu, starte es über Steam und gib jeder Taste in seiner Controller-Konfiguration eine Taste. "
        .. "|cffffd100reWASD|r (kostenpflichtig) geht auch, ohne Steam.",
    TUTO_SOFTWARE_STEAM = "1. Füge WoW (oder den Battle.net-Launcher) in |cffffd100Steam|r als Nicht-Steam-Spiel hinzu "
        .. "(Spiele > Ein Nicht-Steam-Spiel zur Bibliothek hinzufügen) und starte es über Steam.\n"
        .. "2. Öffne seine Controller-Konfiguration (Steam-Overlay oder die Controller-Einstellungen des Spiels in Steam).\n"
        .. "3. Gib jeder Zusatztaste (%s) eine Tastaturtaste, die du in WoW nicht nutzt. Gute Wahl: |cffffd100F9, F10, F11, F12|r.\n"
        .. "4. Vermeide Umschalt, Strg und Alt: Sie würden deine anderen Belegungen verändern.\n\n"
        .. "|cffffd100reWASD|r (kostenpflichtig) kann das auch ohne Steam.",

    TUTO_DETECT_TITLE = "Schritt 3: Tasten erkennen",
    TUTO_DETECT_ALL = "|cff40ff40Alle deine Tasten sind erkannt.|r",
    TUTO_DETECT_MISSING = "Passiert beim Drücken nichts? Prüfe die Belegung in der Software deines Controllers (Schritt 2) und versuche es erneut.",

    TUTO_MODES_TITLE = "Schritt 4: Modus wählen",
    TUTO_MODES_TEXT = "|cffffd100Modifikator|r: Halte die Taste und drücke A, B, X, Y oder das Steuerkreuz. 8 Aktionen pro Taste, wie bei LT und RT.\n"
        .. "|cffffd100Einfache Taste|r: eine Aktion, dazu eine mit gehaltenem LT und eine mit gehaltenem RT.\n"
        .. "|cffffd100Deaktiviert|r: Die Taste bleibt frei.\n\n"
        .. "Empfehlung: Modifikatoren auf die Tasten, die sich am leichtesten halten lassen, einfache Tasten auf die anderen.",
    TUTO_PAIRS_TEXT = "|cffffd100Paare|r: Die Tasten bilden Paare (links + rechts). Sind beide Tasten eines Paares Modifikatoren, "
        .. "ergibt das gemeinsame Halten 8 weitere Kombinationen.",

    TUTO_ACTIONS_TITLE = "Schritt 5: Aktionen festlegen",

    TUTO_HUD_TEXT = "Das Addon ersetzt die Controller-Leiste des Spiels durch ein eigenes HUD unten am Bildschirm:\n\n"
        .. "- |cffffd100Groß|r: die Ebene, die du gerade nutzt, Steuerkreuz links, A/B/X/Y rechts. Halte LT, RT oder einen Modifikator und sie wechselt.\n"
        .. "- |cffffd100In der Leiste|r (unten, oder oben mit /mgir hud strip): alle Ebenen in Miniatur (Allein, LT, RT, LT+RT, deine Modifikatoren und Paare); die gehaltene leuchtet auf.\n"
        .. "- |cffffd100In der Mitte|r: deine einfachen Tasten, mit der Aktion, die zum gehaltenen Trigger ausgelöst wird.\n\n"
        .. "Außerhalb des Kampfes wird es blasser, solange du nichts hältst.\n"
        .. "|cffffd100/mgir hud|r: verschieben  -  |cffffd100/mgir hud scale 1.2|r: Größe  -  |cffffd100/mgir hud off|r: zurück zur Leiste des Spiels",
})

-- Profils : liste, export, import
ns.AddLocale("deDE", {
    TAB_PROFILES = "Profile",
    PROFILES_INTRO = "Ein Profil enthält einen Controller, seine Tasten und für jeden Charakter dessen Aktionen. Es wird immer ein Profil für den ganzen Account genutzt. Das HUD gilt für alle Profile.",
    PROFILE_ACTIVE = "aktiv",
    PROFILE_USE = "Dieses Profil nutzen",
    PROFILE_NEW = "Neu...",
    PROFILE_COPY = "Kopieren...",
    PROFILE_RENAME = "Umbenennen...",
    PROFILE_DELETE = "Löschen",
    PROFILE_EXPORT = "Exportieren...",
    PROFILE_IMPORT = "Importieren...",
    PROFILE_DEFAULT = "Profil",
    PROFILE_IMPORTED = "Importiertes Profil",
    PROFILE_COPY_SUFFIX = "%s (Kopie)",
    PROFILE_NAME_NEW = "Name des neuen Profils:",
    PROFILE_NAME_COPY = "Name der Kopie:",
    PROFILE_NAME_RENAME = "Neuer Name für „%s“:",
    PROFILE_DELETE_CONFIRM = "Profil „%s“ löschen? Seine Tasten und die Aktionen aller deiner Charaktere für dieses Profil gehen verloren.",
    PROFILE_SWITCHED = "Aktives Profil: %s.",
    PROFILE_UNKNOWN = "Kein Profil heißt „%s“. Gib /mgir profiles ein, um sie zu sehen.",
    PROFILE_COMBAT = "Profile können im Kampf nicht gewechselt werden.",
    PROFILE_LAST = "Das ist dein einziges Profil: Es kann nicht gelöscht werden.",
    PROFILE_CREATED = "Profil „%s“ erstellt und aktiv. Lege seine Tasten im Reiter Tasten fest.",

    EXPORT_TITLE = "„%s“ exportieren",
    EXPORT_ACTIONS = "Aktionen dieses Charakters einschließen",
    EXPORT_HUD = "HUD-Einstellungen einschließen",
    EXPORT_HINT = "Der Text ist markiert: Strg+C zum Kopieren, dann füge ihn ein, wo du willst (Discord, eine Textdatei...). Importiert wird er mit der Schaltfläche Importieren im Reiter Profile.",
    CLOSE = "Schließen",

    IMPORT_TITLE = "Profil importieren",
    IMPORT_PASTE = "Füge den Exporttext hier ein (Strg+V):",
    IMPORT_EMPTY = "Füge einen Exporttext ein, um zu sehen, was er enthält.",
    IMPORT_BAD = "Das ist kein Exporttext von My Gamepad Is Rich.",
    IMPORT_VERSION = "Dieser Text stammt aus einer anderen Version des Addons und kann nicht gelesen werden.",
    IMPORT_DAMAGED = "Dieser Text ist beschädigt oder unvollständig: Kopiere ihn erneut, vollständig.",
    IMPORT_SUMMARY = "Profil „%s“, Controller: %s\n%d Taste(n) mit Belegung, %d Aktion(en)",
    IMPORT_SUMMARY_HUD = "Enthält HUD-Einstellungen.",
    IMPORT_MACROS = "Achtung: %d selbst geschriebene(s) Makro(s). Lies sie, bevor du sie nutzt:",
    IMPORT_COMMANDS = "WoW-Befehle: %s",
    IMPORT_AS_NEW = "Neues Profil:",
    IMPORT_REPLACE = "Ersetzen:",
    IMPORT_PICK = "Zu ersetzendes Profil",
    IMPORT_ACTIONS = "Aktionen importieren (für diesen Charakter)",
    IMPORT_HUD = "HUD-Einstellungen übernehmen",
    IMPORT_DO = "Importieren",
    IMPORT_REPLACE_CONFIRM = "Profil „%s“ ersetzen? Controller und Tasten werden überschrieben, ebenso seine Aktionen für diesen Charakter, wenn du sie importierst.",
    IMPORT_DONE = "Profil „%s“ importiert.",

    SELFTEST_OK = "Selbsttest: Alles in Ordnung.",
    SELFTEST_FAIL = "Selbsttest: %d Problem(e): %s",
    SLASH_HELP = "/mgir : öffnen  |  /mgir profile <Name> : Profil wechseln  |  /mgir test : Controller-Test  |  /mgir tuto : Tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : Aktionen dieses Charakters zurücksetzen",
})

-- HUD : arrêt après une erreur
ns.AddLocale("deDE", {
    HUD_ERROR = "HUD-Fehler, das HUD ist bis zum /reload angehalten (die Leiste des Spiels ist zurück). Bitte melde diese Nachricht: %s",
})

-- Gâchettes LT / RT données à l'addon
ns.AddLocale("deDE", {
    TRIGGERS_LABEL = "Trigger LT / RT:",
    TRIGGERS_ADDON = "Addon-Modifikatoren",
    TRIGGERS_GAME = "Ebenen des Spiels",
    TRIGGERS_ADDON_DESC = "Halte LT oder RT (oder beide) und drücke A, B, X, Y oder das Steuerkreuz: die Aktionen des Addons, mit allem, was es erlaubt (selbst geschriebene Makros, WoW-Befehle). Sie ersetzen die Ebenen LT, RT und LT + RT der Controller-Leiste des Spiels; ein leeres Feld tut nichts. LB und RB bleiben unverändert.",
    TRIGGERS_GAME_DESC = "LT und RT behalten die Ebenen der Controller-Leiste des Spiels (im Reiter Aktionen bearbeitbar).",
    TRIGGERS_COPIED = "%d Aktion(en) aus den LT/RT-Ebenen des Spiels in die des Addons übernommen.",
    IMPORT_SUMMARY_TRIGGERS = "LT / RT: Addon-Modifikatoren.",
})

-- Menu d'une case : pourquoi des choix sont grisés
ns.AddLocale("deDE", {
    MENU_GAME_BAR_HINT = "Eigene Makros, WoW-Befehle: LT / RT auf „Addon-Modifikatoren“ stellen (Reiter Tasten)",
})

-- Actions de base (celles de Forever sur A/B/X/Y)
ns.AddLocale("deDE", {
    MENU_GAME = "Grundaktion...",
    GAME_TITLE = "Grundaktionen",
    KIND_game = "Grundaktion",
    GAME_jump = "Springen",
    GAME_cancel = "Abbrechen (Zauber, Ziel)",
    GAME_search = "Suchen (Rechtsklick auf das Ziel)",
    GAME_attack = "Automatischer Angriff",
    GAME_interact = "Interagieren",
})
