library(shinydashboard)
library(shiny)
library(leaflet)
library(ggplot2)

source(DrugInvestment2.R)

function(input, output) {
  output$InvestmentOvertime <- renderLeaflet({
    FilteredStateData <- filter(geo@data, years == input$yearsforinvestment)
    statespalette <- colorBin("Purples", domain = geo@data$InvestmentPerCapita)
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
              values = InvestmentPerCapita,
              opacity = .8,
              title = "Investment Per Capita for States from 1991 to 2014"
      )
  })
}