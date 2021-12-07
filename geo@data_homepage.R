library(shiny)
library(leaflet)
library(tidyverse)
library(rgdal)
library(dplyr)
library(lubridate)


Overdosemapdata <- read_csv("overdose_all.csv")

geo <- readOGR("states.geo.json")

Overdosemapdata$NumberOfDrugOverdoseDeaths <- as.character(Overdosemapdata$NumberOfDrugOverdoseDeaths)

OverdoseStateMaps <- filter(Overdosemapdata, Year == "2021", Month == "January")

geo@data <- left_join(geo@data, OverdoseStateMaps, by = c("NAME" = "StateName"))

write_csv(geo@data, "geoOverdoseStateMaps.csv")
