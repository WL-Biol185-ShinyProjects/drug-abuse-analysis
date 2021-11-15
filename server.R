library(shiny)

#globalMean = read.delim("../global-mean.txt", header = TRUE)

function(input, output) {
  
  x = reactive({
    
  })
  
  output$histogram = renderPlot({
   
    x = if(input$distribution == "normal") {
      rnorm(100, input$number)
    } else if(input$distribution == "uniform") {
      runif(100, max = input$number)
    } else {
      rpois(100, lambda = input$number)
    }
    
    col = if(input$distribution == "normal") {
      "grey"
    } else if(input$distribution == "uniform") {
      "blue"
    } else {
      "green"
    }
    
    hist(x, col = col)
    
  })

  output$summary = renderText({
    
  })  
}
