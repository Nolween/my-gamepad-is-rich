# My Gamepad Is Rich — addon WoW Forever

Support des boutons supplémentaires des manettes (palettes arrière, gâchettes ou boutons en plus) dans World of Warcraft Forever :

- jusqu'à **6 boutons supplémentaires**, nommés selon la manette choisie (L5 / R5 / L4 / R4 d'une GameSir G7 Pro, P1 à P4 d'une Xbox Elite…) ; les emplacements que la manette n'utilise pas restent libres ;
- chaque bouton peut être :
  - **Modificateur** — maintenu, comme LT/RT : bouton + A / B / X / Y / croix = 8 nouvelles combinaisons ;
  - **Bouton simple** — une action, une autre avec LT maintenu, une autre avec RT maintenu (une couche vide reprend l'action « Seul ») ;
  - **Désactivé**.
- **Paires** : les boutons vont par deux (gauche + droite : emplacements 1 + 2, 3 + 4, 5 + 6). Quand les deux sont des modificateurs, les maintenir ensemble donne 8 combinaisons de plus, comme LT + RT.
- **Gâchettes LT / RT** (au choix, par profil) : elles peuvent devenir des modificateurs de l'addon, qui remplacent les couches LT, RT et LT + RT de la barre manette du jeu. Voir [Gâchettes LT / RT](#gâchettes-lt--rt).
- Interface en glisser-déposer (sorts, objets, macros, montures, jouets, ensembles d'équipement, macro écrite à la main, commande WoW).
- Fonctionne en combat.

## Manettes prévues

Le choix se fait dans le tutoriel ou dans l'onglet **Boutons** (« Changer… »). Une manette fixe les noms de ses boutons (renommables), les modes conseillés et le logiciel indiqué dans le tutoriel.

| Manette | Boutons | Logiciel pour leur donner une touche clavier |
|---|---|---|
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

Au premier lancement, un **tutoriel** s'ouvre et guide ces étapes : choix de la manette, logiciel à utiliser, détection des boutons et choix des modes directement dans la fenêtre. On peut le revoir avec `/mgir tuto` ou depuis l'onglet Aide.

La fenêtre (`/mgir` ou le bouton de la minimap) est organisée par tâche :

| Onglet | Rôle |
|---|---|
| **Actions** | Chaque couche, disposée comme la manette (croix à gauche, A/B/X/Y à droite) : la **barre manette** du jeu (Seul, LT, RT, LT+RT), les **modificateurs** et les **paires**, les **boutons simples**. Glisser un sort / objet / macro / monture sur une case, clic : menu, clic droit : vider. |
| **Boutons** | La manette (« Changer… »). Pour chaque bouton supplémentaire : nom, touche (**Détecter**), mode. État des paires. |
| **Profils** | Les profils (un par manette, par exemple) : utiliser, créer, copier, renommer, supprimer, exporter, importer. |
| **HUD** | Afficher le HUD, miniatures en bas / en haut, taille, déplacer, bouton de la minimap. |
| **Test manette** | Ce que WoW reçoit de chaque bouton. |
| **Aide** | Les textes du tutoriel (pour la manette choisie), et un bouton pour le relancer. |

**La couche « Seul »** (rien de maintenu) accepte tout :
- Un sort, un objet, une monture ou une macro de la liste va dans la barre du jeu, comme avec son éditeur.
- Une macro écrite à la main, une commande WoW ou un ensemble d'équipement va dans une couche de l'addon, qui ne prend que les cases remplies. Les autres restent au jeu.
- **A, B, X et Y** gardent les actions du jeu (sauter, interagir…) tant qu'on n'y met rien. Une action posée dessus les remplace, et vider la case rend l'action du jeu.

Les couches LT, RT et LT + RT de la barre du jeu n'acceptent que ce que la barre du jeu sait tenir. Pour y mettre des macros écrites ou des commandes WoW, il faut passer les gâchettes en « Modificateurs de l'addon » (voir plus bas) ; le menu d'une case l'indique.

La manette, les touches et les modes sont enregistrés pour tout le compte, dans le profil utilisé. Les actions sont enregistrées **par personnage**, dans ce même profil.

Changer de manette (dans un profil) remet les noms et les modes conseillés de la nouvelle manette. Les touches et les actions de ses boutons restent. Un bouton de l'ancienne manette qui n'existe pas sur la nouvelle est vidé et désactivé.

## Gâchettes LT / RT

Dans l'onglet **Boutons**, la ligne **Gâchettes LT / RT** propose deux choix, enregistrés dans le profil :

- **Couches du jeu** (par défaut) : LT et RT gardent les couches de la barre manette de Forever. On les remplit depuis l'onglet Actions, avec ce que la barre du jeu accepte (sorts, objets, montures, macros de la liste).
- **Modificateurs de l'addon** : LT, RT et LT + RT deviennent des couches de l'addon, comme L5. Maintenir LT puis appuyer sur A lance l'action de l'addon, avec tout ce qu'il permet (macros écrites à la main, commandes WoW, ensembles d'équipement). Elles remplacent les couches LT, RT et LT + RT de la barre du jeu ; une case vide ne fait rien. Ce ne sont jamais des boutons simples.

En passant aux modificateurs de l'addon, les couches de l'addon encore vides reprennent ce que la barre du jeu avait sur LT, RT et LT + RT. Rien n'est perdu, et revenir aux couches du jeu les retrouve telles quelles.

**LB et RB ne sont jamais touchés** (ciblage).

Technique : l'addon suit les réglages de manette du jeu.
- Une gâchette qui **imite une touche** (`GamePadEmulateShift = PADLTRIGGER`, le réglage de Forever pour LT) est liée en accord : LT + A = `SHIFT-PAD1`.
- Une gâchette qui **n'imite rien** (RT chez Forever) a sa touche reprise par un gestionnaire, comme la touche de L5.

Ces liaisons n'existent que quand le jeu a le focus manette : dans les fenêtres de Forever (sacs, carte…), les gâchettes gardent leur rôle.

## Profils

Un **profil** contient une manette, ses boutons (touches, modes, noms) et, pour chaque personnage, ses actions. Pratique avec plusieurs manettes : un profil « G7 Pro », un profil « DualSense Edge »…

- **Un seul profil utilisé à la fois, pour tout le compte.** On en change à la main, dans l'onglet **Profils** (bouton « Utiliser ce profil » ou double-clic) ou avec `/mgir profil <nom>`. WoW ne sait pas quelle manette est branchée, l'addon ne peut donc pas changer de profil tout seul. Impossible en combat.
- **Nouveau** : choisir la manette, puis le nom. Le profil est créé avec les modes conseillés, sans touche, et devient le profil utilisé : il reste à détecter ses touches dans l'onglet Boutons.
- **Copier** reprend la manette, les boutons et les actions **du personnage connecté**. Les autres personnages commencent ce profil sans actions.
- **Supprimer** efface aussi les actions de tous les personnages pour ce profil. Le dernier profil ne peut pas être supprimé.
- Le **HUD** et le bouton de la minimap sont communs à tous les profils.

À la mise à jour depuis la 1.3, la configuration existante devient un premier profil, nommé d'après la manette. Chaque personnage y retrouve ses actions.

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
| `/mgir hud` | Déverrouiller / verrouiller le HUD pour le déplacer à la souris |
| `/mgir hud scale 1.2` | Taille du HUD (0.5 à 2) |
| `/mgir hud off` / `on` | Revenir à la barre manette du jeu / réafficher le HUD |
| `/mgir hud strip` | Miniatures des couches sous le HUD (par défaut) ou au-dessus (aussi dans le tutoriel) |
| `/mgir minimap` | Masquer / remontrer le bouton autour de la minimap |
| `/mgir hud reset` | Remettre le HUD à sa place et à sa taille d'origine |
| `/mgir reset` | Vider les actions du personnage courant (dans le profil utilisé) |
| `/mgir selftest` | Outil de développement : vérifie l'export / import (aller-retour du profil utilisé, chaînes abîmées ou forgées) |

Un raccourci « Ouvrir la configuration » existe aussi dans Options › Raccourcis › AddOns, ainsi qu'une page dans Options › AddOns.

## Fonctionnement technique

- **Emplacements** : six emplacements internes fixes (`L5 R5 L4 R4 EX1 EX2`, gardés pour les données sauvegardées). La manette choisie nomme les premiers ; les autres restent des emplacements libres (« Bouton 5 »…).
- **Modificateur** : la touche du bouton est liée à un gestionnaire sécurisé (`SecureHandlerClickTemplate`). À l'appui, son code (environnement restreint, autorisé en combat) lie A/B/X/Y/croix à des boutons d'action sécurisés, avec priorité sur la barre croisée du jeu. Au relâchement, il retire ces liaisons. Les combinaisons ne s'activent que si aucune fenêtre manette de Forever (sacs, carte…) n'a le focus.
- **Bouton simple** : un `SecureActionButtonTemplate` lit LT/RT avec `GetGamePadState()` au moment du clic et choisit la couche.
- Les actions passent par des macros sécurisées (`/cast`, `/use`, `/equipset`, ou une macro du jeu). Une **commande WoW** est liée directement à la touche.
- Les changements de configuration faits en combat sont appliqués à la fin du combat (règle de WoW).

## Limites connues

- Une **commande WoW** ne peut pas être sur une couche LT/RT, ni sur la couche « Seul » d'un bouton qui a des couches LT/RT. En mode Modificateur, elle marche partout.
- Avec deux modificateurs maintenus en même temps, c'est le dernier pressé qui l'emporte, sauf s'ils forment une paire : leur couche de paire s'active.
- Quand LT / RT sont des modificateurs de l'addon, Forever ne reçoit plus l'appui sur RT en jeu. Ce qu'il fait lui-même avec RT (par exemple une action de classe sur RB + RT) peut ne plus répondre : il suffit de repasser aux couches du jeu.
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
  UI/                     icônes, emplacements, menus, test, tutoriel, fenêtre,
                          onglet Profils (ProfilesTab.lua)
```
