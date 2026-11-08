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
    TUTO_SUGGESTED = "使用推荐模式",
    HELP_REPLAY = "重新查看教程",

    TUTO_WELCOME_TITLE = "欢迎使用 My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "对每个按键，点击 |cffffd100检测|r，然后按下手柄上的这个键。"
        .. "它发送的键位会显示在旁边。",


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

-- Paires de modificateurs
ns.AddLocale("zhCN", {
    PAIR_READY = "组合 · 同时按住",
    PAIR_NOT_READY = "组合 · 不可用",
    PAIR_DESC = "同时按住 %s 和 %s，再按 A、B、X、Y 或十字键：再多 8 个组合。",
    PAIR_NEEDS = "要使用此组合，%s 和 %s 都必须是已设置键位的修饰键模式。",
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
    LAYER_DESC_BASE = "不按住任何键时的 A、B、X、Y 和十字键。这里可以放任何东西：游戏动作条无法容纳的（手写宏、WoW 指令）由插件接管。在你放入自己的动作之前，A、B、X、Y 保留游戏的动作（跳跃、互动…）。",
    LAYER_DESC_HOLD = "按住 %s，再按 A、B、X、Y 或十字键。",
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

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("zhCN", {
    CONTROLLER_LABEL = "手柄：",
    CONTROLLER_CHANGE = "更换…",
    CONTROLLER_PICK = "选择你的手柄",
    CONTROLLER_OTHER = "其他手柄",
    EXTRA = "按键",
    SOFTWARE_GENERIC = "手柄的配套软件",
    SETTINGS_DESC = "设置手柄的额外按键（背键、额外扳机）。命令：/mgir",
    BUTTONS_INTRO = "你的手柄及其额外按键：每个键发送的键位，以及它的作用。将鼠标移到模式上可查看说明。",
    TEST_INTRO = "按任意按键：WoW 收到的输入会亮起。如果额外按键没有反应，请在手柄的配套软件中为它们设置键盘按键（见帮助）。",
    LEARN_MODKEY = "注意：%s 是 Shift / Ctrl / Alt 键；在手柄的配套软件中最好使用 F9-F12 之类的键。",

    TUTO_WELCOME_TEXT = "本插件让你在 WoW 中使用手柄的额外按键：背键、额外扳机或肩键"
        .. "（GameSir、Xbox Elite、DualSense Edge、SCUF、8BitDo、飞智…）。\n\n"
        .. "每个键都可以作为按住的修饰键（与 A、B、X、Y 和十字键组成 8 个新组合），"
        .. "也可以作为拥有独立 LT 和 RT 层的普通按键。\n\n"
        .. "本教程大约需要两分钟。你可以随时退出，并用 |cffffd100/mgir tuto|r 再次打开。",

    TUTO_CONTROLLER_TITLE = "第 1 步：你的手柄",
    TUTO_CONTROLLER_TEXT = "选择你的手柄：插件会使用它的按键名称，并告诉你用哪个软件设置这些按键。"
        .. "列表里没有？请选择 |cffffd100其他手柄|r（最多 6 个按键，可重命名）。",

    TUTO_SOFTWARE_TITLE = "第 2 步：让按键发送键盘按键",
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

    TUTO_DETECT_TITLE = "第 3 步：检测按键",
    TUTO_DETECT_ALL = "|cff40ff40所有按键都已检测到。|r",
    TUTO_DETECT_MISSING = "按下后没有反应？请在手柄的配套软件（第 2 步）中检查该键的设置，然后重试。",

    TUTO_MODES_TITLE = "第 4 步：选择模式",
    TUTO_MODES_TEXT = "|cffffd100修饰键|r：按住该键，再按 A、B、X、Y 或十字键。每个键 8 个动作，与 LT、RT 相同。\n"
        .. "|cffffd100普通按键|r：一个动作，外加按住 LT 时一个、按住 RT 时一个。\n"
        .. "|cffffd100禁用|r：键位保持空闲。\n\n"
        .. "推荐：最容易按住的键设为修饰键，其余设为普通按键。",
    TUTO_PAIRS_TEXT = "|cffffd100组合|r：按键按左 + 右成对。当一对中的两个键都是修饰键时，同时按住它们可再获得 8 个组合。",

    TUTO_ACTIONS_TITLE = "第 5 步：放置动作",

    TUTO_HUD_TEXT = "本插件用自己的 HUD 取代游戏的手柄动作条，位于屏幕下方：\n\n"
        .. "- |cffffd100大图|r：你正在使用的层，左边是十字键，右边是 A/B/X/Y。按住 LT、RT 或修饰键即可切换。\n"
        .. "- |cffffd100缩略图栏|r（在下方，或用 /mgir hud strip 移到上方）：所有层的缩略图（单独、LT、RT、LT+RT、你的修饰键和组合）；按住的那一层会亮起。\n"
        .. "- |cffffd100中间|r：你的普通按键，以及按住扳机时将触发的动作。\n\n"
        .. "非战斗状态且没有按住任何键时，它会变淡。\n"
        .. "|cffffd100/mgir hud|r：移动  -  |cffffd100/mgir hud scale 1.2|r：大小  -  |cffffd100/mgir hud off|r：恢复游戏动作条",
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
    TRIGGERS_GAME_DESC = "LT 和 RT 保留游戏手柄动作条的层（可在“动作”标签页编辑）。",
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
    EMULATION_OFF = "%s 交给插件期间不再模拟 Shift / Ctrl。停用插件前请输入 /mgir restore。",
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
