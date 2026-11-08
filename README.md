# My Gamepad Is Rich — addon WoW Forever

Support des boutons supplémentaires de la **GameSir G7 Pro** dans World of Warcraft Forever :

- **L5 / R5** (3es gâchettes) et **L4 / R4** (palettes arrière), plus 2 emplacements libres ;
- chaque bouton peut être :
  - **Modificateur** — maintenu, comme LT/RT : bouton + A / B / X / Y / croix = 8 nouvelles combinaisons ;
  - **Bouton simple** — une action, une autre avec LT maintenu, une autre avec RT maintenu (une couche vide reprend l'action « Seul ») ;
  - **Désactivé**.
- **Paires** : quand L5 et R5 (ou L4 et R4) sont tous les deux des modificateurs, les maintenir ensemble donne 8 combinaisons de plus, comme LT + RT.
- Interface en glisser-déposer (sorts, objets, macros, montures, jouets, ensembles d'équipement, macro écrite à la main, commande WoW).
- Fonctionne en combat.

## Pourquoi WoW ne voit pas ces boutons

Windows voit la G7 Pro comme une manette **Xbox 360 (XInput)** : `USB\VID_3537&PID_100A`, pilote `xusb22`.
Le protocole XInput ne transporte que les boutons Xbox standard (A B X Y, LB RB, LT RT, L3 R3, croix, View, Menu).
Les L5/R5/L4/R4 n'y existent pas, donc **aucun addon ne peut les lire directement**.
La solution : les programmer dans **GameSir Nexus** pour qu'ils envoient une **touche clavier**. L'addon apprend ensuite cette touche.

## Installation

1. Copier le dossier `MyGamepadIsRich` dans
   `K:\World of Warcraft\_forever_\Interface\AddOns\`.
   Pour développer, mieux vaut une jonction : le jeu lit alors directement ce dossier.
   ```bat
   mklink /J "K:\World of Warcraft\_forever_\Interface\AddOns\MyGamepadIsRich" "G:\Addons Wow Dev\GamesirPadSupport\MyGamepadIsRich"
   ```
2. Lancer WoW Forever et activer **My Gamepad Is Rich** dans la liste des addons.

## Étape 1 — GameSir Nexus (une seule fois)

1. Brancher la manette et ouvrir **GameSir Nexus**.
2. Ouvrir la configuration des boutons (mapping / profil).
3. Assigner une touche clavier inutilisée à chaque bouton, par exemple :

   | Bouton | Touche conseillée |
   |---|---|
   | L5 | F9 |
   | R5 | F10 |
   | L4 | F11 |
   | R4 | F12 |

   Éviter **Maj / Ctrl / Alt** : elles modifieraient les autres raccourcis.
4. Enregistrer le profil sur la manette.

## Étape 2 — Dans WoW

Au premier lancement, un **tutoriel** s'ouvre et guide ces étapes (détection des boutons et choix des modes directement dans la fenêtre). On peut le revoir avec `/mgir tuto` ou depuis l'onglet Aide.

La fenêtre (`/mgir` ou le bouton de la minimap) est organisée par tâche :

| Onglet | Rôle |
|---|---|
| **Actions** | Chaque couche, disposée comme la manette (croix à gauche, A/B/X/Y à droite) : la **barre manette** du jeu (Seul, LT, RT, LT+RT), les **modificateurs** et les **paires** (L5, R5, L4, R4, L5+R5, L4+R4), les **boutons simples**. Glisser un sort / objet / macro / monture sur une case, clic : menu, clic droit : vider. |
| **Boutons** | Pour chaque bouton supplémentaire : nom, touche (**Détecter**), mode. État des paires. |
| **HUD** | Afficher le HUD, miniatures en bas / en haut, taille, déplacer, bouton de la minimap. |
| **Test manette** | Ce que WoW reçoit de chaque bouton. |
| **Aide** | Les textes du tutoriel, et un bouton pour le relancer. |

Sur la barre manette du jeu, A/B/X/Y sans rien maintenir gardent les actions du jeu (sauter, interagir…) ; ses cases n'acceptent que des sorts, objets, montures et macros de la liste des macros (pas de macro écrite à la main ni de commande WoW).

Les touches et les modes sont enregistrés pour tout le compte. Les actions sont enregistrées **par personnage**.

## Commandes

| Commande | Effet |
|---|---|
| `/mgir` (ou l'ancien `/gps`) | Ouvrir / fermer la fenêtre |
| `/mgir test` | Ouvrir l'onglet Test manette |
| `/mgir tuto` | Revoir le tutoriel |
| `/mgir hud` | Déverrouiller / verrouiller le HUD pour le déplacer à la souris |
| `/mgir hud scale 1.2` | Taille du HUD (0.5 à 2) |
| `/mgir hud off` / `on` | Revenir à la barre manette du jeu / réafficher le HUD |
| `/mgir hud strip` | Miniatures des couches sous le HUD (par défaut) ou au-dessus (aussi dans le tutoriel) |
| `/mgir minimap` | Masquer / remontrer le bouton autour de la minimap |
| `/mgir hud reset` | Remettre le HUD à sa place et à sa taille d'origine |
| `/mgir reset` | Vider les actions du personnage courant |

Un raccourci « Ouvrir la configuration » existe aussi dans Options › Raccourcis › AddOns, ainsi qu'une page dans Options › AddOns.

## Fonctionnement technique

- **Modificateur** : la touche du bouton est liée à un gestionnaire sécurisé (`SecureHandlerClickTemplate`). À l'appui, son code (environnement restreint, autorisé en combat) lie A/B/X/Y/croix à des boutons d'action sécurisés, avec priorité sur la barre croisée du jeu. Au relâchement, il retire ces liaisons. Les combinaisons ne s'activent que si aucune fenêtre manette de Forever (sacs, carte…) n'a le focus.
- **Bouton simple** : un `SecureActionButtonTemplate` lit LT/RT avec `GetGamePadState()` au moment du clic et choisit la couche.
- Les actions passent par des macros sécurisées (`/cast`, `/use`, `/equipset`, ou une macro du jeu). Une **commande WoW** est liée directement à la touche.
- Les changements de configuration faits en combat sont appliqués à la fin du combat (règle de WoW).

## Limites connues

- Une **commande WoW** ne peut pas être sur une couche LT/RT, ni sur la couche « Seul » d'un bouton qui a des couches LT/RT. En mode Modificateur, elle marche partout.
- Avec deux modificateurs maintenus en même temps, c'est le dernier pressé qui l'emporte, sauf s'ils forment une paire (L5 + R5, L4 + R4) : leur couche de paire s'active.
- Si Forever bascule l'interface en mode clavier/souris quand une palette envoie une touche, merci de le signaler : une option pourra forcer le style manette.
- Improved Forever peut aussi poser des liaisons sur certaines touches. En cas de conflit, c'est la dernière liaison appliquée qui gagne.

## Fichiers

```
MyGamepadIsRich/
  MyGamepadIsRich.toc   métadonnées (interface 16001+)
  Bindings.xml            raccourci « Ouvrir la configuration »
  Locales/                un fichier par langue du client (enUS, frFR, deDE, esES/esMX,
                          itIT, ptBR, ruRU, koKR, zhCN, zhTW), l'anglais en repli
  Core.lua                données, application des liaisons, slash
  Actions.lua             actions (curseur -> macro sécurisée)
  Focus.lua               focus manette de Forever
  Modifier.lua            mode Modificateur
  Simple.lua              mode Bouton simple (couches LT/RT)
  Learn.lua               « Détecter »
  Bar.lua                 lecture / écriture de la barre manette du jeu
  UI/                     icônes, emplacements, menus, test, tutoriel, fenêtre
```
