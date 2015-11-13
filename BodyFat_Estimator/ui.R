
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Male Body Fat Estimator"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      numericInput("age","Age",min = 20,max = 80,value = 30),
      numericInput("height","Height",min = 36,max = 50,value = 72),
      numericInput("weight","Weight",min = 80,max = 400,value = 200),
      numericInput("neck","Neck",min=1,max=50,value=16),
      numericInput("abdomen","Abdomen",min = 1,max = 50,value = 36),
      numericInput("chest","Chest",min = 1,max = 50,value = 44),
      helpText("All measurements are in inches except age"),
      h4("Your % Body Fat"),
      h5(textOutput("bf"))
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("bfplot")
    )
  )
))
