library(shiny)
library(shinymanager)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      .shiny-output-error { color: red; }
    "))
  ),
  titlePanel("Climate Change Data Analysis & eProject Learning Environment"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Navigation"),
      sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
        menuItem("Data Ingestion", tabName = "ingestion", icon = icon("database")),
        menuItem("Data Processing", tabName = "processing", icon = icon("cogs")),
        menuItem("ML Models", tabName = "ml", icon = icon("chart-line")),
        menuItem("Visualizations", tabName = "viz", icon = icon("chart-area")),
        menuItem("Notifications", tabName = "alerts", icon = icon("bell"))
      )
    ),
    mainPanel(
      tabItems(
        tabItem(tabName = "dashboard",
                h2("Dashboard"),
                verbatimTextOutput("welcomeText")
        ),
        tabItem(tabName = "ingestion",
                h2("Data Ingestion"),
                dataTableOutput("ingestedData")
        ),
        tabItem(tabName = "processing",
                h2("Data Processing"),
                dataTableOutput("processedData")
        ),
        tabItem(tabName = "ml",
                h2("Machine Learning Models"),
                verbatimTextOutput("mlResults")
        ),
        tabItem(tabName = "viz",
                h2("Data Visualization"),
                plotlyOutput("climatePlot")
        ),
        tabItem(tabName = "alerts",
                h2("Notifications & Alerts"),
                verbatimTextOutput("alertStatus")
        )
      )
    )
  )
)

ui_secured <- secure_app(ui)
