library(shiny)
library(shinydashboard)
library(tidyverse)
library(lubridate)

# Read in Big Pharma Stock Data from Wharton Research Database
BigPharmaStockData <- read.csv("BigPharmaStockData.csv")

# Set closing monthly closing price data as numeric vector
BigPharmaStockData$prccm <- as.numeric(as.character( BigPharmaStockData$prccm ))
BigPharmaStockData <- BigPharmaStockData %>%
  arrange(conm)

# Organizing Big Pharma Stock Data to throw into the UI & Server
BigPharmaPerformance <-
  fluidPage(
    titlePanel("The Growth of Select Pharmecutical Companies as a Result of a Nationwide Push in Greater Prescribing for Pain"),
    fluidRow(box(width      = 12,
                 background = "navy",
                 p("The line graph below demonstrates the percent change in monthly closing share price for major pharmaceutical companies with ties to the Opioid Epidemic.")),
    sidebarLayout(
      sidebarPanel(
        sliderInput(inputId = "year_slider",
                    label = "Select years to display:",
                    min = min(ymd(BigPharmaStockData$datadate)),
                    max = max(ymd(BigPharmaStockData$datadate)),
                    value = c(min(ymd(BigPharmaStockData$datadate)), max(ymd(BigPharmaStockData$datadate)))
        )
      ),
      mainPanel(
        tabsetPanel(type = "tabs",
                    tabPanel("Monthly Closing Price (in $)",
                             selectInput(
                               inputId = "conm",
                               label = "Select one or more Pharmaceutical Distributors or Producers:",
                               choices = unique(BigPharmaStockData$conm),
                               selected = 'SPDR S&P 500 ETF TRUST',
                               multiple = TRUE),
                             plotOutput("myDollarGraph")),
                    tabPanel("Monthly Closing Price (in % change)",
                             selectInput(
                               inputId = "conm",
                               label = "Select one or more Pharmaceutical Distributors or Producers:",
                               choices = unique(BigPharmaStockData$conm),
                               selected = 'SPDR S&P 500 ETF TRUST',
                               multiple = TRUE),
                             plotOutput("myPercentGraph"))
        )
      )
    )
    )
  )

# List to pull: AMRX CAH TEVA SPY MCK JNJ MNK WBA CVS WMT RAD KR WPI PRX ENDP