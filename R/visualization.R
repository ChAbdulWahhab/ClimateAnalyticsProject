library(ggplot2)

plot_climate_data <- function(data) {
  p <- ggplot(data, aes(x = date, y = temperature)) +
    geom_line(color = "blue") +
    labs(title = "Temperature Trend Over Time", x = "Date", y = "Temperature (°C)") +
    theme_minimal()
  
  return(p)
}
