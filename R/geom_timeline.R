#' @title Create a geom for plotting a time line of NOAA earthquakes
#' @description
#' Create a ggproto object for plotting a time line of earthquakes.
#'
#' @import ggplot2
#' @importFrom grid pointsGrob unit gpar
#'
#' @examples
#' \dontrun{
#'
#'   dt[YEAR > 2000 & COUNTRY %in% c("USA", 'CHINA'), ] %>%
#'   ggplot2::ggplot(aes(x = DATE, y = COUNTRY, size = EQ_PRIMARY, color = DEATHS)) +
#'   geom_timeline() +
#'   theme_timeline()
#'
#' }
#'
#' @export
GeomTimeline <- ggplot2::ggproto("GeomTimeline", ggplot2::Geom,
                                  required_aes = c("x"),
                                  optional_aes = c("y"),

                                  default_aes = ggplot2::aes(color = "grey", size = 1,
                                                             shape = 21, alpha = 0.3,
                                                             fill = "grey", stroke = 1,
                                                             y = 0),

                                  draw_key = ggplot2::draw_key_point,

                                  draw_panel = function(data, panel_params, coord) {

                                    coords <- coord$transform(data, panel_params)

                                    grid::pointsGrob(
                                        x = coords$x,
                                        y = coords$y,
                                        pch = coords$shape,
                                        size = grid::unit(coords$size,"mm"),
                                        gp = grid::gpar(
                                          col = coords$colour,
                                          fill = coords$fill,
                                          alpha = coords$alpha
                                        )
                                      )

                                  }
)


#' @title Create a geom for plotting a time line of NOAA earthquakes
#' @description
#' Generates a points chart on a ggmap object representing a time line.
#'
#' @param mapping Uses aes to produce a set of aesthetic mappings.
#' @param data The data to be graphed in the layer.
#' @param stat A string that defines statistical transformation to use on the
#' data for the layer.
#' @param position A string or output of position adjustment function that specifies the position adjustment.
#' @param na.rm A logical parameter that determines if missing values are removed with or without a warning.
#' @param show.legend A logical parameter that determines if a legend should be included in this layer.
#' @param inherit.aes A logical parameter that determines if the default aesthetics are maintained in the layer.
#' @param ... other arguments passed on to \code{\link{layer}}.
#'
#' @import ggplot2
#'
#' @examples
#' \dontrun{
#'
#'   dt[YEAR > 2000 & COUNTRY %in% c("USA", 'CHINA'), ] %>%
#'   ggplot2::ggplot(aes(x = DATE, y = COUNTRY, size = EQ_PRIMARY, color = DEATHS)) +
#'   geom_timeline() +
#'   theme_timeline()
#'
#' }
#'
#' @export
geom_timeline <- function(mapping = NULL, data = NULL, stat = "identity",
                          position = "identity", na.rm = FALSE, show.legend = NA,
                          inherit.aes = TRUE, ...) {

  ggplot2::layer(
    geom = GeomTimeline, mapping = mapping,  data = data, stat = stat,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )

}


#' @title Time line theme
#' @description
#' Create custom theme for time line chart.
#'
#' @import ggplot2
#'
#' @examples
#' \dontrun{
#'
#'   dt[YEAR > 2000 & COUNTRY %in% c("USA", 'CHINA'), ] %>%
#'   ggplot2::ggplot(aes(x = DATE, y = COUNTRY, size = EQ_PRIMARY, color = DEATHS)) +
#'   geom_timeline() +
#'   theme_timeline()
#'
#' }
#'
#' @export
theme_timeline <- function() {

  ggplot2::theme_get() + ggplot2::theme(
  axis.line.y = ggplot2::element_blank(),
  axis.title.y = ggplot2::element_blank(),
  axis.ticks.y = ggplot2::element_blank(),
  legend.position = "bottom",
  legend.key = ggplot2::element_rect(fill = NA),
  axis.ticks.x = ggplot2::element_line(color = "black", size = 1, linetype = "solid"),
  axis.line.x = ggplot2::element_line(color = "black", size = 1, linetype = "solid"),
  panel.background = ggplot2::element_rect(fill = NA),
  panel.grid.major.x = ggplot2::element_blank() ,
  panel.grid.major.y = ggplot2::element_line(size = .1, color = "grey")
)

}



