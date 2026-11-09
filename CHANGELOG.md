# Journal des versions — My Gamepad Is Rich

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
