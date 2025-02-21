library(shinymanager)

credentials <- data.frame(
  user = c("admin", "analyst"),
  password = c("adminpass", "analystpass"),
  admin = c(TRUE, FALSE),
  stringsAsFactors = FALSE
)

check_credentials <- shinymanager::check_credentials(credentials)
