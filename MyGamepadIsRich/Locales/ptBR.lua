-- Português (Brasil)
local _, ns = ...

ns.AddLocale("ptBR", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "Botões",
    TAB_TEST = "Teste do controle",
    TAB_HELP = "Ajuda",

    EXTRA = "Botão",
    NAME = "Nome:",
    KEY = "Tecla:",
    KEY_NONE = "não definida",
    DETECT = "Detectar",
    CLEAR = "Apagar",
    MODE = "Modo:",
    MODE_MODIFIER = "Modificador",
    MODE_SIMPLE = "Botão simples",
    MODE_OFF = "Desativado",
    MODE_MODIFIER_DESC = "Segure este botão e aperte A, B, X, Y ou o direcional: 8 novas combinações, como LT/RT.",
    MODE_SIMPLE_DESC = "Uma ação, mais uma com LT segurado e outra com RT segurado. Uma camada vazia usa a ação \"Sozinho\".",
    MODE_OFF_DESC = "Este botão não faz nada: a tecla fica livre.",
    LAYER_BASE = "Sozinho",
    LAYER_LT = "LT +",
    LAYER_RT = "RT +",
    SLOT_HINT = "Arraste um feitiço, item, macro ou montaria para um espaço. Clique direito: mais opções.",
    EMPTY = "Vazio",
    NO_KEY_WARNING = "Defina a tecla primeiro: clique em \"Detectar\" e aperte o botão.",

    MENU_SPELL = "Escolher um feitiço...",
    MENU_ITEM = "Escolher um item da bolsa...",
    SPELL_TITLE = "Feitiços do personagem",
    ITEM_TITLE = "Itens das bolsas",
    ITEMS_EQUIPPED = "Equipados (utilizáveis)",
    ITEMS_USABLE = "Utilizáveis",
    ITEMS_OTHER = "Outros itens",
    LIST_EMPTY = "Nada para mostrar.",
    MENU_MACROTEXT = "Escrever uma macro...",
    MENU_COMMAND = "Comando do WoW...",
    MENU_CLEAR = "Esvaziar",
    MENU_PICKUP_HINT = "Ou solte aqui um feitiço / item / macro / montaria",
    MACRO_TITLE = "Texto da macro",
    MACRO_HELP = "Um comando por linha, ex.: /cast Bola de Fogo  (máx. 255 caracteres)",
    OK = "OK",
    CANCEL = "Cancelar",
    COMMAND_TITLE = "Comando do WoW",
    SEARCH = "Buscar:",
    COMMAND_LT_RT = "Um comando do WoW só funciona na camada \"Sozinho\" de um botão sem camadas LT/RT.",

    KIND_spell = "Feitiço",
    KIND_item = "Item",
    KIND_toy = "Brinquedo",
    KIND_mount = "Montaria",
    KIND_macro = "Macro",
    KIND_macrotext = "Macro personalizada",
    KIND_command = "Comando do WoW",
    KIND_equipset = "Conjunto de equipamento",

    CURSOR_UNSUPPORTED = "Isto não pode ir em um botão (somente feitiços, itens, brinquedos, montarias, macros e conjuntos de equipamento).",
    APPLIED_AFTER_COMBAT = "Em combate: as mudanças serão aplicadas quando o combate terminar.",
    APPLIED = "Mudanças aplicadas.",
    LEARN_PROMPT = "Aperte o botão do controle para |cffffd100%s|r\n\n(Esc para cancelar)",
    LEARN_COMBAT = "Não é possível detectar um botão em combate.",
    LEARN_DONE = "%s agora está na tecla %s.",
    LEARN_TAKEN = "A tecla %s era usada por %s: removida.",
    LEARN_MODKEY = "Atenção: %s é uma tecla Shift / Ctrl / Alt; no GameSir Nexus, prefira uma tecla como F9-F12.",
    LEARN_BOUND = "Observação: %s estava atribuída a \"%s\" no WoW; enquanto este addon a usar, o addon tem prioridade.",

    TEST_INTRO = "Aperte qualquer botão: o que o WoW recebe se acende. Se L5 / R5 / L4 / R4 não mostrarem nada, atribua teclas a eles no GameSir Nexus (veja Ajuda).",
    TEST_STANDARD = "Botões padrão",
    TEST_EXTRA = "Botões extras",
    TEST_LOG = "Últimas entradas",
    TEST_GAME = "jogo",
    TEST_UNKNOWN = "não atribuída",

    IF_WARNING = "O Improved Forever está carregado: se ele também usar uma destas teclas, vale a última atribuição aplicada.",
    OPEN_CONFIG = "Abrir a configuração",
    SETTINGS_DESC = "Configure os botões extras do seu GameSir G7 Pro (L5/R5, L4/R4). Comando: /mgir",
    LOADED = "carregado. Digite /mgir para configurar seus botões extras.",
    SLASH_HELP = "/mgir : abrir  |  /mgir test : teste do controle  |  /mgir tuto : tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : zerar as ações deste personagem",
    RESET_DONE = "As ações deste personagem foram zeradas.",

    DPAD_UP = "Direcional cima",
    DPAD_DOWN = "Direcional baixo",
    DPAD_LEFT = "Direcional esquerda",
    DPAD_RIGHT = "Direcional direita",
    PADDLE = "Paddle %s",

    TUTO_TITLE = "Tutorial",
    TUTO_NEXT = "Próximo",
    TUTO_BACK = "Voltar",
    TUTO_SKIP = "Pular o tutorial",
    TUTO_FINISH = "Abrir a configuração",
    TUTO_REOPEN = "Tutorial fechado. Digite /mgir tuto para vê-lo de novo.",
    TUTO_SUGGESTED = "Usar os modos sugeridos",
    HELP_REPLAY = "Ver o tutorial de novo",

    TUTO_WELCOME_TITLE = "Bem-vindo ao My Gamepad Is Rich",
    TUTO_WELCOME_TEXT = "Este addon traz para o WoW os botões extras do seu GameSir G7 Pro:\n\n"
        .. "|cffffd100L5 / R5|r: os terceiros gatilhos\n"
        .. "|cffffd100L4 / R4|r: os paddles traseiros\n\n"
        .. "Cada um pode ser um modificador segurado (8 novas combinações com A, B, X, Y e o direcional) "
        .. "ou um botão simples com suas próprias camadas LT e RT.\n\n"
        .. "Este tutorial leva uns dois minutos. Você pode sair a qualquer momento e abri-lo de novo com |cffffd100/mgir tuto|r.",

    TUTO_NEXUS_TITLE = "Passo 1: GameSir Nexus",
    TUTO_NEXUS_TEXT = "O Windows vê o G7 Pro como um controle de Xbox 360. Esse modo só transmite os botões padrão, "
        .. "então o WoW nunca recebe L5, R5, L4 e R4. A solução: fazer com que enviem uma tecla do teclado.\n\n"
        .. "1. Conecte o controle e abra o |cffffd100GameSir Nexus|r (Microsoft Store).\n"
        .. "2. Abra a página de mapeamento dos botões.\n"
        .. "3. Dê a L5, R5, L4 e R4 uma tecla que você não usa no WoW. Boas opções: |cffffd100F9, F10, F11, F12|r "
        .. "ou o teclado numérico (com Num Lock ligado).\n"
        .. "4. Evite Shift, Ctrl e Alt: eles mudariam suas outras teclas de atalho.\n"
        .. "5. Salve o perfil no controle.\n\n"
        .. "Pronto? Vá para o próximo passo.",

    TUTO_DETECT_TITLE = "Passo 2: Detectar seus botões",
    TUTO_DETECT_TEXT = "Para cada botão, clique em |cffffd100Detectar|r e aperte esse botão no controle. "
        .. "A tecla enviada aparece ao lado.",
    TUTO_DETECT_ALL = "|cff40ff40Os quatro botões foram detectados.|r",
    TUTO_DETECT_MISSING = "Nada acontece ao apertar? Verifique a tecla do botão no GameSir Nexus e tente de novo.",

    TUTO_MODES_TITLE = "Passo 3: Escolher um modo",
    TUTO_MODES_TEXT = "|cffffd100Modificador|r: segure o botão e aperte A, B, X, Y ou o direcional. 8 ações por botão, como LT e RT.\n"
        .. "|cffffd100Botão simples|r: uma ação, mais uma com LT segurado e outra com RT segurado.\n"
        .. "|cffffd100Desativado|r: a tecla fica livre.\n\n"
        .. "Sugestão: modificadores em L5 e R5 (fáceis de segurar), botões simples em L4 e R4.",

    TUTO_ACTIONS_TITLE = "Passo 4: Colocar suas ações",
    TUTO_ACTIONS_TEXT = "Na janela de configuração, cada botão mostra seus espaços.\n\n"
        .. "- Arraste um feitiço do grimório, um item das bolsas, uma macro, uma montaria ou um brinquedo para um espaço.\n"
        .. "- Ou clique com o botão direito em um espaço: escolha um feitiço ou item da bolsa, escreva uma macro, escolha um comando do WoW (como Correr automaticamente) ou esvazie-o.\n\n"
        .. "As ações são salvas por personagem; as teclas e os modos, para a conta toda. "
        .. "Tudo funciona em combate; só as mudanças feitas em combate esperam ele terminar.",

    TUTO_DONE_TITLE = "Tudo pronto",
    TUTO_DONE_TEXT = "Abra a configuração para colocar suas primeiras ações.\n\n"
        .. "|cffffd100/mgir|r: abrir a configuração\n"
        .. "|cffffd100/mgir test|r: teste do controle, para ver o que o WoW recebe\n"
        .. "|cffffd100/mgir tuto|r: este tutorial\n"
        .. "|cffffd100/mgir reset|r: esvaziar as ações deste personagem",
})

-- HUD
ns.AddLocale("ptBR", {
    HUD_UNLOCKED = "HUD desbloqueado: arraste-o com o mouse. Digite /mgir hud de novo para travá-lo.",
    HUD_LOCKED = "HUD travado.",
    HUD_ON = "HUD visível: ele substitui a barra de controle do jogo.",
    HUD_OFF = "HUD oculto: a barra de controle do jogo voltou. Digite /mgir hud on para mostrá-lo de novo.",
    HUD_SCALE = "Tamanho do HUD: %s",
    TUTO_HUD_TITLE = "Seu HUD de controle",
    TUTO_HUD_TEXT = "O addon substitui a barra de controle do jogo pelo próprio HUD, na parte de baixo da tela:\n\n"
        .. "- |cffffd100Em destaque|r: a camada que você está usando, direcional à esquerda, A/B/X/Y à direita. Segure LT, RT, L5 ou R5 e ela muda.\n"
        .. "- |cffffd100Na faixa|r (embaixo, ou em cima com /mgir hud strip): todas as camadas em miniatura (Sozinho, LT, RT, LT+RT, L5, R5); a que você segura se acende.\n"
        .. "- |cffffd100No centro|r: L4 e R4, com a ação que vai sair conforme o gatilho segurado.\n\n"
        .. "Ele fica mais apagado fora de combate enquanto você não segura nada.\n"
        .. "|cffffd100/mgir hud|r: mover  -  |cffffd100/mgir hud scale 1.2|r: tamanho  -  |cffffd100/mgir hud off|r: voltar à barra do jogo",
})

-- HUD : attribution rapide
ns.AddLocale("ptBR", {
    HUD_COMBAT = "Não é possível mudar as ações em combate.",
    HUD_GAME_SLOT = "Este botão mantém a ação do jogo (pular, interagir...).",
    HUD_KIND = "A barra do jogo só aceita feitiços, itens, montarias e macros da lista de macros.",
    HUD_EDITING = "Editando esta camada: clique em um espaço para atribuí-lo, clique direito para esvaziá-lo. Clique de novo na miniatura para voltar.",
    HUD_TILE_HINT = "Clique: atribuir  -  Clique direito: esvaziar",
    HUD_CARD_HINT = "Clique: editar esta camada",
})

-- HUD : bande des miniatures
ns.AddLocale("ptBR", {
    HUD_STRIP_TOP = "Miniaturas das camadas agora acima do HUD. Digite /mgir hud strip para alternar.",
    HUD_STRIP_BOTTOM = "Miniaturas das camadas agora abaixo do HUD. Digite /mgir hud strip para alternar.",
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("ptBR", {
    TUTO_STRIP_LABEL = "Miniaturas das camadas:",
    TUTO_STRIP_BOTTOM = "Embaixo (recomendado)",
    TUTO_STRIP_TOP = "Em cima",
})

-- Bouton de la minimap
ns.AddLocale("ptBR", {
    MINIMAP_LEFT = "Clique esquerdo: abrir a configuração",
    MINIMAP_RIGHT = "Clique direito: destravar / travar o HUD para movê-lo",
    MINIMAP_SHIFT = "Shift + clique esquerdo: tutorial",
    MINIMAP_DRAG = "Arrastar: mover este botão ao redor do minimapa",
    MINIMAP_HIDDEN = "Botão do minimapa oculto. Digite /mgir minimap para mostrá-lo de novo.",
    MINIMAP_SHOWN = "Botão do minimapa visível.",
})

-- Paires de modificateurs (L5 + R5, L4 + R4)
ns.AddLocale("ptBR", {
    PAIR_READY = "Par · segurar os dois",
    PAIR_NOT_READY = "Par · indisponível",
    PAIR_DESC = "Segure %s e %s juntos e aperte A, B, X, Y ou o direcional: mais 8 combinações.",
    PAIR_NEEDS = "Para usar este par, %s e %s precisam estar no modo Modificador, com uma tecla.",
    TUTO_PAIRS_TEXT = "|cffffd100Pares|r: quando L5 e R5 são modificadores, segurá-los juntos dá mais 8 combinações. O mesmo para L4 + R4.",
})

-- Fenêtre de configuration (onglets Actions, Boutons, HUD)
ns.AddLocale("ptBR", {
    TAB_ACTIONS = "Ações",
    TAB_HUD = "HUD",
    SECTION_PAD = "Barra do controle",
    SECTION_MODS = "Modificadores",
    SECTION_MODS_EMPTY = "Nenhum ainda: coloque um botão em Modificador na aba Botões.",
    SECTION_SIMPLE = "Botões simples",
    SECTION_SIMPLE_EMPTY = "Nenhum ainda: coloque um botão em Botão simples na aba Botões.",
    LAYER_DESC_BASE = "A, B, X, Y e o direcional sem segurar nada. A, B, X e Y mantêm as ações do jogo (pular, interagir...).",
    LAYER_DESC_HOLD = "Segure %s e aperte A, B, X, Y ou o direcional.",
    BUTTONS_INTRO = "Seus botões extras: a tecla que o GameSir Nexus envia e o que cada um faz. Passe o mouse sobre um modo para ver o que ele faz.",
    PAIRS_TITLE = "Pares (dois modificadores segurados juntos)",
    HUD_INTRO = "O HUD substitui a barra de controle do jogo: a camada em uso em destaque, todas as camadas em miniatura.",
    HUD_SHOW = "Mostrar o HUD (no lugar da barra de controle do jogo)",
    HUD_SIZE = "Tamanho:",
    HUD_MOVE = "Mover o HUD",
    HUD_MOVE_DONE = "Travar o HUD",
    HUD_RESET = "Restaurar posição e tamanho",
    MINIMAP_SHOW = "Botão ao redor do minimapa",
    GAME_ACTION = "Jogo",
    BAR_UNAVAILABLE = "A barra de controle do jogo não está disponível (a interface de controle está ativada?).",
    KIND_slot = "Ação",
    SLOT_HINT = "Arraste um feitiço, item, macro ou montaria para um espaço. Clique: menu. Clique direito: esvaziar.",
})

-- HUD : taille et lignes des miniatures
ns.AddLocale("ptBR", {
    HUD_STRIP_SIZE = "Tamanho das miniaturas:",
    HUD_STRIP_ROWS = "Linhas de miniaturas:",
})
