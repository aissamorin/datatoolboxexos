################################################################################################################# #
#
# Buiding research project according to the research copendium
#
###################################################################################################################

# ETAPE 1 ###
# La première étape : on forke le projet formation_datatoolbox ou importe le projet GITHUB vide prélablement créé

#ETAPE 2 ###
rrtools::use_compendium("../datatoolboxexos/", open = FALSE) # on remonte d'un niveau "../" , open = FALSE: pour pas ouvrir une nouvelle session

#2.1 édition fichier description ####
# modification du titre, du paragraphe des auteurs et de la description

# versionne

# ETAPE 3 ####
#création d'une première fonction
usethis::use_r("data_wildfinder")# créé un fichier R/data_wildfinder.R dans le répertoire R/ normalement
#Servira a abriter les fonctions pour lire les donnée wilfinder
#Suppose que les données sont dispos !

### Etape 3.1###
#Création de 3 fonctions pour lire chaque données wildfinder
# Renseignement des entête via Roxygen2

#base de la fonction créée:
#readr:: read_csv(here::here("data", "wwf-wildfinder", "wildfinder-ecoregions_list.csv"))
# on recommance cette étape pour les 3 fonctions

### Etape 3.2  - Ajout des dépendances###
# récupériation des package nécessaire

usethis::use_package("here")
usethis::use_package("readr")

# normalement après on  utilise devtools::install_deps() pour que les modifications dans DESCRIPTION soient prises en compte

#Versionning

#ETAPE 4 - Ajout d'un README au compendium ####

rrtools::use_readme_rmd()# créé un fichier README.Rmd à la racine du projet
# dans le README : à la fin du README.Rmd afficher les informations de votre session (utils::sessionInfo()

#ETAPE 5 ####
# Etape 5-1 ####
devtools::install_deps()# permet de charger les packages nécessaires  au bon déroulement de vos analyses (ainsi que leur dépendences) peuvent être installés ou mis à jour à l'aide de cette fonction

devtools::document()# pour fabriquer la doc (aide) des fonctions a partir des entetes de fonctions ( r-oxygen entete) (??nom_fonction()), a executer quand on modifie la description des dfonctions, i.e. le Roxygen ?
#ATTENTION a ne pas avoir les fonction dans l'env. global
#Crfé un fichier name
#crée un fichier NAMESPACE ?

#etape 5.2 ####

#Construire le package : tester la fonction/le package et construire la doc
# fenêtre de droite --> onglet build  --> « Install and restart »
# A ce stade, si on fait datatoolboxexos:: on retrouve nos 3 fonctions nouvellement créées

# Versionning

#etape 5.3 - check du package ####
devtools::check() #la documentation est reconstruite et beaucoup de vérifications de votre code sont effectuées lors de cette étape
#Si pas d'etteur normalement ok

#etape 5.4 - check du package ####
d<- datatoolboxexos::data_ecoregion() #  testez la fonction datatoolboxexos::data_ecoregion() -->j'ai changé le nom

# Versionning

#Etape 5.5 #####

devtools::load_all() #  a pour effet principal de charger tous les fichiers présents dans le répetoire R/
#Permet de ne pas checker et builder le package tout le temps quand en développement ( sauf pour le build initial ?)

#ETAPE 6 - Intégration d'un document dynamique Rmarkdown ####
#création du rmd/md etc...

#ETAPE 7 - Création du fichier make.R ####

# Création du fichier make

# Package supplémentaires nécessaires pour faire tourner ma fonction
usethis::use_pipe()# si je souhaite  utiliser la fonction dans mon projet
usethis::use_package("dplyr") # à faire pour tous les packages du tidyverse si je souhaite les utiliser dans mon projet
#devtools::install_deps()#Pour modifier la DESCRIPTION --> pas la peine de le faire ici, fait dans make.R
# puis on fait tourner devtools::load_all() dans le fichier make.R
#devtools::document()# pour modifier description ( sinon je peux modifier ça la la main) --> NON

