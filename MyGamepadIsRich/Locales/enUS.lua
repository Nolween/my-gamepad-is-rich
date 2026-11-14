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
    MODE_MODIFIER = "Modifier",
    MODE_SIMPLE = "Simple button",
    MODE_OFF = "Disabled",
    MODE_MODIFIER_DESC = "Hold this button and press A, B, X, Y or the D-pad: 8 new combos, like LT/RT.",
    MODE_SIMPLE_DESC = "One action, plus one with LT held and one with RT held. An empty layer does nothing.",
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
    MENU_ICON = "Change icon...",
    ICON_TITLE = "Choose an icon",
    ICON_HINT = "Search by spell, item or WoW command name, or type an icon file name (as on Wowhead: inv_misc_map_01).",
    ICON_DEFAULT = "Default icon",
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
    HELP_REPLAY = "Replay the tutorial",

    TUTO_WELCOME_TITLE = "Welcome to My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "For each button, click |cffffd100Detect|r, then press that button on your controller. "
        .. "The key it sends appears next to it.",



    TUTO_DONE_TITLE = "You're ready",
})

-- HUD
ns.AddLocale("enUS", {
    HUD_UNLOCKED = "HUD unlocked: drag it with the mouse (separated miniatures move on their own). To lock it: the HUD padlock, or /mgir hud again.",
    HUD_LOCKED = "HUD locked.",
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
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("enUS", {
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
    TAB_ACTIONS = "Layers",
    TAB_HUD = "HUD",
    SECTION_PAD = "Controller bar",
    SECTION_MODS = "Modifiers",
    SECTION_MODS_EMPTY = "None yet: set a button to Modifier in the Buttons tab.",
    SECTION_SIMPLE = "Simple buttons",
    SECTION_SIMPLE_EMPTY = "None yet: set a button to Simple button in the Buttons tab.",
    LAYER_DESC_BASE = "A, B, X, Y and the D-pad with nothing held. Everything can go here: what the game's bar can't hold (custom macro, WoW command) is taken by the addon. A, B, X and Y keep the game's actions (jump, interact...) until you put your own.",
    LAYER_DESC_HOLD = "Hold %s, then press A, B, X, Y or the D-pad.",
    PAIRS_TITLE = "Pairs (two modifiers held together)",
    HUD_INTRO = "The HUD replaces the game's controller bar: as a grid (one row per layer) or like the controller (the layer in use in large, every layer in miniature).",
    HUD_SIZE = "Size:",
    HUD_MOVE = "Unlock the HUD",
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
    HUD_ORDER = "Layer order:",
    HUD_ORDER_RESET = "Default order",
    HUD_ORDER_HINT = "Arrows: move a layer. On the HUD, you can also drag a miniature (or a grid row's name) onto another one.",
    HUD_CARD_DRAG = "Drag: move it (onto another miniature)",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("enUS", {
    CONTROLLER_LABEL = "Controller:",
    CONTROLLER_CHANGE = "Change...",
    CONTROLLER_PICK = "Choose your controller",
    CONTROLLER_OTHER = "Other controller",
    EXTRA = "Button",
    SOFTWARE_GENERIC = "your controller's software",
    TEST_INTRO = "Press any button: what WoW receives lights up. If your extra buttons show nothing, give them keyboard keys in your controller's software (see Help).",
    LEARN_MODKEY = "Warning: %s is a Shift / Ctrl / Alt key; in your controller's software, prefer a key like F9-F12.",



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

    TUTO_DETECT_ALL = "|cff40ff40All your buttons are detected.|r",



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
    TRIGGERS_GAME_DESC = "LT and RT keep the layers of the game's controller bar (edited from the Layers tab).",
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
    EMULATION_OFF = "%s no longer imitates Shift / Ctrl while it is given to the addon. It is put back automatically when you log out.",
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
})

-- Paire avec un bouton de base resté au jeu
ns.AddLocale("enUS", {
})

-- Boutons de base : mode par défaut
ns.AddLocale("enUS", {
    MODE_IS_DEFAULT = "Default for this button: it works like in the game.",
})

-- Tutoriel : les types de boutons, boutons de base, paires ; options
ns.AddLocale("enUS", {
    MODE = "Type:",
    TUTO_WELCOME_TEXT = "This addon lets you choose what every button of your controller does: the extra buttons (back paddles, extra triggers: GameSir, Xbox Elite, DualSense Edge, SCUF...) and the base buttons LT, RT, LB and RB.\n\n|cffffd100The idea: layers.|r On their own, A, B, X, Y and the D-pad cast 8 actions. Hold a button (LT, RT, a paddle...) and those same 8 buttons cast 8 other actions: that is a new layer. Every button you hold gives one.\n\nThis tutorial takes about two minutes. You can leave at any time and reopen it with |cffffd100/mgir tuto|r.",
    TUTO_CONTROLLER_TITLE = "Your controller",
    TUTO_CONTROLLER_TEXT = "Pick your controller: the addon then uses the names of its extra buttons and tells you which software sets them up. A standard Xbox or PlayStation controller with no extra buttons? Pick it too: you can still set up LT, RT, LB and RB. Not in the list? Pick |cffffd100Other controller|r (up to 6 buttons, which you can rename).",
    TUTO_TYPES_TITLE = "The 4 button types",
    TUTO_TYPES_TEXT = "Each button gets a type, which says what it does. You pick it in the next steps, and at any time in the |cffffd100Buttons|r tab (hover a type to read its explanation again).",
    TYPE_MODIFIER_HOW = "Hold it, then press A, B, X, Y or the D-pad: a layer of 8 actions. On its own, it does nothing.",
    TYPE_MODIFIER_FOR = "For: buttons that are easy to keep pressed. Default for LT and RT, like in the game.",
    TYPE_TARGET_HOW = "A short press targets the nearest ally (or enemy); hold it and aim with the right stick to pick another one. Held with A, B, X, Y or the D-pad: 8 shortcuts, like a modifier.",
    TYPE_TARGET_FOR = "For: heals and spells cast on a target. Default for LB (ally) and RB (enemy), like in the game.",
    TYPE_SIMPLE_HOW = "One press casts one action. With LT or RT held, it casts another one. It also has a slot in each modifier layer.",
    TYPE_SIMPLE_FOR = "For: a spell you cast often, a potion, a mount.",
    TYPE_OFF_HOW = "The button does nothing: its key stays free for something else.",
    TYPE_OFF_FOR = "For: extra buttons you do not use (base buttons do not have this type).",
    TUTO_SOFTWARE_TITLE = "Make the extra buttons send a key",
    TUTO_DETECT_TITLE = "Detect your extra buttons",
    TUTO_DETECT_MISSING = "Nothing happens when you press? Check the button's key in your controller's software, then try again.",
    TUTO_MODES_TITLE = "The type of your extra buttons",
    TUTO_MODES_TEXT = "Pick a type for each extra button (hover a type to read what it does).\nTip: modifiers on the buttons easiest to hold, simple buttons on the others. |cffffd100Use the suggested types|r does it for you.",
    TUTO_SUGGESTED = "Use the suggested types",
    TUTO_PADS_TITLE = "Your base buttons: LT, RT, LB, RB",
    TUTO_PADS_TEXT = "By default (in green), they work like in the game: LT and RT are modifiers, LB targets allies and RB enemies. The actions of the game's controller bar are copied into their layers. You can change them: for example RB as a simple button, or LB as a modifier.",
    TUTO_PADS_DEFAULT = "Back to the default types",
    TUTO_PAIRS_TITLE = "Pairs: two buttons held together",
    TUTO_PAIRS_TEXT = "Hold two buttons together (modifiers or targeting): yet another layer of 8 actions. Any two can make a pair: L5 + R5, LT + RT, LB + LT... Tick the ones you want (you can change them later in the |cffffd100Buttons|r tab). By default: the left + right pairs.",
    TUTO_ACTIONS_TITLE = "Place your actions",
    TUTO_ACTIONS_TEXT = "In the |cffffd100Layers|r tab: on the left, all your layers (Alone, LT, RT, your modifiers and pairs); on the right, the chosen layer, laid out like the controller.\n\n- Drag a spell from your spellbook, an item from your bags, a macro, a mount or a toy onto a slot.\n- Or click a slot: pick a spell or an item, write a macro, pick a WoW command (Auto run...) or a basic action (Jump, Interact...). Right-click: clear.\n- The row under the D-pad holds your simple buttons' slots in that layer.\n\nYou can also click a layer thumbnail on the HUD to edit it right there.\n\nActions are saved per character; types and keys in the profile, for the whole account. Everything works in combat; only changes made in combat wait for it to end.\n\n|cffffd100Handy|r:\n- The field at the top of the list searches an action in all your layers.\n- |cffffd100Smart consumable|r (slot menu): your best potion, food, drink or bandage, updated on its own.\n- A greyed, red spell: this character does not know it. |cffffd100Templates and specs...|r can remove them.\n- A new rank learned from your class trainer: the addon offers to put it in place of the old one, everywhere.",
    TUTO_HUD_TEXT = "The addon replaces the game's controller bar with its own HUD. Pick its layout below: the HUD changes right away, and you can switch at any time (|cffffd100HUD|r tab, or the HUD's small button).\n\nWhen the mouse is over the HUD, small buttons appear: the |cffffd100padlock|r unlocks it to move it with the mouse (and locks it again), another one switches the layout, and the |cffffd100gear|r opens the HUD tab for finer settings (size, miniatures...).",
    TUTO_DONE_TEXT = "Open the configuration to place your first actions.\n\n|cffffd100/mgir|r: open the configuration\n|cffffd100/mgir test|r: controller test, to see what WoW receives\n|cffffd100/mgir tuto|r: this tutorial\n|cffffd100/mgir reset|r: clear this character's actions\n|cffffd100/mgir restore|r: give LT, RT, LB and RB back to the game\n|cffffd100/mgir rangs|r: put the new ranks of your spells in place of the old ones",
    SETTINGS_DESC = "Choose what every button of your controller does: extra buttons (back paddles, extra triggers) and base buttons (LT, RT, LB, RB). Command: /mgir",
    BUTTONS_INTRO = "Pick a type for each button: hover a type to see what it does. In green: the default type of the base buttons, which works like the game.",
    BUTTONS_TYPES_HELP = "The button types",
    PAIRS_HINT = "Tick the pairs you want: holding both buttons together gives 8 more actions. Any two modifiers or targeting buttons can form a pair (L5 + LT, LB + RT...).",
    PAIRS_NONE = "Set at least two buttons as Modifier, Ally target or Enemy target to form pairs.",
    PAIR_WAITS = "%s is on Game: set it to Modifier, Ally target or Enemy target (above)",
})

-- Tutoriel, paires : appuyer sur les boutons pour les trouver
ns.AddLocale("enUS", {
    TUTO_PAIRS_PRESS = "Press a button on your controller: its pairs light up in green. Press two buttons together: their pair lights up.",
})

-- LB + LT et RB + RT : l'action de classe de Forever
ns.AddLocale("enUS", {
    PAIR_CLASS_WARN = "also triggers Forever's class action",
    PAIR_CLASS_WARN_LONG = "Warning: %s also triggers Forever's class action (often a spell wheel, which takes over A, B, X and Y while it is open; B closes it). The addon cannot prevent it: better pick another pair.",
    PAIR_CLASS_NOTE = "%s and %s also trigger Forever's class action (often a spell wheel that takes over A, B, X and Y). The addon cannot prevent it: better pick other pairs.",
})

-- Forever resté sur sa barre LT / RT
ns.AddLocale("enUS", {
    FOREVER_STUCK = "Forever stayed on its %s bar (a button release went missing). Press %s once to bring it back to \"Alone\".",
    HUD_STUCK = "%s stuck: press %s once",
    HUD_GRID_RECALL_DETACH = "Separated from the grid",
    TIP_HUD_GRID_RECALL_DETACH = "The reminder leaves the grid: you can place it wherever you want (HUD padlock, then drag).",
    HUD_GRID_RECALL = "Show the layer in use in large on top",
    TIP_HUD_GRID_RECALL = "Above the grid and centered, the layer you are using in large, each tile with its button. That layer's row in the grid then stays small (gold border).",
    HUD_STYLE_LABEL = "HUD layout:",
    HUD_STYLE_GRID = "Grid",
    HUD_STYLE_PAD = "Controller",
    TIP_HUD_STYLE_GRID = "One row per layer, buttons always in the same order: the D-pad, then X, Y, B, A (left, top, right, bottom), then simple buttons. The layer in use in large on top, and in gold in the grid.",
    TIP_HUD_STYLE_PAD = "Like the controller: the layer in use in large (D-pad on the left, A/B/X/Y on the right, simple buttons in the center), every layer in miniature.",
    HUD_SECTION_GRID = "Layer grid",
    HUD_GRID_SIZE = "Grid size:",
    HUD_GRID_COLS = "Layer columns:",
    TIP_HUD_GRID_SIZE = "The size of the grid. \"Size\" (below) scales the whole HUD.",
    TIP_HUD_GRID_COLS = "How many columns to spread the layer rows over: more columns make a wider, shorter grid.",
    HUD_TOOL_TO_GRID = "Switch the HUD to the grid layout",
    HUD_TOOL_TO_PAD = "Switch the HUD to the controller layout",
    HUD_ROW_HINT = "Click: enlarge this layer to edit it",
    HUD_ROW_DRAG = "Drag: move it (onto another row)",
    TUTO_HUD_GRID_NAME = "Grid (recommended)",
    TUTO_HUD_GRID_DESC = "One row per layer, buttons always in the same order, in their color at the top of each column: the D-pad, then X, Y, B, A (left, top, right, bottom: the same place for both thumbs), then your simple buttons. On top, the reminder shows the layer you use in large; its row turns gold. Click a tile to edit it, a row's name to enlarge it; drag that name to change the order. HUD tab: size, number of columns, reminder (which can be separated from the grid and placed anywhere).",
    TUTO_HUD_PAD_NAME = "Controller",
    TUTO_HUD_PAD_DESC = "Like the controller: the layer you use in large, D-pad on the left, A/B/X/Y on the right, your simple buttons in the center with the action they will cast. Every layer in miniature below: click one to edit it.",
    WHATSNEW_1_4_0 = "• |cffffd100Grid HUD|r: a new layout, one row per layer, buttons always in the same order, in their color at the top of each column: the D-pad, then X, Y, B, A (left, top, right, bottom), then simple buttons. On top, the reminder shows the layer in use in large; in the grid, it turns gold. Every tile can be edited directly; click a row's name to enlarge it, drag it to change the order.\n• HUD tab: grid size, number of columns (1 to 3), reminder shown or not, and separated from the grid to place it anywhere. Your HUD keeps its current layout: switch to the grid in the HUD tab (\"HUD layout\") or with the HUD's small button.\n• |cffffd100Stuck layer in red|r: when the game's LT / RT bar stays stuck, the HUD shows that layer in red with the button to press to free it.",
})

-- 1.1.0 : spés, état des actions sur le HUD, profils, remplissage rapide, rapport
ns.AddLocale("enUS", {
    SPEC_NUMBER = "Specialization %d",
    SPEC_SWITCHED = "Actions of the \"%s\" specialization.",
    SPEC_NEW = "New specialization \"%s\": it starts with a copy of the previous one's actions.",
    PROFILE_PER_CHAR = "Remember each character's profile",
    PROFILE_PER_CHAR_DESC = "On login, each character goes back to the last profile it used. Without this option, they all take the last profile used on the account.",
    REPORT_BUTTON = "Copy a report",
    REPORT_TITLE = "Controller report",
    REPORT_HINT = "First press every button in the controller test, then copy this text (Ctrl+C) and send it to the addon's author, with what works and what doesn't. It helps confirm the settings of other controllers. No character or realm name is included.",
    WHATSNEW_TITLE = "What's new in My Gamepad Is Rich",
    QUICKFILL_BUTTON = "Fill empty slots",
    QUICKFILL_DESC = "Places your hearthstone, equipped usable trinkets and bag consumables (potions, food, bandages, elixirs...) in this layer's empty slots, except those already there. Right-click a slot to clear it.",
    QUICKFILL_DONE = "%d slot(s) filled.",
    QUICKFILL_NONE = "Nothing to place: no usable item found in your bags that isn't already on this layer.",
})

-- 1.1.0 : modèles de classe, copie de couches, verrou, annulation, véhicules
ns.AddLocale("enUS", {
    SLASH_HELP = "/mgir : open  |  /mgir profile <name> : switch profile  |  /mgir test : controller test  |  /mgir tuto : tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : reset this character's actions  |  /mgir undo : undo the last change of actions  |  /mgir rangs: replace lower spell ranks",
    LEARN_PAD_REFUSED = "%s is a base controller button: the addon combines or configures it itself. Press the extra button (the key its software sends).",
    RESET_CONFIRM = "Clear all of this character's actions in the current profile?",
    RESET_CONFIRM_SPEC = "Clear all of this character's actions for the \"%s\" specialization, in the current profile?",
    UNDO_HINT = "/mgir undo to go back.",
    UNDO_DONE = "Actions restored as they were before the last change.",
    UNDO_NONE = "Nothing to undo for this specialization.",
    ACTION_COUNT = "%d action(s)",
    LAYER_COPY_BUTTON = "Copy / swap...",
    LAYER_COPY_DESC = "Copy this layer's actions to another layer, or swap the actions of the two layers (the 8 slots and the simple buttons' slots).",
    LAYER_COPY_TITLE = "Layer %s",
    LAYER_COPY_TO = "Copy to",
    LAYER_SWAP_WITH = "Swap with",
    LAYER_COPY_NONE = "No other combo layer: first make another button a modifier.",
    LAYER_COPY_CONFIRM = "Replace the actions of the %s layer (%d) with those of %s?",
    LAYER_COPIED = "%s copied to %s.",
    LAYER_SWAPPED = "%s and %s swapped.",
    TPL_BUTTON = "Templates and specs...",
    TPL_DESC = "Class templates: save this specialization's actions for the whole account, then load them on another character of the same class. You can also copy the actions of another specialization. Actions kept on the game bar are not included.",
    TPL_TITLE = "Templates and specializations",
    TPL_SECTION_SAVE = "Save",
    TPL_SAVE = "Save these actions as a template...",
    TPL_SECTION_LOAD = "Load a template (%s)",
    TPL_SECTION_SPEC = "Copy from a specialization",
    TPL_SECTION_DELETE = "Delete a template",
    TPL_SAVE_PROMPT = "Template name (for every %s of the account):",
    TPL_SAVED = "Template \"%s\" saved for %s.",
    TPL_REPLACE_CONFIRM = "Replace the template \"%s\"?",
    TPL_LOAD_CONFIRM = "Load the template \"%s\"? It replaces the actions of %s.",
    TPL_LOADED = "Template \"%s\" loaded.",
    TPL_DELETE_CONFIRM = "Delete the template \"%s\" for every character of this class?",
    TPL_DELETED = "Template \"%s\" deleted.",
    SPEC_COPY_CONFIRM = "Copy the actions of \"%s\"? They replace the actions of %s.",
    SPEC_COPIED = "Actions of \"%s\" copied.",
    LATCH = "Latching",
    LATCH_DESC = "One press turns this modifier's layer on, the next press turns it off: no need to hold it. Another modifier held takes over while it is held. Any settings change releases the latch. Extra buttons only (not LT, RT, LB, RB).",
})

-- 1.1.0 : notes de version (tout ce qui a changé depuis la 1.0.0)
ns.AddLocale("enUS", {
    WHATSNEW_1_1_5 = "• Friendly / enemy target: in combat, the button no longer stays held after you release it (the HUD stayed on its layer and the stick kept aiming). A short press still moves to the next target, and a long press keeps the target you aimed at.",
    WHATSNEW_1_1_4 = "• Friendly / enemy target: each short press moves to the next target, even when you already have one, including where the game does not give the addon the time. A long press keeps the target you aimed at with the stick.\n• /mgir etat tells how a short press is detected.",
    WHATSNEW_1_1_3 = "• Friendly / enemy target: the target you aim at with the stick stays when you release the button. Only a short press targets the nearest one.",
    WHATSNEW_1_1_2 = "• A WoW command or a hand-written macro can use the icon of your choice: click the slot, \"Change icon...\". The search finds the icons of your spells, your items and WoW commands, or an icon by its file name (as on Wowhead: inv_misc_map_01).\n• Common commands have their own icon instead of the key: world map, bags, spellbook, quest log, character, achievements, group finder, collections.",
    WHATSNEW_1_1_1 = "• Simple button: an empty layer (LT, RT or a modifier) now does nothing and stays empty on the HUD, instead of using the \"Alone\" action. Only exception: a WoW command set on \"Alone\".\n• The spell list now includes profession spells: Find Herbs, Find Minerals, Fishing, Cooking, Archaeology…",
    WHATSNEW_1_1_0 = "• HUD: the addon's actions look like the game's bars. Red out of range, blue without enough resource, grey when unusable, golden edge during a proc, remaining charges, lit while active (auto attack, form...).\n• HUD: choose the order of the layer miniatures (arrows in the HUD tab, or drag a miniature onto another one).\n• Each specialization has its own actions. A new spec starts with a copy of the previous one's actions.\n• Actions tab: \"Fill empty slots\" places your hearthstone, trinkets and bag consumables on a modifier layer, and \"Copy / swap...\" copies a combo layer to another one, or swaps two layers.\n• Class templates: save your actions for the whole account, then load them on another character of the same class (\"Templates and specs...\" under the layer list). You can also copy the actions of another specialization.\n• Latching modifier (Buttons tab): one press turns the layer on, the next press turns it off.\n• /mgir reset asks for confirmation, and /mgir undo goes back after a reset, a template, a spec copy or a layer copy.\n• Profiles: \"Remember each character's profile\" option.\n• Stuck layers: a base button given to the addon stays with whoever got the press until it is released, and Forever no longer stays stuck on its RT (or LT) bar, for example after a spell cast with RT + A such as a paladin seal.\n• Vehicles, override bars and pet battles: the addon steps aside and the game's buttons work, in combat too.\n• No more /mgir restore before disabling the addon: on every logout, LT and LB get their Shift / Ctrl imitation back, and the addon cuts it again on login.\n• Detect refuses A, B, X, Y, the D-pad and LT, RT, LB, RB (pressed by mistake, they would become an extra button's key).\n• Controller test tab: \"Copy a report\" (with the recent layer log), to send and help confirm other controllers. /mgir etat shows the state of the layers.\n• /mgir news: show this window again.",
})

-- Marqueurs de raid (actions de base)
ns.AddLocale("enUS", {
    GAME_markquick = "Quick marking (next marker on each press)",
    GAME_mark = "Mark: %s",
    GAME_markclear = "Remove the marker",
})

-- Se cibler (action de base)
ns.AddLocale("enUS", {
    GAME_targetself = "Target yourself",
})

-- Nouveautés de la 1.1.6
ns.AddLocale("enUS", {
    WHATSNEW_1_1_6 = "• Raid markers in the basic actions: \"Quick marking\" puts the next marker on your target at each press (skull, cross, square, moon, triangle, diamond, circle, star), each of the 8 markers, and \"Remove the marker\".\n• \"Target yourself\" in the basic actions.\n• A spell's tooltip shows its rank.\n• Friendly / enemy target: each short press now moves to the next target in Forever too, and aiming with the right stick responds right away. The target you aimed at stays if the stick is still tilted when you release the button, or after a long press.",
})

-- Nouveaux rangs (maître de classe)
ns.AddLocale("enUS", {
    UPRANK_ASK = "New rank learned: %s.\n\nReplace the lower rank in your actions?\n(%d slot(s) of the addon, %d slot(s) of the game's bars)",
    UPRANK_REPLACE = "Replace",
    UPRANK_KEEP = "Keep",
    UPRANK_DONE = "New rank placed: %d slot(s) of the addon, %d slot(s) of the game's bars.",
})

-- Confort : nouveaux rangs sans demander
ns.AddLocale("enUS", {
    COMFORT_TITLE = "Comfort",
    UPRANK_AUTO = "Replace new spell ranks without asking (lower ranks in the addon's actions and on the game's bars)",
    UPRANK_NONE = "No lower rank to replace.",
})

-- Actions de base : cible, focus, sacs, montures
ns.AddLocale("enUS", {
    GAME_targetlast = "Previous target",
    GAME_assist = "Assist the target",
    GAME_focus = "Set as focus",
    GAME_targetfocus = "Target the focus",
    GAME_follow = "Follow the target",
    GAME_openbags = "Open the bags",
    GAME_dismount = "Dismount",
    GAME_randommount = "Random favorite mount",
})

-- Sorts inconnus
ns.AddLocale("enUS", {
    SPELL_UNKNOWN = "This character doesn't know this spell (talents, another specialization, a template from another character): this slot does nothing.",
    UNKNOWN_SECTION = "Unknown spells",
    UNKNOWN_REMOVE = "Remove the unknown spells",
    UNKNOWN_CONFIRM = "Remove %d spell(s) this character doesn't know from the actions of %s?",
    UNKNOWN_REMOVED = "%d unknown spell(s) removed.",
})

-- Recherche d'une action (onglet Actions)
ns.AddLocale("enUS", {
    SEARCH_HINT = "Find an action",
    SEARCH_DESC = "Type part of a name (spell, item, macro...): the layers that hold it show how many slots, and those slots get a gold border.",
})

-- Consommables intelligents
ns.AddLocale("enUS", {
    MENU_BEST = "Smart consumable...",
    BEST_TITLE = "Smart consumables",
    KIND_best = "Smart consumable",
    BEST_heal = "Best healing potion",
    BEST_mana = "Best mana potion",
    BEST_food = "Best food",
    BEST_drink = "Best drink",
    BEST_bandage = "Best bandage",
    BEST_NONE = "None in your bags",
    BEST_DESC = "Uses the best item of this kind in your bags; when a stack runs out, the next one (in combat too). The list follows your bags out of combat.",
})

-- Vibrations
ns.AddLocale("enUS", {
    VIBRATION_OPTION = "Controller vibrations (lockable modifier on / off, long press recognized, new rank placed)",
})

-- Bouton simple : sa case dans chaque couche de modificateur
ns.AddLocale("enUS", {
    SIMPLE_MOD_ROW = "With a modifier held (empty: does nothing)",
})

-- HUD : couches séparées, en colonne
ns.AddLocale("enUS", {
    HUD_LAYERS_LABEL = "Layers:",
    HUD_DETACH = "Separate from the HUD",
    HUD_VERTICAL = "In columns",
    HUD_STRIP_COLS = "Miniature columns:",
    HUD_TOOL_VERTICAL = "Layers in columns",
    HUD_TOOL_HORIZONTAL = "Layers in rows",
})

-- HUD : cadenas (verrouiller / déverrouiller)
ns.AddLocale("enUS", {
    HUD_TOOL_UNLOCK = "Unlock: move the HUD with the mouse",
    HUD_TOOL_LOCK = "Lock the HUD (drag it where you want first)",
    HUD_TOOL_LOCK_DETACHED = "Lock the HUD (drag the HUD and the layers first, each to its place)",
    HUD_UNLOCKED_HINT = "Unlocked: drag with the mouse (separated layers move on their own). Click the padlock to lock.",
})

-- HUD : bouton vers l'onglet HUD
ns.AddLocale("enUS", {
    HUD_TOOL_SETTINGS = "HUD settings (HUD tab): layout, size, miniatures...",
})

-- HUD : miniatures des couches cachées
ns.AddLocale("enUS", {
    HUD_HIDE_STRIP = "Hidden",
})

-- Onglets réorganisés : Options, sections, Aide en sections, info-bulles
ns.AddLocale("enUS", {
    TAB_OPTIONS = "Options",
    ACTIONS_INTRO = "What each button casts. Pick a layer on the left, then put your actions on its slots on the right.",
    OPTIONS_INTRO = "The addon's general settings: what is neither a button, nor a layer, nor the HUD display.",
    OPTIONS_SECTION_UI = "Interface",
    HUD_SECTION_STRIP = "Layer miniatures",
    HUD_SECTION_PLACE = "HUD size and position",
    HUD_LAYOUT_LABEL = "Layout:",
    TEST_OPEN = "Test my controller",
    TEST_BACK = "Back to buttons",
    HELP_INTRO = "Pick a topic on the left. The tutorial goes through everything step by step.",
    HELP_PRINCIPLE = "The principle",
    HELP_COMMANDS = "Commands",
    TIP_CONTROLLER = "Pick your controller: the addon uses the names of its extra buttons.",
    TIP_TYPES = "See again what each button type does: modifier, target, simple button, none.",
    TIP_DETECT = "Then press the button on your controller: the addon remembers the key it sends.",
    TIP_CLEAR = "Forget this button's key: it no longer does anything.",
    TIP_TEST = "See live what WoW receives from each button: useful when a button does not respond.",
    TIP_REPORT = "A text to send to the author if something goes wrong (no character or realm name).",
    TIP_PROFILE_USE = "This profile becomes the one in use: its controller, its buttons and this character's actions.",
    TIP_PROFILE_NEW = "An empty profile, for example for another controller.",
    TIP_PROFILE_COPY = "A new profile, a copy of the selected one, to try changes safely.",
    TIP_PROFILE_RENAME = "Change the name of the selected profile.",
    TIP_PROFILE_DELETE = "Delete the selected profile, with the actions of all your characters for this profile.",
    TIP_PROFILE_EXPORT = "A text to copy, to share this profile or keep it aside.",
    TIP_PROFILE_IMPORT = "Paste the text of an exported profile (yours or another player's).",
    TIP_HUD_DETACH = "The miniatures leave the HUD: you can place them anywhere (HUD padlock, then drag).",
    TIP_HUD_VERTICAL = "The miniatures stack in columns instead of a row.",
    TIP_HUD_HIDDEN = "No more miniatures: the HUD only shows the current layer. Layers are edited in the Layers tab.",
    TIP_HUD_ROWS = "How many rows (or columns) the miniatures are spread over.",
    TIP_HUD_STRIP_SIZE = "The size of the miniatures, without changing the rest of the HUD.",
    TIP_HUD_SIZE = "The size of the whole HUD.",
    TIP_HUD_MOVE = "Unlock the HUD to drag it with the mouse (like the HUD padlock). Click again to lock it.",
    TIP_HUD_RESET = "Put the HUD back to its original place and size (separated miniatures come back under it).",
    TIP_UPRANK = "When you learn a new rank of a spell, it replaces the old one everywhere without asking.",
    TIP_VIBRATION = "A short vibration when a lockable modifier turns on or off, and when a new rank is placed.",
    TIP_MINIMAP = "The button around the minimap: click to open the settings, right-click to move the HUD.",
})

-- Nouveautés 1.2.0, et l'encart « donne ton avis »
ns.AddLocale("enUS", {
    WHATSNEW_1_2_0 = "• The window is reorganized in setup order: Buttons, Layers (the former Actions tab), HUD, Options, Profiles, Help. Every setting has a tooltip, Help has a table of contents, and the controller test opens from the Buttons tab.\n• New spell ranks: when you learn one, the addon offers to replace the old one everywhere (or does it on its own, Options tab). /mgir rangs checks the whole spellbook.\n• Smart consumables (slot menu): your best potion, food, drink or bandage, updated on its own.\n• Spells this character does not know are shown in red; \"Templates and specs...\" can remove them.\n• A field searches an action in all your layers.\n• New basic actions: previous target, assist, focus, follow, open bags, dismount, random favorite mount.\n• HUD: small buttons on mouseover (padlock to move it, row or column, settings); the miniatures can be separated from the HUD, in columns or hidden. The HUD is always shown.\n• A, B, X and Y of \"Alone\" show the game's action, and a simple button's page shows its slot in each modifier.\n• Controller vibrations, if the game allows them.",
    WHATSNEW_FEEDBACK = "A bug, an idea, something annoying? Tell me: every piece of feedback helps improve the addon. Copy this link (Ctrl+C) to write on GitHub:",
})

-- 1.3.0: cast target, context action, cycle action, configuration check,
-- HUD comfort
ns.AddLocale("enUS", {
    MENU_UNIT = "Cast on...",
    MENU_COND = "Context action...",
    MENU_SEQ = "Cycle action...",
    MENU_PICKUP_CAST = "Or drop a spell or an item here",
    SLOT_KIND_REFUSED = "Only a spell or an item can go here.",
    KIND_cond = "Context action",
    KIND_seq = "Cycle action",

    UNIT_TITLE = "Cast on",
    UNIT_target = "The target (usual)",
    UNIT_CURRENT = "chosen",
    UNIT_player = "Me",
    UNIT_helpself = "The targeted ally, otherwise me",
    UNIT_focus = "The focus",
    UNIT_targettarget = "My target's target",
    UNIT_pet = "My pet",
    UNIT_party = "Party member %s",
    UNIT_TIP = "Cast on: %s",

    COND_TITLE = "Context action",
    COND_HELP = "One slot, two actions: the first one fires if the condition is true, the second one otherwise. One of the two can stay empty.",
    COND_IF = "Condition:",
    COND_THEN = "If yes",
    COND_ELSE = "Otherwise",
    COND_NOTHING = "Nothing",
    COND_NEED_ACTION = "Place at least one spell or item.",
    COND_TIP_IF = "%s: %s",
    COND_TIP_ELSE = "Otherwise: %s",
    COND_combat = "In combat",
    COND_mounted = "Mounted",
    COND_stealth = "Stealthed",
    COND_harm = "My target is an enemy",
    COND_help = "My target is an ally",
    COND_exists = "I have a target",
    COND_pet = "I have a pet",
    COND_group = "In a group",
    COND_swimming = "Swimming",
    COND_indoors = "Indoors",
    COND_stance = "Form or stance %d",

    SEQ_TITLE = "Cycle action",
    SEQ_HELP = "2 to 4 spells or items: each press casts the next one, then it starts over. The game only moves on when the spell was cast.",
    SEQ_RESET = "Back to the first:",
    SEQ_RESET_none = "Only after the last one",
    SEQ_RESET_target = "On target change",
    SEQ_RESET_combat = "When combat ends",
    SEQ_RESET_both = "Target change or end of combat",
    SEQ_RESET_seconds = "After %d s without a press",
    SEQ_NEED_TWO = "Place at least two spells or items.",
    SEQ_TIP_RESET = "Back to the first: %s",

    GAME_mounttoggle = "Mount / dismount",
    GAME_targetpet = "Target my pet",
    GAME_sheet = "Show the layer cheat sheet",
    GAME_partynext = "Next party ally (me, then each member)",
    GAME_targetparty = "Target party member %d",

    CHECK_BUTTON = "Check my configuration",
    TIP_CHECK = "Looks for what keeps a button or a slot from working: button without a key, deleted macro, unknown spell, incomplete pair... Each line offers to fix it or to go there.",
    CHECK_TITLE = "Configuration check",
    CHECK_ALL_GOOD = "All set: nothing to fix.",
    CHECK_SUMMARY = "%d item(s) to fix, %d note(s).",
    CHECK_FIX = "Fix",
    CHECK_GO = "Go there",
    CHECK_AGAIN = "Check again",
    CHECK_CLEAR = "Clear the slot",
    CHECK_CLEARED = "Slot cleared.",
    CHECK_REMOVE = "Remove",
    CHECK_REPLACE = "Replace",
    CHECK_UNCHECK = "Uncheck",
    CHECK_NO_KEY = "%s has no key: it does nothing. Click \"Detect\" in the Buttons tab, or set it to \"Disabled\".",
    CHECK_SAME_KEY = "%s and %s have the same key (%s): only one of them works.",
    CHECK_PAIR_HALF = "The pair %s is checked, but %s is not a modifier: it does not work.",
    CHECK_MACRO_GONE = "%s: the macro \"%s\" no longer exists in the game. The slot does nothing.",
    CHECK_SET_GONE = "%s: the equipment set \"%s\" no longer exists. The slot does nothing.",
    CHECK_COMPOSED_EMPTY = "%s: this action has no valid spell or item left. The slot does nothing.",
    CHECK_ITEM_GONE = "%s: %s is neither in your bags nor equipped.",
    CHECK_UNKNOWN = "%d slot(s) hold a spell this character does not know: they do nothing.",
    CHECK_LOWER_RANKS = "%d slot(s) hold a lower rank of a spell you know at a higher rank.",
    CHECK_EMPTY_BUTTON = "%s has no action.",
    CHECK_TAP_SAFE = "This game cannot measure how long a press lasts: a targeting button only changes target when you do not already have a valid one.",
    HUD_IDLE_ALPHA = "Opacity at rest:",
    TIP_HUD_IDLE_ALPHA = "The HUD opacity out of combat, when no button is held. At 0%, it is hidden: it comes back in combat, when you hold a button, or under the mouse.",
    SHEET_BUTTON = "Layer cheat sheet",
    TIP_SHEET = "Shows all your layers, large, in the middle of the screen, to learn your shortcuts. Also with /mgir map, or the basic action \"Show the layer cheat sheet\" placed on a slot.",
    SHEET_TITLE = "Cheat sheet: all your layers",
    SHEET_HINT = "Escape or /mgir map to close. The layer in use has a golden border.",

    TUTO_ACTIONS_MORE = "\n|cffffd100Going further|r (a slot's menu):\n- |cffffd100Cast on...|r: the spell or item goes to you, the focus, your target's target, your pet or a party member. The slot shows an \"@\".\n- |cffffd100Context action...|r: two actions and a condition (in combat, mounted, form...). The first one fires if the condition is true, the second one otherwise. The slot shows a \"/\".\n- |cffffd100Cycle action...|r: 2 to 4 spells or items, the next one on each press. The slot shows the step (\"2/3\").\n- |cffffd100Basic action|r: \"Next party ally\" goes from you to each party member; \"Target party member\" picks one directly. The game does not let an addon choose the most injured ally.\n\nA button or a slot does not work? |cffffd100Check my configuration|r (Buttons tab, or /mgir check) tells you why.",
    TUTO_HUD_MORE = "\n|cffffd100HUD tab|r:\n- |cffffd100Opacity at rest|r: how visible the HUD is out of combat; at 0%, it is hidden and comes back in combat or when you hold a button.\n- |cffffd100Layer cheat sheet|r (or /mgir map): all your layers, large, in the middle of the screen.",
    HELP_COMMANDS_MORE = "|cffffd100/mgir check|r: check the configuration\n|cffffd100/mgir map|r: cheat sheet of all the layers",
    SLASH_HELP_MORE = "/mgir check: check the configuration  |  /mgir map: layer cheat sheet",
    WHATSNEW_1_3_0 = "• Cast on... (a slot's menu): a spell or an item goes to you, the focus, your target's target, your pet or a party member, without writing a macro.\n• Context action: one slot, two actions and a condition (in combat, mounted, stealthed, form, enemy or ally target...).\n• Cycle action: 2 to 4 spells or items on one slot, the next one on each press.\n• New basic actions: next party ally, target party member 1 to 4, target your pet, mount / dismount, cheat sheet.\n• Check my configuration (Buttons and Help tabs, /mgir check): the list of what keeps a button or a slot from working, with a way to fix it.\n• HUD: adjustable opacity at rest (down to hidden out of combat) and a cheat sheet of all your layers (/mgir map).",
})
