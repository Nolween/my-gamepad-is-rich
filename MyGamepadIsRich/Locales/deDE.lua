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
    MODE_MODIFIER = "Modifikator",
    MODE_SIMPLE = "Einfache Taste",
    MODE_OFF = "Deaktiviert",
    MODE_MODIFIER_DESC = "Halte diese Taste gedrückt und drücke A, B, X, Y oder das Steuerkreuz: 8 neue Kombinationen, wie bei LT/RT.",
    MODE_SIMPLE_DESC = "Eine Aktion, dazu eine mit gehaltenem LT und eine mit gehaltenem RT. Eine leere Ebene tut nichts.",
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
    MENU_ICON = "Symbol ändern...",
    ICON_TITLE = "Symbol wählen",
    ICON_HINT = "Suche nach Zauber, Gegenstand oder WoW-Befehl, oder gib den Dateinamen eines Symbols ein (wie auf Wowhead: inv_misc_map_01).",
    ICON_DEFAULT = "Standardsymbol",
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
    HELP_REPLAY = "Tutorial erneut ansehen",

    TUTO_WELCOME_TITLE = "Willkommen bei My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "Klicke für jede Taste auf |cffffd100Erkennen|r und drücke dann diese Taste am Controller. "
        .. "Die gesendete Taste erscheint daneben.",



    TUTO_DONE_TITLE = "Alles bereit",
})

-- HUD
ns.AddLocale("deDE", {
    HUD_UNLOCKED = "HUD entsperrt: Ziehe es mit der Maus (getrennte Miniaturen bewegen sich separat). Zum Sperren: das Schloss am HUD, oder erneut /mgir hud.",
    HUD_LOCKED = "HUD gesperrt.",
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
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("deDE", {
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
    TAB_ACTIONS = "Ebenen",
    TAB_HUD = "HUD",
    SECTION_PAD = "Controller-Leiste",
    SECTION_MODS = "Modifikatoren",
    SECTION_MODS_EMPTY = "Noch keine: Stelle eine Taste im Reiter Tasten auf Modifikator.",
    SECTION_SIMPLE = "Einfache Tasten",
    SECTION_SIMPLE_EMPTY = "Noch keine: Stelle eine Taste im Reiter Tasten auf Einfache Taste.",
    LAYER_DESC_BASE = "A, B, X, Y und das Steuerkreuz, ohne etwas zu halten. Alles ist möglich: Was die Leiste des Spiels nicht halten kann (selbst geschriebenes Makro, WoW-Befehl), übernimmt das Addon. A, B, X und Y behalten die Aktionen des Spiels (Springen, Interagieren...), bis du eigene festlegst.",
    LAYER_DESC_HOLD = "Halte %s und drücke dann A, B, X, Y oder das Steuerkreuz.",
    PAIRS_TITLE = "Paare (zwei gemeinsam gehaltene Modifikatoren)",
    HUD_INTRO = "Das HUD ersetzt die Controller-Leiste des Spiels: als Raster (eine Zeile pro Ebene) oder wie der Controller (die genutzte Ebene groß, alle Ebenen als Miniatur).",
    HUD_SIZE = "Größe:",
    HUD_MOVE = "HUD entsperren",
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
    HUD_ORDER = "Reihenfolge der Ebenen:",
    HUD_ORDER_RESET = "Standardreihenfolge",
    HUD_ORDER_HINT = "Pfeile: eine Ebene verschieben. Auf dem HUD kannst du auch eine Miniatur (oder den Namen einer Rasterzeile) auf eine andere ziehen.",
    HUD_CARD_DRAG = "Ziehen: verschieben (auf eine andere Miniatur)",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("deDE", {
    CONTROLLER_LABEL = "Controller:",
    CONTROLLER_CHANGE = "Ändern...",
    CONTROLLER_PICK = "Wähle deinen Controller",
    CONTROLLER_OTHER = "Anderer Controller",
    EXTRA = "Taste",
    SOFTWARE_GENERIC = "die Software deines Controllers",
    TEST_INTRO = "Drücke eine beliebige Taste: Was WoW empfängt, leuchtet auf. Zeigen deine Zusatztasten nichts an, belege sie in der Software deines Controllers mit Tastaturtasten (siehe Hilfe).",
    LEARN_MODKEY = "Achtung: %s ist eine Umschalt- / Strg- / Alt-Taste; nimm in der Software deines Controllers lieber eine Taste wie F9-F12.",



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

    TUTO_DETECT_ALL = "|cff40ff40Alle deine Tasten sind erkannt.|r",



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
    TRIGGERS_GAME_DESC = "LT und RT behalten die Ebenen der Controller-Leiste des Spiels (im Reiter Ebenen bearbeitbar).",
    TRIGGERS_COPIED = "%d Aktion(en) aus den LT/RT-Ebenen des Spiels in die des Addons übernommen.",
    IMPORT_SUMMARY_TRIGGERS = "LT / RT: Addon-Modifikatoren.",
})

-- Menu d'une case : pourquoi des choix sont grisés
ns.AddLocale("deDE", {
    MENU_GAME_BAR_HINT = "Eigene Makros, WoW-Befehle: LT / RT dem Addon geben (Reiter Tasten, Grundtasten)",
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

-- Modes de ciblage (comme LB / RB dans Forever)
ns.AddLocale("deDE", {
    MODE_TARGET_FRIEND = "Verbündete",
    MODE_TARGET_ENEMY = "Feinde",
    MODE_TARGET_FRIEND_DESC = "Wie LB in Forever: Kurz drücken wählt den nächsten Verbündeten; halten und mit dem rechten Stick zielen, um einen auszuwählen. Gehalten ist es auch ein Modifikator: A, B, X, Y und das Steuerkreuz lösen seine 8 Kürzel aus.",
    MODE_TARGET_ENEMY_DESC = "Wie RB in Forever: Kurz drücken wählt den nächsten Feind; halten und mit dem rechten Stick zielen, um einen auszuwählen. Gehalten ist es auch ein Modifikator: A, B, X, Y und das Steuerkreuz lösen seine 8 Kürzel aus.",
    TARGET_UNAVAILABLE = "Die Zielerfassung von Forever wurde nicht gefunden: %s arbeitet als einfacher Modifikator.",
})

-- Onglet « Soutenir » (don PayPal)
ns.AddLocale("deDE", {
    TAB_DONATE = "Unterstützen",
    DONATE_TITLE = "My Gamepad Is Rich unterstützen",
    DONATE_INTRO = "My Gamepad Is Rich ist kostenlos und bleibt es auch. Wenn es dir hilft und du dich bedanken möchtest, kannst du mir über PayPal einen Betrag deiner Wahl spenden.",
    DONATE_SCAN = "Scanne den QR-Code mit deinem Handy",
    DONATE_LINK = "Oder kopiere den Link (Strg+C) und füge ihn in deinen Browser ein:",
    DONATE_THANKS = "Spenden sind völlig freiwillig und schalten nichts frei: Alle Funktionen bleiben für alle verfügbar. Danke für deine Unterstützung!",
})

-- Boutons de base (LT, RT, LB, RB)
ns.AddLocale("deDE", {
    MODE_GAME = "Spiel",
    MODE_GAME_DESC = "Diese Taste behält ihre Rolle im Spiel (LT / RT: Ebenen der Controller-Leiste; LB / RB: die Zielerfassung von Forever).",
    PADS_LABEL = "Grundtasten:",
    PADS_PICK = "%s: Modus wählen",
    IMPORT_SUMMARY_PADS = "Dem Addon gegebene Grundtasten: %s",
    EMULATION_OFF = "%s imitiert kein Umschalt / Strg mehr, solange sie dem Addon gehört. Beim Ausloggen wird sie automatisch zurückgesetzt.",
    RESTORE_DONE = "Grundtasten an das Spiel zurückgegeben und ihre Umschalt-/Strg-Imitation wiederhergestellt.",
})

-- Plus aucun ciblage allié / ennemi configuré
ns.AddLocale("deDE", {
    TARGET_MISSING_FRIEND = "Keine Taste wählt Verbündete: Stelle LB auf „Spiel“ oder eine Taste auf „Verbündete“ (Reiter Tasten).",
    TARGET_MISSING_ENEMY = "Keine Taste wählt Feinde: Stelle RB auf „Spiel“ oder eine Taste auf „Feinde“ (Reiter Tasten).",
    TARGET_MISSING_BOTH = "Keine Taste wählt Verbündete oder Feinde: Stelle LB / RB auf „Spiel“ oder Tasten auf „Verbündete“ / „Feinde“ (Reiter Tasten).",
})

-- Onglet Boutons : mention des boutons de base
ns.AddLocale("deDE", {
    PAD_HINT = "Controller-Taste: nichts zu erkennen",
})

-- Case vide d'un bouton simple dans une couche : son action habituelle
ns.AddLocale("deDE", {
    SIMPLE_USUAL = "Wie sonst",
})

-- Manettes standard (sans bouton supplémentaire), noms PlayStation
ns.AddLocale("deDE", {
    TUTO_NO_EXTRA = "Dieser Controller hat keine Zusatztasten: Hier ist nichts einzurichten. Du kannst LT, RT, LB und RB andere Rollen geben (Grundtasten, im Reiter Tasten).",
    PS_CROSS = "Kreuz",
    PS_CIRCLE = "Kreis",
    PS_SQUARE = "Quadrat",
    PS_TRIANGLE = "Dreieck",
})

-- Paires libres (deux modificateurs quelconques)
ns.AddLocale("deDE", {
})

-- Paire avec un bouton de base resté au jeu
ns.AddLocale("deDE", {
})

-- Boutons de base : mode par défaut
ns.AddLocale("deDE", {
    MODE_IS_DEFAULT = "Standard für diese Taste: Sie funktioniert wie im Spiel.",
})

-- Tutoriel : les types de boutons, boutons de base, paires ; options
ns.AddLocale("deDE", {
    MODE = "Typ:",
    TUTO_WELCOME_TEXT = "Mit diesem Addon legst du fest, was jede Taste deines Controllers tut: die Zusatztasten (Paddles hinten, zusätzliche Trigger: GameSir, Xbox Elite, DualSense Edge, SCUF...) und die Grundtasten LT, RT, LB und RB.\n\n|cffffd100Das Prinzip: Ebenen.|r Allein lösen A, B, X, Y und das Steuerkreuz 8 Aktionen aus. Halte eine Taste (LT, RT, ein Paddle...) und dieselben 8 Tasten lösen 8 andere Aktionen aus: Das ist eine neue Ebene. Jede gehaltene Taste gibt eine.\n\nDieses Tutorial dauert etwa zwei Minuten. Du kannst es jederzeit verlassen und mit |cffffd100/mgir tuto|r wieder öffnen.",
    TUTO_CONTROLLER_TITLE = "Dein Controller",
    TUTO_CONTROLLER_TEXT = "Wähle deinen Controller: Das Addon übernimmt die Namen seiner Zusatztasten und zeigt dir die Software, mit der sie eingerichtet werden. Ein normaler Xbox- oder PlayStation-Controller ohne Zusatztasten? Wähle ihn auch: LT, RT, LB und RB kannst du trotzdem einrichten. Nicht in der Liste? Wähle |cffffd100Anderer Controller|r (bis zu 6 Tasten, die du umbenennen kannst).",
    TUTO_TYPES_TITLE = "Die 4 Tastentypen",
    TUTO_TYPES_TEXT = "Jede Taste bekommt einen Typ, der festlegt, was sie tut. Du wählst ihn in den nächsten Schritten und jederzeit im Reiter |cffffd100Tasten|r (fahre über einen Typ, um seine Erklärung erneut zu lesen).",
    TYPE_MODIFIER_HOW = "Halte sie und drücke dann A, B, X, Y oder das Steuerkreuz: eine Ebene mit 8 Aktionen. Allein tut sie nichts.",
    TYPE_MODIFIER_FOR = "Für: Tasten, die sich leicht gedrückt halten lassen. Standard für LT und RT, wie im Spiel.",
    TYPE_TARGET_HOW = "Ein kurzer Druck wählt den nächsten Verbündeten (oder Feind) als Ziel; halte sie und ziele mit dem rechten Stick, um einen anderen zu wählen. Gehalten mit A, B, X, Y oder dem Steuerkreuz: 8 Kürzel, wie ein Modifikator.",
    TYPE_TARGET_FOR = "Für: Heilungen und Zauber auf ein Ziel. Standard für LB (Verbündete) und RB (Feinde), wie im Spiel.",
    TYPE_SIMPLE_HOW = "Ein Druck löst eine Aktion aus. Mit gehaltenem LT oder RT löst sie eine andere aus. Sie hat auch ein Feld in jeder Modifikator-Ebene.",
    TYPE_SIMPLE_FOR = "Für: einen Zauber, den du oft wirkst, einen Trank, ein Reittier.",
    TYPE_OFF_HOW = "Die Taste tut nichts: Ihre Taste bleibt für anderes frei.",
    TYPE_OFF_FOR = "Für: Zusatztasten, die du nicht benutzt (Grundtasten haben diesen Typ nicht).",
    TUTO_SOFTWARE_TITLE = "Den Zusatztasten eine Taste zuweisen",
    TUTO_DETECT_TITLE = "Deine Zusatztasten erkennen",
    TUTO_DETECT_MISSING = "Beim Drücken passiert nichts? Prüfe die Taste in der Software deines Controllers und versuche es erneut.",
    TUTO_MODES_TITLE = "Der Typ deiner Zusatztasten",
    TUTO_MODES_TEXT = "Wähle für jede Zusatztaste einen Typ (fahre über einen Typ, um zu sehen, was er tut).\nTipp: Modifikatoren auf die Tasten, die sich am leichtesten halten lassen, einfache Tasten auf die anderen. |cffffd100Empfohlene Typen verwenden|r erledigt das für dich.",
    TUTO_SUGGESTED = "Empfohlene Typen verwenden",
    TUTO_PADS_TITLE = "Deine Grundtasten: LT, RT, LB, RB",
    TUTO_PADS_TEXT = "Standardmäßig (in Grün) funktionieren sie wie im Spiel: LT und RT sind Modifikatoren, LB wählt Verbündete und RB Feinde als Ziel. Die Aktionen der Controller-Leiste des Spiels werden in ihre Ebenen übernommen. Du kannst sie ändern: zum Beispiel RB als einfache Taste oder LB als Modifikator.",
    TUTO_PADS_DEFAULT = "Zurück zu den Standardtypen",
    TUTO_PAIRS_TITLE = "Paare: zwei gemeinsam gehaltene Tasten",
    TUTO_PAIRS_TEXT = "Halte zwei Tasten zusammen (Modifikatoren oder Zielerfassung): noch eine Ebene mit 8 Aktionen. Zwei beliebige Tasten können ein Paar bilden: L5 + R5, LT + RT, LB + LT... Hake die gewünschten an (du kannst sie später im Reiter |cffffd100Tasten|r ändern). Standard: die Paare links + rechts.",
    TUTO_ACTIONS_TITLE = "Deine Aktionen platzieren",
    TUTO_ACTIONS_TEXT = "Im Reiter |cffffd100Ebenen|r: links alle deine Ebenen (Allein, LT, RT, deine Modifikatoren und Paare); rechts die gewählte Ebene, angeordnet wie der Controller.\n\n- Ziehe einen Zauber aus deinem Zauberbuch, einen Gegenstand aus deinen Taschen, ein Makro, ein Reittier oder ein Spielzeug auf ein Feld.\n- Oder klicke auf ein Feld: einen Zauber oder Gegenstand wählen, ein Makro schreiben, einen WoW-Befehl (Automatisch laufen...) oder eine Grundaktion (Springen, Interagieren...) wählen. Rechtsklick: leeren.\n- Die Zeile unter dem Steuerkreuz: die Felder deiner einfachen Tasten in dieser Ebene.\n\nDu kannst auch auf eine Ebenen-Miniatur im HUD klicken, um sie direkt zu bearbeiten.\n\nAktionen werden pro Charakter gespeichert; Typen und Tasten im Profil, für den ganzen Account. Alles funktioniert im Kampf; nur Änderungen im Kampf warten auf sein Ende.\n\n|cffffd100Praktisch|r:\n- Das Feld oben in der Liste sucht eine Aktion in all deinen Ebenen.\n- |cffffd100Intelligentes Verbrauchsgut|r (Feldmenü): dein bester Trank, Essen, Getränk oder Verband, aktualisiert sich selbst.\n- Ein grauer, roter Zauber: dieser Charakter kennt ihn nicht. |cffffd100Vorlagen und Spezialisierungen...|r kann sie entfernen.\n- Ein neuer Rang beim Klassenlehrer gelernt: das Addon bietet an, ihn überall statt des alten einzusetzen.",
    TUTO_HUD_TEXT = "Das Addon ersetzt die Controller-Leiste des Spiels durch sein eigenes HUD. Wähle unten seine Anordnung: Das HUD ändert sich sofort, und du kannst jederzeit wechseln (Reiter |cffffd100HUD|r oder die kleine Schaltfläche am HUD).\n\nWenn die Maus über dem HUD ist, erscheinen kleine Schaltflächen: das |cffffd100Schloss|r entsperrt es, um es mit der Maus zu verschieben (und sperrt es wieder), eine andere wechselt die Anordnung, und das |cffffd100Zahnrad|r öffnet den Reiter HUD für genauere Einstellungen (Größe, Miniaturen...).",
    TUTO_DONE_TEXT = "Öffne die Konfiguration, um deine ersten Aktionen zu platzieren.\n\n|cffffd100/mgir|r: Konfiguration öffnen\n|cffffd100/mgir test|r: Controller-Test, um zu sehen, was WoW empfängt\n|cffffd100/mgir tuto|r: dieses Tutorial\n|cffffd100/mgir reset|r: die Aktionen dieses Charakters leeren\n|cffffd100/mgir restore|r: LT, RT, LB und RB dem Spiel zurückgeben\n|cffffd100/mgir rangs|r: neue Ränge deiner Zauber statt der alten einsetzen",
    SETTINGS_DESC = "Lege fest, was jede Taste deines Controllers tut: Zusatztasten (Paddles hinten, zusätzliche Trigger) und Grundtasten (LT, RT, LB, RB). Befehl: /mgir",
    BUTTONS_INTRO = "Wähle für jede Taste einen Typ: Fahre über einen Typ, um zu sehen, was er tut. In Grün: der Standardtyp der Grundtasten, der wie im Spiel funktioniert.",
    BUTTONS_TYPES_HELP = "Die Tastentypen",
    PAIRS_HINT = "Hake die gewünschten Paare an: Beide Tasten zusammen gehalten ergeben 8 weitere Aktionen. Zwei beliebige Modifikatoren oder Zieltasten können ein Paar bilden (L5 + LT, LB + RT...).",
    PAIRS_NONE = "Stelle mindestens zwei Tasten auf Modifikator, Verbündete oder Feinde, um Paare zu bilden.",
    PAIR_WAITS = "%s steht auf Spiel: auf Modifikator, Verbündete oder Feinde stellen (oben)",
})

-- Tutoriel, paires : appuyer sur les boutons pour les trouver
ns.AddLocale("deDE", {
    TUTO_PAIRS_PRESS = "Drücke eine Taste an deinem Controller: Ihre Paare leuchten grün auf. Drücke zwei Tasten zusammen: Ihr Paar leuchtet auf.",
})

-- LB + LT et RB + RT : l'action de classe de Forever
ns.AddLocale("deDE", {
    PAIR_CLASS_WARN = "löst auch die Klassenaktion von Forever aus",
    PAIR_CLASS_WARN_LONG = "Achtung: %s löst auch die Klassenaktion von Forever aus (oft ein Zauberrad, das A, B, X und Y übernimmt, solange es offen ist; B schließt es). Das Addon kann das nicht verhindern: Wähle lieber ein anderes Paar.",
    PAIR_CLASS_NOTE = "%s und %s lösen auch die Klassenaktion von Forever aus (oft ein Zauberrad, das A, B, X und Y übernimmt). Das Addon kann das nicht verhindern: Wähle lieber andere Paare.",
})

-- Forever resté sur sa barre LT / RT
ns.AddLocale("deDE", {
    FOREVER_STUCK = "Forever ist auf seiner %s-Leiste hängen geblieben (ein Loslassen der Taste ging verloren). Drücke einmal %s, um zu „Allein“ zurückzukehren.",
    HUD_STUCK = "%s hängt fest: drücke einmal %s",
    HUD_GRID_RECALL_DETACH = "Vom Raster getrennt",
    TIP_HUD_GRID_RECALL_DETACH = "Die Anzeige verlässt das Raster: Du kannst sie platzieren, wo du willst (Schloss des HUD, dann ziehen).",
    HUD_GRID_RECALL = "Genutzte Ebene oben groß anzeigen",
    TIP_HUD_GRID_RECALL = "Über dem Raster und zentriert die Ebene, die du nutzt, groß, jedes Feld mit seiner Taste. Ihre Zeile im Raster bleibt dann klein (goldener Rand).",
    HUD_STYLE_LABEL = "HUD-Anzeige:",
    HUD_STYLE_GRID = "Raster",
    HUD_STYLE_PAD = "Controller",
    TIP_HUD_STYLE_GRID = "Eine Zeile pro Ebene, die Tasten immer in derselben Reihenfolge: Steuerkreuz, dann X, Y, B, A (links, oben, rechts, unten), dann die einfachen Tasten. Die genutzte Ebene oben groß und im Raster golden.",
    TIP_HUD_STYLE_PAD = "Wie der Controller: die genutzte Ebene groß (Steuerkreuz links, A/B/X/Y rechts, einfache Tasten in der Mitte), alle Ebenen als Miniatur.",
    HUD_SECTION_GRID = "Ebenen-Raster",
    HUD_GRID_SIZE = "Größe des Rasters:",
    HUD_GRID_COLS = "Spalten mit Ebenen:",
    TIP_HUD_GRID_SIZE = "Die Größe des Rasters. „Größe“ (weiter unten) vergrößert das ganze HUD.",
    TIP_HUD_GRID_COLS = "Auf wie viele Spalten die Ebenenzeilen verteilt werden: mehr Spalten ergeben ein breiteres, niedrigeres Raster.",
    HUD_TOOL_TO_GRID = "HUD auf Raster umstellen",
    HUD_TOOL_TO_PAD = "HUD auf Controller-Anordnung umstellen",
    HUD_ROW_HINT = "Klick: diese Ebene zum Bearbeiten vergrößern",
    HUD_ROW_DRAG = "Ziehen: verschieben (auf eine andere Zeile)",
    TUTO_HUD_GRID_NAME = "Raster (empfohlen)",
    TUTO_HUD_GRID_DESC = "Eine Zeile pro Ebene, die Tasten immer in derselben Reihenfolge, in ihrer Farbe oben in jeder Spalte: Steuerkreuz, dann X, Y, B, A (links, oben, rechts, unten: dieselbe Stelle für beide Daumen), dann deine einfachen Tasten. Oben zeigt die Anzeige die Ebene, die du nutzt, groß; ihre Zeile wird golden. Klick auf ein Feld, um es zu bearbeiten, auf den Namen einer Zeile, um sie zu vergrößern; zieh diesen Namen, um die Reihenfolge zu ändern. Reiter HUD: Größe, Anzahl der Spalten, Anzeige (die sich vom Raster trennen und frei platzieren lässt).",
    TUTO_HUD_PAD_NAME = "Controller",
    TUTO_HUD_PAD_DESC = "Wie der Controller: die Ebene, die du nutzt, groß, Steuerkreuz links, A/B/X/Y rechts, deine einfachen Tasten in der Mitte mit der Aktion, die ausgelöst wird. Alle Ebenen als Miniatur darunter: Klick auf eine Miniatur, um sie zu bearbeiten.",
    WHATSNEW_1_4_0 = "• |cffffd100HUD als Raster|r: eine neue Anordnung, eine Zeile pro Ebene, die Tasten immer in derselben Reihenfolge, in ihrer Farbe oben in jeder Spalte: Steuerkreuz, dann X, Y, B, A (links, oben, rechts, unten), dann die einfachen Tasten. Oben zeigt die Anzeige die genutzte Ebene groß; im Raster wird sie golden. Jedes Feld lässt sich direkt bearbeiten; Klick auf den Namen einer Zeile vergrößert sie, Ziehen ändert die Reihenfolge.\n• Reiter HUD: Größe des Rasters, Anzahl der Spalten (1 bis 3), Anzeige ein oder aus und vom Raster getrennt, um sie frei zu platzieren. Dein HUD behält seine bisherige Anordnung: Wechsle zum Raster im Reiter HUD („HUD-Anzeige“) oder mit der kleinen Schaltfläche am HUD.\n• |cffffd100Hängende Ebene in Rot|r: Wenn die LT- / RT-Leiste des Spiels hängen bleibt, zeigt das HUD diese Ebene rot mit der Taste, die du zum Lösen drücken musst.",
})

-- 1.1.0 : spés, état des actions sur le HUD, profils, remplissage rapide, rapport
ns.AddLocale("deDE", {
    SPEC_NUMBER = "Spezialisierung %d",
    SPEC_SWITCHED = "Aktionen der Spezialisierung „%s“.",
    SPEC_NEW = "Neue Spezialisierung „%s“: Sie beginnt mit einer Kopie der Aktionen der vorherigen.",
    PROFILE_PER_CHAR = "Profil jedes Charakters merken",
    PROFILE_PER_CHAR_DESC = "Beim Einloggen nimmt jeder Charakter wieder das zuletzt von ihm genutzte Profil. Ohne diese Option nehmen alle das zuletzt auf dem Account genutzte Profil.",
    REPORT_BUTTON = "Bericht kopieren",
    REPORT_TITLE = "Controller-Bericht",
    REPORT_HINT = "Drücke zuerst jede Taste im Controller-Test, kopiere dann diesen Text (Strg+C) und schicke ihn dem Autor des Addons, mit dem, was funktioniert und was nicht. Er hilft, die Einstellungen anderer Controller zu bestätigen. Kein Charakter- oder Realmname ist enthalten.",
    WHATSNEW_TITLE = "Neues in My Gamepad Is Rich",
    QUICKFILL_BUTTON = "Leere Felder füllen",
    QUICKFILL_DESC = "Legt Ruhestein, angelegte benutzbare Schmuckstücke und Verbrauchsgüter aus den Taschen (Tränke, Essen, Verbände, Elixiere...) in die leeren Felder dieser Ebene, außer denen, die schon da sind. Rechtsklick auf ein Feld leert es.",
    QUICKFILL_DONE = "%d Feld(er) gefüllt.",
    QUICKFILL_NONE = "Nichts zu legen: kein benutzbarer Gegenstand in den Taschen, der nicht schon auf dieser Ebene ist.",
})

-- 1.1.0 : modèles de classe, copie de couches, verrou, annulation, véhicules
ns.AddLocale("deDE", {
    SLASH_HELP = "/mgir : öffnen  |  /mgir profile <Name> : Profil wechseln  |  /mgir test : Controller-Test  |  /mgir tuto : Tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : Aktionen dieses Charakters zurücksetzen  |  /mgir undo : letzte Änderung der Aktionen rückgängig machen  |  /mgir rangs: niedrigere Zauberränge ersetzen",
    LEARN_PAD_REFUSED = "%s ist eine Grundtaste des Controllers: Das Addon kombiniert oder konfiguriert sie selbst. Drücke die Zusatztaste (die Taste, die ihre Software sendet).",
    RESET_CONFIRM = "Alle Aktionen dieses Charakters im aktuellen Profil löschen?",
    RESET_CONFIRM_SPEC = "Alle Aktionen dieses Charakters für die Spezialisierung „%s“ im aktuellen Profil löschen?",
    UNDO_HINT = "/mgir undo macht es rückgängig.",
    UNDO_DONE = "Aktionen wie vor der letzten Änderung wiederhergestellt.",
    UNDO_NONE = "Für diese Spezialisierung gibt es nichts rückgängig zu machen.",
    ACTION_COUNT = "%d Aktion(en)",
    LAYER_COPY_BUTTON = "Kopieren / tauschen…",
    LAYER_COPY_DESC = "Kopiert die Aktionen dieser Ebene auf eine andere Ebene oder tauscht die Aktionen beider Ebenen (die 8 Felder und die Felder der einfachen Tasten).",
    LAYER_COPY_TITLE = "Ebene %s",
    LAYER_COPY_TO = "Kopieren nach",
    LAYER_SWAP_WITH = "Tauschen mit",
    LAYER_COPY_NONE = "Keine andere Kombinationsebene: Mache zuerst eine andere Taste zum Modifikator.",
    LAYER_COPY_CONFIRM = "Die Aktionen der Ebene %s (%d) durch die von %s ersetzen?",
    LAYER_COPIED = "%s nach %s kopiert.",
    LAYER_SWAPPED = "%s und %s getauscht.",
    TPL_BUTTON = "Vorlagen und Spezialisierungen…",
    TPL_DESC = "Klassenvorlagen: Speichere die Aktionen dieser Spezialisierung für den ganzen Account und lade sie dann auf einem anderen Charakter derselben Klasse. Du kannst auch die Aktionen einer anderen Spezialisierung kopieren. Aktionen, die auf der Leiste des Spiels bleiben, gehören nicht dazu.",
    TPL_TITLE = "Vorlagen und Spezialisierungen",
    TPL_SECTION_SAVE = "Speichern",
    TPL_SAVE = "Diese Aktionen als Vorlage speichern…",
    TPL_SECTION_LOAD = "Vorlage laden (%s)",
    TPL_SECTION_SPEC = "Von einer Spezialisierung kopieren",
    TPL_SECTION_DELETE = "Vorlage löschen",
    TPL_SAVE_PROMPT = "Name der Vorlage (für alle Charaktere der Klasse %s im Account):",
    TPL_SAVED = "Vorlage „%s“ für %s gespeichert.",
    TPL_REPLACE_CONFIRM = "Vorlage „%s“ ersetzen?",
    TPL_LOAD_CONFIRM = "Vorlage „%s“ laden? Sie ersetzt die Aktionen von %s.",
    TPL_LOADED = "Vorlage „%s“ geladen.",
    TPL_DELETE_CONFIRM = "Vorlage „%s“ für alle Charaktere dieser Klasse löschen?",
    TPL_DELETED = "Vorlage „%s“ gelöscht.",
    SPEC_COPY_CONFIRM = "Aktionen von „%s“ kopieren? Sie ersetzen die Aktionen von %s.",
    SPEC_COPIED = "Aktionen von „%s“ kopiert.",
    LATCH = "Einrastend",
    LATCH_DESC = "Ein Druck schaltet die Ebene dieses Modifikators ein, der nächste schaltet sie aus: Du musst ihn nicht halten. Ein anderer gehaltener Modifikator hat Vorrang, solange er gehalten wird. Jede Änderung der Einstellungen löst die Einrastung. Nur für Zusatztasten (nicht LT, RT, LB, RB).",
})

-- 1.1.0 : notes de version (tout ce qui a changé depuis la 1.0.0)
ns.AddLocale("deDE", {
    WHATSNEW_1_1_5 = "• Freundliches / feindliches Ziel: Im Kampf bleibt die Taste nach dem Loslassen nicht mehr gedrückt (das HUD blieb auf ihrer Ebene und der Stick zielte weiter). Ein kurzer Druck wechselt weiterhin zum nächsten Ziel, ein langer Druck behält das anvisierte Ziel.",
    WHATSNEW_1_1_4 = "• Freundliches / feindliches Ziel: Jeder kurze Druck wechselt zum nächsten Ziel, auch wenn du schon eines hast, selbst wo das Spiel dem Addon die Uhrzeit nicht gibt. Ein langer Druck behält das mit dem Stick anvisierte Ziel.\n• /mgir etat zeigt, wie ein kurzer Druck erkannt wird.",
    WHATSNEW_1_1_3 = "• Freundliches / feindliches Ziel: Das mit dem Stick anvisierte Ziel bleibt, wenn du die Taste loslässt. Nur ein kurzer Druck wählt das nächste Ziel.",
    WHATSNEW_1_1_2 = "• Ein WoW-Befehl oder ein selbst geschriebenes Makro kann ein Symbol deiner Wahl nutzen: Klick auf das Feld, „Symbol ändern...“. Die Suche findet die Symbole deiner Zauber, Gegenstände und WoW-Befehle, oder ein Symbol über seinen Dateinamen (wie auf Wowhead: inv_misc_map_01).\n• Häufige Befehle haben ein eigenes Symbol statt des Schlüssels: Weltkarte, Taschen, Zauberbuch, Questlog, Charakter, Erfolge, Gruppensuche, Sammlungen.",
    WHATSNEW_1_1_1 = "• Einfache Taste: Eine leere Ebene (LT, RT oder ein Modifikator) tut nichts mehr und bleibt im HUD leer, statt die Aktion „Allein“ zu nutzen. Einzige Ausnahme: ein WoW-Befehl auf „Allein“.\n• Die Zauberliste enthält jetzt auch Berufszauber: Kräutersuche, Mineraliensuche, Angeln, Kochkunst, Archäologie…",
    WHATSNEW_1_1_0 = "• HUD: Die Aktionen des Addons sehen aus wie auf den Leisten des Spiels. Rot außer Reichweite, blau ohne genug Ressource, grau wenn unbenutzbar, goldener Rand bei einem Proc, verbleibende Aufladungen, hervorgehoben solange aktiv (automatischer Angriff, Gestalt...).\n• HUD: Die Reihenfolge der Ebenen-Miniaturen ist wählbar (Pfeile im Reiter HUD, oder eine Miniatur auf eine andere ziehen).\n• Jede Spezialisierung hat ihre eigenen Aktionen. Eine neue Spezialisierung beginnt mit einer Kopie der Aktionen der vorherigen.\n• Reiter Aktionen: „Leere Felder füllen“ legt Ruhestein, Schmuckstücke und Verbrauchsgüter aus den Taschen auf eine Modifikator-Ebene, und „Kopieren / tauschen…“ kopiert eine Kombinationsebene auf eine andere oder tauscht zwei Ebenen.\n• Klassenvorlagen: Speichere deine Aktionen für den ganzen Account und lade sie auf einem anderen Charakter derselben Klasse („Vorlagen und Spezialisierungen…“ unter der Ebenenliste). Du kannst auch die Aktionen einer anderen Spezialisierung kopieren.\n• Einrastender Modifikator (Reiter Tasten): Ein Druck schaltet die Ebene ein, der nächste schaltet sie aus.\n• /mgir reset fragt nach einer Bestätigung, und /mgir undo macht ein Zurücksetzen, eine Vorlage oder eine kopierte Spezialisierung bzw. Ebene rückgängig.\n• Profile: Option „Profil jedes Charakters merken“.\n• Hängende Ebenen: Eine dem Addon gegebene Grundtaste bleibt bei dem, der den Druck erhalten hat, bis sie losgelassen wird, und Forever bleibt nicht mehr auf seiner RT- (oder LT-)Leiste hängen, etwa nach einem mit RT + A gewirkten Zauber wie einem Siegel des Paladins.\n• Fahrzeuge, Ersatzleisten und Haustierkämpfe: Das Addon tritt zurück und die Tasten des Spiels funktionieren, auch im Kampf.\n• Kein /mgir restore mehr vor dem Deaktivieren: Bei jedem Ausloggen bekommen LT und LB ihre Umschalt-/Strg-Imitation zurück, und das Addon schaltet sie beim Einloggen wieder ab.\n• Erkennen lehnt A, B, X, Y, das Steuerkreuz und LT, RT, LB, RB ab (versehentlich gedrückt, würden sie zur Taste einer Zusatztaste).\n• Reiter Controller-Test: „Bericht kopieren“ (mit dem aktuellen Ebenenprotokoll), zum Verschicken, um andere Controller zu bestätigen. /mgir etat zeigt den Zustand der Ebenen.\n• /mgir news: dieses Fenster erneut zeigen.",
})

-- Marqueurs de raid (actions de base)
ns.AddLocale("deDE", {
    GAME_markquick = "Schnellmarkierung (nächste Markierung bei jedem Druck)",
    GAME_mark = "Markieren: %s",
    GAME_markclear = "Markierung entfernen",
})

-- Se cibler (action de base)
ns.AddLocale("deDE", {
    GAME_targetself = "Sich selbst anvisieren",
})

-- Nouveautés de la 1.1.6
ns.AddLocale("deDE", {
    WHATSNEW_1_1_6 = "• Schlachtzugsmarkierungen in den Grundaktionen: „Schnellmarkierung“ setzt bei jedem Druck die nächste Markierung auf dein Ziel (Totenschädel, Kreuz, Quadrat, Mond, Dreieck, Diamant, Kreis, Stern), dazu jede der 8 Markierungen einzeln und „Markierung entfernen“.\n• „Sich selbst anvisieren“ in den Grundaktionen.\n• Der Tooltip eines Zaubers zeigt seinen Rang.\n• Freundliches / feindliches Ziel: Jeder kurze Druck wechselt jetzt auch in Forever zum nächsten Ziel, und das Zielen mit dem rechten Stick reagiert sofort. Das anvisierte Ziel bleibt, wenn der Stick beim Loslassen noch geneigt ist, oder nach einem langen Druck.",
})

-- Nouveaux rangs (maître de classe)
ns.AddLocale("deDE", {
    UPRANK_ASK = "Neuer Rang erlernt: %s.\n\nDen niedrigeren Rang in deinen Aktionen ersetzen?\n(%d Feld(er) des Addons, %d Feld(er) der Leisten des Spiels)",
    UPRANK_REPLACE = "Ersetzen",
    UPRANK_KEEP = "Behalten",
    UPRANK_DONE = "Neuer Rang gesetzt: %d Feld(er) des Addons, %d Feld(er) der Leisten des Spiels.",
})

-- Confort : nouveaux rangs sans demander
ns.AddLocale("deDE", {
    COMFORT_TITLE = "Komfort",
    UPRANK_AUTO = "Neue Zauberränge ohne Nachfrage ersetzen (niedrigere Ränge in den Aktionen des Addons und auf den Leisten des Spiels)",
    UPRANK_NONE = "Kein niedrigerer Rang zu ersetzen.",
})

-- Actions de base : cible, focus, sacs, montures
ns.AddLocale("deDE", {
    GAME_targetlast = "Vorheriges Ziel",
    GAME_assist = "Ziel assistieren",
    GAME_focus = "Als Fokus setzen",
    GAME_targetfocus = "Fokus anvisieren",
    GAME_follow = "Ziel folgen",
    GAME_openbags = "Taschen öffnen",
    GAME_dismount = "Absitzen",
    GAME_randommount = "Zufälliges Lieblingsreittier",
})

-- Sorts inconnus
ns.AddLocale("deDE", {
    SPELL_UNKNOWN = "Dieser Charakter kennt diesen Zauber nicht (Talente, andere Spezialisierung, Vorlage eines anderen Charakters): dieses Feld tut nichts.",
    UNKNOWN_SECTION = "Unbekannte Zauber",
    UNKNOWN_REMOVE = "Unbekannte Zauber entfernen",
    UNKNOWN_CONFIRM = "%d Zauber, die dieser Charakter nicht kennt, aus den Aktionen von %s entfernen?",
    UNKNOWN_REMOVED = "%d unbekannte(r) Zauber entfernt.",
})

-- Recherche d'une action (onglet Actions)
ns.AddLocale("deDE", {
    SEARCH_HINT = "Aktion suchen",
    SEARCH_DESC = "Gib einen Teil eines Namens ein (Zauber, Gegenstand, Makro...): die Ebenen, die ihn haben, zeigen die Anzahl der Felder, und diese Felder bekommen einen goldenen Rand.",
})

-- Consommables intelligents
ns.AddLocale("deDE", {
    MENU_BEST = "Intelligentes Verbrauchsgut...",
    BEST_TITLE = "Intelligente Verbrauchsgüter",
    KIND_best = "Intelligentes Verbrauchsgut",
    BEST_heal = "Bester Heiltrank",
    BEST_mana = "Bester Manatrank",
    BEST_food = "Bestes Essen",
    BEST_drink = "Bestes Getränk",
    BEST_bandage = "Bester Verband",
    BEST_NONE = "Keiner in deinen Taschen",
    BEST_DESC = "Benutzt den besten Gegenstand dieser Art in deinen Taschen; ist ein Stapel leer, den nächsten (auch im Kampf). Die Liste folgt deinen Taschen außerhalb des Kampfes.",
})

-- Vibrations
ns.AddLocale("deDE", {
    VIBRATION_OPTION = "Controller-Vibration (feststellbarer Modifikator an / aus, langer Druck erkannt, neuer Rang gesetzt)",
})

-- Bouton simple : sa case dans chaque couche de modificateur
ns.AddLocale("deDE", {
    SIMPLE_MOD_ROW = "Mit gehaltenem Modifikator (leer: tut nichts)",
})

-- HUD : couches séparées, en colonne
ns.AddLocale("deDE", {
    HUD_LAYERS_LABEL = "Ebenen:",
    HUD_DETACH = "Vom HUD getrennt",
    HUD_VERTICAL = "In Spalten",
    HUD_STRIP_COLS = "Miniaturspalten:",
    HUD_TOOL_VERTICAL = "Ebenen in Spalten",
    HUD_TOOL_HORIZONTAL = "Ebenen in Zeilen",
})

-- HUD : cadenas (verrouiller / déverrouiller)
ns.AddLocale("deDE", {
    HUD_TOOL_UNLOCK = "Entsperren: HUD mit der Maus verschieben",
    HUD_TOOL_LOCK = "HUD sperren (zuerst an die gewünschte Stelle ziehen)",
    HUD_TOOL_LOCK_DETACHED = "HUD sperren (zuerst HUD und Ebenen ziehen, jedes an seinen Platz)",
    HUD_UNLOCKED_HINT = "Entsperrt: mit der Maus ziehen (getrennte Ebenen bewegen sich separat). Zum Sperren auf das Schloss klicken.",
})

-- HUD : bouton vers l'onglet HUD
ns.AddLocale("deDE", {
    HUD_TOOL_SETTINGS = "HUD-Einstellungen (Reiter HUD): Anordnung, Größe, Miniaturen...",
})

-- HUD : miniatures des couches cachées
ns.AddLocale("deDE", {
    HUD_HIDE_STRIP = "Ausgeblendet",
})

-- Onglets réorganisés : Options, sections, Aide en sections, info-bulles
ns.AddLocale("deDE", {
    TAB_OPTIONS = "Optionen",
    ACTIONS_INTRO = "Was jede Taste auslöst. Wähle links eine Ebene und lege rechts deine Aktionen auf ihre Felder.",
    OPTIONS_INTRO = "Die allgemeinen Einstellungen des Addons: was weder eine Taste noch eine Ebene noch die HUD-Anzeige ist.",
    OPTIONS_SECTION_UI = "Oberfläche",
    HUD_SECTION_STRIP = "Ebenen-Miniaturen",
    HUD_SECTION_PLACE = "Größe und Position des HUD",
    HUD_LAYOUT_LABEL = "Anordnung:",
    TEST_OPEN = "Controller testen",
    TEST_BACK = "Zurück zu den Tasten",
    HELP_INTRO = "Wähle links ein Thema. Das Tutorial geht alles Schritt für Schritt durch.",
    HELP_PRINCIPLE = "Das Prinzip",
    HELP_COMMANDS = "Befehle",
    TIP_CONTROLLER = "Wähle deinen Controller: das Addon übernimmt die Namen seiner Zusatztasten.",
    TIP_TYPES = "Noch einmal sehen, was jeder Tastentyp tut: Modifikator, Ziel, einfache Taste, keiner.",
    TIP_DETECT = "Drücke dann die Taste am Controller: das Addon merkt sich die Taste, die sie sendet.",
    TIP_CLEAR = "Die Taste dieses Knopfes vergessen: er tut nichts mehr.",
    TIP_TEST = "Live sehen, was WoW von jeder Taste empfängt: nützlich, wenn eine Taste nicht reagiert.",
    TIP_REPORT = "Ein Text für den Autor bei Problemen (ohne Charakter- oder Realmnamen).",
    TIP_PROFILE_USE = "Dieses Profil wird verwendet: sein Controller, seine Tasten und die Aktionen dieses Charakters.",
    TIP_PROFILE_NEW = "Ein leeres Profil, zum Beispiel für einen anderen Controller.",
    TIP_PROFILE_COPY = "Ein neues Profil als Kopie des gewählten, um Änderungen gefahrlos zu testen.",
    TIP_PROFILE_RENAME = "Den Namen des gewählten Profils ändern.",
    TIP_PROFILE_DELETE = "Das gewählte Profil löschen, mit den Aktionen all deiner Charaktere für dieses Profil.",
    TIP_PROFILE_EXPORT = "Ein Text zum Kopieren, um dieses Profil zu teilen oder aufzubewahren.",
    TIP_PROFILE_IMPORT = "Den Text eines exportierten Profils einfügen (deines oder das eines anderen Spielers).",
    TIP_HUD_DETACH = "Die Miniaturen verlassen das HUD: du kannst sie überall platzieren (Schloss am HUD, dann ziehen).",
    TIP_HUD_VERTICAL = "Die Miniaturen stapeln sich in Spalten statt in einer Zeile.",
    TIP_HUD_HIDDEN = "Keine Miniaturen mehr: das HUD zeigt nur die aktuelle Ebene. Ebenen werden im Reiter Ebenen bearbeitet.",
    TIP_HUD_ROWS = "Auf wie viele Zeilen (oder Spalten) die Miniaturen verteilt werden.",
    TIP_HUD_STRIP_SIZE = "Die Größe der Miniaturen, ohne den Rest des HUD zu ändern.",
    TIP_HUD_SIZE = "Die Größe des ganzen HUD.",
    TIP_HUD_MOVE = "HUD entsperren, um es mit der Maus zu ziehen (wie das Schloss am HUD). Erneut klicken zum Sperren.",
    TIP_HUD_RESET = "Das HUD an seinen ursprünglichen Platz und in seine Größe zurücksetzen (getrennte Miniaturen kommen darunter zurück).",
    TIP_UPRANK = "Lernst du einen neuen Rang eines Zaubers, ersetzt er den alten überall ohne Nachfrage.",
    TIP_VIBRATION = "Eine kurze Vibration, wenn ein feststellbarer Modifikator an- oder ausgeht und wenn ein neuer Rang gesetzt wird.",
    TIP_MINIMAP = "Der Knopf an der Minikarte: Klick öffnet die Einstellungen, Rechtsklick verschiebt das HUD.",
})

-- Nouveautés 1.2.0, et l'encart « donne ton avis »
ns.AddLocale("deDE", {
    WHATSNEW_1_2_0 = "• Das Fenster ist in der Reihenfolge der Einrichtung neu geordnet: Tasten, Ebenen (der frühere Reiter Aktionen), HUD, Optionen, Profile, Hilfe. Jede Einstellung hat einen Tooltip, die Hilfe ein Inhaltsverzeichnis, und der Controller-Test öffnet sich im Reiter Tasten.\n• Neue Zauberränge: Lernst du einen, bietet das Addon an, den alten überall zu ersetzen (oder tut es selbst, Reiter Optionen). /mgir rangs prüft das ganze Zauberbuch.\n• Intelligente Verbrauchsgüter (Feldmenü): dein bester Trank, Essen, Getränk oder Verband, aktualisiert sich selbst.\n• Zauber, die dieser Charakter nicht kennt, sind rot; „Vorlagen und Spezialisierungen...“ kann sie entfernen.\n• Ein Feld sucht eine Aktion in all deinen Ebenen.\n• Neue Grundaktionen: vorheriges Ziel, assistieren, Fokus, folgen, Taschen öffnen, absitzen, zufälliges Lieblingsreittier.\n• HUD: kleine Knöpfe beim Überfahren (Schloss zum Verschieben, Zeile oder Spalte, Einstellungen); die Miniaturen können vom HUD getrennt, in Spalten oder ausgeblendet sein. Das HUD ist immer sichtbar.\n• A, B, X und Y von „Allein“ zeigen die Aktion des Spiels, und die Seite einer einfachen Taste ihr Feld in jedem Modifikator.\n• Controller-Vibrationen, wenn das Spiel sie erlaubt.",
    WHATSNEW_FEEDBACK = "Ein Fehler, eine Idee, etwas Störendes? Sag es mir: jede Rückmeldung hilft, das Addon zu verbessern. Kopiere diesen Link (Strg+C), um auf GitHub zu schreiben:",
})

-- 1.3.0: Zauberziel, Kontextaktion, Zyklusaktion, Prüfung der Einrichtung,
-- HUD-Komfort
ns.AddLocale("deDE", {
    MENU_UNIT = "Wirken auf...",
    MENU_COND = "Kontextaktion...",
    MENU_SEQ = "Zyklusaktion...",
    MENU_PICKUP_CAST = "Oder hier einen Zauber oder Gegenstand ablegen",
    SLOT_KIND_REFUSED = "Hier nur ein Zauber oder ein Gegenstand.",
    KIND_cond = "Kontextaktion",
    KIND_seq = "Zyklusaktion",

    UNIT_TITLE = "Wirken auf",
    UNIT_target = "Das Ziel (üblich)",
    UNIT_CURRENT = "gewählt",
    UNIT_player = "Mich",
    UNIT_helpself = "Den anvisierten Verbündeten, sonst mich",
    UNIT_focus = "Den Fokus",
    UNIT_targettarget = "Das Ziel meines Ziels",
    UNIT_pet = "Meinen Begleiter",
    UNIT_party = "Gruppenmitglied %s",
    UNIT_TIP = "Gewirkt auf: %s",

    COND_TITLE = "Kontextaktion",
    COND_HELP = "Ein Platz, zwei Aktionen: Die erste wird ausgelöst, wenn die Bedingung zutrifft, sonst die zweite. Eine der beiden darf leer bleiben.",
    COND_IF = "Bedingung:",
    COND_THEN = "Wenn ja",
    COND_ELSE = "Sonst",
    COND_NOTHING = "Nichts",
    COND_NEED_ACTION = "Lege mindestens einen Zauber oder Gegenstand ab.",
    COND_TIP_IF = "%s: %s",
    COND_TIP_ELSE = "Sonst: %s",
    COND_combat = "Im Kampf",
    COND_mounted = "Auf einem Reittier",
    COND_stealth = "In Verstohlenheit",
    COND_harm = "Mein Ziel ist ein Feind",
    COND_help = "Mein Ziel ist ein Verbündeter",
    COND_exists = "Ich habe ein Ziel",
    COND_pet = "Ich habe einen Begleiter",
    COND_group = "In einer Gruppe",
    COND_swimming = "Beim Schwimmen",
    COND_indoors = "In Innenräumen",
    COND_stance = "Gestalt oder Haltung %d",

    SEQ_TITLE = "Zyklusaktion",
    SEQ_HELP = "2 bis 4 Zauber oder Gegenstände: Jeder Druck wirkt den nächsten, dann geht es von vorn los. Das Spiel geht nur weiter, wenn der Zauber gewirkt wurde.",
    SEQ_RESET = "Zurück zum ersten:",
    SEQ_RESET_none = "Nur nach dem letzten",
    SEQ_RESET_target = "Beim Zielwechsel",
    SEQ_RESET_combat = "Am Ende des Kampfes",
    SEQ_RESET_both = "Zielwechsel oder Kampfende",
    SEQ_RESET_seconds = "Nach %d s ohne Druck",
    SEQ_NEED_TWO = "Lege mindestens zwei Zauber oder Gegenstände ab.",
    SEQ_TIP_RESET = "Zurück zum ersten: %s",

    GAME_mounttoggle = "Aufsitzen / absitzen",
    GAME_targetpet = "Meinen Begleiter anvisieren",
    GAME_sheet = "Spickzettel der Ebenen anzeigen",
    GAME_partynext = "Nächster Verbündeter der Gruppe (ich, dann jedes Mitglied)",
    GAME_targetparty = "Gruppenmitglied %d anvisieren",

    CHECK_BUTTON = "Meine Einrichtung prüfen",
    TIP_CHECK = "Sucht, was eine Taste oder einen Platz am Funktionieren hindert: Taste ohne Tastenbelegung, gelöschtes Makro, unbekannter Zauber, unvollständiges Paar... Jede Zeile bietet an, es zu beheben oder dorthin zu gehen.",
    CHECK_TITLE = "Prüfung der Einrichtung",
    CHECK_ALL_GOOD = "Alles bereit: nichts zu beheben.",
    CHECK_SUMMARY = "%d Punkt(e) zu beheben, %d Hinweis(e).",
    CHECK_FIX = "Beheben",
    CHECK_GO = "Dorthin",
    CHECK_AGAIN = "Erneut prüfen",
    CHECK_CLEAR = "Platz leeren",
    CHECK_CLEARED = "Platz geleert.",
    CHECK_REMOVE = "Entfernen",
    CHECK_REPLACE = "Ersetzen",
    CHECK_UNCHECK = "Abwählen",
    CHECK_NO_KEY = "%s hat keine Taste: Sie tut nichts. Klicke im Reiter Tasten auf „Erkennen“ oder stelle sie auf „Deaktiviert“.",
    CHECK_SAME_KEY = "%s und %s haben dieselbe Taste (%s): Nur eine der beiden funktioniert.",
    CHECK_PAIR_HALF = "Das Paar %s ist angehakt, aber %s ist kein Modifikator: Es funktioniert nicht.",
    CHECK_MACRO_GONE = "%s: Das Makro „%s“ gibt es im Spiel nicht mehr. Der Platz tut nichts.",
    CHECK_SET_GONE = "%s: Das Ausrüstungsset „%s“ gibt es nicht mehr. Der Platz tut nichts.",
    CHECK_COMPOSED_EMPTY = "%s: Diese Aktion hat keinen gültigen Zauber oder Gegenstand mehr. Der Platz tut nichts.",
    CHECK_ITEM_GONE = "%s: %s ist weder in deinen Taschen noch angelegt.",
    CHECK_UNKNOWN = "%d Platz/Plätze enthalten einen Zauber, den dieser Charakter nicht kennt: Sie tun nichts.",
    CHECK_LOWER_RANKS = "%d Platz/Plätze enthalten einen niedrigeren Rang eines Zaubers, den du in höherem Rang kennst.",
    CHECK_EMPTY_BUTTON = "%s hat keine Aktion.",
    CHECK_TAP_SAFE = "Dieses Spiel kann die Dauer eines Tastendrucks nicht messen: Eine Zieltaste wechselt das Ziel nur, wenn du noch kein gültiges Ziel hast.",
    HUD_IDLE_ALPHA = "Deckkraft im Ruhezustand:",
    TIP_HUD_IDLE_ALPHA = "Die Deckkraft des HUD außerhalb des Kampfes, wenn keine Taste gehalten wird. Bei 0 % ist es ausgeblendet: Es kommt im Kampf zurück, wenn du eine Taste hältst, oder unter der Maus.",
    SHEET_BUTTON = "Spickzettel der Ebenen",
    TIP_SHEET = "Zeigt alle deine Ebenen groß in der Bildschirmmitte, um deine Kürzel zu lernen. Auch mit /mgir map oder der Grundaktion „Spickzettel der Ebenen anzeigen“ auf einem Platz.",
    SHEET_TITLE = "Spickzettel: alle deine Ebenen",
    SHEET_HINT = "Esc oder /mgir map zum Schließen. Die benutzte Ebene hat einen goldenen Rand.",

    TUTO_ACTIONS_MORE = "\n|cffffd100Mehr Möglichkeiten|r (Menü eines Platzes):\n- |cffffd100Wirken auf...|r: Der Zauber oder Gegenstand geht auf dich, den Fokus, das Ziel deines Ziels, deinen Begleiter oder ein Gruppenmitglied. Der Platz zeigt ein „@“.\n- |cffffd100Kontextaktion...|r: zwei Aktionen und eine Bedingung (im Kampf, auf einem Reittier, Gestalt...). Die erste wird ausgelöst, wenn die Bedingung zutrifft, sonst die zweite. Der Platz zeigt ein „/“.\n- |cffffd100Zyklusaktion...|r: 2 bis 4 Zauber oder Gegenstände, bei jedem Druck der nächste. Der Platz zeigt den Schritt („2/3“).\n- |cffffd100Grundaktion|r: „Nächster Verbündeter der Gruppe“ geht von dir zu jedem Gruppenmitglied; „Gruppenmitglied anvisieren“ wählt eines direkt. Das Spiel erlaubt einem Addon nicht, den am stärksten verletzten Verbündeten zu wählen.\n\nEine Taste oder ein Platz funktioniert nicht? |cffffd100Meine Einrichtung prüfen|r (Reiter Tasten oder /mgir check) sagt dir, warum.",
    TUTO_HUD_MORE = "\n|cffffd100Reiter HUD|r:\n- |cffffd100Deckkraft im Ruhezustand|r: wie sichtbar das HUD außerhalb des Kampfes ist; bei 0 % ist es ausgeblendet und kommt im Kampf zurück oder wenn du eine Taste hältst.\n- |cffffd100Spickzettel der Ebenen|r (oder /mgir map): alle deine Ebenen groß in der Bildschirmmitte.",
    HELP_COMMANDS_MORE = "|cffffd100/mgir check|r: die Einrichtung prüfen\n|cffffd100/mgir map|r: Spickzettel aller Ebenen",
    SLASH_HELP_MORE = "/mgir check: Einrichtung prüfen  |  /mgir map: Spickzettel der Ebenen",
    WHATSNEW_1_3_0 = "• Wirken auf... (Menü eines Platzes): Ein Zauber oder Gegenstand geht auf dich, den Fokus, das Ziel deines Ziels, deinen Begleiter oder ein Gruppenmitglied, ohne ein Makro zu schreiben.\n• Kontextaktion: ein Platz, zwei Aktionen und eine Bedingung (im Kampf, auf einem Reittier, in Verstohlenheit, Gestalt, feindliches oder verbündetes Ziel...).\n• Zyklusaktion: 2 bis 4 Zauber oder Gegenstände auf einem Platz, bei jedem Druck der nächste.\n• Neue Grundaktionen: nächster Verbündeter der Gruppe, Gruppenmitglied 1 bis 4 anvisieren, deinen Begleiter anvisieren, aufsitzen / absitzen, Spickzettel.\n• Meine Einrichtung prüfen (Reiter Tasten und Hilfe, /mgir check): die Liste dessen, was eine Taste oder einen Platz am Funktionieren hindert, mit einer Möglichkeit, es zu beheben.\n• HUD: einstellbare Deckkraft im Ruhezustand (bis ausgeblendet außerhalb des Kampfes) und ein Spickzettel aller deiner Ebenen (/mgir map).",
})
