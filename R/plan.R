#' Write basic plan
#'
#' @return A drake plan
#' @export
#'
#' @importFrom drake drake_plan
#' @examples
write_plan <- function() {
  drake::drake_plan(
    # Load data
    eco_list = data_ecoregion(),
    sp_eco = data_mammals_ecoregions(),
    sp_list = data_mammals(),
    pantheria = data_pantheria(),
    #wrangling data
    data_pantheria_cleaned = clean_pantheria(pantheria),
    ursus = extract_ursidae(sp_list),
    ursus_eco = join_dataset(ursus,sp_eco,eco_list),
    nb_eco_reg_ursus = get_nb_ecoreg(ursus_eco),
    #Figures
    fig1 = barplot_ursus(nb_eco_reg_ursus),
    fig2= gestation_longevity(data_pantheria_cleaned),
    #fig3, à ajouter plus tard
    # output save figures function pour sauvegarder plot
    out_fig1 = save_plot(plot= fig1, name= "figure1_necoregions"),
    out_fig2 = save_plot(plot = fig2, name= "figure2_gestation"),
    # report
    report = rmarkdown::render(
        drake::knitr_in("output/text/ursus_drake.Rmd"),
      output_file = drake::file_out("output/text/ursus_drake.html"),
      quiet = FALSE,
      output_dir = "output/text/"
    )
  )
}

