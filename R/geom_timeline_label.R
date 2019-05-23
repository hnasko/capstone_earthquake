#' @title Create a geom for adding a text annotation to a time line plot
#' @description
#' Create a geom for adding a vertical line to each data point on a time line
#' chart with a text annotation.
#'
#' @import ggplot2
#' @importFrom grid gpar gTree gList segmentsGrob textGrob
#' @importFrom dplyr arrange desc
#'
#' @examples
#' \dontrun{
#'
#'   dt[YEAR > 2000 & COUNTRY %in% c("USA", 'CHINA'), ] %>%
#'   ggplot2::ggplot(aes(x = DATE, y = COUNTRY, size = EQ_PRIMARY, color = DEATHS)) +
#'   geom_timeline() +
#'   geom_timeline_label(aes(label = LOCATION_NAME), n_max = 5) +
#'   theme_timeline()
#'
#' }
#'
#' @export
GeomTimelineLabel <- ggplot2::ggproto("GeomTimelineLabel", ggplot2::Geom,
                                      required_aes = c("x","label"),

                                      default_aes = ggplot2::aes(shape = 21,
                                                                 lwd = 1,
                                                                 colour = "grey",
                                                                 fill = "grey",
                                                                 alpha = 0.3,
                                                                 stroke = 1,
                                                                 n_max = NA),

                                      draw_key = ggplot2::draw_key_point,

                                      draw_panel = function(data, panel_params, coord) {

                                        max_value <- data$n_max[1]

                                         if(!is.na(max_value)) {

                                           data <- dplyr::arrange(data, dplyr::desc(size)) %>%
                                             head(max_value)

                                         }

                                         coords <- coord$transform(data, panel_params)

                                         grid::gTree(children = grid::gList(

                                           grid::segmentsGrob(
                                             x0 = coords$x,
                                             y0 = coords$y,
                                             x1 = coords$x,
                                             y1 = coords$y + 0.1,
                                             gp = grid::gpar(
                                               col = "grey"
                                             )),

                                           grid::textGrob(
                                             label = coords$label,
                                             x = coords$x,
                                             y = coords$y + 0.1,
                                             just = "left",
                                             rot = 45)

                                           ))

                                       }
)



#' @title Create a geom for adding a text annotation to a time line plot
#' @description
#' Add a vertical line to each data point on a time line chart with a text annotation.
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
#'   geom_timeline_label(aes(label = LOCATION_NAME), n_max = 5) +
#'   theme_timeline()
#'
#' }
#'
#' @export
geom_timeline_label <- function(mapping = NULL, data = NULL, stat = "identity",
                          position = "identity", na.rm = FALSE, show.legend = NA,
                          inherit.aes = TRUE, ...) {

  ggplot2::layer(
    geom = GeomTimelineLabel, mapping = mapping,  data = data, stat = stat,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )

}
