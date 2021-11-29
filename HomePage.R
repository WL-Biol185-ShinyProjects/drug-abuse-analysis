library(shiny)
library(shinydashboard)
library(markdown)

homepagetext <-
    fluidPage(
      titlePanel("Drug Abuse Analysis Over the Past Three Decades in the United States"),
      column(width = 6,
             box(
               title = "Background on the Drug Crisis throughout the country", width = NULL, background = "blue",
               "Over the past several decades the United States has seen an exponential increase in drug abuse and ultimately drug overdose. Our project attempts to show there is a correlation between the increased number of drug overdoses and an increased financial gain for major drug companies. The ultimate mechanism causing this was a large scale marketing scheme by Pharmecutical companies toward more prescribing for pain. This likely occured as a means to maximize their profits. We will show the increased invesment in prescription drugs by showing how much government programs have increased their spending on prescription drugs over the past few decades. The point of the project is to show some of the different finiancial influences that put the country in its current state of drug crisis."
             ),
             
    img(src = "NYTPic.png",
    height = "25%", width = "50%",
    align = "middle",
    style = "display: block; margin-left: auto; margin-right: auto;", 
    h5()
)))
