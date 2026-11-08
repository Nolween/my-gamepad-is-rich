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
    MODE = "模式：",
    MODE_MODIFIER = "修飾鍵",
    MODE_SIMPLE = "一般按鍵",
    MODE_OFF = "停用",
    MODE_MODIFIER_DESC = "按住此鍵，再按 A、B、X、Y 或十字鍵：8 個新組合，與 LT/RT 相同。",
    MODE_SIMPLE_DESC = "一個動作，另加按住 LT 時的一個動作與按住 RT 時的一個動作。空的層使用「單獨」動作。",
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
    TUTO_SUGGESTED = "使用建議模式",
    HELP_REPLAY = "重新觀看教學",

    TUTO_WELCOME_TITLE = "歡迎使用 My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "對每個按鍵，點擊 |cffffd100偵測|r，然後按下手把上的這個鍵。"
        .. "它送出的鍵位會顯示在旁邊。",


    TUTO_ACTIONS_TEXT = "在設定視窗中，每個按鍵都會顯示它的格子。\n\n"
        .. "- 將法術書中的法術、背包裡的物品、巨集、坐騎或玩具拖到格子上。\n"
        .. "- 或右鍵點擊格子：選擇法術或背包物品、撰寫巨集、選擇 WoW 指令（如自動奔跑），或清空。\n\n"
        .. "動作依角色儲存；鍵位和模式對整個帳號生效。"
        .. "所有功能在戰鬥中都能使用；只有戰鬥中做的變更會等到戰鬥結束後生效。",

    TUTO_DONE_TITLE = "一切就緒",
    TUTO_DONE_TEXT = "開啟設定，放置你的第一批動作。\n\n"
        .. "|cffffd100/mgir|r：開啟設定\n"
        .. "|cffffd100/mgir test|r：手把測試，查看 WoW 收到的輸入\n"
        .. "|cffffd100/mgir tuto|r：本教學\n"
        .. "|cffffd100/mgir reset|r：清空此角色的動作",
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
    HUD_EDITING = "正在編輯此層：點擊格子進行設定，右鍵清空。再次點擊縮圖返回。",
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
    LAYER_DESC_BASE = "不按住任何鍵時的 A、B、X、Y 和十字鍵。A、B、X、Y 保留遊戲內建的動作（跳躍、互動……）。",
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
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("zhTW", {
    CONTROLLER_LABEL = "手把：",
    CONTROLLER_CHANGE = "更換…",
    CONTROLLER_PICK = "選擇你的手把",
    CONTROLLER_OTHER = "其他手把",
    EXTRA = "按鍵",
    SOFTWARE_GENERIC = "手把的配套軟體",
    SETTINGS_DESC = "設定手把的額外按鍵（背鍵、額外扳機）。指令：/mgir",
    BUTTONS_INTRO = "你的手把及其額外按鍵：每個鍵送出的鍵位，以及它的作用。將滑鼠移到模式上可查看說明。",
    TEST_INTRO = "按任意按鍵：WoW 收到的輸入會亮起。如果額外按鍵沒有反應，請在手把的配套軟體中為它們設定鍵盤按鍵（見說明）。",
    LEARN_MODKEY = "注意：%s 是 Shift / Ctrl / Alt 鍵；在手把的配套軟體中最好使用 F9-F12 之類的鍵。",

    TUTO_WELCOME_TEXT = "本插件讓你在 WoW 中使用手把的額外按鍵：背鍵、額外扳機或肩鍵"
        .. "（GameSir、Xbox Elite、DualSense Edge、SCUF、8BitDo、飛智…）。\n\n"
        .. "每個鍵都可以作為按住的修飾鍵（與 A、B、X、Y 和十字鍵組成 8 個新組合），"
        .. "也可以作為擁有獨立 LT 與 RT 層的一般按鍵。\n\n"
        .. "本教學大約需要兩分鐘。你可以隨時離開，並用 |cffffd100/mgir tuto|r 再次開啟。",

    TUTO_CONTROLLER_TITLE = "第 1 步：你的手把",
    TUTO_CONTROLLER_TEXT = "選擇你的手把：插件會使用它的按鍵名稱，並告訴你用哪個軟體設定這些按鍵。"
        .. "清單裡沒有？請選擇 |cffffd100其他手把|r（最多 6 個按鍵，可重新命名）。",

    TUTO_SOFTWARE_TITLE = "第 2 步：讓按鍵送出鍵盤按鍵",
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

    TUTO_DETECT_TITLE = "第 3 步：偵測按鍵",
    TUTO_DETECT_ALL = "|cff40ff40所有按鍵都已偵測到。|r",
    TUTO_DETECT_MISSING = "按下後沒有反應？請在手把的配套軟體（第 2 步）中檢查該鍵的設定，然後重試。",

    TUTO_MODES_TITLE = "第 4 步：選擇模式",
    TUTO_MODES_TEXT = "|cffffd100修飾鍵|r：按住該鍵，再按 A、B、X、Y 或十字鍵。每個鍵 8 個動作，與 LT、RT 相同。\n"
        .. "|cffffd100一般按鍵|r：一個動作，另加按住 LT 時一個、按住 RT 時一個。\n"
        .. "|cffffd100停用|r：鍵位保持空閒。\n\n"
        .. "建議：最容易按住的鍵設為修飾鍵，其餘設為一般按鍵。",
    TUTO_PAIRS_TEXT = "|cffffd100組合|r：按鍵依左 + 右成對。當一對中的兩個鍵都是修飾鍵時，同時按住它們可再獲得 8 個組合。",

    TUTO_ACTIONS_TITLE = "第 5 步：放置動作",

    TUTO_HUD_TEXT = "本插件以自己的 HUD 取代遊戲的手把快捷列，位於畫面下方：\n\n"
        .. "- |cffffd100大圖|r：你正在使用的層，左邊是十字鍵，右邊是 A/B/X/Y。按住 LT、RT 或修飾鍵即可切換。\n"
        .. "- |cffffd100縮圖列|r（在下方，或用 /mgir hud strip 移到上方）：所有層的縮圖（單獨、LT、RT、LT+RT、你的修飾鍵和組合）；按住的那一層會亮起。\n"
        .. "- |cffffd100中間|r：你的一般按鍵，以及按住扳機時將觸發的動作。\n\n"
        .. "非戰鬥狀態且沒有按住任何鍵時，它會變淡。\n"
        .. "|cffffd100/mgir hud|r：移動  -  |cffffd100/mgir hud scale 1.2|r：大小  -  |cffffd100/mgir hud off|r：恢復遊戲快捷列",
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
