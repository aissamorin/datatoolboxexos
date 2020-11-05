

#' Get barplot of the number of ecoregions per species
#'
#' @param data_ursus_eco_reg dataset with both bears and eco_region data
#'
#' @return
#' @export
#'
#' @examples
barplot_ursus <- function(data_ursus_eco_reg){

  plot <- data_ursus_eco_reg %>% ggplot2::ggplot()+
    ggplot2::geom_col()+
    ggplot2::aes(forcats::fct_reorder(sci_name, n_ecoregions), x = n_ecoregions) +
    ggplot2::xlab("Number of ecoregions") +
    ggplot2::ylab("Species") +
    ggplot2::ggtitle("Number of ecoregions per species")

  return(plot)
  }


#' Get Gestation~longevity figure
#'
#' @param data cleaned pantheria data set used to draw the figure
#'
#' @return
#' @export
#'
#' @import ggplot2
#' @examples
gestation_longevity <- function(data){

 plot <-  data %>%
    ggplot()+
    aes(x = longevity,y= gestation,color = adult_bodymass)+
    geom_smooth()+
    geom_point(size = 5)+
    ylab("Gestation")+
    xlab("Longevity")+
    theme_bw()

  return(plot)

}


#' Plot saving
#'
#' @param plot ggplot2 object
#' @param name character
#' @param ext png, pdf, tiff,... (default is png)
#' @param width
#' @param height
#' @param ...
#'
#' @return
#' @export
#'
#' @import ggplot2
#' @examples
save_plot <- function(plot, name, ext = "png",
                      width = 8, height = 6,
                      ...) {

  # to save any plots
  ggplot2::ggsave(plot = plot,
                  filename = here::here("output", "plots", paste0(name, ".", ext)), # se sauvegarde dans le sous dossier plot du dossier output, prend le nom name.png (<=> ext)
                  width = width,
                  height = height,
                  ...)
}
