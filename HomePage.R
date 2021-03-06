library(shiny)
library(shinydashboard)
library(markdown)
#organizing home page
homepagetext <-
  fluidPage(
     titlePanel(h1("Home", align = "center")),
       fluidRow(
          column(
            width = 12,
                 box(
                    width = NULL, 
                    solidHeader = TRUE, 
                    status = "primary",
                    title = "What is Our Project?", 
                    background = "blue",
                    "Our project is a data analysis into where the United States is at presently in the drug crisis and several economic factors that may have contributed to it getting here. To examine the effects of the crisis we look at factors such as the total amount of drug overdose deaths over a given time period and the number of drug overdoses for specefic drugs. Economically, we look at the investment in drugs by Medicare and Medicaid from 1991 to 2014. We also examine the economic growth of some of the biggest pharmaceutical companies over the years when the drug crisis has most taken its toll."),
      
            fluidRow(
                     column( 
                        width = 12,
                            box(
                              width = NULL,
                              title = "The Total Amount of Overdose Deaths in Each State for January 2021",
                              leafletOutput("OverdoseMap"),
                              "You can scroll over each state to view the total number of drug overdose deaths for that state in 2021.")),
                     # column(
                     #     width = 4,
                     #           img(src = "NYTPic.png",
                     #                   width = "100%",
                     #                   length = "100%"),
          )
       )
          ),
     mainPanel(h3("Current Opioid Epidemic News from Alcoholism and Drug Abuse Weekly Publication", align = "center"),
       fluidRow(column(width = 12,
                               tags$head(tags$script('!function(d,s,id){var js,fjs=d.getElementsByTagName(s)    [0],p=/^http:/.test(d.location)?\'http\':\'https\';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");')),
                               column(width = 12, box(width = NULL, height = NULL,
                                                     a("Tweets by @ADAWnews", class = "twitter-timeline", href = "https://twitter.com/ADAWnews")
                               ))
     )
     ))
  )
