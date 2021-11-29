library(shiny)
library(shinydashboard)
library(markdown)

BigPharmaPerformanceText <-
  fluidPage(
    titlePanel("The Growth of Select Pharmecutical Companies as a Result of a Nationwide Push in Greater Prescribing for Pain"))

fluidRow(box(width      = 12,
             background = "navy",
             p("The line graph below demonstrates the obesity trends in each state from 2011-2018."))

sidebarLayout(
  sidebarPanel(
    checkboxGroupInput(
      "yearInput",
      "Choose the Year:",
      choices = list(
        "2011" = "2011",
        "2012" = "2012",
        "2013" = "2013",
        "2014" = "2014",
        "2015" = "2015",
        "2016" = "2016",
        "2017" = "2017",
        "2018" = "2018"
      ),
      selected = list("2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018"),
      inline   = TRUE),
    selectInput(inputId = "Pharmaceutical Company",
                label   = "Choose a Company:",
                choices = list(
                  "Alaska", "Alabama", "Arkansas", "Arizona", "California", "Colorado", "Connecticut", "DC", "Delaware", "Florida", "Georgia",
                  "GU", "Hawaii", "Iowa", "Idaho", "Illinois", "Indiana", "Kansas", "Kentucky", "Louisiana", "Massachusetts", "Maryland",
                  "Maine", "Michigan", "Minnesota", "Missouri", "Mississippi", "Montana", "North Carolina", "North Dakota", "Nebraska", "New Hampshire", "New Jersey",
                  "New Mexico", "Nevada", "New York", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "PR", "Rhode Island", "South Carolina", "South Dakota",
                  "Tennessee", "Texas", "US", "Utah", "Virginia", "VI", "Vermont", "Washington", "Wisconsin", "West Virginia", "Wyoming" 
                  
                  #Amneal (AMRX), Teva (TEVA), McKesson (MCK), Cardinal Health (CAH), Par Pharmaceuticals (PRX)
                ),
                selected  = "Alaska",
                selectize = TRUE,
                multiple  = FALSE
    ),
    textOutput("stateResult2")
  ),
  mainPanel(plotOutput("myLineGraph"))
)
)