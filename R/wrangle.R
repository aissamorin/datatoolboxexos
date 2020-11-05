

#

#' Get cleaned data pantheria
#'
#' @param datapantheria data from pantheria database obtain with the function datapantheria.R
#'
#' @return
#' @export
#'
#' @examples
clean_pantheria <- function(datapantheria){

  ### clean pantheria data based on ggplot2 exercices
pantheria_clean <- datapantheria %>%
  dplyr::mutate(order = forcats::as_factor(MSW05_Order),
         family = forcats::as_factor(MSW05_Family)) %>%
  dplyr::rename( adult_bodymass  = '5-1_AdultBodyMass_g',
          dispersal_age  = '7-1_DispersalAge_d',
          gestation = '9-1_GestationLen_d',
          homerange = '22-2_HomeRange_Indiv_km2',
          litter_size = '16-1_LittersPerYear',
          longevity = '17-1_MaxLongevity_m') %>%
  dplyr::select(order, family, adult_bodymass, dispersal_age, gestation,homerange,litter_size,longevity ) %>%
  dplyr::na_if(-999 )


return(pantheria_clean)
}

#' To extract usrus data
#'
#' @param sp The data containing all species i.e. sp_list obtain with data_mammals() function
#'
#' @return
#' @export
#'
#' @examples
extract_ursidae <- function(sp){
ursus <- sp %>%
  dplyr::filter(family   == "Ursidae") %>%                       # Sélection des Ursidés
  dplyr::filter(sci_name != "Ursus malayanus") %>%             # Suppression du synonyme
  dplyr::select(species_id, sci_name, common)                    # Sélection de colonnes
}


#' Join the three data set ursus species, mammals and ecoregion and ecoregion
#'
#' @param data1 ursus data obtained with extract_ursidae() function
#' @param data2 sp_eco data set linking species and eco region , obtained with data_mammals_ecoregions()
#' @param data3 eco_list list of eco_regions obtained with data_ecoregion() function
#'
#' @return
#' @export
#'
#' @examples
join_dataset <-function(data1, data2, data3 ){

data_temp <- data1 %>%
  dplyr::left_join(data2)

## Seconde jointure
data_set <- data_temp %>%
  dplyr::left_join(data3, by = "ecoregion_id")

return(data_set)
}

#' Get the number of ecoregion per ursidae species
#'
#' @param data ursus_eco obained with join_dataset() function
#'
#' @return
#' @export
#'
#' @examples
get_nb_ecoreg <- function(data){

nb_ecoreg_ursidae <- data %>%
  dplyr::group_by(sci_name) %>%
  dplyr::summarise(n_ecoregions = dplyr::n_distinct(ecoregion))

return(nb_ecoreg_ursidae)
}
