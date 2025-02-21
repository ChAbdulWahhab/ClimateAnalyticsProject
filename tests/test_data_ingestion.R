library(testthat)
source("../R/data_ingestion.R")

test_that("load_climate_data returns a data frame", {
  data <- load_climate_data("../data/sample_climate_data.csv")
  expect_true(is.data.frame(data))
})
