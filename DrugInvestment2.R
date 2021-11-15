library(shiny)
library(leaflet)
library(tidyverse)
library(rgdal)
library(dplyr)

library("readxl")
StateInvestmentInDrugs <- read_excel("StateInvestmentInDrugs.xlsx")

#Getting rid of regional rows
UpdatedSIID <- StateInvestmentInDrugs[-c(2, 3, 10, 17, 23, 31, 44, 49, 55), ]

names(UpdatedSIID) <- as.matrix(UpdatedSIID[1, ])
UpdatedSIID <- UpdatedSIID[-1, ]
UpdatedSIID [] <- lapply(UpdatedSIID, function(x) type.convert(as.character(x)))

UpdatedSIID <- UpdatedSIID[-c(26)]

names(UpdatedSIID)[names(UpdatedSIID) == 'Region/state of residence'] <- 'States'

#Loading state map
geo <- readOGR("states.geo.json")
#Joining state map with investment in Drug data

newData  <- left_join(geo@data, UpdatedSIID, by = c("NAME" = "States"))
geo@data <- newData
View(geo@data)

#Loading data for US population over the given years
devtools::install_github("nsgrantham/uspops")

library(uspops)

View(state_pops)
#Filtering for the given years
NewPops <- state_pops %>%
  select(year, state, pop) %>%
  filter(year > "1990" & year < "2015")
View(NewPops)
#data cleanup
NewPops2 <- spread(NewPops, key = year, value = pop)
View(NewPops2)

NewPops5 <- NewPops2 %>% gather("years", "pops", 2:25)
View(NewPops5)

geo@data <- geo@data %>% gather("years", "Investments", 6:29)
View(geo@data)

geo@data$Investments <- geo@data$Investments * 1000000
View(geo@data)
#Joining population data to main data set
NewData3 <- left_join(geo@data, NewPops5, by = c("NAME" = "state", "years" = "years"))
geo@data <- NewData3
View(geo@data)
#Getting rid of lack of data for Puerto Rico
geo@data <- geo@data %>%
  filter(NAME != "Puerto Rico")
#creating investment per capita column
geo@data$InvestmentPerCapita <- geo@data$Investments / geo@data$pops
View(geo@data)

geo@data$years <- as.numeric(geo@data$years)
View(geo@data)

#getting to the poin to throw into Leaflet
InvestmentStates <- 
  fluidRow(
    box(
      titlePanel("Timeline of State Investment in Drugs"),
      "The Growth of Statewide Investment in Drugs in the United States from 1991 to 2014 using a log scale to view the change in values.",
      width = 12,
      leafletOutput("InvestmentOvertime"),
      sliderInput("yearsforinvestment", "year", min(geo@data$years), max(geo@data$years), value = min(geo@data$years), animate = TRUE)
    )
  )
