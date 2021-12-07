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
write_csv(OverdoseStateMaps, "OverdoeseStateMaps2021.csv")

