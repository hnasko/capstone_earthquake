Introduction
------------

This packages was designed as a final part of Mastering Software
Development in R Specialization. It provides functionality for work with
Significant Earthquakes dataset obtained from National Oceanic and
Atmospheric Administration (NOAA). This dataset contains information
about 5,933 earthquakes over an approximately 4,000 year time span.

The dataset is available at the NOAA website
(<a href="https://www.ngdc.noaa.gov/nndc/struts/results?type_0=Exact&query_0=$ID&t=101650&s=13&d=189&dfn=signif.txt">NOAA
Significant Earthquake Database</a>).

Package functionality
---------------------

NOAA dataset was included in the package. The data can be loaded from
`inst\extdata` subdirectory.

To load the dataset, use `fread()` function from `data.table` package:

    library(NOAA.capstone)
    dt <- data.table::fread('signif.txt', sep = "\t")

The package contains functions for cleaning NOAA dataset. These
functions are designed for correct work with the dataset.

The `eq_clean_data()` function takes raw NOAA data and return DATE,
LATITUDE and LONGITUDE columns in appropriate format. The DATE column is
created by uniting the YEAR, MONTH and DAY columns. LATITUDE and
LONGITUDE columns are converted to numeric class.

The `eq_location_clean()` function cleans the LOCATION\_NAME column by
stripping out the country name and converts names to title case.

    dt <- dt %>% eq_clean_data() %>% eq_location_clean() 
    str(dt)

As well the package provides visualization tools on the base of
`ggplot2` package.

The `geom_timeline()` function creates a timeline layer, which displays
earthquakes as points with the diameter relative to earthquake's
maginitude and color to number of deaths caused by it.

Required aestetic for the function is `x`, which should be the DATE
variable.

The `geom_timeline_label()` function was created in support to
`geom_timeline()` function. `geom_timeline_label()` adds a geom for
adding a text annotation to a time line plot.

Required aestetic for the function is `x`, which should be the same as
in `geom_timeline()`, and `label`, which shoould provide text
information.

Additionally, the `theme_timeline()` function could be used to make a
timeline plot prettier.


    dt[YEAR > 2000 & YEAR < 2015 & COUNTRY %in% c('MEXICO'), ] %>%
       ggplot2::ggplot(ggplot2::aes(x = DATE, y = COUNTRY, size = EQ_PRIMARY, color = DEATHS)) +
       geom_timeline() +
       geom_timeline_label(ggplot2::aes(label = LOCATION_NAME), n_max = 3) +
       theme_timeline()

The packade provides functionality for displaying earthquakes on an
interactive map. The `eq_map()` maps the epicenters (LATITUDE/LONGITUDE)
of earthquakes and annotates each point with a popup window. A popup is
displayed when a user clicks on an earthquake point.

The `eq_create_label()` is a helper function, which can be used as
extended annotation for the leaflet map. The function put together
location, magnitude and total number of deaths for each earthquake.


    dt[COUNTRY == "MEXICO" & lubridate::year(DATE) >= 2000] %>%
      eq_create_label() %>%
      eq_map(annot_col = "popup_text")
# noaa.capstone
