# SceneKitTutorialActionProject
Le projet pédagogique d'utilisation des actions de SceneKit pour OpenClassroom

Ce projet est un jeux simpliste aux graphismes style voxel qui pour l'instant n'a aucune mecanique et aucun but !

Voici les exercices a realiser :

1 - Creation du mouvement du personnage principale

	Situation:
		Une node de la scene qui a pour nom "hero" doit etre le personnage que nous controllons dans ce jeu.
		Les fonctions event[Up, Down, Left, Right] sont appellee lors-ce que la machine (iPhone ou Mac) recoit un certain evenement.

	Probleme:
		Lors de l'appelle aux fonctions d'events, notre personnage doit se deplacer dans la bonne direction selon la fonction appelee

	Solution:
		Utiliser des actions pour faire bouger la node du personnage


2 - Faire suivre les amis

	Situation:
		Un set de nodes "friends" est initialise lors du lancement du programme. Il contient les nodes de la scene qui doivent etre des personnages "amis" de notre hero.

	Probleme:
		Lors-ce que notre hero se deplace proche de l'un d'eux, ils doivent se mettre a le suivre en file indienne !

	Solution:
		Creer un tableau qui liste les amis qui nous suivent et un autre pour enregistrer les precedentes positions du hero. Utiliser des actions pour faire bouger les suiveurs un par un

3 - Gestion des collisions

	Situation:
		Les murs et les arbres n'ont aucun effets sur le deplacement du personnage

	Probleme:
		Se deplacer dans un obstacle doit etre impossible

	Solution:
		Utiliser des corps physique autour du personnage pour reveler les eventuels futures collisions
		Interdire les mouvements dans les directions detecte

4 - Disparition du feuillage

	Situation:
		Une des amies, appelee Raisy se trouve dans un jardin recouvert de feuillage opaque

	Probleme:
		Le materiel du feuillage doit devenir transparent lors-ce que le personnage entre dans la zone en dessous et retrouver son opacite lors-ce qu'il en sort

	Solution:
		Utiliser des corps physiques pour detecter l'entree et la sortie du hero
		Utiliser l'action de changement d'opacite pour modifier la transparence de la node du feuillage

5 - Escalader une echelle

	Situation:
		Une des amies appelee Knina se trouve dans une tour en elevation dont le acces est une echelle.

	Probleme:
		Lors-ce que le hero passe au pied de l'echelle, il doit automatiquement la monter et arriver en haut avec tout ses compagnons
		Lors-ce que le hero arrive dans la tour, le toit de la tour doit devenir transparent de la meme maniere que le feuillage

	Solution:
		Utiliser des corps physiques pour detecter la presence du hero au pied de l'echelle
		Ajouter une sous node vide qui sert de point cible a l'ascension de la tour
		Utiliser une action pour le deplacer jusqu'au point cible

6 - Sauter de la tour

	Situation:
		Si le personnage monte dans la tour, il peut se deplacer a cote des bords et rester en levitation

	Probleme:
		Lors-ce que le personnage saute a cote de la plateforme, il doit tomber jusqu'au sol en dessous

	Solution:
		Utiliser des corps physiques pour detecter la presence du personnage dans les airs autour de la tour
		Utiliser une action pour le faire tomber jusque sur le sol, lui et tout ses amis
