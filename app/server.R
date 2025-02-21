library(shiny)
library(shinymanager)
library(shinydashboard)

server <- function(input, output, session) {
  
  res_auth <- secure_server(check_credentials = check_credentials)

  observe({
    print(str(res_auth))
  })

  output$welcomeText <- renderText({
    paste("Welcome", res_auth$user, "to the Climate Data Analysis Dashboard!")
  })

  data_ingested <- reactive({
    load_climate_data("../data/sample_climate_data.csv")
  })
  
  output$ingestedData <- renderDataTable({
    data_ingested()
  })
  
  data_processed <- reactive({
    process_climate_data(data_ingested())
  })
  
  output$processedData <- renderDataTable({
    data_processed()
  })
  
  ml_result <- reactive({
    train_climate_model(data_processed())
  })
  
  output$mlResults <- renderPrint({
    ml_result()
  })
  
  output$climatePlot <- renderPlotly({
    p <- plot_climate_data(data_processed())
    ggplotly(p)
  })
  
  output$alertStatus <- renderText({
    alert_message <- check_alerts(data_processed())
    if (nchar(alert_message) > 0) {
      send_alert_notification(alert_message)
      paste("Alert Sent:", alert_message)
    } else {
      "No alerts triggered at this time."
    }
  })
}

shinyApp(ui = ui_secured, server = server)
