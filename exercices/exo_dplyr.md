---
title: "Manipulation de données avec {dplyr}"
author: "Aissa Morin"
date: "2020-11-04"
output:
  html_document:
    keep_md: yes
---



# Introduction

Dans cet exercice nous allons utiliser le package `dplyr` pour nous instruire sur la biogéographie des ours.

# Données

On utilise la base [**WWF Wildfinder**](https://www.worldwildlife.org/pages/wildfinder-database)

La base de données WildFinder du WWF contient des données de présence/absence pour les amphibiens, reptiles, oiseaux et mammifères terrestres du monde entier au niveau des écorégions terrestres. Seul le sous-ensemble des mammifères est disponible dans ce dépôt avec 4936 espèces. Les données, préalablement nettoyées, sont structurées de la manière suivante dans le dossier `data/wwf-wildfinder/` :

  - `wildfinder-mammals_list.csv` : liste taxonomique des 4936 espèces de mammifères du monde entier
  - `wildfinder-ecoregions_list.csv` : liste des 798 écorégions terrestres définies par le WWF
  - `wildfinder-ecoregions_species.csv` : correspondances entre les espèces et les écorégions

# Analyses

## Exploration des données

- Histogramme de la distribution du nombre d'espèces de mammifères par écorégion.


```r
#read wildfinder-ecoregions_species.csv
sp_eco <- datatoolboxexos::data_mammals_ecoregions()

#tabulate the ecoregions
mam_per_eco <- table(sp_eco$ecoregion_id)

#histogram
hist(mam_per_eco,
     main = "Number of mammal species per ecoregion",
     breaks = 50
)
```

![](exo_dplyr_files/figure-html/explo_histo-1.png)<!-- -->

### Importation des données 


```r
sp_eco <- datatoolboxexos::data_mammals_ecoregions()
sp <- datatoolboxexos::data_mammals()
eco_reg <- datatoolboxexos::data_ecoregion()
```

_Dans combien de royaumes, biomes et écorégions différents retrouve-t-on chacune des 7 espèces d'Ursidés ?_


```r
require(tidyverse)

sp_ursus_list <-sp %>%
  dplyr::filter(family == "Ursidae") %>% # selectionne les espèces d'ursidés
  dplyr::filter(!str_detect(sci_name,'Ursus malayanus')) # remove Ursus malayanus
  
sp_ursus_sp_eco <- left_join(sp_ursus_list,sp_eco, by ="species_id" )  # jointure tables wildfinder-ursus_list et wildfinder-ecoregions_species

ursus_table <- left_join(sp_ursus_sp_eco, eco_reg, by = "ecoregion_id" ) #jointure  à wildfinder-ecoregions_list

ursus_table %>% 
  group_by(common, sci_name)%>%
  summarize(nb_realm =  n_distinct(realm),
            nb_biome = n_distinct(biome),
            nb_eco_reg = n_distinct(ecoregion_id)) %>%
  arrange(desc(nb_eco_reg))
```

```
## # A tibble: 7 x 5
## # Groups:   common [7]
##   common              sci_name               nb_realm nb_biome nb_eco_reg
##   <chr>               <chr>                     <int>    <int>      <int>
## 1 Brown Bear          Ursus arctos                  3       11        139
## 2 American Black Bear Ursus americanus              3       10         82
## 3 Asiatic Black Bear  Ursus thibetanus              3       11         79
## 4 Sun Bear            Helarctos malayanus           2        5         39
## 5 Spectacled Bear     Tremarctos ornatus            1        3         23
## 6 Sloth Bear          Melursus ursinus              1        6         21
## 7 Giant Panda         Ailuropoda melanoleuca        1        4          6
```

_Correction_


```r
ursus <- sp %>%
  filter(family   == "Ursidae") %>%                       # Sélection des Ursidés
  filter(sci_name != "Ursus malayanus") %>%             # Suppression du synonyme
  select(species_id, sci_name, common)                    # Sélection de colonnes

ursus_eco <- ursus %>%
  left_join(sp_eco)

## Seconde jointure
ursus_eco <- ursus_eco %>%
  left_join(eco_reg, by = "ecoregion_id")

## Nombre de royaumes où chaque espèce est retrouvée
realm_ursus <- ursus_eco %>%
  group_by(sci_name) %>%
  summarise(n_realms     = n_distinct(realm))

## Nombre de biomes où chaque espèce est retrouvée
biome_ursus <- ursus_eco %>%
  group_by(sci_name) %>%
  summarise(n_biomes     = n_distinct(biome))

## Nombre d'écorégions où chaque espèce est retrouvée
eco_ursus <- ursus_eco %>%
  group_by(sci_name) %>%
  summarise(n_ecoregions = n_distinct(ecoregion))

## Combinons toutes les informations
realm_ursus %>%
  left_join(biome_ursus, by = "sci_name") %>%
  left_join(eco_ursus, by = "sci_name") %>%
  left_join(ursus, by = "sci_name") %>%
  select(sci_name, common, n_realms, n_biomes, n_ecoregions) %>%
  arrange(desc(n_ecoregions))
```

```
## # A tibble: 7 x 5
##   sci_name               common              n_realms n_biomes n_ecoregions
##   <chr>                  <chr>                  <int>    <int>        <int>
## 1 Ursus arctos           Brown Bear                 3       11          139
## 2 Ursus americanus       American Black Bear        3       10           82
## 3 Ursus thibetanus       Asiatic Black Bear         3       11           78
## 4 Helarctos malayanus    Sun Bear                   2        5           37
## 5 Tremarctos ornatus     Spectacled Bear            1        3           23
## 6 Melursus ursinus       Sloth Bear                 1        6           21
## 7 Ailuropoda melanoleuca Giant Panda                1        4            6
```




