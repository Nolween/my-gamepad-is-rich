-- Español (España y México)
local _, ns = ...

ns.AddLocale("esES", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "Botones",
    TAB_TEST = "Prueba del mando",
    TAB_HELP = "Ayuda",

    NAME = "Nombre:",
    KEY = "Tecla:",
    KEY_NONE = "sin asignar",
    DETECT = "Detectar",
    CLEAR = "Borrar",
    MODE_MODIFIER = "Modificador",
    MODE_SIMPLE = "Botón simple",
    MODE_OFF = "Desactivado",
    MODE_MODIFIER_DESC = "Mantén este botón y pulsa A, B, X, Y o la cruceta: 8 combinaciones nuevas, como LT/RT.",
    MODE_SIMPLE_DESC = "Una acción, más otra con LT mantenido y otra con RT mantenido. Una capa vacía usa la acción «Solo».",
    MODE_OFF_DESC = "Este botón no hace nada: su tecla queda libre.",
    LAYER_BASE = "Solo",
    LAYER_LT = "LT +",
    LAYER_RT = "RT +",
    SLOT_HINT = "Arrastra un hechizo, objeto, macro o montura a una casilla. Clic derecho: más opciones.",
    EMPTY = "Vacío",
    NO_KEY_WARNING = "Primero asigna la tecla: haz clic en «Detectar» y pulsa el botón.",

    MENU_SPELL = "Elegir un hechizo...",
    MENU_ITEM = "Elegir un objeto de la bolsa...",
    SPELL_TITLE = "Hechizos del personaje",
    ITEM_TITLE = "Objetos de las bolsas",
    ITEMS_EQUIPPED = "Equipados (usables)",
    ITEMS_USABLE = "Usables",
    ITEMS_OTHER = "Otros objetos",
    LIST_EMPTY = "Nada que mostrar.",
    MENU_MACROTEXT = "Escribir una macro...",
    MENU_COMMAND = "Comando de WoW...",
    MENU_CLEAR = "Vaciar",
    MENU_PICKUP_HINT = "O suelta aquí un hechizo / objeto / macro / montura",
    MACRO_TITLE = "Texto de la macro",
    MACRO_HELP = "Un comando por línea, p. ej. /cast Bola de Fuego  (255 caracteres máx.)",
    OK = "Aceptar",
    CANCEL = "Cancelar",
    COMMAND_TITLE = "Comando de WoW",
    SEARCH = "Buscar:",
    COMMAND_LT_RT = "Un comando de WoW solo funciona en la capa «Solo» de un botón sin capas LT/RT.",

    KIND_spell = "Hechizo",
    KIND_item = "Objeto",
    KIND_toy = "Juguete",
    KIND_mount = "Montura",
    KIND_macro = "Macro",
    KIND_macrotext = "Macro personalizada",
    KIND_command = "Comando de WoW",
    KIND_equipset = "Conjunto de equipo",

    CURSOR_UNSUPPORTED = "Esto no puede ir en un botón (solo hechizos, objetos, juguetes, monturas, macros y conjuntos de equipo).",
    APPLIED_AFTER_COMBAT = "En combate: los cambios se aplicarán al terminar el combate.",
    APPLIED = "Cambios aplicados.",
    LEARN_PROMPT = "Pulsa el botón del mando para |cffffd100%s|r\n\n(Esc para cancelar)",
    LEARN_COMBAT = "No se puede detectar un botón en combate.",
    LEARN_DONE = "%s está ahora en la tecla %s.",
    LEARN_TAKEN = "La tecla %s la usaba %s: se le ha quitado.",
    LEARN_BOUND = "Nota: %s estaba asignada a «%s» en WoW; mientras este addon la use, el addon tiene prioridad.",

    TEST_STANDARD = "Botones estándar",
    TEST_EXTRA = "Botones adicionales",
    TEST_LOG = "Últimas entradas",
    TEST_GAME = "juego",
    TEST_UNKNOWN = "sin asignar",

    IF_WARNING = "Improved Forever está cargado: si también usa una de estas teclas, gana la última asignación aplicada.",
    OPEN_CONFIG = "Abrir la configuración",
    LOADED = "cargado. Escribe /mgir para configurar tus botones adicionales.",
    RESET_DONE = "Se han reiniciado las acciones de este personaje.",

    DPAD_UP = "Cruceta arriba",
    DPAD_DOWN = "Cruceta abajo",
    DPAD_LEFT = "Cruceta izquierda",
    DPAD_RIGHT = "Cruceta derecha",
    PADDLE = "Paleta %s",

    TUTO_TITLE = "Tutorial",
    TUTO_NEXT = "Siguiente",
    TUTO_BACK = "Anterior",
    TUTO_SKIP = "Saltar el tutorial",
    TUTO_FINISH = "Abrir la configuración",
    TUTO_REOPEN = "Tutorial cerrado. Escribe /mgir tuto para volver a verlo.",
    HELP_REPLAY = "Ver el tutorial de nuevo",

    TUTO_WELCOME_TITLE = "Bienvenido a My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "Para cada botón, haz clic en |cffffd100Detectar|r y pulsa ese botón en tu mando. "
        .. "La tecla que envía aparece al lado.",



    TUTO_DONE_TITLE = "Todo listo",
})

-- HUD
ns.AddLocale("esES", {
    HUD_UNLOCKED = "HUD desbloqueado: arrástralo con el ratón. Escribe /mgir hud otra vez para bloquearlo.",
    HUD_LOCKED = "HUD bloqueado.",
    HUD_ON = "HUD visible: sustituye la barra de mando del juego.",
    HUD_OFF = "HUD oculto: vuelve la barra de mando del juego. Escribe /mgir hud on para mostrarlo de nuevo.",
    HUD_SCALE = "Tamaño del HUD: %s",
    TUTO_HUD_TITLE = "Tu HUD de mando",
})

-- HUD : attribution rapide
ns.AddLocale("esES", {
    HUD_COMBAT = "No se pueden cambiar las acciones en combate.",
    HUD_GAME_SLOT = "Este botón conserva la acción del juego (saltar, interactuar...).",
    HUD_KIND = "La barra del juego solo admite hechizos, objetos, monturas y macros de la lista de macros.",
    HUD_EDITING = "Editando esta capa: haz clic en una casilla para asignarla, clic derecho para vaciarla. Vuelve a hacer clic en la miniatura, o pulsa cualquier otro botón o tecla, para volver.",
    HUD_TILE_HINT = "Clic: asignar  -  Clic derecho: vaciar",
    HUD_CARD_HINT = "Clic: editar esta capa",
})

-- HUD : bande des miniatures
ns.AddLocale("esES", {
    HUD_STRIP_TOP = "Miniaturas de las capas ahora encima del HUD. Escribe /mgir hud strip para cambiar.",
    HUD_STRIP_BOTTOM = "Miniaturas de las capas ahora debajo del HUD. Escribe /mgir hud strip para cambiar.",
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("esES", {
    TUTO_STRIP_LABEL = "Miniaturas de las capas:",
    TUTO_STRIP_BOTTOM = "Abajo (recomendado)",
    TUTO_STRIP_TOP = "Arriba",
})

-- Bouton de la minimap
ns.AddLocale("esES", {
    MINIMAP_LEFT = "Clic izquierdo: abrir la configuración",
    MINIMAP_RIGHT = "Clic derecho: desbloquear / bloquear el HUD para moverlo",
    MINIMAP_SHIFT = "Mayús + clic izquierdo: tutorial",
    MINIMAP_DRAG = "Arrastrar: mover este botón alrededor del minimapa",
    MINIMAP_HIDDEN = "Botón del minimapa oculto. Escribe /mgir minimap para mostrarlo de nuevo.",
    MINIMAP_SHOWN = "Botón del minimapa visible.",
})

-- Paires de modificateurs
ns.AddLocale("esES", {
    PAIR_READY = "Pareja · mantener ambos",
    PAIR_NOT_READY = "Pareja · no disponible",
    PAIR_DESC = "Mantén %s y %s a la vez y pulsa A, B, X, Y o la cruceta: 8 combinaciones más.",
    PAIR_NEEDS = "Para usar esta pareja, %s y %s deben estar ambos en modo Modificador, con una tecla.",
})

-- Fenêtre de configuration (onglets Actions, Boutons, HUD)
ns.AddLocale("esES", {
    TAB_ACTIONS = "Acciones",
    TAB_HUD = "HUD",
    SECTION_PAD = "Barra del mando",
    SECTION_MODS = "Modificadores",
    SECTION_MODS_EMPTY = "Ninguno aún: pon un botón en Modificador en la pestaña Botones.",
    SECTION_SIMPLE = "Botones simples",
    SECTION_SIMPLE_EMPTY = "Ninguno aún: pon un botón en Botón simple en la pestaña Botones.",
    LAYER_DESC_BASE = "A, B, X, Y y la cruceta sin mantener nada. Todo cabe aquí: lo que la barra del juego no puede contener (macro escrita a mano, comando de WoW) lo toma el addon. A, B, X e Y conservan las acciones del juego (saltar, interactuar...) hasta que pongas las tuyas.",
    LAYER_DESC_HOLD = "Mantén %s y pulsa A, B, X, Y o la cruceta.",
    PAIRS_TITLE = "Parejas (dos modificadores mantenidos a la vez)",
    HUD_INTRO = "El HUD sustituye la barra de mando del juego: la capa en uso en grande y todas las capas en miniatura.",
    HUD_SHOW = "Mostrar el HUD (en lugar de la barra de mando del juego)",
    HUD_SIZE = "Tamaño:",
    HUD_MOVE = "Mover el HUD",
    HUD_MOVE_DONE = "Bloquear el HUD",
    HUD_RESET = "Restablecer posición y tamaño",
    MINIMAP_SHOW = "Botón junto al minimapa",
    GAME_ACTION = "Juego",
    BAR_UNAVAILABLE = "La barra de mando del juego no está disponible (¿está activada la interfaz de mando?).",
    KIND_slot = "Acción",
    SLOT_HINT = "Arrastra un hechizo, objeto, macro o montura a una casilla. Clic: menú. Clic derecho: vaciar.",
})

-- HUD : taille et lignes des miniatures
ns.AddLocale("esES", {
    HUD_STRIP_SIZE = "Tamaño de las miniaturas:",
    HUD_STRIP_ROWS = "Filas de miniaturas:",
    HUD_ORDER = "Orden de las miniaturas:",
    HUD_ORDER_RESET = "Orden por defecto",
    HUD_ORDER_HINT = "Flechas: mover una capa. En el HUD también puedes arrastrar una miniatura sobre otra.",
    HUD_CARD_DRAG = "Arrastrar: moverla (sobre otra miniatura)",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("esES", {
    CONTROLLER_LABEL = "Mando:",
    CONTROLLER_CHANGE = "Cambiar...",
    CONTROLLER_PICK = "Elige tu mando",
    CONTROLLER_OTHER = "Otro mando",
    EXTRA = "Botón",
    SOFTWARE_GENERIC = "el software de tu mando",
    TEST_INTRO = "Pulsa cualquier botón: lo que recibe WoW se ilumina. Si tus botones adicionales no muestran nada, asígnales teclas en el software de tu mando (ver Ayuda).",
    LEARN_MODKEY = "Atención: %s es una tecla Mayús / Ctrl / Alt; en el software de tu mando, mejor usa una tecla como F9-F12.",



    TUTO_SOFTWARE_WHY = "Windows ve la mayoría de los mandos como un mando de Xbox (XInput). Ese modo solo transmite los botones estándar, "
        .. "así que WoW nunca recibe los adicionales. La solución: hacer que cada uno envíe una tecla del teclado.",
    TUTO_SOFTWARE_VENDOR = "1. Conecta el mando y abre |cffffd100%s|r.\n"
        .. "2. Abre la página de asignación de botones.\n"
        .. "3. Asigna a cada botón adicional (%s) una tecla que no uses en WoW. Buenas opciones: |cffffd100F9, F10, F11, F12|r "
        .. "o el teclado numérico (con Bloq Num activado).\n"
        .. "4. Evita Mayús, Ctrl y Alt: cambiarían tus otras asignaciones.\n"
        .. "5. Guarda el perfil (en el mando, si el software lo permite).",
    TUTO_SOFTWARE_ALT = "Si %s no puede asignar una tecla a estos botones, usa |cffffd100Steam Input|r: añade WoW (o el launcher de Battle.net) "
        .. "a Steam como juego ajeno a Steam, lánzalo desde Steam y asigna una tecla a cada botón en su configuración del mando. "
        .. "|cffffd100reWASD|r (de pago) también sirve, sin Steam.",
    TUTO_SOFTWARE_STEAM = "1. En |cffffd100Steam|r, añade WoW (o el launcher de Battle.net) como juego ajeno a Steam "
        .. "(Juegos > Añadir un juego ajeno a Steam a mi biblioteca) y lánzalo desde Steam.\n"
        .. "2. Abre su configuración del mando (overlay de Steam o los ajustes del mando del juego en Steam).\n"
        .. "3. Asigna a cada botón adicional (%s) una tecla que no uses en WoW. Buenas opciones: |cffffd100F9, F10, F11, F12|r.\n"
        .. "4. Evita Mayús, Ctrl y Alt: cambiarían tus otras asignaciones.\n\n"
        .. "|cffffd100reWASD|r (de pago) hace lo mismo sin Steam.",

    TUTO_DETECT_ALL = "|cff40ff40Todos tus botones están detectados.|r",



})

-- Profils : liste, export, import
ns.AddLocale("esES", {
    TAB_PROFILES = "Perfiles",
    PROFILES_INTRO = "Un perfil contiene un mando, sus botones y, para cada personaje, sus acciones. Se usa un solo perfil a la vez, para toda la cuenta. El HUD es común a todos los perfiles.",
    PROFILE_ACTIVE = "en uso",
    PROFILE_USE = "Usar este perfil",
    PROFILE_NEW = "Nuevo...",
    PROFILE_COPY = "Copiar...",
    PROFILE_RENAME = "Renombrar...",
    PROFILE_DELETE = "Eliminar",
    PROFILE_EXPORT = "Exportar...",
    PROFILE_IMPORT = "Importar...",
    PROFILE_DEFAULT = "Perfil",
    PROFILE_IMPORTED = "Perfil importado",
    PROFILE_COPY_SUFFIX = "%s (copia)",
    PROFILE_NAME_NEW = "Nombre del nuevo perfil:",
    PROFILE_NAME_COPY = "Nombre de la copia:",
    PROFILE_NAME_RENAME = "Nuevo nombre para «%s»:",
    PROFILE_DELETE_CONFIRM = "¿Eliminar el perfil «%s»? Se perderán sus botones y las acciones de todos tus personajes para este perfil.",
    PROFILE_SWITCHED = "Perfil en uso: %s.",
    PROFILE_UNKNOWN = "Ningún perfil se llama «%s». Escribe /mgir profiles para verlos.",
    PROFILE_COMBAT = "No se puede cambiar de perfil en combate.",
    PROFILE_LAST = "Es tu único perfil: no se puede eliminar.",
    PROFILE_CREATED = "Perfil «%s» creado y en uso. Configura sus teclas en la pestaña Botones.",

    EXPORT_TITLE = "Exportar «%s»",
    EXPORT_ACTIONS = "Incluir las acciones de este personaje",
    EXPORT_HUD = "Incluir los ajustes del HUD",
    EXPORT_HINT = "El texto está seleccionado: Ctrl+C para copiarlo y pégalo donde quieras (Discord, un archivo de texto...). Se importa con el botón Importar de la pestaña Perfiles.",
    CLOSE = "Cerrar",

    IMPORT_TITLE = "Importar un perfil",
    IMPORT_PASTE = "Pega aquí el texto exportado (Ctrl+V):",
    IMPORT_EMPTY = "Pega un texto exportado para ver lo que contiene.",
    IMPORT_BAD = "No es un texto exportado de My Gamepad Is Rich.",
    IMPORT_VERSION = "Este texto viene de otra versión del addon y no se puede leer.",
    IMPORT_DAMAGED = "Este texto está dañado o incompleto: vuelve a copiarlo entero.",
    IMPORT_SUMMARY = "Perfil «%s», mando: %s\n%d botón(es) con tecla, %d acción(es)",
    IMPORT_SUMMARY_HUD = "Incluye ajustes del HUD.",
    IMPORT_MACROS = "Atención: %d macro(s) escrita(s) a mano. Léelas antes de usarlas:",
    IMPORT_COMMANDS = "Comandos de WoW: %s",
    IMPORT_AS_NEW = "Nuevo perfil:",
    IMPORT_REPLACE = "Reemplazar:",
    IMPORT_PICK = "Perfil que reemplazar",
    IMPORT_ACTIONS = "Importar las acciones (para este personaje)",
    IMPORT_HUD = "Aplicar los ajustes del HUD",
    IMPORT_DO = "Importar",
    IMPORT_REPLACE_CONFIRM = "¿Reemplazar el perfil «%s»? Se sobrescribirán su mando y sus botones, y sus acciones para este personaje si las importas.",
    IMPORT_DONE = "Perfil «%s» importado.",

    SELFTEST_OK = "Autoprueba: todo correcto.",
    SELFTEST_FAIL = "Autoprueba: %d problema(s): %s",
    SLASH_HELP = "/mgir : abrir  |  /mgir profile <nombre> : cambiar de perfil  |  /mgir test : prueba del mando  |  /mgir tuto : tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : reiniciar las acciones de este personaje",
})

-- HUD : arrêt après une erreur
ns.AddLocale("esES", {
    HUD_ERROR = "Error del HUD: queda detenido hasta /reload (vuelve la barra del juego). Por favor, informa de este mensaje: %s",
})

-- Gâchettes LT / RT données à l'addon
ns.AddLocale("esES", {
    TRIGGERS_LABEL = "Gatillos LT / RT:",
    TRIGGERS_ADDON = "Modificadores del addon",
    TRIGGERS_GAME = "Capas del juego",
    TRIGGERS_ADDON_DESC = "Mantén LT o RT (o ambos) y pulsa A, B, X, Y o la cruceta: las acciones del addon, con todo lo que permite (macros escritas a mano, comandos de WoW). Sustituyen las capas LT, RT y LT + RT de la barra de mando del juego; una casilla vacía no hace nada. LB y RB no cambian.",
    TRIGGERS_GAME_DESC = "LT y RT conservan las capas de la barra de mando del juego (editables desde la pestaña Acciones).",
    TRIGGERS_COPIED = "%d acción(es) de las capas LT / RT del juego copiada(s) a las del addon.",
    IMPORT_SUMMARY_TRIGGERS = "LT / RT: modificadores del addon.",
})

-- Menu d'une case : pourquoi des choix sont grisés
ns.AddLocale("esES", {
    MENU_GAME_BAR_HINT = "Macros escritas, comandos de WoW: cede LT / RT al addon (pestaña Botones, Botones base)",
})

-- Actions de base (celles de Forever sur A/B/X/Y)
ns.AddLocale("esES", {
    MENU_GAME = "Acción básica...",
    GAME_TITLE = "Acciones básicas",
    KIND_game = "Acción básica",
    GAME_jump = "Saltar",
    GAME_cancel = "Cancelar (hechizo, objetivo)",
    GAME_search = "Buscar (clic derecho en el objetivo)",
    GAME_attack = "Ataque automático",
    GAME_interact = "Interactuar",
})

-- Modes de ciblage (comme LB / RB dans Forever)
ns.AddLocale("esES", {
    MODE_TARGET_FRIEND = "Obj. aliado",
    MODE_TARGET_ENEMY = "Obj. enemigo",
    MODE_TARGET_FRIEND_DESC = "Como LB en Forever: una pulsación breve selecciona al aliado más cercano; mantenlo y apunta con el stick derecho para elegir uno. Mantenido, también es un modificador: A, B, X, Y y la cruceta lanzan sus 8 atajos.",
    MODE_TARGET_ENEMY_DESC = "Como RB en Forever: una pulsación breve selecciona al enemigo más cercano; mantenlo y apunta con el stick derecho para elegir uno. Mantenido, también es un modificador: A, B, X, Y y la cruceta lanzan sus 8 atajos.",
    TARGET_UNAVAILABLE = "No se encuentra la selección de objetivo de Forever: %s funciona como un modificador simple.",
})

-- Onglet « Soutenir » (don PayPal)
ns.AddLocale("esES", {
    TAB_DONATE = "Apoyar",
    DONATE_TITLE = "Apoya My Gamepad Is Rich",
    DONATE_INTRO = "My Gamepad Is Rich es gratuito y lo seguirá siendo. Si te resulta útil y quieres darme las gracias, puedes hacerme una donación en PayPal, de la cantidad que quieras.",
    DONATE_SCAN = "Escanea el código QR con tu móvil",
    DONATE_LINK = "O copia el enlace (Ctrl+C) y pégalo en tu navegador:",
    DONATE_THANKS = "Las donaciones son totalmente opcionales y no desbloquean nada: todas las funciones siguen disponibles para todos. ¡Gracias por tu apoyo!",
})

-- Boutons de base (LT, RT, LB, RB)
ns.AddLocale("esES", {
    MODE_GAME = "Juego",
    MODE_GAME_DESC = "Este botón conserva su función en el juego (LT / RT: capas de la barra de mando; LB / RB: la selección de objetivo de Forever).",
    PADS_LABEL = "Botones base:",
    PADS_PICK = "%s: elegir un modo",
    IMPORT_SUMMARY_PADS = "Botones base cedidos al addon: %s",
    EMULATION_OFF = "%s ya no imita Mayús / Ctrl mientras pertenece al addon. Escribe /mgir restore antes de desactivar el addon.",
    RESTORE_DONE = "Botones base devueltos al juego y su imitación de Mayús / Ctrl restaurada.",
})

-- Plus aucun ciblage allié / ennemi configuré
ns.AddLocale("esES", {
    TARGET_MISSING_FRIEND = "Ningún botón selecciona aliados: pon LB en «Juego», o un botón en «Obj. aliado» (pestaña Botones).",
    TARGET_MISSING_ENEMY = "Ningún botón selecciona enemigos: pon RB en «Juego», o un botón en «Obj. enemigo» (pestaña Botones).",
    TARGET_MISSING_BOTH = "Ningún botón selecciona aliados ni enemigos: pon LB / RB en «Juego», o botones en «Obj. aliado» / «Obj. enemigo» (pestaña Botones).",
})

-- Onglet Boutons : mention des boutons de base
ns.AddLocale("esES", {
    PAD_HINT = "botón del mando: nada que detectar",
})

-- Case vide d'un bouton simple dans une couche : son action habituelle
ns.AddLocale("esES", {
    SIMPLE_USUAL = "Habitual",
})

-- Manettes standard (sans bouton supplémentaire), noms PlayStation
ns.AddLocale("esES", {
    TUTO_NO_EXTRA = "Este mando no tiene botones adicionales: aquí no hay nada que configurar. Puedes dar otras funciones a LT, RT, LB y RB (Botones base, en la pestaña Botones).",
    PS_CROSS = "Equis",
    PS_CIRCLE = "Círculo",
    PS_SQUARE = "Cuadrado",
    PS_TRIANGLE = "Triángulo",
})

-- Paires libres (deux modificateurs quelconques)
ns.AddLocale("esES", {
})

-- Paire avec un bouton de base resté au jeu
ns.AddLocale("esES", {
})

-- Boutons de base : mode par défaut
ns.AddLocale("esES", {
    MODE_IS_DEFAULT = "Predeterminado para este botón: funciona como en el juego.",
})

-- Tutoriel : les types de boutons, boutons de base, paires ; options
ns.AddLocale("esES", {
    MODE = "Tipo:",
    TUTO_WELCOME_TEXT = "Este addon te permite elegir qué hace cada botón de tu mando: los botones adicionales (palancas traseras, gatillos extra: GameSir, Xbox Elite, DualSense Edge, SCUF...) y los botones base LT, RT, LB y RB.\n\n|cffffd100La idea: las capas.|r Solos, A, B, X, Y y la cruceta lanzan 8 acciones. Mantén un botón (LT, RT, una palanca...) y esos mismos 8 botones lanzan otras 8 acciones: es una nueva capa. Cada botón que mantienes da una.\n\nEste tutorial dura unos dos minutos. Puedes salir en cualquier momento y volver a abrirlo con |cffffd100/mgir tuto|r.",
    TUTO_CONTROLLER_TITLE = "Tu mando",
    TUTO_CONTROLLER_TEXT = "Elige tu mando: el addon usa los nombres de sus botones adicionales y te indica el programa que los configura. ¿Un mando Xbox o PlayStation normal, sin botones extra? Elígelo también: podrás configurar LT, RT, LB y RB igualmente. ¿No está en la lista? Elige |cffffd100Otro mando|r (hasta 6 botones, que puedes renombrar).",
    TUTO_TYPES_TITLE = "Los 4 tipos de botón",
    TUTO_TYPES_TEXT = "Cada botón recibe un tipo, que indica lo que hace. Lo eliges en los pasos siguientes y en cualquier momento en la pestaña |cffffd100Botones|r (pasa el ratón sobre un tipo para volver a leer su explicación).",
    TYPE_MODIFIER_HOW = "Mantenlo y pulsa A, B, X, Y o la cruceta: una capa de 8 acciones. Solo, no hace nada.",
    TYPE_MODIFIER_FOR = "Para: los botones fáciles de mantener pulsados. Por defecto en LT y RT, como en el juego.",
    TYPE_TARGET_HOW = "Una pulsación breve selecciona al aliado (o enemigo) más cercano; mantenlo y apunta con el stick derecho para elegir otro. Mantenido con A, B, X, Y o la cruceta: 8 atajos, como un modificador.",
    TYPE_TARGET_FOR = "Para: curaciones y hechizos sobre un objetivo. Por defecto en LB (aliado) y RB (enemigo), como en el juego.",
    TYPE_SIMPLE_HOW = "Una pulsación lanza una acción. Con LT o RT mantenido, lanza otra. También tiene una casilla en cada capa de modificador.",
    TYPE_SIMPLE_FOR = "Para: un hechizo que lanzas a menudo, una poción, una montura.",
    TYPE_OFF_HOW = "El botón no hace nada: su tecla queda libre para otra cosa.",
    TYPE_OFF_FOR = "Para: los botones adicionales que no usas (los botones base no tienen este tipo).",
    TUTO_SOFTWARE_TITLE = "Hacer que los botones adicionales envíen una tecla",
    TUTO_DETECT_TITLE = "Detectar tus botones adicionales",
    TUTO_DETECT_MISSING = "¿No pasa nada al pulsar? Revisa la tecla del botón en el programa de tu mando y vuelve a intentarlo.",
    TUTO_MODES_TITLE = "El tipo de tus botones adicionales",
    TUTO_MODES_TEXT = "Elige el tipo de cada botón adicional (pasa el ratón sobre un tipo para ver lo que hace).\nConsejo: modificadores en los botones más fáciles de mantener, botones simples en los demás. |cffffd100Usar los tipos recomendados|r lo hace por ti.",
    TUTO_SUGGESTED = "Usar los tipos recomendados",
    TUTO_PADS_TITLE = "Tus botones base: LT, RT, LB, RB",
    TUTO_PADS_TEXT = "Por defecto (en verde), funcionan como en el juego: LT y RT son modificadores, LB selecciona aliados y RB enemigos. Las acciones de la barra de mando del juego se copian en sus capas. Puedes cambiarlos: por ejemplo RB como botón simple, o LB como modificador.",
    TUTO_PADS_DEFAULT = "Volver a los tipos por defecto",
    TUTO_PAIRS_TITLE = "Parejas: dos botones mantenidos a la vez",
    TUTO_PAIRS_TEXT = "Mantén dos botones a la vez (modificadores o de objetivo): otra capa más de 8 acciones. Dos botones cualesquiera pueden formar una pareja: L5 + R5, LT + RT, LB + LT... Marca las que quieras (podrás cambiarlas en la pestaña |cffffd100Botones|r). Por defecto: las parejas izquierda + derecha.",
    TUTO_ACTIONS_TITLE = "Colocar tus acciones",
    TUTO_ACTIONS_TEXT = "En la pestaña |cffffd100Acciones|r: a la izquierda, todas tus capas (Solo, LT, RT, tus modificadores y parejas); a la derecha, la capa elegida, dispuesta como el mando.\n\n- Arrastra un hechizo de tu libro de hechizos, un objeto de tus bolsas, una macro, una montura o un juguete a una casilla.\n- O haz clic en una casilla: elegir un hechizo o un objeto, escribir una macro, elegir un comando de WoW (Correr automáticamente...) o una acción básica (Saltar, Interactuar...). Clic derecho: vaciar.\n- La fila bajo la cruceta: las casillas de tus botones simples en esa capa.\n\nTambién puedes hacer clic en una miniatura de capa del HUD para editarla allí mismo.\n\nLas acciones se guardan por personaje; los tipos y las teclas en el perfil, para toda la cuenta. Todo funciona en combate; solo los cambios hechos en combate esperan a que termine.",
    TUTO_HUD_TEXT = "El addon sustituye la barra de mando del juego por su propio HUD:\n\n- |cffffd100En grande|r: la capa que usas, la cruceta a la izquierda y A/B/X/Y a la derecha. Mantén un botón y cambia.\n- |cffffd100Las miniaturas|r: todas tus capas, con las casillas de tus botones simples en el centro; la que mantienes se ilumina. Haz clic en una para editarla.\n- |cffffd100En el centro|r: tus botones simples, con la acción que lanzarán.\n\nAjustes (tamaño, posición, miniaturas): pestaña |cffffd100HUD|r. |cffffd100/mgir hud off|r: volver a la barra del juego.",
    TUTO_DONE_TEXT = "Abre la configuración para colocar tus primeras acciones.\n\n|cffffd100/mgir|r: abrir la configuración\n|cffffd100/mgir test|r: prueba del mando, para ver lo que recibe WoW\n|cffffd100/mgir tuto|r: este tutorial\n|cffffd100/mgir reset|r: vaciar las acciones de este personaje\n|cffffd100/mgir restore|r: devolver LT, RT, LB y RB al juego (antes de desactivar el addon)",
    SETTINGS_DESC = "Elige qué hace cada botón de tu mando: botones adicionales (palancas traseras, gatillos extra) y botones base (LT, RT, LB, RB). Comando: /mgir",
    BUTTONS_INTRO = "Elige el tipo de cada botón: pasa el ratón sobre un tipo para ver lo que hace. En verde: el tipo por defecto de los botones base, que funciona como el juego.",
    BUTTONS_TYPES_HELP = "Los tipos de botón",
    PAIRS_HINT = "Marca las parejas que quieras usar: mantener los dos botones a la vez da 8 acciones más. Dos modificadores o botones de objetivo cualesquiera pueden formar una pareja (L5 + LT, LB + RT...).",
    PAIRS_NONE = "Pon al menos dos botones en Modificador, Obj. aliado u Obj. enemigo para formar parejas.",
    PAIR_WAITS = "%s está en Juego: ponlo en Modificador, Obj. aliado u Obj. enemigo (arriba)",
})

-- Tutoriel, paires : appuyer sur les boutons pour les trouver
ns.AddLocale("esES", {
    TUTO_PAIRS_PRESS = "Pulsa un botón de tu mando: sus parejas se iluminan en verde. Pulsa dos botones a la vez: se ilumina su pareja.",
})

-- LB + LT et RB + RT : l'action de classe de Forever
ns.AddLocale("esES", {
    PAIR_CLASS_WARN = "también activa la acción de clase de Forever",
    PAIR_CLASS_WARN_LONG = "Atención: %s también activa la acción de clase de Forever (a menudo una rueda de hechizos que toma el control de A, B, X e Y mientras está abierta; B la cierra). El addon no puede impedirlo: mejor elige otra pareja.",
    PAIR_CLASS_NOTE = "%s y %s también activan la acción de clase de Forever (a menudo una rueda de hechizos que toma el control de A, B, X e Y). El addon no puede impedirlo: mejor elige otras parejas.",
})

-- Forever resté sur sa barre LT / RT
ns.AddLocale("esES", {
    FOREVER_STUCK = "Forever se quedó en su barra %s (se perdió el soltar de un botón). Pulsa %s una vez para volver a «Solo».",
})
