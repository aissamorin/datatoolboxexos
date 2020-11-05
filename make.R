# #############################################################
#
#Data and Code for the CESAB Datatoolbox Exercises
#
#########################################################

############################################# RESEARCH COMPENDIUM ################################################# ##################################################################################################################

# ----- clean workspace
rm(list = ls())

# ----- install/update packages
devtools::install_deps() # Chargement des packages et dépendance, permet d'ajouter à la DESCRIPTION les nouveaux packages évventuels

# ----- install compendium package
#devtools::install(build = FALSE)
devtools::load_all()# pour rendre dispo toutes les fonctions dans le repertoire .R

# ----- Knit exo dplyr
rmarkdown::render(here::here("exercices","exo_dplyr.Rmd"))# emettre le rmarkdown pour l'exercice 1
rmarkdown::render(here::here("exercices","exo_ggplot2.Rmd"))

############################################## DRAKE ############################################################
###################################################################################################################

## Execute plan
drake::r_make() # Quand on a 1) mis a jour les fonctions 2) jointes les fonctions (ici wrangle.R ou plot.R) à plans 3) enregistré plans.R, 4 ) exécuté _drake.R
#(la premiere fois ? )va relancer ds une autre session R, pas de soucis avec ton espace de travail, il reconnait le _drake.R
#Normalement il crée la target

## Pour voir le graphe des dépendances
## Visualize
drake::r_vis_drake_graph(targets_only = TRUE)
drake::r_vis_drake_graph()

# Si je souhaite visualisé les différentes target créées, faire des analyses intermédiaires, etc...
# all in work environment
# drake::loadd(nb_eco_reg_ursus)
# drake::loadd(barplot1)
# drake::loadd(data_pantheria_cleaned)
#
# # look at specific target
# drake::readd(fig2)
# dans la console, ne doit pas s'éxécuter direct, si ?
