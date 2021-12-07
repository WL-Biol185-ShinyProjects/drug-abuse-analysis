library(shiny)
library(shinydashboard)
library(markdown)

homepagetext <-
    fluidRow(
      column(
        width = 7,
      box(
        width = NULL, 
        solidHeader = TRUE, 
        status = "primary",
        title = "What is Our Project?", 
        background = "blue",
        "Our project is an analysis into where the United States is at as a nation in the drug crisis. Specefically, we examine several of the financial factors that correlate with the increase in drug overdoses."
      ),
      box(
        title = "The Total Amount of Overdoses in Each State for January 2021",
        width = 15,
        leafletOutput("OverdoseMap"),
        "source"),
      column(
        width = 7,
      box(
        width = 7,
    img(src = "NYTPic.png",
    width = "100%"
)))))
