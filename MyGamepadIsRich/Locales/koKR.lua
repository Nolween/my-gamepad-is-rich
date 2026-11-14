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
    MODE_MODIFIER = "수정키",
    MODE_SIMPLE = "단일 버튼",
    MODE_OFF = "사용 안 함",
    MODE_MODIFIER_DESC = "이 버튼을 누른 채로 A, B, X, Y 또는 십자키를 누르세요. LT/RT처럼 새로운 조합 8개가 생깁니다.",
    MODE_SIMPLE_DESC = "기본 동작 하나, LT를 누른 상태의 동작 하나, RT를 누른 상태의 동작 하나. 빈 층은 아무것도 하지 않습니다.",
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
    MENU_ICON = "아이콘 변경...",
    ICON_TITLE = "아이콘 선택",
    ICON_HINT = "주문, 아이템, WoW 명령 이름으로 검색하거나 아이콘 파일 이름을 입력하세요 (Wowhead처럼: inv_misc_map_01).",
    ICON_DEFAULT = "기본 아이콘",
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
    HELP_REPLAY = "튜토리얼 다시 보기",

    TUTO_WELCOME_TITLE = "My Gamepad Is Rich에 오신 것을 환영합니다",


    TUTO_DETECT_TEXT = "각 버튼마다 |cffffd100감지|r를 클릭한 다음 컨트롤러에서 그 버튼을 누르세요. "
        .. "버튼이 보내는 키가 옆에 표시됩니다.",



    TUTO_DONE_TITLE = "준비 완료",
})

-- HUD
ns.AddLocale("koKR", {
    HUD_UNLOCKED = "HUD 잠금 해제: 마우스로 끌어 옮기세요 (분리된 미니어처는 따로 움직입니다). 잠그려면: HUD의 자물쇠, 또는 다시 /mgir hud.",
    HUD_LOCKED = "HUD가 잠겼습니다.",
    HUD_SCALE = "HUD 크기: %s",
    TUTO_HUD_TITLE = "컨트롤러 HUD",
})

-- HUD : attribution rapide
ns.AddLocale("koKR", {
    HUD_COMBAT = "전투 중에는 동작을 바꿀 수 없습니다.",
    HUD_GAME_SLOT = "이 버튼은 게임 동작(점프, 상호작용 등)을 유지합니다.",
    HUD_KIND = "게임 바에는 주문, 아이템, 탈것, 매크로 목록의 매크로만 넣을 수 있습니다.",
    HUD_EDITING = "이 층 편집 중: 칸을 클릭해 지정하고, 오른쪽 클릭으로 비우세요. 미리보기를 다시 클릭하거나 다른 버튼이나 키를 누르면 돌아갑니다.",
    HUD_TILE_HINT = "클릭: 지정  -  오른쪽 클릭: 비우기",
    HUD_CARD_HINT = "클릭: 이 층 편집",
})

-- HUD : bande des miniatures
ns.AddLocale("koKR", {
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("koKR", {
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
    TAB_ACTIONS = "층",
    TAB_HUD = "HUD",
    SECTION_PAD = "컨트롤러 바",
    SECTION_MODS = "수정키",
    SECTION_MODS_EMPTY = "아직 없음: 버튼 탭에서 버튼을 수정키로 설정하세요.",
    SECTION_SIMPLE = "단일 버튼",
    SECTION_SIMPLE_EMPTY = "아직 없음: 버튼 탭에서 버튼을 단일 버튼으로 설정하세요.",
    LAYER_DESC_BASE = "아무것도 누르지 않은 상태의 A, B, X, Y와 십자키. 무엇이든 넣을 수 있습니다. 게임 바가 담지 못하는 것(직접 작성한 매크로, WoW 명령)은 애드온이 맡습니다. A, B, X, Y는 직접 지정하기 전까지 게임 동작(점프, 상호작용...)을 유지합니다.",
    LAYER_DESC_HOLD = "%s을(를) 누른 채 A, B, X, Y 또는 십자키를 누르세요.",
    PAIRS_TITLE = "쌍 (함께 누르는 두 수정키)",
    HUD_INTRO = "HUD는 게임의 컨트롤러 바를 대신합니다: 격자(층마다 한 줄) 또는 컨트롤러 모양(사용 중인 층은 크게, 모든 층은 미리보기로).",
    HUD_SIZE = "크기:",
    HUD_MOVE = "HUD 잠금 해제",
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
    HUD_ORDER = "층 순서:",
    HUD_ORDER_RESET = "기본 순서",
    HUD_ORDER_HINT = "화살표: 층 이동. HUD에서 미리보기(또는 격자 줄의 이름)를 다른 것 위로 끌어 놓을 수도 있습니다.",
    HUD_CARD_DRAG = "끌기: 이동 (다른 미리보기 위로)",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("koKR", {
    CONTROLLER_LABEL = "컨트롤러:",
    CONTROLLER_CHANGE = "변경...",
    CONTROLLER_PICK = "컨트롤러 선택",
    CONTROLLER_OTHER = "기타 컨트롤러",
    EXTRA = "버튼",
    SOFTWARE_GENERIC = "컨트롤러 소프트웨어",
    TEST_INTRO = "아무 버튼이나 누르세요. WoW가 받은 입력이 켜집니다. 추가 버튼에 아무것도 표시되지 않으면 컨트롤러 소프트웨어에서 키보드 키를 지정하세요 (도움말 참고).",
    LEARN_MODKEY = "주의: %s 키는 Shift / Ctrl / Alt 키입니다. 컨트롤러 소프트웨어에서는 F9-F12 같은 키를 권장합니다.",



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

    TUTO_DETECT_ALL = "|cff40ff40모든 버튼이 감지되었습니다.|r",



})

-- Profils : liste, export, import
ns.AddLocale("koKR", {
    TAB_PROFILES = "프로필",
    PROFILES_INTRO = "프로필에는 컨트롤러, 그 버튼, 그리고 캐릭터별 동작이 들어 있습니다. 계정 전체에서 한 번에 하나의 프로필만 사용합니다. HUD는 모든 프로필에 공통입니다.",
    PROFILE_ACTIVE = "사용 중",
    PROFILE_USE = "이 프로필 사용",
    PROFILE_NEW = "새로 만들기...",
    PROFILE_COPY = "복사...",
    PROFILE_RENAME = "이름 변경...",
    PROFILE_DELETE = "삭제",
    PROFILE_EXPORT = "내보내기...",
    PROFILE_IMPORT = "가져오기...",
    PROFILE_DEFAULT = "프로필",
    PROFILE_IMPORTED = "가져온 프로필",
    PROFILE_COPY_SUFFIX = "%s (사본)",
    PROFILE_NAME_NEW = "새 프로필 이름:",
    PROFILE_NAME_COPY = "사본 이름:",
    PROFILE_NAME_RENAME = "'%s'의 새 이름:",
    PROFILE_DELETE_CONFIRM = "'%s' 프로필을 삭제할까요? 버튼 설정과 모든 캐릭터의 이 프로필 동작이 사라집니다.",
    PROFILE_SWITCHED = "사용 중인 프로필: %s.",
    PROFILE_UNKNOWN = "'%s'라는 프로필이 없습니다. /mgir profiles로 목록을 보세요.",
    PROFILE_COMBAT = "전투 중에는 프로필을 바꿀 수 없습니다.",
    PROFILE_LAST = "유일한 프로필이라 삭제할 수 없습니다.",
    PROFILE_CREATED = "'%s' 프로필을 만들고 사용 중입니다. 버튼 탭에서 키를 설정하세요.",

    EXPORT_TITLE = "'%s' 내보내기",
    EXPORT_ACTIONS = "이 캐릭터의 동작 포함",
    EXPORT_HUD = "HUD 설정 포함",
    EXPORT_HINT = "텍스트가 선택되어 있습니다. Ctrl+C로 복사한 뒤 원하는 곳(Discord, 텍스트 파일...)에 붙여 넣으세요. 프로필 탭의 가져오기 버튼으로 가져옵니다.",
    CLOSE = "닫기",

    IMPORT_TITLE = "프로필 가져오기",
    IMPORT_PASTE = "내보낸 텍스트를 여기에 붙여 넣으세요 (Ctrl+V):",
    IMPORT_EMPTY = "내보낸 텍스트를 붙여 넣으면 내용을 볼 수 있습니다.",
    IMPORT_BAD = "My Gamepad Is Rich에서 내보낸 텍스트가 아닙니다.",
    IMPORT_VERSION = "다른 버전의 애드온에서 만든 텍스트라 읽을 수 없습니다.",
    IMPORT_DAMAGED = "텍스트가 손상되었거나 불완전합니다. 전체를 다시 복사하세요.",
    IMPORT_SUMMARY = "프로필 '%s', 컨트롤러: %s\n키가 있는 버튼 %d개, 동작 %d개",
    IMPORT_SUMMARY_HUD = "HUD 설정이 들어 있습니다.",
    IMPORT_MACROS = "주의: 직접 작성한 매크로 %d개. 사용하기 전에 읽어 보세요:",
    IMPORT_COMMANDS = "WoW 명령: %s",
    IMPORT_AS_NEW = "새 프로필:",
    IMPORT_REPLACE = "교체:",
    IMPORT_PICK = "교체할 프로필",
    IMPORT_ACTIONS = "동작 가져오기 (이 캐릭터)",
    IMPORT_HUD = "HUD 설정 적용",
    IMPORT_DO = "가져오기",
    IMPORT_REPLACE_CONFIRM = "'%s' 프로필을 교체할까요? 컨트롤러와 버튼 설정을 덮어쓰며, 동작을 가져오면 이 캐릭터의 동작도 덮어씁니다.",
    IMPORT_DONE = "'%s' 프로필을 가져왔습니다.",

    SELFTEST_OK = "자체 테스트: 모두 정상입니다.",
    SELFTEST_FAIL = "자체 테스트: 문제 %d개: %s",
    SLASH_HELP = "/mgir : 열기  |  /mgir profile <이름> : 프로필 변경  |  /mgir test : 컨트롤러 테스트  |  /mgir tuto : 튜토리얼  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : 이 캐릭터의 동작 초기화",
})

-- HUD : arrêt après une erreur
ns.AddLocale("koKR", {
    HUD_ERROR = "HUD 오류: /reload 전까지 HUD가 멈춥니다(게임 바가 돌아옵니다). 이 메시지를 알려 주세요: %s",
})

-- Gâchettes LT / RT données à l'addon
ns.AddLocale("koKR", {
    TRIGGERS_LABEL = "LT / RT 트리거:",
    TRIGGERS_ADDON = "애드온 수정키",
    TRIGGERS_GAME = "게임 층",
    TRIGGERS_ADDON_DESC = "LT나 RT(또는 둘 다)를 누른 채 A, B, X, Y 또는 십자키를 누르면 애드온의 동작이 나갑니다(직접 작성한 매크로, WoW 명령 등 모두 가능). 게임 컨트롤러 바의 LT, RT, LT + RT 층을 대신하며, 빈 칸은 아무것도 하지 않습니다. LB와 RB는 바뀌지 않습니다.",
    TRIGGERS_GAME_DESC = "LT와 RT는 게임 컨트롤러 바의 층을 그대로 씁니다(층 탭에서 편집).",
    TRIGGERS_COPIED = "게임의 LT / RT 층에서 동작 %d개를 애드온으로 가져왔습니다.",
    IMPORT_SUMMARY_TRIGGERS = "LT / RT: 애드온 수정키.",
})

-- Menu d'une case : pourquoi des choix sont grisés
ns.AddLocale("koKR", {
    MENU_GAME_BAR_HINT = "직접 작성한 매크로, WoW 명령: LT / RT를 애드온에 맡기세요 (버튼 탭, 기본 버튼)",
})

-- Actions de base (celles de Forever sur A/B/X/Y)
ns.AddLocale("koKR", {
    MENU_GAME = "기본 동작...",
    GAME_TITLE = "기본 동작",
    KIND_game = "기본 동작",
    GAME_jump = "점프",
    GAME_cancel = "취소 (주문, 대상)",
    GAME_search = "찾기 (대상 오른쪽 클릭)",
    GAME_attack = "자동 공격",
    GAME_interact = "상호작용",
})

-- Modes de ciblage (comme LB / RB dans Forever)
ns.AddLocale("koKR", {
    MODE_TARGET_FRIEND = "아군 대상",
    MODE_TARGET_ENEMY = "적 대상",
    MODE_TARGET_FRIEND_DESC = "Forever의 LB처럼: 짧게 누르면 가장 가까운 아군을 대상으로 잡고, 누른 채 오른쪽 스틱으로 겨냥해 고를 수 있습니다. 누르고 있으면 수정키이기도 합니다: A, B, X, Y와 십자키로 단축 동작 8개를 씁니다.",
    MODE_TARGET_ENEMY_DESC = "Forever의 RB처럼: 짧게 누르면 가장 가까운 적을 대상으로 잡고, 누른 채 오른쪽 스틱으로 겨냥해 고를 수 있습니다. 누르고 있으면 수정키이기도 합니다: A, B, X, Y와 십자키로 단축 동작 8개를 씁니다.",
    TARGET_UNAVAILABLE = "Forever의 대상 지정을 찾을 수 없습니다: %s은(는) 일반 수정키로 동작합니다.",
})

-- Onglet « Soutenir » (don PayPal)
ns.AddLocale("koKR", {
    TAB_DONATE = "후원",
    DONATE_TITLE = "My Gamepad Is Rich 후원하기",
    DONATE_INTRO = "My Gamepad Is Rich는 무료이며 앞으로도 무료입니다. 도움이 되었고 감사를 전하고 싶다면 PayPal로 원하는 금액을 후원할 수 있습니다.",
    DONATE_SCAN = "휴대폰으로 QR 코드를 스캔하세요",
    DONATE_LINK = "또는 링크를 복사(Ctrl+C)해 브라우저에 붙여 넣으세요:",
    DONATE_THANKS = "후원은 전적으로 선택 사항이며 아무것도 잠금 해제하지 않습니다. 모든 기능은 누구나 사용할 수 있습니다. 후원해 주셔서 감사합니다!",
})

-- Boutons de base (LT, RT, LB, RB)
ns.AddLocale("koKR", {
    MODE_GAME = "게임",
    MODE_GAME_DESC = "이 버튼은 게임에서의 역할을 유지합니다 (LT / RT: 컨트롤러 바의 층, LB / RB: Forever의 대상 지정).",
    PADS_LABEL = "기본 버튼:",
    PADS_PICK = "%s: 모드 선택",
    IMPORT_SUMMARY_PADS = "애드온에 맡긴 기본 버튼: %s",
    EMULATION_OFF = "%s 버튼은 애드온에 맡겨진 동안 Shift / Ctrl을 흉내 내지 않습니다. 로그아웃하면 자동으로 되돌아갑니다.",
    RESTORE_DONE = "기본 버튼을 게임에 돌려주고 Shift / Ctrl 흉내를 되돌렸습니다.",
})

-- Plus aucun ciblage allié / ennemi configuré
ns.AddLocale("koKR", {
    TARGET_MISSING_FRIEND = "아군을 대상으로 잡는 버튼이 없습니다: LB를 '게임'으로 되돌리거나 버튼 하나를 '아군 대상'으로 설정하세요 (버튼 탭).",
    TARGET_MISSING_ENEMY = "적을 대상으로 잡는 버튼이 없습니다: RB를 '게임'으로 되돌리거나 버튼 하나를 '적 대상'으로 설정하세요 (버튼 탭).",
    TARGET_MISSING_BOTH = "아군도 적도 대상으로 잡는 버튼이 없습니다: LB / RB를 '게임'으로 되돌리거나 버튼을 '아군 대상' / '적 대상'으로 설정하세요 (버튼 탭).",
})

-- Onglet Boutons : mention des boutons de base
ns.AddLocale("koKR", {
    PAD_HINT = "컨트롤러 버튼: 감지할 필요 없음",
})

-- Case vide d'un bouton simple dans une couche : son action habituelle
ns.AddLocale("koKR", {
    SIMPLE_USUAL = "평소대로",
})

-- Manettes standard (sans bouton supplémentaire), noms PlayStation
ns.AddLocale("koKR", {
    TUTO_NO_EXTRA = "이 컨트롤러에는 추가 버튼이 없습니다. 여기서 설정할 것은 없습니다. 버튼 탭의 기본 버튼에서 LT, RT, LB, RB에 다른 역할을 줄 수 있습니다.",
    PS_CROSS = "엑스",
    PS_CIRCLE = "동그라미",
    PS_SQUARE = "네모",
    PS_TRIANGLE = "세모",
})

-- Paires libres (deux modificateurs quelconques)
ns.AddLocale("koKR", {
})

-- Paire avec un bouton de base resté au jeu
ns.AddLocale("koKR", {
})

-- Boutons de base : mode par défaut
ns.AddLocale("koKR", {
    MODE_IS_DEFAULT = "이 버튼의 기본값: 게임에서와 같이 동작합니다.",
})

-- Tutoriel : les types de boutons, boutons de base, paires ; options
ns.AddLocale("koKR", {
    MODE = "유형:",
    TUTO_WELCOME_TEXT = "이 애드온으로 컨트롤러의 모든 버튼이 할 일을 정할 수 있습니다: 추가 버튼(뒷면 패들, 추가 트리거: GameSir, Xbox Elite, DualSense Edge, SCUF...)과 기본 버튼 LT, RT, LB, RB.\n\n|cffffd100원리: 층.|r A, B, X, Y와 십자키는 그 자체로 동작 8개를 실행합니다. 버튼 하나(LT, RT, 패들...)를 누르고 있으면 같은 8개 버튼이 다른 동작 8개를 실행합니다: 새로운 층입니다. 누르고 있는 버튼마다 층이 하나씩 생깁니다.\n\n이 튜토리얼은 약 2분 걸립니다. 언제든 닫을 수 있고 |cffffd100/mgir tuto|r로 다시 열 수 있습니다.",
    TUTO_CONTROLLER_TITLE = "컨트롤러",
    TUTO_CONTROLLER_TEXT = "컨트롤러를 선택하세요. 애드온이 추가 버튼의 이름을 가져오고 설정용 프로그램을 알려 줍니다. 추가 버튼이 없는 일반 Xbox나 PlayStation 컨트롤러인가요? 그래도 선택하세요. LT, RT, LB, RB는 설정할 수 있습니다. 목록에 없나요? |cffffd100기타 컨트롤러|r를 선택하세요(버튼 최대 6개, 이름 변경 가능).",
    TUTO_TYPES_TITLE = "버튼 유형 4가지",
    TUTO_TYPES_TEXT = "각 버튼에는 하는 일을 정하는 유형이 있습니다. 다음 단계에서, 그리고 언제든 |cffffd100버튼|r 탭에서 선택할 수 있습니다(유형 위에 마우스를 올리면 설명을 다시 볼 수 있습니다).",
    TYPE_MODIFIER_HOW = "누른 채로 A, B, X, Y 또는 십자키를 누르세요: 동작 8개의 층. 혼자서는 아무것도 하지 않습니다.",
    TYPE_MODIFIER_FOR = "추천: 누르고 있기 쉬운 버튼. 게임처럼 LT와 RT의 기본값입니다.",
    TYPE_TARGET_HOW = "짧게 누르면 가장 가까운 아군(또는 적)을 대상으로 잡습니다. 누른 채로 오른쪽 스틱으로 조준하면 다른 대상을 고를 수 있습니다. 누른 채로 A, B, X, Y 또는 십자키: 수정키처럼 단축 동작 8개.",
    TYPE_TARGET_FOR = "추천: 대상에게 쓰는 치유와 주문. 게임처럼 LB(아군)와 RB(적)의 기본값입니다.",
    TYPE_SIMPLE_HOW = "한 번 누르면 동작 하나를 실행합니다. LT나 RT를 누른 채로는 다른 동작을 실행합니다. 각 수정키 층에도 칸이 하나 있습니다.",
    TYPE_SIMPLE_FOR = "추천: 자주 쓰는 주문, 물약, 탈것.",
    TYPE_OFF_HOW = "버튼이 아무것도 하지 않습니다: 키는 다른 용도로 비워 둡니다.",
    TYPE_OFF_FOR = "추천: 사용하지 않는 추가 버튼(기본 버튼에는 이 유형이 없습니다).",
    TUTO_SOFTWARE_TITLE = "추가 버튼이 키를 보내게 하기",
    TUTO_DETECT_TITLE = "추가 버튼 감지",
    TUTO_DETECT_MISSING = "눌러도 아무 일도 없나요? 컨트롤러 프로그램에서 버튼의 키를 확인하고 다시 시도하세요.",
    TUTO_MODES_TITLE = "추가 버튼의 유형",
    TUTO_MODES_TEXT = "추가 버튼마다 유형을 선택하세요(유형 위에 마우스를 올리면 하는 일을 볼 수 있습니다).\n팁: 누르고 있기 가장 쉬운 버튼에는 수정키, 나머지에는 단일 버튼. |cffffd100추천 유형 사용|r을 누르면 자동으로 설정됩니다.",
    TUTO_SUGGESTED = "추천 유형 사용",
    TUTO_PADS_TITLE = "기본 버튼: LT, RT, LB, RB",
    TUTO_PADS_TEXT = "기본값(초록색)은 게임과 같이 동작합니다: LT와 RT는 수정키, LB는 아군 대상, RB는 적 대상. 게임 컨트롤러 바의 동작이 해당 층으로 복사됩니다. 바꿀 수도 있습니다: 예를 들어 RB를 단일 버튼으로, LB를 수정키로.",
    TUTO_PADS_DEFAULT = "기본 유형으로 되돌리기",
    TUTO_PAIRS_TITLE = "쌍: 함께 누르는 두 버튼",
    TUTO_PAIRS_TEXT = "두 버튼(수정키 또는 대상 지정)을 함께 누르세요: 동작 8개의 층이 하나 더 생깁니다. 어떤 두 버튼이든 쌍이 될 수 있습니다: L5 + R5, LT + RT, LB + LT... 원하는 쌍을 선택하세요(나중에 |cffffd100버튼|r 탭에서 바꿀 수 있습니다). 기본값: 왼쪽 + 오른쪽 쌍.",
    TUTO_ACTIONS_TITLE = "동작 배치",
    TUTO_ACTIONS_TEXT = "|cffffd100층|r 탭: 왼쪽에는 모든 층(단독, LT, RT, 수정키와 쌍), 오른쪽에는 선택한 층이 컨트롤러 모양으로 표시됩니다.\n\n- 주문서의 주문, 가방의 아이템, 매크로, 탈것, 장난감을 칸으로 끌어다 놓으세요.\n- 또는 칸을 클릭: 주문이나 아이템 선택, 매크로 작성, WoW 명령(자동 달리기...) 또는 기본 동작(점프, 상호작용...) 선택. 오른쪽 클릭: 비우기.\n- 십자키 아래 줄: 이 층에서 단일 버튼의 칸.\n\nHUD의 층 미리보기를 클릭해 그 자리에서 수정할 수도 있습니다.\n\n동작은 캐릭터별로 저장되고, 유형과 키는 계정 전체의 프로필에 저장됩니다. 모든 기능은 전투 중에도 작동하며, 전투 중 변경만 전투가 끝난 뒤 적용됩니다.\n\n|cffffd100편리한 기능|r:\n- 목록 위의 입력란은 모든 층에서 동작을 찾습니다.\n- |cffffd100스마트 소모품|r (칸 메뉴): 가방에서 가장 좋은 물약, 음식, 음료, 붕대를 자동으로 고릅니다.\n- 회색에 빨간 주문: 이 캐릭터가 모르는 주문입니다. |cffffd100템플릿 및 전문화...|r에서 지울 수 있습니다.\n- 직업 전문가에게 새 등급을 배우면: 애드온이 모든 곳에서 이전 등급을 바꿀지 묻습니다.",
    TUTO_HUD_TEXT = "애드온은 게임의 컨트롤러 바를 자체 HUD로 대신합니다. 아래에서 배치를 고르세요: HUD가 바로 바뀌며, 언제든지 바꿀 수 있습니다 (|cffffd100HUD|r 탭 또는 HUD의 작은 버튼).\n\nHUD 위에 마우스를 올리면 작은 버튼이 나타납니다: |cffffd100자물쇠|r는 HUD를 마우스로 옮길 수 있게 잠금을 풀고(다시 잠그고), 다른 버튼은 배치를 바꾸며, |cffffd100톱니바퀴|r는 세부 설정(크기, 미니어처...)을 위한 HUD 탭을 엽니다.",
    TUTO_DONE_TEXT = "설정을 열어 첫 동작을 배치하세요.\n\n|cffffd100/mgir|r: 설정 열기\n|cffffd100/mgir test|r: 컨트롤러 테스트, WoW가 받는 입력 보기\n|cffffd100/mgir tuto|r: 이 튜토리얼\n|cffffd100/mgir reset|r: 이 캐릭터의 동작 비우기\n|cffffd100/mgir restore|r: LT, RT, LB, RB를 게임에 돌려주기\n|cffffd100/mgir rangs|r: 주문의 새 등급으로 이전 등급 바꾸기",
    SETTINGS_DESC = "컨트롤러의 모든 버튼이 할 일을 정하세요: 추가 버튼(뒷면 패들, 추가 트리거)과 기본 버튼(LT, RT, LB, RB). 명령어: /mgir",
    BUTTONS_INTRO = "버튼마다 유형을 선택하세요. 유형 위에 마우스를 올리면 하는 일을 볼 수 있습니다. 초록색: 게임처럼 동작하는 기본 버튼의 기본 유형.",
    BUTTONS_TYPES_HELP = "버튼 유형",
    PAIRS_HINT = "사용할 쌍을 선택하세요. 두 버튼을 함께 누르면 동작 8개가 추가됩니다. 어떤 두 수정키나 대상 지정 버튼이든 쌍이 될 수 있습니다 (L5 + LT, LB + RT...).",
    PAIRS_NONE = "쌍을 만들려면 버튼 두 개 이상을 수정키, 아군 대상 또는 적 대상으로 설정하세요.",
    PAIR_WAITS = "%s: 게임 모드입니다. 수정키, 아군 대상 또는 적 대상으로 설정하세요 (위)",
})

-- Tutoriel, paires : appuyer sur les boutons pour les trouver
ns.AddLocale("koKR", {
    TUTO_PAIRS_PRESS = "컨트롤러의 버튼을 누르면 그 버튼의 쌍이 초록색으로 표시됩니다. 두 버튼을 함께 누르면 그 쌍이 표시됩니다.",
})

-- LB + LT et RB + RT : l'action de classe de Forever
ns.AddLocale("koKR", {
    PAIR_CLASS_WARN = "Forever의 직업 동작도 실행됩니다",
    PAIR_CLASS_WARN_LONG = "주의: %s는 Forever의 직업 동작도 실행합니다(대개 주문 휠이며, 열려 있는 동안 A, B, X, Y를 차지합니다. B로 닫습니다). 애드온이 막을 수 없으니 다른 쌍을 선택하세요.",
    PAIR_CLASS_NOTE = "%s와 %s는 Forever의 직업 동작도 실행합니다(대개 A, B, X, Y를 차지하는 주문 휠). 애드온이 막을 수 없으니 다른 쌍을 고르는 것이 좋습니다.",
})

-- Forever resté sur sa barre LT / RT
ns.AddLocale("koKR", {
    FOREVER_STUCK = "Forever가 %s 바에 머물러 있습니다(버튼 떼기 입력이 누락됨). %s를 한 번 누르면 \"단독\"으로 돌아갑니다.",
    HUD_STUCK = "%s 고정됨: %s를 한 번 누르세요",
    HUD_GRID_RECALL_DETACH = "격자와 분리",
    TIP_HUD_GRID_RECALL_DETACH = "표시가 격자에서 분리됩니다: 원하는 곳에 둘 수 있습니다(HUD 자물쇠, 그다음 끌기).",
    HUD_GRID_RECALL = "사용 중인 층을 위에 크게 표시",
    TIP_HUD_GRID_RECALL = "격자 위 가운데에 사용 중인 층을 크게, 칸마다 버튼과 함께 표시합니다. 그러면 격자 안의 그 층 줄은 작게 유지됩니다(금색 테두리).",
    HUD_STYLE_LABEL = "HUD 표시:",
    HUD_STYLE_GRID = "격자",
    HUD_STYLE_PAD = "컨트롤러",
    TIP_HUD_STYLE_GRID = "층마다 한 줄, 버튼은 항상 같은 순서: 십자키, 그다음 X, Y, B, A(왼쪽, 위, 오른쪽, 아래), 그다음 단일 버튼. 사용 중인 층은 위에 크게, 격자 안에서는 금색으로.",
    TIP_HUD_STYLE_PAD = "컨트롤러처럼: 사용 중인 층은 크게(왼쪽에 십자키, 오른쪽에 A/B/X/Y, 가운데에 단일 버튼), 모든 층은 미리보기로.",
    HUD_SECTION_GRID = "층 격자",
    HUD_GRID_SIZE = "격자 크기:",
    HUD_GRID_COLS = "층 열 수:",
    TIP_HUD_GRID_SIZE = "격자의 크기. 아래의 \"크기\"는 HUD 전체를 키웁니다.",
    TIP_HUD_GRID_COLS = "층 줄을 몇 개의 열로 나눌지: 열이 많을수록 격자가 넓고 낮아집니다.",
    HUD_TOOL_TO_GRID = "HUD를 격자로 바꾸기",
    HUD_TOOL_TO_PAD = "HUD를 컨트롤러 배치로 바꾸기",
    HUD_ROW_HINT = "클릭: 이 층을 크게 해서 편집",
    HUD_ROW_DRAG = "끌기: 이동 (다른 줄 위로)",
    TUTO_HUD_GRID_NAME = "격자 (추천)",
    TUTO_HUD_GRID_DESC = "층마다 한 줄, 버튼은 항상 같은 순서이며 각 열 위에 버튼 색으로 표시됩니다: 십자키, 그다음 X, Y, B, A(왼쪽, 위, 오른쪽, 아래: 두 엄지에 같은 자리), 그다음 단일 버튼. 위쪽 표시에는 사용 중인 층이 크게 나오고, 그 층의 줄은 금색이 됩니다. 칸을 클릭하면 편집하고, 줄 이름을 클릭하면 크게 합니다; 이름을 끌어 순서를 바꿉니다. HUD 탭: 크기, 열 수, 위쪽 표시(격자와 분리해 원하는 곳에 둘 수 있음).",
    TUTO_HUD_PAD_NAME = "컨트롤러",
    TUTO_HUD_PAD_DESC = "컨트롤러처럼: 사용 중인 층은 크게, 왼쪽에 십자키, 오른쪽에 A/B/X/Y, 가운데에 단일 버튼과 나갈 행동. 아래에는 모든 층의 미리보기: 미리보기를 클릭하면 편집합니다.",
    WHATSNEW_1_4_0 = "• |cffffd100격자 HUD|r: 새 배치, 층마다 한 줄, 버튼은 항상 같은 순서이며 각 열 위에 버튼 색으로 표시됩니다: 십자키, 그다음 X, Y, B, A(왼쪽, 위, 오른쪽, 아래), 그다음 단일 버튼. 위쪽 표시에는 사용 중인 층이 크게 나오고, 격자 안에서는 금색이 됩니다. 모든 칸을 바로 편집할 수 있고, 줄 이름을 클릭하면 크게, 끌면 순서가 바뀝니다.\n• HUD 탭: 격자 크기, 열 수(1~3), 위쪽 표시 켜기/끄기, 격자와 분리해 원하는 곳에 두기. 지금 HUD는 현재 배치를 유지합니다: HUD 탭(\"HUD 표시\") 또는 HUD의 작은 버튼으로 격자로 바꾸세요.\n• |cffffd100고정된 층은 빨간색|r: 게임의 LT / RT 바가 고정되면, HUD가 그 층을 빨간색으로 보여 주고 풀려면 누를 버튼을 알려 줍니다.",
})

-- 1.1.0 : spés, état des actions sur le HUD, profils, remplissage rapide, rapport
ns.AddLocale("koKR", {
    SPEC_NUMBER = "전문화 %d",
    SPEC_SWITCHED = "\"%s\" 전문화의 동작입니다.",
    SPEC_NEW = "새 전문화 \"%s\": 이전 전문화의 동작을 복사해서 시작합니다.",
    PROFILE_PER_CHAR = "캐릭터마다 프로필 기억",
    PROFILE_PER_CHAR_DESC = "접속할 때 각 캐릭터가 마지막으로 쓴 프로필로 돌아갑니다. 이 옵션이 없으면 모든 캐릭터가 계정에서 마지막으로 쓴 프로필을 씁니다.",
    REPORT_BUTTON = "보고서 복사",
    REPORT_TITLE = "컨트롤러 보고서",
    REPORT_HINT = "먼저 컨트롤러 테스트에서 모든 버튼을 눌러 본 뒤, 이 텍스트를 복사(Ctrl+C)해서 되는 것과 안 되는 것을 함께 애드온 제작자에게 보내 주세요. 다른 컨트롤러의 설정을 확인하는 데 도움이 됩니다. 캐릭터나 서버 이름은 들어 있지 않습니다.",
    WHATSNEW_TITLE = "My Gamepad Is Rich 새 기능",
    QUICKFILL_BUTTON = "빈 칸 채우기",
    QUICKFILL_DESC = "이 층의 빈 칸에 귀환석, 착용 중인 사용 가능 장신구, 가방의 소모품(물약, 음식, 붕대, 비약...)을 놓습니다. 이미 있는 것은 빼고 놓습니다. 칸을 오른쪽 클릭하면 비웁니다.",
    QUICKFILL_DONE = "%d칸을 채웠습니다.",
    QUICKFILL_NONE = "놓을 것이 없습니다: 이 층에 아직 없는 사용 가능한 아이템이 가방에 없습니다.",
})

-- 1.1.0 : modèles de classe, copie de couches, verrou, annulation, véhicules
ns.AddLocale("koKR", {
    SLASH_HELP = "/mgir : 열기  |  /mgir profile <이름> : 프로필 변경  |  /mgir test : 컨트롤러 테스트  |  /mgir tuto : 튜토리얼  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : 이 캐릭터의 동작 초기화  |  /mgir undo : 마지막 동작 변경 취소  |  /mgir rangs: 낮은 주문 등급 바꾸기",
    LEARN_PAD_REFUSED = "%s은(는) 컨트롤러의 기본 버튼입니다. 애드온이 직접 조합하거나 설정합니다. 추가 버튼(해당 소프트웨어가 보내는 키)을 누르세요.",
    RESET_CONFIRM = "현재 프로필에서 이 캐릭터의 동작을 모두 비울까요?",
    RESET_CONFIRM_SPEC = "현재 프로필에서 이 캐릭터의 '%s' 전문화 동작을 모두 비울까요?",
    UNDO_HINT = "/mgir undo로 되돌릴 수 있습니다.",
    UNDO_DONE = "마지막 변경 전의 동작으로 되돌렸습니다.",
    UNDO_NONE = "이 전문화에는 되돌릴 것이 없습니다.",
    ACTION_COUNT = "동작 %d개",
    LAYER_COPY_BUTTON = "복사 / 교환…",
    LAYER_COPY_DESC = "이 층의 동작을 다른 층으로 복사하거나, 두 층의 동작을 서로 바꿉니다(8칸과 단일 버튼 칸).",
    LAYER_COPY_TITLE = "%s 층",
    LAYER_COPY_TO = "복사할 곳",
    LAYER_SWAP_WITH = "교환할 층",
    LAYER_COPY_NONE = "다른 조합 층이 없습니다. 먼저 다른 버튼을 수정키로 만드세요.",
    LAYER_COPY_CONFIRM = "%s 층의 동작(%d개)을 %s의 동작으로 바꿀까요?",
    LAYER_COPIED = "%s을(를) %s(으)로 복사했습니다.",
    LAYER_SWAPPED = "%s와(과) %s을(를) 교환했습니다.",
    TPL_BUTTON = "템플릿 및 전문화…",
    TPL_DESC = "직업 템플릿: 이 전문화의 동작을 계정 전체에 저장한 뒤 같은 직업의 다른 캐릭터에서 불러옵니다. 다른 전문화의 동작을 복사할 수도 있습니다. 게임 바에 남아 있는 동작은 포함되지 않습니다.",
    TPL_TITLE = "템플릿 및 전문화",
    TPL_SECTION_SAVE = "저장",
    TPL_SAVE = "이 동작을 템플릿으로 저장…",
    TPL_SECTION_LOAD = "템플릿 불러오기 (%s)",
    TPL_SECTION_SPEC = "전문화에서 복사",
    TPL_SECTION_DELETE = "템플릿 삭제",
    TPL_SAVE_PROMPT = "템플릿 이름 (계정의 모든 %s 캐릭터용):",
    TPL_SAVED = "'%s' 템플릿을 %s용으로 저장했습니다.",
    TPL_REPLACE_CONFIRM = "'%s' 템플릿을 바꿀까요?",
    TPL_LOAD_CONFIRM = "'%s' 템플릿을 불러올까요? %s의 동작을 대체합니다.",
    TPL_LOADED = "'%s' 템플릿을 불러왔습니다.",
    TPL_DELETE_CONFIRM = "이 직업의 모든 캐릭터에서 '%s' 템플릿을 삭제할까요?",
    TPL_DELETED = "'%s' 템플릿을 삭제했습니다.",
    SPEC_COPY_CONFIRM = "'%s'의 동작을 복사할까요? %s의 동작을 대체합니다.",
    SPEC_COPIED = "'%s'의 동작을 복사했습니다.",
    LATCH = "고정 가능",
    LATCH_DESC = "한 번 누르면 이 수정키의 층이 켜지고, 다시 누르면 꺼집니다. 누르고 있을 필요가 없습니다. 다른 수정키를 누르고 있는 동안에는 그 수정키가 우선합니다. 설정을 바꾸면 고정이 풀립니다. 추가 버튼 전용입니다(LT, RT, LB, RB 제외).",
})

-- 1.1.0 : notes de version (tout ce qui a changé depuis la 1.0.0)
ns.AddLocale("koKR", {
    WHATSNEW_1_1_5 = "• 아군 / 적 대상 지정: 전투 중 버튼을 놓은 뒤에도 눌린 상태로 남지 않습니다 (HUD가 해당 층에 머물고 스틱이 계속 조준하던 문제). 짧게 누르면 여전히 다음 대상으로, 길게 누르면 조준한 대상이 유지됩니다.",
    WHATSNEW_1_1_4 = "• 아군 / 적 대상 지정: 짧게 누를 때마다 다음 대상으로 넘어갑니다. 이미 대상이 있어도, 게임이 애드온에 시간을 주지 않는 환경에서도 마찬가지입니다. 길게 누르면 스틱으로 고른 대상이 유지됩니다.\n• /mgir etat에서 짧은 누름을 어떻게 인식하는지 볼 수 있습니다.",
    WHATSNEW_1_1_3 = "• 아군 / 적 대상 지정: 스틱으로 고른 대상이 버튼을 놓아도 유지됩니다. 짧게 누를 때만 가장 가까운 대상을 지정합니다.",
    WHATSNEW_1_1_2 = "• WoW 명령이나 직접 작성한 매크로에 원하는 아이콘을 지정할 수 있습니다: 칸을 클릭하고 \"아이콘 변경...\". 검색으로 주문, 아이템, WoW 명령의 아이콘이나 파일 이름으로 아이콘을 찾을 수 있습니다 (Wowhead처럼: inv_misc_map_01).\n• 자주 쓰는 명령은 열쇠 대신 고유 아이콘을 사용합니다: 세계 지도, 가방, 주문책, 퀘스트 목록, 캐릭터, 업적, 파티 찾기, 수집품.",
    WHATSNEW_1_1_1 = "• 단일 버튼: 빈 층(LT, RT 또는 수정키)은 이제 \"단독\" 동작을 사용하지 않고 아무것도 하지 않으며, HUD에서도 비어 있습니다. 예외: \"단독\"에 놓은 WoW 명령.\n• 주문 목록에 전문 기술 주문도 포함됩니다: 약초 찾기, 광물 찾기, 낚시, 요리, 고고학…",
    WHATSNEW_1_1_0 = "• HUD: 애드온의 동작이 게임 행동 단축바처럼 표시됩니다. 사거리 밖이면 빨간색, 자원이 부족하면 파란색, 쓸 수 없으면 회색, 발동 효과 중에는 금색 테두리, 남은 충전 수, 실행 중인 동작(자동 공격, 변신...)은 밝게 표시됩니다.\n• HUD: 층 미리보기의 순서를 고를 수 있습니다(HUD 탭의 화살표, 또는 미리보기를 다른 미리보기 위로 끌어 놓기).\n• 전문화마다 동작이 따로 있습니다. 새 전문화는 이전 전문화의 동작을 복사해서 시작합니다.\n• 동작 탭: '빈 칸 채우기'로 귀환석, 장신구, 가방의 소모품을 수정키 층에 놓고, '복사 / 교환…'으로 조합 층을 다른 층으로 복사하거나 두 층을 교환합니다.\n• 직업 템플릿: 동작을 계정 전체에 저장하고 같은 직업의 다른 캐릭터에서 불러옵니다(층 목록 아래 '템플릿 및 전문화…'). 다른 전문화의 동작을 복사할 수도 있습니다.\n• 고정 가능한 수정키(버튼 탭): 한 번 누르면 층이 켜지고, 다시 누르면 꺼집니다.\n• /mgir reset은 확인을 요청하며, /mgir undo로 초기화, 템플릿, 전문화 또는 층 복사를 되돌릴 수 있습니다.\n• 프로필: '캐릭터마다 프로필 기억' 옵션.\n• 멈춘 층: 애드온에 준 기본 버튼은 놓을 때까지 누름을 받은 쪽에 남고, Forever가 RT(또는 LT) 바에 더 이상 멈춰 있지 않습니다(예: RT + A로 시전한 성기사의 문장 뒤).\n• 탈것, 대체 바, 애완동물 대전: 애드온이 물러나고 게임 버튼이 작동합니다(전투 중에도).\n• 애드온을 끄기 전에 /mgir restore를 입력할 필요가 없습니다. 로그아웃할 때마다 LT와 LB가 Shift / Ctrl 흉내를 되찾고, 접속하면 애드온이 다시 끕니다.\n• 감지는 A, B, X, Y, 십자키와 LT, RT, LB, RB를 거부합니다(실수로 누르면 추가 버튼의 키가 되기 때문입니다).\n• 컨트롤러 테스트 탭: '보고서 복사'(최근 층 기록 포함)로 다른 컨트롤러 확인을 도와주세요. /mgir etat는 층의 상태를 보여 줍니다.\n• /mgir news: 이 창을 다시 봅니다.",
})

-- Marqueurs de raid (actions de base)
ns.AddLocale("koKR", {
    GAME_markquick = "빠른 징표 (누를 때마다 다음 징표)",
    GAME_mark = "징표: %s",
    GAME_markclear = "징표 제거",
})

-- Se cibler (action de base)
ns.AddLocale("koKR", {
    GAME_targetself = "자신을 대상으로 지정",
})

-- Nouveautés de la 1.1.6
ns.AddLocale("koKR", {
    WHATSNEW_1_1_6 = "• 기본 동작에 공격대 징표 추가: \"빠른 징표\"는 누를 때마다 대상에게 다음 징표를 붙입니다(해골, 가위표, 네모, 달, 세모, 다이아몬드, 동그라미, 별). 8개 징표를 각각 고를 수도 있고, \"징표 제거\"도 있습니다.\n• 기본 동작에 \"자신을 대상으로 지정\" 추가.\n• 주문 툴팁에 주문 등급이 표시됩니다.\n• 아군 / 적 대상: 이제 Forever에서도 짧게 누를 때마다 다음 대상으로 넘어가고, 오른쪽 스틱 조준이 바로 반응합니다. 버튼을 뗄 때 스틱이 아직 기울어져 있거나 길게 눌렀다면 조준한 대상이 유지됩니다.",
})

-- Nouveaux rangs (maître de classe)
ns.AddLocale("koKR", {
    UPRANK_ASK = "새 등급을 배웠습니다: %s.\n\n동작에 있는 낮은 등급을 바꿀까요?\n(애드온 칸 %d개, 게임 바 칸 %d개)",
    UPRANK_REPLACE = "바꾸기",
    UPRANK_KEEP = "유지",
    UPRANK_DONE = "새 등급 적용: 애드온 칸 %d개, 게임 바 칸 %d개.",
})

-- Confort : nouveaux rangs sans demander
ns.AddLocale("koKR", {
    COMFORT_TITLE = "편의",
    UPRANK_AUTO = "새 주문 등급을 묻지 않고 바꾸기 (애드온 동작과 게임 바의 낮은 등급)",
    UPRANK_NONE = "바꿀 낮은 등급이 없습니다.",
})

-- Actions de base : cible, focus, sacs, montures
ns.AddLocale("koKR", {
    GAME_targetlast = "이전 대상",
    GAME_assist = "대상 지원",
    GAME_focus = "주시 대상으로 설정",
    GAME_targetfocus = "주시 대상 선택",
    GAME_follow = "대상 따라가기",
    GAME_openbags = "가방 열기",
    GAME_dismount = "탈것에서 내리기",
    GAME_randommount = "무작위 즐겨찾는 탈것",
})

-- Sorts inconnus
ns.AddLocale("koKR", {
    SPELL_UNKNOWN = "이 캐릭터는 이 주문을 모릅니다(특성, 다른 전문화, 다른 캐릭터의 템플릿): 이 칸은 아무것도 하지 않습니다.",
    UNKNOWN_SECTION = "모르는 주문",
    UNKNOWN_REMOVE = "모르는 주문 제거",
    UNKNOWN_CONFIRM = "%2$s의 동작에서 이 캐릭터가 모르는 주문 %1$d개를 제거할까요?",
    UNKNOWN_REMOVED = "모르는 주문 %d개를 제거했습니다.",
})

-- Recherche d'une action (onglet Actions)
ns.AddLocale("koKR", {
    SEARCH_HINT = "동작 찾기",
    SEARCH_DESC = "이름의 일부를 입력하세요(주문, 아이템, 매크로...): 그것이 있는 층에 칸 수가 표시되고, 해당 칸에 금색 테두리가 생깁니다.",
})

-- Consommables intelligents
ns.AddLocale("koKR", {
    MENU_BEST = "스마트 소모품...",
    BEST_TITLE = "스마트 소모품",
    KIND_best = "스마트 소모품",
    BEST_heal = "가장 좋은 치유 물약",
    BEST_mana = "가장 좋은 마나 물약",
    BEST_food = "가장 좋은 음식",
    BEST_drink = "가장 좋은 음료",
    BEST_bandage = "가장 좋은 붕대",
    BEST_NONE = "가방에 없음",
    BEST_DESC = "가방에 있는 이 종류의 가장 좋은 아이템을 사용합니다. 한 묶음이 떨어지면 다음 것을 씁니다(전투 중에도). 목록은 전투 밖에서 가방을 따라갑니다.",
})

-- Vibrations
ns.AddLocale("koKR", {
    VIBRATION_OPTION = "컨트롤러 진동 (고정 수정키 켜짐 / 꺼짐, 길게 누르기 인식, 새 등급 적용)",
})

-- Bouton simple : sa case dans chaque couche de modificateur
ns.AddLocale("koKR", {
    SIMPLE_MOD_ROW = "수정자를 누른 상태 (비어 있으면 아무 일도 하지 않음)",
})

-- HUD : couches séparées, en colonne
ns.AddLocale("koKR", {
    HUD_LAYERS_LABEL = "층:",
    HUD_DETACH = "HUD와 분리",
    HUD_VERTICAL = "세로로",
    HUD_STRIP_COLS = "미니어처 열:",
    HUD_TOOL_VERTICAL = "층을 세로로",
    HUD_TOOL_HORIZONTAL = "층을 가로로",
})

-- HUD : cadenas (verrouiller / déverrouiller)
ns.AddLocale("koKR", {
    HUD_TOOL_UNLOCK = "잠금 해제: 마우스로 HUD 이동",
    HUD_TOOL_LOCK = "HUD 잠금 (먼저 원하는 곳으로 끌어 놓으세요)",
    HUD_TOOL_LOCK_DETACHED = "HUD 잠금 (먼저 HUD와 층을 각각 제자리로 끌어 놓으세요)",
    HUD_UNLOCKED_HINT = "잠금 해제됨: 마우스로 끌어 옮기세요 (분리된 층은 따로 움직입니다). 자물쇠를 클릭하면 잠깁니다.",
})

-- HUD : bouton vers l'onglet HUD
ns.AddLocale("koKR", {
    HUD_TOOL_SETTINGS = "HUD 설정 (HUD 탭): 배치, 크기, 미니어처...",
})

-- HUD : miniatures des couches cachées
ns.AddLocale("koKR", {
    HUD_HIDE_STRIP = "숨김",
})

-- Onglets réorganisés : Options, sections, Aide en sections, info-bulles
ns.AddLocale("koKR", {
    TAB_OPTIONS = "옵션",
    ACTIONS_INTRO = "각 버튼이 실행하는 것입니다. 왼쪽에서 층을 고르고, 오른쪽 칸에 동작을 놓으세요.",
    OPTIONS_INTRO = "애드온의 일반 설정: 버튼도, 층도, HUD 표시도 아닌 것들입니다.",
    OPTIONS_SECTION_UI = "인터페이스",
    HUD_SECTION_STRIP = "층 미니어처",
    HUD_SECTION_PLACE = "HUD 크기와 위치",
    HUD_LAYOUT_LABEL = "배치:",
    TEST_OPEN = "컨트롤러 테스트",
    TEST_BACK = "버튼으로 돌아가기",
    HELP_INTRO = "왼쪽에서 주제를 고르세요. 튜토리얼이 모든 것을 단계별로 설명합니다.",
    HELP_PRINCIPLE = "원리",
    HELP_COMMANDS = "명령어",
    TIP_CONTROLLER = "컨트롤러 선택: 애드온이 추가 버튼의 이름을 가져옵니다.",
    TIP_TYPES = "각 버튼 유형이 하는 일을 다시 보기: 수정자, 대상, 단순 버튼, 없음.",
    TIP_DETECT = "그다음 컨트롤러 버튼을 누르세요: 애드온이 그 버튼이 보내는 키를 기억합니다.",
    TIP_CLEAR = "이 버튼의 키를 지웁니다: 더 이상 아무것도 하지 않습니다.",
    TIP_TEST = "WoW가 각 버튼에서 받는 것을 실시간으로 보기: 버튼이 반응하지 않을 때 유용합니다.",
    TIP_REPORT = "문제가 있을 때 제작자에게 보낼 텍스트 (캐릭터 이름과 서버 이름 없음).",
    TIP_PROFILE_USE = "이 프로필을 사용합니다: 그 컨트롤러, 버튼, 이 캐릭터의 동작.",
    TIP_PROFILE_NEW = "빈 프로필, 예를 들어 다른 컨트롤러용.",
    TIP_PROFILE_COPY = "선택한 프로필의 복사본인 새 프로필로, 변경을 안전하게 시험합니다.",
    TIP_PROFILE_RENAME = "선택한 프로필의 이름을 바꿉니다.",
    TIP_PROFILE_DELETE = "선택한 프로필을 이 프로필의 모든 캐릭터 동작과 함께 삭제합니다.",
    TIP_PROFILE_EXPORT = "이 프로필을 공유하거나 보관하기 위해 복사할 텍스트.",
    TIP_PROFILE_IMPORT = "내보낸 프로필의 텍스트를 붙여 넣습니다 (내 것이든 다른 플레이어의 것이든).",
    TIP_HUD_DETACH = "미니어처가 HUD에서 분리됩니다: 원하는 곳에 놓을 수 있습니다 (HUD의 자물쇠, 그다음 끌기).",
    TIP_HUD_VERTICAL = "미니어처가 가로 대신 세로로 쌓입니다.",
    TIP_HUD_HIDDEN = "미니어처 없음: HUD에는 현재 층만 보입니다. 층은 층 탭에서 편집합니다.",
    TIP_HUD_ROWS = "미니어처를 몇 줄 (또는 몇 열)로 나눌지.",
    TIP_HUD_STRIP_SIZE = "HUD의 나머지는 그대로 두고 미니어처 크기만 바꿉니다.",
    TIP_HUD_SIZE = "HUD 전체의 크기.",
    TIP_HUD_MOVE = "HUD 잠금을 풀어 마우스로 끌어 옮깁니다 (HUD의 자물쇠와 같음). 다시 클릭하면 잠깁니다.",
    TIP_HUD_RESET = "HUD를 원래 위치와 크기로 되돌립니다 (분리된 미니어처는 그 아래로 돌아옵니다).",
    TIP_UPRANK = "주문의 새 등급을 배우면 묻지 않고 모든 곳에서 이전 등급을 바꿉니다.",
    TIP_VIBRATION = "고정 가능한 수정자가 켜지거나 꺼질 때, 그리고 새 등급이 놓일 때 짧은 진동.",
    TIP_MINIMAP = "미니맵 주위의 버튼: 클릭하면 설정을 열고, 오른쪽 클릭하면 HUD를 옮깁니다.",
})

-- Nouveautés 1.2.0, et l'encart « donne ton avis »
ns.AddLocale("koKR", {
    WHATSNEW_1_2_0 = "• 창을 설정 순서대로 다시 정리했습니다: 버튼, 층 (이전 동작 탭), HUD, 옵션, 프로필, 도움말. 모든 설정에 툴팁이 있고, 도움말에는 목차가 있으며, 컨트롤러 테스트는 버튼 탭에서 엽니다.\n• 새 주문 등급: 새 등급을 배우면 애드온이 모든 곳에서 이전 등급을 바꿀지 묻습니다 (옵션 탭에서 자동으로 할 수도 있습니다). /mgir rangs는 주문책 전체를 확인합니다.\n• 스마트 소모품 (칸 메뉴): 가장 좋은 물약, 음식, 음료, 붕대를 자동으로 고릅니다.\n• 이 캐릭터가 모르는 주문은 빨간색으로 표시되고, \"템플릿 및 전문화...\"에서 지울 수 있습니다.\n• 입력란으로 모든 층에서 동작을 찾습니다.\n• 새 기본 동작: 이전 대상, 지원, 주시, 따라가기, 가방 열기, 내리기, 무작위 즐겨찾는 탈것.\n• HUD: 마우스를 올리면 작은 버튼 (이동용 자물쇠, 가로 또는 세로, 설정); 미니어처를 HUD에서 분리하거나 세로로 놓거나 숨길 수 있습니다. HUD는 항상 표시됩니다.\n• \"단독\"의 A, B, X, Y는 게임 동작을 보여 주고, 단순 버튼 페이지는 각 수정자에서의 칸을 보여 줍니다.\n• 게임이 허용하면 컨트롤러 진동.",
    WHATSNEW_FEEDBACK = "버그, 아이디어, 불편한 점이 있나요? 알려 주세요: 모든 의견이 애드온을 더 좋게 만듭니다. 이 링크를 복사(Ctrl+C)해 GitHub에 글을 남겨 주세요:",
})

-- 1.3.0: 주문 대상, 상황별 동작, 순환 동작, 설정 점검, HUD 편의
ns.AddLocale("koKR", {
    MENU_UNIT = "시전 대상...",
    MENU_COND = "상황별 동작...",
    MENU_SEQ = "순환 동작...",
    MENU_PICKUP_CAST = "또는 여기에 주문이나 아이템을 놓으세요",
    SLOT_KIND_REFUSED = "여기에는 주문이나 아이템만 놓을 수 있습니다.",
    KIND_cond = "상황별 동작",
    KIND_seq = "순환 동작",

    UNIT_TITLE = "시전 대상",
    UNIT_target = "대상 (기본)",
    UNIT_CURRENT = "선택됨",
    UNIT_player = "나",
    UNIT_helpself = "선택한 아군, 없으면 나",
    UNIT_focus = "주시 대상",
    UNIT_targettarget = "내 대상의 대상",
    UNIT_pet = "내 소환수",
    UNIT_party = "파티원 %s",
    UNIT_TIP = "시전 대상: %s",

    COND_TITLE = "상황별 동작",
    COND_HELP = "한 칸에 두 동작: 조건이 맞으면 첫 번째, 아니면 두 번째가 실행됩니다. 둘 중 하나는 비워 둘 수 있습니다.",
    COND_IF = "조건:",
    COND_THEN = "맞으면",
    COND_ELSE = "아니면",
    COND_NOTHING = "없음",
    COND_NEED_ACTION = "주문이나 아이템을 하나 이상 놓으세요.",
    COND_TIP_IF = "%s: %s",
    COND_TIP_ELSE = "아니면: %s",
    COND_combat = "전투 중",
    COND_mounted = "탈것 탑승 중",
    COND_stealth = "은신 중",
    COND_harm = "내 대상이 적",
    COND_help = "내 대상이 아군",
    COND_exists = "대상이 있음",
    COND_pet = "소환수가 있음",
    COND_group = "파티 중",
    COND_swimming = "수영 중",
    COND_indoors = "실내",
    COND_stance = "변신 또는 태세 %d",

    SEQ_TITLE = "순환 동작",
    SEQ_HELP = "주문이나 아이템 2~4개: 누를 때마다 다음 것을 시전하고, 끝나면 처음으로 돌아갑니다. 주문이 시전되어야만 다음으로 넘어갑니다.",
    SEQ_RESET = "처음으로 돌아가기:",
    SEQ_RESET_none = "마지막 이후에만",
    SEQ_RESET_target = "대상이 바뀔 때",
    SEQ_RESET_combat = "전투가 끝날 때",
    SEQ_RESET_both = "대상 변경 또는 전투 종료",
    SEQ_RESET_seconds = "%d초 동안 누르지 않으면",
    SEQ_NEED_TWO = "주문이나 아이템을 두 개 이상 놓으세요.",
    SEQ_TIP_RESET = "처음으로: %s",

    GAME_mounttoggle = "탈것 타기 / 내리기",
    GAME_targetpet = "내 소환수 대상 지정",
    GAME_sheet = "층 요약표 보기",
    GAME_partynext = "다음 파티 아군 (나, 그다음 각 파티원)",
    GAME_targetparty = "파티원 %d 대상 지정",

    CHECK_BUTTON = "내 설정 점검",
    TIP_CHECK = "버튼이나 칸이 작동하지 않는 원인을 찾습니다: 키 없는 버튼, 삭제된 매크로, 모르는 주문, 불완전한 쌍... 각 줄에서 고치거나 해당 위치로 갈 수 있습니다.",
    CHECK_TITLE = "설정 점검",
    CHECK_ALL_GOOD = "모두 준비됨: 고칠 것이 없습니다.",
    CHECK_SUMMARY = "고칠 항목 %d개, 참고 %d개.",
    CHECK_FIX = "고치기",
    CHECK_GO = "이동",
    CHECK_AGAIN = "다시 점검",
    CHECK_CLEAR = "칸 비우기",
    CHECK_CLEARED = "칸을 비웠습니다.",
    CHECK_REMOVE = "제거",
    CHECK_REPLACE = "바꾸기",
    CHECK_UNCHECK = "선택 해제",
    CHECK_NO_KEY = "%s에 키가 없어 아무것도 하지 않습니다. 버튼 탭에서 \"감지\"를 누르거나 \"사용 안 함\"으로 설정하세요.",
    CHECK_SAME_KEY = "%s와(과) %s의 키가 같습니다 (%s): 둘 중 하나만 작동합니다.",
    CHECK_PAIR_HALF = "%s 쌍이 선택되어 있지만 %s은(는) 수정키가 아니므로 작동하지 않습니다.",
    CHECK_MACRO_GONE = "%s: 매크로 \"%s\"이(가) 게임에 더 이상 없습니다. 이 칸은 아무것도 하지 않습니다.",
    CHECK_SET_GONE = "%s: 장비 구성 \"%s\"이(가) 더 이상 없습니다. 이 칸은 아무것도 하지 않습니다.",
    CHECK_COMPOSED_EMPTY = "%s: 이 동작에 유효한 주문이나 아이템이 남아 있지 않습니다. 이 칸은 아무것도 하지 않습니다.",
    CHECK_ITEM_GONE = "%s: %s이(가) 가방에도 장비에도 없습니다.",
    CHECK_UNKNOWN = "이 캐릭터가 모르는 주문이 있는 칸 %d개: 아무것도 하지 않습니다.",
    CHECK_LOWER_RANKS = "더 높은 단계를 아는 주문의 낮은 단계가 있는 칸 %d개.",
    CHECK_EMPTY_BUTTON = "%s에 동작이 없습니다.",
    CHECK_TAP_SAFE = "이 게임은 누른 시간을 잴 수 없습니다: 대상 지정 버튼은 유효한 대상이 없을 때만 대상을 바꿉니다.",
    HUD_IDLE_ALPHA = "대기 시 불투명도:",
    TIP_HUD_IDLE_ALPHA = "전투 밖에서 아무 버튼도 누르지 않을 때의 HUD 불투명도입니다. 0%이면 숨겨지며, 전투 중, 버튼을 누를 때, 마우스를 올릴 때 다시 나타납니다.",
    SHEET_BUTTON = "층 요약표",
    TIP_SHEET = "모든 층을 화면 가운데에 크게 보여 줘 단축키를 익힐 수 있습니다. /mgir map 또는 칸에 놓은 기본 동작 \"층 요약표 보기\"로도 열 수 있습니다.",
    SHEET_TITLE = "요약표: 모든 층",
    SHEET_HINT = "Esc 또는 /mgir map으로 닫기. 사용 중인 층은 금색 테두리입니다.",

    TUTO_ACTIONS_MORE = "\n|cffffd100더 알아보기|r (칸 메뉴):\n- |cffffd100시전 대상...|r: 주문이나 아이템이 나, 주시 대상, 내 대상의 대상, 소환수 또는 파티원에게 갑니다. 칸에 \"@\"가 표시됩니다.\n- |cffffd100상황별 동작...|r: 두 동작과 하나의 조건 (전투 중, 탈것 탑승 중, 변신...). 조건이 맞으면 첫 번째, 아니면 두 번째가 실행됩니다. 칸에 \"/\"가 표시됩니다.\n- |cffffd100순환 동작...|r: 주문이나 아이템 2~4개, 누를 때마다 다음 것. 칸에 단계가 표시됩니다 (\"2/3\").\n- |cffffd100기본 동작|r: \"다음 파티 아군\"은 나에서 각 파티원으로 넘어가고, \"파티원 대상 지정\"은 한 명을 바로 고릅니다. 게임은 애드온이 가장 많이 다친 아군을 고르는 것을 허용하지 않습니다.\n\n버튼이나 칸이 작동하지 않나요? |cffffd100내 설정 점검|r (버튼 탭 또는 /mgir check)이 이유를 알려 줍니다.",
    TUTO_HUD_MORE = "\n|cffffd100HUD 탭|r:\n- |cffffd100대기 시 불투명도|r: 전투 밖에서 HUD가 보이는 정도; 0%이면 숨겨지고 전투 중이나 버튼을 누르면 다시 나타납니다.\n- |cffffd100층 요약표|r (또는 /mgir map): 모든 층을 화면 가운데에 크게.",
    HELP_COMMANDS_MORE = "|cffffd100/mgir check|r: 설정 점검\n|cffffd100/mgir map|r: 모든 층 요약표",
    SLASH_HELP_MORE = "/mgir check: 설정 점검  |  /mgir map: 층 요약표",
    WHATSNEW_1_3_0 = "• 시전 대상... (칸 메뉴): 매크로를 쓰지 않고도 주문이나 아이템을 나, 주시 대상, 내 대상의 대상, 소환수 또는 파티원에게 사용합니다.\n• 상황별 동작: 한 칸에 두 동작과 하나의 조건 (전투 중, 탈것 탑승 중, 은신 중, 변신, 적 또는 아군 대상...).\n• 순환 동작: 한 칸에 주문이나 아이템 2~4개, 누를 때마다 다음 것.\n• 새 기본 동작: 다음 파티 아군, 파티원 1~4 대상 지정, 소환수 대상 지정, 탈것 타기 / 내리기, 요약표.\n• 내 설정 점검 (버튼 및 도움말 탭, /mgir check): 버튼이나 칸이 작동하지 않는 원인 목록과 고치는 방법.\n• HUD: 대기 시 불투명도 조절 (전투 밖에서 숨김까지), 모든 층 요약표 (/mgir map).",
})
