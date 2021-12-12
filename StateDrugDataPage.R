library(shiny)
library(shinydashboard)
library(markdown)

# Read in 2021 provisional overdose data from CDC
geoOverdoseStateHeatMaps2021 <- read.csv("geoOverdoseStateHeatMaps.csv")

StateDrugData <-
  fluidPage(
    titlePanel("Current Drug Overdose Counts by Drug Group and Subgroup"),
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
          title = "Overdoses Related to a Specific Drug Type during 12 month period ending in January 2021",
          leafletOutput("OverdoseSpecificMap"),
          "You can scroll over each state to view the total number of drug overdose deaths for that state in 2021.")
    )
  )
