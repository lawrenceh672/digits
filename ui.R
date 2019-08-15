#digits recognizer kaggle competition.

library(shiny)


shinyUI(fluidPage(
  titlePanel("digits"),
  
  # Sidebar with a slider input for number of sample, all sqaured
  sidebarLayout(
    sidebarPanel(
      actionButton("load_button", "Load sample Data"),
      sliderInput("samples",
                   "Number of samples:",
                   min = 1,
                   max = 10,
                   value = 3)
    ),
    
    #Draw the
    mainPanel(
       plotOutput("numbers")
    )
  )
))
