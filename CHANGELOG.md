# Journal des versions — My Gamepad Is Rich

## 1.3.0

### Couches et actions
- **Lancer sur…** (menu d'une case, onglet Couches et HUD) : un sort ou un objet part sur toi, l'allié ciblé sinon toi, le focus, la cible de ta cible, ton familier ou un membre du groupe (1 à 4), sans écrire de macro. La case montre un « @ », l'info-bulle dit la cible, et la portée affichée est celle de cette cible.
- **Action selon le contexte…** : une case, deux actions (sorts, objets, montures, jouets) et une condition : en combat, sur une monture, en furtivité, cible ennemie, cible alliée, une cible, un familier, en groupe, en nageant, à l'intérieur, forme ou posture 1 à 6. La première part si la condition est vraie, la seconde sinon ; une des deux peut rester vide. Le HUD montre l'icône, la recharge et l'état de celle qui partirait. La case montre un « / ».
- **Action cyclique…** : 2 à 4 sorts ou objets sur une case, le suivant à chaque appui (`/castsequence`), avec retour au premier au choix (changement de cible, fin du combat, après 5, 10 ou 30 s). Le jeu ne passe au suivant que si le sort est parti. La case montre l'étape (« 2/3 »).
- **Nouvelles actions de base** : allié suivant du groupe (toi, puis chaque membre, absents sautés), cibler le membre du groupe 1 à 4, cibler ton familier, monter / descendre de monture, aide-mémoire des couches.
- Choisir l'allié le plus blessé n'est pas possible : le code protégé ne lit pas la vie des unités, et le reste du code ne cible pas en combat.
- Les nouveaux rangs de sorts, les sorts inconnus et la recherche regardent aussi les actions composées. « Retirer les sorts inconnus » ne retire que le sort concerné.
- Le menu d'une case est le même dans l'onglet Couches et sur le HUD.

### Vérifier ma configuration
- Bouton dans les onglets Boutons et Aide, `/mgir check` : la liste de ce qui empêche un bouton ou une case de marcher (bouton sans touche, deux boutons sur la même touche, plus de ciblage allié / ennemi, paire incomplète, paire LB + LT / RB + RT, macro du jeu ou ensemble d'équipement supprimé, action composée vide, objet absent, sorts inconnus, rangs inférieurs, bouton sans action, commande WoW impossible, appui bref non mesurable, réglages en attente du combat). Chaque ligne propose de corriger (avec `/mgir undo` quand une action est retirée) ou d'y aller.

### HUD
- **Opacité au repos** réglable (onglet HUD), de 0 à 100 % ; à 0 %, le HUD est caché hors combat et revient en combat, quand un bouton est tenu ou au survol.
- **Aide-mémoire des couches** : toutes les couches en grand au milieu de l'écran, la couche utilisée en doré. Bouton de l'onglet HUD, `/mgir carte` (ou `map`), ou action de base à poser sur une case ; marche en combat, Échap le ferme.
- Taille des miniatures, taille du HUD et opacité au repos se règlent avec une **barre à curseur** (glisser, ou molette de la souris) au lieu des boutons - et +.
- Ces réglages voyagent avec l'export du HUD.

## 1.2.0

### Fenêtre de configuration
- **Onglets dans l'ordre de la configuration** : Boutons, Couches, HUD, Options, Profils, Aide, Soutenir. La fenêtre s'ouvre sur Boutons la première fois, puis sur le dernier onglet utilisé.
- L'onglet **Actions** devient **Couches**, comme partout ailleurs dans l'addon.
- Chaque onglet commence par une phrase qui dit à quoi il sert, et chaque réglage a une info-bulle.
- Nouvel onglet **Options** : section Confort (nouveaux rangs de sorts, vibrations) et section Interface (bouton de la minimap). L'onglet **HUD** ne garde que l'affichage, en deux sections : Miniatures des couches, et Taille et position du HUD.
- Le **test de la manette** n'est plus un onglet : « Tester ma manette » l'ouvre depuis l'onglet Boutons (`/mgir test` aussi).
- L'onglet **Aide** a un sommaire : le principe, chaque étape du tutoriel, les commandes.
- Le tutoriel présente les nouveautés ci-dessous (recherche, consommables intelligents, sorts inconnus, nouveaux rangs, petits boutons du HUD, `/mgir rangs`).
- La fenêtre des nouveautés invite à donner son avis, avec le lien des tickets GitHub à copier.

### Couches et actions
- **Nouveaux rangs de sorts** : quand on apprend un rang chez le maître de classe, l'addon repère le rang inférieur posé dans ses couches et sur les barres du jeu, et propose de le remplacer partout. Option pour le faire sans demander (onglet Options) ; `/mgir rangs` vérifie tout le grimoire. Un rang choisi exprès garde son rang.
- **Consommables intelligents** (menu d'une case, aussi sur le HUD) : meilleure potion de soins ou de mana, nourriture, boisson, bandage. La case lance le meilleur objet des sacs utilisable à ce niveau, puis le suivant quand la pile est finie, combat compris.
- **Sorts inconnus** : un sort que ce personnage ne connaît pas est grisé et rouge (onglet Couches et HUD). « Modèles et spés… » propose de retirer ces sorts (`/mgir undo` les remet).
- **Chercher une action** : un champ en haut de la liste des couches. Les couches qui l'ont montrent combien de cases, les cases trouvées ont un bord doré.
- **Nouvelles actions de base** : cible précédente, assister la cible, mettre en focus, cibler le focus, suivre la cible, ouvrir les sacs, descendre de monture, monture favorite au hasard.
- **Seul** : A, B, X et Y montrent l'action du jeu (icône et nom, lu dans l'info-bulle de Forever) au lieu de « Jeu », dans l'onglet Couches et sur le HUD.
- La page d'un **bouton simple** montre aussi sa case dans chaque couche de modificateur, de ciblage et de paire. Une case vide y affiche « Vide » (elle ne fait rien), et non plus « Habituel ».

### HUD
- **Petits boutons au survol** : le cadenas déverrouille le HUD pour le glisser à la souris, un autre met les miniatures en ligne ou en colonne, l'engrenage ouvre l'onglet HUD.
- Les miniatures des couches peuvent être **séparées du HUD** (placées où on veut), **en colonne**, ou **cachées**. Le HUD principal ne bouge pas quand on change ces réglages.
- Le HUD est toujours affiché : la case « Afficher le HUD » et `/mgir hud on / off` disparaissent. Le choix « miniatures en haut / en bas » aussi, remplacé par les miniatures séparées.

### Manette
- **Vibrations** (si le jeu les permet, voir `/mgir etat`) : une quand un modificateur verrouillable s'allume, deux quand il s'éteint, une quand un nouveau rang est posé. Option dans l'onglet Options.

### Corrections
- La mesure de durée d'un appui (boutons de ciblage) est vérifiée à nouveau si un écran de chargement l'a fait échouer au lancement, au lieu de conclure qu'elle est impossible.

## 1.1.6

### Actions
- **Marqueurs de raid** dans les actions de base : **Marquage rapide** pose le marqueur suivant sur la cible à chaque appui (crâne, croix, carré, lune, triangle, losange, cercle, étoile), les 8 marqueurs un par un, et **Retirer le marqueur**. Ils marchent sur toutes les cases, en combat aussi.
- **Se cibler soi-même** dans les actions de base, sur toutes les cases.
- L'info-bulle d'un sort montre son rang (« Rang 3 »), dans l'onglet Actions et dans le HUD : le rang choisi exprès, sinon celui du sort.

### Corrections
- **Cible alliée / ennemie dans Forever** : chaque appui bref passe à la cible suivante, même quand on en a déjà une. Forever ne donne au code protégé de l'addon ni horloge ni minuteur : la durée de l'appui est maintenant mesurée avec la surveillance d'unité du jeu (celle des cadres de groupe, combat compris), qui cache un petit cadre protégé à chaque passage ; l'addon compte les passages. Au chargement, il vérifie que ça marche et mesure leur rythme, pour qu'un appui ne compte comme maintenu qu'au-delà d'environ 0,3 s.
- **La visée au stick droit répond tout de suite** : elle s'allume dès qu'on incline le stick pendant que le bouton est tenu, et seulement alors. Allumée dès l'appui, elle choisissait tout de suite la meilleure cible devant soi, et l'appui bref passait ensuite à la suivante de celle-là, souvent toujours la même.
- La cible visée reste si le stick droit est encore incliné au relâchement, ou après un appui maintenu. Si la mesure de durée n'est pas possible, seul le stick décide.

### Aide au diagnostic
- `/mgir etat` dit comment l'appui bref est reconnu (avec la surveillance d'unité, ou le stick seul), si le code protégé lit la manette, et la position de chaque stick. Le journal note les changements de cible.

## 1.1.5

### Corrections
- **Cible alliée / ennemie en combat** (régression de la 1.1.4) : le bouton ne reste plus tenu après le relâchement. Le HUD restait sur sa couche et le ciblage au stick restait allumé jusqu'à la fin du combat, car le témoin de la 1.1.4 (un cadre ordinaire) ne peut pas être lu par le code protégé en combat.
- L'appui maintenu est maintenant mesuré entièrement en code protégé : un petit cadre protégé montré à l'appui, que le jeu cache tout seul au bout de 0,3 s. Encore montré au relâchement : appui bref, la cible suivante est prise ; déjà caché : appui maintenu, la cible visée reste. Au chargement, l'addon vérifie que le jeu cache bien ce cadre, sinon il garde la règle de secours.

## 1.1.4

### Corrections
- **Cible alliée / ennemie** : chaque appui bref passe à la cible suivante, même quand on en a déjà une. Dans les versions du jeu qui ne donnent pas l'heure au code protégé de l'addon (comme Forever), l'appui maintenu est reconnu par un témoin : un petit cadre invisible montré quand l'appui dure plus de 0,3 s. Avant, l'appui bref n'y ciblait que si l'on n'avait pas déjà un allié (ou un ennemi) vivant.

### Aide au diagnostic
- `/mgir etat` dit comment l'appui bref est reconnu : horloge, témoin, ou ni l'un ni l'autre.

## 1.1.3

### Corrections
- **Cible alliée / ennemie** : la cible visée au stick reste quand on relâche le bouton. Avant, le relâchement ciblait à nouveau le plus proche et remplaçait la cible choisie. Seul un appui bref (moins de 0,3 s) cible le plus proche.
- Si le jeu ne permet pas de mesurer la durée de l'appui, le relâchement ne recible que si la cible actuelle n'est pas déjà un allié (ou un ennemi) vivant.

## 1.1.2

### Actions
- Une commande WoW ou une macro écrite à la main peut prendre l'icône de son choix : clic sur la case (onglet Actions ou HUD), **Changer l'icône...**. La fenêtre montre les icônes de macro du jeu ; la recherche trouve les icônes des sorts, des objets et des commandes WoW, ou une icône par son nom de fichier (comme sur Wowhead : `inv_misc_map_01`). **Icône par défaut** revient à l'icône d'origine.
- Les commandes courantes ont leur propre icône au lieu de la clé : carte du monde, sacs, grimoire, journal de quêtes, personnage, hauts faits, recherche de groupe, collections.
- L'icône choisie est gardée à l'export et à l'import d'un profil.

## 1.1.1

### Boutons simples
- Une couche vide (LT, RT, un modificateur, une paire ou une cible) ne fait plus rien, au lieu de reprendre l'action « Seul ». Le HUD la montre vide, au lieu de l'icône de « Seul » en gris.
- Seule exception : une commande WoW posée sur « Seul » (Course automatique…) part aussi avec LT ou RT tenu, car elle est liée directement à la touche ; le HUD la montre alors en gris.
- HUD : LT ou RT réglé en bouton simple affiche bien sa couche « Seul » quand on appuie dessus.

### Actions
- La liste des sorts contient aussi les sorts de métier : Découverte d'herbes, Découverte de gisements, Pêche, Cuisine, Archéologie, et les sorts qui ouvrent la fenêtre d'un métier.

## 1.1.0

Tout ce qui a changé depuis la 1.0.0. Au premier lancement après la mise à jour, la fenêtre « Nouveautés » le résume (`/mgir news` pour la revoir).

### HUD
- Les actions de l'addon s'affichent comme sur les barres du jeu : rouges hors de portée, bleues sans assez de ressource (mana, énergie…), grises si inutilisables, bord doré pendant un proc, charges restantes, case allumée pendant une action en cours (attaque automatique, forme…).
- L'ordre des miniatures des couches se choisit : flèches de l'onglet HUD, ou glisser une miniature sur une autre (hors combat). « Ordre d'origine » remet l'ordre de l'interface.

### Actions
- Chaque spécialisation (ou groupe de talents) a ses propres actions, comme les barres du jeu. Une spé jamais jouée commence avec une copie des actions de la précédente.
- **Remplir les cases vides** (couche de modificateur) : pierre de foyer, bijoux utilisables équipés et consommables des sacs (potions, nourriture, bandages, élixirs…).
- **Copier / échanger…** : copie une couche de combinaisons vers une autre, ou échange deux couches.
- **Modèles et spés…** (sous la liste des couches) : enregistrer ses actions comme modèle pour tout le compte, et les charger sur un autre personnage de la même classe ; copier les actions d'une autre spé.
- `/mgir reset` demande confirmation. `/mgir undo` revient en arrière après une remise à zéro, un modèle, une copie de spé, une copie ou un échange de couches.

### Boutons
- **Modificateur verrouillable** (boutons supplémentaires) : un appui active la couche, l'appui suivant la quitte, sans avoir à le maintenir.
- **Détecter** refuse A, B, X, Y, la croix et LT, RT, LB, RB : pressés par erreur, ils deviendraient la touche d'un bouton supplémentaire.

### Profils
- Option **Retenir le profil de chaque personnage** : à sa connexion, chaque personnage reprend le dernier profil qu'il a utilisé.
- Le réglage « verrouillable » voyage avec l'export / import.

### Corrections et fiabilité
- Couches bloquées : un bouton de base donné à l'addon reste à qui a reçu l'appui (l'addon ou une fenêtre de Forever) jusqu'à son relâchement, et un bouton noté tenu alors qu'il est relâché est libéré.
- Forever ne reste plus bloqué sur sa barre RT (ou LT), par exemple après un sort lancé avec RT + A comme un sceau de paladin. S'il se bloque malgré tout, l'addon le remet sur « Seul » et reprend le bouton au début d'un combat.
- Véhicules, barres de remplacement et combats de mascottes : l'addon s'efface et les boutons du jeu fonctionnent, en combat aussi.
- Plus besoin de `/mgir restore` avant de désactiver l'addon : à chaque déconnexion, LT et LB retrouvent leur imitation de Maj / Ctrl, et l'addon la recoupe à la connexion.

### Aide au diagnostic
- Onglet Test manette : **Copier un rapport**, un texte à envoyer à l'auteur (manette, touches, ce que WoW reçoit, journal récent des couches ; ni nom de personnage ni royaume), pour confirmer les préréglages des manettes non testées.
- `/mgir etat` : l'état des couches dans le chat (boutons tenus, barre active de Forever, liaisons de A, LT, RT, LB, RB, pause en véhicule).
- Textes traduits dans les 10 langues du jeu.

## 1.0.0

Première version publiée.
