# Climate Change Data Analysis

## Overview  

This project is an interactive climate data analysis platform built in **R**. It includes modules for **data ingestion, processing, machine learning, visualization, and notifications**, all integrated within a **Shiny application**.  

## Directory Structure  

```
ClimateAnalyticsProject/
├── app/
│   ├── app.R                # Main entry point for the Shiny application
│   ├── global.R             # Global configurations and package loading
│   ├── ui.R                 # User Interface definitions with authentication
│   └── server.R             # Server logic handling app functionalities
├── data/
│   └── sample_climate_data.csv  # Sample climate dataset
├── R/
│   ├── auth.R               # Authentication functions
│   ├── data_ingestion.R     # Data ingestion functions
│   ├── data_processing.R    # Data processing functions
│   ├── ml_models.R          # Machine learning model functions
│   ├── notifications.R      # Notification and alert functions
│   ├── utils.R              # Utility functions
│   └── visualization.R      # Visualization functions
├── docs/
│   ├── README.md            # Project documentation and usage guide
│   └── design_document.md   # Detailed design and architecture documents
├── tests/
│   ├── test_data_ingestion.R  # Unit tests for data ingestion module
│   └── test_ml_models.R       # Unit tests for machine learning module
├── install_packages.R       # Script to install required packages
├── run_app.R                # Script to run the Shiny app
└── ClimateProject.Rproj     # RStudio project file
```

## How to Run  

1. **Install Required Packages**  
   Run the following script to install all necessary dependencies:  
   ```r
   source("install_packages.R")
   ```

2. **Launch the Shiny Application**  
   Execute the script to start the app:  
   ```r
   source("run_app.R")
   ```

3. **Login Credentials**  
   Use the following credentials to access the application:  

   - **Admin:**  
     - Username: `admin`  
     - Password: `adminpass`  
   - **Analyst:**  
     - Username: `analyst`  
     - Password: `analystpass`  

---

This README provides a structured guide to help users set up and run the Climate Change Data Analysis platform efficiently.
