library(dplyr)

process_climate_data <- function(data) {
  data <- data %>%
    mutate(date = as.Date(date)) %>%
    filter(!is.na(temperature) & !is.na(date))
  
  if (any(is.na(data$date))) {
    stop("Error: Date conversion failed.")
  }

  return(data)
}
