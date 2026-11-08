# My Gamepad Is Rich — addon WoW Forever

Support des boutons supplémentaires des manettes (palettes arrière, gâchettes ou boutons en plus) dans World of Warcraft Forever :

- jusqu'à **6 boutons supplémentaires**, nommés selon la manette choisie (L5 / R5 / L4 / R4 d'une GameSir G7 Pro, P1 à P4 d'une Xbox Elite…) ; les emplacements que la manette n'utilise pas restent libres ;
- chaque bouton peut être :
  - **Modificateur** — maintenu, comme LT/RT : bouton + A / B / X / Y / croix = 8 nouvelles combinaisons ;
  - **Bouton simple** — une action, une autre avec LT maintenu, une autre avec RT maintenu (une couche vide reprend l'action « Seul ») ;
  - **Désactivé**.
- **Paires** : deux modificateurs quelconques (boutons supplémentaires ou boutons de base : L5 + R5, LT + RT, L5 + LT, LB + RT...) maintenus ensemble donnent 8 combinaisons de plus. On coche celles qu'on veut dans l'onglet Boutons ; par défaut, les paires gauche + droite (emplacements 1 + 2, 3 + 4, 5 + 6, LT + RT, LB + RB).
- **Boutons de base LT, RT, LB, RB** (au choix, par profil) : chacun peut devenir modificateur, cible alliée / ennemie ou bouton simple. Voir [Boutons de base](#boutons-de-base-lt-rt-lb-rb).
- **Modes de ciblage** : n'importe quel bouton peut cibler comme LB / RB dans Forever (appui = le plus proche, maintien + stick droit = visée), avec ses propres raccourcis. Voir [Modes de ciblage](#modes-de-ciblage).
- Interface en glisser-déposer (sorts, objets, macros, montures, jouets, ensembles d'équipement, macro écrite à la main, commande WoW).
- Fonctionne en combat.

## Manettes prévues

Le choix se fait dans le tutoriel ou dans l'onglet **Boutons** (« Changer… »). Une manette fixe les noms de ses boutons (renommables), les modes conseillés et le logiciel indiqué dans le tutoriel.

| Manette | Boutons | Logiciel pour leur donner une touche clavier |
|---|---|---|
| Xbox (Series, One, 360) | aucun : on configure LT, RT, LB, RB | — |
| PlayStation (DualSense, DualShock 4) | aucun : on configure L2, R2, L1, R1 (icônes et noms PlayStation) | — |
| GameSir G7 Pro | L5, R5, L4, R4 | GameSir Nexus (vérifié) |
| GameSir (G7 SE, Cyclone 2, Kaleid…) | L4, R4 | GameSir Nexus |
| Xbox Elite Series 2 / Core | P3, P1, P4, P2 | Xbox Accessories |
| PlayStation DualSense Edge | LP, RP | Steam Input (pas de logiciel Sony sur PC) |
| Steam Controller / Steam Deck | L4, R4, L5, R5 | Steam Input |
| SCUF Envision Pro | P1–P4, G1, G2 | iCUE |
| Razer Wolverine V3 Pro / V2 Pro | M1–M6 | logiciel Razer |
| 8BitDo Ultimate 2 | L4, R4, PL, PR | 8BitDo Ultimate Software |
| Flydigi Vader 4 Pro / Apex 4 | M1–M4, C, Z | Flydigi Space Station |
| Victrix Pro BFG | P1–P4 | Victrix Control Hub |
| Nacon Revolution 5 Pro | P1–P4 | logiciel Nacon |
| Turtle Beach Stealth Ultra | P1–P4 | logiciel Turtle Beach |
| Autre manette | E1–E6 | logiciel de la manette |

Seule la G7 Pro a été testée. Pour les autres, les noms des boutons et la capacité du logiciel à envoyer une **touche clavier** restent à confirmer. Le tutoriel propose donc toujours **Steam Input** (ou **reWASD**, payant) en repli. Les préréglages sont dans `Controllers.lua`.

## Pourquoi WoW ne voit pas ces boutons

Windows voit la plupart des manettes comme une manette **Xbox (XInput)**. La G7 Pro, par exemple, apparaît comme `USB\VID_3537&PID_100A`, pilote `xusb22`.
Le protocole XInput ne transporte que les boutons Xbox standard (A B X Y, LB RB, LT RT, L3 R3, croix, View, Menu).
Les boutons supplémentaires n'y existent pas, donc **aucun addon ne peut les lire directement**.
La solution : les programmer dans le logiciel de la manette (ou Steam Input) pour qu'ils envoient une **touche clavier**. L'addon apprend ensuite cette touche.

## Installation

1. Copier le dossier `MyGamepadIsRich` dans
   `K:\World of Warcraft\_forever_\Interface\AddOns\`.
   Pour développer, mieux vaut une jonction : le jeu lit alors directement ce dossier.
   ```bat
   mklink /J "K:\World of Warcraft\_forever_\Interface\AddOns\MyGamepadIsRich" "G:\Addons Wow Dev\MyGamepadIsRich\MyGamepadIsRich"
   ```
2. Lancer WoW Forever et activer **My Gamepad Is Rich** dans la liste des addons.

## Étape 1 — Le logiciel de la manette (une seule fois)

1. Brancher la manette et ouvrir son logiciel (GameSir Nexus, Xbox Accessories, iCUE…).
2. Ouvrir la configuration des boutons (mapping / profil).
3. Assigner une touche clavier inutilisée à chaque bouton supplémentaire, par exemple :

   | Bouton | Touche conseillée |
   |---|---|
   | 1er (L5, P3…) | F9 |
   | 2e (R5, P1…) | F10 |
   | 3e (L4, P4…) | F11 |
   | 4e (R4, P2…) | F12 |

   Éviter **Maj / Ctrl / Alt** : elles modifieraient les autres raccourcis.
4. Enregistrer le profil (sur la manette si le logiciel le propose).

**Sans logiciel adapté** (DualSense Edge, ou un logiciel qui ne sait faire que des boutons de manette) : ajouter WoW (ou le lanceur Battle.net) à Steam comme jeu non-Steam, le lancer depuis Steam, et donner les touches dans sa configuration de manette **Steam Input**. reWASD (payant) fait la même chose sans Steam.

## Étape 2 — Dans WoW

Au premier lancement (et une fois après la mise à jour qui l'a refait), un **tutoriel** s'ouvre : le principe des couches, le choix de la manette, **les 4 types de boutons** (Modificateur, Cible alliée / ennemie, Bouton simple, Désactivé) expliqués en cartes, les boutons de base (types par défaut en vert), puis — seulement si la manette a des boutons en plus — le logiciel, la détection et le type de ces boutons ; ensuite les paires à cocher, la pose des actions et le HUD. Tout se règle directement dans la fenêtre. On peut le revoir avec `/mgir tuto`, depuis l'onglet Aide, ou ouvrir l'explication des types avec le bouton « Les types de boutons » de l'onglet Boutons. La page de l'addon dans Options > AddOns reprend aussi cette explication.

La fenêtre (`/mgir` ou le bouton de la minimap) est organisée par tâche :

| Onglet | Rôle |
|---|---|
| **Actions** | Chaque couche, disposée comme la manette (croix à gauche, A/B/X/Y à droite) : la **barre manette** du jeu (Seul, LT, RT, LT+RT), les **modificateurs** et les **paires**, les **boutons simples**. Glisser un sort / objet / macro / monture sur une case, clic : menu, clic droit : vider. Sur une couche de modificateur, **Remplir les cases vides** pose la pierre de foyer, les bijoux utilisables équipés et les consommables des sacs (potions, nourriture, bandages, élixirs…) qui n'y sont pas déjà. |
| **Boutons** | La manette (« Changer… »). Pour chaque bouton supplémentaire : nom, touche (**Détecter**), mode. Pour les boutons de base (LT, RT, LB, RB) : mode. Les paires à utiliser, parmi toutes celles de deux modificateurs. |
| **Profils** | Les profils (un par manette, par exemple) : utiliser, créer, copier, renommer, supprimer, exporter, importer. Option « Retenir le profil de chaque personnage ». |
| **HUD** | Afficher le HUD, miniatures en bas / en haut, taille, ordre des miniatures, déplacer, bouton de la minimap. |
| **Test manette** | Ce que WoW reçoit de chaque bouton. **Copier un rapport** : un texte à envoyer à l'auteur (manette choisie, touche et mode de chaque bouton, ce que WoW en a reçu, version du jeu ; ni nom de personnage ni royaume), pour confirmer les préréglages des manettes non testées. |
| **Aide** | Les textes du tutoriel (pour la manette choisie), et un bouton pour le relancer. |

**État des actions sur le HUD** : les actions de l'addon s'affichent comme sur les barres du jeu. Elles sont rouges hors de portée de la cible, bleues sans assez de ressource (mana, énergie…) et grises si elles sont inutilisables. Le bord est doré pendant un proc, les charges restantes s'affichent, et la case s'allume pendant une action en cours (attaque automatique, forme…). Une information que le jeu rend secrète n'est pas affichée (la case reste normale).

**Ordre des miniatures du HUD** : dans l'onglet HUD, les flèches montent ou descendent une couche ; sur le HUD, on peut aussi glisser une miniature sur une autre (hors combat). « Ordre d'origine » remet l'ordre de l'interface. Une couche ajoutée plus tard (nouveau modificateur, paire cochée) se place après sa voisine habituelle ; une couche retirée garde sa place pour son retour. L'ordre fait partie des réglages du HUD (export / import compris).

**La couche « Seul »** (rien de maintenu) accepte tout :
- Un sort, un objet, une monture ou une macro de la liste va dans la barre du jeu, comme avec son éditeur.
- Une macro écrite à la main, une commande WoW ou un ensemble d'équipement va dans une couche de l'addon, qui ne prend que les cases remplies. Les autres restent au jeu.
- **A, B, X et Y** gardent les actions du jeu (sauter, interagir…) tant qu'on n'y met rien. Une action posée dessus les remplace, et vider la case rend l'action du jeu.

**Actions de base** (menu d'une case, « Action de base… ») : les actions de Forever sur A/B/X/Y, à poser où on veut. Une action posée par l'addon reste en place même quand Forever change le rôle d'un bouton selon le contexte (X qui devient « interagir » près d'un PNJ). Elles sont refaites avec le jeu :

| Action | Ce qu'elle fait |
|---|---|
| Sauter | commande WoW « Sauter » |
| Annuler (sort, cible) | `/stopcasting`, `/stopspelltarget`, `/cleartarget` (dans une fenêtre de Forever, B garde son rôle et ferme la fenêtre) |
| Rechercher (clic droit sur la cible) | commande WoW « Interagir avec la cible » |
| Attaque automatique | `/startattack` |
| Interagir | commande WoW « Interagir avec la cible » |

Les couches LT, RT et LT + RT de la barre du jeu n'acceptent que ce que la barre du jeu sait tenir. Pour y mettre des macros écrites ou des commandes WoW, il faut donner LT / RT à l'addon (voir [Boutons de base](#boutons-de-base-lt-rt-lb-rb)) ; le menu d'une case l'indique.

La manette, les touches et les modes sont enregistrés pour tout le compte, dans le profil utilisé. Les actions sont enregistrées **par personnage et par spécialisation**, dans ce même profil. Comme les barres du jeu, chaque spé (ou chaque groupe de talents d'une double spécialisation) a ses actions. Une spé jamais jouée commence avec une copie des actions de la précédente, et un message le dit au changement. L'export et `/mgir reset` concernent la spé active.

Changer de manette (dans un profil) remet les noms et les modes conseillés de la nouvelle manette. Les touches et les actions de ses boutons restent. Un bouton de l'ancienne manette qui n'existe pas sur la nouvelle est vidé et désactivé.

## Modes de ciblage

Un bouton (L5, R5… ou un bouton de base) peut être en **Cible alliée** ou **Cible ennemie**, comme LB / RB dans Forever :
- **appui bref** : cible l'allié (ou l'ennemi) le plus proche ;
- **maintenu + stick droit** : vise la cible voulue (le ciblage du moteur du jeu, `C_GamepadTargeting`) ;
- **maintenu + A / B / X / Y / croix** : ses 8 raccourcis, comme un modificateur. Un raccourci lancé pendant l'appui empêche le reciblage au relâchement.

Si tu vises avec le stick puis relâches sans lancer de raccourci, le relâchement cible à nouveau le plus proche.

## Boutons de base (LT, RT, LB, RB)

Dans l'onglet **Boutons**, le bloc **Boutons de base** donne à chacun de LT, RT, LB et RB un mode, enregistré dans le profil : **Modificateur**, **Cible alliée**, **Cible ennemie** ou **Bouton simple**, comme les boutons supplémentaires.
- **Par défaut, comme dans le jeu** (libellé en vert) : LT et RT en Modificateur, LB en Cible alliée, RB en Cible ennemie (ciblage comme dans Forever, plus une couche de raccourcis). C'est le cas pour un nouveau profil, au choix d'une manette et avec « Prendre les types conseillés ». Il n'y a pas de case « Jeu » : les modes par défaut font comme le jeu.
- Les cases vides d'un modificateur ou d'une cible ne font rien. Les boutons de base forment des paires avec n'importe quel autre modificateur (LT + RT, LB + RB, L5 + LT...), à cocher dans l'onglet Boutons.

Quand LT ou RT devient modificateur (ou cible), les couches de l'addon encore vides reprennent une fois, pour chaque personnage, ce que la barre du jeu avait sur LT, RT et LT + RT.

**Imitation de Maj / Ctrl.** Chez Forever, LT imite Maj et LB imite Ctrl (`GamePadEmulateShift`, `GamePadEmulateCtrl`). Un bouton qui imite une touche n'envoie son appui que s'il est tapé brièvement, et l'état Ctrl de LB déclenche le ciblage de Forever. Tant qu'un tel bouton est donné à l'addon, l'addon coupe son imitation ; il la remet avec `/mgir restore`. Le réglage d'origine est noté dans les réglages du compte. **À chaque déconnexion** (et à chaque `/reload`), l'addon remet les imitations dans les réglages du jeu, puis les recoupe à la connexion : désactiver l'addon ne laisse donc pas LT ou LB sans leur rôle. `/mgir restore` reste utile pour rendre tout de suite les boutons de base au jeu.

Ces liaisons n'existent que quand le jeu a le focus manette. Dans les fenêtres de Forever (sacs, carte…), LT, RT, LB et RB gardent leur rôle, et RB garde son clic droit avec le curseur.

## Profils

Un **profil** contient une manette, ses boutons (touches, modes, noms) et, pour chaque personnage, ses actions. Pratique avec plusieurs manettes : un profil « G7 Pro », un profil « DualSense Edge »…

- **Un seul profil utilisé à la fois, pour tout le compte.** On en change à la main, dans l'onglet **Profils** (bouton « Utiliser ce profil » ou double-clic) ou avec `/mgir profil <nom>`. WoW ne sait pas quelle manette est branchée, l'addon ne peut donc pas changer de profil tout seul. Impossible en combat.
- **Retenir le profil de chaque personnage** (case de l'onglet Profils, décochée par défaut) : à sa connexion, chaque personnage reprend le dernier profil qu'il a utilisé, au lieu du dernier utilisé sur le compte. Pratique quand un personnage est toujours joué avec la même manette.
- **Nouveau** : choisir la manette, puis le nom. Le profil est créé avec les modes conseillés, sans touche, et devient le profil utilisé : il reste à détecter ses touches dans l'onglet Boutons.
- **Copier** reprend la manette, les boutons et les actions **du personnage connecté**. Les autres personnages commencent ce profil sans actions.
- **Supprimer** efface aussi les actions de tous les personnages pour ce profil. Le dernier profil ne peut pas être supprimé.
- Le **HUD** et le bouton de la minimap sont communs à tous les profils.

### Exporter, importer

**Exporter** produit une ligne de texte à copier (Ctrl+C) et à coller où on veut : à un ami sur Discord, ou dans un fichier pour un autre PC. Deux cases :
- **Inclure les actions de ce personnage** (cochée par défaut). Les sorts ne servent qu'à la même classe ; les macros de la liste du jeu ne voyagent que par leur nom.
- **Inclure les réglages du HUD** (décochée par défaut).

**Importer** : coller la ligne (Ctrl+V). Un résumé s'affiche : manette, boutons avec touche, nombre d'actions, HUD. Les **macros écrites à la main** et les **commandes WoW** sont listées, pour les vérifier avant de s'en servir. Ensuite, au choix :
- **Nouveau profil** (nom proposé) : il devient le profil utilisé ;
- **Remplacer** un profil existant, après confirmation. Si on n'importe pas les actions, celles du profil remplacé restent.

Les actions importées vont au personnage connecté. Les réglages du HUD ne s'appliquent que si la case est cochée.

La ligne commence par `!MGIR1!`, avec une somme de contrôle qui repère une copie incomplète. Elle n'est jamais exécutée : l'addon la lit et ne garde que ce qu'il connaît (manettes, emplacements, modes, touches, types d'action, commandes WoW existantes, macros de 255 caractères au plus).

## Commandes

| Commande | Effet |
|---|---|
| `/mgir` (ou l'ancien `/gps`) | Ouvrir / fermer la fenêtre |
| `/mgir profil <nom>` (ou `profile`) | Utiliser le profil de ce nom |
| `/mgir profils` (ou `profiles`) | Ouvrir l'onglet Profils |
| `/mgir test` | Ouvrir l'onglet Test manette |
| `/mgir tuto` | Revoir le tutoriel |
| `/mgir news` (ou `nouveautes`) | Revoir les nouveautés (la fenêtre s'ouvre seule une fois après chaque mise à jour) |
| `/mgir hud` | Déverrouiller / verrouiller le HUD pour le déplacer à la souris |
| `/mgir hud scale 1.2` | Taille du HUD (0.5 à 2) |
| `/mgir hud off` / `on` | Revenir à la barre manette du jeu / réafficher le HUD |
| `/mgir hud strip` | Miniatures des couches sous le HUD (par défaut) ou au-dessus (aussi dans le tutoriel) |
| `/mgir minimap` | Masquer / remontrer le bouton autour de la minimap |
| `/mgir hud reset` | Remettre le HUD à sa place et à sa taille d'origine |
| `/mgir reset` | Vider les actions du personnage courant (dans le profil utilisé) |
| `/mgir restore` | Rendre LT, RT, LB, RB au jeu et remettre leur imitation de Maj / Ctrl (plus nécessaire avant de désactiver l'addon : c'est fait à chaque déconnexion) |
| `/mgir etat` (ou `state`) | Afficher dans le chat l'état des couches (boutons tenus, barre active de Forever, liaisons de A, LT, RT, LB, RB), à taper quand une couche semble bloquée. Les derniers changements d'état sont aussi gardés dans `MyGamepadIsRichDB.diagLog` (écrit au `/reload`), pour un rapport de bug |
| `/mgir selftest` | Outil de développement : vérifie l'export / import (aller-retour du profil utilisé, chaînes abîmées ou forgées) |

Un raccourci « Ouvrir la configuration » existe aussi dans Options › Raccourcis › AddOns, ainsi qu'une page dans Options › AddOns.

## Fonctionnement technique

- **Emplacements** : six emplacements internes fixes (`L5 R5 L4 R4 EX1 EX2`, gardés pour les données sauvegardées). La manette choisie nomme les premiers ; les autres restent des emplacements libres (« Bouton 5 »…).
- **Modificateur** : la touche du bouton est liée à un gestionnaire sécurisé (`SecureHandlerClickTemplate`). À l'appui, son code (environnement restreint, autorisé en combat) lie A/B/X/Y/croix à des boutons d'action sécurisés, avec priorité sur la barre croisée du jeu. Au relâchement, il retire ces liaisons. Les combinaisons ne s'activent que si aucune fenêtre manette de Forever (sacs, carte…) n'a le focus.
- **Bouton simple** : un `SecureActionButtonTemplate` lit LT/RT avec `GetGamePadState()` au moment du clic et choisit la couche.
- Les actions passent par des macros sécurisées (`/cast`, `/use`, `/equipset`, ou une macro du jeu). Une **commande WoW** est liée directement à la touche.
- Les changements de configuration faits en combat sont appliqués à la fin du combat (règle de WoW).
- **Couches bloquées** : les boutons de base donnés à l'addon ne changent pas de propriétaire (addon / fenêtre de Forever) tant qu'ils sont enfoncés, et un bouton noté tenu alors qu'il est relâché sur la manette est libéré. Si Forever reste sur sa barre LT / RT sans rien de tenu, l'addon lui rend ces boutons le temps d'un appui (un message le dit) pour qu'il revienne sur « Seul ». Ces boutons sont repris au début d'un combat, pour que leurs couches de l'addon restent disponibles.
- **Barre de Forever et `ACTIONBAR_SLOT_CHANGED`** : à chaque changement d'une case d'action (un sceau de paladin, une forme…), Forever relit l'état réel des gâchettes et passe sur sa barre LT / RT si l'une est tenue, même quand elle est à l'addon. Il ne voit pas le relâchement et reste alors sur cette barre jusqu'au prochain événement (par exemple un appui sur A). Tant que LT ou RT est à l'addon, sa barre est donc désabonnée de cet événement (hors combat, réaffirmé régulièrement), puis réabonnée quand ils reviennent au jeu.

## Limites connues

- Une **commande WoW** ne peut pas être sur une couche LT/RT, ni sur la couche « Seul » d'un bouton qui a des couches LT/RT. En mode Modificateur, elle marche partout.
- Avec deux modificateurs maintenus en même temps, c'est le dernier pressé qui l'emporte, sauf s'ils forment une paire cochée : leur couche de paire s'active (avec trois tenus ou plus : le dernier pressé et le plus récent des autres qui fait paire avec lui).
- **LB + LT et RB + RT déclenchent toujours l'action de classe de Forever** (souvent une roue de sorts, par exemple chez le paladin), même quand ces boutons appartiennent à l'addon : Forever détecte lui-même ces deux boutons tenus ensemble, par un chemin interne que l'addon ne peut pas intercepter. La roue prend la main sur A, B, X et Y tant qu'elle est ouverte (B pour la fermer). Ces deux paires restent cochables, mais l'addon prévient partout (onglet Boutons, onglet Actions, chat, tutoriel, options) : mieux vaut choisir d'autres paires. Pendant une paire, l'addon n'allume plus le ciblage du moteur (la visée au stick d'un bouton de ciblage), pour ne pas s'en mêler.
- Si Forever bascule l'interface en mode clavier/souris quand une palette envoie une touche, merci de le signaler : une option pourra forcer le style manette.
- Improved Forever peut aussi poser des liaisons sur certaines touches. En cas de conflit, c'est la dernière liaison appliquée qui gagne.

## Fichiers

```
MyGamepadIsRich/
  MyGamepadIsRich.toc   métadonnées (interface 16001+)
  Bindings.xml            raccourci « Ouvrir la configuration »
  Locales/                un fichier par langue du client (enUS, frFR, deDE, esES/esMX,
                          itIT, ptBR, ruRU, koKR, zhCN, zhTW), l'anglais en repli
  Controllers.lua         préréglages des manettes (noms des boutons, logiciel, modes conseillés)
  Core.lua                données, application des liaisons, slash
  Profiles.lua            profils : migration, changement, création, copie, suppression, import
  Serialize.lua           export / import en texte (sérialiseur sans exécution, base64, contrôle)
  Actions.lua             actions (curseur -> macro sécurisée)
  Focus.lua               focus manette de Forever
  Modifier.lua            mode Modificateur
  Simple.lua              mode Bouton simple (couches LT/RT)
  Learn.lua               « Détecter »
  Bar.lua                 lecture / écriture de la barre manette du jeu
  Diag.lua                /mgir etat
  Probe.lua               relevés de développement (/mgir probe) : hors du .toc
                          publié, à y ajouter après Diag.lua pour s'en servir
  UI/                     icônes, emplacements, menus, test, tutoriel, fenêtre,
                          onglet Profils (ProfilesTab.lua), nouveautés (WhatsNew.lua)
```
