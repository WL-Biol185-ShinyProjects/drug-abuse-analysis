library(shinydashboard)
library(shiny)
library(leaflet)
library(ggplot2)

source("DrugInvestment2.R")
source("HomePage.R")
source("StateDrugDataPage.R")
source("BigPharmaPerformance.R")
source("AboutPage.R")


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
    )
    output$OverdoseMap <- renderLeaflet({
OverdoseStateMaps2021 <- read_csv("OverdoseStateMaps2021.csv")
countryMap <- rgdal::readOGR("states.geo.json")
countryMap@data <- left_join(countryMap@data, 
                             OverdoseStateMaps2021, 
                             by = c("NAME" = "StateName"))
print(countryMap@data)                                            
map <- leaflet(countryMap) %>%
  setView(-96, 37.8, 4)

labels <- sprintf(
  "<strong>%s<strong><br>Number of Drug Overdose Deaths: %s",
  countryMap@data$NAME, 
  countryMap@data$NumberOfDrugOverdoseDeaths 
) %>% lapply(HTML)

map %>% addPolygons(
  weight = 2,
  opacity = 1,
  fillColor = "lightblue",
  dashArray = "1",
  fillOpacity = 0.7,
  label = labels,
  highlight = highlightOptions(
    weight = 3,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE))

    })
    }