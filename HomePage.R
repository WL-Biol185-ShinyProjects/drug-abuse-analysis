library(shiny)
library(shinydashboard)
library(markdown)

homepagetext <-
  fluidPage(  
       fluidRow(
          column(
            width = 12,
                 box(
                    width = NULL, 
                    solidHeader = TRUE, 
                    status = "primary",
                    title = "What is Our Project?", 
                    background = "blue",
                    "Our project is an analysis into where the United States is at as a nation in the drug crisis. Specefically, we examine several of the financial factors that correlate with the increase in drug overdoses."),
      fluidRow(
           column( 
             width = 8,
      box(
        width = NULL,
        title = "The Total Amount of Overdoses in Each State for January 2021",
        leafletOutput("OverdoseMap"),
        "source")),
      column(
        width = 4,
    img(src = "NYTPic.png",
    width = "100%",
    length = "100%"
))))))
