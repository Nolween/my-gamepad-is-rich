-- 简体中文
local _, ns = ...

ns.AddLocale("zhCN", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "按键",
    TAB_TEST = "手柄测试",
    TAB_HELP = "帮助",

    EXTRA = "按键",
    NAME = "名称：",
    KEY = "键位：",
    KEY_NONE = "未设置",
    DETECT = "检测",
    CLEAR = "清除",
    MODE = "模式：",
    MODE_MODIFIER = "修饰键",
    MODE_SIMPLE = "普通按键",
    MODE_OFF = "禁用",
    MODE_MODIFIER_DESC = "按住此键，再按 A、B、X、Y 或十字键：8 个新组合，与 LT/RT 相同。",
    MODE_SIMPLE_DESC = "一个动作，外加按住 LT 时的一个动作和按住 RT 时的一个动作。空的层使用“单独”动作。",
    MODE_OFF_DESC = "此键不执行任何操作：其键位保持空闲。",
    LAYER_BASE = "单独",
    LAYER_LT = "LT +",
    LAYER_RT = "RT +",
    SLOT_HINT = "将法术、物品、宏或坐骑拖到格子上。右键：更多选项。",
    EMPTY = "空",
    NO_KEY_WARNING = "请先设置键位：点击“检测”，然后按下该按键。",

    MENU_SPELL = "选择法术...",
    MENU_ITEM = "选择背包物品...",
    SPELL_TITLE = "角色法术",
    ITEM_TITLE = "背包物品",
    ITEMS_EQUIPPED = "已装备（可使用）",
    ITEMS_USABLE = "可使用",
    ITEMS_OTHER = "其他物品",
    LIST_EMPTY = "没有可显示的内容。",
    MENU_MACROTEXT = "编写宏...",
    MENU_COMMAND = "WoW 命令...",
    MENU_CLEAR = "清空",
    MENU_PICKUP_HINT = "或将法术 / 物品 / 宏 / 坐骑放到这里",
    MACRO_TITLE = "宏文本",
    MACRO_HELP = "每行一条命令，例如 /cast 火球术（最多 255 个字符）",
    OK = "确定",
    CANCEL = "取消",
    COMMAND_TITLE = "WoW 命令",
    SEARCH = "搜索：",
    COMMAND_LT_RT = "WoW 命令只能用在没有 LT/RT 层的按键的“单独”层上。",

    KIND_spell = "法术",
    KIND_item = "物品",
    KIND_toy = "玩具",
    KIND_mount = "坐骑",
    KIND_macro = "宏",
    KIND_macrotext = "自定义宏",
    KIND_command = "WoW 命令",
    KIND_equipset = "装备方案",

    CURSOR_UNSUPPORTED = "这个不能放到按键上（只能是法术、物品、玩具、坐骑、宏和装备方案）。",
    APPLIED_AFTER_COMBAT = "战斗中：更改将在战斗结束后生效。",
    APPLIED = "更改已应用。",
    LEARN_PROMPT = "请按下用于 |cffffd100%s|r 的手柄按键\n\n（Esc 取消）",
    LEARN_COMBAT = "战斗中无法检测按键。",
    LEARN_DONE = "%s 现在对应键位 %s。",
    LEARN_TAKEN = "键位 %s 原先由 %s 使用：已从中移除。",
    LEARN_MODKEY = "注意：%s 是 Shift / Ctrl / Alt 键；在 GameSir Nexus 中最好使用 F9-F12 之类的键。",
    LEARN_BOUND = "提示：%s 在 WoW 中绑定为“%s”；本插件使用它时，以插件为准。",

    TEST_INTRO = "按任意按键：WoW 收到的输入会亮起。如果 L5 / R5 / L4 / R4 没有反应，请在 GameSir Nexus 中为它们设置键盘按键（见帮助）。",
    TEST_STANDARD = "标准按键",
    TEST_EXTRA = "额外按键",
    TEST_LOG = "最近输入",
    TEST_GAME = "游戏",
    TEST_UNKNOWN = "未分配",

    IF_WARNING = "已加载 Improved Forever：如果它也使用这些键位之一，以最后应用的绑定为准。",
    OPEN_CONFIG = "打开设置",
    SETTINGS_DESC = "设置 GameSir G7 Pro 的额外按键（L5/R5、L4/R4）。命令：/mgir",
    LOADED = "已加载。输入 /mgir 设置额外按键。",
    SLASH_HELP = "/mgir : 打开  |  /mgir test : 手柄测试  |  /mgir tuto : 教程  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : 重置此角色的动作",
    RESET_DONE = "此角色的动作已重置。",

    DPAD_UP = "十字键上",
    DPAD_DOWN = "十字键下",
    DPAD_LEFT = "十字键左",
    DPAD_RIGHT = "十字键右",
    PADDLE = "背键 %s",

    TUTO_TITLE = "教程",
    TUTO_NEXT = "下一步",
    TUTO_BACK = "上一步",
    TUTO_SKIP = "跳过教程",
    TUTO_FINISH = "打开设置",
    TUTO_REOPEN = "教程已关闭。输入 /mgir tuto 可再次查看。",
    TUTO_SUGGESTED = "使用推荐模式",
    HELP_REPLAY = "重新查看教程",

    TUTO_WELCOME_TITLE = "欢迎使用 My Gamepad Is Rich",
    TUTO_WELCOME_TEXT = "本插件让你在 WoW 中使用 GameSir G7 Pro 的额外按键：\n\n"
        .. "|cffffd100L5 / R5|r：第三扳机\n"
        .. "|cffffd100L4 / R4|r：背部拨片\n\n"
        .. "每个键都可以作为按住的修饰键（与 A、B、X、Y 和十字键组成 8 个新组合），"
        .. "也可以作为拥有独立 LT 和 RT 层的普通按键。\n\n"
        .. "本教程大约需要两分钟。你可以随时退出，并用 |cffffd100/mgir tuto|r 再次打开。",

    TUTO_NEXUS_TITLE = "第 1 步：GameSir Nexus",
    TUTO_NEXUS_TEXT = "Windows 会把 G7 Pro 识别为 Xbox 360 手柄。此模式只传输标准按键，"
        .. "因此 WoW 永远收不到 L5、R5、L4 和 R4。解决办法：让它们发送键盘按键。\n\n"
        .. "1. 连接手柄并打开 |cffffd100GameSir Nexus|r（Microsoft Store）。\n"
        .. "2. 打开按键映射页面。\n"
        .. "3. 为 L5、R5、L4 和 R4 设置你在 WoW 中不用的键盘按键。推荐：|cffffd100F9、F10、F11、F12|r，"
        .. "或小键盘（打开 Num Lock）。\n"
        .. "4. 避免使用 Shift、Ctrl 和 Alt：它们会改变你的其他快捷键。\n"
        .. "5. 将配置保存到手柄。\n\n"
        .. "完成了吗？进入下一步。",

    TUTO_DETECT_TITLE = "第 2 步：检测按键",
    TUTO_DETECT_TEXT = "对每个按键，点击 |cffffd100检测|r，然后按下手柄上的这个键。"
        .. "它发送的键位会显示在旁边。",
    TUTO_DETECT_ALL = "|cff40ff40四个按键都已检测到。|r",
    TUTO_DETECT_MISSING = "按下后没有反应？请在 GameSir Nexus 中检查该键的设置，然后重试。",

    TUTO_MODES_TITLE = "第 3 步：选择模式",
    TUTO_MODES_TEXT = "|cffffd100修饰键|r：按住该键，再按 A、B、X、Y 或十字键。每个键 8 个动作，与 LT、RT 相同。\n"
        .. "|cffffd100普通按键|r：一个动作，外加按住 LT 时一个、按住 RT 时一个。\n"
        .. "|cffffd100禁用|r：键位保持空闲。\n\n"
        .. "推荐：L5 和 R5 设为修饰键（容易按住），L4 和 R4 设为普通按键。",

    TUTO_ACTIONS_TITLE = "第 4 步：放置动作",
    TUTO_ACTIONS_TEXT = "在设置窗口中，每个按键都会显示它的格子。\n\n"
        .. "- 将法术书中的法术、背包里的物品、宏、坐骑或玩具拖到格子上。\n"
        .. "- 或右键点击格子：选择法术或背包物品、编写宏、选择 WoW 命令（如自动奔跑），或清空。\n\n"
        .. "动作按角色保存；键位和模式对整个账号生效。"
        .. "所有功能在战斗中都可用；只有战斗中做的更改会等到战斗结束后生效。",

    TUTO_DONE_TITLE = "一切就绪",
    TUTO_DONE_TEXT = "打开设置，放置你的第一批动作。\n\n"
        .. "|cffffd100/mgir|r：打开设置\n"
        .. "|cffffd100/mgir test|r：手柄测试，查看 WoW 收到的输入\n"
        .. "|cffffd100/mgir tuto|r：本教程\n"
        .. "|cffffd100/mgir reset|r：清空此角色的动作",
})

-- HUD
ns.AddLocale("zhCN", {
    HUD_UNLOCKED = "HUD 已解锁：用鼠标拖动。再次输入 /mgir hud 锁定。",
    HUD_LOCKED = "HUD 已锁定。",
    HUD_ON = "HUD 已显示：它取代游戏的手柄动作条。",
    HUD_OFF = "HUD 已隐藏：游戏的手柄动作条已恢复。输入 /mgir hud on 重新显示。",
    HUD_SCALE = "HUD 大小：%s",
    TUTO_HUD_TITLE = "你的手柄 HUD",
    TUTO_HUD_TEXT = "本插件用自己的 HUD 取代游戏的手柄动作条，位于屏幕下方：\n\n"
        .. "- |cffffd100大图|r：你正在使用的层，左边是十字键，右边是 A/B/X/Y。按住 LT、RT、L5 或 R5 即可切换。\n"
        .. "- |cffffd100缩略图栏|r（在下方，或用 /mgir hud strip 移到上方）：所有层的缩略图（单独、LT、RT、LT+RT、L5、R5）；按住的那一层会亮起。\n"
        .. "- |cffffd100中间|r：L4 和 R4，以及按住扳机时将触发的动作。\n\n"
        .. "非战斗状态且没有按住任何键时，它会变淡。\n"
        .. "|cffffd100/mgir hud|r：移动  -  |cffffd100/mgir hud scale 1.2|r：大小  -  |cffffd100/mgir hud off|r：恢复游戏动作条",
})

-- HUD : attribution rapide
ns.AddLocale("zhCN", {
    HUD_COMBAT = "战斗中无法更改动作。",
    HUD_GAME_SLOT = "此按键保留游戏自带的动作（跳跃、互动……）。",
    HUD_KIND = "游戏动作条只接受法术、物品、坐骑和宏列表中的宏。",
    HUD_EDITING = "正在编辑此层：点击格子进行设置，右键清空。再次点击缩略图返回。",
    HUD_TILE_HINT = "点击：设置  -  右键：清空",
    HUD_CARD_HINT = "点击：编辑此层",
})

-- HUD : bande des miniatures
ns.AddLocale("zhCN", {
    HUD_STRIP_TOP = "各层缩略图现在位于 HUD 上方。输入 /mgir hud strip 切换。",
    HUD_STRIP_BOTTOM = "各层缩略图现在位于 HUD 下方。输入 /mgir hud strip 切换。",
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("zhCN", {
    TUTO_STRIP_LABEL = "各层缩略图：",
    TUTO_STRIP_BOTTOM = "下方（推荐）",
    TUTO_STRIP_TOP = "上方",
})

-- Bouton de la minimap
ns.AddLocale("zhCN", {
    MINIMAP_LEFT = "左键：打开设置",
    MINIMAP_RIGHT = "右键：解锁 / 锁定 HUD 以便移动",
    MINIMAP_SHIFT = "Shift + 左键：教程",
    MINIMAP_DRAG = "拖动：沿小地图移动此按钮",
    MINIMAP_HIDDEN = "小地图按钮已隐藏。输入 /mgir minimap 重新显示。",
    MINIMAP_SHOWN = "小地图按钮已显示。",
})

-- Paires de modificateurs (L5 + R5, L4 + R4)
ns.AddLocale("zhCN", {
    PAIR_READY = "组合 · 同时按住",
    PAIR_NOT_READY = "组合 · 不可用",
    PAIR_DESC = "同时按住 %s 和 %s，再按 A、B、X、Y 或十字键：再多 8 个组合。",
    PAIR_NEEDS = "要使用此组合，%s 和 %s 都必须是已设置键位的修饰键模式。",
    TUTO_PAIRS_TEXT = "|cffffd100组合|r：当 L5 和 R5 都是修饰键时，同时按住它们可再获得 8 个组合。L4 + R4 同理。",
})

-- Fenêtre de configuration (onglets Actions, Boutons, HUD)
ns.AddLocale("zhCN", {
    TAB_ACTIONS = "动作",
    TAB_HUD = "HUD",
    SECTION_PAD = "手柄动作条",
    SECTION_MODS = "修饰键",
    SECTION_MODS_EMPTY = "暂无：请在“按键”标签页中把一个按键设为修饰键。",
    SECTION_SIMPLE = "普通按键",
    SECTION_SIMPLE_EMPTY = "暂无：请在“按键”标签页中把一个按键设为普通按键。",
    LAYER_DESC_BASE = "不按住任何键时的 A、B、X、Y 和十字键。A、B、X、Y 保留游戏自带的动作（跳跃、互动……）。",
    LAYER_DESC_HOLD = "按住 %s，再按 A、B、X、Y 或十字键。",
    BUTTONS_INTRO = "你的额外按键：GameSir Nexus 发送的键位，以及每个键的作用。将鼠标移到模式上可查看说明。",
    PAIRS_TITLE = "组合（同时按住两个修饰键）",
    HUD_INTRO = "HUD 取代游戏的手柄动作条：正在使用的层放大显示，所有层以缩略图显示。",
    HUD_SHOW = "显示 HUD（代替游戏的手柄动作条）",
    HUD_SIZE = "大小：",
    HUD_MOVE = "移动 HUD",
    HUD_MOVE_DONE = "锁定 HUD",
    HUD_RESET = "重置位置和大小",
    MINIMAP_SHOW = "小地图旁的按钮",
    GAME_ACTION = "游戏",
    BAR_UNAVAILABLE = "游戏的手柄动作条不可用（手柄界面是否已开启？）。",
    KIND_slot = "动作",
    SLOT_HINT = "将法术、物品、宏或坐骑拖到格子上。点击：菜单。右键：清空。",
})

-- HUD : taille et lignes des miniatures
ns.AddLocale("zhCN", {
    HUD_STRIP_SIZE = "缩略图大小：",
    HUD_STRIP_ROWS = "缩略图行数：",
})
