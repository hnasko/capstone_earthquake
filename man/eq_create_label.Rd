% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eq_map.R
\name{eq_create_label}
\alias{eq_create_label}
\title{Create extended annotation}
\usage{
eq_create_label(dt)
}
\arguments{
\item{dt}{NOAA data frame}
}
\value{
The function returns a data frame with a new column "popup_text"
}
\description{
This function create HTML label that can be used as extended annotation for the leaflet map.
The function put together location, magnitude and total number of deaths for each earthquake
and show them in new column "popup_text".
}
\examples{
\dontrun{

dt[COUNTRY == "MEXICO" & lubridate::year(DATE) >= 2000] \%>\%
eq_create_label() \%>\%
eq_map(annot_col = "popup_text")

}

}
