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
shinyServer(function(input, output) {
  data_loaded <<- 0 #not loaded it by default
  sample_size <<- 20  #default 20 all the training samples
  
  train<<-0
  t2<<-0
  t1<<-0
})
