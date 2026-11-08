-- 한국어
local _, ns = ...

ns.AddLocale("koKR", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "버튼",
    TAB_TEST = "컨트롤러 테스트",
    TAB_HELP = "도움말",

    NAME = "이름:",
    KEY = "키:",
    KEY_NONE = "설정 안 됨",
    DETECT = "감지",
    CLEAR = "지우기",
    MODE = "모드:",
    MODE_MODIFIER = "수정키",
    MODE_SIMPLE = "단일 버튼",
    MODE_OFF = "사용 안 함",
    MODE_MODIFIER_DESC = "이 버튼을 누른 채로 A, B, X, Y 또는 십자키를 누르세요. LT/RT처럼 새로운 조합 8개가 생깁니다.",
    MODE_SIMPLE_DESC = "기본 동작 하나, LT를 누른 상태의 동작 하나, RT를 누른 상태의 동작 하나. 빈 층은 \"단독\" 동작을 사용합니다.",
    MODE_OFF_DESC = "이 버튼은 아무것도 하지 않으며, 키는 비워 둡니다.",
    LAYER_BASE = "단독",
    LAYER_LT = "LT +",
    LAYER_RT = "RT +",
    SLOT_HINT = "주문, 아이템, 매크로, 탈것을 칸으로 끌어 놓으세요. 오른쪽 클릭: 더 많은 선택지.",
    EMPTY = "비어 있음",
    NO_KEY_WARNING = "먼저 키를 설정하세요. \"감지\"를 클릭한 다음 버튼을 누르세요.",

    MENU_SPELL = "주문 선택...",
    MENU_ITEM = "가방 아이템 선택...",
    SPELL_TITLE = "캐릭터 주문",
    ITEM_TITLE = "가방 아이템",
    ITEMS_EQUIPPED = "착용 중 (사용 가능)",
    ITEMS_USABLE = "사용 가능",
    ITEMS_OTHER = "기타 아이템",
    LIST_EMPTY = "표시할 항목이 없습니다.",
    MENU_MACROTEXT = "매크로 작성...",
    MENU_COMMAND = "WoW 명령...",
    MENU_CLEAR = "비우기",
    MENU_PICKUP_HINT = "또는 여기에 주문 / 아이템 / 매크로 / 탈것을 놓으세요",
    MACRO_TITLE = "매크로 내용",
    MACRO_HELP = "한 줄에 명령 하나, 예: /cast 화염구  (최대 255자)",
    OK = "확인",
    CANCEL = "취소",
    COMMAND_TITLE = "WoW 명령",
    SEARCH = "검색:",
    COMMAND_LT_RT = "WoW 명령은 LT/RT 층이 없는 버튼의 \"단독\" 층에서만 작동합니다.",

    KIND_spell = "주문",
    KIND_item = "아이템",
    KIND_toy = "장난감",
    KIND_mount = "탈것",
    KIND_macro = "매크로",
    KIND_macrotext = "사용자 매크로",
    KIND_command = "WoW 명령",
    KIND_equipset = "장비 구성",

    CURSOR_UNSUPPORTED = "이것은 버튼에 지정할 수 없습니다 (주문, 아이템, 장난감, 탈것, 매크로, 장비 구성만 가능).",
    APPLIED_AFTER_COMBAT = "전투 중: 변경 사항은 전투가 끝나면 적용됩니다.",
    APPLIED = "변경 사항이 적용되었습니다.",
    LEARN_PROMPT = "|cffffd100%s|r에 사용할 컨트롤러 버튼을 누르세요\n\n(Esc: 취소)",
    LEARN_COMBAT = "전투 중에는 버튼을 감지할 수 없습니다.",
    LEARN_DONE = "%s 버튼이 이제 %s 키에 지정되었습니다.",
    LEARN_TAKEN = "%s 키는 %s 버튼이 사용 중이었으므로 그쪽에서 해제했습니다.",
    LEARN_BOUND = "참고: %s 키는 WoW에서 \"%s\"에 지정되어 있었습니다. 이 애드온이 사용하는 동안에는 애드온이 우선합니다.",

    TEST_STANDARD = "기본 버튼",
    TEST_EXTRA = "추가 버튼",
    TEST_LOG = "최근 입력",
    TEST_GAME = "게임",
    TEST_UNKNOWN = "지정 안 됨",

    IF_WARNING = "Improved Forever가 로드되어 있습니다. 같은 키를 사용하면 마지막으로 적용된 지정이 우선합니다.",
    OPEN_CONFIG = "설정 열기",
    LOADED = "로드됨. /mgir를 입력해 추가 버튼을 설정하세요.",
    SLASH_HELP = "/mgir : 열기  |  /mgir test : 컨트롤러 테스트  |  /mgir tuto : 튜토리얼  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : 이 캐릭터의 동작 초기화",
    RESET_DONE = "이 캐릭터의 동작이 초기화되었습니다.",

    DPAD_UP = "십자키 위",
    DPAD_DOWN = "십자키 아래",
    DPAD_LEFT = "십자키 왼쪽",
    DPAD_RIGHT = "십자키 오른쪽",
    PADDLE = "패들 %s",

    TUTO_TITLE = "튜토리얼",
    TUTO_NEXT = "다음",
    TUTO_BACK = "이전",
    TUTO_SKIP = "튜토리얼 건너뛰기",
    TUTO_FINISH = "설정 열기",
    TUTO_REOPEN = "튜토리얼을 닫았습니다. 다시 보려면 /mgir tuto를 입력하세요.",
    TUTO_SUGGESTED = "추천 모드 사용",
    HELP_REPLAY = "튜토리얼 다시 보기",

    TUTO_WELCOME_TITLE = "My Gamepad Is Rich에 오신 것을 환영합니다",


    TUTO_DETECT_TEXT = "각 버튼마다 |cffffd100감지|r를 클릭한 다음 컨트롤러에서 그 버튼을 누르세요. "
        .. "버튼이 보내는 키가 옆에 표시됩니다.",


    TUTO_ACTIONS_TEXT = "설정 창에서 각 버튼의 칸을 볼 수 있습니다.\n\n"
        .. "- 마법책의 주문, 가방의 아이템, 매크로, 탈것, 장난감을 칸으로 끌어 놓으세요.\n"
        .. "- 또는 칸을 오른쪽 클릭: 주문이나 가방 아이템 선택, 매크로 작성, WoW 명령 선택(예: 자동 달리기), 비우기.\n\n"
        .. "동작은 캐릭터별로, 키와 모드는 계정 전체에 저장됩니다. "
        .. "모든 기능은 전투 중에도 작동하며, 전투 중에 바꾼 설정만 전투가 끝난 뒤 적용됩니다.",

    TUTO_DONE_TITLE = "준비 완료",
    TUTO_DONE_TEXT = "설정을 열어 첫 동작을 배치하세요.\n\n"
        .. "|cffffd100/mgir|r: 설정 열기\n"
        .. "|cffffd100/mgir test|r: 컨트롤러 테스트 (WoW가 받는 입력 확인)\n"
        .. "|cffffd100/mgir tuto|r: 이 튜토리얼\n"
        .. "|cffffd100/mgir reset|r: 이 캐릭터의 동작 비우기",
})

-- HUD
ns.AddLocale("koKR", {
    HUD_UNLOCKED = "HUD 잠금 해제: 마우스로 끌어 옮기세요. 다시 잠그려면 /mgir hud를 입력하세요.",
    HUD_LOCKED = "HUD가 잠겼습니다.",
    HUD_ON = "HUD 표시: 게임의 컨트롤러 바를 대신합니다.",
    HUD_OFF = "HUD 숨김: 게임의 컨트롤러 바가 돌아왔습니다. 다시 표시하려면 /mgir hud on을 입력하세요.",
    HUD_SCALE = "HUD 크기: %s",
    TUTO_HUD_TITLE = "컨트롤러 HUD",
})

-- HUD : attribution rapide
ns.AddLocale("koKR", {
    HUD_COMBAT = "전투 중에는 동작을 바꿀 수 없습니다.",
    HUD_GAME_SLOT = "이 버튼은 게임 동작(점프, 상호작용 등)을 유지합니다.",
    HUD_KIND = "게임 바에는 주문, 아이템, 탈것, 매크로 목록의 매크로만 넣을 수 있습니다.",
    HUD_EDITING = "이 층 편집 중: 칸을 클릭해 지정하고, 오른쪽 클릭으로 비우세요. 미리보기를 다시 클릭하면 돌아갑니다.",
    HUD_TILE_HINT = "클릭: 지정  -  오른쪽 클릭: 비우기",
    HUD_CARD_HINT = "클릭: 이 층 편집",
})

-- HUD : bande des miniatures
ns.AddLocale("koKR", {
    HUD_STRIP_TOP = "층 미리보기가 이제 HUD 위에 있습니다. 바꾸려면 /mgir hud strip을 입력하세요.",
    HUD_STRIP_BOTTOM = "층 미리보기가 이제 HUD 아래에 있습니다. 바꾸려면 /mgir hud strip을 입력하세요.",
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("koKR", {
    TUTO_STRIP_LABEL = "층 미리보기:",
    TUTO_STRIP_BOTTOM = "아래 (추천)",
    TUTO_STRIP_TOP = "위",
})

-- Bouton de la minimap
ns.AddLocale("koKR", {
    MINIMAP_LEFT = "왼쪽 클릭: 설정 열기",
    MINIMAP_RIGHT = "오른쪽 클릭: HUD 잠금 해제 / 잠금 (이동용)",
    MINIMAP_SHIFT = "Shift + 왼쪽 클릭: 튜토리얼",
    MINIMAP_DRAG = "끌기: 미니맵 주위로 이 버튼 이동",
    MINIMAP_HIDDEN = "미니맵 버튼을 숨겼습니다. 다시 표시하려면 /mgir minimap을 입력하세요.",
    MINIMAP_SHOWN = "미니맵 버튼을 표시했습니다.",
})

-- Paires de modificateurs
ns.AddLocale("koKR", {
    PAIR_READY = "쌍 · 둘 다 누르기",
    PAIR_NOT_READY = "쌍 · 사용 불가",
    PAIR_DESC = "%s와(과) %s을(를) 함께 누른 채 A, B, X, Y 또는 십자키를 누르세요: 조합 8개 추가.",
    PAIR_NEEDS = "이 쌍을 쓰려면 %s와(과) %s 모두 키가 지정된 수정키 모드여야 합니다.",
})

-- Fenêtre de configuration (onglets Actions, Boutons, HUD)
ns.AddLocale("koKR", {
    TAB_ACTIONS = "동작",
    TAB_HUD = "HUD",
    SECTION_PAD = "컨트롤러 바",
    SECTION_MODS = "수정키",
    SECTION_MODS_EMPTY = "아직 없음: 버튼 탭에서 버튼을 수정키로 설정하세요.",
    SECTION_SIMPLE = "단일 버튼",
    SECTION_SIMPLE_EMPTY = "아직 없음: 버튼 탭에서 버튼을 단일 버튼으로 설정하세요.",
    LAYER_DESC_BASE = "아무것도 누르지 않은 상태의 A, B, X, Y와 십자키. A, B, X, Y는 게임 동작(점프, 상호작용 등)을 유지합니다.",
    LAYER_DESC_HOLD = "%s을(를) 누른 채 A, B, X, Y 또는 십자키를 누르세요.",
    PAIRS_TITLE = "쌍 (함께 누르는 두 수정키)",
    HUD_INTRO = "HUD는 게임의 컨트롤러 바를 대신합니다: 사용 중인 층은 크게, 모든 층은 미리보기로.",
    HUD_SHOW = "HUD 표시 (게임 컨트롤러 바 대신)",
    HUD_SIZE = "크기:",
    HUD_MOVE = "HUD 이동",
    HUD_MOVE_DONE = "HUD 잠그기",
    HUD_RESET = "위치와 크기 초기화",
    MINIMAP_SHOW = "미니맵 주위 버튼",
    GAME_ACTION = "게임",
    BAR_UNAVAILABLE = "게임 컨트롤러 바를 사용할 수 없습니다 (컨트롤러 인터페이스가 켜져 있나요?).",
    KIND_slot = "동작",
    SLOT_HINT = "주문, 아이템, 매크로, 탈것을 칸으로 끌어 놓으세요. 클릭: 메뉴. 오른쪽 클릭: 비우기.",
})

-- HUD : taille et lignes des miniatures
ns.AddLocale("koKR", {
    HUD_STRIP_SIZE = "미리보기 크기:",
    HUD_STRIP_ROWS = "미리보기 줄 수:",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("koKR", {
    CONTROLLER_LABEL = "컨트롤러:",
    CONTROLLER_CHANGE = "변경...",
    CONTROLLER_PICK = "컨트롤러 선택",
    CONTROLLER_OTHER = "기타 컨트롤러",
    EXTRA = "버튼",
    SOFTWARE_GENERIC = "컨트롤러 소프트웨어",
    SETTINGS_DESC = "컨트롤러의 추가 버튼(후면 패들, 추가 트리거)을 설정합니다. 명령어: /mgir",
    BUTTONS_INTRO = "컨트롤러와 추가 버튼: 각 버튼이 보내는 키와 기능. 모드 위에 마우스를 올리면 설명이 나옵니다.",
    TEST_INTRO = "아무 버튼이나 누르세요. WoW가 받은 입력이 켜집니다. 추가 버튼에 아무것도 표시되지 않으면 컨트롤러 소프트웨어에서 키보드 키를 지정하세요 (도움말 참고).",
    LEARN_MODKEY = "주의: %s 키는 Shift / Ctrl / Alt 키입니다. 컨트롤러 소프트웨어에서는 F9-F12 같은 키를 권장합니다.",

    TUTO_WELCOME_TEXT = "이 애드온은 컨트롤러의 추가 버튼(후면 패들, 추가 트리거나 범퍼: "
        .. "GameSir, Xbox Elite, DualSense Edge, SCUF, 8BitDo, Flydigi...)을 WoW에서 쓸 수 있게 해 줍니다.\n\n"
        .. "각 버튼은 누르고 있는 수정키(A, B, X, Y와 십자키로 새로운 조합 8개)가 되거나, "
        .. "LT와 RT 층을 따로 가진 단일 버튼이 될 수 있습니다.\n\n"
        .. "튜토리얼은 2분 정도 걸립니다. 언제든 나갈 수 있으며 |cffffd100/mgir tuto|r로 다시 열 수 있습니다.",

    TUTO_CONTROLLER_TITLE = "1단계: 컨트롤러",
    TUTO_CONTROLLER_TEXT = "컨트롤러를 선택하세요. 애드온이 해당 컨트롤러의 버튼 이름을 쓰고, 버튼을 설정할 소프트웨어를 알려 줍니다. "
        .. "목록에 없나요? |cffffd100기타 컨트롤러|r를 선택하세요(버튼 최대 6개, 이름 변경 가능).",

    TUTO_SOFTWARE_TITLE = "2단계: 버튼이 키를 보내게 하기",
    TUTO_SOFTWARE_WHY = "Windows는 대부분의 컨트롤러를 Xbox 컨트롤러(XInput)로 인식합니다. 이 모드는 기본 버튼만 전달하므로 "
        .. "WoW는 추가 버튼을 받지 못합니다. 해결 방법은 각 버튼이 키보드 키를 보내게 하는 것입니다.",
    TUTO_SOFTWARE_VENDOR = "1. 컨트롤러를 연결하고 |cffffd100%s|r을(를) 여세요.\n"
        .. "2. 버튼 매핑 페이지를 여세요.\n"
        .. "3. 각 추가 버튼(%s)에 WoW에서 쓰지 않는 키를 지정하세요. 추천: |cffffd100F9, F10, F11, F12|r "
        .. "또는 숫자 키패드 (Num Lock 켜기).\n"
        .. "4. Shift, Ctrl, Alt는 피하세요. 다른 단축키가 바뀝니다.\n"
        .. "5. 프로필을 저장하세요(소프트웨어가 지원하면 컨트롤러에).",
    TUTO_SOFTWARE_ALT = "%s에서 이 버튼에 키보드 키를 지정할 수 없다면 |cffffd100Steam Input|r을 쓰세요. "
        .. "WoW(또는 Battle.net 런처)를 Steam에 비 Steam 게임으로 추가하고, Steam에서 실행한 뒤 컨트롤러 레이아웃에서 각 버튼에 키를 지정하세요. "
        .. "|cffffd100reWASD|r(유료)도 Steam 없이 쓸 수 있습니다.",
    TUTO_SOFTWARE_STEAM = "1. |cffffd100Steam|r에서 WoW(또는 Battle.net 런처)를 비 Steam 게임으로 추가하고 "
        .. "(게임 > 비 Steam 게임을 내 라이브러리에 추가), Steam에서 실행하세요.\n"
        .. "2. 해당 게임의 컨트롤러 레이아웃을 여세요(Steam 오버레이 또는 Steam의 게임 컨트롤러 설정).\n"
        .. "3. 각 추가 버튼(%s)에 WoW에서 쓰지 않는 키를 지정하세요. 추천: |cffffd100F9, F10, F11, F12|r.\n"
        .. "4. Shift, Ctrl, Alt는 피하세요. 다른 단축키가 바뀝니다.\n\n"
        .. "|cffffd100reWASD|r(유료)로도 Steam 없이 같은 설정을 할 수 있습니다.",

    TUTO_DETECT_TITLE = "3단계: 버튼 감지",
    TUTO_DETECT_ALL = "|cff40ff40모든 버튼이 감지되었습니다.|r",
    TUTO_DETECT_MISSING = "눌러도 아무 반응이 없나요? 컨트롤러 소프트웨어(2단계)에서 버튼의 키를 확인한 뒤 다시 시도하세요.",

    TUTO_MODES_TITLE = "4단계: 모드 선택",
    TUTO_MODES_TEXT = "|cffffd100수정키|r: 버튼을 누른 채로 A, B, X, Y 또는 십자키를 누르세요. LT, RT처럼 버튼마다 동작 8개.\n"
        .. "|cffffd100단일 버튼|r: 기본 동작 하나, LT를 누른 상태의 동작 하나, RT를 누른 상태의 동작 하나.\n"
        .. "|cffffd100사용 안 함|r: 키를 비워 둡니다.\n\n"
        .. "추천: 누르고 있기 쉬운 버튼은 수정키, 나머지는 단일 버튼.",
    TUTO_PAIRS_TEXT = "|cffffd100쌍|r: 버튼은 왼쪽 + 오른쪽 쌍을 이룹니다. 한 쌍의 두 버튼이 모두 수정키이면 "
        .. "함께 눌러 조합 8개를 더 쓸 수 있습니다.",

    TUTO_ACTIONS_TITLE = "5단계: 동작 배치",

    TUTO_HUD_TEXT = "애드온은 게임의 컨트롤러 바 대신 화면 아래쪽에 자체 HUD를 표시합니다.\n\n"
        .. "- |cffffd100크게|r: 지금 사용하는 층. 왼쪽은 십자키, 오른쪽은 A/B/X/Y. LT, RT 또는 수정키를 누르고 있으면 바뀝니다.\n"
        .. "- |cffffd100미리보기 줄|r(아래, 또는 /mgir hud strip으로 위): 모든 층의 미리보기(단독, LT, RT, LT+RT, 수정키와 쌍). 누르고 있는 층이 켜집니다.\n"
        .. "- |cffffd100가운데|r: 단일 버튼, 그리고 누르고 있는 트리거에 따라 나갈 동작.\n\n"
        .. "전투 중이 아니고 아무것도 누르지 않으면 흐려집니다.\n"
        .. "|cffffd100/mgir hud|r: 이동  -  |cffffd100/mgir hud scale 1.2|r: 크기  -  |cffffd100/mgir hud off|r: 게임 바로 돌아가기",
})
