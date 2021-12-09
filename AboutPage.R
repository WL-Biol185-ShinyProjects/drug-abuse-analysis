library(shiny)
library(shinydashboard)
library(markdown)

AboutPageText <-
  fluidPage(
    titlePanel("Where Do We Go From Here?"),
        fluidRow(
           column( 
             width = 12,
                  box(
                     width = NULL,
                     img(src = "What Can You do to prevent.jpeg",
                     width = "100%",
                     length = "100%"
      )))),
          fluidRow(
              column( width = 6,
                 box(
                   width = NULL,
                   solidHeader = TRUE, 
                   status = "primary",
                   title = "Sources", 
                   background = "blue",
                   a("Centers for Medicare and Medicaid Services, Office of the Actuary, National Health Statistics Group.", href = "https://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/NationalHealthExpendData", style = "color:LightGray;"),
                   br(),
                   a("New York Times", href = "https://www.nytimes.com/2021/11/17/health/drug-overdoses-fentanyl-deaths.html", style = "color:LightGray;"),
                   br(),
                   a("Wharton Research Data Services, Compustat North America, Security Monthly", href = "https://wrds-www.wharton.upenn.edu", style = "color:LightGray;"),
                   br(),
                   a("Center for Disease Control", href = "https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm", style = "color:LightGray;"),
                   br()
              )
            ),
              column( width = 6,
                 box(
                     width = NULL,
                     solidHeader = TRUE, 
                     status = "primary",
                     title = "Project Background", 
                     background = "blue",
                     "This project was created by Bryson Parker and Jeremiah Kohl. We would like to give a special thanks to Professor Whitworth and our classmates for their assistance and guidance on our project."
             )
           )
            )
          )
