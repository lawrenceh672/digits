#digits recognizer kaggle competition.

library(shiny)


shinyUI(
  fluidPage(
    titlePanel("digits"),
  
    # Sidebar with a slider input for number of sample, all sqaured
    sidebarLayout(
      sidebarPanel(
        h3("Load the data set"),
        submitButton("Load Data"),
        h3("Number of samples to start with"),
        sliderInput("samples","Number of samples:",min = 1,max = 10,value = 3)
        ),
    
    #Draw the
    mainPanel(
      plotOutput("numbers"),
      h3("sample Size"),
      textOutput("samples")
))))