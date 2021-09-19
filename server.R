library(shiny)

shinyServer(function(input, output) {
    USArrests$Murdersp <- ifelse(USArrests$Murder - 1 > 0, USArrests$Murder - 1, 0)
    model1 <- lm(Assault ~ Murder, data = USArrests)
    model2 <- lm(Assault ~ Murdersp + Murder, data = USArrests)
    
    model1pred <- reactive({
        MurderInput <- input$sliderMurder
        predict(model1, newdata = data.frame(Murder = MurderInput))
    })
    
    model2pred <- reactive({
        MurderInput <- input$sliderMurder
        predict(model2, newdata = 
                    data.frame(Murder = MurderInput,
                               Murdersp = ifelse(MurderInput - 1 > 0,
                                              MurderInput - 1, 0)))
    })
    output$plot1 <- renderPlot({
        MurderInput <- input$sliderMurder
        
        plot(USArrests$Murder,USArrests$Assault, xlab = "Murders",
             ylab = "Assaults", bty = "n", pch = 16,
             xlim = c(0, 20), ylim = c(40, 350))
        if(input$showModel1){
            abline(model1, col = "pink", lwd = 2)
        }
        if(input$showModel2){
            model2lines <- predict(model2, newdata = data.frame(
                Murder = 0:20, Murdersp = ifelse(0:20 - 1 > 0, 0:20 - 1, 0)
            ))
            lines(0:20, model2lines, col = "blue", lwd = 2)
        }
        legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
               col = c("pink", "blue"), bty = "n", cex = 1.2)
        points(MurderInput, model1pred(), col = "pink", pch = 16, cex = 2)
        points(MurderInput, model2pred(), col = "blue", pch = 16, cex = 2)
    })
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
        model2pred()
    })
})
