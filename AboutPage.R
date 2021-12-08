library(shiny)
library(shinydashboard)
library(markdown)

AboutPageText <-
  fluidPage(
          fluidRow(
            column(
              width = 6,
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
           column(
             width = 6,
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
