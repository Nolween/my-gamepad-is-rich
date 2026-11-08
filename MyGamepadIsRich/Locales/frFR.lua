-- Français
local _, ns = ...

ns.AddLocale("frFR", {
    TITLE = "My Gamepad Is Rich",
    TAB_BUTTONS = "Boutons",
    TAB_TEST = "Test manette",
    TAB_HELP = "Aide",

    NAME = "Nom :",
    KEY = "Touche :",
    KEY_NONE = "non définie",
    DETECT = "Détecter",
    CLEAR = "Effacer",
    MODE = "Mode :",
    MODE_MODIFIER = "Modificateur",
    MODE_SIMPLE = "Bouton simple",
    MODE_OFF = "Désactivé",
    MODE_MODIFIER_DESC = "Maintiens ce bouton et appuie sur A, B, X, Y ou la croix : 8 nouvelles combinaisons, comme LT/RT.",
    MODE_SIMPLE_DESC = "Une action, plus une avec LT maintenu et une avec RT maintenu. Une couche vide reprend l'action « Seul ».",
    MODE_OFF_DESC = "Ce bouton ne fait rien : sa touche reste libre.",
    LAYER_BASE = "Seul",
    LAYER_LT = "LT +",
    LAYER_RT = "RT +",
    SLOT_HINT = "Glisse un sort, un objet, une macro ou une monture sur un emplacement. Clic droit : plus de choix.",
    EMPTY = "Vide",
    NO_KEY_WARNING = "Définis d'abord la touche : clique sur « Détecter » puis appuie sur le bouton.",

    MENU_SPELL = "Choisir un sort...",
    MENU_ITEM = "Choisir un objet du sac...",
    SPELL_TITLE = "Sorts du personnage",
    ITEM_TITLE = "Objets des sacs",
    ITEMS_EQUIPPED = "Équipés (utilisables)",
    ITEMS_USABLE = "Utilisables",
    ITEMS_OTHER = "Autres objets",
    LIST_EMPTY = "Rien à afficher.",
    MENU_MACROTEXT = "Écrire une macro...",
    MENU_COMMAND = "Commande WoW...",
    MENU_CLEAR = "Vider",
    MENU_PICKUP_HINT = "Ou dépose ici un sort / objet / macro / monture",
    MACRO_TITLE = "Texte de macro",
    MACRO_HELP = "Une commande par ligne, ex. /cast Boule de feu  (255 caractères max)",
    OK = "OK",
    CANCEL = "Annuler",
    COMMAND_TITLE = "Commande WoW",
    SEARCH = "Rechercher :",
    COMMAND_LT_RT = "Une commande WoW ne marche que sur la couche « Seul » d'un bouton sans couche LT/RT.",

    KIND_spell = "Sort",
    KIND_item = "Objet",
    KIND_toy = "Jouet",
    KIND_mount = "Monture",
    KIND_macro = "Macro",
    KIND_macrotext = "Macro personnalisée",
    KIND_command = "Commande WoW",
    KIND_equipset = "Ensemble d'équipement",

    CURSOR_UNSUPPORTED = "Ceci ne peut pas aller sur un bouton (seulement sorts, objets, jouets, montures, macros, ensembles d'équipement).",
    APPLIED_AFTER_COMBAT = "En combat : les changements seront appliqués à la fin du combat.",
    APPLIED = "Changements appliqués.",
    LEARN_PROMPT = "Appuie sur le bouton de la manette pour |cffffd100%s|r\n\n(Échap pour annuler)",
    LEARN_COMBAT = "Impossible de détecter un bouton en combat.",
    LEARN_DONE = "%s est maintenant sur la touche %s.",
    LEARN_TAKEN = "La touche %s était utilisée par %s : retirée.",
    LEARN_BOUND = "Note : %s était liée à « %s » dans WoW ; tant que l'addon l'utilise, c'est l'addon qui gagne.",

    TEST_STANDARD = "Boutons standard",
    TEST_EXTRA = "Boutons supplémentaires",
    TEST_LOG = "Dernières entrées",
    TEST_GAME = "jeu",
    TEST_UNKNOWN = "non assignée",

    IF_WARNING = "Improved Forever est chargé : s'il utilise aussi une de ces touches, le dernier binding appliqué gagne.",
    OPEN_CONFIG = "Ouvrir la configuration",
    LOADED = "chargé. Tape /mgir pour configurer tes boutons supplémentaires.",
    RESET_DONE = "Les actions de ce personnage ont été remises à zéro.",

    DPAD_UP = "Croix haut",
    DPAD_DOWN = "Croix bas",
    DPAD_LEFT = "Croix gauche",
    DPAD_RIGHT = "Croix droite",
    PADDLE = "Palette %s",

    TUTO_TITLE = "Tutoriel",
    TUTO_NEXT = "Suivant",
    TUTO_BACK = "Précédent",
    TUTO_SKIP = "Passer le tutoriel",
    TUTO_FINISH = "Ouvrir la configuration",
    TUTO_REOPEN = "Tutoriel fermé. Tape /mgir tuto pour le revoir.",
    TUTO_SUGGESTED = "Prendre les modes conseillés",
    HELP_REPLAY = "Revoir le tutoriel",

    TUTO_WELCOME_TITLE = "Bienvenue dans My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "Pour chaque bouton, clique sur |cffffd100Détecter|r, puis appuie sur ce bouton de ta manette. "
        .. "La touche qu'il envoie s'affiche à côté.",


    TUTO_ACTIONS_TEXT = "Dans la fenêtre de configuration, chaque bouton montre ses emplacements.\n\n"
        .. "- Glisse un sort depuis ton grimoire, un objet depuis tes sacs, une macro, une monture ou un jouet sur un emplacement.\n"
        .. "- Ou fais un clic droit sur un emplacement : choisir un sort ou un objet du sac, écrire une macro, choisir une commande WoW (comme Course automatique), ou le vider.\n\n"
        .. "Les actions sont enregistrées par personnage ; les touches et les modes pour tout le compte. "
        .. "Tout fonctionne en combat ; seules les modifications faites en combat attendent sa fin.",

    TUTO_DONE_TITLE = "Tout est prêt",
    TUTO_DONE_TEXT = "Ouvre la configuration pour poser tes premières actions.\n\n"
        .. "|cffffd100/mgir|r : ouvrir la configuration\n"
        .. "|cffffd100/mgir test|r : test manette, pour voir ce que WoW reçoit\n"
        .. "|cffffd100/mgir tuto|r : ce tutoriel\n"
        .. "|cffffd100/mgir reset|r : vider les actions de ce personnage",
})

-- HUD
ns.AddLocale("frFR", {
    HUD_UNLOCKED = "HUD déverrouillé : déplace-le à la souris. Tape à nouveau /mgir hud pour le verrouiller.",
    HUD_LOCKED = "HUD verrouillé.",
    HUD_ON = "HUD affiché : il remplace la barre manette du jeu.",
    HUD_OFF = "HUD masqué : la barre manette du jeu revient. Tape /mgir hud on pour le réafficher.",
    HUD_SCALE = "Taille du HUD : %s",
    TUTO_HUD_TITLE = "Ton HUD manette",
})

-- HUD : attribution rapide
ns.AddLocale("frFR", {
    HUD_COMBAT = "Impossible de changer les actions en combat.",
    HUD_GAME_SLOT = "Ce bouton garde l'action du jeu (sauter, interagir...).",
    HUD_KIND = "La barre du jeu ne prend que des sorts, objets, montures et macros de la liste des macros.",
    HUD_EDITING = "Modification de cette couche : clic sur une case pour l'attribuer, clic droit pour la vider. Clique à nouveau sur la miniature pour revenir.",
    HUD_TILE_HINT = "Clic : attribuer  -  Clic droit : vider",
    HUD_CARD_HINT = "Clic : modifier cette couche",
})

-- HUD : bande des miniatures
ns.AddLocale("frFR", {
    HUD_STRIP_TOP = "Miniatures des couches maintenant au-dessus du HUD. Tape /mgir hud strip pour basculer.",
    HUD_STRIP_BOTTOM = "Miniatures des couches maintenant sous le HUD. Tape /mgir hud strip pour basculer.",
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("frFR", {
    TUTO_STRIP_LABEL = "Miniatures des couches :",
    TUTO_STRIP_BOTTOM = "En bas (conseillé)",
    TUTO_STRIP_TOP = "En haut",
})

-- Bouton de la minimap
ns.AddLocale("frFR", {
    MINIMAP_LEFT = "Clic gauche : ouvrir la configuration",
    MINIMAP_RIGHT = "Clic droit : déverrouiller / verrouiller le HUD pour le déplacer",
    MINIMAP_SHIFT = "Maj + clic gauche : tutoriel",
    MINIMAP_DRAG = "Glisser : déplacer ce bouton autour de la minimap",
    MINIMAP_HIDDEN = "Bouton de la minimap masqué. Tape /mgir minimap pour le remontrer.",
    MINIMAP_SHOWN = "Bouton de la minimap affiché.",
})

-- Paires de modificateurs
ns.AddLocale("frFR", {
    PAIR_READY = "Paire · maintenir les deux",
    PAIR_NOT_READY = "Paire · indisponible",
    PAIR_DESC = "Maintiens %s et %s ensemble, puis appuie sur A, B, X, Y ou la croix : 8 combinaisons de plus.",
    PAIR_NEEDS = "Pour utiliser cette paire, %s et %s doivent tous les deux être en mode Modificateur, avec une touche.",
})

-- Fenêtre de configuration (onglets Actions, Boutons, HUD)
ns.AddLocale("frFR", {
    TAB_ACTIONS = "Actions",
    TAB_HUD = "HUD",
    SECTION_PAD = "Barre manette",
    SECTION_MODS = "Modificateurs",
    SECTION_MODS_EMPTY = "Aucun pour l'instant : passe un bouton en Modificateur dans l'onglet Boutons.",
    SECTION_SIMPLE = "Boutons simples",
    SECTION_SIMPLE_EMPTY = "Aucun pour l'instant : passe un bouton en Bouton simple dans l'onglet Boutons.",
    LAYER_DESC_BASE = "A, B, X, Y et la croix sans rien maintenir. A, B, X et Y gardent les actions du jeu (sauter, interagir...).",
    LAYER_DESC_HOLD = "Maintiens %s, puis appuie sur A, B, X, Y ou la croix.",
    PAIRS_TITLE = "Paires (deux modificateurs maintenus ensemble)",
    HUD_INTRO = "Le HUD remplace la barre manette du jeu : la couche utilisée en grand, toutes les couches en miniature.",
    HUD_SHOW = "Afficher le HUD (à la place de la barre manette du jeu)",
    HUD_SIZE = "Taille :",
    HUD_MOVE = "Déplacer le HUD",
    HUD_MOVE_DONE = "Verrouiller le HUD",
    HUD_RESET = "Remettre position et taille d'origine",
    MINIMAP_SHOW = "Bouton autour de la minimap",
    GAME_ACTION = "Jeu",
    BAR_UNAVAILABLE = "La barre manette du jeu n'est pas disponible (l'interface manette est-elle activée ?).",
    KIND_slot = "Action",
    SLOT_HINT = "Glisse un sort, un objet, une macro ou une monture sur un emplacement. Clic : menu. Clic droit : vider.",
})

-- HUD : taille et lignes des miniatures
ns.AddLocale("frFR", {
    HUD_STRIP_SIZE = "Taille des miniatures :",
    HUD_STRIP_ROWS = "Lignes de miniatures :",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("frFR", {
    CONTROLLER_LABEL = "Manette :",
    CONTROLLER_CHANGE = "Changer...",
    CONTROLLER_PICK = "Choisis ta manette",
    CONTROLLER_OTHER = "Autre manette",
    EXTRA = "Bouton",
    SOFTWARE_GENERIC = "le logiciel de ta manette",
    SETTINGS_DESC = "Configure les boutons supplémentaires de ta manette (palettes arrière, gâchettes en plus). Commande : /mgir",
    BUTTONS_INTRO = "Ta manette et ses boutons supplémentaires : la touche que chacun envoie, et ce qu'il fait. Survole un mode pour voir ce qu'il fait.",
    TEST_INTRO = "Appuie sur n'importe quel bouton : ce que WoW reçoit s'allume. Si tes boutons supplémentaires n'affichent rien, assigne-leur des touches clavier dans le logiciel de ta manette (voir Aide).",
    LEARN_MODKEY = "Attention : %s est une touche Maj / Ctrl / Alt ; dans le logiciel de ta manette, préfère une touche comme F9-F12.",

    TUTO_WELCOME_TEXT = "Cet addon donne accès dans WoW aux boutons supplémentaires de ta manette : palettes arrière, gâchettes ou boutons en plus "
        .. "(GameSir, Xbox Elite, DualSense Edge, SCUF, 8BitDo, Flydigi...).\n\n"
        .. "Chacun peut devenir un modificateur à maintenir (8 nouvelles combinaisons avec A, B, X, Y et la croix), "
        .. "ou un bouton simple avec ses propres couches LT et RT.\n\n"
        .. "Ce tutoriel prend environ deux minutes. Tu peux le quitter à tout moment et le rouvrir avec |cffffd100/mgir tuto|r.",

    TUTO_CONTROLLER_TITLE = "Étape 1 : Ta manette",
    TUTO_CONTROLLER_TEXT = "Choisis ta manette : l'addon reprend alors les noms de ses boutons et t'indique le logiciel qui les configure. "
        .. "Elle n'est pas dans la liste ? Choisis |cffffd100Autre manette|r (jusqu'à 6 boutons, que tu peux renommer).",

    TUTO_SOFTWARE_TITLE = "Étape 2 : Faire envoyer une touche aux boutons",
    TUTO_SOFTWARE_WHY = "Windows voit la plupart des manettes comme une manette Xbox (XInput). Ce mode ne transmet que les boutons standard : "
        .. "WoW ne reçoit donc jamais les boutons supplémentaires. La solution : faire envoyer une touche clavier à chacun.",
    TUTO_SOFTWARE_VENDOR = "1. Branche la manette et ouvre |cffffd100%s|r.\n"
        .. "2. Ouvre la page de configuration des boutons.\n"
        .. "3. Donne à chaque bouton supplémentaire (%s) une touche clavier que tu n'utilises pas dans WoW. Bons choix : |cffffd100F9, F10, F11, F12|r, "
        .. "ou le pavé numérique (avec Verr. Num activé).\n"
        .. "4. Évite Maj, Ctrl et Alt : elles changeraient tes autres raccourcis.\n"
        .. "5. Enregistre le profil (sur la manette, si le logiciel le propose).",
    TUTO_SOFTWARE_ALT = "Si %s ne sait pas donner une touche clavier à ces boutons, passe par |cffffd100Steam Input|r : ajoute WoW (ou le lanceur Battle.net) "
        .. "à Steam comme jeu non-Steam, lance-le depuis Steam et donne une touche à chaque bouton dans sa configuration de manette. "
        .. "|cffffd100reWASD|r (payant) marche aussi, sans Steam.",
    TUTO_SOFTWARE_STEAM = "1. Dans |cffffd100Steam|r, ajoute WoW (ou le lanceur Battle.net) comme jeu non-Steam "
        .. "(Jeux > Ajouter un jeu non-Steam à ma bibliothèque), puis lance-le depuis Steam.\n"
        .. "2. Ouvre sa configuration de manette (overlay Steam, ou les paramètres de manette du jeu dans Steam).\n"
        .. "3. Donne à chaque bouton supplémentaire (%s) une touche clavier que tu n'utilises pas dans WoW. Bons choix : |cffffd100F9, F10, F11, F12|r.\n"
        .. "4. Évite Maj, Ctrl et Alt : elles changeraient tes autres raccourcis.\n\n"
        .. "|cffffd100reWASD|r (payant) fait la même chose sans Steam.",

    TUTO_DETECT_TITLE = "Étape 3 : Détecter tes boutons",
    TUTO_DETECT_ALL = "|cff40ff40Tous tes boutons sont détectés.|r",
    TUTO_DETECT_MISSING = "Rien ne se passe quand tu appuies ? Vérifie la touche du bouton dans le logiciel de ta manette (étape 2), puis réessaie.",

    TUTO_MODES_TITLE = "Étape 4 : Choisir un mode",
    TUTO_MODES_TEXT = "|cffffd100Modificateur|r : maintiens le bouton, puis appuie sur A, B, X, Y ou la croix. 8 actions par bouton, comme LT et RT.\n"
        .. "|cffffd100Bouton simple|r : une action, plus une avec LT maintenu et une avec RT maintenu.\n"
        .. "|cffffd100Désactivé|r : la touche reste libre.\n\n"
        .. "Conseil : des modificateurs sur les boutons les plus faciles à maintenir, des boutons simples sur les autres.",
    TUTO_PAIRS_TEXT = "|cffffd100Paires|r : les boutons vont par paires gauche + droite. Quand les deux boutons d'une paire sont des modificateurs, "
        .. "les maintenir ensemble donne 8 combinaisons de plus.",

    TUTO_ACTIONS_TITLE = "Étape 5 : Poser tes actions",

    TUTO_HUD_TEXT = "L'addon remplace la barre manette du jeu par son propre HUD, en bas de l'écran :\n\n"
        .. "- |cffffd100En grand|r : la couche que tu utilises, la croix à gauche, A/B/X/Y à droite. Maintiens LT, RT ou un modificateur et elle change.\n"
        .. "- |cffffd100Dans la bande|r (en bas, ou en haut avec /mgir hud strip) : toutes les couches en miniature (Seul, LT, RT, LT+RT, tes modificateurs et paires) ; celle que tu maintiens s'allume.\n"
        .. "- |cffffd100Au centre|r : tes boutons simples, avec l'action qui partira selon la gâchette tenue.\n\n"
        .. "Il s'estompe hors combat quand tu ne maintiens rien.\n"
        .. "|cffffd100/mgir hud|r : le déplacer  -  |cffffd100/mgir hud scale 1.2|r : sa taille  -  |cffffd100/mgir hud off|r : revenir à la barre du jeu",
})

-- Profils : liste, export, import
ns.AddLocale("frFR", {
    TAB_PROFILES = "Profils",
    PROFILES_INTRO = "Un profil contient une manette, ses boutons et, pour chaque personnage, ses actions. Un seul profil est utilisé à la fois, pour tout le compte. Le HUD est commun à tous les profils.",
    PROFILE_ACTIVE = "utilisé",
    PROFILE_USE = "Utiliser ce profil",
    PROFILE_NEW = "Nouveau...",
    PROFILE_COPY = "Copier...",
    PROFILE_RENAME = "Renommer...",
    PROFILE_DELETE = "Supprimer",
    PROFILE_EXPORT = "Exporter...",
    PROFILE_IMPORT = "Importer...",
    PROFILE_DEFAULT = "Profil",
    PROFILE_IMPORTED = "Profil importé",
    PROFILE_COPY_SUFFIX = "%s (copie)",
    PROFILE_NAME_NEW = "Nom du nouveau profil :",
    PROFILE_NAME_COPY = "Nom de la copie :",
    PROFILE_NAME_RENAME = "Nouveau nom pour « %s » :",
    PROFILE_DELETE_CONFIRM = "Supprimer le profil « %s » ? Ses boutons, et les actions de tous tes personnages pour ce profil, seront perdus.",
    PROFILE_SWITCHED = "Profil utilisé : %s.",
    PROFILE_UNKNOWN = "Aucun profil ne s'appelle « %s ». Tape /mgir profils pour les voir.",
    PROFILE_COMBAT = "Impossible de changer de profil en combat.",
    PROFILE_LAST = "C'est ton seul profil : il ne peut pas être supprimé.",
    PROFILE_CREATED = "Profil « %s » créé et utilisé. Règle ses touches dans l'onglet Boutons.",

    EXPORT_TITLE = "Exporter « %s »",
    EXPORT_ACTIONS = "Inclure les actions de ce personnage",
    EXPORT_HUD = "Inclure les réglages du HUD",
    EXPORT_HINT = "Le texte est sélectionné : Ctrl+C pour le copier, puis colle-le où tu veux (Discord, un fichier texte...). On l'importe avec le bouton Importer de l'onglet Profils.",
    CLOSE = "Fermer",

    IMPORT_TITLE = "Importer un profil",
    IMPORT_PASTE = "Colle le texte d'export ici (Ctrl+V) :",
    IMPORT_EMPTY = "Colle un texte d'export pour voir ce qu'il contient.",
    IMPORT_BAD = "Ce n'est pas un texte d'export de My Gamepad Is Rich.",
    IMPORT_VERSION = "Ce texte vient d'une autre version de l'addon et ne peut pas être lu.",
    IMPORT_DAMAGED = "Ce texte est abîmé ou incomplet : copie-le à nouveau, en entier.",
    IMPORT_SUMMARY = "Profil « %s », manette : %s\n%d bouton(s) avec une touche, %d action(s)",
    IMPORT_SUMMARY_HUD = "Contient des réglages du HUD.",
    IMPORT_MACROS = "Attention : %d macro(s) écrite(s) à la main. Lis-les avant de t'en servir :",
    IMPORT_COMMANDS = "Commandes WoW : %s",
    IMPORT_AS_NEW = "Nouveau profil :",
    IMPORT_REPLACE = "Remplacer :",
    IMPORT_PICK = "Profil à remplacer",
    IMPORT_ACTIONS = "Importer les actions (pour ce personnage)",
    IMPORT_HUD = "Appliquer les réglages du HUD",
    IMPORT_DO = "Importer",
    IMPORT_REPLACE_CONFIRM = "Remplacer le profil « %s » ? Sa manette et ses boutons seront écrasés, ainsi que ses actions pour ce personnage si tu les importes.",
    IMPORT_DONE = "Profil « %s » importé.",

    SELFTEST_OK = "Auto-test : tout est bon.",
    SELFTEST_FAIL = "Auto-test : %d problème(s) : %s",
    SLASH_HELP = "/mgir : ouvrir  |  /mgir profil <nom> : changer de profil  |  /mgir test : test manette  |  /mgir tuto : tutoriel  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : remettre à zéro les actions de ce personnage",
})

-- HUD : arrêt après une erreur
ns.AddLocale("frFR", {
    HUD_ERROR = "Erreur du HUD, il est arrêté jusqu'au /reload (la barre du jeu revient). Merci de signaler ce message : %s",
})
