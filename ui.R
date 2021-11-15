library(shiny)
fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("number",
                  label = "Choose a number",
                  min = 0,
                  max = 100,
                  value = 50
                  ),
      selectInput("distribution",
                  label = "Choose a distribution",
                  choices = c("normal", "uniform", "poisson"))
    ),
  mainPanel(
    plotOutput("histogram"),
    textOutput("summary")
  )
    )
)