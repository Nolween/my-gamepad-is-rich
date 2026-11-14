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
    MODE_SIMPLE_DESC = "Una acción, más otra con LT mantenido y otra con RT mantenido. Una capa vacía no hace nada.",
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
    MENU_ICON = "Cambiar icono...",
    ICON_TITLE = "Elegir un icono",
    ICON_HINT = "Busca por hechizo, objeto o comando de WoW, o escribe el nombre de archivo de un icono (como en Wowhead: inv_misc_map_01).",
    ICON_DEFAULT = "Icono por defecto",
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
    HUD_UNLOCKED = "HUD desbloqueado: arrástralo con el ratón (las miniaturas separadas se mueven aparte). Para bloquearlo: el candado del HUD, o /mgir hud otra vez.",
    HUD_LOCKED = "HUD bloqueado.",
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
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("esES", {
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
    TAB_ACTIONS = "Capas",
    TAB_HUD = "HUD",
    SECTION_PAD = "Barra del mando",
    SECTION_MODS = "Modificadores",
    SECTION_MODS_EMPTY = "Ninguno aún: pon un botón en Modificador en la pestaña Botones.",
    SECTION_SIMPLE = "Botones simples",
    SECTION_SIMPLE_EMPTY = "Ninguno aún: pon un botón en Botón simple en la pestaña Botones.",
    LAYER_DESC_BASE = "A, B, X, Y y la cruceta sin mantener nada. Todo cabe aquí: lo que la barra del juego no puede contener (macro escrita a mano, comando de WoW) lo toma el addon. A, B, X e Y conservan las acciones del juego (saltar, interactuar...) hasta que pongas las tuyas.",
    LAYER_DESC_HOLD = "Mantén %s y pulsa A, B, X, Y o la cruceta.",
    PAIRS_TITLE = "Parejas (dos modificadores mantenidos a la vez)",
    HUD_INTRO = "El HUD sustituye la barra de mando del juego: en cuadrícula (una fila por capa) o como el mando (la capa en uso en grande y todas las capas en miniatura).",
    HUD_SIZE = "Tamaño:",
    HUD_MOVE = "Desbloquear el HUD",
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
    HUD_ORDER = "Orden de las capas:",
    HUD_ORDER_RESET = "Orden por defecto",
    HUD_ORDER_HINT = "Flechas: mover una capa. En el HUD también puedes arrastrar una miniatura (o el nombre de una fila de la cuadrícula) sobre otra.",
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
    TRIGGERS_GAME_DESC = "LT y RT conservan las capas de la barra de mando del juego (editables desde la pestaña Capas).",
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
    EMULATION_OFF = "%s ya no imita Mayús / Ctrl mientras pertenece al addon. Se restablece sola al cerrar sesión.",
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
    TUTO_ACTIONS_TEXT = "En la pestaña |cffffd100Capas|r: a la izquierda, todas tus capas (Solo, LT, RT, tus modificadores y parejas); a la derecha, la capa elegida, dispuesta como el mando.\n\n- Arrastra un hechizo de tu libro de hechizos, un objeto de tus bolsas, una macro, una montura o un juguete a una casilla.\n- O haz clic en una casilla: elegir un hechizo o un objeto, escribir una macro, elegir un comando de WoW (Correr automáticamente...) o una acción básica (Saltar, Interactuar...). Clic derecho: vaciar.\n- La fila bajo la cruceta: las casillas de tus botones simples en esa capa.\n\nTambién puedes hacer clic en una miniatura de capa del HUD para editarla allí mismo.\n\nLas acciones se guardan por personaje; los tipos y las teclas en el perfil, para toda la cuenta. Todo funciona en combate; solo los cambios hechos en combate esperan a que termine.\n\n|cffffd100Práctico|r:\n- El campo de arriba de la lista busca una acción en todas tus capas.\n- |cffffd100Consumible inteligente|r (menú de una casilla): tu mejor poción, comida, bebida o venda, actualizada sola.\n- Un hechizo gris y rojo: este personaje no lo conoce. |cffffd100Plantillas y especializaciones...|r puede quitarlos.\n- Un nuevo rango aprendido con el instructor de clase: el addon propone ponerlo en lugar del antiguo, en todas partes.",
    TUTO_HUD_TEXT = "El addon sustituye la barra de mando del juego por su propio HUD. Elige su disposición abajo: el HUD cambia al instante y podrás cambiarla cuando quieras (pestaña |cffffd100HUD|r o el botoncito del HUD).\n\nAl pasar el ratón sobre el HUD aparecen botoncitos: el |cffffd100candado|r lo desbloquea para moverlo con el ratón (y lo vuelve a bloquear), otro cambia la disposición y el |cffffd100engranaje|r abre la pestaña HUD para los ajustes finos (tamaño, miniaturas...).",
    TUTO_DONE_TEXT = "Abre la configuración para colocar tus primeras acciones.\n\n|cffffd100/mgir|r: abrir la configuración\n|cffffd100/mgir test|r: prueba del mando, para ver lo que recibe WoW\n|cffffd100/mgir tuto|r: este tutorial\n|cffffd100/mgir reset|r: vaciar las acciones de este personaje\n|cffffd100/mgir restore|r: devolver LT, RT, LB y RB al juego\n|cffffd100/mgir rangs|r: poner los nuevos rangos de tus hechizos en lugar de los antiguos",
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
    HUD_STUCK = "%s bloqueado: pulsa %s una vez",
    HUD_GRID_RECALL_DETACH = "Separado de la cuadrícula",
    TIP_HUD_GRID_RECALL_DETACH = "El recordatorio sale de la cuadrícula: puedes colocarlo donde quieras (candado del HUD y luego arrastrar).",
    HUD_GRID_RECALL = "Recordatorio de la capa en uso en grande arriba",
    TIP_HUD_GRID_RECALL = "Encima de la cuadrícula y centrada, la capa que usas en grande, cada casilla con su botón. Su fila en la cuadrícula se queda entonces pequeña (borde dorado).",
    HUD_STYLE_LABEL = "Vista del HUD:",
    HUD_STYLE_GRID = "Cuadrícula",
    HUD_STYLE_PAD = "Mando",
    TIP_HUD_STYLE_GRID = "Una fila por capa, los botones siempre en el mismo orden: la cruceta, luego X, Y, B, A (izquierda, arriba, derecha, abajo) y luego los botones simples. La capa en uso en grande arriba y dorada en la cuadrícula.",
    TIP_HUD_STYLE_PAD = "Como el mando: la capa en uso en grande (cruceta a la izquierda, A/B/X/Y a la derecha, botones simples en el centro) y todas las capas en miniatura.",
    HUD_SECTION_GRID = "Cuadrícula de capas",
    HUD_GRID_SIZE = "Tamaño de la cuadrícula:",
    HUD_GRID_COLS = "Columnas de capas:",
    TIP_HUD_GRID_SIZE = "El tamaño de la cuadrícula. «Tamaño» (más abajo) agranda todo el HUD.",
    TIP_HUD_GRID_COLS = "En cuántas columnas repartir las filas de capas: más columnas, una cuadrícula más ancha y más baja.",
    HUD_TOOL_TO_GRID = "Pasar el HUD a cuadrícula",
    HUD_TOOL_TO_PAD = "Pasar el HUD a disposición de mando",
    HUD_ROW_HINT = "Clic: agrandar esta capa para editarla",
    HUD_ROW_DRAG = "Arrastrar: moverla (sobre otra fila)",
    TUTO_HUD_GRID_NAME = "Cuadrícula (recomendada)",
    TUTO_HUD_GRID_DESC = "Una fila por capa, los botones siempre en el mismo orden, con su color en la cabecera de cada columna: la cruceta, luego X, Y, B, A (izquierda, arriba, derecha, abajo: el mismo sitio para los dos pulgares) y luego tus botones simples. Arriba, el recordatorio muestra en grande la capa que usas; su fila se vuelve dorada. Clic en una casilla para editarla, en el nombre de una fila para agrandarla; arrastra ese nombre para cambiar el orden. Pestaña HUD: tamaño, número de columnas, recordatorio (que se puede separar de la cuadrícula y colocar donde quieras).",
    TUTO_HUD_PAD_NAME = "Mando",
    TUTO_HUD_PAD_DESC = "Como el mando: la capa que usas en grande, la cruceta a la izquierda, A/B/X/Y a la derecha, tus botones simples en el centro con la acción que se lanzará. Todas tus capas en miniatura debajo: haz clic en una miniatura para editarla.",
    WHATSNEW_1_4_0 = "• |cffffd100HUD en cuadrícula|r: una nueva disposición, una fila por capa, los botones siempre en el mismo orden, con su color en la cabecera de cada columna: la cruceta, luego X, Y, B, A (izquierda, arriba, derecha, abajo) y luego los botones simples. Arriba, el recordatorio muestra en grande la capa en uso; en la cuadrícula se vuelve dorada. Cada casilla se edita directamente; clic en el nombre de una fila para agrandarla, arrastrar para cambiar el orden.\n• Pestaña HUD: tamaño de la cuadrícula, número de columnas (1 a 3), recordatorio visible o no, y separado de la cuadrícula para colocarlo donde quieras. Tu HUD conserva su disposición actual: pasa a la cuadrícula en la pestaña HUD («Vista del HUD») o con el botoncito del HUD.\n• |cffffd100Capa bloqueada en rojo|r: cuando la barra LT / RT del juego se queda bloqueada, el HUD muestra esa capa en rojo con el botón que hay que pulsar para desbloquearla.",
})

-- 1.1.0 : spés, état des actions sur le HUD, profils, remplissage rapide, rapport
ns.AddLocale("esES", {
    SPEC_NUMBER = "Especialización %d",
    SPEC_SWITCHED = "Acciones de la especialización «%s».",
    SPEC_NEW = "Nueva especialización «%s»: empieza con una copia de las acciones de la anterior.",
    PROFILE_PER_CHAR = "Recordar el perfil de cada personaje",
    PROFILE_PER_CHAR_DESC = "Al conectarse, cada personaje vuelve al último perfil que usó. Sin esta opción, todos toman el último perfil usado en la cuenta.",
    REPORT_BUTTON = "Copiar un informe",
    REPORT_TITLE = "Informe del mando",
    REPORT_HINT = "Pulsa primero cada botón en la prueba del mando, luego copia este texto (Ctrl+C) y envíalo al autor del addon, con lo que funciona y lo que no. Ayuda a confirmar los ajustes de otros mandos. No incluye ningún nombre de personaje ni de reino.",
    WHATSNEW_TITLE = "Novedades de My Gamepad Is Rich",
    QUICKFILL_BUTTON = "Rellenar casillas vacías",
    QUICKFILL_DESC = "Coloca en las casillas vacías de esta capa la piedra de hogar, los abalorios usables equipados y los consumibles de las bolsas (pociones, comida, vendas, elixires...), salvo los que ya están. Clic derecho en una casilla para vaciarla.",
    QUICKFILL_DONE = "%d casilla(s) rellenada(s).",
    QUICKFILL_NONE = "Nada que colocar: ningún objeto usable en las bolsas que no esté ya en esta capa.",
})

-- 1.1.0 : modèles de classe, copie de couches, verrou, annulation, véhicules
ns.AddLocale("esES", {
    SLASH_HELP = "/mgir : abrir  |  /mgir profile <nombre> : cambiar de perfil  |  /mgir test : prueba del mando  |  /mgir tuto : tutorial  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : reiniciar las acciones de este personaje  |  /mgir undo : deshacer el último cambio de acciones  |  /mgir rangs: reemplazar los rangos inferiores de hechizos",
    LEARN_PAD_REFUSED = "%s es un botón básico del mando: el addon lo combina o lo configura él mismo. Pulsa el botón adicional (la tecla que envía su software).",
    RESET_CONFIRM = "¿Vaciar todas las acciones de este personaje en el perfil actual?",
    RESET_CONFIRM_SPEC = "¿Vaciar todas las acciones de este personaje para la especialización «%s», en el perfil actual?",
    UNDO_HINT = "/mgir undo para volver atrás.",
    UNDO_DONE = "Acciones restauradas como antes del último cambio.",
    UNDO_NONE = "Nada que deshacer para esta especialización.",
    ACTION_COUNT = "%d acción(es)",
    LAYER_COPY_BUTTON = "Copiar / intercambiar…",
    LAYER_COPY_DESC = "Copia las acciones de esta capa a otra capa, o intercambia las acciones de las dos capas (las 8 casillas y las de los botones simples).",
    LAYER_COPY_TITLE = "Capa %s",
    LAYER_COPY_TO = "Copiar a",
    LAYER_SWAP_WITH = "Intercambiar con",
    LAYER_COPY_NONE = "No hay otra capa de combinaciones: primero convierte otro botón en modificador.",
    LAYER_COPY_CONFIRM = "¿Reemplazar las acciones de la capa %s (%d) por las de %s?",
    LAYER_COPIED = "%s copiada a %s.",
    LAYER_SWAPPED = "%s y %s intercambiadas.",
    TPL_BUTTON = "Plantillas y especializaciones…",
    TPL_DESC = "Plantillas de clase: guarda las acciones de esta especialización para toda la cuenta y cárgalas luego en otro personaje de la misma clase. También puedes copiar las acciones de otra especialización. Las acciones que se quedan en la barra del juego no se incluyen.",
    TPL_TITLE = "Plantillas y especializaciones",
    TPL_SECTION_SAVE = "Guardar",
    TPL_SAVE = "Guardar estas acciones como plantilla…",
    TPL_SECTION_LOAD = "Cargar una plantilla (%s)",
    TPL_SECTION_SPEC = "Copiar de una especialización",
    TPL_SECTION_DELETE = "Eliminar una plantilla",
    TPL_SAVE_PROMPT = "Nombre de la plantilla (para todos los personajes %s de la cuenta):",
    TPL_SAVED = "Plantilla «%s» guardada para %s.",
    TPL_REPLACE_CONFIRM = "¿Reemplazar la plantilla «%s»?",
    TPL_LOAD_CONFIRM = "¿Cargar la plantilla «%s»? Reemplaza las acciones de %s.",
    TPL_LOADED = "Plantilla «%s» cargada.",
    TPL_DELETE_CONFIRM = "¿Eliminar la plantilla «%s» para todos los personajes de esta clase?",
    TPL_DELETED = "Plantilla «%s» eliminada.",
    SPEC_COPY_CONFIRM = "¿Copiar las acciones de «%s»? Reemplazan las acciones de %s.",
    SPEC_COPIED = "Acciones de «%s» copiadas.",
    LATCH = "Fijable",
    LATCH_DESC = "Una pulsación activa la capa de este modificador y la siguiente la desactiva: no hace falta mantenerlo. Otro modificador mantenido toma el control mientras se mantiene. Cualquier cambio de ajustes lo libera. Solo botones adicionales (no LT, RT, LB, RB).",
})

-- 1.1.0 : notes de version (tout ce qui a changé depuis la 1.0.0)
ns.AddLocale("esES", {
    WHATSNEW_1_1_5 = "• Objetivo aliado / enemigo: en combate, el botón ya no queda pulsado tras soltarlo (el HUD se quedaba en su capa y el stick seguía apuntando). Una pulsación breve sigue pasando al siguiente objetivo y una larga mantiene el objetivo elegido.",
    WHATSNEW_1_1_4 = "• Objetivo aliado / enemigo: cada pulsación breve pasa al siguiente objetivo, aunque ya tengas uno, incluso donde el juego no da la hora al addon. Una pulsación larga mantiene el objetivo elegido con el stick.\n• /mgir etat indica cómo se reconoce una pulsación breve.",
    WHATSNEW_1_1_3 = "• Objetivo aliado / enemigo: el objetivo elegido con el stick se mantiene al soltar el botón. Solo una pulsación breve selecciona el más cercano.",
    WHATSNEW_1_1_2 = "• Un comando de WoW o una macro escrita a mano puede usar el icono que elijas: clic en la casilla, «Cambiar icono...». La búsqueda encuentra los iconos de tus hechizos, tus objetos y los comandos de WoW, o un icono por su nombre de archivo (como en Wowhead: inv_misc_map_01).\n• Los comandos habituales tienen su propio icono en lugar de la llave: mapa del mundo, bolsas, libro de hechizos, registro de misiones, personaje, logros, buscador de grupos, colecciones.",
    WHATSNEW_1_1_1 = "• Botón simple: una capa vacía (LT, RT o un modificador) ya no hace nada y queda vacía en el HUD, en lugar de usar la acción «Solo». Única excepción: un comando de WoW puesto en «Solo».\n• La lista de hechizos incluye ahora los hechizos de profesión: Buscar hierbas, Buscar minerales, Pesca, Cocina, Arqueología…",
    WHATSNEW_1_1_0 = "• HUD: las acciones del addon se ven como en las barras del juego. Rojas fuera de alcance, azules sin recurso suficiente, grises si no se pueden usar, borde dorado durante un proc, cargas restantes, iluminadas mientras están activas (ataque automático, forma...).\n• HUD: el orden de las miniaturas de las capas se puede elegir (flechas de la pestaña HUD, o arrastrar una miniatura sobre otra).\n• Cada especialización tiene sus propias acciones. Una especialización nueva empieza con una copia de las acciones de la anterior.\n• Pestaña Acciones: «Rellenar casillas vacías» coloca la piedra de hogar, los abalorios y los consumibles de las bolsas en una capa de modificador, y «Copiar / intercambiar…» copia una capa de combinaciones a otra, o intercambia dos capas.\n• Plantillas de clase: guarda tus acciones para toda la cuenta y cárgalas en otro personaje de la misma clase («Plantillas y especializaciones…» bajo la lista de capas). También puedes copiar las acciones de otra especialización.\n• Modificador fijable (pestaña Botones): una pulsación activa la capa, la siguiente la desactiva.\n• /mgir reset pide confirmación, y /mgir undo vuelve atrás tras un reinicio, una plantilla o una copia de especialización o de capa.\n• Perfiles: opción «Recordar el perfil de cada personaje».\n• Capas bloqueadas: un botón básico dado al addon se queda con quien recibió la pulsación hasta que se suelta, y Forever ya no se queda bloqueado en su barra RT (o LT), por ejemplo tras un hechizo lanzado con RT + A como un sello de paladín.\n• Vehículos, barras de reemplazo y duelos de mascotas: el addon se aparta y los botones del juego funcionan, también en combate.\n• Ya no hace falta /mgir restore antes de desactivar el addon: en cada desconexión, LT y LB recuperan su imitación de Mayús / Ctrl, y el addon la vuelve a quitar al conectarse.\n• Detectar rechaza A, B, X, Y, la cruceta y LT, RT, LB, RB (pulsados por error, se convertirían en la tecla de un botón adicional).\n• Pestaña Prueba del mando: «Copiar un informe» (con el registro reciente de las capas), para enviarlo y ayudar a confirmar otros mandos. /mgir etat muestra el estado de las capas.\n• /mgir news: volver a ver esta ventana.",
})

-- Marqueurs de raid (actions de base)
ns.AddLocale("esES", {
    GAME_markquick = "Marcado rápido (siguiente marca en cada pulsación)",
    GAME_mark = "Marcar: %s",
    GAME_markclear = "Quitar la marca",
})

-- Se cibler (action de base)
ns.AddLocale("esES", {
    GAME_targetself = "Seleccionarte a ti mismo",
})

-- Nouveautés de la 1.1.6
ns.AddLocale("esES", {
    WHATSNEW_1_1_6 = "• Marcas de banda en las acciones básicas: «Marcado rápido» pone la siguiente marca en tu objetivo en cada pulsación (calavera, cruz, cuadrado, luna, triángulo, diamante, círculo, estrella), cada una de las 8 marcas y «Quitar la marca».\n• «Seleccionarte a ti mismo» en las acciones básicas.\n• La descripción de un hechizo muestra su rango.\n• Objetivo aliado / enemigo: cada pulsación breve pasa ahora al siguiente objetivo, también en Forever, y apuntar con el stick derecho responde al instante. El objetivo apuntado se queda si el stick sigue inclinado al soltar el botón, o tras una pulsación mantenida.",
})

-- Nouveaux rangs (maître de classe)
ns.AddLocale("esES", {
    UPRANK_ASK = "Nuevo rango aprendido: %s.\n\n¿Reemplazar el rango inferior en tus acciones?\n(%d casilla(s) del addon, %d casilla(s) de las barras del juego)",
    UPRANK_REPLACE = "Reemplazar",
    UPRANK_KEEP = "Conservar",
    UPRANK_DONE = "Nuevo rango puesto: %d casilla(s) del addon, %d casilla(s) de las barras del juego.",
})

-- Confort : nouveaux rangs sans demander
ns.AddLocale("esES", {
    COMFORT_TITLE = "Comodidad",
    UPRANK_AUTO = "Reemplazar los nuevos rangos de hechizos sin preguntar (rangos inferiores en las acciones del addon y en las barras del juego)",
    UPRANK_NONE = "Ningún rango inferior que reemplazar.",
})

-- Actions de base : cible, focus, sacs, montures
ns.AddLocale("esES", {
    GAME_targetlast = "Objetivo anterior",
    GAME_assist = "Asistir al objetivo",
    GAME_focus = "Poner como foco",
    GAME_targetfocus = "Seleccionar el foco",
    GAME_follow = "Seguir al objetivo",
    GAME_openbags = "Abrir las bolsas",
    GAME_dismount = "Desmontar",
    GAME_randommount = "Montura favorita al azar",
})

-- Sorts inconnus
ns.AddLocale("esES", {
    SPELL_UNKNOWN = "Este personaje no conoce este hechizo (talentos, otra especialización, plantilla de otro personaje): esta casilla no hace nada.",
    UNKNOWN_SECTION = "Hechizos desconocidos",
    UNKNOWN_REMOVE = "Quitar los hechizos desconocidos",
    UNKNOWN_CONFIRM = "¿Quitar de las acciones de %2$s los %1$d hechizo(s) que este personaje no conoce?",
    UNKNOWN_REMOVED = "%d hechizo(s) desconocido(s) quitado(s).",
})

-- Recherche d'une action (onglet Actions)
ns.AddLocale("esES", {
    SEARCH_HINT = "Buscar una acción",
    SEARCH_DESC = "Escribe parte de un nombre (hechizo, objeto, macro...): las capas que lo tienen muestran cuántas casillas, y esas casillas tienen un borde dorado.",
})

-- Consommables intelligents
ns.AddLocale("esES", {
    MENU_BEST = "Consumible inteligente...",
    BEST_TITLE = "Consumibles inteligentes",
    KIND_best = "Consumible inteligente",
    BEST_heal = "Mejor poción de sanación",
    BEST_mana = "Mejor poción de maná",
    BEST_food = "Mejor comida",
    BEST_drink = "Mejor bebida",
    BEST_bandage = "Mejor venda",
    BEST_NONE = "Ninguno en tus bolsas",
    BEST_DESC = "Usa el mejor objeto de este tipo de tus bolsas; cuando se acaba una pila, el siguiente (también en combate). La lista sigue tus bolsas fuera de combate.",
})

-- Vibrations
ns.AddLocale("esES", {
    VIBRATION_OPTION = "Vibración del mando (modificador bloqueable activado / desactivado, pulsación larga reconocida, nuevo rango puesto)",
})

-- Bouton simple : sa case dans chaque couche de modificateur
ns.AddLocale("esES", {
    SIMPLE_MOD_ROW = "Con un modificador mantenido (vacío: no hace nada)",
})

-- HUD : couches séparées, en colonne
ns.AddLocale("esES", {
    HUD_LAYERS_LABEL = "Capas:",
    HUD_DETACH = "Separadas del HUD",
    HUD_VERTICAL = "En columna",
    HUD_STRIP_COLS = "Columnas de miniaturas:",
    HUD_TOOL_VERTICAL = "Capas en columna",
    HUD_TOOL_HORIZONTAL = "Capas en fila",
})

-- HUD : cadenas (verrouiller / déverrouiller)
ns.AddLocale("esES", {
    HUD_TOOL_UNLOCK = "Desbloquear: mover el HUD con el ratón",
    HUD_TOOL_LOCK = "Bloquear el HUD (arrástralo antes donde quieras)",
    HUD_TOOL_LOCK_DETACHED = "Bloquear el HUD (arrastra antes el HUD y las capas, cada uno a su sitio)",
    HUD_UNLOCKED_HINT = "Desbloqueado: arrastra con el ratón (las capas separadas se mueven aparte). Haz clic en el candado para bloquear.",
})

-- HUD : bouton vers l'onglet HUD
ns.AddLocale("esES", {
    HUD_TOOL_SETTINGS = "Ajustes del HUD (pestaña HUD): disposición, tamaño, miniaturas...",
})

-- HUD : miniatures des couches cachées
ns.AddLocale("esES", {
    HUD_HIDE_STRIP = "Ocultas",
})

-- Onglets réorganisés : Options, sections, Aide en sections, info-bulles
ns.AddLocale("esES", {
    TAB_OPTIONS = "Opciones",
    ACTIONS_INTRO = "Lo que lanza cada botón. Elige una capa a la izquierda y pon tus acciones en sus casillas a la derecha.",
    OPTIONS_INTRO = "Los ajustes generales del addon: lo que no es ni un botón, ni una capa, ni la visualización del HUD.",
    OPTIONS_SECTION_UI = "Interfaz",
    HUD_SECTION_STRIP = "Miniaturas de las capas",
    HUD_SECTION_PLACE = "Tamaño y posición del HUD",
    HUD_LAYOUT_LABEL = "Disposición:",
    TEST_OPEN = "Probar mi mando",
    TEST_BACK = "Volver a los botones",
    HELP_INTRO = "Elige un tema a la izquierda. El tutorial lo repasa todo paso a paso.",
    HELP_PRINCIPLE = "El principio",
    HELP_COMMANDS = "Comandos",
    TIP_CONTROLLER = "Elige tu mando: el addon usa los nombres de sus botones adicionales.",
    TIP_TYPES = "Volver a ver qué hace cada tipo de botón: modificador, objetivo, botón simple, ninguno.",
    TIP_DETECT = "Luego pulsa el botón del mando: el addon recuerda la tecla que envía.",
    TIP_CLEAR = "Olvidar la tecla de este botón: ya no hace nada.",
    TIP_TEST = "Ver en directo lo que WoW recibe de cada botón: útil si un botón no responde.",
    TIP_REPORT = "Un texto para enviar al autor si hay un problema (sin nombre de personaje ni de reino).",
    TIP_PROFILE_USE = "Este perfil pasa a ser el usado: su mando, sus botones y las acciones de este personaje.",
    TIP_PROFILE_NEW = "Un perfil vacío, por ejemplo para otro mando.",
    TIP_PROFILE_COPY = "Un perfil nuevo, copia del elegido, para probar cambios sin riesgo.",
    TIP_PROFILE_RENAME = "Cambiar el nombre del perfil elegido.",
    TIP_PROFILE_DELETE = "Borrar el perfil elegido, con las acciones de todos tus personajes para este perfil.",
    TIP_PROFILE_EXPORT = "Un texto para copiar, para compartir este perfil o guardarlo aparte.",
    TIP_PROFILE_IMPORT = "Pegar el texto de un perfil exportado (el tuyo o el de otro jugador).",
    TIP_HUD_DETACH = "Las miniaturas salen del HUD: puedes colocarlas donde quieras (candado del HUD y arrastrar).",
    TIP_HUD_VERTICAL = "Las miniaturas se apilan en columna en lugar de en fila.",
    TIP_HUD_HIDDEN = "Sin miniaturas: el HUD solo muestra la capa actual. Las capas se editan en la pestaña Capas.",
    TIP_HUD_ROWS = "En cuántas filas (o columnas) se reparten las miniaturas.",
    TIP_HUD_STRIP_SIZE = "El tamaño de las miniaturas, sin cambiar el resto del HUD.",
    TIP_HUD_SIZE = "El tamaño de todo el HUD.",
    TIP_HUD_MOVE = "Desbloquear el HUD para arrastrarlo con el ratón (como el candado del HUD). Haz clic de nuevo para bloquearlo.",
    TIP_HUD_RESET = "Devolver el HUD a su lugar y tamaño de origen (las miniaturas separadas vuelven debajo).",
    TIP_UPRANK = "Cuando aprendes un nuevo rango de un hechizo, sustituye al antiguo en todas partes sin preguntar.",
    TIP_VIBRATION = "Una breve vibración cuando un modificador bloqueable se activa o desactiva, y cuando se pone un nuevo rango.",
    TIP_MINIMAP = "El botón junto al minimapa: clic para abrir la configuración, clic derecho para mover el HUD.",
})

-- Nouveautés 1.2.0, et l'encart « donne ton avis »
ns.AddLocale("esES", {
    WHATSNEW_1_2_0 = "• La ventana se reorganiza en el orden de la configuración: Botones, Capas (la antigua pestaña Acciones), HUD, Opciones, Perfiles, Ayuda. Cada ajuste tiene su descripción emergente, la Ayuda tiene un índice y la prueba del mando se abre desde la pestaña Botones.\n• Nuevos rangos de hechizos: cuando aprendes uno, el addon propone sustituir el antiguo en todas partes (o lo hace solo, pestaña Opciones). /mgir rangs revisa todo el libro de hechizos.\n• Consumibles inteligentes (menú de una casilla): tu mejor poción, comida, bebida o venda, actualizada sola.\n• Los hechizos que este personaje no conoce aparecen en rojo; «Plantillas y especializaciones...» puede quitarlos.\n• Un campo busca una acción en todas tus capas.\n• Nuevas acciones básicas: objetivo anterior, asistir, foco, seguir, abrir las bolsas, desmontar, montura favorita al azar.\n• HUD: pequeños botones al pasar el ratón (candado para moverlo, fila o columna, ajustes); las miniaturas pueden separarse del HUD, ponerse en columna u ocultarse. El HUD siempre se muestra.\n• A, B, X e Y de «Solo» muestran la acción del juego, y la página de un botón simple su casilla en cada modificador.\n• Vibraciones del mando, si el juego lo permite.",
    WHATSNEW_FEEDBACK = "¿Un error, una idea, algo molesto? Dímelo: cada comentario ayuda a mejorar el addon. Copia este enlace (Ctrl+C) para escribir en GitHub:",
})

-- 1.3.0: objetivo del hechizo, acción según el contexto, acción cíclica,
-- comprobación de la configuración, comodidad del HUD
ns.AddLocale("esES", {
    MENU_UNIT = "Lanzar sobre...",
    MENU_COND = "Acción según el contexto...",
    MENU_SEQ = "Acción cíclica...",
    MENU_PICKUP_CAST = "O suelta aquí un hechizo o un objeto",
    SLOT_KIND_REFUSED = "Aquí solo un hechizo o un objeto.",
    KIND_cond = "Acción según el contexto",
    KIND_seq = "Acción cíclica",

    UNIT_TITLE = "Lanzar sobre",
    UNIT_target = "El objetivo (habitual)",
    UNIT_CURRENT = "elegido",
    UNIT_player = "Yo",
    UNIT_helpself = "El aliado seleccionado; si no, yo",
    UNIT_focus = "El foco",
    UNIT_targettarget = "El objetivo de mi objetivo",
    UNIT_pet = "Mi mascota",
    UNIT_party = "Miembro del grupo %s",
    UNIT_TIP = "Lanzado sobre: %s",

    COND_TITLE = "Acción según el contexto",
    COND_HELP = "Una casilla, dos acciones: la primera sale si la condición se cumple; si no, la segunda. Una de las dos puede quedar vacía.",
    COND_IF = "Condición:",
    COND_THEN = "Si se cumple",
    COND_ELSE = "Si no",
    COND_NOTHING = "Nada",
    COND_NEED_ACTION = "Pon al menos un hechizo o un objeto.",
    COND_TIP_IF = "%s: %s",
    COND_TIP_ELSE = "Si no: %s",
    COND_combat = "En combate",
    COND_mounted = "En una montura",
    COND_stealth = "En sigilo",
    COND_harm = "Mi objetivo es un enemigo",
    COND_help = "Mi objetivo es un aliado",
    COND_exists = "Tengo un objetivo",
    COND_pet = "Tengo una mascota",
    COND_group = "En grupo",
    COND_swimming = "Nadando",
    COND_indoors = "En interiores",
    COND_stance = "Forma o actitud %d",

    SEQ_TITLE = "Acción cíclica",
    SEQ_HELP = "De 2 a 4 hechizos u objetos: cada pulsación lanza el siguiente y luego se vuelve a empezar. El juego solo pasa al siguiente si el hechizo se ha lanzado.",
    SEQ_RESET = "Volver al primero:",
    SEQ_RESET_none = "Solo después del último",
    SEQ_RESET_target = "Al cambiar de objetivo",
    SEQ_RESET_combat = "Al terminar el combate",
    SEQ_RESET_both = "Cambio de objetivo o fin del combate",
    SEQ_RESET_seconds = "Tras %d s sin pulsar",
    SEQ_NEED_TWO = "Pon al menos dos hechizos u objetos.",
    SEQ_TIP_RESET = "Vuelta al primero: %s",

    GAME_mounttoggle = "Montar / desmontar",
    GAME_targetpet = "Seleccionar mi mascota",
    GAME_sheet = "Mostrar la chuleta de las capas",
    GAME_partynext = "Siguiente aliado del grupo (yo y luego cada miembro)",
    GAME_targetparty = "Seleccionar al miembro del grupo %d",

    CHECK_BUTTON = "Comprobar mi configuración",
    TIP_CHECK = "Busca lo que impide que un botón o una casilla funcione: botón sin tecla, macro borrada, hechizo desconocido, pareja incompleta... Cada línea propone corregirlo o ir allí.",
    CHECK_TITLE = "Comprobación de la configuración",
    CHECK_ALL_GOOD = "Todo listo: nada que corregir.",
    CHECK_SUMMARY = "%d punto(s) por corregir, %d observación(es).",
    CHECK_FIX = "Corregir",
    CHECK_GO = "Ir allí",
    CHECK_AGAIN = "Comprobar de nuevo",
    CHECK_CLEAR = "Vaciar la casilla",
    CHECK_CLEARED = "Casilla vaciada.",
    CHECK_REMOVE = "Quitar",
    CHECK_REPLACE = "Reemplazar",
    CHECK_UNCHECK = "Desmarcar",
    CHECK_NO_KEY = "%s no tiene tecla: no hace nada. Pulsa «Detectar» en la pestaña Botones, o ponlo en «Desactivado».",
    CHECK_SAME_KEY = "%s y %s tienen la misma tecla (%s): solo uno de los dos funciona.",
    CHECK_PAIR_HALF = "La pareja %s está marcada, pero %s no es un modificador: no funciona.",
    CHECK_MACRO_GONE = "%s: la macro «%s» ya no existe en el juego. La casilla no hace nada.",
    CHECK_SET_GONE = "%s: el conjunto de equipo «%s» ya no existe. La casilla no hace nada.",
    CHECK_COMPOSED_EMPTY = "%s: esta acción ya no tiene ningún hechizo ni objeto válido. La casilla no hace nada.",
    CHECK_ITEM_GONE = "%s: %s no está ni en tus bolsas ni equipado.",
    CHECK_UNKNOWN = "%d casilla(s) tienen un hechizo que este personaje no conoce: no hacen nada.",
    CHECK_LOWER_RANKS = "%d casilla(s) tienen un rango inferior de un hechizo del que conoces un rango superior.",
    CHECK_EMPTY_BUTTON = "%s no tiene ninguna acción.",
    CHECK_TAP_SAFE = "Este juego no permite medir cuánto dura una pulsación: un botón de selección solo cambia de objetivo si aún no tienes uno válido.",
    HUD_IDLE_ALPHA = "Opacidad en reposo:",
    TIP_HUD_IDLE_ALPHA = "La opacidad del HUD fuera de combate, cuando no se mantiene ningún botón. Al 0 %, queda oculto: vuelve en combate, cuando mantienes un botón o al pasar el ratón.",
    SHEET_BUTTON = "Chuleta de las capas",
    TIP_SHEET = "Muestra todas tus capas en grande en el centro de la pantalla, para aprender tus atajos. También con /mgir map, o con la acción básica «Mostrar la chuleta de las capas» puesta en una casilla.",
    SHEET_TITLE = "Chuleta: todas tus capas",
    SHEET_HINT = "Escape o /mgir map para cerrar. La capa en uso tiene un borde dorado.",

    TUTO_ACTIONS_MORE = "\n|cffffd100Para ir más lejos|r (menú de una casilla):\n- |cffffd100Lanzar sobre...|r: el hechizo o el objeto va sobre ti, el foco, el objetivo de tu objetivo, tu mascota o un miembro del grupo. La casilla muestra una «@».\n- |cffffd100Acción según el contexto...|r: dos acciones y una condición (en combate, en una montura, forma...). La primera sale si la condición se cumple; si no, la segunda. La casilla muestra una «/».\n- |cffffd100Acción cíclica...|r: de 2 a 4 hechizos u objetos, el siguiente en cada pulsación. La casilla muestra el paso («2/3»).\n- |cffffd100Acción básica|r: «Siguiente aliado del grupo» pasa de ti a cada miembro del grupo; «Seleccionar al miembro del grupo» elige uno directamente. El juego no permite que un addon elija al aliado más herido.\n\n¿Un botón o una casilla no funciona? |cffffd100Comprobar mi configuración|r (pestaña Botones, o /mgir check) te dice por qué.",
    TUTO_HUD_MORE = "\n|cffffd100Pestaña HUD|r:\n- |cffffd100Opacidad en reposo|r: lo visible que es el HUD fuera de combate; al 0 %, queda oculto y vuelve en combate o cuando mantienes un botón.\n- |cffffd100Chuleta de las capas|r (o /mgir map): todas tus capas en grande en el centro de la pantalla.",
    HELP_COMMANDS_MORE = "|cffffd100/mgir check|r: comprobar la configuración\n|cffffd100/mgir map|r: chuleta de todas las capas",
    SLASH_HELP_MORE = "/mgir check: comprobar la configuración  |  /mgir map: chuleta de las capas",
    WHATSNEW_1_3_0 = "• Lanzar sobre... (menú de una casilla): un hechizo o un objeto va sobre ti, el foco, el objetivo de tu objetivo, tu mascota o un miembro del grupo, sin escribir una macro.\n• Acción según el contexto: una casilla, dos acciones y una condición (en combate, en una montura, en sigilo, forma, objetivo enemigo o aliado...).\n• Acción cíclica: de 2 a 4 hechizos u objetos en una casilla, el siguiente en cada pulsación.\n• Nuevas acciones básicas: siguiente aliado del grupo, seleccionar al miembro 1 a 4, seleccionar tu mascota, montar / desmontar, chuleta.\n• Comprobar mi configuración (pestañas Botones y Ayuda, /mgir check): la lista de lo que impide que un botón o una casilla funcione, con la forma de corregirlo.\n• HUD: opacidad en reposo ajustable (hasta oculto fuera de combate) y una chuleta de todas tus capas (/mgir map).",
})
