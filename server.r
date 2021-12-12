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
    #2021 leaflet map for drug overdose deaths on the homepage
    output$OverdoseMap <- renderLeaflet({
                     OverdoseStateMaps2021 <- read_csv("OverdoseStateMaps2021.csv")
                     countryMap <- rgdal::readOGR("states.geo.json")
                     countryMap@data <- left_join(countryMap@data, 
                             OverdoseStateMaps2021, 
                             by = c("NAME" = "StateName"))
                                            
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
                                             color = "black",
                                             fillOpacity = 0.7,
                                             label = labels,
                                                      highlight = highlightOptions(
                                                      weight = 3,
                                                      color = "black",
                                                      dashArray = "",
                                                      fillOpacity = 0.7,
                                                      bringToFront = TRUE
     ))
    })

    #Animated map for Prescription Drug Investment page 
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
    
    #Drug Overdose Leaflet on Prescription Drug Investment Page
    output$DrugOverdoseJan2015 <- renderLeaflet({
                    OverdoseDataJan2015 <- read.csv("OverdoseDataWPopEst2015.csv")
                    countryMap2 <- rgdal::readOGR("states.geo.json")
                    statespalette1 <- colorBin("Purples", domain = OverdoseDataJan2015$IOverdosePerCapita2015)
                    countryMap2@data <- left_join(countryMap2@data, OverdoseDataJan2015, by = c("NAME" = "StateName"))
      
                           map <- leaflet(countryMap2) %>%
                                   setView(-96, 37.8, 4)
      
                          labels <- sprintf(
                                "<strong>%s<strong><br>Number of Drug Overdose Deaths: %s",
                                 countryMap2@data$NAME, 
                                 countryMap2@data$NumberOfDrugOverdoseDeaths 
                                  ) %>% lapply(HTML)
      
                           map %>% addPolygons(
                           weight = 2,
                           opacity = 1,
                           fillColor = ~statespalette1(IOverdosePerCapita2015),
                           dashArray = "1",
                           fillOpacity = 0.7,
                           color = "black",
                           label = labels,
                                 highlight = highlightOptions(
                                             weight = 3,
                                             color = "black",
                                             dashArray = "",
                                             fillOpacity = 0.7,
                                             bringToFront = TRUE))
       
    })
    #Function for BigPharmaPerformance tab
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