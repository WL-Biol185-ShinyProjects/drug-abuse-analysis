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
      ),
      mainPanel(plotOutput("myLineGraph"))
    )
    )
  )
    
    # Going forward: pull SPY data as S&P 500 index so as to compare pharma performance to that of broader market, and wrangle data to include percent change of stock price
    # Lastly: finalize list of tickers to add to graph, needs to be linked to litigation or listed as a top opioid producer in the US
    
# output$unitPlot <- renderPlot({
#   units_g %>%
#     filter(unit_type %in% input$unit_type) %>%
#     ggplot(aes(x = as.numeric(year), y = as.numeric(units), color = unit_type, group = unit_type)) + 
#     geom_line() + 
#     geom_point(aes(color = unit_type)) +
#     xlim(input$year_slider[1], input$year_slider[2]) +
#     #ylim(0,1402.739) +
#     xlab("Year") +
#     ylab("Units (In Millions)") +
#     labs(color = 'Format')
# })
# 
# output$valuePlot <- renderPlot({
#   value_g[[input$inf]] %>%
#     filter(value_type %in% input$value_type) %>%
#     ggplot(aes(x = as.numeric(year), y = as.numeric(values), color = value_type, group = value_type)) + 
#     geom_line() + 
#     geom_point(aes(color = value_type)) +
#     xlim(input$year_slider[1], input$year_slider[2]) +
#     xlab("Year") +
#     ylab("Value (In Millions of $)") +
#     labs(color = 'Format')
# })
# 
# fluidRow(
#   sidebarPanel(
#     sliderInput(inputId = "year_slider",
#                 label = "Select years to display:",
#                 min = 1973,
#                 max = 2019,
#                 value = c(1973, 2019)
#     )
#   ),
#   mainPanel(
#     tabsetPanel(type = "tabs",
#                 tabPanel("Units", 
#                          selectInput(
#                            inputId = "unit_type",
#                            label = "Select Unit Format:",
#                            choices = unique(units_g$unit_type),
#                            multiple = TRUE),
#                          plotOutput("unitPlot",
#                                     brush = "plot_brush"),
#                          verbatimTextOutput("info_brush")
#                 ),
#                 tabPanel("Revenue",  
#                          selectInput(
#                            inputId = "value_type",
#                            label = "Select Revenue Format:",
#                            choices = unique(value_g[["yes_inf"]]$value_type),
#                            multiple = TRUE
#                          ),
#                          radioButtons("inf", "choose adjusted for inflation or not:",
#                                       c("Value not adjusted for inflation" = "not_inf",
#                                         "Value adjusted for inflation" = "yes_inf")
#                          ),
#                          plotOutput("valuePlot",
#                                     brush = "plot_brush"),
#                          verbatimTextOutput("value_brush")
#                 )