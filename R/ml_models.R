library(caret)
library(randomForest)

train_climate_model <- function(data) {
  if (!"temperature" %in% names(data) | !"date" %in% names(data)) {
    stop("Error: Data must contain 'temperature' and 'date' columns.")
  }
  
  data <- data %>%
    filter(!is.na(temperature) & !is.na(date)) %>%
    mutate(day_of_year = as.numeric(format(date, "%j")))
  
  if (any(is.na(data$day_of_year))) {
    stop("Error: Date conversion to day_of_year failed.")
  }

  model <- randomForest(temperature ~ day_of_year, data = data, na.action = na.omit)

  return(model)
}
