library(shiny)
library(leaflet)
library(tidyverse)
library(rgdal)
library(dplyr)
library(lubridate)
library("readxl")

geo@data <- read.csv("geo@data.csv")

#getting to the point to throw into Leaflet
InvestmentStates <- 
  fluidRow(
    box(
      titlePanel("Timeline of State Investment in Drugs"),
      "The Growth of Statewide Investment in Drugs in states per capita from 1991 to 2014",
      width = 12,
      leafletOutput("InvestmentOvertime"),
      sliderInput(inputId = "yearsforinvestment", label = "years", min(geo@data$years), max(geo@data$years), value = min(geo@data$years), animate = TRUE)
    )
  )
