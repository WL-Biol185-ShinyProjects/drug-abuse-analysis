library(shiny)
library(shinydashboard)
library(markdown)

homepagetext <-
    fluidPage(
      titlePanel("Drug Abuse Analysis Over the Past Three Decades in the United States"),
      column(width = 6,
             box(
               title = "Background on the Drug Crisis throughout the country", width = NULL, background = "blue",
               "Over the past several decades the United States has seen an exponential increase in drug abuse and ultimately drug overdose. Our project attempts to show the causation for this drug abuse growth is related to national movements initiated by drug companies toward over prescribing for pain mainagement. The ultimate mechanism causing this was a large scale marketing scheme by Pharmecutical companies as a means to maximize their profits. We will show not only how the overdoses have increased, by speceifc type, but also how the phermicutical companies invested more in marketing and ultimately made more profits at the downstream cost of human lives. We will also show how the majority of this was funded by federal and state healthcare programs which saw no problems with the increased investment in prescription drugs. The point of the project is to show there are several different systematic flaws that put the country in its current state of drug crisis."
             ),
             
    img(src = "NYTPic.png",
    height = "25%", width = "50%",
    align = "middle",
    style = "display: block; margin-left: auto; margin-right: auto;", 
    h5()
)))
