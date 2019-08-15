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
   
  output$numbers <- renderPlot({
  })
  
  observeEvent(input$load_button, {
    session$sendCustomMessage(type = 'testmessage',
                              message = 'Thank you for clicking')
    #draw a green box
    rect(100, 400, 125, 450, col = "green", border = "blue") # coloured
  })
})
