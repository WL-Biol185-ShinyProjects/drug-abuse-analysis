library(shiny)
library(leaflet)
library(tidyverse)
library(rgdal)
library(dplyr)
library(lubridate)
library("readxl")

geoIPC <- read.csv("geoIPC.csv")

#getting to the point to throw into Leaflet
InvestmentStates <- 
  fluidRow(
    box(
      titlePanel("Timeline of State Investment in Drugs"),
      "The Growth of Statewide Investment in Drugs in states per capita from 1991 to 2014",
      width = 12,
      leafletOutput("InvestmentOvertime"),
      sliderInput(inputId = "yearsforinvestment", label = "years", min(geoIPC$years), max(geoIPC$years), value = min(geoIPC$years), animate = TRUE)
    )
  )
