library(dplyr)

check_alerts <- function(data) {
  threshold <- 35
  if (any(data$temperature > threshold, na.rm = TRUE)) {
    return("⚠️ Alert: Temperature threshold exceeded in some records.")
  }
  return("")
}

send_alert_notification <- function(message) {
  if (message == "") {
    print("✅ No alerts.")
    return()
  }

  print("📢 " + message)
}

data <- data.frame(
  date = as.Date(c("2025-01-01", "2025-01-02", "2025-01-03", "2025-01-04", "2025-01-05")),
  temperature = c(25, 26, 27, 36, 28),
  humidity = c(80, 78, 76, 70, 75)
)

alert_message <- check_alerts(data)
send_alert_notification(alert_message)
