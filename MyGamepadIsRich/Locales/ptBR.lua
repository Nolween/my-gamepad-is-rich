-- Português (Brasil)
local _, ns = ...

ns.AddLocale("ptBR", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "Botões",
    TAB_TEST = "Teste do controle",
    TAB_HELP = "Ajuda",

    NAME = "Nome:",
    KEY = "Tecla:",
    KEY_NONE = "não definida",
    DETECT = "Detectar",
    CLEAR = "Apagar",
    MODE_MODIFIER = "Modificador",
    MODE_SIMPLE = "Botão simples",
    MODE_OFF = "Desativado",
    MODE_MODIFIER_DESC = "Segure este botão e aperte A, B, X, Y ou o direcional: 8 novas combinações, como LT/RT.",
    MODE_SIMPLE_DESC = "Uma ação, mais uma com LT segurado e outra com RT segurado. Uma camada vazia não faz nada.",
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
    MENU_ICON = "Mudar ícone...",
    ICON_TITLE = "Escolher um ícone",
    ICON_HINT = "Busque por feitiço, item ou comando do WoW, ou digite o nome de arquivo de um ícone (como no Wowhead: inv_misc_map_01).",
    ICON_DEFAULT = "Ícone padrão",
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
    LEARN_BOUND = "Observação: %s estava atribuída a \"%s\" no WoW; enquanto este addon a usar, o addon tem prioridade.",

    TEST_STANDARD = "Botões padrão",
    TEST_EXTRA = "Botões extras",
    TEST_LOG = "Últimas entradas",
    TEST_GAME = "jogo",
    TEST_UNKNOWN = "não atribuída",

    IF_WARNING = "O Improved Forever está carregado: se ele também usar uma destas teclas, vale a última atribuição aplicada.",
    OPEN_CONFIG = "Abrir a configuração",
    LOADED = "carregado. Digite /mgir para configurar seus botões extras.",
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
    HELP_REPLAY = "Ver o tutorial de novo",

    TUTO_WELCOME_TITLE = "Bem-vindo ao My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "Para cada botão, clique em |cffffd100Detectar|r e aperte esse botão no controle. "
        .. "A tecla enviada aparece ao lado.",



    TUTO_DONE_TITLE = "Tudo pronto",
})

-- HUD
ns.AddLocale("ptBR", {
    HUD_UNLOCKED = "HUD desbloqueado: arraste-o com o mouse. Digite /mgir hud de novo para travá-lo.",
    HUD_LOCKED = "HUD travado.",
    HUD_ON = "HUD visível: ele substitui a barra de controle do jogo.",
    HUD_OFF = "HUD oculto: a barra de controle do jogo voltou. Digite /mgir hud on para mostrá-lo de novo.",
    HUD_SCALE = "Tamanho do HUD: %s",
    TUTO_HUD_TITLE = "Seu HUD de controle",
})

-- HUD : attribution rapide
ns.AddLocale("ptBR", {
    HUD_COMBAT = "Não é possível mudar as ações em combate.",
    HUD_GAME_SLOT = "Este botão mantém a ação do jogo (pular, interagir...).",
    HUD_KIND = "A barra do jogo só aceita feitiços, itens, montarias e macros da lista de macros.",
    HUD_EDITING = "Editando esta camada: clique em um espaço para atribuí-lo, clique direito para esvaziá-lo. Clique de novo na miniatura, ou aperte qualquer outro botão ou tecla, para voltar.",
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

-- Paires de modificateurs
ns.AddLocale("ptBR", {
    PAIR_READY = "Par · segurar os dois",
    PAIR_NOT_READY = "Par · indisponível",
    PAIR_DESC = "Segure %s e %s juntos e aperte A, B, X, Y ou o direcional: mais 8 combinações.",
    PAIR_NEEDS = "Para usar este par, %s e %s precisam estar no modo Modificador, com uma tecla.",
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
    LAYER_DESC_BASE = "A, B, X, Y e o direcional sem segurar nada. Tudo cabe aqui: o que a barra do jogo não consegue guardar (macro escrita à mão, comando do WoW) fica com o addon. A, B, X e Y mantêm as ações do jogo (pular, interagir...) até você colocar as suas.",
    LAYER_DESC_HOLD = "Segure %s e aperte A, B, X, Y ou o direcional.",
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
    HUD_ORDER = "Ordem das miniaturas:",
    HUD_ORDER_RESET = "Ordem padrão",
    HUD_ORDER_HINT = "Setas: mover uma camada. No HUD, você também pode arrastar uma miniatura sobre outra.",
    HUD_CARD_DRAG = "Arrastar: movê-la (sobre outra miniatura)",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("ptBR", {
    CONTROLLER_LABEL = "Controle:",
    CONTROLLER_CHANGE = "Trocar...",
    CONTROLLER_PICK = "Escolha seu controle",
    CONTROLLER_OTHER = "Outro controle",
    EXTRA = "Botão",
    SOFTWARE_GENERIC = "o software do seu controle",
    TEST_INTRO = "Aperte qualquer botão: o que o WoW recebe se acende. Se seus botões extras não mostrarem nada, atribua teclas a eles no software do seu controle (veja Ajuda).",
    LEARN_MODKEY = "Atenção: %s é uma tecla Shift / Ctrl / Alt; no software do seu controle, prefira uma tecla como F9-F12.",



    TUTO_SOFTWARE_WHY = "O Windows vê a maioria dos controles como um controle de Xbox (XInput). Esse modo só transmite os botões padrão, "
        .. "então o WoW nunca recebe os extras. A solução: fazer cada um enviar uma tecla do teclado.",
    TUTO_SOFTWARE_VENDOR = "1. Conecte o controle e abra |cffffd100%s|r.\n"
        .. "2. Abra a página de mapeamento dos botões.\n"
        .. "3. Dê a cada botão extra (%s) uma tecla que você não usa no WoW. Boas opções: |cffffd100F9, F10, F11, F12|r "
        .. "ou o teclado numérico (com Num Lock ligado).\n"
        .. "4. Evite Shift, Ctrl e Alt: eles mudariam suas outras teclas de atalho.\n"
        .. "5. Salve o perfil (no controle, se o software permitir).",
    TUTO_SOFTWARE_ALT = "Se %s não conseguir dar uma tecla a esses botões, use o |cffffd100Steam Input|r: adicione o WoW (ou o launcher da Battle.net) "
        .. "à Steam como jogo não Steam, abra-o pela Steam e dê uma tecla a cada botão na configuração de controle dele. "
        .. "O |cffffd100reWASD|r (pago) também funciona, sem a Steam.",
    TUTO_SOFTWARE_STEAM = "1. Na |cffffd100Steam|r, adicione o WoW (ou o launcher da Battle.net) como jogo não Steam "
        .. "(Jogos > Adicionar jogo não Steam à biblioteca) e abra-o pela Steam.\n"
        .. "2. Abra a configuração de controle dele (overlay da Steam ou as configurações de controle do jogo na Steam).\n"
        .. "3. Dê a cada botão extra (%s) uma tecla que você não usa no WoW. Boas opções: |cffffd100F9, F10, F11, F12|r.\n"
        .. "4. Evite Shift, Ctrl e Alt: eles mudariam suas outras teclas de atalho.\n\n"
        .. "O |cffffd100reWASD|r (pago) faz o mesmo sem a Steam.",

    TUTO_DETECT_ALL = "|cff40ff40Todos os seus botões foram detectados.|r",



})

-- Profils : liste, export, import
ns.AddLocale("ptBR", {
    TAB_PROFILES = "Perfis",
    PROFILES_INTRO = "Um perfil guarda um controle, seus botões e, para cada personagem, suas ações. Um só perfil é usado por vez, para a conta inteira. O HUD é comum a todos os perfis.",
    PROFILE_ACTIVE = "em uso",
    PROFILE_USE = "Usar este perfil",
    PROFILE_NEW = "Novo...",
    PROFILE_COPY = "Copiar...",
    PROFILE_RENAME = "Renomear...",
    PROFILE_DELETE = "Excluir",
    PROFILE_EXPORT = "Exportar...",
    PROFILE_IMPORT = "Importar...",
    PROFILE_DEFAULT = "Perfil",
    PROFILE_IMPORTED = "Perfil importado",
    PROFILE_COPY_SUFFIX = "%s (cópia)",
    PROFILE_NAME_NEW = "Nome do novo perfil:",
    PROFILE_NAME_COPY = "Nome da cópia:",
    PROFILE_NAME_RENAME = "Novo nome para “%s”:",
    PROFILE_DELETE_CONFIRM = "Excluir o perfil “%s”? Os botões dele e as ações de todos os seus personagens para este perfil serão perdidos.",
    PROFILE_SWITCHED = "Perfil em uso: %s.",
    PROFILE_UNKNOWN = "Nenhum perfil se chama “%s”. Digite /mgir profiles para vê-los.",
    PROFILE_COMBAT = "Não é possível trocar de perfil em combate.",
    PROFILE_LAST = "Este é seu único perfil: ele não pode ser excluído.",
    PROFILE_CREATED = "Perfil “%s” criado e em uso. Configure as teclas dele na aba Botões.",

    EXPORT_TITLE = "Exportar “%s”",
    EXPORT_ACTIONS = "Incluir as ações deste personagem",
    EXPORT_HUD = "Incluir as configurações do HUD",
    EXPORT_HINT = "O texto está selecionado: Ctrl+C para copiá-lo e cole onde quiser (Discord, um arquivo de texto...). Ele é importado pelo botão Importar da aba Perfis.",
    CLOSE = "Fechar",

    IMPORT_TITLE = "Importar um perfil",
    IMPORT_PASTE = "Cole aqui o texto exportado (Ctrl+V):",
    IMPORT_EMPTY = "Cole um texto exportado para ver o que ele contém.",
    IMPORT_BAD = "Este não é um texto exportado do My Gamepad Is Rich.",
    IMPORT_VERSION = "Este texto vem de outra versão do addon e não pode ser lido.",
    IMPORT_DAMAGED = "Este texto está danificado ou incompleto: copie-o de novo, inteiro.",
    IMPORT_SUMMARY = "Perfil “%s”, controle: %s\n%d botão(ões) com tecla, %d ação(ões)",
    IMPORT_SUMMARY_HUD = "Contém configurações do HUD.",
    IMPORT_MACROS = "Atenção: %d macro(s) escrita(s) à mão. Leia antes de usar:",
    IMPORT_COMMANDS = "Comandos do WoW: %s",
    IMPORT_AS_NEW = "Novo perfil:",
    IMPORT_REPLACE = "Substituir:",
    IMPORT_PICK = "Perfil a substituir",
    IMPORT_ACTIONS = "Importar as ações (para este personagem)",
    IMPORT_HUD = "Aplicar as configurações do HUD",
    IMPORT_DO = "Importar",
    IMPORT_REPLACE_CONFIRM = "Substituir o perfil “%s”? O controle e os botões dele serão sobrescritos, e as ações dele para este personagem se você as importar.",
    IMPORT_DONE = "Perfil “%s” importado.",

    SELFTEST_OK = "Autoteste: tudo certo.",
    SELFTEST_FAIL = "Autoteste: %d problema(s): %s",
    SLASH_HELP = "/mgir : abrir  |  /mgir profile <nome> : trocar de perfil  |  /mgir test : teste do controle  |  /mgir tuto : tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : zerar as ações deste personagem",
})

-- HUD : arrêt après une erreur
ns.AddLocale("ptBR", {
    HUD_ERROR = "Erro do HUD: ele fica parado até o /reload (a barra do jogo volta). Por favor, informe esta mensagem: %s",
})

-- Gâchettes LT / RT données à l'addon
ns.AddLocale("ptBR", {
    TRIGGERS_LABEL = "Gatilhos LT / RT:",
    TRIGGERS_ADDON = "Modificadores do addon",
    TRIGGERS_GAME = "Camadas do jogo",
    TRIGGERS_ADDON_DESC = "Segure LT ou RT (ou os dois) e aperte A, B, X, Y ou o direcional: as ações do addon, com tudo o que ele permite (macros escritas à mão, comandos do WoW). Elas substituem as camadas LT, RT e LT + RT da barra de controle do jogo; uma casa vazia não faz nada. LB e RB não mudam.",
    TRIGGERS_GAME_DESC = "LT e RT mantêm as camadas da barra de controle do jogo (editáveis na aba Ações).",
    TRIGGERS_COPIED = "%d ação(ões) das camadas LT / RT do jogo copiada(s) para as do addon.",
    IMPORT_SUMMARY_TRIGGERS = "LT / RT: modificadores do addon.",
})

-- Menu d'une case : pourquoi des choix sont grisés
ns.AddLocale("ptBR", {
    MENU_GAME_BAR_HINT = "Macros escritas, comandos do WoW: dê LT / RT ao addon (aba Botões, Botões básicos)",
})

-- Actions de base (celles de Forever sur A/B/X/Y)
ns.AddLocale("ptBR", {
    MENU_GAME = "Ação básica...",
    GAME_TITLE = "Ações básicas",
    KIND_game = "Ação básica",
    GAME_jump = "Pular",
    GAME_cancel = "Cancelar (feitiço, alvo)",
    GAME_search = "Procurar (clique direito no alvo)",
    GAME_attack = "Ataque automático",
    GAME_interact = "Interagir",
})

-- Modes de ciblage (comme LB / RB dans Forever)
ns.AddLocale("ptBR", {
    MODE_TARGET_FRIEND = "Alvo aliado",
    MODE_TARGET_ENEMY = "Alvo inimigo",
    MODE_TARGET_FRIEND_DESC = "Como o LB no Forever: um toque rápido mira o aliado mais próximo; segure e mire com o analógico direito para escolher um. Segurado, também é um modificador: A, B, X, Y e o direcional disparam seus 8 atalhos.",
    MODE_TARGET_ENEMY_DESC = "Como o RB no Forever: um toque rápido mira o inimigo mais próximo; segure e mire com o analógico direito para escolher um. Segurado, também é um modificador: A, B, X, Y e o direcional disparam seus 8 atalhos.",
    TARGET_UNAVAILABLE = "O sistema de alvo do Forever não foi encontrado: %s funciona como um modificador comum.",
})

-- Onglet « Soutenir » (don PayPal)
ns.AddLocale("ptBR", {
    TAB_DONATE = "Apoiar",
    DONATE_TITLE = "Apoie o My Gamepad Is Rich",
    DONATE_INTRO = "O My Gamepad Is Rich é gratuito e continuará sendo. Se ele te ajuda e você quiser me agradecer, pode fazer uma doação pelo PayPal, do valor que quiser.",
    DONATE_SCAN = "Escaneie o QR code com seu celular",
    DONATE_LINK = "Ou copie o link (Ctrl+C) e cole no seu navegador:",
    DONATE_THANKS = "As doações são totalmente opcionais e não desbloqueiam nada: todos os recursos continuam disponíveis para todos. Obrigado pelo apoio!",
})

-- Boutons de base (LT, RT, LB, RB)
ns.AddLocale("ptBR", {
    MODE_GAME = "Jogo",
    MODE_GAME_DESC = "Este botão mantém sua função no jogo (LT / RT: camadas da barra de controle; LB / RB: o sistema de alvo do Forever).",
    PADS_LABEL = "Botões básicos:",
    PADS_PICK = "%s: escolher um modo",
    IMPORT_SUMMARY_PADS = "Botões básicos dados ao addon: %s",
    EMULATION_OFF = "%s não imita mais Shift / Ctrl enquanto pertence ao addon. Ela volta sozinha ao sair do jogo.",
    RESTORE_DONE = "Botões básicos devolvidos ao jogo e a imitação de Shift / Ctrl restaurada.",
})

-- Plus aucun ciblage allié / ennemi configuré
ns.AddLocale("ptBR", {
    TARGET_MISSING_FRIEND = "Nenhum botão mira aliados: volte o LB para “Jogo”, ou coloque um botão em “Alvo aliado” (aba Botões).",
    TARGET_MISSING_ENEMY = "Nenhum botão mira inimigos: volte o RB para “Jogo”, ou coloque um botão em “Alvo inimigo” (aba Botões).",
    TARGET_MISSING_BOTH = "Nenhum botão mira aliados nem inimigos: volte LB / RB para “Jogo”, ou coloque botões em “Alvo aliado” / “Alvo inimigo” (aba Botões).",
})

-- Onglet Boutons : mention des boutons de base
ns.AddLocale("ptBR", {
    PAD_HINT = "botão do controle: nada a detectar",
})

-- Case vide d'un bouton simple dans une couche : son action habituelle
ns.AddLocale("ptBR", {
    SIMPLE_USUAL = "Habitual",
})

-- Manettes standard (sans bouton supplémentaire), noms PlayStation
ns.AddLocale("ptBR", {
    TUTO_NO_EXTRA = "Este controle não tem botões extras: nada a configurar aqui. Você pode dar outras funções a LT, RT, LB e RB (Botões básicos, na aba Botões).",
    PS_CROSS = "Xis",
    PS_CIRCLE = "Círculo",
    PS_SQUARE = "Quadrado",
    PS_TRIANGLE = "Triângulo",
})

-- Paires libres (deux modificateurs quelconques)
ns.AddLocale("ptBR", {
})

-- Paire avec un bouton de base resté au jeu
ns.AddLocale("ptBR", {
})

-- Boutons de base : mode par défaut
ns.AddLocale("ptBR", {
    MODE_IS_DEFAULT = "Padrão para este botão: funciona como no jogo.",
})

-- Tutoriel : les types de boutons, boutons de base, paires ; options
ns.AddLocale("ptBR", {
    MODE = "Tipo:",
    TUTO_WELCOME_TEXT = "Este addon permite escolher o que cada botão do seu controle faz: os botões extras (paletas traseiras, gatilhos extras: GameSir, Xbox Elite, DualSense Edge, SCUF...) e os botões básicos LT, RT, LB e RB.\n\n|cffffd100A ideia: camadas.|r Sozinhos, A, B, X, Y e o direcional lançam 8 ações. Segure um botão (LT, RT, uma paleta...) e esses mesmos 8 botões lançam outras 8 ações: é uma nova camada. Cada botão que você segura dá uma.\n\nEste tutorial leva cerca de dois minutos. Você pode sair a qualquer momento e reabri-lo com |cffffd100/mgir tuto|r.",
    TUTO_CONTROLLER_TITLE = "Seu controle",
    TUTO_CONTROLLER_TEXT = "Escolha seu controle: o addon usa os nomes dos botões extras e mostra o programa que os configura. Um controle Xbox ou PlayStation comum, sem botões extras? Escolha-o também: você ainda poderá configurar LT, RT, LB e RB. Não está na lista? Escolha |cffffd100Outro controle|r (até 6 botões, que você pode renomear).",
    TUTO_TYPES_TITLE = "Os 4 tipos de botão",
    TUTO_TYPES_TEXT = "Cada botão recebe um tipo, que diz o que ele faz. Você o escolhe nas próximas etapas e a qualquer momento na aba |cffffd100Botões|r (passe o mouse sobre um tipo para rever a explicação).",
    TYPE_MODIFIER_HOW = "Segure-o e aperte A, B, X, Y ou o direcional: uma camada de 8 ações. Sozinho, não faz nada.",
    TYPE_MODIFIER_FOR = "Para: botões fáceis de manter pressionados. Padrão para LT e RT, como no jogo.",
    TYPE_TARGET_HOW = "Um toque rápido seleciona o aliado (ou inimigo) mais próximo; segure e mire com o analógico direito para escolher outro. Segurado com A, B, X, Y ou o direcional: 8 atalhos, como um modificador.",
    TYPE_TARGET_FOR = "Para: curas e feitiços em um alvo. Padrão para LB (aliado) e RB (inimigo), como no jogo.",
    TYPE_SIMPLE_HOW = "Um toque lança uma ação. Com LT ou RT segurado, lança outra. Também tem um espaço em cada camada de modificador.",
    TYPE_SIMPLE_FOR = "Para: um feitiço que você usa muito, uma poção, uma montaria.",
    TYPE_OFF_HOW = "O botão não faz nada: sua tecla fica livre para outra coisa.",
    TYPE_OFF_FOR = "Para: botões extras que você não usa (os botões básicos não têm este tipo).",
    TUTO_SOFTWARE_TITLE = "Fazer os botões extras enviarem uma tecla",
    TUTO_DETECT_TITLE = "Detectar seus botões extras",
    TUTO_DETECT_MISSING = "Nada acontece ao apertar? Verifique a tecla do botão no programa do seu controle e tente de novo.",
    TUTO_MODES_TITLE = "O tipo dos seus botões extras",
    TUTO_MODES_TEXT = "Escolha o tipo de cada botão extra (passe o mouse sobre um tipo para ver o que ele faz).\nDica: modificadores nos botões mais fáceis de segurar, botões simples nos outros. |cffffd100Usar os tipos sugeridos|r faz isso por você.",
    TUTO_SUGGESTED = "Usar os tipos sugeridos",
    TUTO_PADS_TITLE = "Seus botões básicos: LT, RT, LB, RB",
    TUTO_PADS_TEXT = "Por padrão (em verde), funcionam como no jogo: LT e RT são modificadores, LB seleciona aliados e RB inimigos. As ações da barra de controle do jogo são copiadas para as camadas deles. Você pode mudá-los: por exemplo RB como botão simples, ou LB como modificador.",
    TUTO_PADS_DEFAULT = "Voltar aos tipos padrão",
    TUTO_PAIRS_TITLE = "Pares: dois botões segurados juntos",
    TUTO_PAIRS_TEXT = "Segure dois botões juntos (modificadores ou de alvo): mais uma camada de 8 ações. Quaisquer dois podem formar um par: L5 + R5, LT + RT, LB + LT... Marque os que quiser (você pode mudar depois na aba |cffffd100Botões|r). Padrão: os pares esquerda + direita.",
    TUTO_ACTIONS_TITLE = "Colocar suas ações",
    TUTO_ACTIONS_TEXT = "Na aba |cffffd100Ações|r: à esquerda, todas as suas camadas (Sozinho, LT, RT, seus modificadores e pares); à direita, a camada escolhida, organizada como o controle.\n\n- Arraste um feitiço do grimório, um item das bolsas, uma macro, uma montaria ou um brinquedo para um espaço.\n- Ou clique em um espaço: escolher um feitiço ou item, escrever uma macro, escolher um comando do WoW (Correr automaticamente...) ou uma ação básica (Pular, Interagir...). Clique direito: limpar.\n- A linha abaixo do direcional: os espaços dos seus botões simples nessa camada.\n\nVocê também pode clicar em uma miniatura de camada no HUD para editá-la ali mesmo.\n\nAs ações são salvas por personagem; tipos e teclas no perfil, para toda a conta. Tudo funciona em combate; só as mudanças feitas em combate esperam ele acabar.",
    TUTO_HUD_TEXT = "O addon substitui a barra de controle do jogo pelo seu próprio HUD:\n\n- |cffffd100Em destaque|r: a camada que você está usando, direcional à esquerda, A/B/X/Y à direita. Segure um botão e ela muda.\n- |cffffd100Miniaturas|r: todas as suas camadas, com os espaços dos botões simples no meio; a que você segura acende. Clique em uma para editá-la.\n- |cffffd100No centro|r: seus botões simples, com a ação que vão lançar.\n\nAjustes (tamanho, posição, miniaturas): aba |cffffd100HUD|r. |cffffd100/mgir hud off|r: voltar à barra do jogo.",
    TUTO_DONE_TEXT = "Abra a configuração para colocar suas primeiras ações.\n\n|cffffd100/mgir|r: abrir a configuração\n|cffffd100/mgir test|r: teste do controle, para ver o que o WoW recebe\n|cffffd100/mgir tuto|r: este tutorial\n|cffffd100/mgir reset|r: limpar as ações deste personagem\n|cffffd100/mgir restore|r: devolver LT, RT, LB e RB ao jogo",
    SETTINGS_DESC = "Escolha o que cada botão do seu controle faz: botões extras (paletas traseiras, gatilhos extras) e botões básicos (LT, RT, LB, RB). Comando: /mgir",
    BUTTONS_INTRO = "Escolha o tipo de cada botão: passe o mouse sobre um tipo para ver o que ele faz. Em verde: o tipo padrão dos botões básicos, que funciona como o jogo.",
    BUTTONS_TYPES_HELP = "Os tipos de botão",
    PAIRS_HINT = "Marque os pares que quer usar: segurar os dois botões juntos dá 8 ações a mais. Quaisquer dois modificadores ou botões de alvo podem formar um par (L5 + LT, LB + RT...).",
    PAIRS_NONE = "Coloque pelo menos dois botões em Modificador, Alvo aliado ou Alvo inimigo para formar pares.",
    PAIR_WAITS = "%s está em Jogo: coloque em Modificador, Alvo aliado ou Alvo inimigo (acima)",
})

-- Tutoriel, paires : appuyer sur les boutons pour les trouver
ns.AddLocale("ptBR", {
    TUTO_PAIRS_PRESS = "Aperte um botão do controle: os pares dele acendem em verde. Aperte dois botões juntos: o par deles acende.",
})

-- LB + LT et RB + RT : l'action de classe de Forever
ns.AddLocale("ptBR", {
    PAIR_CLASS_WARN = "também aciona a ação de classe do Forever",
    PAIR_CLASS_WARN_LONG = "Atenção: %s também aciona a ação de classe do Forever (muitas vezes uma roda de feitiços, que assume A, B, X e Y enquanto está aberta; B fecha). O addon não pode impedir: escolha outro par.",
    PAIR_CLASS_NOTE = "%s e %s também acionam a ação de classe do Forever (muitas vezes uma roda de feitiços que assume A, B, X e Y). O addon não pode impedir: é melhor escolher outros pares.",
})

-- Forever resté sur sa barre LT / RT
ns.AddLocale("ptBR", {
    FOREVER_STUCK = "O Forever ficou preso na barra %s (a soltura de um botão se perdeu). Aperte %s uma vez para voltar a \"Sozinho\".",
})

-- 1.1.0 : spés, état des actions sur le HUD, profils, remplissage rapide, rapport
ns.AddLocale("ptBR", {
    SPEC_NUMBER = "Especialização %d",
    SPEC_SWITCHED = "Ações da especialização \"%s\".",
    SPEC_NEW = "Nova especialização \"%s\": ela começa com uma cópia das ações da anterior.",
    PROFILE_PER_CHAR = "Lembrar o perfil de cada personagem",
    PROFILE_PER_CHAR_DESC = "Ao entrar, cada personagem volta ao último perfil que usou. Sem esta opção, todos usam o último perfil usado na conta.",
    REPORT_BUTTON = "Copiar um relatório",
    REPORT_TITLE = "Relatório do controle",
    REPORT_HINT = "Primeiro aperte cada botão na aba Teste, depois copie este texto (Ctrl+C) e envie ao autor do addon, com o que funciona e o que não funciona. Ele ajuda a confirmar as configurações de outros controles. Nenhum nome de personagem ou de reino é incluído.",
    WHATSNEW_TITLE = "Novidades do My Gamepad Is Rich",
    QUICKFILL_BUTTON = "Preencher espaços vazios",
    QUICKFILL_DESC = "Coloca nos espaços vazios desta camada a pedra de regresso, os berloques usáveis equipados e os consumíveis das bolsas (poções, comida, ataduras, elixires...), exceto os que já estão lá. Clique direito num espaço para esvaziá-lo.",
    QUICKFILL_DONE = "%d espaço(s) preenchido(s).",
    QUICKFILL_NONE = "Nada a colocar: nenhum item usável nas bolsas que já não esteja nesta camada.",
})

-- 1.1.0 : modèles de classe, copie de couches, verrou, annulation, véhicules
ns.AddLocale("ptBR", {
    SLASH_HELP = "/mgir : abrir  |  /mgir profile <nome> : trocar de perfil  |  /mgir test : teste do controle  |  /mgir tuto : tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : zerar as ações deste personagem  |  /mgir undo : desfazer a última mudança de ações",
    LEARN_PAD_REFUSED = "%s é um botão básico do controle: o addon o combina ou o configura sozinho. Aperte o botão extra (a tecla que o software dele envia).",
    RESET_CONFIRM = "Esvaziar todas as ações deste personagem no perfil atual?",
    RESET_CONFIRM_SPEC = "Esvaziar todas as ações deste personagem para a especialização \"%s\", no perfil atual?",
    UNDO_HINT = "/mgir undo para voltar atrás.",
    UNDO_DONE = "Ações restauradas como antes da última mudança.",
    UNDO_NONE = "Nada a desfazer para esta especialização.",
    ACTION_COUNT = "%d ação(ões)",
    LAYER_COPY_BUTTON = "Copiar / trocar…",
    LAYER_COPY_DESC = "Copia as ações desta camada para outra camada, ou troca as ações das duas camadas (os 8 espaços e os dos botões simples).",
    LAYER_COPY_TITLE = "Camada %s",
    LAYER_COPY_TO = "Copiar para",
    LAYER_SWAP_WITH = "Trocar com",
    LAYER_COPY_NONE = "Nenhuma outra camada de combinações: primeiro transforme outro botão em modificador.",
    LAYER_COPY_CONFIRM = "Substituir as ações da camada %s (%d) pelas de %s?",
    LAYER_COPIED = "%s copiada para %s.",
    LAYER_SWAPPED = "%s e %s trocadas.",
    TPL_BUTTON = "Modelos e especializações…",
    TPL_DESC = "Modelos de classe: salve as ações desta especialização para a conta inteira e depois carregue-as em outro personagem da mesma classe. Você também pode copiar as ações de outra especialização. As ações que ficam na barra do jogo não entram.",
    TPL_TITLE = "Modelos e especializações",
    TPL_SECTION_SAVE = "Salvar",
    TPL_SAVE = "Salvar estas ações como modelo…",
    TPL_SECTION_LOAD = "Carregar um modelo (%s)",
    TPL_SECTION_SPEC = "Copiar de uma especialização",
    TPL_SECTION_DELETE = "Excluir um modelo",
    TPL_SAVE_PROMPT = "Nome do modelo (para todos os personagens %s da conta):",
    TPL_SAVED = "Modelo \"%s\" salvo para %s.",
    TPL_REPLACE_CONFIRM = "Substituir o modelo \"%s\"?",
    TPL_LOAD_CONFIRM = "Carregar o modelo \"%s\"? Ele substitui as ações de %s.",
    TPL_LOADED = "Modelo \"%s\" carregado.",
    TPL_DELETE_CONFIRM = "Excluir o modelo \"%s\" para todos os personagens desta classe?",
    TPL_DELETED = "Modelo \"%s\" excluído.",
    SPEC_COPY_CONFIRM = "Copiar as ações de \"%s\"? Elas substituem as ações de %s.",
    SPEC_COPIED = "Ações de \"%s\" copiadas.",
    LATCH = "Travável",
    LATCH_DESC = "Um toque ativa a camada deste modificador e o toque seguinte a desativa: não precisa segurá-lo. Outro modificador segurado assume enquanto estiver segurado. Qualquer mudança de configuração libera a trava. Só botões extras (não LT, RT, LB, RB).",
})

-- 1.1.0 : notes de version (tout ce qui a changé depuis la 1.0.0)
ns.AddLocale("ptBR", {
    WHATSNEW_1_1_5 = "• Alvo aliado / inimigo: em combate, o botão não fica mais preso depois de solto (o HUD ficava na camada dele e o analógico continuava mirando). Um toque rápido ainda passa para o próximo alvo, e um toque longo mantém o alvo escolhido.",
    WHATSNEW_1_1_4 = "• Alvo aliado / inimigo: cada toque rápido passa para o próximo alvo, mesmo se você já tiver um, inclusive onde o jogo não fornece a hora ao addon. Um toque longo mantém o alvo escolhido com o analógico.\n• /mgir etat mostra como um toque rápido é reconhecido.",
    WHATSNEW_1_1_3 = "• Alvo aliado / inimigo: o alvo escolhido com o analógico continua selecionado quando você solta o botão. Só um toque rápido seleciona o mais próximo.",
    WHATSNEW_1_1_2 = "• Um comando do WoW ou uma macro escrita à mão pode usar o ícone que você quiser: clique no espaço, \"Mudar ícone...\". A busca encontra os ícones dos seus feitiços, itens e comandos do WoW, ou um ícone pelo nome do arquivo (como no Wowhead: inv_misc_map_01).\n• Os comandos mais comuns têm ícone próprio em vez da chave: mapa-múndi, bolsas, grimório, registro de missões, personagem, conquistas, localizador de grupos, coleções.",
    WHATSNEW_1_1_1 = "• Botão simples: uma camada vazia (LT, RT ou um modificador) agora não faz nada e fica vazia no HUD, em vez de usar a ação \"Sozinho\". Única exceção: um comando do WoW colocado em \"Sozinho\".\n• A lista de feitiços agora inclui os feitiços de profissão: Encontrar Ervas, Encontrar Minérios, Pesca, Culinária, Arqueologia…",
    WHATSNEW_1_1_0 = "• HUD: as ações do addon aparecem como nas barras do jogo. Vermelhas fora de alcance, azuis sem recurso suficiente, cinza quando inutilizáveis, borda dourada durante um proc, cargas restantes, acesas enquanto ativas (ataque automático, forma...).\n• HUD: a ordem das miniaturas das camadas pode ser escolhida (setas da aba HUD, ou arraste uma miniatura sobre outra).\n• Cada especialização tem suas próprias ações. Uma nova especialização começa com uma cópia das ações da anterior.\n• Aba Ações: \"Preencher espaços vazios\" coloca a pedra de regresso, os berloques e os consumíveis das bolsas numa camada de modificador, e \"Copiar / trocar…\" copia uma camada de combinações para outra, ou troca duas camadas.\n• Modelos de classe: salve suas ações para a conta inteira e carregue-as em outro personagem da mesma classe (\"Modelos e especializações…\" abaixo da lista de camadas). Você também pode copiar as ações de outra especialização.\n• Modificador travável (aba Botões): um toque ativa a camada, o seguinte a desativa.\n• /mgir reset pede confirmação, e /mgir undo volta atrás depois de zerar, de um modelo ou de uma cópia de especialização ou de camada.\n• Perfis: opção \"Lembrar o perfil de cada personagem\".\n• Camadas travadas: um botão básico dado ao addon fica com quem recebeu o aperto até ser solto, e o Forever não fica mais preso na barra RT (ou LT), por exemplo depois de um feitiço lançado com RT + A como um selo de paladino.\n• Veículos, barras de substituição e batalhas de mascotes: o addon sai do caminho e os botões do jogo funcionam, também em combate.\n• Não precisa mais de /mgir restore antes de desativar o addon: a cada saída, LT e LB recuperam a imitação de Shift / Ctrl, e o addon a corta de novo ao entrar.\n• Detectar recusa A, B, X, Y, o direcional e LT, RT, LB, RB (apertados por engano, virariam a tecla de um botão extra).\n• Aba Teste do controle: \"Copiar um relatório\" (com o registro recente das camadas), para enviar e ajudar a confirmar outros controles. /mgir etat mostra o estado das camadas.\n• /mgir news: rever esta janela.",
})

-- Marqueurs de raid (actions de base)
ns.AddLocale("ptBR", {
    GAME_markquick = "Marcação rápida (próxima marca a cada toque)",
    GAME_mark = "Marcar: %s",
    GAME_markclear = "Remover a marca",
})

-- Se cibler (action de base)
ns.AddLocale("ptBR", {
    GAME_targetself = "Selecionar a si mesmo",
})

-- Nouveautés de la 1.1.6
ns.AddLocale("ptBR", {
    WHATSNEW_1_1_6 = "• Marcas de raide nas ações básicas: \"Marcação rápida\" coloca a próxima marca no seu alvo a cada toque (caveira, xis, quadrado, lua, triângulo, losango, círculo, estrela), cada uma das 8 marcas e \"Remover a marca\".\n• \"Selecionar a si mesmo\" nas ações básicas.\n• A dica de um feitiço mostra a classe dele.\n• Alvo aliado / inimigo: cada toque rápido agora passa ao próximo alvo, também no Forever, e a mira com o analógico direito responde na hora. O alvo mirado fica se o analógico ainda estiver inclinado ao soltar o botão, ou depois de um toque segurado.",
})
