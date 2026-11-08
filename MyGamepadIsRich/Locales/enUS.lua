-- English (reference: every key exists here; other languages fall back to it)
local _, ns = ...

ns.AddLocale("enUS", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "Buttons",
    TAB_TEST = "Controller test",
    TAB_HELP = "Help",

    NAME = "Name:",
    KEY = "Key:",
    KEY_NONE = "not set",
    DETECT = "Detect",
    CLEAR = "Clear",
    MODE = "Mode:",
    MODE_MODIFIER = "Modifier",
    MODE_SIMPLE = "Simple button",
    MODE_OFF = "Disabled",
    MODE_MODIFIER_DESC = "Hold this button and press A, B, X, Y or the D-pad: 8 new combos, like LT/RT.",
    MODE_SIMPLE_DESC = "One action, plus one with LT held and one with RT held. An empty layer uses the \"Alone\" action.",
    MODE_OFF_DESC = "This button does nothing: its key is left free.",
    LAYER_BASE = "Alone",
    LAYER_LT = "LT +",
    LAYER_RT = "RT +",
    SLOT_HINT = "Drag a spell, item, macro or mount onto a slot. Right-click: more choices.",
    EMPTY = "Empty",
    NO_KEY_WARNING = "Set the key first: click \"Detect\" and press the button.",

    MENU_SPELL = "Pick a spell...",
    MENU_ITEM = "Pick a bag item...",
    SPELL_TITLE = "Character spells",
    ITEM_TITLE = "Bag items",
    ITEMS_EQUIPPED = "Equipped (usable)",
    ITEMS_USABLE = "Usable",
    ITEMS_OTHER = "Other items",
    LIST_EMPTY = "Nothing to show.",
    MENU_MACROTEXT = "Write a macro...",
    MENU_COMMAND = "WoW command...",
    MENU_CLEAR = "Clear",
    MENU_PICKUP_HINT = "Or drop a spell / item / macro / mount here",
    MACRO_TITLE = "Macro text",
    MACRO_HELP = "One command per line, e.g. /cast Fireball  (255 characters max)",
    OK = "OK",
    CANCEL = "Cancel",
    COMMAND_TITLE = "WoW command",
    SEARCH = "Search:",
    COMMAND_LT_RT = "A WoW command only works on the \"Alone\" layer of a button with no LT/RT layer.",

    KIND_spell = "Spell",
    KIND_item = "Item",
    KIND_toy = "Toy",
    KIND_mount = "Mount",
    KIND_macro = "Macro",
    KIND_macrotext = "Custom macro",
    KIND_command = "WoW command",
    KIND_equipset = "Equipment set",

    CURSOR_UNSUPPORTED = "This can't go on a button (only spells, items, toys, mounts, macros, equipment sets).",
    APPLIED_AFTER_COMBAT = "In combat: changes will apply when combat ends.",
    APPLIED = "Changes applied.",
    LEARN_PROMPT = "Press the controller button for |cffffd100%s|r\n\n(Escape to cancel)",
    LEARN_COMBAT = "Can't detect a button in combat.",
    LEARN_DONE = "%s is now on the key %s.",
    LEARN_TAKEN = "The key %s was used by %s: removed from it.",
    LEARN_BOUND = "Note: %s was bound to \"%s\" in WoW; while this addon uses it, the addon wins.",

    TEST_STANDARD = "Standard buttons",
    TEST_EXTRA = "Extra buttons",
    TEST_LOG = "Last inputs",
    TEST_GAME = "game",
    TEST_UNKNOWN = "not assigned",

    IF_WARNING = "Improved Forever is loaded: if it also uses one of these keys, the last applied binding wins.",
    OPEN_CONFIG = "Open the configuration",
    LOADED = "loaded. Type /mgir to configure your extra buttons.",
    RESET_DONE = "This character's actions were reset.",

    DPAD_UP = "D-pad Up",
    DPAD_DOWN = "D-pad Down",
    DPAD_LEFT = "D-pad Left",
    DPAD_RIGHT = "D-pad Right",
    PADDLE = "Paddle %s",

    -- Tutorial
    TUTO_TITLE = "Tutorial",
    TUTO_NEXT = "Next",
    TUTO_BACK = "Back",
    TUTO_SKIP = "Skip tutorial",
    TUTO_FINISH = "Open the configuration",
    TUTO_REOPEN = "Tutorial closed. Type /mgir tuto to see it again.",
    TUTO_SUGGESTED = "Use the suggested modes",
    HELP_REPLAY = "Replay the tutorial",

    TUTO_WELCOME_TITLE = "Welcome to My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "For each button, click |cffffd100Detect|r, then press that button on your controller. "
        .. "The key it sends appears next to it.",


    TUTO_ACTIONS_TEXT = "In the configuration window, each button shows its slots.\n\n"
        .. "- Drag a spell from your spellbook, an item from your bags, a macro, a mount or a toy onto a slot.\n"
        .. "- Or right-click a slot: pick a spell or a bag item, write a macro, choose a WoW command (such as Auto Run), or clear it.\n\n"
        .. "Actions are saved per character; keys and modes for the whole account. "
        .. "Everything works in combat; only changes made during combat wait for it to end.",

    TUTO_DONE_TITLE = "You're ready",
    TUTO_DONE_TEXT = "Open the configuration to place your first actions.\n\n"
        .. "|cffffd100/mgir|r: open the configuration\n"
        .. "|cffffd100/mgir test|r: controller test, to see what WoW receives\n"
        .. "|cffffd100/mgir tuto|r: this tutorial\n"
        .. "|cffffd100/mgir reset|r: clear this character's actions",
})

-- HUD
ns.AddLocale("enUS", {
    HUD_UNLOCKED = "HUD unlocked: drag it with the mouse. Type /mgir hud again to lock it.",
    HUD_LOCKED = "HUD locked.",
    HUD_ON = "HUD shown: it replaces the game's controller bar.",
    HUD_OFF = "HUD hidden: the game's controller bar is back. Type /mgir hud on to show it again.",
    HUD_SCALE = "HUD scale: %s",
    TUTO_HUD_TITLE = "Your controller HUD",
})

-- HUD : attribution rapide
ns.AddLocale("enUS", {
    HUD_COMBAT = "Actions can't be changed in combat.",
    HUD_GAME_SLOT = "This button keeps the game's own action (jump, interact...).",
    HUD_KIND = "The game's bar only takes spells, items, mounts and macros from the macro list.",
    HUD_EDITING = "Editing this layer: click a tile to set it, right-click to clear it. Click the miniature again, or press any other button or key, to go back.",
    HUD_TILE_HINT = "Click: set  -  Right-click: clear",
    HUD_CARD_HINT = "Click: edit this layer",
})

-- HUD : bande des miniatures
ns.AddLocale("enUS", {
    HUD_STRIP_TOP = "Layer miniatures now above the HUD. Type /mgir hud strip to switch.",
    HUD_STRIP_BOTTOM = "Layer miniatures now below the HUD. Type /mgir hud strip to switch.",
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("enUS", {
    TUTO_STRIP_LABEL = "Layer miniatures:",
    TUTO_STRIP_BOTTOM = "Below (recommended)",
    TUTO_STRIP_TOP = "Above",
})

-- Bouton de la minimap
ns.AddLocale("enUS", {
    MINIMAP_LEFT = "Left-click: open the configuration",
    MINIMAP_RIGHT = "Right-click: unlock / lock the HUD to move it",
    MINIMAP_SHIFT = "Shift + left-click: tutorial",
    MINIMAP_DRAG = "Drag: move this button around the minimap",
    MINIMAP_HIDDEN = "Minimap button hidden. Type /mgir minimap to show it again.",
    MINIMAP_SHOWN = "Minimap button shown.",
})

-- Paires de modificateurs
ns.AddLocale("enUS", {
    PAIR_READY = "Pair · hold both",
    PAIR_NOT_READY = "Pair · not available",
    PAIR_DESC = "Hold %s and %s together, then press A, B, X, Y or the D-pad: 8 more combos.",
    PAIR_NEEDS = "To use this pair, %s and %s must both be in Modifier mode, with a key.",
})

-- Fenêtre de configuration (onglets Actions, Boutons, HUD)
ns.AddLocale("enUS", {
    TAB_ACTIONS = "Actions",
    TAB_HUD = "HUD",
    SECTION_PAD = "Controller bar",
    SECTION_MODS = "Modifiers",
    SECTION_MODS_EMPTY = "None yet: set a button to Modifier in the Buttons tab.",
    SECTION_SIMPLE = "Simple buttons",
    SECTION_SIMPLE_EMPTY = "None yet: set a button to Simple button in the Buttons tab.",
    LAYER_DESC_BASE = "A, B, X, Y and the D-pad with nothing held. Everything can go here: what the game's bar can't hold (custom macro, WoW command) is taken by the addon. A, B, X and Y keep the game's actions (jump, interact...) until you put your own.",
    LAYER_DESC_HOLD = "Hold %s, then press A, B, X, Y or the D-pad.",
    PAIRS_TITLE = "Pairs (two modifiers held together)",
    HUD_INTRO = "The HUD replaces the game's controller bar: the layer in use in large, every layer in miniature.",
    HUD_SHOW = "Show the HUD (instead of the game's controller bar)",
    HUD_SIZE = "Size:",
    HUD_MOVE = "Move the HUD",
    HUD_MOVE_DONE = "Lock the HUD",
    HUD_RESET = "Reset position and size",
    MINIMAP_SHOW = "Button around the minimap",
    GAME_ACTION = "Game",
    BAR_UNAVAILABLE = "The game's controller bar isn't available (is the controller interface on?).",
    KIND_slot = "Action",
    SLOT_HINT = "Drag a spell, item, macro or mount onto a slot. Click: menu. Right-click: clear.",
})

-- HUD : taille et lignes des miniatures
ns.AddLocale("enUS", {
    HUD_STRIP_SIZE = "Miniature size:",
    HUD_STRIP_ROWS = "Miniature rows:",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("enUS", {
    CONTROLLER_LABEL = "Controller:",
    CONTROLLER_CHANGE = "Change...",
    CONTROLLER_PICK = "Choose your controller",
    CONTROLLER_OTHER = "Other controller",
    EXTRA = "Button",
    SOFTWARE_GENERIC = "your controller's software",
    SETTINGS_DESC = "Configure your controller's extra buttons (back paddles, extra triggers). Command: /mgir",
    BUTTONS_INTRO = "Your controller and its extra buttons: the key each one sends, and what it does. Hover a mode to see what it does.",
    TEST_INTRO = "Press any button: what WoW receives lights up. If your extra buttons show nothing, give them keyboard keys in your controller's software (see Help).",
    LEARN_MODKEY = "Warning: %s is a Shift / Ctrl / Alt key; in your controller's software, prefer a key like F9-F12.",

    TUTO_WELCOME_TEXT = "This addon brings your controller's extra buttons into WoW: back paddles, extra triggers or bumpers "
        .. "(GameSir, Xbox Elite, DualSense Edge, SCUF, 8BitDo, Flydigi...).\n\n"
        .. "Each one can be a held modifier (8 new combos with A, B, X, Y and the D-pad), "
        .. "or a simple button with its own LT and RT layers.\n\n"
        .. "This tutorial takes about two minutes. You can leave it at any time and open it again with |cffffd100/mgir tuto|r.",

    TUTO_CONTROLLER_TITLE = "Step 1: Your controller",
    TUTO_CONTROLLER_TEXT = "Pick your controller: the addon then uses the names of its buttons and tells you which software sets them up. "
        .. "Not in the list? Choose |cffffd100Other controller|r (up to 6 buttons, which you can rename).",

    TUTO_SOFTWARE_TITLE = "Step 2: Make the buttons send a key",
    TUTO_SOFTWARE_WHY = "Windows sees most controllers as an Xbox controller (XInput). That mode only carries the standard buttons, "
        .. "so WoW never receives the extra ones. The fix is to make each of them send a keyboard key.",
    TUTO_SOFTWARE_VENDOR = "1. Plug in the controller and open |cffffd100%s|r.\n"
        .. "2. Open the button mapping page.\n"
        .. "3. Give each extra button (%s) a keyboard key you don't use in WoW. Good choices: |cffffd100F9, F10, F11, F12|r, "
        .. "or the numeric keypad (with Num Lock on).\n"
        .. "4. Avoid Shift, Ctrl and Alt: they would change your other bindings.\n"
        .. "5. Save the profile (to the controller, if the software offers it).",
    TUTO_SOFTWARE_ALT = "If %s can't give a keyboard key to these buttons, use |cffffd100Steam Input|r: add WoW (or the Battle.net launcher) "
        .. "to Steam as a non-Steam game, launch it from Steam and give each button a key in its controller layout. "
        .. "|cffffd100reWASD|r (paid) works too, without Steam.",
    TUTO_SOFTWARE_STEAM = "1. In |cffffd100Steam|r, add WoW (or the Battle.net launcher) as a non-Steam game "
        .. "(Games > Add a Non-Steam Game to My Library), then launch it from Steam.\n"
        .. "2. Open its controller layout (Steam overlay, or the game's controller settings in Steam).\n"
        .. "3. Give each extra button (%s) a keyboard key you don't use in WoW. Good choices: |cffffd100F9, F10, F11, F12|r.\n"
        .. "4. Avoid Shift, Ctrl and Alt: they would change your other bindings.\n\n"
        .. "|cffffd100reWASD|r (paid) can do the same without Steam.",

    TUTO_DETECT_TITLE = "Step 3: Detect your buttons",
    TUTO_DETECT_ALL = "|cff40ff40All your buttons are detected.|r",
    TUTO_DETECT_MISSING = "Nothing happens when you press a button? Check its key in your controller's software (step 2), then try again.",

    TUTO_MODES_TITLE = "Step 4: Choose a mode",
    TUTO_MODES_TEXT = "|cffffd100Modifier|r: hold the button, then press A, B, X, Y or the D-pad. 8 actions per button, like LT and RT.\n"
        .. "|cffffd100Simple button|r: one action, plus one with LT held and one with RT held.\n"
        .. "|cffffd100Disabled|r: the key is left free.\n\n"
        .. "Suggested: modifiers on the buttons that are easiest to hold, simple buttons on the others.",
    TUTO_PAIRS_TEXT = "|cffffd100Pairs|r: the buttons go in left + right pairs. When both buttons of a pair are modifiers, "
        .. "holding them together gives 8 more combos.",

    TUTO_ACTIONS_TITLE = "Step 5: Place your actions",

    TUTO_HUD_TEXT = "The addon replaces the game's controller bar with its own HUD at the bottom of the screen:\n\n"
        .. "- |cffffd100Large|r: the layer you are using, D-pad on the left, A/B/X/Y on the right. Hold LT, RT or a modifier and it switches.\n"
        .. "- |cffffd100In the strip|r (below, or above with /mgir hud strip): every layer in miniature (Alone, LT, RT, LT+RT, your modifiers and pairs); the one you hold lights up.\n"
        .. "- |cffffd100In the middle|r: your simple buttons, with the action that will fire for the trigger you hold.\n\n"
        .. "It fades out of combat while you hold nothing.\n"
        .. "|cffffd100/mgir hud|r: move it  -  |cffffd100/mgir hud scale 1.2|r: size  -  |cffffd100/mgir hud off|r: back to the game's bar",
})

-- Profils : liste, export, import
ns.AddLocale("enUS", {
    TAB_PROFILES = "Profiles",
    PROFILES_INTRO = "A profile holds a controller, its buttons and, for each character, its actions. One profile is used at a time, for the whole account. The HUD is shared by all profiles.",
    PROFILE_ACTIVE = "in use",
    PROFILE_USE = "Use this profile",
    PROFILE_NEW = "New...",
    PROFILE_COPY = "Copy...",
    PROFILE_RENAME = "Rename...",
    PROFILE_DELETE = "Delete",
    PROFILE_EXPORT = "Export...",
    PROFILE_IMPORT = "Import...",
    PROFILE_DEFAULT = "Profile",
    PROFILE_IMPORTED = "Imported profile",
    PROFILE_COPY_SUFFIX = "%s (copy)",
    PROFILE_NAME_NEW = "Name of the new profile:",
    PROFILE_NAME_COPY = "Name of the copy:",
    PROFILE_NAME_RENAME = "New name for “%s”:",
    PROFILE_DELETE_CONFIRM = "Delete the profile “%s”? Its buttons, and the actions of all your characters for this profile, will be lost.",
    PROFILE_SWITCHED = "Profile in use: %s.",
    PROFILE_UNKNOWN = "No profile is named “%s”. Type /mgir profiles to see them.",
    PROFILE_COMBAT = "Profiles can't be changed in combat.",
    PROFILE_LAST = "This is your only profile: it can't be deleted.",
    PROFILE_CREATED = "Profile “%s” created and in use. Set its keys in the Buttons tab.",

    EXPORT_TITLE = "Export “%s”",
    EXPORT_ACTIONS = "Include this character's actions",
    EXPORT_HUD = "Include the HUD settings",
    EXPORT_HINT = "The text is selected: Ctrl+C to copy it, then paste it wherever you like (Discord, a text file...). Import it with the Import button of the Profiles tab.",
    CLOSE = "Close",

    IMPORT_TITLE = "Import a profile",
    IMPORT_PASTE = "Paste the export text here (Ctrl+V):",
    IMPORT_EMPTY = "Paste an export text to see what it contains.",
    IMPORT_BAD = "This is not a My Gamepad Is Rich export text.",
    IMPORT_VERSION = "This text comes from another version of the addon and can't be read.",
    IMPORT_DAMAGED = "This text is damaged or incomplete: copy it again, in full.",
    IMPORT_SUMMARY = "Profile “%s”, controller: %s\n%d button(s) with a key, %d action(s)",
    IMPORT_SUMMARY_HUD = "Includes HUD settings.",
    IMPORT_MACROS = "Warning: %d custom macro(s). Read them before using them:",
    IMPORT_COMMANDS = "WoW commands: %s",
    IMPORT_AS_NEW = "New profile:",
    IMPORT_REPLACE = "Replace:",
    IMPORT_PICK = "Profile to replace",
    IMPORT_ACTIONS = "Import the actions (for this character)",
    IMPORT_HUD = "Apply the HUD settings",
    IMPORT_DO = "Import",
    IMPORT_REPLACE_CONFIRM = "Replace the profile “%s”? Its controller and buttons will be overwritten, and its actions for this character if you import them.",
    IMPORT_DONE = "Profile “%s” imported.",

    SELFTEST_OK = "Self-test: everything is OK.",
    SELFTEST_FAIL = "Self-test: %d problem(s): %s",
    SLASH_HELP = "/mgir : open  |  /mgir profile <name> : switch profile  |  /mgir test : controller test  |  /mgir tuto : tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : reset this character's actions",
})

-- HUD : arrêt après une erreur
ns.AddLocale("enUS", {
    HUD_ERROR = "HUD error, the HUD is stopped until /reload (the game's bar is back). Please report this message: %s",
})

-- Gâchettes LT / RT données à l'addon
ns.AddLocale("enUS", {
    TRIGGERS_LABEL = "LT / RT triggers:",
    TRIGGERS_ADDON = "Addon modifiers",
    TRIGGERS_GAME = "Game layers",
    TRIGGERS_ADDON_DESC = "Hold LT or RT (or both) then press A, B, X, Y or the D-pad: the addon's actions, with everything it allows (custom macros, WoW commands). They replace the LT, RT and LT + RT layers of the game's controller bar; an empty slot does nothing. LB and RB are not touched.",
    TRIGGERS_GAME_DESC = "LT and RT keep the layers of the game's controller bar (edited from the Actions tab).",
    TRIGGERS_COPIED = "%d action(s) copied from the game's LT / RT layers to the addon's.",
    IMPORT_SUMMARY_TRIGGERS = "LT / RT: addon modifiers.",
})

-- Menu d'une case : pourquoi des choix sont grisés
ns.AddLocale("enUS", {
    MENU_GAME_BAR_HINT = "Custom macros, WoW commands: give LT / RT to the addon (Buttons tab, Base buttons)",
})

-- Actions de base (celles de Forever sur A/B/X/Y)
ns.AddLocale("enUS", {
    MENU_GAME = "Basic action...",
    GAME_TITLE = "Basic actions",
    KIND_game = "Basic action",
    GAME_jump = "Jump",
    GAME_cancel = "Cancel (spell, target)",
    GAME_search = "Search (right-click on target)",
    GAME_attack = "Auto attack",
    GAME_interact = "Interact",
})

-- Modes de ciblage (comme LB / RB dans Forever)
ns.AddLocale("enUS", {
    MODE_TARGET_FRIEND = "Ally target",
    MODE_TARGET_ENEMY = "Enemy target",
    MODE_TARGET_FRIEND_DESC = "Like LB in Forever: a short press targets the nearest ally; hold it and aim with the right stick to pick one. Held, it is also a modifier: A, B, X, Y and the D-pad fire its 8 shortcuts.",
    MODE_TARGET_ENEMY_DESC = "Like RB in Forever: a short press targets the nearest enemy; hold it and aim with the right stick to pick one. Held, it is also a modifier: A, B, X, Y and the D-pad fire its 8 shortcuts.",
    TARGET_UNAVAILABLE = "Forever's targeting can't be found: %s works as a plain modifier.",
})

-- Onglet « Soutenir » (don PayPal)
ns.AddLocale("enUS", {
    TAB_DONATE = "Support",
    DONATE_TITLE = "Support My Gamepad Is Rich",
    DONATE_INTRO = "My Gamepad Is Rich is free and will stay free. If it makes your game better and you want to thank me, you can make a donation on PayPal, of any amount.",
    DONATE_SCAN = "Scan the QR code with your phone",
    DONATE_LINK = "Or copy the link (Ctrl+C) and paste it in your browser:",
    DONATE_THANKS = "Donations are entirely optional and unlock nothing: every feature stays available to everyone. Thank you for your support!",
})

-- Boutons de base (LT, RT, LB, RB)
ns.AddLocale("enUS", {
    MODE_GAME = "Game",
    MODE_GAME_DESC = "This button keeps its role in the game (LT / RT: layers of the controller bar; LB / RB: Forever's targeting).",
    PADS_LABEL = "Base buttons:",
    PADS_PICK = "%s: choose a mode",
    IMPORT_SUMMARY_PADS = "Base buttons given to the addon: %s",
    EMULATION_OFF = "%s no longer imitates Shift / Ctrl while it is given to the addon. Type /mgir restore before disabling the addon.",
    RESTORE_DONE = "Base buttons given back to the game, and their Shift / Ctrl imitation restored.",
})

-- Plus aucun ciblage allié / ennemi configuré
ns.AddLocale("enUS", {
    TARGET_MISSING_FRIEND = "No button targets allies: set LB to \"Game\", or a button to \"Ally target\" (Buttons tab).",
    TARGET_MISSING_ENEMY = "No button targets enemies: set RB to \"Game\", or a button to \"Enemy target\" (Buttons tab).",
    TARGET_MISSING_BOTH = "No button targets allies or enemies: set LB / RB to \"Game\", or buttons to \"Ally target\" / \"Enemy target\" (Buttons tab).",
})

-- Onglet Boutons : mention des boutons de base
ns.AddLocale("enUS", {
    PAD_HINT = "controller button: nothing to detect",
})

-- Case vide d'un bouton simple dans une couche : son action habituelle
ns.AddLocale("enUS", {
    SIMPLE_USUAL = "Usual",
})

-- Manettes standard (sans bouton supplémentaire), noms PlayStation
ns.AddLocale("enUS", {
    TUTO_NO_EXTRA = "This controller has no extra buttons: nothing to set up here. You can give other roles to LT, RT, LB and RB (Base buttons, in the Buttons tab).",
    PS_CROSS = "Cross",
    PS_CIRCLE = "Circle",
    PS_SQUARE = "Square",
    PS_TRIANGLE = "Triangle",
})

-- Paires libres (deux modificateurs quelconques)
ns.AddLocale("enUS", {
    PAIRS_HINT = "Tick the pairs you want: holding both modifiers together gives 8 more combinations. Any two modifiers can form a pair (L5 + LT, LB + RT...).",
    PAIRS_NONE = "Set at least two buttons as Modifier, Ally target or Enemy target to form pairs.",
})

-- Paire avec un bouton de base resté au jeu
ns.AddLocale("enUS", {
    PAIR_WAITS = "%s is on Game: set it to Modifier, Ally target or Enemy target (above)",
})

-- Boutons de base : mode par défaut
ns.AddLocale("enUS", {
    MODE_IS_DEFAULT = "Default for this button: it works like in the game.",
})
