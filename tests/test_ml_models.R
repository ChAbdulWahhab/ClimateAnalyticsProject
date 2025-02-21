library(testthat)
source("../R/ml_models.R")
source("../R/data_processing.R")
source("../R/data_ingestion.R")

test_that("train_climate_model returns a model summary", {
  data <- load_climate_data("../data/sample_climate_data.csv")
  processed_data <- process_climate_data(data)
  model_summary <- train_climate_model(processed_data)
  expect_true(is.list(model_summary) || is.character(model_summary))
})
