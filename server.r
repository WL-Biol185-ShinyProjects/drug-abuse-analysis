library(shinydashboard)
library(shiny)
library(leaflet)
library(ggplot2)
library(lubridate)

source("DrugInvestment2.R")
source("HomePage.R")
source("StateDrugDataPage.R")
source("BigPharmaPerformance.R")
source("AboutPage.R")

#Function for Drug Investment tab
function(input, output) {
    output$InvestmentOvertime <- renderLeaflet({
      FilteredStateData <- filter(geoIPC, years == input$yearsforinvestment)
      geo@data <- left_join(geo@data, FilteredStateData, by = c("NAME" = "NAME"))
      statespalette <- colorBin("Purples", domain = geoIPC$InvestmentPerCapita)
      leaflet(data = geo) %>%
        setView(-96, 37.8, 4) %>%
        addPolygons(
              fillColor = ~statespalette(InvestmentPerCapita),
              weight = 2,
              label = geo@data$NAME,
              opacity = 1,
              color = "black",
              fillOpacity = .7 
    ) %>%
    addLegend("bottomright",
              pal = statespalette,
              values = ~InvestmentPerCapita,
              opacity = .8,
              title = "Investment Per Capita for States from 1991 to 2014"
    )}
    )}

#Function for BigPharmaPerformance tab
function(input, output) {
  output$myLineGraph <- renderPlot(
    {
      BigPharmaStockData %>%
        filter(tic %in% input$tic) %>%
        ggplot(aes(x = ymd(datadate), y = prccm, color = tic, group = tic)) + 
        geom_line() + 
        geom_point(aes(color = tic)) +
        xlab("Year")                                      +
        ylab("% Change in Monthly Closing Price")
    }
  )
}

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