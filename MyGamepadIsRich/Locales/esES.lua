-- Español (España y México)
local _, ns = ...

ns.AddLocale("esES", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "Botones",
    TAB_TEST = "Prueba del mando",
    TAB_HELP = "Ayuda",

    EXTRA = "Botón",
    NAME = "Nombre:",
    KEY = "Tecla:",
    KEY_NONE = "sin asignar",
    DETECT = "Detectar",
    CLEAR = "Borrar",
    MODE = "Modo:",
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
    LEARN_MODKEY = "Atención: %s es una tecla Mayús / Ctrl / Alt; en GameSir Nexus, mejor usa una tecla como F9-F12.",
    LEARN_BOUND = "Nota: %s estaba asignada a «%s» en WoW; mientras este addon la use, el addon tiene prioridad.",

    TEST_INTRO = "Pulsa cualquier botón: lo que recibe WoW se ilumina. Si L5 / R5 / L4 / R4 no muestran nada, asígnales teclas en GameSir Nexus (ver Ayuda).",
    TEST_STANDARD = "Botones estándar",
    TEST_EXTRA = "Botones adicionales",
    TEST_LOG = "Últimas entradas",
    TEST_GAME = "juego",
    TEST_UNKNOWN = "sin asignar",

    IF_WARNING = "Improved Forever está cargado: si también usa una de estas teclas, gana la última asignación aplicada.",
    OPEN_CONFIG = "Abrir la configuración",
    SETTINGS_DESC = "Configura los botones adicionales de tu GameSir G7 Pro (L5/R5, L4/R4). Comando: /mgir",
    LOADED = "cargado. Escribe /mgir para configurar tus botones adicionales.",
    SLASH_HELP = "/mgir : abrir  |  /mgir test : prueba del mando  |  /mgir tuto : tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : reiniciar las acciones de este personaje",
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
    TUTO_SUGGESTED = "Usar los modos recomendados",
    HELP_REPLAY = "Ver el tutorial de nuevo",

    TUTO_WELCOME_TITLE = "Bienvenido a My Gamepad Is Rich",
    TUTO_WELCOME_TEXT = "Este addon lleva a WoW los botones adicionales de tu GameSir G7 Pro:\n\n"
        .. "|cffffd100L5 / R5|r: los terceros gatillos\n"
        .. "|cffffd100L4 / R4|r: las paletas traseras\n\n"
        .. "Cada uno puede ser un modificador que se mantiene (8 combinaciones nuevas con A, B, X, Y y la cruceta) "
        .. "o un botón simple con sus propias capas LT y RT.\n\n"
        .. "Este tutorial dura unos dos minutos. Puedes salir cuando quieras y volver a abrirlo con |cffffd100/mgir tuto|r.",

    TUTO_NEXUS_TITLE = "Paso 1: GameSir Nexus",
    TUTO_NEXUS_TEXT = "Windows ve el G7 Pro como un mando de Xbox 360. Ese modo solo transmite los botones estándar, "
        .. "así que WoW nunca recibe L5, R5, L4 ni R4. La solución: hacer que envíen una tecla del teclado.\n\n"
        .. "1. Conecta el mando y abre |cffffd100GameSir Nexus|r (Microsoft Store).\n"
        .. "2. Abre la página de asignación de botones.\n"
        .. "3. Asigna a L5, R5, L4 y R4 una tecla que no uses en WoW. Buenas opciones: |cffffd100F9, F10, F11, F12|r "
        .. "o el teclado numérico (con Bloq Num activado).\n"
        .. "4. Evita Mayús, Ctrl y Alt: cambiarían tus otras asignaciones.\n"
        .. "5. Guarda el perfil en el mando.\n\n"
        .. "¿Listo? Pasa al siguiente paso.",

    TUTO_DETECT_TITLE = "Paso 2: Detectar tus botones",
    TUTO_DETECT_TEXT = "Para cada botón, haz clic en |cffffd100Detectar|r y pulsa ese botón en tu mando. "
        .. "La tecla que envía aparece al lado.",
    TUTO_DETECT_ALL = "|cff40ff40Los cuatro botones están detectados.|r",
    TUTO_DETECT_MISSING = "¿No pasa nada al pulsar? Revisa la tecla del botón en GameSir Nexus y vuelve a intentarlo.",

    TUTO_MODES_TITLE = "Paso 3: Elegir un modo",
    TUTO_MODES_TEXT = "|cffffd100Modificador|r: mantén el botón y pulsa A, B, X, Y o la cruceta. 8 acciones por botón, como LT y RT.\n"
        .. "|cffffd100Botón simple|r: una acción, más otra con LT mantenido y otra con RT mantenido.\n"
        .. "|cffffd100Desactivado|r: la tecla queda libre.\n\n"
        .. "Recomendado: modificadores en L5 y R5 (fáciles de mantener), botones simples en L4 y R4.",

    TUTO_ACTIONS_TITLE = "Paso 4: Colocar tus acciones",
    TUTO_ACTIONS_TEXT = "En la ventana de configuración, cada botón muestra sus casillas.\n\n"
        .. "- Arrastra un hechizo del libro de hechizos, un objeto de tus bolsas, una macro, una montura o un juguete a una casilla.\n"
        .. "- O haz clic derecho en una casilla: elige un hechizo u objeto de la bolsa, escribe una macro, elige un comando de WoW (como Correr automáticamente) o vacíala.\n\n"
        .. "Las acciones se guardan por personaje; las teclas y los modos, para toda la cuenta. "
        .. "Todo funciona en combate; solo los cambios hechos en combate esperan a que termine.",

    TUTO_DONE_TITLE = "Todo listo",
    TUTO_DONE_TEXT = "Abre la configuración para colocar tus primeras acciones.\n\n"
        .. "|cffffd100/mgir|r: abrir la configuración\n"
        .. "|cffffd100/mgir test|r: prueba del mando, para ver lo que recibe WoW\n"
        .. "|cffffd100/mgir tuto|r: este tutorial\n"
        .. "|cffffd100/mgir reset|r: vaciar las acciones de este personaje",
})

-- HUD
ns.AddLocale("esES", {
    HUD_UNLOCKED = "HUD desbloqueado: arrástralo con el ratón. Escribe /mgir hud otra vez para bloquearlo.",
    HUD_LOCKED = "HUD bloqueado.",
    HUD_ON = "HUD visible: sustituye la barra de mando del juego.",
    HUD_OFF = "HUD oculto: vuelve la barra de mando del juego. Escribe /mgir hud on para mostrarlo de nuevo.",
    HUD_SCALE = "Tamaño del HUD: %s",
    TUTO_HUD_TITLE = "Tu HUD de mando",
    TUTO_HUD_TEXT = "El addon sustituye la barra de mando del juego por su propio HUD, en la parte inferior de la pantalla:\n\n"
        .. "- |cffffd100En grande|r: la capa que usas, la cruceta a la izquierda y A/B/X/Y a la derecha. Mantén LT, RT, L5 o R5 y cambia.\n"
        .. "- |cffffd100En la franja|r (abajo, o arriba con /mgir hud strip): todas las capas en miniatura (Solo, LT, RT, LT+RT, L5, R5); la que mantienes se ilumina.\n"
        .. "- |cffffd100En el centro|r: L4 y R4, con la acción que saldrá según el gatillo que mantengas.\n\n"
        .. "Se atenúa fuera de combate mientras no mantienes nada.\n"
        .. "|cffffd100/mgir hud|r: moverlo  -  |cffffd100/mgir hud scale 1.2|r: tamaño  -  |cffffd100/mgir hud off|r: volver a la barra del juego",
})

-- HUD : attribution rapide
ns.AddLocale("esES", {
    HUD_COMBAT = "No se pueden cambiar las acciones en combate.",
    HUD_GAME_SLOT = "Este botón conserva la acción del juego (saltar, interactuar...).",
    HUD_KIND = "La barra del juego solo admite hechizos, objetos, monturas y macros de la lista de macros.",
    HUD_EDITING = "Editando esta capa: haz clic en una casilla para asignarla, clic derecho para vaciarla. Vuelve a hacer clic en la miniatura para volver.",
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

-- Paires de modificateurs (L5 + R5, L4 + R4)
ns.AddLocale("esES", {
    PAIR_READY = "Pareja · mantener ambos",
    PAIR_NOT_READY = "Pareja · no disponible",
    PAIR_DESC = "Mantén %s y %s a la vez y pulsa A, B, X, Y o la cruceta: 8 combinaciones más.",
    PAIR_NEEDS = "Para usar esta pareja, %s y %s deben estar ambos en modo Modificador, con una tecla.",
    TUTO_PAIRS_TEXT = "|cffffd100Parejas|r: si L5 y R5 son ambos modificadores, mantenerlos a la vez da 8 combinaciones más. Lo mismo para L4 + R4.",
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
    LAYER_DESC_BASE = "A, B, X, Y y la cruceta sin mantener nada. A, B, X e Y conservan las acciones del juego (saltar, interactuar...).",
    LAYER_DESC_HOLD = "Mantén %s y pulsa A, B, X, Y o la cruceta.",
    BUTTONS_INTRO = "Tus botones adicionales: la tecla que envía GameSir Nexus y lo que hace cada uno. Pasa el ratón por un modo para ver qué hace.",
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
})
