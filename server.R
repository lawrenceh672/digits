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
  data_loaded <- 0
  sample_size <- 42000  #default 42000 all the training samples
  rect(0,0,10,10, border="red", col = "blue") #blue is not loaded
  text(0,0, "Not Loaded")
  
  output$numbers <- renderPlot({
  })
  
  observeEvent(input$load_button, {
    #draw a green box
    rect(0,0,100,100, border="green", col = "green")
    data_loaded <- 1 #now its true, presumably.
  })
})
