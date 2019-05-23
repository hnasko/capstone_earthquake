globalVariables(c('YEAR', 'MONTH', 'DAY', 'DATE', 'epoch', 'LATITUDE', 'LONGITUDE',
                  'LOCATION_NAME'))

#' @title Clean raw NOAA data frame
#' @description
#' This function takes raw NOAA data frame and returns a clean data frame.
#' The clean data frame have a DATE column created by uniting the year, month and
#' day columns. As well LATITUDE and LONGITUDE columns are converted to numeric class.
#'
#' @param dt A raw NOAA data frame
#'
#' @return The function returns a clean data frame with DATE, LATITUDE and LONGITUDE
#' columns in appropriate format.
#'
#' @import data.table
#' @importFrom lubridate ymd years
#'
#' @examples
#' \dontrun{
#' eq_clean_data(data.table::fread(file.path("inst/extdata", "signif.txt"), sep = "\t"))
#' }
#'
#' @export
eq_clean_data <- function(dt) {

  setDT(dt)
  dt[is.na(MONTH), MONTH := 1 ]
  dt[is.na(DAY), DAY := 1 ]
  dt[, epoch := "AD"]
  dt[YEAR < 0, epoch := "BC"]

  # For the AD period
  dt[epoch == "AD", DATE := as.Date(paste(YEAR, MONTH, DAY, sep = "-"))]
  # For the BC period
  dt[epoch == "BC", DATE := lubridate::ymd("0000-01-01") - lubridate::years(YEAR)]

  dt[, `:=`(LATITUDE = as.numeric(LATITUDE), LONGITUDE = as.numeric(LONGITUDE))]
  dt[, epoch := NULL]
  dt

}


#' @title Clean the LOCATION_NAME column in NOAA data frame
#' @description
#' This function cleans the LOCATION_NAME column by stripping out the country name
#' and converts names to title case.
#'
#' @param dt A raw NOAA data frame
#'
#' @return The function returns a cleaned up version of the LOCATION_NAME column.
#'
#' @import data.table
#' @importFrom stringr str_to_title
#'
#' @examples
#' \dontrun{
#' eq_location_clean(data.table::fread(file.path("inst/extdata", "signif.txt"), sep = "\t"))
#' }
#'
#' @export
eq_location_clean <- function(dt) {

  setDT(dt)
  dt[, LOCATION_NAME := stringr::str_to_title(sub('.*\\: ', '', LOCATION_NAME))]
  dt

}

