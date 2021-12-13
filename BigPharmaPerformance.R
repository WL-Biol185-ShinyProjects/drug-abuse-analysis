library(shiny)
library(shinydashboard)
library(tidyverse)
library(lubridate)
library(markdown)

# Read in Big Pharma Stock Data from Wharton Research Database
BigPharmaStockData <- read.csv("BigPharmaStockData.csv")

# Set closing monthly closing price data as numeric vector
BigPharmaStockData$prccm <- as.numeric(as.character( BigPharmaStockData$prccm ))
BigPharmaStockData <- BigPharmaStockData %>%
  arrange(conm)

# Organizing Big Pharma Stock Data to throw into the UI & Server
BigPharmaPerformance <-
  fluidPage(
    titlePanel("Pharmaceutical Asset Pricing Throughout the Opioid Epidemic"),
    fluidRow(box(width      = 12,
                 background = "blue",
                 p("Click the 'Monthly Closing Price (in $)' tab to view the monthly closing price of stocks from top opioid producers and distributors.",
                   "Click the 'Monthly Closing Price (in % change versus 1 year prior)' tab to view the year to date percentage change in monthly closing price of each asset.",
                   "The pre-selected 'SPDR S&P 500 ETF TRUST' asset on each graph is an index fund that tracks with the S&P 500 Index, which itself tracks with the performance of 500 large companies traded on US exchanges.",
                   "This 'SPDR S&P 500 ETF TRUST' asset can be interpreted as an estimate for performance in the broader market and is intended as a metric to compare pharmaceutical asset performance to.",
                   "Slide either end of the 'Select years to display' interactive tool to select the time frame of the Opioid Epidemic to visualize.")),
    sidebarLayout(
      sidebarPanel(
        box(
          width = 16,
          title = "Reports on Corporate Involvement in the Opioid Epidemic:",
          background = "blue",
          a("• Purdue Pharma (nonpublic), Cardinal Health, McKesson, and AmerisourceBergen", href = "https://www.nytimes.com/2019/04/22/health/opioids-lawsuits-distributors.html", style = "color:white;"),
          br(),
          a("• Johnson & Johnson", href = "https://www.nytimes.com/2021/07/21/health/opioids-distributors-settlement.html", style = "color:white;"),
          br(),
          a("• Walgreens, CVS, Walmart, Rite Aid, Kroger, and Par Pharmaceutical", href = "https://www.washingtonpost.com/investigations/76-billion-opioid-pills-newly-released-federal-data-unmasks-the-epidemic/2019/07/16/5f29fd62-a73e-11e9-86dd-d7f0e60391e9_story.html", style = "color:white;"),
          br(),
          a("• Amneal Pharmaceuticals, Teva Pharmaceuticals, and Endo Pharmaceuticals", href = "https://www.marketwatch.com/story/possible-criminal-probe-undermines-recovery-in-opioid-stocks-since-global-legal-settlement-announced-2019-11-27", style = "color:white;"),
          br()
        ),
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
                    tabPanel("Monthly Closing Price (in % change ytd)",
                             selectInput(
                               inputId = "conm_pct",
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