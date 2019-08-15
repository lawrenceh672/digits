#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(graphics)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  data_loaded <<- 0 #not loaded it by default
  sample_size <<- 20  #default 20 all the training samples
  
  #the sample size reactor
  sample_size_reactor<-reactive({
    sample_size<-input$samples**2 #sqaure it for square pictures
    sample_size
  })
    
  output$numbers <- renderPlot({
  if(data_loaded == FALSE){
    rect(0,0,100,100, border="red", col = "blue") #blue is not loaded
    text(0,0, "Not Loaded")
    data_loaded<-TRUE
    }
  
  if(data_loaded == TRUE) {
      rect(0,0,100,100, border="blue", col = "red") #blue is not loaded
      text(0,0, "Loaded")
      data_loaded=2
    }
  })
  
  output$samples <- renderText({
    sample_size_reactor()
  })
})
