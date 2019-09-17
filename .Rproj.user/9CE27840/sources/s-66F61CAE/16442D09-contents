#digits recognizer kaggle competition.

library(shiny)


shinyUI(
  fluidPage(
    titlePanel("digits"),
  
    # Sidebar with a slider input for number of sample, all sqaured
    sidebarLayout(
      sidebarPanel(
        textInput(inputID="file_path", "path", value="\data\train.csv"),
        h3("Number of samples to start with"),
        sliderInput("samples","Number of samples:",min = 1,max = 10,value = 3)
        ),
      #Draw the
      mainPanel(
        plotOutput(outputID = "status")
      )
    )
  )
)