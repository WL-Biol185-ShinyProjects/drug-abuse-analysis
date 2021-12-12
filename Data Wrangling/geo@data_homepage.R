library(shiny)
library(leaflet)
library(tidyverse)
library(rgdal)
library(dplyr)
library(lubridate)


Overdosemapdata <- read_csv("overdose_all.csv")

geo <- readOGR("states.geo.json")
#data filtering for year and month
OverdoseStateMaps <- filter(Overdosemapdata, Year == "2021", Month == "January")
write_csv(OverdoseStateMaps, "OverdoseStateMaps2021.csv")

#Merging in geo data
ODheatmapdata <- read.csv("overdose_heatmap.csv")
ODheatmapdata <- ODheatmapdata %>%
  filter(Year == "2021") %>%
  filter(Month == "January") %>%
  filter(Indicator != "NA")
ODheatmapdata$DataValue <- as.character(ODheatmapdata$DataValue)

geo@data <- left_join(geo@data, ODheatmapdata, by = c("NAME" = "StateName"))

write_csv(geo@data, "geoOverdoseStateHeatMaps.csv")