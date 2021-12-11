library(shiny)
library(shinydashboard)
library(tidyverse)
library(lubridate)

# Read in Big Pharma Stock Data from Wharton Research Database
BigPharmaStockData <- read.csv("BigPharmaStockData.csv")

# Set closing monthly closing price data as numeric vector
BigPharmaStockData$prccm <- as.numeric(as.character( BigPharmaStockData$prccm ))

# 
BigPharmaPerformanceText <-
  fluidPage(
    titlePanel("The Growth of Select Pharmecutical Companies as a Result of a Nationwide Push in Greater Prescribing for Pain"),
    fluidRow(box(width      = 12,
                 background = "navy",
                 p("The line graph below demonstrates the percent change in monthly closing share price for major pharmaceutical companies with ties to the Opioid Epidemic.")),
    sidebarLayout(
     sidebarPanel(
        selectInput(
          inputId = "tic",
          label = "Select one or more Pharmaceutical Companies:",
          choices = unique(BigPharmaStockData$tic),
          selected = 'AMRX',
          multiple = TRUE),

  
        textOutput("ticResult2")
      ),
      mainPanel(plotOutput("myLineGraph"))
    )
    )
  )
    
    # Going forward: pull SPY data as S&P 500 index so as to compare pharma performance to that of broader market, and wrangle data to include percent change of stock price
    # Lastly: finalize list of tickers to add to graph, needs to be linked to litigation or listed as a top opioid producer in the US
    