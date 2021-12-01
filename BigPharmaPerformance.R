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
#       "Choose the Year:",
#       choices = list(
#         "2011" = "2011",
#         "2012" = "2012",
#         "2013" = "2013",
#         "2014" = "2014",
#         "2015" = "2015",
#         "2016" = "2016",
#         "2017" = "2017",
#         "2018" = "2018"
#       ),
#       selected = list("2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018"),
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