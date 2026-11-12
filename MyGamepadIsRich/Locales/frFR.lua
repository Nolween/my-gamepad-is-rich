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
    MODE_MODIFIER = "Modificateur",
    MODE_SIMPLE = "Bouton simple",
    MODE_OFF = "Désactivé",
    MODE_MODIFIER_DESC = "Maintiens ce bouton et appuie sur A, B, X, Y ou la croix : 8 nouvelles combinaisons, comme LT/RT.",
    MODE_SIMPLE_DESC = "Une action, plus une avec LT maintenu et une avec RT maintenu. Une couche vide ne fait rien.",
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
    MENU_ICON = "Changer l'icône...",
    ICON_TITLE = "Choisir une icône",
    ICON_HINT = "Cherche par nom de sort, d'objet ou de commande WoW, ou tape le nom de fichier d'une icône (comme sur Wowhead : inv_misc_map_01).",
    ICON_DEFAULT = "Icône par défaut",
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
    HELP_REPLAY = "Revoir le tutoriel",

    TUTO_WELCOME_TITLE = "Bienvenue dans My Gamepad Is Rich",


    TUTO_DETECT_TEXT = "Pour chaque bouton, clique sur |cffffd100Détecter|r, puis appuie sur ce bouton de ta manette. "
        .. "La touche qu'il envoie s'affiche à côté.",



    TUTO_DONE_TITLE = "Tout est prêt",
})

-- HUD
ns.AddLocale("frFR", {
    HUD_UNLOCKED = "HUD déverrouillé : déplace-le à la souris (les miniatures séparées se déplacent à part). Pour le verrouiller : le cadenas du HUD, ou à nouveau /mgir hud.",
    HUD_LOCKED = "HUD verrouillé.",
    HUD_SCALE = "Taille du HUD : %s",
    TUTO_HUD_TITLE = "Ton HUD manette",
})

-- HUD : attribution rapide
ns.AddLocale("frFR", {
    HUD_COMBAT = "Impossible de changer les actions en combat.",
    HUD_GAME_SLOT = "Ce bouton garde l'action du jeu (sauter, interagir...).",
    HUD_KIND = "La barre du jeu ne prend que des sorts, objets, montures et macros de la liste des macros.",
    HUD_EDITING = "Modification de cette couche : clic sur une case pour l'attribuer, clic droit pour la vider. Clique à nouveau sur la miniature, ou appuie sur n'importe quel autre bouton ou touche, pour revenir.",
    HUD_TILE_HINT = "Clic : attribuer  -  Clic droit : vider",
    HUD_CARD_HINT = "Clic : modifier cette couche",
})

-- HUD : bande des miniatures
ns.AddLocale("frFR", {
})

-- Tutoriel : choix de la bande des miniatures
ns.AddLocale("frFR", {
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
    TAB_ACTIONS = "Couches",
    TAB_HUD = "HUD",
    SECTION_PAD = "Barre manette",
    SECTION_MODS = "Modificateurs",
    SECTION_MODS_EMPTY = "Aucun pour l'instant : passe un bouton en Modificateur dans l'onglet Boutons.",
    SECTION_SIMPLE = "Boutons simples",
    SECTION_SIMPLE_EMPTY = "Aucun pour l'instant : passe un bouton en Bouton simple dans l'onglet Boutons.",
    LAYER_DESC_BASE = "A, B, X, Y et la croix sans rien maintenir. Tout peut y aller : ce que la barre du jeu ne sait pas tenir (macro écrite à la main, commande WoW) est pris par l'addon. A, B, X et Y gardent les actions du jeu (sauter, interagir...) tant que tu n'y mets pas les tiennes.",
    LAYER_DESC_HOLD = "Maintiens %s, puis appuie sur A, B, X, Y ou la croix.",
    PAIRS_TITLE = "Paires (deux modificateurs maintenus ensemble)",
    HUD_INTRO = "Le HUD remplace la barre manette du jeu : la couche utilisée en grand, toutes les couches en miniature.",
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
    HUD_ORDER = "Ordre des miniatures :",
    HUD_ORDER_RESET = "Ordre d'origine",
    HUD_ORDER_HINT = "Flèches : déplacer une couche. Sur le HUD, tu peux aussi glisser une miniature sur une autre.",
    HUD_CARD_DRAG = "Glisser : la déplacer (sur une autre miniature)",
})

-- Manettes (préréglages), et les textes qui en dépendent
ns.AddLocale("frFR", {
    CONTROLLER_LABEL = "Manette :",
    CONTROLLER_CHANGE = "Changer...",
    CONTROLLER_PICK = "Choisis ta manette",
    CONTROLLER_OTHER = "Autre manette",
    EXTRA = "Bouton",
    SOFTWARE_GENERIC = "le logiciel de ta manette",
    TEST_INTRO = "Appuie sur n'importe quel bouton : ce que WoW reçoit s'allume. Si tes boutons supplémentaires n'affichent rien, assigne-leur des touches clavier dans le logiciel de ta manette (voir Aide).",
    LEARN_MODKEY = "Attention : %s est une touche Maj / Ctrl / Alt ; dans le logiciel de ta manette, préfère une touche comme F9-F12.",



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

    TUTO_DETECT_ALL = "|cff40ff40Tous tes boutons sont détectés.|r",



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

-- Gâchettes LT / RT données à l'addon
ns.AddLocale("frFR", {
    TRIGGERS_LABEL = "Gâchettes LT / RT :",
    TRIGGERS_ADDON = "Modificateurs de l'addon",
    TRIGGERS_GAME = "Couches du jeu",
    TRIGGERS_ADDON_DESC = "Maintiens LT ou RT (ou les deux) puis appuie sur A, B, X, Y ou la croix : les actions de l'addon, avec tout ce qu'il permet (macros écrites à la main, commandes WoW). Elles remplacent les couches LT, RT et LT + RT de la barre manette du jeu ; une case vide ne fait rien. LB et RB ne changent pas.",
    TRIGGERS_GAME_DESC = "LT et RT gardent les couches de la barre manette du jeu (modifiables depuis l'onglet Couches).",
    TRIGGERS_COPIED = "%d action(s) des couches LT / RT du jeu reprise(s) dans celles de l'addon.",
    IMPORT_SUMMARY_TRIGGERS = "LT / RT : modificateurs de l'addon.",
})

-- Menu d'une case : pourquoi des choix sont grisés
ns.AddLocale("frFR", {
    MENU_GAME_BAR_HINT = "Macros écrites, commandes WoW : donne LT / RT à l'addon (onglet Boutons, Boutons de base)",
})

-- Actions de base (celles de Forever sur A/B/X/Y)
ns.AddLocale("frFR", {
    MENU_GAME = "Action de base...",
    GAME_TITLE = "Actions de base",
    KIND_game = "Action de base",
    GAME_jump = "Sauter",
    GAME_cancel = "Annuler (sort, cible)",
    GAME_search = "Rechercher (clic droit sur la cible)",
    GAME_attack = "Attaque automatique",
    GAME_interact = "Interagir",
})

-- Modes de ciblage (comme LB / RB dans Forever)
ns.AddLocale("frFR", {
    MODE_TARGET_FRIEND = "Cible alliée",
    MODE_TARGET_ENEMY = "Cible ennemie",
    MODE_TARGET_FRIEND_DESC = "Comme LB dans Forever : un appui bref cible l'allié le plus proche ; maintiens-le et vise avec le stick droit pour en choisir un. Maintenu, c'est aussi un modificateur : A, B, X, Y et la croix lancent ses 8 raccourcis.",
    MODE_TARGET_ENEMY_DESC = "Comme RB dans Forever : un appui bref cible l'ennemi le plus proche ; maintiens-le et vise avec le stick droit pour en choisir un. Maintenu, c'est aussi un modificateur : A, B, X, Y et la croix lancent ses 8 raccourcis.",
    TARGET_UNAVAILABLE = "Le ciblage de Forever est introuvable : %s fonctionne comme un simple modificateur.",
})

-- Onglet « Soutenir » (don PayPal)
ns.AddLocale("frFR", {
    TAB_DONATE = "Soutenir",
    DONATE_TITLE = "Soutenir My Gamepad Is Rich",
    DONATE_INTRO = "My Gamepad Is Rich est gratuit et le restera. S'il te rend service et que tu veux me remercier, tu peux me faire un don sur PayPal, du montant de ton choix.",
    DONATE_SCAN = "Scanne le QR code avec ton téléphone",
    DONATE_LINK = "Ou copie le lien (Ctrl+C) et colle-le dans ton navigateur :",
    DONATE_THANKS = "Les dons sont entièrement facultatifs et ne débloquent rien : toutes les fonctions restent accessibles à tous. Merci pour ton soutien !",
})

-- Boutons de base (LT, RT, LB, RB)
ns.AddLocale("frFR", {
    MODE_GAME = "Jeu",
    MODE_GAME_DESC = "Ce bouton garde son rôle dans le jeu (LT / RT : couches de la barre manette ; LB / RB : le ciblage de Forever).",
    PADS_LABEL = "Boutons de base :",
    PADS_PICK = "%s : choisir un mode",
    IMPORT_SUMMARY_PADS = "Boutons de base donnés à l'addon : %s",
    EMULATION_OFF = "%s n'imite plus Maj / Ctrl tant qu'il est donné à l'addon. Elle est remise d'elle-même à la déconnexion.",
    RESTORE_DONE = "Boutons de base rendus au jeu, et leur imitation de Maj / Ctrl remise.",
})

-- Plus aucun ciblage allié / ennemi configuré
ns.AddLocale("frFR", {
    TARGET_MISSING_FRIEND = "Aucun bouton ne cible les alliés : remets LB sur « Jeu », ou mets un bouton en « Cible alliée » (onglet Boutons).",
    TARGET_MISSING_ENEMY = "Aucun bouton ne cible les ennemis : remets RB sur « Jeu », ou mets un bouton en « Cible ennemie » (onglet Boutons).",
    TARGET_MISSING_BOTH = "Aucun bouton ne cible les alliés ni les ennemis : remets LB / RB sur « Jeu », ou mets des boutons en « Cible alliée » / « Cible ennemie » (onglet Boutons).",
})

-- Onglet Boutons : mention des boutons de base
ns.AddLocale("frFR", {
    PAD_HINT = "bouton de la manette : rien à détecter",
})

-- Case vide d'un bouton simple dans une couche : son action habituelle
ns.AddLocale("frFR", {
    SIMPLE_USUAL = "Habituel",
})

-- Manettes standard (sans bouton supplémentaire), noms PlayStation
ns.AddLocale("frFR", {
    TUTO_NO_EXTRA = "Cette manette n'a pas de bouton supplémentaire : rien à configurer ici. Tu peux donner d'autres rôles à LT, RT, LB et RB (Boutons de base, dans l'onglet Boutons).",
    PS_CROSS = "Croix",
    PS_CIRCLE = "Rond",
    PS_SQUARE = "Carré",
    PS_TRIANGLE = "Triangle",
})

-- Paires libres (deux modificateurs quelconques)
ns.AddLocale("frFR", {
})

-- Paire avec un bouton de base resté au jeu
ns.AddLocale("frFR", {
})

-- Boutons de base : mode par défaut
ns.AddLocale("frFR", {
    MODE_IS_DEFAULT = "Par défaut pour ce bouton : il fonctionne comme dans le jeu.",
})

-- Tutoriel : les types de boutons, boutons de base, paires ; options
ns.AddLocale("frFR", {
    MODE = "Type :",
    TUTO_WELCOME_TEXT = "Cet addon te laisse choisir ce que fait chaque bouton de ta manette : les boutons supplémentaires (palettes arrière, gâchettes en plus : GameSir, Xbox Elite, DualSense Edge, SCUF...) et les boutons de base LT, RT, LB et RB.\n\n|cffffd100Le principe : les couches.|r Seuls, A, B, X, Y et la croix lancent 8 actions. Maintiens un bouton (LT, RT, une palette...) et ces mêmes 8 boutons lancent 8 autres actions : c'est une nouvelle couche. Chaque bouton que tu maintiens en donne une.\n\nCe tutoriel prend environ deux minutes. Tu peux le quitter à tout moment et le rouvrir avec |cffffd100/mgir tuto|r.",
    TUTO_CONTROLLER_TITLE = "Ta manette",
    TUTO_CONTROLLER_TEXT = "Choisis ta manette : l'addon reprend les noms de ses boutons supplémentaires et t'indique le logiciel qui les configure. Une manette Xbox ou PlayStation classique, sans bouton en plus ? Choisis-la aussi : tu pourras quand même configurer LT, RT, LB et RB. Elle n'est pas dans la liste ? Choisis |cffffd100Autre manette|r (jusqu'à 6 boutons, que tu peux renommer).",
    TUTO_TYPES_TITLE = "Les 4 types de boutons",
    TUTO_TYPES_TEXT = "Chaque bouton reçoit un type, qui dit ce qu'il fait. Tu le choisis dans les étapes suivantes, et à tout moment dans l'onglet |cffffd100Boutons|r (survole un type pour revoir son explication).",
    TYPE_MODIFIER_HOW = "Maintiens-le, puis appuie sur A, B, X, Y ou la croix : une couche de 8 actions. Seul, il ne fait rien.",
    TYPE_MODIFIER_FOR = "Pour : les boutons faciles à garder enfoncés. Par défaut sur LT et RT, comme dans le jeu.",
    TYPE_TARGET_HOW = "Un appui bref cible l'allié (ou l'ennemi) le plus proche ; maintiens-le et vise avec le stick droit pour en choisir un autre. Maintenu avec A, B, X, Y ou la croix : 8 raccourcis, comme un modificateur.",
    TYPE_TARGET_FOR = "Pour : les soins et les sorts lancés sur une cible. Par défaut sur LB (allié) et RB (ennemi), comme dans le jeu.",
    TYPE_SIMPLE_HOW = "Un appui lance une action. Avec LT ou RT maintenu, il en lance une autre. Il a aussi une case dans chaque couche de modificateur.",
    TYPE_SIMPLE_FOR = "Pour : un sort que tu lances souvent, une potion, une monture.",
    TYPE_OFF_HOW = "Le bouton ne fait rien : sa touche reste libre pour autre chose.",
    TYPE_OFF_FOR = "Pour : les boutons supplémentaires dont tu ne te sers pas (les boutons de base n'ont pas ce type).",
    TUTO_SOFTWARE_TITLE = "Faire envoyer une touche aux boutons supplémentaires",
    TUTO_DETECT_TITLE = "Détecter tes boutons supplémentaires",
    TUTO_DETECT_MISSING = "Rien ne se passe quand tu appuies ? Vérifie la touche du bouton dans le logiciel de ta manette, puis réessaie.",
    TUTO_MODES_TITLE = "Le type de tes boutons supplémentaires",
    TUTO_MODES_TEXT = "Choisis le type de chaque bouton supplémentaire (survole un type pour revoir ce qu'il fait).\nConseil : des modificateurs sur les boutons les plus faciles à maintenir, des boutons simples sur les autres. |cffffd100Prendre les types conseillés|r le fait pour toi.",
    TUTO_SUGGESTED = "Prendre les types conseillés",
    TUTO_PADS_TITLE = "Tes boutons de base : LT, RT, LB, RB",
    TUTO_PADS_TEXT = "Par défaut (en vert), ils font comme dans le jeu : LT et RT sont des modificateurs, LB cible les alliés et RB les ennemis. Les actions de la barre manette du jeu sont reprises dans leurs couches. Tu peux en changer : par exemple RB en bouton simple, ou LB en modificateur.",
    TUTO_PADS_DEFAULT = "Revenir aux types par défaut",
    TUTO_PAIRS_TITLE = "Les paires : deux boutons maintenus ensemble",
    TUTO_PAIRS_TEXT = "Maintiens deux boutons ensemble (modificateurs ou cibles) : encore une couche de 8 actions. N'importe lesquels peuvent faire une paire : L5 + R5, LT + RT, LB + LT... Coche celles que tu veux (tu pourras changer dans l'onglet |cffffd100Boutons|r). Par défaut : les paires gauche + droite.",
    TUTO_ACTIONS_TITLE = "Poser tes actions",
    TUTO_ACTIONS_TEXT = "Dans l'onglet |cffffd100Couches|r : à gauche, toutes tes couches (Seul, LT, RT, tes modificateurs et tes paires) ; à droite, la couche choisie, disposée comme la manette.\n\n- Glisse un sort depuis ton grimoire, un objet depuis tes sacs, une macro, une monture ou un jouet sur une case.\n- Ou clique sur une case : choisir un sort ou un objet, écrire une macro, choisir une commande WoW (Course automatique...) ou une action de base (Sauter, Interagir...). Clic droit : vider.\n- La ligne sous la croix : les cases de tes boutons simples dans cette couche.\n\nTu peux aussi cliquer sur une miniature de couche du HUD pour la modifier sur place.\n\nLes actions sont enregistrées par personnage ; les types et les touches dans le profil, pour tout le compte. Tout fonctionne en combat ; seules les modifications faites en combat attendent sa fin.\n\n|cffffd100Pratique|r :\n- Le champ en haut de la liste cherche une action dans toutes tes couches.\n- |cffffd100Consommable intelligent|r (menu d'une case) : ta meilleure potion, nourriture, boisson ou bandage, mise à jour toute seule.\n- Un sort grisé et rouge : ce personnage ne le connaît pas. |cffffd100Modèles et spés...|r peut les retirer.\n- Un nouveau rang appris chez le maître de classe : l'addon propose de le mettre à la place de l'ancien, partout.",
    TUTO_HUD_TEXT = "L'addon remplace la barre manette du jeu par son propre HUD :\n\n- |cffffd100En grand|r : la couche que tu utilises, la croix à gauche, A/B/X/Y à droite. Maintiens un bouton et elle change.\n- |cffffd100Les miniatures|r : toutes tes couches, avec au milieu les cases de tes boutons simples ; celle que tu maintiens s'allume. Clique sur une miniature pour la modifier.\n- |cffffd100Au centre|r : tes boutons simples, avec l'action qui partira.\n\nRéglages (taille, position, miniatures) : onglet |cffffd100HUD|r.\n\nAu survol des miniatures, de petits boutons apparaissent : le |cffffd100cadenas|r déverrouille le HUD pour le déplacer à la souris (puis le reverrouille), un autre met les miniatures en ligne ou en colonne. Un |cffffd100engrenage|r ouvre l'onglet HUD pour les réglages précis (miniatures séparées du HUD, taille...).",
    TUTO_DONE_TEXT = "Ouvre la configuration pour poser tes premières actions.\n\n|cffffd100/mgir|r : ouvrir la configuration\n|cffffd100/mgir test|r : test manette, pour voir ce que WoW reçoit\n|cffffd100/mgir tuto|r : ce tutoriel\n|cffffd100/mgir reset|r : vider les actions de ce personnage\n|cffffd100/mgir restore|r : rendre LT, RT, LB et RB au jeu\n|cffffd100/mgir rangs|r : mettre les nouveaux rangs de tes sorts à la place des anciens",
    SETTINGS_DESC = "Choisis ce que fait chaque bouton de ta manette : boutons supplémentaires (palettes arrière, gâchettes en plus) et boutons de base (LT, RT, LB, RB). Commande : /mgir",
    BUTTONS_INTRO = "Choisis le type de chaque bouton : survole un type pour voir ce qu'il fait. En vert : le type par défaut des boutons de base, qui fait comme le jeu.",
    BUTTONS_TYPES_HELP = "Les types de boutons",
    PAIRS_HINT = "Coche les paires à utiliser : maintenir les deux boutons ensemble donne 8 actions de plus. N'importe quels deux modificateurs ou boutons de ciblage peuvent former une paire (L5 + LT, LB + RT...).",
    PAIRS_NONE = "Mets au moins deux boutons en Modificateur, Cible alliée ou Cible ennemie pour former des paires.",
    PAIR_WAITS = "%s est sur Jeu : mets-le en Modificateur, Cible alliée ou Cible ennemie (plus haut)",
})

-- Tutoriel, paires : appuyer sur les boutons pour les trouver
ns.AddLocale("frFR", {
    TUTO_PAIRS_PRESS = "Appuie sur un bouton de ta manette : ses paires s'allument en vert. Appuie sur deux boutons ensemble : leur paire s'allume.",
})

-- LB + LT et RB + RT : l'action de classe de Forever
ns.AddLocale("frFR", {
    PAIR_CLASS_WARN = "déclenche aussi l'action de classe de Forever",
    PAIR_CLASS_WARN_LONG = "Attention : %s déclenche aussi l'action de classe de Forever (souvent une roue de sorts, qui prend la main sur A, B, X et Y tant qu'elle est ouverte ; B pour la fermer). L'addon ne peut pas l'empêcher : choisis plutôt une autre paire.",
    PAIR_CLASS_NOTE = "%s et %s déclenchent aussi l'action de classe de Forever (souvent une roue de sorts qui prend la main sur A, B, X et Y). L'addon ne peut pas l'empêcher : mieux vaut choisir d'autres paires.",
})

-- Forever resté sur sa barre LT / RT
ns.AddLocale("frFR", {
    FOREVER_STUCK = "Forever est resté sur sa barre %s (un relâchement de bouton lui a échappé). Appuie une fois sur %s pour le remettre sur « Seul ».",
})

-- 1.1.0 : spés, état des actions sur le HUD, profils, remplissage rapide, rapport
ns.AddLocale("frFR", {
    SPEC_NUMBER = "Spécialisation %d",
    SPEC_SWITCHED = "Actions de la spécialisation « %s ».",
    SPEC_NEW = "Nouvelle spécialisation « %s » : elle commence avec une copie des actions de la précédente.",
    PROFILE_PER_CHAR = "Retenir le profil de chaque personnage",
    PROFILE_PER_CHAR_DESC = "À la connexion, chaque personnage reprend le dernier profil qu'il a utilisé. Sans cette option, tous prennent le dernier profil utilisé sur le compte.",
    REPORT_BUTTON = "Copier un rapport",
    REPORT_TITLE = "Rapport de manette",
    REPORT_HINT = "Appuie d'abord sur chaque bouton dans le test de la manette, puis copie ce texte (Ctrl+C) et envoie-le à l'auteur de l'addon, avec ce qui marche ou pas. Il aide à confirmer les réglages des autres manettes. Aucun nom de personnage ni de royaume n'y figure.",
    WHATSNEW_TITLE = "Nouveautés de My Gamepad Is Rich",
    QUICKFILL_BUTTON = "Remplir les cases vides",
    QUICKFILL_DESC = "Pose dans les cases vides de cette couche la pierre de foyer, les bijoux utilisables équipés et les consommables des sacs (potions, nourriture, bandages, élixirs...), sauf ceux déjà présents. Clic droit sur une case pour la vider.",
    QUICKFILL_DONE = "%d case(s) remplie(s).",
    QUICKFILL_NONE = "Rien à poser : aucun objet utilisable trouvé dans les sacs qui ne soit pas déjà sur cette couche.",
})

-- 1.1.0 : modèles de classe, copie de couches, verrou, annulation, véhicules
ns.AddLocale("frFR", {
    SLASH_HELP = "/mgir : ouvrir  |  /mgir profil <nom> : changer de profil  |  /mgir test : test manette  |  /mgir tuto : tutoriel  |  /mgir hud : HUD  |  /mgir minimap  |  /mgir reset : remettre à zéro les actions de ce personnage  |  /mgir undo : annuler le dernier changement d'actions  |  /mgir rangs : remplacer les rangs inférieurs des sorts",
    LEARN_PAD_REFUSED = "%s est un bouton de base de la manette : l'addon le combine ou le configure lui-même. Appuie sur le bouton supplémentaire (la touche que son logiciel envoie).",
    RESET_CONFIRM = "Vider toutes les actions de ce personnage dans le profil utilisé ?",
    RESET_CONFIRM_SPEC = "Vider toutes les actions de ce personnage pour la spécialisation « %s », dans le profil utilisé ?",
    UNDO_HINT = "/mgir undo pour revenir en arrière.",
    UNDO_DONE = "Actions remises comme avant le dernier changement.",
    UNDO_NONE = "Rien à annuler pour cette spécialisation.",
    ACTION_COUNT = "%d action(s)",
    LAYER_COPY_BUTTON = "Copier / échanger…",
    LAYER_COPY_DESC = "Copie les actions de cette couche vers une autre couche, ou échange les actions des deux couches (les 8 cases et celles des boutons simples).",
    LAYER_COPY_TITLE = "Couche %s",
    LAYER_COPY_TO = "Copier vers",
    LAYER_SWAP_WITH = "Échanger avec",
    LAYER_COPY_NONE = "Aucune autre couche de combinaisons : fais d'abord d'un autre bouton un modificateur.",
    LAYER_COPY_CONFIRM = "Remplacer les actions de la couche %s (%d) par celles de %s ?",
    LAYER_COPIED = "%s copiée vers %s.",
    LAYER_SWAPPED = "%s et %s échangées.",
    TPL_BUTTON = "Modèles et spés…",
    TPL_DESC = "Modèles de classe : enregistre les actions de cette spécialisation pour tout le compte, puis reprends-les sur un autre personnage de la même classe. Tu peux aussi copier les actions d'une autre spécialisation. Les actions laissées sur la barre du jeu n'en font pas partie.",
    TPL_TITLE = "Modèles et spécialisations",
    TPL_SECTION_SAVE = "Enregistrer",
    TPL_SAVE = "Enregistrer ces actions comme modèle…",
    TPL_SECTION_LOAD = "Charger un modèle (%s)",
    TPL_SECTION_SPEC = "Copier depuis une spécialisation",
    TPL_SECTION_DELETE = "Supprimer un modèle",
    TPL_SAVE_PROMPT = "Nom du modèle (pour tous les personnages %s du compte) :",
    TPL_SAVED = "Modèle « %s » enregistré pour %s.",
    TPL_REPLACE_CONFIRM = "Remplacer le modèle « %s » ?",
    TPL_LOAD_CONFIRM = "Charger le modèle « %s » ? Il remplace les actions de %s.",
    TPL_LOADED = "Modèle « %s » chargé.",
    TPL_DELETE_CONFIRM = "Supprimer le modèle « %s » pour tous les personnages de cette classe ?",
    TPL_DELETED = "Modèle « %s » supprimé.",
    SPEC_COPY_CONFIRM = "Copier les actions de « %s » ? Elles remplacent les actions de %s.",
    SPEC_COPIED = "Actions de « %s » copiées.",
    LATCH = "Verrouillable",
    LATCH_DESC = "Un appui active la couche de ce modificateur, l'appui suivant la quitte : plus besoin de le maintenir. Un autre modificateur maintenu prend la main tant qu'il est tenu. Tout changement de réglage libère le verrou. Boutons supplémentaires seulement (pas LT, RT, LB, RB).",
})

-- 1.1.0 : notes de version (tout ce qui a changé depuis la 1.0.0)
ns.AddLocale("frFR", {
    WHATSNEW_1_1_5 = "• Cible alliée / ennemie : en combat, le bouton ne reste plus tenu après le relâchement (le HUD restait sur sa couche et le stick continuait de viser). L'appui bref passe toujours à la cible suivante, et l'appui maintenu garde la cible visée.",
    WHATSNEW_1_1_4 = "• Cible alliée / ennemie : chaque appui bref passe à la cible suivante, même quand tu en as déjà une, y compris là où le jeu ne donne pas l'heure à l'addon. Un appui maintenu garde la cible visée au stick.\n• /mgir etat dit comment l'appui bref est reconnu.",
    WHATSNEW_1_1_3 = "• Cible alliée / ennemie : la cible visée au stick reste quand tu relâches le bouton. Seul un appui bref cible le plus proche.",
    WHATSNEW_1_1_2 = "• Une commande WoW ou une macro écrite à la main peut prendre l'icône de ton choix : clic sur la case, « Changer l'icône... ». La recherche trouve les icônes de tes sorts, de tes objets et des commandes WoW, ou une icône par son nom de fichier (comme sur Wowhead : inv_misc_map_01).\n• Les commandes courantes ont leur propre icône au lieu de la clé : carte du monde, sacs, grimoire, journal de quêtes, personnage, hauts faits, recherche de groupe, collections.",
    WHATSNEW_1_1_1 = "• Bouton simple : une couche vide (LT, RT ou un modificateur) ne fait plus rien et reste vide sur le HUD, au lieu de reprendre l'action « Seul ». Seule exception : une commande WoW posée sur « Seul ».\n• La liste des sorts contient aussi les sorts de métier : Découverte d'herbes, Découverte de gisements, Pêche, Cuisine, Archéologie…",
    WHATSNEW_1_1_0 = "• HUD : les actions de l'addon s'affichent comme sur les barres du jeu. Rouges hors de portée, bleues sans assez de ressource, grises si inutilisables, bord doré pendant un proc, charges restantes, case allumée pour une action en cours (attaque auto, forme...).\n• HUD : l'ordre des miniatures des couches se choisit (flèches de l'onglet HUD, ou glisser une miniature sur une autre).\n• Chaque spécialisation a ses propres actions. Une nouvelle spé commence avec une copie des actions de la précédente.\n• Onglet Actions : « Remplir les cases vides » pose la pierre de foyer, les bijoux et les consommables des sacs sur une couche de modificateur, et « Copier / échanger… » copie une couche de combinaisons vers une autre, ou échange deux couches.\n• Modèles de classe : enregistre tes actions pour tout le compte, puis reprends-les sur un autre personnage de la même classe (« Modèles et spés… » sous la liste des couches). Tu peux aussi copier les actions d'une autre spécialisation.\n• Modificateur verrouillable (onglet Boutons) : un appui active la couche, l'appui suivant la quitte.\n• /mgir reset demande confirmation, et /mgir undo revient en arrière après une remise à zéro, un modèle, une copie de spé ou de couche.\n• Profils : option « Retenir le profil de chaque personnage ».\n• Couches bloquées : un bouton de base donné à l'addon reste à qui a reçu l'appui jusqu'à son relâchement, et Forever ne reste plus bloqué sur sa barre RT (ou LT), par exemple après un sort lancé avec RT + A comme un sceau de paladin.\n• Véhicules, barres de remplacement et combats de mascottes : l'addon s'efface et les boutons du jeu fonctionnent, en combat aussi.\n• Plus besoin de /mgir restore avant de désactiver l'addon : à chaque déconnexion, LT et LB retrouvent leur imitation de Maj / Ctrl, et l'addon la recoupe à la connexion.\n• Détecter refuse A, B, X, Y, la croix et LT, RT, LB, RB (pressés par erreur, ils deviendraient la touche d'un bouton supplémentaire).\n• Onglet Test manette : « Copier un rapport » (avec le journal récent des couches), à envoyer pour aider à confirmer les autres manettes. /mgir etat montre l'état des couches.\n• /mgir news : revoir cette fenêtre.",
})

-- Marqueurs de raid (actions de base)
ns.AddLocale("frFR", {
    GAME_markquick = "Marquage rapide (marqueur suivant à chaque appui)",
    GAME_mark = "Marquer : %s",
    GAME_markclear = "Retirer le marqueur",
})

-- Se cibler (action de base)
ns.AddLocale("frFR", {
    GAME_targetself = "Se cibler soi-même",
})

-- Nouveautés de la 1.1.6
ns.AddLocale("frFR", {
    WHATSNEW_1_1_6 = "• Marqueurs de raid dans les actions de base : « Marquage rapide » pose le marqueur suivant sur ta cible à chaque appui (crâne, croix, carré, lune, triangle, losange, cercle, étoile), les 8 marqueurs un par un, et « Retirer le marqueur ».\n• « Se cibler soi-même » dans les actions de base.\n• L'info-bulle d'un sort montre son rang.\n• Cible alliée / ennemie : chaque appui bref passe maintenant à la cible suivante, aussi dans Forever, et la visée au stick droit répond tout de suite. La cible visée reste si le stick est encore incliné quand tu relâches le bouton, ou après un appui maintenu.",
})

-- Nouveaux rangs (maître de classe)
ns.AddLocale("frFR", {
    UPRANK_ASK = "Nouveau rang appris : %s.\n\nRemplacer le rang inférieur dans tes actions ?\n(%d case(s) de l'addon, %d case(s) des barres du jeu)",
    UPRANK_REPLACE = "Remplacer",
    UPRANK_KEEP = "Garder",
    UPRANK_DONE = "Nouveau rang posé : %d case(s) de l'addon, %d case(s) des barres du jeu.",
})

-- Confort : nouveaux rangs sans demander
ns.AddLocale("frFR", {
    COMFORT_TITLE = "Confort",
    UPRANK_AUTO = "Remplacer les nouveaux rangs de sorts sans demander (rangs inférieurs dans les actions de l'addon et sur les barres du jeu)",
    UPRANK_NONE = "Aucun rang inférieur à remplacer.",
})

-- Actions de base : cible, focus, sacs, montures
ns.AddLocale("frFR", {
    GAME_targetlast = "Cible précédente",
    GAME_assist = "Assister la cible",
    GAME_focus = "Mettre en focus",
    GAME_targetfocus = "Cibler le focus",
    GAME_follow = "Suivre la cible",
    GAME_openbags = "Ouvrir les sacs",
    GAME_dismount = "Descendre de monture",
    GAME_randommount = "Monture favorite au hasard",
})

-- Sorts inconnus
ns.AddLocale("frFR", {
    SPELL_UNKNOWN = "Ce personnage ne connaît pas ce sort (talents, autre spécialisation, modèle d'un autre personnage) : cette case ne fait rien.",
    UNKNOWN_SECTION = "Sorts inconnus",
    UNKNOWN_REMOVE = "Retirer les sorts inconnus",
    UNKNOWN_CONFIRM = "Retirer des actions de %2$s les %1$d sort(s) que ce personnage ne connaît pas ?",
    UNKNOWN_REMOVED = "%d sort(s) inconnu(s) retiré(s).",
})

-- Recherche d'une action (onglet Actions)
ns.AddLocale("frFR", {
    SEARCH_HINT = "Chercher une action",
    SEARCH_DESC = "Tape une partie d'un nom (sort, objet, macro...) : les couches qui l'ont montrent combien de cases, et ces cases ont un bord doré.",
})

-- Consommables intelligents
ns.AddLocale("frFR", {
    MENU_BEST = "Consommable intelligent...",
    BEST_TITLE = "Consommables intelligents",
    KIND_best = "Consommable intelligent",
    BEST_heal = "Meilleure potion de soins",
    BEST_mana = "Meilleure potion de mana",
    BEST_food = "Meilleure nourriture",
    BEST_drink = "Meilleure boisson",
    BEST_bandage = "Meilleur bandage",
    BEST_NONE = "Aucun dans tes sacs",
    BEST_DESC = "Utilise le meilleur objet de ce type présent dans tes sacs ; quand une pile est finie, le suivant (en combat aussi). La liste suit tes sacs hors combat.",
})

-- Vibrations
ns.AddLocale("frFR", {
    VIBRATION_OPTION = "Vibrations de la manette (modificateur verrouillable allumé / éteint, appui long reconnu, nouveau rang posé)",
})

-- Bouton simple : sa case dans chaque couche de modificateur
ns.AddLocale("frFR", {
    SIMPLE_MOD_ROW = "Avec un modificateur tenu (vide : ne fait rien)",
})

-- HUD : couches séparées, en colonne
ns.AddLocale("frFR", {
    HUD_LAYERS_LABEL = "Couches :",
    HUD_DETACH = "Séparées du HUD",
    HUD_VERTICAL = "En colonne",
    HUD_STRIP_COLS = "Colonnes de miniatures :",
    HUD_TOOL_VERTICAL = "Couches en colonne",
    HUD_TOOL_HORIZONTAL = "Couches en ligne",
})

-- HUD : cadenas (verrouiller / déverrouiller)
ns.AddLocale("frFR", {
    HUD_TOOL_UNLOCK = "Déverrouiller : déplacer le HUD à la souris",
    HUD_TOOL_LOCK = "Verrouiller le HUD (glisse-le d'abord où tu veux)",
    HUD_TOOL_LOCK_DETACHED = "Verrouiller le HUD (glisse d'abord le HUD et les couches, chacun à sa place)",
    HUD_UNLOCKED_HINT = "Déverrouillé : glisse à la souris (les couches séparées se déplacent à part). Clique sur le cadenas pour verrouiller.",
})

-- HUD : bouton vers l'onglet HUD
ns.AddLocale("frFR", {
    HUD_TOOL_SETTINGS = "Réglages du HUD (onglet HUD) : miniatures séparées du HUD, taille...",
})

-- HUD : miniatures des couches cachées
ns.AddLocale("frFR", {
    HUD_HIDE_STRIP = "Cachées",
})

-- Onglets réorganisés : Options, sections, Aide en sections, info-bulles
ns.AddLocale("frFR", {
    TAB_OPTIONS = "Options",
    ACTIONS_INTRO = "Ce que lance chaque bouton. Choisis une couche à gauche, puis pose tes actions sur ses cases à droite.",
    OPTIONS_INTRO = "Les réglages généraux de l'addon : ce qui n'est ni un bouton, ni une couche, ni l'affichage du HUD.",
    OPTIONS_SECTION_UI = "Interface",
    HUD_SECTION_STRIP = "Miniatures des couches",
    HUD_SECTION_PLACE = "Taille et position du HUD",
    HUD_LAYOUT_LABEL = "Disposition :",
    TEST_OPEN = "Tester ma manette",
    TEST_BACK = "Retour aux boutons",
    HELP_INTRO = "Choisis un sujet à gauche. Le tutoriel reprend tout pas à pas.",
    HELP_PRINCIPLE = "Le principe",
    HELP_COMMANDS = "Commandes",
    TIP_CONTROLLER = "Choisir ta manette : l'addon reprend les noms de ses boutons supplémentaires.",
    TIP_TYPES = "Revoir ce que fait chaque type de bouton : modificateur, cible, bouton simple, aucun.",
    TIP_DETECT = "Appuie ensuite sur le bouton de ta manette : l'addon retient la touche qu'il envoie.",
    TIP_CLEAR = "Oublier la touche de ce bouton : il ne fait plus rien.",
    TIP_TEST = "Voir en direct ce que WoW reçoit de chaque bouton : utile si un bouton ne répond pas.",
    TIP_REPORT = "Un texte à envoyer à l'auteur en cas de problème (sans nom de personnage ni royaume).",
    TIP_PROFILE_USE = "Ce profil devient celui utilisé : sa manette, ses boutons et les actions de ce personnage.",
    TIP_PROFILE_NEW = "Un profil vide, par exemple pour une autre manette.",
    TIP_PROFILE_COPY = "Un nouveau profil, copie de celui choisi, pour essayer des changements sans risque.",
    TIP_PROFILE_RENAME = "Changer le nom du profil choisi.",
    TIP_PROFILE_DELETE = "Supprimer le profil choisi, avec les actions de tous tes personnages pour ce profil.",
    TIP_PROFILE_EXPORT = "Un texte à copier pour partager ce profil ou le garder de côté.",
    TIP_PROFILE_IMPORT = "Coller le texte d'un profil exporté (le tien ou celui d'un autre joueur).",
    TIP_HUD_DETACH = "Les miniatures quittent le HUD : tu peux les placer où tu veux (cadenas du HUD, puis glisser).",
    TIP_HUD_VERTICAL = "Les miniatures s'empilent en colonne au lieu d'une ligne.",
    TIP_HUD_HIDDEN = "Plus de miniatures : le HUD ne montre que la couche en cours. Les couches se modifient dans l'onglet Couches.",
    TIP_HUD_ROWS = "Sur combien de lignes (ou de colonnes) répartir les miniatures.",
    TIP_HUD_STRIP_SIZE = "La taille des miniatures, sans changer celle du reste du HUD.",
    TIP_HUD_SIZE = "La taille de tout le HUD.",
    TIP_HUD_MOVE = "Déverrouiller le HUD pour le glisser à la souris (comme le cadenas du HUD). Clique à nouveau pour le verrouiller.",
    TIP_HUD_RESET = "Remettre le HUD à sa place et à sa taille d'origine (les miniatures séparées reviennent dessous).",
    TIP_UPRANK = "Quand tu apprends un nouveau rang d'un sort, il remplace l'ancien partout sans te poser la question.",
    TIP_VIBRATION = "Une petite vibration quand un modificateur verrouillable s'allume ou s'éteint, et quand un nouveau rang est posé.",
    TIP_MINIMAP = "Le bouton autour de la minimap : clic pour ouvrir la configuration, clic droit pour déplacer le HUD.",
})

-- Nouveautés 1.2.0, et l'encart « donne ton avis »
ns.AddLocale("frFR", {
    WHATSNEW_1_2_0 = "• Fenêtre réorganisée, dans l'ordre de la configuration : Boutons, Couches (l'ancien onglet Actions), HUD, Options, Profils, Aide. Chaque réglage a une info-bulle, l'Aide a un sommaire, et le test de la manette s'ouvre depuis l'onglet Boutons.\n• Nouveaux rangs de sorts : quand tu en apprends un, l'addon propose de remplacer l'ancien partout (ou le fait tout seul, onglet Options). /mgir rangs vérifie tout le grimoire.\n• Consommables intelligents (menu d'une case) : ta meilleure potion, nourriture, boisson ou bandage, mise à jour toute seule.\n• Les sorts que ce personnage ne connaît pas sont en rouge ; « Modèles et spés... » peut les retirer.\n• Un champ cherche une action dans toutes tes couches.\n• Nouvelles actions de base : cible précédente, assister, focus, suivre, ouvrir les sacs, descendre de monture, monture favorite au hasard.\n• HUD : de petits boutons au survol (cadenas pour le déplacer, ligne ou colonne, réglages) ; les miniatures peuvent être séparées du HUD, en colonne ou cachées. Le HUD est toujours affiché.\n• A, B, X et Y de « Seul » montrent l'action du jeu, et la page d'un bouton simple sa case dans chaque modificateur.\n• Vibrations de la manette, si le jeu le permet.",
    WHATSNEW_FEEDBACK = "Un bug, une idée, une gêne ? Dis-le-moi : chaque retour aide à améliorer l'addon. Copie ce lien (Ctrl+C) pour écrire sur GitHub :",
})
