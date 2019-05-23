globalVariables(c("EQ_PRIMARY", "TOTAL_DEATHS", "label_1", "label_2", "label_3",
                  "popup_text"))

#' @title Build interactive chart
#' @description
#' This function visualizes earthquakes on an interactive map. The function maps the
#' epicenters (LATITUDE/LONGITUDE) and annotates each point with in pop up window
#' containing annotation data stored in a column of the data frame.
#'
#' @param dt NOAA data frame
#' @param annot_col A character vector containing the name of a column which is used for annotation
#' in the pop-up window
#'
#' @return The function returns an interactive map with annotation in popup window
#'
#' @importFrom leaflet leaflet addTiles addCircleMarkers
#' @importFrom dplyr %>%
#'
#' @examples
#' \dontrun{
#'
#' readr::read_delim("earthquakes.tsv.gz", delim = "\t") %>%
#' eq_clean_data() %>%
#' dplyr::filter(COUNTRY == "MEXICO" & lubridate::year(DATE) >= 2000) %>%
#' eq_map(annot_col = "DATE")
#'
#' }
#'
#' @export
eq_map <- function(dt, annot_col = "DATE") {

  map <- dt %>%
    leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addCircleMarkers(lng = ~ LONGITUDE,
                              lat = ~ LATITUDE,
                              radius = ~ EQ_PRIMARY,
                              weight = 1,
                              popup = ~ dt[[annot_col]])

  map

}


#' @title Create extended annotation
#' @description
#' This function create HTML label that can be used as extended annotation for the leaflet map.
#' The function put together location, magnitude and total number of deaths for each earthquake
#' and show them in new column "popup_text".
#'
#' @param dt NOAA data frame
#'
#' @return The function returns a data frame with a new column "popup_text"
#'
#' @import data.table
#'
#' @examples
#' \dontrun{
#'
#' dt[COUNTRY == "MEXICO" & lubridate::year(DATE) >= 2000] %>%
#' eq_create_label() %>%
#' eq_map(annot_col = "popup_text")
#'
#' }
#'
#' @export
eq_create_label <- function(dt) {

  data.table::setDT(dt)

  dt[, `:=`(label_1 = "", label_2 = "", label_3 = "")]
  dt[!is.na(LOCATION_NAME), label_1 := paste("<strong>Location: </strong>", LOCATION_NAME)]
  dt[!is.na(EQ_PRIMARY), label_2 := paste("<strong>Magnitude: </strong>", EQ_PRIMARY)]
  dt[!is.na(TOTAL_DEATHS), label_3 := paste("<strong>Total deaths: </strong>", TOTAL_DEATHS)]
  dt[, popup_text := paste(label_1, label_2, label_3, sep = '<br/>')][, `:=`(label_1 = NULL, label_2 = NULL, label_3 = NULL)]
  dt

}


