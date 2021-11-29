library(shinydashboard)
library(shiny)
library(leaflet)
library(ggplot2)

source("DrugInvestment2.R")
source("HomePage.R")
source("StateDrugDataPage.R")
source("BigPharmaPerformance.R")

function(input, output) {
    output$InvestmentOvertime <- renderLeaflet({
    FilteredStateData <- filter(geo@data, years == input$yearsforinvestment)
    geo@data <- left_join(geo@data, FilteredStateData, by = c("NAME" = "NAME"))
    statespalette <- colorBin("Purples", domain = geo@data$InvestmentPerCapita)
    leafletProxy("InvestmentPerCapita", data = Geo) %>%
      setView(-96, 37.8, 4) %>%
      addPolygons(
        fillColor = ~statespalette(geo@data$InvestmentPerCapita),
    weight = 2,
    label = geo@data$NAME,
    opacity = 1,
    color = "black",
    fillOpacity = .7 
    ) %>%
    addLegend("bottomright",
              pal = statespalette,
              values = ~(geo@data$InvestmentPerCapita),
              opacity = .8,
              title = "Investment Per Capita for States from 1991 to 2014"
    )}
    )}