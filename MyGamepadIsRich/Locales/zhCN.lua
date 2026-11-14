-- 简体中文
local _, ns = ...

ns.AddLocale("zhCN", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "按键",
    TAB_TEST = "手柄测试",
    TAB_HELP = "帮助",

    NAME = "名称：",
    KEY = "键位：",
    KEY_NONE = "未设置",
    DETECT = "检测",
    CLEAR = "清除",
    MODE_MODIFIER = "修饰键",
    MODE_SIMPLE = "普通按键",
    MODE_OFF = "禁用",
    MODE_MODIFIER_DESC = "按住此键，再按 A、B、X、Y 或十字键：8 个新组合，与 LT/RT 相同。",
    MODE_SIMPLE_DESC = "一个动作，外加按住 LT 时的一个动作和按住 RT 时的一个动作。空的层不执行任何动作。",
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
    MENU_ICON = "更换图标...",
    ICON_TITLE = "选择图标",
    ICON_HINT = "按法术、物品或魔兽世界命令名称搜索，或输入图标文件名（如 Wowhead 上的 inv_misc_map_01）。",
    ICON_DEFAULT = "默认图标",
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
    LEARN_BOUND = "提示：%s 在 WoW 中绑定为“%s”；本插件使用它时，以插件为准。",

    TEST_STANDARD = "标准按键",
    TEST_EXTRA = "额外按键",
    TEST_LOG = "最近输入",
    TEST_GAME = "游戏",
    TEST_UNKNOWN = "未分配",

    IF_WARNING = "已加载 Improved Forever：如果它也使用这些键位之一，以最后应用的绑定为准。",
    OPEN_CONFIG = "打开设置",
    LOADED = "已加载。输入 /mgir 设置额外按键。",
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
    HELP_REPLAY = "重新查看教程",

    TUTO_WELCOME_TITLE = "欢迎使用 My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "对每个按键，点击 |cffffd100检测|r，然后按下手柄上的这个键。"
        .. "它发送的键位会显示在旁边。",



    TUTO_DONE_TITLE = "一切就绪",
})

-- HUD
ns.AddLocale("zhCN", {
    HUD_UNLOCKED = "HUD 已解锁：用鼠标拖动（分离的缩略图单独移动）。锁定：点击 HUD 上的锁，或再次输入 /mgir hud。",
    HUD_LOCKED = "HUD 已锁定。",
    HUD_SCALE = "HUD 大小：%s",
    TUTO_HUD_TITLE = "你的手柄 HUD",
})

-- HUD : attribution rapide
ns.AddLocale("zhCN", {
    HUD_COMBAT = "战斗中无法更改动作。",
    HUD_GAME_SLOT = "此按键保留游戏自带的动作（跳跃、互动……）。",
    HUD_KIND = "游戏动作条只接受法术、物品、坐骑和宏列表中的宏。",
    HUD_EDITING = "正在编辑此层：点击格子进行设置，右键清空。再次点击缩略图，或按任意其他按键，即可返回。",
    HUD_TILE_HINT = "点击：设置  -  右键：清空",
    HUD_CARD_HINT = "点击：编辑此层",
})

-- HUD : bande des miniatures
ns.AddLocale("zhCN", {
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("zhCN", {
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

-- Paires de modificateurs
ns.AddLocale("zhCN", {
    PAIR_READY = "组合 · 同时按住",
    PAIR_NOT_READY = "组合 · 不可用",
    PAIR_DESC = "同时按住 %s 和 %s，再按 A、B、X、Y 或十字键：再多 8 个组合。",
    PAIR_NEEDS = "要使用此组合，%s 和 %s 都必须是已设置键位的修饰键模式。",
})

-- Fenêtre de configuration (onglets Actions, Boutons, HUD)
ns.AddLocale("zhCN", {
    TAB_ACTIONS = "层",
    TAB_HUD = "HUD",
    SECTION_PAD = "手柄动作条",
    SECTION_MODS = "修饰键",
    SECTION_MODS_EMPTY = "暂无：请在“按键”标签页中把一个按键设为修饰键。",
    SECTION_SIMPLE = "普通按键",
    SECTION_SIMPLE_EMPTY = "暂无：请在“按键”标签页中把一个按键设为普通按键。",
    LAYER_DESC_BASE = "不按住任何键时的 A、B、X、Y 和十字键。这里可以放任何东西：游戏动作条无法容纳的（手写宏、WoW 指令）由插件接管。在你放入自己的动作之前，A、B、X、Y 保留游戏的动作（跳跃、互动…）。",
    LAYER_DESC_HOLD = "按住 %s，再按 A、B、X、Y 或十字键。",
    PAIRS_TITLE = "组合（同时按住两个修饰键）",
    HUD_INTRO = "HUD 取代游戏的手柄动作条：网格（每层一行），或手柄样式（正在使用的层放大显示，所有层以缩略图显示）。",
    HUD_SIZE = "大小：",
    HUD_MOVE = "解锁 HUD",
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
    HUD_ORDER = "层顺序：",
    HUD_ORDER_RESET = "默认顺序",
    HUD_ORDER_HINT = "箭头：移动一层。在 HUD 上也可以把缩略图（或网格中一行的名称）拖到另一个上。",
    HUD_CARD_DRAG = "拖动：移动它（拖到另一个缩略图上）",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("zhCN", {
    CONTROLLER_LABEL = "手柄：",
    CONTROLLER_CHANGE = "更换…",
    CONTROLLER_PICK = "选择你的手柄",
    CONTROLLER_OTHER = "其他手柄",
    EXTRA = "按键",
    SOFTWARE_GENERIC = "手柄的配套软件",
    TEST_INTRO = "按任意按键：WoW 收到的输入会亮起。如果额外按键没有反应，请在手柄的配套软件中为它们设置键盘按键（见帮助）。",
    LEARN_MODKEY = "注意：%s 是 Shift / Ctrl / Alt 键；在手柄的配套软件中最好使用 F9-F12 之类的键。",



    TUTO_SOFTWARE_WHY = "Windows 会把大多数手柄识别为 Xbox 手柄（XInput）。此模式只传输标准按键，"
        .. "因此 WoW 永远收不到额外按键。解决办法：让每个额外按键发送一个键盘按键。",
    TUTO_SOFTWARE_VENDOR = "1. 连接手柄并打开 |cffffd100%s|r。\n"
        .. "2. 打开按键映射页面。\n"
        .. "3. 为每个额外按键（%s）设置你在 WoW 中不用的键盘按键。推荐：|cffffd100F9、F10、F11、F12|r，"
        .. "或小键盘（打开 Num Lock）。\n"
        .. "4. 避免使用 Shift、Ctrl 和 Alt：它们会改变你的其他快捷键。\n"
        .. "5. 保存配置（如果软件支持，保存到手柄）。",
    TUTO_SOFTWARE_ALT = "如果 %s 无法为这些按键设置键盘按键，请使用 |cffffd100Steam Input|r：将 WoW（或 Battle.net 启动器）"
        .. "作为非 Steam 游戏添加到 Steam，从 Steam 启动，然后在其控制器布局中为每个按键设置一个键。"
        .. "|cffffd100reWASD|r（付费）也可以，无需 Steam。",
    TUTO_SOFTWARE_STEAM = "1. 在 |cffffd100Steam|r 中将 WoW（或 Battle.net 启动器）添加为非 Steam 游戏"
        .. "（游戏 > 添加非 Steam 游戏到我的库），然后从 Steam 启动。\n"
        .. "2. 打开它的控制器布局（Steam 界面覆盖，或 Steam 中该游戏的控制器设置）。\n"
        .. "3. 为每个额外按键（%s）设置你在 WoW 中不用的键盘按键。推荐：|cffffd100F9、F10、F11、F12|r。\n"
        .. "4. 避免使用 Shift、Ctrl 和 Alt：它们会改变你的其他快捷键。\n\n"
        .. "|cffffd100reWASD|r（付费）无需 Steam 也能做到。",

    TUTO_DETECT_ALL = "|cff40ff40所有按键都已检测到。|r",



})

-- Profils : liste, export, import
ns.AddLocale("zhCN", {
    TAB_PROFILES = "配置",
    PROFILES_INTRO = "一个配置包含一个手柄、它的按键，以及每个角色的动作。整个账号同一时间只使用一个配置。HUD 由所有配置共用。",
    PROFILE_ACTIVE = "使用中",
    PROFILE_USE = "使用此配置",
    PROFILE_NEW = "新建…",
    PROFILE_COPY = "复制…",
    PROFILE_RENAME = "重命名…",
    PROFILE_DELETE = "删除",
    PROFILE_EXPORT = "导出…",
    PROFILE_IMPORT = "导入…",
    PROFILE_DEFAULT = "配置",
    PROFILE_IMPORTED = "导入的配置",
    PROFILE_COPY_SUFFIX = "%s（副本）",
    PROFILE_NAME_NEW = "新配置的名称：",
    PROFILE_NAME_COPY = "副本的名称：",
    PROFILE_NAME_RENAME = "“%s”的新名称：",
    PROFILE_DELETE_CONFIRM = "删除配置“%s”？它的按键设置以及你所有角色在此配置中的动作都将丢失。",
    PROFILE_SWITCHED = "当前配置：%s。",
    PROFILE_UNKNOWN = "没有名为“%s”的配置。输入 /mgir profiles 查看列表。",
    PROFILE_COMBAT = "战斗中无法切换配置。",
    PROFILE_LAST = "这是你唯一的配置，无法删除。",
    PROFILE_CREATED = "已创建并启用配置“%s”。请在“按键”标签页设置它的按键。",

    EXPORT_TITLE = "导出“%s”",
    EXPORT_ACTIONS = "包含此角色的动作",
    EXPORT_HUD = "包含 HUD 设置",
    EXPORT_HINT = "文本已选中：按 Ctrl+C 复制，然后粘贴到任何地方（Discord、文本文件…）。在“配置”标签页用“导入”按钮导入。",
    CLOSE = "关闭",

    IMPORT_TITLE = "导入配置",
    IMPORT_PASTE = "在此粘贴导出的文本（Ctrl+V）：",
    IMPORT_EMPTY = "粘贴导出的文本即可查看其内容。",
    IMPORT_BAD = "这不是 My Gamepad Is Rich 导出的文本。",
    IMPORT_VERSION = "此文本来自插件的其他版本，无法读取。",
    IMPORT_DAMAGED = "此文本已损坏或不完整：请重新完整复制。",
    IMPORT_SUMMARY = "配置“%s”，手柄：%s\n已设置按键的按钮 %d 个，动作 %d 个",
    IMPORT_SUMMARY_HUD = "包含 HUD 设置。",
    IMPORT_MACROS = "注意：%d 个手写宏。使用前请先阅读：",
    IMPORT_COMMANDS = "WoW 指令：%s",
    IMPORT_AS_NEW = "新配置：",
    IMPORT_REPLACE = "替换：",
    IMPORT_PICK = "要替换的配置",
    IMPORT_ACTIONS = "导入动作（用于此角色）",
    IMPORT_HUD = "应用 HUD 设置",
    IMPORT_DO = "导入",
    IMPORT_REPLACE_CONFIRM = "替换配置“%s”？它的手柄和按键设置将被覆盖；如果导入动作，此角色的动作也会被覆盖。",
    IMPORT_DONE = "已导入配置“%s”。",

    SELFTEST_OK = "自检：一切正常。",
    SELFTEST_FAIL = "自检：%d 个问题：%s",
    SLASH_HELP = "/mgir : 打开  |  /mgir profile <名称> : 切换配置  |  /mgir test : 手柄测试  |  /mgir tuto : 教程  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : 重置此角色的动作",
})

-- HUD : arrêt après une erreur
ns.AddLocale("zhCN", {
    HUD_ERROR = "HUD 出错：在 /reload 前已停止（恢复游戏动作条）。请报告此消息：%s",
})

-- Gâchettes LT / RT données à l'addon
ns.AddLocale("zhCN", {
    TRIGGERS_LABEL = "LT / RT 扳机：",
    TRIGGERS_ADDON = "插件修饰键",
    TRIGGERS_GAME = "游戏的层",
    TRIGGERS_ADDON_DESC = "按住 LT 或 RT（或两者）再按 A、B、X、Y 或十字键：触发插件的动作，支持插件的全部功能（手写宏、WoW 指令）。它们取代游戏手柄动作条的 LT、RT 和 LT + RT 层；空格子不执行任何操作。LB 和 RB 不变。",
    TRIGGERS_GAME_DESC = "LT 和 RT 保留游戏手柄动作条的层（可在“层”标签页编辑）。",
    TRIGGERS_COPIED = "已将游戏 LT / RT 层中的 %d 个动作复制到插件的层。",
    IMPORT_SUMMARY_TRIGGERS = "LT / RT：插件修饰键。",
})

-- Menu d'une case : pourquoi des choix sont grisés
ns.AddLocale("zhCN", {
    MENU_GAME_BAR_HINT = "手写宏、WoW 指令：请将 LT / RT 交给插件（“按键”标签页，基础按键）",
})

-- Actions de base (celles de Forever sur A/B/X/Y)
ns.AddLocale("zhCN", {
    MENU_GAME = "基础动作…",
    GAME_TITLE = "基础动作",
    KIND_game = "基础动作",
    GAME_jump = "跳跃",
    GAME_cancel = "取消（法术、目标）",
    GAME_search = "搜索（右键点击目标）",
    GAME_attack = "自动攻击",
    GAME_interact = "互动",
})

-- Modes de ciblage (comme LB / RB dans Forever)
ns.AddLocale("zhCN", {
    MODE_TARGET_FRIEND = "友方目标",
    MODE_TARGET_ENEMY = "敌方目标",
    MODE_TARGET_FRIEND_DESC = "与 Forever 的 LB 相同：短按选中最近的友方；按住并用右摇杆瞄准来选择。按住时它也是修饰键：A、B、X、Y 和十字键触发它的 8 个快捷动作。",
    MODE_TARGET_ENEMY_DESC = "与 Forever 的 RB 相同：短按选中最近的敌人；按住并用右摇杆瞄准来选择。按住时它也是修饰键：A、B、X、Y 和十字键触发它的 8 个快捷动作。",
    TARGET_UNAVAILABLE = "找不到 Forever 的目标选择：%s 作为普通修饰键使用。",
})

-- Onglet « Soutenir » (don PayPal)
ns.AddLocale("zhCN", {
    TAB_DONATE = "支持",
    DONATE_TITLE = "支持 My Gamepad Is Rich",
    DONATE_INTRO = "My Gamepad Is Rich 是免费的，并将一直免费。如果它对你有帮助、你想表示感谢，可以通过 PayPal 捐赠任意金额。",
    DONATE_SCAN = "用手机扫描二维码",
    DONATE_LINK = "或复制链接（Ctrl+C）并粘贴到浏览器中：",
    DONATE_THANKS = "捐赠完全自愿，不会解锁任何内容：所有功能对所有人开放。感谢你的支持！",
})

-- Boutons de base (LT, RT, LB, RB)
ns.AddLocale("zhCN", {
    MODE_GAME = "游戏",
    MODE_GAME_DESC = "此按键保留它在游戏中的作用（LT / RT：手柄动作条的层；LB / RB：Forever 的目标选择）。",
    PADS_LABEL = "基础按键：",
    PADS_PICK = "%s：选择模式",
    IMPORT_SUMMARY_PADS = "交给插件的基础按键：%s",
    EMULATION_OFF = "%s 交给插件期间不再模拟 Shift / Ctrl。登出时会自动恢复。",
    RESTORE_DONE = "基础按键已还给游戏，Shift / Ctrl 模拟已恢复。",
})

-- Plus aucun ciblage allié / ennemi configuré
ns.AddLocale("zhCN", {
    TARGET_MISSING_FRIEND = "没有按键可以选中友方：请把 LB 设回“游戏”，或把某个按键设为“友方目标”（“按键”标签页）。",
    TARGET_MISSING_ENEMY = "没有按键可以选中敌人：请把 RB 设回“游戏”，或把某个按键设为“敌方目标”（“按键”标签页）。",
    TARGET_MISSING_BOTH = "没有按键可以选中友方或敌人：请把 LB / RB 设回“游戏”，或把按键设为“友方目标” / “敌方目标”（“按键”标签页）。",
})

-- Onglet Boutons : mention des boutons de base
ns.AddLocale("zhCN", {
    PAD_HINT = "手柄按键：无需检测",
})

-- Case vide d'un bouton simple dans une couche : son action habituelle
ns.AddLocale("zhCN", {
    SIMPLE_USUAL = "照常",
})

-- Manettes standard (sans bouton supplémentaire), noms PlayStation
ns.AddLocale("zhCN", {
    TUTO_NO_EXTRA = "这个手柄没有额外按键：这里无需设置。你可以在“按键”标签页的基础按键中，为 LT、RT、LB 和 RB 设置其他作用。",
    PS_CROSS = "叉",
    PS_CIRCLE = "圆",
    PS_SQUARE = "方",
    PS_TRIANGLE = "三角",
})

-- Paires libres (deux modificateurs quelconques)
ns.AddLocale("zhCN", {
})

-- Paire avec un bouton de base resté au jeu
ns.AddLocale("zhCN", {
})

-- Boutons de base : mode par défaut
ns.AddLocale("zhCN", {
    MODE_IS_DEFAULT = "此按键的默认设置：与游戏中的作用相同。",
})

-- Tutoriel : les types de boutons, boutons de base, paires ; options
ns.AddLocale("zhCN", {
    MODE = "类型：",
    TUTO_WELCOME_TEXT = "这个插件让你决定手柄上每个按键的作用：额外按键（背键、额外扳机：GameSir、Xbox Elite、DualSense Edge、SCUF……）以及基础按键 LT、RT、LB 和 RB。\n\n|cffffd100原理：层。|r单独按下时，A、B、X、Y 和十字键触发 8 个动作。按住一个按键（LT、RT、背键……），同样这 8 个按键会触发另外 8 个动作：这就是一个新的层。每个按住的按键都对应一层。\n\n本教程大约需要两分钟。你可以随时退出，并用 |cffffd100/mgir tuto|r 重新打开。",
    TUTO_CONTROLLER_TITLE = "你的手柄",
    TUTO_CONTROLLER_TEXT = "选择你的手柄：插件会使用其额外按键的名称，并告诉你用哪个软件来设置它们。没有额外按键的普通 Xbox 或 PlayStation 手柄？也选择它：你仍然可以设置 LT、RT、LB 和 RB。列表里没有？选择 |cffffd100其他手柄|r（最多 6 个按键，可以重命名）。",
    TUTO_TYPES_TITLE = "4 种按键类型",
    TUTO_TYPES_TEXT = "每个按键都有一个类型，决定它的作用。你可以在接下来的步骤中选择，也可以随时在 |cffffd100按键|r 标签页中更改（将鼠标悬停在类型上可再次查看说明）。",
    TYPE_MODIFIER_HOW = "按住它，再按 A、B、X、Y 或十字键：一层 8 个动作。单独按下时什么也不做。",
    TYPE_MODIFIER_FOR = "适合：容易一直按住的按键。LT 和 RT 默认为此类型，与游戏中相同。",
    TYPE_TARGET_HOW = "短按选择最近的友方（或敌方）目标；按住并用右摇杆瞄准可以选择其他目标。按住时配合 A、B、X、Y 或十字键：8 个快捷动作，和修饰键一样。",
    TYPE_TARGET_FOR = "适合：对目标施放的治疗和法术。LB（友方）和 RB（敌方）默认为此类型，与游戏中相同。",
    TYPE_SIMPLE_HOW = "按一下触发一个动作。按住 LT 或 RT 时触发另一个动作。它在每个修饰键层中也有一个格子。",
    TYPE_SIMPLE_FOR = "适合：常用的法术、药水、坐骑。",
    TYPE_OFF_HOW = "按键不做任何事：它的按键留作他用。",
    TYPE_OFF_FOR = "适合：你不使用的额外按键（基础按键没有此类型）。",
    TUTO_SOFTWARE_TITLE = "让额外按键发送一个按键",
    TUTO_DETECT_TITLE = "检测你的额外按键",
    TUTO_DETECT_MISSING = "按下后没有反应？在手柄软件中检查该按键的设置，然后重试。",
    TUTO_MODES_TITLE = "额外按键的类型",
    TUTO_MODES_TEXT = "为每个额外按键选择类型（将鼠标悬停在类型上可查看其作用）。\n建议：最容易按住的按键设为修饰键，其他设为普通按键。|cffffd100使用推荐类型|r 会帮你完成。",
    TUTO_SUGGESTED = "使用推荐类型",
    TUTO_PADS_TITLE = "你的基础按键：LT、RT、LB、RB",
    TUTO_PADS_TEXT = "默认（绿色）与游戏中相同：LT 和 RT 是修饰键，LB 选择友方目标，RB 选择敌方目标。游戏手柄动作条上的动作会复制到它们的层中。你也可以更改：例如把 RB 设为普通按键，或把 LB 设为修饰键。",
    TUTO_PADS_DEFAULT = "恢复默认类型",
    TUTO_PAIRS_TITLE = "组合：同时按住两个按键",
    TUTO_PAIRS_TEXT = "同时按住两个按键（修饰键或目标选择）：再多一层 8 个动作。任意两个都能组成组合：L5 + R5、LT + RT、LB + LT……勾选你想要的（之后可在 |cffffd100按键|r 标签页中更改）。默认：左 + 右组合。",
    TUTO_ACTIONS_TITLE = "放置你的动作",
    TUTO_ACTIONS_TEXT = "在 |cffffd100层|r 标签页：左边是你所有的层（单独、LT、RT、你的修饰键和组合）；右边是所选的层，按手柄布局排列。\n\n- 从法术书拖入法术，从背包拖入物品、宏、坐骑或玩具到格子上。\n- 或点击格子：选择法术或物品、编写宏、选择 WoW 命令（自动奔跑……）或基础动作（跳跃、互动……）。右键：清空。\n- 十字键下方那一行：你的普通按键在该层中的格子。\n\n你也可以点击 HUD 上的层缩略图直接编辑。\n\n动作按角色保存；类型和按键保存在配置档中，整个账号通用。所有功能在战斗中都能使用；只有在战斗中做的修改会等到战斗结束后生效。\n\n|cffffd100实用|r：\n- 列表上方的输入框可在所有层中搜索动作。\n- |cffffd100智能消耗品|r（格子菜单）：背包里最好的药水、食物、饮料或绷带，自动更新。\n- 灰色带红色的法术：这个角色还不会。|cffffd100模板和专精...|r 可以移除它们。\n- 在职业训练师处学会新等级：插件会提议在所有地方替换旧等级。",
    TUTO_HUD_TEXT = "插件用自己的 HUD 取代游戏的手柄动作条。在下方选择它的布局：HUD 会立即改变，之后随时可以切换（|cffffd100HUD|r 选项卡，或 HUD 上的小按钮）。\n\n鼠标移到 HUD 上会出现小按钮：|cffffd100锁|r 解锁 HUD 以便用鼠标移动（再点一次锁定），另一个切换布局，|cffffd100齿轮|r 打开 HUD 选项卡进行详细设置（大小、缩略图……）。",
    TUTO_DONE_TEXT = "打开设置来放置你的第一批动作。\n\n|cffffd100/mgir|r：打开设置\n|cffffd100/mgir test|r：手柄测试，查看 WoW 收到的输入\n|cffffd100/mgir tuto|r：本教程\n|cffffd100/mgir reset|r：清空此角色的动作\n|cffffd100/mgir restore|r：把 LT、RT、LB 和 RB 还给游戏\n|cffffd100/mgir rangs|r：用法术的新等级替换旧等级",
    SETTINGS_DESC = "决定手柄上每个按键的作用：额外按键（背键、额外扳机）和基础按键（LT、RT、LB、RB）。命令：/mgir",
    BUTTONS_INTRO = "为每个按键选择类型：将鼠标悬停在类型上可查看其作用。绿色：基础按键的默认类型，与游戏中相同。",
    BUTTONS_TYPES_HELP = "按键类型",
    PAIRS_HINT = "勾选要使用的组合：同时按住两个按键可再获得 8 个动作。任意两个修饰键或目标选择按键都能组成组合（L5 + LT、LB + RT……）。",
    PAIRS_NONE = "至少将两个按键设为修饰键、友方目标或敌方目标，才能组成组合。",
    PAIR_WAITS = "%s 处于“游戏”：请设为修饰键、友方目标或敌方目标（上方）",
})

-- Tutoriel, paires : appuyer sur les boutons pour les trouver
ns.AddLocale("zhCN", {
    TUTO_PAIRS_PRESS = "按下手柄上的一个按键：它所在的组合会以绿色高亮。同时按下两个按键：它们的组合会高亮。",
})

-- LB + LT et RB + RT : l'action de classe de Forever
ns.AddLocale("zhCN", {
    PAIR_CLASS_WARN = "也会触发 Forever 的职业动作",
    PAIR_CLASS_WARN_LONG = "注意：%s 也会触发 Forever 的职业动作（通常是一个法术轮盘，打开时会占用 A、B、X 和 Y；按 B 关闭）。插件无法阻止：最好选择其他组合。",
    PAIR_CLASS_NOTE = "%s 和 %s 也会触发 Forever 的职业动作（通常是会占用 A、B、X 和 Y 的法术轮盘）。插件无法阻止：最好选择其他组合。",
})

-- Forever resté sur sa barre LT / RT
ns.AddLocale("zhCN", {
    FOREVER_STUCK = "Forever 停留在了它的 %s 动作条上（漏掉了一次按键松开）。按一次 %s 即可回到“单独”。",
    HUD_STUCK = "%s 卡住了：按一次 %s",
    HUD_GRID_RECALL_DETACH = "与网格分离",
    TIP_HUD_GRID_RECALL_DETACH = "放大显示离开网格：你可以把它放在任何位置（HUD 的锁，然后拖动）。",
    HUD_GRID_RECALL = "在上方放大显示正在使用的层",
    TIP_HUD_GRID_RECALL = "在网格上方居中放大显示你正在使用的层，每个格子都标有按键。此时网格中该层的行保持小尺寸（金色边框）。",
    HUD_STYLE_LABEL = "HUD 显示：",
    HUD_STYLE_GRID = "网格",
    HUD_STYLE_PAD = "手柄",
    TIP_HUD_STYLE_GRID = "每层一行，按键顺序始终相同：十字键，然后是 X、Y、B、A（左、上、右、下），再是普通按键。正在使用的层在上方放大显示，在网格中显示为金色。",
    TIP_HUD_STYLE_PAD = "手柄样式：正在使用的层放大显示（十字键在左，A/B/X/Y 在右，普通按键在中间），所有层以缩略图显示。",
    HUD_SECTION_GRID = "层网格",
    HUD_GRID_SIZE = "网格大小：",
    HUD_GRID_COLS = "层的列数：",
    TIP_HUD_GRID_SIZE = "网格的大小。下方的“大小”会放大整个 HUD。",
    TIP_HUD_GRID_COLS = "把各层的行分成几列：列越多，网格越宽越矮。",
    HUD_TOOL_TO_GRID = "把 HUD 切换为网格",
    HUD_TOOL_TO_PAD = "把 HUD 切换为手柄布局",
    HUD_ROW_HINT = "点击：放大此层以便编辑",
    HUD_ROW_DRAG = "拖动：移动它（拖到另一行上）",
    TUTO_HUD_GRID_NAME = "网格（推荐）",
    TUTO_HUD_GRID_DESC = "每层一行，按键顺序始终相同，每列顶部显示按键及其颜色：十字键，然后是 X、Y、B、A（左、上、右、下：两个拇指位置一致），再是你的普通按键。上方的放大显示展示你正在使用的层；该层的行变成金色。点击格子可编辑，点击一行的名称可放大该行；拖动名称可调整顺序。HUD 选项卡：大小、列数、放大显示（可与网格分离并放在任意位置）。",
    TUTO_HUD_PAD_NAME = "手柄",
    TUTO_HUD_PAD_DESC = "手柄样式：你正在使用的层放大显示，十字键在左，A/B/X/Y 在右，普通按键在中间并显示将要施放的动作。下方是所有层的缩略图：点击缩略图即可编辑。",
    WHATSNEW_1_4_0 = "• |cffffd100网格 HUD|r：新的布局，每层一行，按键顺序始终相同，每列顶部显示按键及其颜色：十字键，然后是 X、Y、B、A（左、上、右、下），再是普通按键。上方的放大显示展示正在使用的层；在网格中该层显示为金色。每个格子都可直接编辑；点击一行的名称可放大，拖动可调整顺序。\n• HUD 选项卡：网格大小、列数（1 到 3）、是否显示放大显示，以及与网格分离以放在任意位置。你的 HUD 保持当前布局：可在 HUD 选项卡（“HUD 显示”）或用 HUD 上的小按钮切换为网格。\n• |cffffd100卡住的层显示为红色|r：当游戏的 LT / RT 动作条卡住时，HUD 会把该层显示为红色，并提示按哪个键解除。",
})

-- 1.1.0 : spés, état des actions sur le HUD, profils, remplissage rapide, rapport
ns.AddLocale("zhCN", {
    SPEC_NUMBER = "专精 %d",
    SPEC_SWITCHED = "“%s”专精的动作。",
    SPEC_NEW = "新专精“%s”：以上一个专精动作的副本开始。",
    PROFILE_PER_CHAR = "记住每个角色的配置",
    PROFILE_PER_CHAR_DESC = "登录时，每个角色会回到自己上次使用的配置。不勾选时，所有角色都使用账号上次使用的配置。",
    REPORT_BUTTON = "复制报告",
    REPORT_TITLE = "手柄报告",
    REPORT_HINT = "先在手柄测试中按一遍每个按键，然后复制这段文字（Ctrl+C），连同哪些可用、哪些不可用一起发给插件作者。这有助于确认其他手柄的设置。其中不包含角色名或服务器名。",
    WHATSNEW_TITLE = "My Gamepad Is Rich 新内容",
    QUICKFILL_BUTTON = "填满空格",
    QUICKFILL_DESC = "把炉石、已装备的可使用饰品和背包里的消耗品（药水、食物、绷带、药剂……）放进此层的空格，已有的除外。右键点击格子可清空。",
    QUICKFILL_DONE = "已填入 %d 格。",
    QUICKFILL_NONE = "没有可放的：背包里没有此层尚未有的可使用物品。",
})

-- 1.1.0 : modèles de classe, copie de couches, verrou, annulation, véhicules
ns.AddLocale("zhCN", {
    SLASH_HELP = "/mgir : 打开  |  /mgir profile <名称> : 切换配置  |  /mgir test : 手柄测试  |  /mgir tuto : 教程  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : 重置此角色的动作  |  /mgir undo : 撤销上一次动作更改  |  /mgir rangs：替换低等级法术",
    LEARN_PAD_REFUSED = "%s 是手柄的基础按键：插件会自行组合或设置它。请按额外按键（其软件发送的键）。",
    RESET_CONFIRM = "清空此角色在当前配置中的所有动作？",
    RESET_CONFIRM_SPEC = "清空此角色在当前配置中“%s”专精的所有动作？",
    UNDO_HINT = "输入 /mgir undo 可撤销。",
    UNDO_DONE = "动作已恢复到上一次更改之前。",
    UNDO_NONE = "此专精没有可撤销的更改。",
    ACTION_COUNT = "%d 个动作",
    LAYER_COPY_BUTTON = "复制 / 交换…",
    LAYER_COPY_DESC = "将此层的动作复制到另一层，或交换两层的动作（8 格以及普通按键的格子）。",
    LAYER_COPY_TITLE = "%s 层",
    LAYER_COPY_TO = "复制到",
    LAYER_SWAP_WITH = "交换",
    LAYER_COPY_NONE = "没有其他组合层：请先把另一个按键设为修饰键。",
    LAYER_COPY_CONFIRM = "将 %s 层的动作（%d 个）替换为 %s 的动作？",
    LAYER_COPIED = "已将 %s 复制到 %s。",
    LAYER_SWAPPED = "已交换 %s 和 %s。",
    TPL_BUTTON = "模板和专精…",
    TPL_DESC = "职业模板：将此专精的动作保存给整个账号，然后在同职业的其他角色上载入。也可以复制另一个专精的动作。留在游戏动作条上的动作不包括在内。",
    TPL_TITLE = "模板和专精",
    TPL_SECTION_SAVE = "保存",
    TPL_SAVE = "将这些动作保存为模板…",
    TPL_SECTION_LOAD = "载入模板（%s）",
    TPL_SECTION_SPEC = "从专精复制",
    TPL_SECTION_DELETE = "删除模板",
    TPL_SAVE_PROMPT = "模板名称（账号中所有%s角色可用）：",
    TPL_SAVED = "模板“%s”已为%s保存。",
    TPL_REPLACE_CONFIRM = "替换模板“%s”？",
    TPL_LOAD_CONFIRM = "载入模板“%s”？它会替换%s的动作。",
    TPL_LOADED = "模板“%s”已载入。",
    TPL_DELETE_CONFIRM = "为此职业的所有角色删除模板“%s”？",
    TPL_DELETED = "模板“%s”已删除。",
    SPEC_COPY_CONFIRM = "复制“%s”的动作？它们会替换%s的动作。",
    SPEC_COPIED = "已复制“%s”的动作。",
    LATCH = "可锁定",
    LATCH_DESC = "按一下开启此修饰键的层，再按一下关闭：无需按住。按住另一个修饰键时，由它接管。任何设置更改都会解除锁定。仅限额外按键（不含 LT、RT、LB、RB）。",
})

-- 1.1.0 : notes de version (tout ce qui a changé depuis la 1.0.0)
ns.AddLocale("zhCN", {
    WHATSNEW_1_1_5 = "• 友方 / 敌方目标：战斗中松开按键后，按键不再保持按下状态（之前 HUD 会停留在其层上，摇杆也会继续瞄准）。短按仍会切换到下一个目标，长按会保留瞄准的目标。",
    WHATSNEW_1_1_4 = "• 友方 / 敌方目标：每次短按都会切换到下一个目标，即使已有目标，在游戏不向插件提供时间的环境中也是如此。长按会保留用摇杆选中的目标。\n• /mgir etat 会显示短按的识别方式。",
    WHATSNEW_1_1_3 = "• 友方 / 敌方目标：松开按键后，用摇杆选中的目标会保留。只有短按才会选中最近的目标。",
    WHATSNEW_1_1_2 = "• 魔兽世界命令或手写宏可以使用你选择的图标：点击格子，“更换图标...”。搜索可以找到你的法术、物品和魔兽世界命令的图标，或按文件名查找图标（如 Wowhead 上的 inv_misc_map_01）。\n• 常用命令有了自己的图标，不再是钥匙：世界地图、背包、法术书、任务日志、角色、成就、地下城查找器、收藏。",
    WHATSNEW_1_1_1 = "• 普通按键：空的层（LT、RT 或修饰键）现在不执行任何动作，在 HUD 上也保持为空，而不再使用“单独”动作。唯一例外：放在“单独”上的魔兽世界命令。\n• 法术列表现在包含专业技能法术：寻找草药、寻找矿物、钓鱼、烹饪、考古学……",
    WHATSNEW_1_1_0 = "• HUD：插件的动作像游戏动作条一样显示。超出距离为红色，资源不足为蓝色，不可用为灰色，触发特效时金色边框，显示剩余充能，进行中的动作（自动攻击、形态……）高亮。\n• HUD：可以选择各层缩略图的顺序（HUD 标签页的箭头，或把一个缩略图拖到另一个上）。\n• 每个专精有自己的动作。新专精以上一个专精动作的副本开始。\n• 动作标签页：“填满空格”把炉石、饰品和背包里的消耗品放到修饰键层上，“复制 / 交换…”可将组合层复制到另一层，或交换两层。\n• 职业模板：将动作保存给整个账号，并在同职业的其他角色上载入（层列表下方的“模板和专精…”）。也可以复制另一个专精的动作。\n• 可锁定的修饰键（按键页）：按一下开启层，再按一下关闭。\n• /mgir reset 会要求确认，/mgir undo 可撤销重置、模板、专精复制或层复制。\n• 配置：新增“记住每个角色的配置”选项。\n• 卡住的层：交给插件的基础按键在松开前一直属于收到按下的一方，Forever 也不会再卡在 RT（或 LT）动作条上，例如用 RT + A 施放圣骑士的圣印之后。\n• 载具、替换动作条和宠物对战：插件让位，游戏按键正常工作，战斗中也一样。\n• 停用插件前不再需要输入 /mgir restore：每次登出时 LT 和 LB 恢复模拟 Shift / Ctrl，登录时插件再关闭它。\n• 检测会拒绝 A、B、X、Y、十字键和 LT、RT、LB、RB（误按会让它们成为额外按键的键）。\n• 手柄测试标签页：“复制报告”（含最近的层记录），发送它来帮助确认其他手柄。/mgir etat 显示各层的状态。\n• /mgir news：再次显示此窗口。",
})

-- Marqueurs de raid (actions de base)
ns.AddLocale("zhCN", {
    GAME_markquick = "快速标记（每按一次换下一个标记）",
    GAME_mark = "标记：%s",
    GAME_markclear = "移除标记",
})

-- Se cibler (action de base)
ns.AddLocale("zhCN", {
    GAME_targetself = "选择自己为目标",
})

-- Nouveautés de la 1.1.6
ns.AddLocale("zhCN", {
    WHATSNEW_1_1_6 = "• 基础动作中新增团队标记：“快速标记”每按一次就在目标上放下一个标记（骷髅、十字、方块、月亮、三角、菱形、圆圈、星星），也可以单独选择 8 种标记，以及“移除标记”。\n• 基础动作中新增“选择自己为目标”。\n• 法术的提示信息会显示其等级。\n• 友方 / 敌方目标：现在在 Forever 中每次短按也会切换到下一个目标，右摇杆瞄准会立即响应。松开按键时摇杆仍在倾斜，或长按之后，瞄准的目标会保留。",
})

-- Nouveaux rangs (maître de classe)
ns.AddLocale("zhCN", {
    UPRANK_ASK = "学会了新等级：%s。\n\n替换你的动作中的低等级吗？\n（插件格子 %d 个，游戏动作条格子 %d 个）",
    UPRANK_REPLACE = "替换",
    UPRANK_KEEP = "保留",
    UPRANK_DONE = "已放入新等级：插件格子 %d 个，游戏动作条格子 %d 个。",
})

-- Confort : nouveaux rangs sans demander
ns.AddLocale("zhCN", {
    COMFORT_TITLE = "便利",
    UPRANK_AUTO = "不询问直接替换新的法术等级（插件动作和游戏动作条中的低等级）",
    UPRANK_NONE = "没有需要替换的低等级。",
})

-- Actions de base : cible, focus, sacs, montures
ns.AddLocale("zhCN", {
    GAME_targetlast = "上一个目标",
    GAME_assist = "协助目标",
    GAME_focus = "设为焦点",
    GAME_targetfocus = "选择焦点为目标",
    GAME_follow = "跟随目标",
    GAME_openbags = "打开背包",
    GAME_dismount = "解散坐骑",
    GAME_randommount = "随机偏好坐骑",
})

-- Sorts inconnus
ns.AddLocale("zhCN", {
    SPELL_UNKNOWN = "该角色不会这个法术（天赋、其他专精、其他角色的模板）：这个格子没有作用。",
    UNKNOWN_SECTION = "未知法术",
    UNKNOWN_REMOVE = "移除未知法术",
    UNKNOWN_CONFIRM = "从 %2$s 的动作中移除该角色不会的 %1$d 个法术吗？",
    UNKNOWN_REMOVED = "已移除 %d 个未知法术。",
})

-- Recherche d'une action (onglet Actions)
ns.AddLocale("zhCN", {
    SEARCH_HINT = "查找动作",
    SEARCH_DESC = "输入名称的一部分（法术、物品、宏……）：包含它的层会显示格子数量，这些格子会有金色边框。",
})

-- Consommables intelligents
ns.AddLocale("zhCN", {
    MENU_BEST = "智能消耗品……",
    BEST_TITLE = "智能消耗品",
    KIND_best = "智能消耗品",
    BEST_heal = "最佳治疗药水",
    BEST_mana = "最佳法力药水",
    BEST_food = "最佳食物",
    BEST_drink = "最佳饮料",
    BEST_bandage = "最佳绷带",
    BEST_NONE = "背包中没有",
    BEST_DESC = "使用背包中此类最好的物品；一组用完后使用下一个（战斗中也可以）。列表在脱战时跟随背包更新。",
})

-- Vibrations
ns.AddLocale("zhCN", {
    VIBRATION_OPTION = "手柄震动（可锁定修饰键开启 / 关闭、识别到长按、放入新等级）",
})

-- Bouton simple : sa case dans chaque couche de modificateur
ns.AddLocale("zhCN", {
    SIMPLE_MOD_ROW = "按住修饰键时（空：不做任何事）",
})

-- HUD : couches séparées, en colonne
ns.AddLocale("zhCN", {
    HUD_LAYERS_LABEL = "层：",
    HUD_DETACH = "与 HUD 分离",
    HUD_VERTICAL = "竖排",
    HUD_STRIP_COLS = "缩略图列数：",
    HUD_TOOL_VERTICAL = "层竖排",
    HUD_TOOL_HORIZONTAL = "层横排",
})

-- HUD : cadenas (verrouiller / déverrouiller)
ns.AddLocale("zhCN", {
    HUD_TOOL_UNLOCK = "解锁：用鼠标移动 HUD",
    HUD_TOOL_LOCK = "锁定 HUD（先把它拖到想要的位置）",
    HUD_TOOL_LOCK_DETACHED = "锁定 HUD（先把 HUD 和层分别拖到各自的位置）",
    HUD_UNLOCKED_HINT = "已解锁：用鼠标拖动（分离的层单独移动）。点击锁图标即可锁定。",
})

-- HUD : bouton vers l'onglet HUD
ns.AddLocale("zhCN", {
    HUD_TOOL_SETTINGS = "HUD 设置（HUD 选项卡）：布局、大小、缩略图……",
})

-- HUD : miniatures des couches cachées
ns.AddLocale("zhCN", {
    HUD_HIDE_STRIP = "隐藏",
})

-- Onglets réorganisés : Options, sections, Aide en sections, info-bulles
ns.AddLocale("zhCN", {
    TAB_OPTIONS = "选项",
    ACTIONS_INTRO = "每个按键触发什么。在左侧选择一个层，然后在右侧的格子里放上动作。",
    OPTIONS_INTRO = "插件的通用设置：既不属于按键、也不属于层或 HUD 显示的内容。",
    OPTIONS_SECTION_UI = "界面",
    HUD_SECTION_STRIP = "层缩略图",
    HUD_SECTION_PLACE = "HUD 大小和位置",
    HUD_LAYOUT_LABEL = "布局：",
    TEST_OPEN = "测试我的手柄",
    TEST_BACK = "返回按键",
    HELP_INTRO = "在左侧选择一个主题。教程会一步步讲解全部内容。",
    HELP_PRINCIPLE = "原理",
    HELP_COMMANDS = "命令",
    TIP_CONTROLLER = "选择你的手柄：插件会使用其额外按键的名称。",
    TIP_TYPES = "再看一遍每种按键类型的作用：修饰键、目标、简单按键、无。",
    TIP_DETECT = "然后按下手柄上的按键：插件会记住它发送的键。",
    TIP_CLEAR = "清除此按键的键位：它将不再有任何作用。",
    TIP_TEST = "实时查看 WoW 从每个按键收到的信号：按键没有反应时很有用。",
    TIP_REPORT = "出现问题时发给作者的文本（不含角色名和服务器名）。",
    TIP_PROFILE_USE = "使用此配置：它的手柄、按键以及此角色的动作。",
    TIP_PROFILE_NEW = "一个空配置，例如用于另一个手柄。",
    TIP_PROFILE_COPY = "新建一个所选配置的副本，安全地尝试修改。",
    TIP_PROFILE_RENAME = "修改所选配置的名称。",
    TIP_PROFILE_DELETE = "删除所选配置，以及你所有角色在该配置下的动作。",
    TIP_PROFILE_EXPORT = "复制一段文本，用于分享或保存此配置。",
    TIP_PROFILE_IMPORT = "粘贴导出的配置文本（你自己的或其他玩家的）。",
    TIP_HUD_DETACH = "缩略图离开 HUD：可以放在任何位置（点击 HUD 上的锁，然后拖动）。",
    TIP_HUD_VERTICAL = "缩略图竖向排列，而不是横排一行。",
    TIP_HUD_HIDDEN = "不显示缩略图：HUD 只显示当前层。层在“层”标签页中编辑。",
    TIP_HUD_ROWS = "缩略图分布在几行（或几列）。",
    TIP_HUD_STRIP_SIZE = "缩略图的大小，不改变 HUD 其余部分。",
    TIP_HUD_SIZE = "整个 HUD 的大小。",
    TIP_HUD_MOVE = "解锁 HUD，用鼠标拖动（与 HUD 上的锁相同）。再次点击即可锁定。",
    TIP_HUD_RESET = "将 HUD 恢复到原始位置和大小（分离的缩略图回到它下方）。",
    TIP_UPRANK = "学会法术的新等级时，不再询问，直接在所有地方替换旧等级。",
    TIP_VIBRATION = "可锁定修饰键开启或关闭时、放置新等级时，手柄会轻微震动。",
    TIP_MINIMAP = "小地图旁的按钮：点击打开设置，右键移动 HUD。",
})

-- Nouveautés 1.2.0, et l'encart « donne ton avis »
ns.AddLocale("zhCN", {
    WHATSNEW_1_2_0 = "• 窗口按设置顺序重新整理：按键、层（原“动作”标签页）、HUD、选项、配置、帮助。每个设置都有提示，帮助有目录，手柄测试从“按键”标签页打开。\n• 法术新等级：学会新等级时，插件会提议在所有地方替换旧等级（也可以在“选项”中设为自动）。/mgir rangs 检查整本法术书。\n• 智能消耗品（格子菜单）：你最好的药水、食物、饮料或绷带，自动更新。\n• 这个角色不会的法术显示为红色；“模板和专精...”可以移除它们。\n• 输入框可在所有层中搜索动作。\n• 新的基础动作：上一个目标、协助、焦点、跟随、打开背包、下坐骑、随机偏好坐骑。\n• HUD：鼠标悬停时出现小按钮（锁用于移动、横排或竖排、设置）；缩略图可以与 HUD 分离、竖排或隐藏。HUD 始终显示。\n• “单独”层的 A、B、X、Y 显示游戏动作，简单按键页面显示它在每个修饰键中的格子。\n• 手柄震动（如果游戏支持）。",
    WHATSNEW_FEEDBACK = "发现问题、有想法或觉得不顺手？告诉我：每条反馈都能帮助改进插件。复制这个链接（Ctrl+C）去 GitHub 留言：",
})

-- 1.3.0：法术目标、按情境动作、循环动作、检查配置、HUD 便利
ns.AddLocale("zhCN", {
    MENU_UNIT = "施放于……",
    MENU_COND = "按情境动作……",
    MENU_SEQ = "循环动作……",
    MENU_PICKUP_CAST = "或将法术或物品拖到这里",
    SLOT_KIND_REFUSED = "这里只能放法术或物品。",
    KIND_cond = "按情境动作",
    KIND_seq = "循环动作",

    UNIT_TITLE = "施放于",
    UNIT_target = "目标（默认）",
    UNIT_CURRENT = "已选",
    UNIT_player = "自己",
    UNIT_helpself = "选中的友方，否则自己",
    UNIT_focus = "焦点",
    UNIT_targettarget = "目标的目标",
    UNIT_pet = "我的宠物",
    UNIT_party = "队友 %s",
    UNIT_TIP = "施放于：%s",

    COND_TITLE = "按情境动作",
    COND_HELP = "一个格子，两个动作：条件成立时执行第一个，否则执行第二个。其中一个可以留空。",
    COND_IF = "条件：",
    COND_THEN = "成立时",
    COND_ELSE = "否则",
    COND_NOTHING = "无",
    COND_NEED_ACTION = "请至少放一个法术或物品。",
    COND_TIP_IF = "%s：%s",
    COND_TIP_ELSE = "否则：%s",
    COND_combat = "战斗中",
    COND_mounted = "骑乘中",
    COND_stealth = "潜行中",
    COND_harm = "我的目标是敌人",
    COND_help = "我的目标是友方",
    COND_exists = "我有目标",
    COND_pet = "我有宠物",
    COND_group = "在队伍中",
    COND_swimming = "游泳中",
    COND_indoors = "室内",
    COND_stance = "形态或姿态 %d",

    SEQ_TITLE = "循环动作",
    SEQ_HELP = "2 到 4 个法术或物品：每按一次施放下一个，然后从头开始。只有法术施放成功，游戏才会进入下一个。",
    SEQ_RESET = "回到第一个：",
    SEQ_RESET_none = "仅在最后一个之后",
    SEQ_RESET_target = "更换目标时",
    SEQ_RESET_combat = "战斗结束时",
    SEQ_RESET_both = "更换目标或战斗结束",
    SEQ_RESET_seconds = "%d 秒未按后",
    SEQ_NEED_TWO = "请至少放两个法术或物品。",
    SEQ_TIP_RESET = "回到第一个：%s",

    GAME_mounttoggle = "上坐骑 / 下坐骑",
    GAME_targetpet = "选择我的宠物为目标",
    GAME_sheet = "显示层速查表",
    GAME_partynext = "下一个队伍友方（自己，然后每位队友）",
    GAME_targetparty = "选择队友 %d 为目标",

    CHECK_BUTTON = "检查我的配置",
    TIP_CHECK = "查找导致按键或格子无法工作的原因：没有按键的按钮、已删除的宏、未知法术、不完整的组合……每一行都可以修复或跳转过去。",
    CHECK_TITLE = "配置检查",
    CHECK_ALL_GOOD = "一切就绪：无需修复。",
    CHECK_SUMMARY = "需修复 %d 项，提示 %d 项。",
    CHECK_FIX = "修复",
    CHECK_GO = "前往",
    CHECK_AGAIN = "重新检查",
    CHECK_CLEAR = "清空格子",
    CHECK_CLEARED = "格子已清空。",
    CHECK_REMOVE = "移除",
    CHECK_REPLACE = "替换",
    CHECK_UNCHECK = "取消勾选",
    CHECK_NO_KEY = "%s 没有按键：它不起作用。在“按键”标签页点击“检测”，或将其设为“禁用”。",
    CHECK_SAME_KEY = "%s 和 %s 使用同一个按键（%s）：只有其中一个有效。",
    CHECK_PAIR_HALF = "组合 %s 已勾选，但 %s 不是修饰键：该组合无效。",
    CHECK_MACRO_GONE = "%s：宏“%s”已不存在于游戏中。该格子不起作用。",
    CHECK_SET_GONE = "%s：装备方案“%s”已不存在。该格子不起作用。",
    CHECK_COMPOSED_EMPTY = "%s：此动作已没有有效的法术或物品。该格子不起作用。",
    CHECK_ITEM_GONE = "%s：%s 既不在背包中也未装备。",
    CHECK_UNKNOWN = "%d 个格子里有此角色不会的法术：它们不起作用。",
    CHECK_LOWER_RANKS = "%d 个格子里是低等级法术，而你已学会更高等级。",
    CHECK_EMPTY_BUTTON = "%s 没有任何动作。",
    CHECK_TAP_SAFE = "此游戏无法测量按下的时长：选择目标按键只在你还没有有效目标时才更换目标。",
    HUD_IDLE_ALPHA = "空闲时不透明度：",
    TIP_HUD_IDLE_ALPHA = "非战斗且未按住任何按键时 HUD 的不透明度。设为 0% 时隐藏：战斗中、按住按键或鼠标悬停时重新出现。",
    SHEET_BUTTON = "层速查表",
    TIP_SHEET = "在屏幕中央放大显示所有层，帮助你记住快捷键。也可用 /mgir map，或放在格子上的基础动作“显示层速查表”。",
    SHEET_TITLE = "速查表：你的所有层",
    SHEET_HINT = "Esc 或 /mgir map 关闭。正在使用的层有金色边框。",

    TUTO_ACTIONS_MORE = "\n|cffffd100进阶|r（格子菜单）：\n- |cffffd100施放于……|r：法术或物品作用于你、焦点、目标的目标、宠物或队友。格子上显示“@”。\n- |cffffd100按情境动作……|r：两个动作和一个条件（战斗中、骑乘中、形态……）。条件成立时执行第一个，否则执行第二个。格子上显示“/”。\n- |cffffd100循环动作……|r：2 到 4 个法术或物品，每按一次下一个。格子上显示步骤（“2/3”）。\n- |cffffd100基础动作|r：“下一个队伍友方”从你依次切换到每位队友；“选择队友为目标”直接选中一位。游戏不允许插件选择受伤最重的友方。\n\n某个按键或格子不起作用？|cffffd100检查我的配置|r（“按键”标签页或 /mgir check）会告诉你原因。",
    TUTO_HUD_MORE = "\n|cffffd100HUD 标签页|r：\n- |cffffd100空闲时不透明度|r：HUD 在非战斗时的可见程度；设为 0% 时隐藏，战斗中或按住按键时重新出现。\n- |cffffd100层速查表|r（或 /mgir map）：在屏幕中央放大显示所有层。",
    HELP_COMMANDS_MORE = "|cffffd100/mgir check|r：检查配置\n|cffffd100/mgir map|r：所有层的速查表",
    SLASH_HELP_MORE = "/mgir check：检查配置  |  /mgir map：层速查表",
    WHATSNEW_1_3_0 = "• 施放于……（格子菜单）：无需写宏，法术或物品即可作用于你、焦点、目标的目标、宠物或队友。\n• 按情境动作：一个格子，两个动作和一个条件（战斗中、骑乘中、潜行中、形态、敌方或友方目标……）。\n• 循环动作：一个格子放 2 到 4 个法术或物品，每按一次下一个。\n• 新基础动作：下一个队伍友方、选择队友 1 到 4、选择宠物、上坐骑 / 下坐骑、速查表。\n• 检查我的配置（“按键”和“帮助”标签页，/mgir check）：列出导致按键或格子无法工作的原因，并提供修复方法。\n• HUD：可调节空闲时不透明度（可在非战斗时隐藏），以及所有层的速查表（/mgir map）。",
})
