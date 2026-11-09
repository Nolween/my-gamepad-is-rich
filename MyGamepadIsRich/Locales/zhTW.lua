-- 繁體中文
local _, ns = ...

ns.AddLocale("zhTW", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "按鍵",
    TAB_TEST = "手把測試",
    TAB_HELP = "說明",

    NAME = "名稱：",
    KEY = "鍵位：",
    KEY_NONE = "未設定",
    DETECT = "偵測",
    CLEAR = "清除",
    MODE_MODIFIER = "修飾鍵",
    MODE_SIMPLE = "一般按鍵",
    MODE_OFF = "停用",
    MODE_MODIFIER_DESC = "按住此鍵，再按 A、B、X、Y 或十字鍵：8 個新組合，與 LT/RT 相同。",
    MODE_SIMPLE_DESC = "一個動作，另加按住 LT 時的一個動作與按住 RT 時的一個動作。空的層不執行任何動作。",
    MODE_OFF_DESC = "此鍵不執行任何動作：其鍵位保持空閒。",
    LAYER_BASE = "單獨",
    LAYER_LT = "LT +",
    LAYER_RT = "RT +",
    SLOT_HINT = "將法術、物品、巨集或坐騎拖到格子上。右鍵：更多選項。",
    EMPTY = "空",
    NO_KEY_WARNING = "請先設定鍵位：點擊「偵測」，然後按下該按鍵。",

    MENU_SPELL = "選擇法術...",
    MENU_ITEM = "選擇背包物品...",
    SPELL_TITLE = "角色法術",
    ITEM_TITLE = "背包物品",
    ITEMS_EQUIPPED = "已裝備（可使用）",
    ITEMS_USABLE = "可使用",
    ITEMS_OTHER = "其他物品",
    LIST_EMPTY = "沒有可顯示的內容。",
    MENU_MACROTEXT = "撰寫巨集...",
    MENU_COMMAND = "WoW 指令...",
    MENU_ICON = "更換圖示...",
    ICON_TITLE = "選擇圖示",
    ICON_HINT = "依法術、物品或魔獸世界指令名稱搜尋，或輸入圖示檔名（如 Wowhead 上的 inv_misc_map_01）。",
    ICON_DEFAULT = "預設圖示",
    MENU_CLEAR = "清空",
    MENU_PICKUP_HINT = "或將法術 / 物品 / 巨集 / 坐騎放到這裡",
    MACRO_TITLE = "巨集內容",
    MACRO_HELP = "每行一條指令，例如 /cast 火球術（最多 255 個字元）",
    OK = "確定",
    CANCEL = "取消",
    COMMAND_TITLE = "WoW 指令",
    SEARCH = "搜尋：",
    COMMAND_LT_RT = "WoW 指令只能用在沒有 LT/RT 層的按鍵的「單獨」層上。",

    KIND_spell = "法術",
    KIND_item = "物品",
    KIND_toy = "玩具",
    KIND_mount = "坐騎",
    KIND_macro = "巨集",
    KIND_macrotext = "自訂巨集",
    KIND_command = "WoW 指令",
    KIND_equipset = "裝備設定",

    CURSOR_UNSUPPORTED = "這個不能放到按鍵上（只能是法術、物品、玩具、坐騎、巨集和裝備設定）。",
    APPLIED_AFTER_COMBAT = "戰鬥中：變更將在戰鬥結束後生效。",
    APPLIED = "變更已套用。",
    LEARN_PROMPT = "請按下用於 |cffffd100%s|r 的手把按鍵\n\n（Esc 取消）",
    LEARN_COMBAT = "戰鬥中無法偵測按鍵。",
    LEARN_DONE = "%s 現在對應鍵位 %s。",
    LEARN_TAKEN = "鍵位 %s 原本由 %s 使用：已從中移除。",
    LEARN_BOUND = "提示：%s 在 WoW 中綁定為「%s」；本插件使用它時，以插件為準。",

    TEST_STANDARD = "標準按鍵",
    TEST_EXTRA = "額外按鍵",
    TEST_LOG = "最近輸入",
    TEST_GAME = "遊戲",
    TEST_UNKNOWN = "未指派",

    IF_WARNING = "已載入 Improved Forever：如果它也使用這些鍵位之一，以最後套用的綁定為準。",
    OPEN_CONFIG = "開啟設定",
    LOADED = "已載入。輸入 /mgir 設定額外按鍵。",
    RESET_DONE = "此角色的動作已重設。",

    DPAD_UP = "十字鍵上",
    DPAD_DOWN = "十字鍵下",
    DPAD_LEFT = "十字鍵左",
    DPAD_RIGHT = "十字鍵右",
    PADDLE = "背鍵 %s",

    TUTO_TITLE = "教學",
    TUTO_NEXT = "下一步",
    TUTO_BACK = "上一步",
    TUTO_SKIP = "略過教學",
    TUTO_FINISH = "開啟設定",
    TUTO_REOPEN = "教學已關閉。輸入 /mgir tuto 可再次查看。",
    HELP_REPLAY = "重新觀看教學",

    TUTO_WELCOME_TITLE = "歡迎使用 My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "對每個按鍵，點擊 |cffffd100偵測|r，然後按下手把上的這個鍵。"
        .. "它送出的鍵位會顯示在旁邊。",



    TUTO_DONE_TITLE = "一切就緒",
})

-- HUD
ns.AddLocale("zhTW", {
    HUD_UNLOCKED = "HUD 已解鎖：用滑鼠拖曳。再次輸入 /mgir hud 鎖定。",
    HUD_LOCKED = "HUD 已鎖定。",
    HUD_ON = "HUD 已顯示：它取代遊戲的手把快捷列。",
    HUD_OFF = "HUD 已隱藏：遊戲的手把快捷列已恢復。輸入 /mgir hud on 重新顯示。",
    HUD_SCALE = "HUD 大小：%s",
    TUTO_HUD_TITLE = "你的手把 HUD",
})

-- HUD : attribution rapide
ns.AddLocale("zhTW", {
    HUD_COMBAT = "戰鬥中無法變更動作。",
    HUD_GAME_SLOT = "此按鍵保留遊戲內建的動作（跳躍、互動……）。",
    HUD_KIND = "遊戲快捷列只接受法術、物品、坐騎和巨集清單中的巨集。",
    HUD_EDITING = "正在編輯此層：點擊格子進行設定，右鍵清空。再次點擊縮圖，或按任意其他按鍵，即可返回。",
    HUD_TILE_HINT = "點擊：設定  -  右鍵：清空",
    HUD_CARD_HINT = "點擊：編輯此層",
})

-- HUD : bande des miniatures
ns.AddLocale("zhTW", {
    HUD_STRIP_TOP = "各層縮圖現在位於 HUD 上方。輸入 /mgir hud strip 切換。",
    HUD_STRIP_BOTTOM = "各層縮圖現在位於 HUD 下方。輸入 /mgir hud strip 切換。",
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("zhTW", {
    TUTO_STRIP_LABEL = "各層縮圖：",
    TUTO_STRIP_BOTTOM = "下方（建議）",
    TUTO_STRIP_TOP = "上方",
})

-- Bouton de la minimap
ns.AddLocale("zhTW", {
    MINIMAP_LEFT = "左鍵：開啟設定",
    MINIMAP_RIGHT = "右鍵：解鎖 / 鎖定 HUD 以便移動",
    MINIMAP_SHIFT = "Shift + 左鍵：教學",
    MINIMAP_DRAG = "拖曳：沿小地圖移動此按鈕",
    MINIMAP_HIDDEN = "小地圖按鈕已隱藏。輸入 /mgir minimap 重新顯示。",
    MINIMAP_SHOWN = "小地圖按鈕已顯示。",
})

-- Paires de modificateurs
ns.AddLocale("zhTW", {
    PAIR_READY = "組合 · 同時按住",
    PAIR_NOT_READY = "組合 · 無法使用",
    PAIR_DESC = "同時按住 %s 和 %s，再按 A、B、X、Y 或十字鍵：再多 8 個組合。",
    PAIR_NEEDS = "要使用此組合，%s 和 %s 都必須是已設定鍵位的修飾鍵模式。",
})

-- Fenêtre de configuration (onglets Actions, Boutons, HUD)
ns.AddLocale("zhTW", {
    TAB_ACTIONS = "動作",
    TAB_HUD = "HUD",
    SECTION_PAD = "手把快捷列",
    SECTION_MODS = "修飾鍵",
    SECTION_MODS_EMPTY = "尚無：請在「按鍵」分頁中把一個按鍵設為修飾鍵。",
    SECTION_SIMPLE = "一般按鍵",
    SECTION_SIMPLE_EMPTY = "尚無：請在「按鍵」分頁中把一個按鍵設為一般按鍵。",
    LAYER_DESC_BASE = "不按住任何鍵時的 A、B、X、Y 和十字鍵。這裡可以放任何東西：遊戲快捷列無法容納的（手寫巨集、WoW 指令）由插件接管。在你放入自己的動作之前，A、B、X、Y 保留遊戲的動作（跳躍、互動…）。",
    LAYER_DESC_HOLD = "按住 %s，再按 A、B、X、Y 或十字鍵。",
    PAIRS_TITLE = "組合（同時按住兩個修飾鍵）",
    HUD_INTRO = "HUD 取代遊戲的手把快捷列：正在使用的層放大顯示，所有層以縮圖顯示。",
    HUD_SHOW = "顯示 HUD（代替遊戲的手把快捷列）",
    HUD_SIZE = "大小：",
    HUD_MOVE = "移動 HUD",
    HUD_MOVE_DONE = "鎖定 HUD",
    HUD_RESET = "重設位置和大小",
    MINIMAP_SHOW = "小地圖旁的按鈕",
    GAME_ACTION = "遊戲",
    BAR_UNAVAILABLE = "遊戲的手把快捷列無法使用（手把介面是否已開啟？）。",
    KIND_slot = "動作",
    SLOT_HINT = "將法術、物品、巨集或坐騎拖到格子上。點擊：選單。右鍵：清空。",
})

-- HUD : taille et lignes des miniatures
ns.AddLocale("zhTW", {
    HUD_STRIP_SIZE = "縮圖大小：",
    HUD_STRIP_ROWS = "縮圖列數：",
    HUD_ORDER = "縮圖順序：",
    HUD_ORDER_RESET = "預設順序",
    HUD_ORDER_HINT = "箭頭：移動一層。在 HUD 上也可以把縮圖拖到另一個縮圖上。",
    HUD_CARD_DRAG = "拖曳：移動它（拖到另一個縮圖上）",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("zhTW", {
    CONTROLLER_LABEL = "手把：",
    CONTROLLER_CHANGE = "更換…",
    CONTROLLER_PICK = "選擇你的手把",
    CONTROLLER_OTHER = "其他手把",
    EXTRA = "按鍵",
    SOFTWARE_GENERIC = "手把的配套軟體",
    TEST_INTRO = "按任意按鍵：WoW 收到的輸入會亮起。如果額外按鍵沒有反應，請在手把的配套軟體中為它們設定鍵盤按鍵（見說明）。",
    LEARN_MODKEY = "注意：%s 是 Shift / Ctrl / Alt 鍵；在手把的配套軟體中最好使用 F9-F12 之類的鍵。",



    TUTO_SOFTWARE_WHY = "Windows 會把大多數手把識別為 Xbox 手把（XInput）。此模式只傳輸標準按鍵，"
        .. "因此 WoW 永遠收不到額外按鍵。解決辦法：讓每個額外按鍵送出一個鍵盤按鍵。",
    TUTO_SOFTWARE_VENDOR = "1. 連接手把並開啟 |cffffd100%s|r。\n"
        .. "2. 開啟按鍵對應頁面。\n"
        .. "3. 為每個額外按鍵（%s）設定你在 WoW 中不用的鍵盤按鍵。建議：|cffffd100F9、F10、F11、F12|r，"
        .. "或數字鍵盤（開啟 Num Lock）。\n"
        .. "4. 避免使用 Shift、Ctrl 和 Alt：它們會改變你的其他快捷鍵。\n"
        .. "5. 儲存設定檔（若軟體支援，儲存到手把）。",
    TUTO_SOFTWARE_ALT = "如果 %s 無法為這些按鍵設定鍵盤按鍵，請使用 |cffffd100Steam Input|r：將 WoW（或 Battle.net 啟動器）"
        .. "以非 Steam 遊戲加入 Steam，從 Steam 啟動，然後在其控制器配置中為每個按鍵設定一個鍵。"
        .. "|cffffd100reWASD|r（付費）也可以，不需 Steam。",
    TUTO_SOFTWARE_STEAM = "1. 在 |cffffd100Steam|r 中將 WoW（或 Battle.net 啟動器）加入為非 Steam 遊戲"
        .. "（遊戲 > 新增非 Steam 遊戲到我的收藏庫），然後從 Steam 啟動。\n"
        .. "2. 開啟它的控制器配置（Steam 遊戲內介面，或 Steam 中該遊戲的控制器設定）。\n"
        .. "3. 為每個額外按鍵（%s）設定你在 WoW 中不用的鍵盤按鍵。建議：|cffffd100F9、F10、F11、F12|r。\n"
        .. "4. 避免使用 Shift、Ctrl 和 Alt：它們會改變你的其他快捷鍵。\n\n"
        .. "|cffffd100reWASD|r（付費）不需 Steam 也能做到。",

    TUTO_DETECT_ALL = "|cff40ff40所有按鍵都已偵測到。|r",



})

-- Profils : liste, export, import
ns.AddLocale("zhTW", {
    TAB_PROFILES = "設定檔",
    PROFILES_INTRO = "一個設定檔包含一個手把、它的按鍵，以及每個角色的動作。整個帳號同一時間只使用一個設定檔。HUD 由所有設定檔共用。",
    PROFILE_ACTIVE = "使用中",
    PROFILE_USE = "使用此設定檔",
    PROFILE_NEW = "新增…",
    PROFILE_COPY = "複製…",
    PROFILE_RENAME = "重新命名…",
    PROFILE_DELETE = "刪除",
    PROFILE_EXPORT = "匯出…",
    PROFILE_IMPORT = "匯入…",
    PROFILE_DEFAULT = "設定檔",
    PROFILE_IMPORTED = "匯入的設定檔",
    PROFILE_COPY_SUFFIX = "%s（副本）",
    PROFILE_NAME_NEW = "新設定檔的名稱：",
    PROFILE_NAME_COPY = "副本的名稱：",
    PROFILE_NAME_RENAME = "「%s」的新名稱：",
    PROFILE_DELETE_CONFIRM = "刪除設定檔「%s」？它的按鍵設定以及你所有角色在此設定檔中的動作都將遺失。",
    PROFILE_SWITCHED = "目前設定檔：%s。",
    PROFILE_UNKNOWN = "沒有名為「%s」的設定檔。輸入 /mgir profiles 查看清單。",
    PROFILE_COMBAT = "戰鬥中無法切換設定檔。",
    PROFILE_LAST = "這是你唯一的設定檔，無法刪除。",
    PROFILE_CREATED = "已建立並啟用設定檔「%s」。請在「按鍵」分頁設定它的按鍵。",

    EXPORT_TITLE = "匯出「%s」",
    EXPORT_ACTIONS = "包含此角色的動作",
    EXPORT_HUD = "包含 HUD 設定",
    EXPORT_HINT = "文字已選取：按 Ctrl+C 複製，然後貼到任何地方（Discord、文字檔…）。在「設定檔」分頁用「匯入」按鈕匯入。",
    CLOSE = "關閉",

    IMPORT_TITLE = "匯入設定檔",
    IMPORT_PASTE = "在此貼上匯出的文字（Ctrl+V）：",
    IMPORT_EMPTY = "貼上匯出的文字即可查看內容。",
    IMPORT_BAD = "這不是 My Gamepad Is Rich 匯出的文字。",
    IMPORT_VERSION = "此文字來自插件的其他版本，無法讀取。",
    IMPORT_DAMAGED = "此文字已損壞或不完整：請重新完整複製。",
    IMPORT_SUMMARY = "設定檔「%s」，手把：%s\n已設定按鍵的按鈕 %d 個，動作 %d 個",
    IMPORT_SUMMARY_HUD = "包含 HUD 設定。",
    IMPORT_MACROS = "注意：%d 個手寫巨集。使用前請先閱讀：",
    IMPORT_COMMANDS = "WoW 指令：%s",
    IMPORT_AS_NEW = "新設定檔：",
    IMPORT_REPLACE = "取代：",
    IMPORT_PICK = "要取代的設定檔",
    IMPORT_ACTIONS = "匯入動作（用於此角色）",
    IMPORT_HUD = "套用 HUD 設定",
    IMPORT_DO = "匯入",
    IMPORT_REPLACE_CONFIRM = "取代設定檔「%s」？它的手把和按鍵設定將被覆寫；若匯入動作，此角色的動作也會被覆寫。",
    IMPORT_DONE = "已匯入設定檔「%s」。",

    SELFTEST_OK = "自我檢測：一切正常。",
    SELFTEST_FAIL = "自我檢測：%d 個問題：%s",
    SLASH_HELP = "/mgir : 開啟  |  /mgir profile <名稱> : 切換設定檔  |  /mgir test : 手把測試  |  /mgir tuto : 教學  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : 重設此角色的動作",
})

-- HUD : arrêt après une erreur
ns.AddLocale("zhTW", {
    HUD_ERROR = "HUD 發生錯誤：在 /reload 前已停止（恢復遊戲快捷列）。請回報此訊息：%s",
})

-- Gâchettes LT / RT données à l'addon
ns.AddLocale("zhTW", {
    TRIGGERS_LABEL = "LT / RT 扳機：",
    TRIGGERS_ADDON = "插件修飾鍵",
    TRIGGERS_GAME = "遊戲的層",
    TRIGGERS_ADDON_DESC = "按住 LT 或 RT（或兩者）再按 A、B、X、Y 或十字鍵：觸發插件的動作，支援插件的全部功能（手寫巨集、WoW 指令）。它們取代遊戲手把快捷列的 LT、RT 和 LT + RT 層；空格子不執行任何動作。LB 和 RB 不變。",
    TRIGGERS_GAME_DESC = "LT 和 RT 保留遊戲手把快捷列的層（可在「動作」分頁編輯）。",
    TRIGGERS_COPIED = "已將遊戲 LT / RT 層中的 %d 個動作複製到插件的層。",
    IMPORT_SUMMARY_TRIGGERS = "LT / RT：插件修飾鍵。",
})

-- Menu d'une case : pourquoi des choix sont grisés
ns.AddLocale("zhTW", {
    MENU_GAME_BAR_HINT = "手寫巨集、WoW 指令：請將 LT / RT 交給插件（「按鍵」分頁，基礎按鍵）",
})

-- Actions de base (celles de Forever sur A/B/X/Y)
ns.AddLocale("zhTW", {
    MENU_GAME = "基礎動作…",
    GAME_TITLE = "基礎動作",
    KIND_game = "基礎動作",
    GAME_jump = "跳躍",
    GAME_cancel = "取消（法術、目標）",
    GAME_search = "搜尋（右鍵點擊目標）",
    GAME_attack = "自動攻擊",
    GAME_interact = "互動",
})

-- Modes de ciblage (comme LB / RB dans Forever)
ns.AddLocale("zhTW", {
    MODE_TARGET_FRIEND = "友方目標",
    MODE_TARGET_ENEMY = "敵方目標",
    MODE_TARGET_FRIEND_DESC = "與 Forever 的 LB 相同：短按選取最近的友方；按住並用右搖桿瞄準來選擇。按住時它也是修飾鍵：A、B、X、Y 和十字鍵觸發它的 8 個快捷動作。",
    MODE_TARGET_ENEMY_DESC = "與 Forever 的 RB 相同：短按選取最近的敵人；按住並用右搖桿瞄準來選擇。按住時它也是修飾鍵：A、B、X、Y 和十字鍵觸發它的 8 個快捷動作。",
    TARGET_UNAVAILABLE = "找不到 Forever 的目標選取：%s 作為一般修飾鍵使用。",
})

-- Onglet « Soutenir » (don PayPal)
ns.AddLocale("zhTW", {
    TAB_DONATE = "支持",
    DONATE_TITLE = "支持 My Gamepad Is Rich",
    DONATE_INTRO = "My Gamepad Is Rich 是免費的，而且會一直免費。如果它對你有幫助、你想表達感謝，可以透過 PayPal 捐贈任意金額。",
    DONATE_SCAN = "用手機掃描 QR 碼",
    DONATE_LINK = "或複製連結（Ctrl+C）並貼到瀏覽器中：",
    DONATE_THANKS = "捐贈完全自願，不會解鎖任何內容：所有功能對所有人開放。感謝你的支持！",
})

-- Boutons de base (LT, RT, LB, RB)
ns.AddLocale("zhTW", {
    MODE_GAME = "遊戲",
    MODE_GAME_DESC = "此按鍵保留它在遊戲中的作用（LT / RT：手把快捷列的層；LB / RB：Forever 的目標選取）。",
    PADS_LABEL = "基礎按鍵：",
    PADS_PICK = "%s：選擇模式",
    IMPORT_SUMMARY_PADS = "交給插件的基礎按鍵：%s",
    EMULATION_OFF = "%s 交給插件期間不再模擬 Shift / Ctrl。登出時會自動恢復。",
    RESTORE_DONE = "基礎按鍵已還給遊戲，Shift / Ctrl 模擬已恢復。",
})

-- Plus aucun ciblage allié / ennemi configuré
ns.AddLocale("zhTW", {
    TARGET_MISSING_FRIEND = "沒有按鍵可以選取友方：請把 LB 設回「遊戲」，或把某個按鍵設為「友方目標」（「按鍵」分頁）。",
    TARGET_MISSING_ENEMY = "沒有按鍵可以選取敵人：請把 RB 設回「遊戲」，或把某個按鍵設為「敵方目標」（「按鍵」分頁）。",
    TARGET_MISSING_BOTH = "沒有按鍵可以選取友方或敵人：請把 LB / RB 設回「遊戲」，或把按鍵設為「友方目標」/「敵方目標」（「按鍵」分頁）。",
})

-- Onglet Boutons : mention des boutons de base
ns.AddLocale("zhTW", {
    PAD_HINT = "手把按鍵：無需偵測",
})

-- Case vide d'un bouton simple dans une couche : son action habituelle
ns.AddLocale("zhTW", {
    SIMPLE_USUAL = "照常",
})

-- Manettes standard (sans bouton supplémentaire), noms PlayStation
ns.AddLocale("zhTW", {
    TUTO_NO_EXTRA = "這個手把沒有額外按鍵：這裡無需設定。你可以在「按鍵」分頁的基礎按鍵中，為 LT、RT、LB 和 RB 設定其他作用。",
    PS_CROSS = "叉",
    PS_CIRCLE = "圓",
    PS_SQUARE = "方",
    PS_TRIANGLE = "三角",
})

-- Paires libres (deux modificateurs quelconques)
ns.AddLocale("zhTW", {
})

-- Paire avec un bouton de base resté au jeu
ns.AddLocale("zhTW", {
})

-- Boutons de base : mode par défaut
ns.AddLocale("zhTW", {
    MODE_IS_DEFAULT = "此按鍵的預設設定：與遊戲中的作用相同。",
})

-- Tutoriel : les types de boutons, boutons de base, paires ; options
ns.AddLocale("zhTW", {
    MODE = "類型：",
    TUTO_WELCOME_TEXT = "這個插件讓你決定手把上每個按鍵的作用：額外按鍵（背鍵、額外扳機：GameSir、Xbox Elite、DualSense Edge、SCUF……）以及基礎按鍵 LT、RT、LB 和 RB。\n\n|cffffd100原理：層。|r單獨按下時，A、B、X、Y 和十字鍵觸發 8 個動作。按住一個按鍵（LT、RT、背鍵……），同樣這 8 個按鍵會觸發另外 8 個動作：這就是一個新的層。每個按住的按鍵都對應一層。\n\n本教學大約需要兩分鐘。你可以隨時離開，並用 |cffffd100/mgir tuto|r 重新開啟。",
    TUTO_CONTROLLER_TITLE = "你的手把",
    TUTO_CONTROLLER_TEXT = "選擇你的手把：插件會使用其額外按鍵的名稱，並告訴你用哪個軟體來設定它們。沒有額外按鍵的一般 Xbox 或 PlayStation 手把？也選擇它：你仍然可以設定 LT、RT、LB 和 RB。清單裡沒有？選擇 |cffffd100其他手把|r（最多 6 個按鍵，可以重新命名）。",
    TUTO_TYPES_TITLE = "4 種按鍵類型",
    TUTO_TYPES_TEXT = "每個按鍵都有一個類型，決定它的作用。你可以在接下來的步驟中選擇，也可以隨時在 |cffffd100按鍵|r 分頁中更改（將滑鼠停在類型上可再次查看說明）。",
    TYPE_MODIFIER_HOW = "按住它，再按 A、B、X、Y 或十字鍵：一層 8 個動作。單獨按下時什麼也不做。",
    TYPE_MODIFIER_FOR = "適合：容易一直按住的按鍵。LT 和 RT 預設為此類型，與遊戲中相同。",
    TYPE_TARGET_HOW = "短按選擇最近的友方（或敵方）目標；按住並用右搖桿瞄準可以選擇其他目標。按住時配合 A、B、X、Y 或十字鍵：8 個快捷動作，和修飾鍵一樣。",
    TYPE_TARGET_FOR = "適合：對目標施放的治療和法術。LB（友方）和 RB（敵方）預設為此類型，與遊戲中相同。",
    TYPE_SIMPLE_HOW = "按一下觸發一個動作。按住 LT 或 RT 時觸發另一個動作。它在每個修飾鍵層中也有一個格子。",
    TYPE_SIMPLE_FOR = "適合：常用的法術、藥水、坐騎。",
    TYPE_OFF_HOW = "按鍵不做任何事：它的按鍵留作他用。",
    TYPE_OFF_FOR = "適合：你不使用的額外按鍵（基礎按鍵沒有此類型）。",
    TUTO_SOFTWARE_TITLE = "讓額外按鍵送出一個按鍵",
    TUTO_DETECT_TITLE = "偵測你的額外按鍵",
    TUTO_DETECT_MISSING = "按下後沒有反應？在手把軟體中檢查該按鍵的設定，然後再試一次。",
    TUTO_MODES_TITLE = "額外按鍵的類型",
    TUTO_MODES_TEXT = "為每個額外按鍵選擇類型（將滑鼠停在類型上可查看其作用）。\n建議：最容易按住的按鍵設為修飾鍵，其他設為一般按鍵。|cffffd100使用建議類型|r 會幫你完成。",
    TUTO_SUGGESTED = "使用建議類型",
    TUTO_PADS_TITLE = "你的基礎按鍵：LT、RT、LB、RB",
    TUTO_PADS_TEXT = "預設（綠色）與遊戲中相同：LT 和 RT 是修飾鍵，LB 選擇友方目標，RB 選擇敵方目標。遊戲手把動作條上的動作會複製到它們的層中。你也可以更改：例如把 RB 設為一般按鍵，或把 LB 設為修飾鍵。",
    TUTO_PADS_DEFAULT = "恢復預設類型",
    TUTO_PAIRS_TITLE = "組合：同時按住兩個按鍵",
    TUTO_PAIRS_TEXT = "同時按住兩個按鍵（修飾鍵或目標選擇）：再多一層 8 個動作。任意兩個都能組成組合：L5 + R5、LT + RT、LB + LT……勾選你想要的（之後可在 |cffffd100按鍵|r 分頁中更改）。預設：左 + 右組合。",
    TUTO_ACTIONS_TITLE = "放置你的動作",
    TUTO_ACTIONS_TEXT = "在 |cffffd100動作|r 分頁：左邊是你所有的層（單獨、LT、RT、你的修飾鍵和組合）；右邊是所選的層，按手把配置排列。\n\n- 從法術書拖入法術，從背包拖入物品、巨集、坐騎或玩具到格子上。\n- 或點擊格子：選擇法術或物品、編寫巨集、選擇 WoW 指令（自動奔跑……）或基礎動作（跳躍、互動……）。右鍵：清空。\n- 十字鍵下方那一列：你的一般按鍵在該層中的格子。\n\n你也可以點擊 HUD 上的層縮圖直接編輯。\n\n動作按角色儲存；類型和按鍵儲存在設定檔中，整個帳號通用。所有功能在戰鬥中都能使用；只有在戰鬥中做的修改會等到戰鬥結束後生效。",
    TUTO_HUD_TEXT = "插件用自己的 HUD 取代遊戲的手把動作條：\n\n- |cffffd100大圖|r：你正在使用的層，左邊是十字鍵，右邊是 A/B/X/Y。按住一個按鍵即可切換。\n- |cffffd100縮圖|r：你所有的層，中間是一般按鍵的格子；正在按住的層會亮起。點擊縮圖即可編輯。\n- |cffffd100中央|r：你的一般按鍵，以及它們將觸發的動作。\n\n設定（大小、位置、縮圖）：|cffffd100HUD|r 分頁。|cffffd100/mgir hud off|r：恢復遊戲動作條。",
    TUTO_DONE_TEXT = "開啟設定來放置你的第一批動作。\n\n|cffffd100/mgir|r：開啟設定\n|cffffd100/mgir test|r：手把測試，查看 WoW 收到的輸入\n|cffffd100/mgir tuto|r：本教學\n|cffffd100/mgir reset|r：清空此角色的動作\n|cffffd100/mgir restore|r：把 LT、RT、LB 和 RB 還給遊戲",
    SETTINGS_DESC = "決定手把上每個按鍵的作用：額外按鍵（背鍵、額外扳機）和基礎按鍵（LT、RT、LB、RB）。指令：/mgir",
    BUTTONS_INTRO = "為每個按鍵選擇類型：將滑鼠停在類型上可查看其作用。綠色：基礎按鍵的預設類型，與遊戲中相同。",
    BUTTONS_TYPES_HELP = "按鍵類型",
    PAIRS_HINT = "勾選要使用的組合：同時按住兩個按鍵可再獲得 8 個動作。任意兩個修飾鍵或目標選擇按鍵都能組成組合（L5 + LT、LB + RT……）。",
    PAIRS_NONE = "至少將兩個按鍵設為修飾鍵、友方目標或敵方目標，才能組成組合。",
    PAIR_WAITS = "%s 處於「遊戲」：請設為修飾鍵、友方目標或敵方目標（上方）",
})

-- Tutoriel, paires : appuyer sur les boutons pour les trouver
ns.AddLocale("zhTW", {
    TUTO_PAIRS_PRESS = "按下手把上的一個按鍵：它所在的組合會以綠色標示。同時按下兩個按鍵：它們的組合會標示出來。",
})

-- LB + LT et RB + RT : l'action de classe de Forever
ns.AddLocale("zhTW", {
    PAIR_CLASS_WARN = "也會觸發 Forever 的職業動作",
    PAIR_CLASS_WARN_LONG = "注意：%s 也會觸發 Forever 的職業動作（通常是一個法術輪盤，開啟時會占用 A、B、X 和 Y；按 B 關閉）。插件無法阻止：最好選擇其他組合。",
    PAIR_CLASS_NOTE = "%s 和 %s 也會觸發 Forever 的職業動作（通常是會占用 A、B、X 和 Y 的法術輪盤）。插件無法阻止：最好選擇其他組合。",
})

-- Forever resté sur sa barre LT / RT
ns.AddLocale("zhTW", {
    FOREVER_STUCK = "Forever 停留在它的 %s 動作條上（漏掉了一次按鍵放開）。按一次 %s 即可回到「單獨」。",
})

-- 1.1.0 : spés, état des actions sur le HUD, profils, remplissage rapide, rapport
ns.AddLocale("zhTW", {
    SPEC_NUMBER = "專精 %d",
    SPEC_SWITCHED = "「%s」專精的動作。",
    SPEC_NEW = "新專精「%s」：以上一個專精動作的副本開始。",
    PROFILE_PER_CHAR = "記住每個角色的設定檔",
    PROFILE_PER_CHAR_DESC = "登入時，每個角色會回到自己上次使用的設定檔。不勾選時，所有角色都使用帳號上次使用的設定檔。",
    REPORT_BUTTON = "複製報告",
    REPORT_TITLE = "手把報告",
    REPORT_HINT = "先在測試分頁按一遍每個按鍵，然後複製這段文字（Ctrl+C），連同哪些可用、哪些不可用一起寄給插件作者。這有助於確認其他手把的設定。其中不包含角色名稱或伺服器名稱。",
    WHATSNEW_TITLE = "My Gamepad Is Rich 新內容",
    QUICKFILL_BUTTON = "填滿空格",
    QUICKFILL_DESC = "把爐石、已裝備的可使用飾品和背包裡的消耗品（藥水、食物、繃帶、藥劑……）放進此層的空格，已有的除外。右鍵點擊格子可清空。",
    QUICKFILL_DONE = "已填入 %d 格。",
    QUICKFILL_NONE = "沒有可放的：背包裡沒有此層尚未有的可使用物品。",
})

-- 1.1.0 : modèles de classe, copie de couches, verrou, annulation, véhicules
ns.AddLocale("zhTW", {
    SLASH_HELP = "/mgir : 開啟  |  /mgir profile <名稱> : 切換設定檔  |  /mgir test : 手把測試  |  /mgir tuto : 教學  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : 重設此角色的動作  |  /mgir undo : 復原上一次動作變更",
    LEARN_PAD_REFUSED = "%s 是手把的基本按鍵：插件會自行組合或設定它。請按額外按鍵（其軟體送出的鍵）。",
    RESET_CONFIRM = "清空此角色在目前設定檔中的所有動作？",
    RESET_CONFIRM_SPEC = "清空此角色在目前設定檔中「%s」專精的所有動作？",
    UNDO_HINT = "輸入 /mgir undo 可復原。",
    UNDO_DONE = "動作已恢復到上一次變更之前。",
    UNDO_NONE = "此專精沒有可復原的變更。",
    ACTION_COUNT = "%d 個動作",
    LAYER_COPY_BUTTON = "複製 / 交換…",
    LAYER_COPY_DESC = "將此層的動作複製到另一層，或交換兩層的動作（8 格以及一般按鍵的格子）。",
    LAYER_COPY_TITLE = "%s 層",
    LAYER_COPY_TO = "複製到",
    LAYER_SWAP_WITH = "交換",
    LAYER_COPY_NONE = "沒有其他組合層：請先把另一個按鍵設為修飾鍵。",
    LAYER_COPY_CONFIRM = "將 %s 層的動作（%d 個）替換為 %s 的動作？",
    LAYER_COPIED = "已將 %s 複製到 %s。",
    LAYER_SWAPPED = "已交換 %s 和 %s。",
    TPL_BUTTON = "範本和專精…",
    TPL_DESC = "職業範本：將此專精的動作儲存給整個帳號，然後在同職業的其他角色上載入。也可以複製另一個專精的動作。留在遊戲快捷列上的動作不包含在內。",
    TPL_TITLE = "範本和專精",
    TPL_SECTION_SAVE = "儲存",
    TPL_SAVE = "將這些動作儲存為範本…",
    TPL_SECTION_LOAD = "載入範本（%s）",
    TPL_SECTION_SPEC = "從專精複製",
    TPL_SECTION_DELETE = "刪除範本",
    TPL_SAVE_PROMPT = "範本名稱（帳號中所有%s角色可用）：",
    TPL_SAVED = "範本「%s」已為%s儲存。",
    TPL_REPLACE_CONFIRM = "取代範本「%s」？",
    TPL_LOAD_CONFIRM = "載入範本「%s」？它會取代%s的動作。",
    TPL_LOADED = "範本「%s」已載入。",
    TPL_DELETE_CONFIRM = "為此職業的所有角色刪除範本「%s」？",
    TPL_DELETED = "範本「%s」已刪除。",
    SPEC_COPY_CONFIRM = "複製「%s」的動作？它們會取代%s的動作。",
    SPEC_COPIED = "已複製「%s」的動作。",
    LATCH = "可鎖定",
    LATCH_DESC = "按一下開啟此修飾鍵的層，再按一下關閉：不必按住。按住另一個修飾鍵時，由它接手。任何設定變更都會解除鎖定。僅限額外按鍵（不含 LT、RT、LB、RB）。",
})

-- 1.1.0 : notes de version (tout ce qui a changé depuis la 1.0.0)
ns.AddLocale("zhTW", {
    WHATSNEW_1_1_4 = "• 友方 / 敵方目標：每次短按都會切換到下一個目標，即使已有目標，在遊戲不向插件提供時間的環境中也是如此。長按會保留用搖桿選中的目標。\n• /mgir etat 會顯示短按的辨識方式。",
    WHATSNEW_1_1_3 = "• 友方 / 敵方目標：放開按鍵後，用搖桿選中的目標會保留。只有短按才會選取最近的目標。",
    WHATSNEW_1_1_2 = "• 魔獸世界指令或手寫巨集可以使用你選擇的圖示：點擊格子，「更換圖示...」。搜尋可以找到你的法術、物品和魔獸世界指令的圖示，或依檔名尋找圖示（如 Wowhead 上的 inv_misc_map_01）。\n• 常用指令有了自己的圖示，不再是鑰匙：世界地圖、背包、法術書、任務日誌、角色、成就、隊伍搜尋器、收藏。",
    WHATSNEW_1_1_1 = "• 一般按鍵：空的層（LT、RT 或修飾鍵）現在不執行任何動作，在 HUD 上也保持空白，而不再使用「單獨」動作。唯一例外：放在「單獨」上的魔獸世界指令。\n• 法術列表現在包含專業技能法術：尋找草藥、尋找礦物、釣魚、烹飪、考古學……",
    WHATSNEW_1_1_0 = "• HUD：插件的動作像遊戲快捷列一樣顯示。超出距離為紅色，資源不足為藍色，無法使用為灰色，觸發特效時金色邊框，顯示剩餘充能，進行中的動作（自動攻擊、形態……）高亮。\n• HUD：可以選擇各層縮圖的順序（HUD 分頁的箭頭，或把一個縮圖拖到另一個上）。\n• 每個專精有自己的動作。新專精以上一個專精動作的副本開始。\n• 動作分頁：「填滿空格」把爐石、飾品和背包裡的消耗品放到修飾鍵層上，「複製 / 交換…」可將組合層複製到另一層，或交換兩層。\n• 職業範本：將動作儲存給整個帳號，並在同職業的其他角色上載入（層清單下方的「範本和專精…」）。也可以複製另一個專精的動作。\n• 可鎖定的修飾鍵（按鍵頁）：按一下開啟層，再按一下關閉。\n• /mgir reset 會要求確認，/mgir undo 可復原重設、範本、專精複製或層複製。\n• 設定檔：新增「記住每個角色的設定檔」選項。\n• 卡住的層：交給插件的基本按鍵在放開前一直屬於收到按下的一方，Forever 也不會再卡在 RT（或 LT）快捷列上，例如用 RT + A 施放聖騎士的聖印之後。\n• 載具、替換快捷列和寵物對戰：插件讓位，遊戲按鍵正常運作，戰鬥中也一樣。\n• 停用插件前不再需要輸入 /mgir restore：每次登出時 LT 和 LB 恢復模擬 Shift / Ctrl，登入時插件再關閉它。\n• 偵測會拒絕 A、B、X、Y、十字鍵和 LT、RT、LB、RB（誤按會讓它們成為額外按鍵的鍵）。\n• 手把測試分頁：「複製報告」（含最近的層記錄），寄出它來幫助確認其他手把。/mgir etat 顯示各層的狀態。\n• /mgir news：再次顯示此視窗。",
})
