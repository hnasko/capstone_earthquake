% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_timeline.R
\name{geom_timeline}
\alias{geom_timeline}
\title{Create a geom for plotting a time line of NOAA earthquakes}
\usage{
geom_timeline(mapping = NULL, data = NULL, stat = "identity",
  position = "identity", na.rm = FALSE, show.legend = NA,
  inherit.aes = TRUE, ...)
}
\arguments{
\item{mapping}{Uses aes to produce a set of aesthetic mappings.}

\item{data}{The data to be graphed in the layer.}

\item{stat}{A string that defines statistical transformation to use on the
data for the layer.}

\item{position}{A string or output of position adjustment function that specifies the position adjustment.}

\item{na.rm}{A logical parameter that determines if missing values are removed with or without a warning.}

\item{show.legend}{A logical parameter that determines if a legend should be included in this layer.}

\item{inherit.aes}{A logical parameter that determines if the default aesthetics are maintained in the layer.}

\item{...}{other arguments passed on to \code{\link{layer}}.}
}
\description{
Generates a points chart on a ggmap object representing a time line.
}
\examples{
\dontrun{

  dt[YEAR > 2000 & COUNTRY \%in\% c("USA", 'CHINA'), ] \%>\%
  ggplot2::ggplot(aes(x = DATE, y = COUNTRY, size = EQ_PRIMARY, color = DEATHS)) +
  geom_timeline() +
  theme_timeline()

}

}
