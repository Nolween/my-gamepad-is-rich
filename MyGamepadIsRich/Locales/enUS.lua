-- English (reference: every key exists here; other languages fall back to it)
local _, ns = ...

ns.AddLocale("enUS", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "Buttons",
    TAB_TEST = "Controller test",
    TAB_HELP = "Help",

    EXTRA = "Button",
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
    LEARN_MODKEY = "Warning: %s is a Shift / Ctrl / Alt key; in GameSir Nexus, prefer a key like F9-F12.",
    LEARN_BOUND = "Note: %s was bound to \"%s\" in WoW; while this addon uses it, the addon wins.",

    TEST_INTRO = "Press any button: what WoW receives lights up. If L5 / R5 / L4 / R4 show nothing, map them to keyboard keys in GameSir Nexus (see Help).",
    TEST_STANDARD = "Standard buttons",
    TEST_EXTRA = "Extra buttons",
    TEST_LOG = "Last inputs",
    TEST_GAME = "game",
    TEST_UNKNOWN = "not assigned",

    IF_WARNING = "Improved Forever is loaded: if it also uses one of these keys, the last applied binding wins.",
    OPEN_CONFIG = "Open the configuration",
    SETTINGS_DESC = "Configure the extra buttons of your GameSir G7 Pro (L5/R5, L4/R4). Command: /mgir",
    LOADED = "loaded. Type /mgir to configure your extra buttons.",
    SLASH_HELP = "/mgir : open  |  /mgir test : controller test  |  /mgir tuto : tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : reset this character's actions",
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
    TUTO_WELCOME_TEXT = "This addon brings the extra buttons of your GameSir G7 Pro into WoW:\n\n"
        .. "|cffffd100L5 / R5|r: the third triggers\n"
        .. "|cffffd100L4 / R4|r: the back paddles\n\n"
        .. "Each one can be a held modifier (8 new combos with A, B, X, Y and the D-pad), "
        .. "or a simple button with its own LT and RT layers.\n\n"
        .. "This tutorial takes about two minutes. You can leave it at any time and open it again with |cffffd100/mgir tuto|r.",

    TUTO_NEXUS_TITLE = "Step 1: GameSir Nexus",
    TUTO_NEXUS_TEXT = "Windows sees the G7 Pro as an Xbox 360 controller. That mode only carries the standard buttons, "
        .. "so WoW never receives L5, R5, L4 and R4. The fix is to make them send a keyboard key.\n\n"
        .. "1. Plug in the controller and open |cffffd100GameSir Nexus|r (Microsoft Store).\n"
        .. "2. Open the button mapping page.\n"
        .. "3. Give L5, R5, L4 and R4 a keyboard key you don't use in WoW. Good choices: |cffffd100F9, F10, F11, F12|r, "
        .. "or the numeric keypad (with Num Lock on).\n"
        .. "4. Avoid Shift, Ctrl and Alt: they would change your other bindings.\n"
        .. "5. Save the profile to the controller.\n\n"
        .. "Done? Go to the next step.",

    TUTO_DETECT_TITLE = "Step 2: Detect your buttons",
    TUTO_DETECT_TEXT = "For each button, click |cffffd100Detect|r, then press that button on your controller. "
        .. "The key it sends appears next to it.",
    TUTO_DETECT_ALL = "|cff40ff40All four buttons are detected.|r",
    TUTO_DETECT_MISSING = "Nothing happens when you press a button? Check its key in GameSir Nexus, then try again.",

    TUTO_MODES_TITLE = "Step 3: Choose a mode",
    TUTO_MODES_TEXT = "|cffffd100Modifier|r: hold the button, then press A, B, X, Y or the D-pad. 8 actions per button, like LT and RT.\n"
        .. "|cffffd100Simple button|r: one action, plus one with LT held and one with RT held.\n"
        .. "|cffffd100Disabled|r: the key is left free.\n\n"
        .. "Suggested: modifiers on L5 and R5 (easy to hold), simple buttons on L4 and R4.",

    TUTO_ACTIONS_TITLE = "Step 4: Place your actions",
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
    TUTO_HUD_TEXT = "The addon replaces the game's controller bar with its own HUD at the bottom of the screen:\n\n"
        .. "- |cffffd100Large|r: the layer you are using, D-pad on the left, A/B/X/Y on the right. Hold LT, RT, L5 or R5 and it switches.\n"
        .. "- |cffffd100In the strip|r (below, or above with /mgir hud strip): every layer in miniature (Alone, LT, RT, LT+RT, L5, R5); the one you hold lights up.\n"
        .. "- |cffffd100In the middle|r: L4 and R4, with the action that will fire for the trigger you hold.\n\n"
        .. "It fades out of combat while you hold nothing.\n"
        .. "|cffffd100/mgir hud|r: move it  -  |cffffd100/mgir hud scale 1.2|r: size  -  |cffffd100/mgir hud off|r: back to the game's bar",
})

-- HUD : attribution rapide
ns.AddLocale("enUS", {
    HUD_COMBAT = "Actions can't be changed in combat.",
    HUD_GAME_SLOT = "This button keeps the game's own action (jump, interact...).",
    HUD_KIND = "The game's bar only takes spells, items, mounts and macros from the macro list.",
    HUD_EDITING = "Editing this layer: click a tile to set it, right-click to clear it. Click the miniature again to go back.",
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

-- Paires de modificateurs (L5 + R5, L4 + R4)
ns.AddLocale("enUS", {
    PAIR_READY = "Pair · hold both",
    PAIR_NOT_READY = "Pair · not available",
    PAIR_DESC = "Hold %s and %s together, then press A, B, X, Y or the D-pad: 8 more combos.",
    PAIR_NEEDS = "To use this pair, %s and %s must both be in Modifier mode, with a key.",
    TUTO_PAIRS_TEXT = "|cffffd100Pairs|r: when L5 and R5 are both modifiers, holding them together gives 8 more combos. Same for L4 + R4.",
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
    LAYER_DESC_BASE = "A, B, X, Y and the D-pad with nothing held. A, B, X and Y keep the game's actions (jump, interact...).",
    LAYER_DESC_HOLD = "Hold %s, then press A, B, X, Y or the D-pad.",
    BUTTONS_INTRO = "Your extra buttons: the key GameSir Nexus sends, and what each one does. Hover a mode to see what it does.",
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
