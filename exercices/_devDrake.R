#### DRAKE ####

## ETAPE 1 - Set_up ####
usethis::use_r(name = "wrangle.R") # accueilleras des fonctions d'analyse/nettoyage de données
usethis::use_r(name = "plots.R") # accueilleras des fonctions pour faire des plots
usethis::use_r(name = "plan.R") # accueilleras le plan
file.create("_drake.R")# important
#file.create("make.R") essayons de modifier celui que l'on a déjà
dir.create("output")# je créé un dossier "output"
#dir.create("text") #on peut aussi utiliser notre répertoire "exercices" ici ;)
dir.create("output/plots") # je crée un sous dossier plots dans le dossier outputs
dir.create("output/text")


##Etape 1.3 On ajoute les packages ####
# add needed packages
#(comme on a deja un research copendium, pas besoin de faire une fonction installation package)
# add needed packages
usethis::use_package("dplyr")
usethis::use_package("ggplot2")
usethis::use_package("magrittr")
usethis::use_package("forcats")
usethis::use_package("sf")
usethis::use_package("drake")

#----- Point particulier : package non installé sur la machine------####
#modification dans description fishualize car pas encore installé dur l'ordi (sinon on le fait via fonction install.packages)
#1)  Modification dans DESCRIPTION
#devtools::install_deps 2)
usethis::use_package("fishualize") #3)

##Etape 1.3 fichiers à ignorer ####
#>> pour ne pas s'encombrer de certains fichiers, pour pas le faire remonter sur git
# ignore files
usethis::use_build_ignore(".drake")
usethis::use_build_ignore("_drake.R")
usethis::use_build_ignore("make.R")
usethis::use_git_ignore(".drake")
usethis::use_build_ignore("output/")
usethis::use_build_ignore("text/")

## Chargement des données ####

# créer une  fonction pour creer un plan plan.R

#make.R
#Pour installer visNetwork
# 1) Ajout dans DESCRIPTION
#2) devtools::install_deps()
 usethis::use_package("visNetwork")#3)
# cf step one - cadre rouge des notes de la formation


