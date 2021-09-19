library(shiny)

shinyUI(fluidPage(
    titlePanel("Predict Assaults from Murders"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderMurder", "What is the number of murders?", 0, 10, value = 10),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
        ),
        mainPanel(
            plotOutput("plot1"),
            h3("Predicted Assaults from Model 1:"),
            textOutput("pred1"),
            h3("Predicted Assaults from Model 2:"),
            textOutput("pred2")
        )
    )
))
