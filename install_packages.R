required_packages <- c("shiny", "shinymanager", "readr", "dplyr", "data.table", 
                       "ggplot2", "plotly", "caret", "randomForest", "forecast", 
                       "blastula", "testthat", "shinyWidgets")

install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

invisible(lapply(required_packages, install_if_missing))
