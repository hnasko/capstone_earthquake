library(NOAA.capstone)

context("Test NOAA.capstone package")


dt <- data.table::fread('https://www.ngdc.noaa.gov/nndc/struts/results?type_0=Exact&query_0=$ID&t=101650&s=13&d=189&dfn=signif.txt', sep = "\t")

# eq_clean_data returns a data table
test_that("eq_clean_data returns data table", {
  expect_true(is.data.table(eq_clean_data(dt)))
})

# Date column is supposed to be added and of type Date
test_that("Date column is supposed to be Date type", {
  expect_true(lubridate::is.Date(eq_clean_data(dt)$DATE))
})

# Latitude and Longitude are supposed to be numeric
test_that("eq_clean_data returns numeric coordinates", {
  expect_true(is.numeric(eq_clean_data(dt)$LATITUDE))
  expect_true(is.numeric(eq_clean_data(dt)$LONGITUDE))
})

# eq_location_clean returns a data frame
test_that("eq_location_clean returns a data table", {
  expect_true(is.data.table(eq_location_clean(dt)))
})

# geom_timeline returns a ggplot object
test_that("geom_timeline returns ggplot object", {
  plot <- dt %>% eq_clean_data() %>%
    dplyr::filter(COUNTRY %in% c("USA", "CHINA"), YEAR > 2010) %>%
    ggplot2::ggplot(aes(x = DATE, y = COUNTRY, size = EQ_PRIMARY, color = DEATHS)) +
    geom_timeline()
  expect_true(is.ggplot(plot))
})

# geom_timeline_label returns a ggplot object
test_that("geom_timeline_label returns ggplot object", {
  plot <- dt %>% eq_clean_data() %>%
    dplyr::filter(COUNTRY %in% c("USA", "CHINA"), YEAR > 2010) %>%
    ggplot2::ggplot(aes(x = DATE, y = COUNTRY, size = EQ_PRIMARY, color = DEATHS)) +
    geom_timeline_label(aes(label = LOCATION_NAME))
  expect_true(is.ggplot(plot))
})

# theme_timeline returns a ggplot object
test_that("theme_timeline returns ggplot object", {
  plot <- dt %>% eq_clean_data() %>%
    dplyr::filter(COUNTRY %in% c("USA", "CHINA"), YEAR > 2010) %>%
    ggplot2::ggplot(aes(x = DATE, y = COUNTRY, size = EQ_PRIMARY, color = DEATHS)) +
    theme_timeline()
  expect_true(is.ggplot(plot))
})

# eq_map returns a leaflet object
test_that("eq_map returns leaflet object", {
  map <- dt %>%
    eq_clean_data() %>%
    dplyr::filter(COUNTRY == "USA" & lubridate::year(DATE) >= 2010) %>%
    eq_map(annot_col = "DATE")
  expect_true(any(class(map) == "leaflet"))
})

# eq_create_label returns popup_text column
test_that("eq_create_label returns character vector", {
  expect_true(any(names(eq_create_label(dt)) == "popup_text"))
})
