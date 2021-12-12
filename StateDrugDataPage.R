library(shiny)
library(shinydashboard)
library(markdown)

# Read in 2021 provisional overdose data from CDC
geoOverdoseStateHeatMaps2021 <- read.csv("geoOverdoseStateHeatMaps.csv")
geoOverdoseStateHeatMaps2021 <- geoOverdoseStateHeatMaps2021 %>%
  arrange(Indicator)

StateDrugData <-
  fluidPage(
    titlePanel("Current Drug Overdose Counts by Specific Drug Type from January 2020-2021"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "Indicator",
          label = "Select one drug group or subgroup:",
          choices = unique(geoOverdoseStateHeatMaps2021$Indicator),
          selected = 'Number of Drug Overdose Deaths',
          multiple = FALSE)),
      mainPanel(
            width = NULL,
            leafletOutput("OverdoseSpecificMap"),
            "You can scroll over each state to view the total number of drug overdose deaths for that state during the 12 month period ending in January 2021.
            Provisional overdose counts sourced from CDC's Vital Statistics Rapid Release program."))
    )
