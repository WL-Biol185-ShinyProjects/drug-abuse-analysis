library(shiny)
library(leaflet)
library(tidyverse)
library(rgdal)
library(dplyr)
library(lubridate)
library("readxl")

geo <- readOGR("states.geo.json")
geoIPC <- read.csv("geoIPC.csv")

#getting to the point to throw into Leaflet
InvestmentStates <- 
  fluidPage( titlePanel("State Investment in Prescription Drugs"),
    fluidRow(
      column( width = 12,
         box(
            width = NULL,
              titlePanel("How Did the United States Get Here?"),
              "Timeline of State Investment in Drugs",
               leafletOutput("InvestmentOvertime"),
               sliderInput(inputId = "yearsforinvestment", label = "years", min(geoIPC$years), max(geoIPC$years), value = min(geoIPC$years), step = TRUE, animate = TRUE, sep = NULL),
              "The Growth of Statewide Investment in Drugs in states per capita from 1991 to 2014. The states darken as the investment per capita rises."
    ))),
    fluidRow(
      column( width = 12,
            box(
                 width = NULL,
                 titlePanel("Where Did this Leave the United States?"), 
                 "Drug Overdose Deaths Per Capita January 2015",
                 leafletOutput("DrugOverdoseJan2015"),
                 "The darker states indicate a higher amount of drug overdose deaths per capita. If you scroll over you can see the total number of drug overdose deaths for that state in January of 2015."
        
      )
    )),
    fluidRow(
      column( width = 12,
              box(
                width = NULL,
                titlePanel("What Does it Mean?"),
                background = "blue",
                "The maps were meant to show how the rise in state funded investments in prescription drugs over the past two plus decades correlates with large amounts of drug overdose deaths per capita. This tends to be true for states like West Virginia, Ohio, Kentucky, Pennsylvania and Tennessee."
              )  
    )
    ))

