


#' Import pantheria data
#'
#' @return A 2 columns tibble linking species IDs to ecoregions IDs
#' @export
#' @importFrom readr read_csv
#' @importFrom here here
#'
data_pantheria   <- function() {
  readr::read_delim(
    here::here("data","pantheria-traits","PanTHERIA_1-0_WR05_Aug2008.txt"),
    delim = "\t")
}
