library(shiny)
library(leaflet)
library(tidyverse)
library(rgdal)
library(dplyr)
library(lubridate)
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


#Loading data for US population over the given years
devtools::install_github("nsgrantham/uspops")

library(uspops)

write.csv(NewPops, 'Statepops')

state_pops <- read.csv("Statepops")

geo@data <- geo@data %>% gather("years", "Investments", 6:29)

#Filtering for the given years
NewPops <- state_pops %>%
  select(year, state, pop) %>%
  filter(year > "1990" & year < "2015")

#data cleanup
NewPops2 <- spread(NewPops, key = year, value = pop)


NewPops5 <- NewPops2 %>% gather("years", "pops", 2:25)

geo@data$Investments <- geo@data$Investments * 1000000

#Joining population data to main data set
NewData3 <- left_join(geo@data, NewPops5, by = c("NAME" = "state", "years" = "years"))

geo@data <- NewData3

#Getting rid of lack of data for Puerto Rico
geo@data <- geo@data %>%
  filter(NAME != "Puerto Rico")
#creating investment per capita column
geo@data$InvestmentPerCapita <- geo@data$Investments / geo@data$pops

geo@data$InvestmentPerCapita <- as.numeric(unlist(geo@data$InvestmentPerCapita))
geo@data$years <- as.numeric(unlist(geo@data$years))

write.csv(geo@data, 'geoIPC.csv')