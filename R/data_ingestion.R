library(readr)

load_climate_data <- function(filepath) {
  data <- read_csv(filepath, col_types = cols(
    date = col_date(format = "%Y-%m-%d"),
    temperature = col_double(),
    humidity = col_double()
  ))
  
  if (any(is.na(data))) {
    stop("Error: Missing values found in the dataset.")
  }
  
  return(data)
}
