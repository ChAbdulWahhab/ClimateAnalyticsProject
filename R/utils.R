log_message <- function(message, level = "INFO") {
  cat(sprintf("[%s] %s: %s\n", Sys.time(), level, message))
}
