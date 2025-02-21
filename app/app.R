library(shiny)
library(shinydashboard)
library(shinymanager)
library(ggplot2)
library(plotly)
library(DT)
library(shinyWidgets)
library(shinycssloaders)

source("../R/auth.R")
source("../R/data_ingestion.R")
source("../R/data_processing.R")
source("../R/ml_models.R")
source("../R/visualization.R")
source("../R/notifications.R")

credentials <- data.frame(
  user = c("admin", "analyst"),
  password = c("adminpass", "analystpass"),
  admin = c(TRUE, FALSE),
  stringsAsFactors = FALSE
)

ui <- secure_app(
  dashboardPage(
    dashboardHeader(title = "Climate Data Analytics", titleWidth = 250),
    dashboardSidebar(
      tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
      sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("tachometer-alt")),
        menuItem("Data Ingestion", tabName = "ingestion", icon = icon("database")),
        menuItem("Data Processing", tabName = "processing", icon = icon("cogs")),
        menuItem("ML Models", tabName = "ml", icon = icon("brain")),
        menuItem("Visualizations", tabName = "viz", icon = icon("chart-line")),
        menuItem("Notifications", tabName = "alerts", icon = icon("bell"))
      )
    ),
    dashboardBody(
      setBackgroundColor("#f4f6f9"),
      tabItems(
        tabItem(tabName = "dashboard",
                fluidRow(
                  valueBoxOutput("dataCount"),
                  valueBoxOutput("alertCount"),
                  valueBoxOutput("avgTemperature")
                ),
                fluidRow(
                  box(title = "Latest Climate Data", width = 12, DTOutput("latestData"))
                )
        ),
        tabItem(tabName = "ingestion", 
                fluidRow(
                  box(title = "Upload Data", width = 6, fileInput("file", "Upload CSV File")),
                  box(title = "View Data", width = 6, DTOutput("ingestedData"))
                )
        ),
        tabItem(tabName = "processing", h2("Data Processing"), DTOutput("processedData")),
        tabItem(tabName = "ml", h2("Machine Learning Models"), verbatimTextOutput("mlResults")),
        tabItem(tabName = "viz", h2("Data Visualization"), plotlyOutput("climatePlot")),
        tabItem(tabName = "alerts", h2("Notifications & Alerts"), verbatimTextOutput("alertStatus"))
      )
    )
  )
)

server <- function(input, output, session) {
  res_auth <- secure_server(check_credentials)
  
  uploaded_data <- reactive({
    if (is.null(input$file)) {
      load_climate_data("../data/sample_climate_data.csv")
    } else {
      read.csv(input$file$datapath, stringsAsFactors = FALSE)
    }
  })
  
  data_processed <- reactive({ process_climate_data(uploaded_data()) })
  ml_result <- reactive({ train_climate_model(data_processed()) })
  
  output$ingestedData <- renderDT({ uploaded_data() }, options = list(scrollX = TRUE))
  output$processedData <- renderDT({ data_processed() }, options = list(scrollX = TRUE))
  output$mlResults <- renderPrint({ ml_result() })
  output$climatePlot <- renderPlotly({ ggplotly(plot_climate_data(data_processed())) })
  
  output$alertStatus <- renderText({
    alert_message <- check_alerts(data_processed())
    if (nchar(alert_message) > 0) {
      send_alert_notification(alert_message)
      paste("🚨 Alert Sent:", alert_message)
    } else {
      "✅ No alerts triggered at this time."
    }
  })
  
  output$dataCount <- renderValueBox({
    valueBox(nrow(uploaded_data()), "Total Records", icon = icon("database"), color = "blue")
  })
  
  output$alertCount <- renderValueBox({
    alert_count <- ifelse(nchar(check_alerts(data_processed())) > 0, 1, 0)
    valueBox(alert_count, "Alerts", icon = icon("bell"), color = "red")
  })
  
  output$avgTemperature <- renderValueBox({
    avg_temp <- mean(uploaded_data()$temperature, na.rm = TRUE)
    valueBox(round(avg_temp, 2), "Avg Temperature", icon = icon("thermometer-half"), color = "green")
  })
  
  output$latestData <- renderDT({
    head(uploaded_data(), 10)
  })
}

shinyApp(ui = ui, server = server)
