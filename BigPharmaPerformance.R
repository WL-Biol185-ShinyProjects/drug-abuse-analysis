library(shiny)
library(shinydashboard)
library(markdown)

BigPharmaPerformanceText <-
  fluidPage(
    titlePanel("The Growth of Select Pharmecutical Companies as a Result of a Nationwide Push in Greater Prescribing for Pain"))

# fluidRow(box(width      = 12,
#              background = "navy",
#              p("The line graph below demonstrates the percent chnage in monthly clsoing share price for major pharmaceutical companies with ties to the Opioid Ecpidemic."))
# 
# sidebarLayout(
#   sidebarPanel(
#     checkboxGroupInput(
#       "yearInput",
#       "Select one or more Pharmaceutical Companies:",
#       choices = list(
#         "AMRX" = "2011",
#         "CAH" = "2012",
#         "MCK" = "2013",
#         "PRX" = "2014",
#         "TEVA" = "2015"
#       ),
#       selected = list("2011", "2012", "2013", "2014", "2015"),
#       inline   = TRUE),
#     selectInput(inputId = "Pharmaceutical Company",
#                 label   = "Choose a Company:",
#                 choices = list(
#                   "AMRX", "TEVA", "MCK", "CAH", "PRX"
# 
#                   #Amneal (AMRX), Teva (TEVA), McKesson (MCK), Cardinal Health (CAH), Par Pharmaceuticals (PRX)
#                 ),
#                 selected  = "AMRX",
#                 selectize = TRUE,
#                 multiple  = FALSE
#     ),
#     textOutput("stateResult2")
#   ),
#   mainPanel(plotOutput("myLineGraph"))
# )
# )