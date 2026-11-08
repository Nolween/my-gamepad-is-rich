-- 繁體中文
local _, ns = ...

ns.AddLocale("zhTW", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "按鍵",
    TAB_TEST = "手把測試",
    TAB_HELP = "說明",

    EXTRA = "按鍵",
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
    LEARN_MODKEY = "注意：%s 是 Shift / Ctrl / Alt 鍵；在 GameSir Nexus 中最好使用 F9-F12 之類的鍵。",
    LEARN_BOUND = "提示：%s 在 WoW 中綁定為「%s」；本插件使用它時，以插件為準。",

    TEST_INTRO = "按任意按鍵：WoW 收到的輸入會亮起。如果 L5 / R5 / L4 / R4 沒有反應，請在 GameSir Nexus 中為它們設定鍵盤按鍵（見說明）。",
    TEST_STANDARD = "標準按鍵",
    TEST_EXTRA = "額外按鍵",
    TEST_LOG = "最近輸入",
    TEST_GAME = "遊戲",
    TEST_UNKNOWN = "未指派",

    IF_WARNING = "已載入 Improved Forever：如果它也使用這些鍵位之一，以最後套用的綁定為準。",
    OPEN_CONFIG = "開啟設定",
    SETTINGS_DESC = "設定 GameSir G7 Pro 的額外按鍵（L5/R5、L4/R4）。指令：/mgir",
    LOADED = "已載入。輸入 /mgir 設定額外按鍵。",
    SLASH_HELP = "/mgir : 開啟  |  /mgir test : 手把測試  |  /mgir tuto : 教學  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : 重設此角色的動作",
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
    TUTO_WELCOME_TEXT = "本插件讓你在 WoW 中使用 GameSir G7 Pro 的額外按鍵：\n\n"
        .. "|cffffd100L5 / R5|r：第三扳機\n"
        .. "|cffffd100L4 / R4|r：背部撥片\n\n"
        .. "每個鍵都可以作為按住的修飾鍵（與 A、B、X、Y 和十字鍵組成 8 個新組合），"
        .. "也可以作為擁有獨立 LT 與 RT 層的一般按鍵。\n\n"
        .. "本教學大約需要兩分鐘。你可以隨時離開，並用 |cffffd100/mgir tuto|r 再次開啟。",

    TUTO_NEXUS_TITLE = "第 1 步：GameSir Nexus",
    TUTO_NEXUS_TEXT = "Windows 會把 G7 Pro 識別為 Xbox 360 手把。此模式只傳輸標準按鍵，"
        .. "因此 WoW 永遠收不到 L5、R5、L4 和 R4。解決辦法：讓它們送出鍵盤按鍵。\n\n"
        .. "1. 連接手把並開啟 |cffffd100GameSir Nexus|r（Microsoft Store）。\n"
        .. "2. 開啟按鍵對應頁面。\n"
        .. "3. 為 L5、R5、L4 和 R4 設定你在 WoW 中不用的鍵盤按鍵。建議：|cffffd100F9、F10、F11、F12|r，"
        .. "或數字鍵盤（開啟 Num Lock）。\n"
        .. "4. 避免使用 Shift、Ctrl 和 Alt：它們會改變你的其他快捷鍵。\n"
        .. "5. 將設定檔儲存到手把。\n\n"
        .. "完成了嗎？進入下一步。",

    TUTO_DETECT_TITLE = "第 2 步：偵測按鍵",
    TUTO_DETECT_TEXT = "對每個按鍵，點擊 |cffffd100偵測|r，然後按下手把上的這個鍵。"
        .. "它送出的鍵位會顯示在旁邊。",
    TUTO_DETECT_ALL = "|cff40ff40四個按鍵都已偵測到。|r",
    TUTO_DETECT_MISSING = "按下後沒有反應？請在 GameSir Nexus 中檢查該鍵的設定，然後重試。",

    TUTO_MODES_TITLE = "第 3 步：選擇模式",
    TUTO_MODES_TEXT = "|cffffd100修飾鍵|r：按住該鍵，再按 A、B、X、Y 或十字鍵。每個鍵 8 個動作，與 LT、RT 相同。\n"
        .. "|cffffd100一般按鍵|r：一個動作，另加按住 LT 時一個、按住 RT 時一個。\n"
        .. "|cffffd100停用|r：鍵位保持空閒。\n\n"
        .. "建議：L5 和 R5 設為修飾鍵（容易按住），L4 和 R4 設為一般按鍵。",

    TUTO_ACTIONS_TITLE = "第 4 步：放置動作",
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
    TUTO_HUD_TEXT = "本插件以自己的 HUD 取代遊戲的手把快捷列，位於畫面下方：\n\n"
        .. "- |cffffd100大圖|r：你正在使用的層，左邊是十字鍵，右邊是 A/B/X/Y。按住 LT、RT、L5 或 R5 即可切換。\n"
        .. "- |cffffd100縮圖列|r（在下方，或用 /mgir hud strip 移到上方）：所有層的縮圖（單獨、LT、RT、LT+RT、L5、R5）；按住的那一層會亮起。\n"
        .. "- |cffffd100中間|r：L4 和 R4，以及按住扳機時將觸發的動作。\n\n"
        .. "非戰鬥狀態且沒有按住任何鍵時，它會變淡。\n"
        .. "|cffffd100/mgir hud|r：移動  -  |cffffd100/mgir hud scale 1.2|r：大小  -  |cffffd100/mgir hud off|r：恢復遊戲快捷列",
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

-- Paires de modificateurs (L5 + R5, L4 + R4)
ns.AddLocale("zhTW", {
    PAIR_READY = "組合 · 同時按住",
    PAIR_NOT_READY = "組合 · 無法使用",
    PAIR_DESC = "同時按住 %s 和 %s，再按 A、B、X、Y 或十字鍵：再多 8 個組合。",
    PAIR_NEEDS = "要使用此組合，%s 和 %s 都必須是已設定鍵位的修飾鍵模式。",
    TUTO_PAIRS_TEXT = "|cffffd100組合|r：當 L5 和 R5 都是修飾鍵時，同時按住它們可再獲得 8 個組合。L4 + R4 同理。",
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
    BUTTONS_INTRO = "你的額外按鍵：GameSir Nexus 送出的鍵位，以及每個鍵的作用。將滑鼠移到模式上可查看說明。",
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
