##--- AFL Total Score betting application

# Load required libraries

    library(shiny)
    library(ggplot2)
    library(dplyr)
    library(readxl)

# Read the required data

    dAfl <- read_excel(path = "./data/aflApp.xlsx", sheet = "Data", skip = 0)
    
    shinyAfl<- dAfl %>%
        mutate( total.score=score+opp.score,
                total.diff=total.score-total.score.close)
    
    # Only keep rows with all values populated
    shinyAfl<-shinyAfl [complete.cases(shinyAfl),]

## ---- Shiny application Start - Server code
    
shinyServer(
    function(input, output) {
    
    # Only keep data for the selected team
    dataset <- reactive({filter(shinyAfl, team==input$team) })
    
    # Calc the min and max of the Total predicted score
    dataMin <- reactive({min(dataset()$total.score.close)})
    dataMax <- reactive({max(dataset()$total.score.close)})
    
    # Filter the data for the selected range to calculated certain metrics
    rangeData <- reactive({
        filter(dataset(),total.score.close <= input$totalRange[2],total.score.close >= input$totalRange[1]) })
    
    rangeMean <- reactive({mean(rangeData()$total.diff)})
    
    # data for the average line to be drawnbetween the range lines
    meanline <- reactive({data.frame(x1 = input$totalRange[1], x2 = input$totalRange[2], 
                                     y1 = rangeMean(), y2 = rangeMean())})

    # Create the range selector here because it depends on the data selected
    output$rangeSelector <- renderUI({
    sliderInput('totalRange', 'Select a Total Score range', min=dataMin()-3, max=dataMax()+3,
                value=c(dataMin()-3,dataMax()+3))
    })
    
    # Create the plot
    output$plot <- renderPlot({

        p <- ggplot(dataset(), aes(x=total.score.close, y=total.diff)) + geom_point() +
             geom_hline(yintercept = 0,color="blue",size=0.7) +
             ggtitle("Total Predicted Score vs. Real Score Difference") +
             xlab("Total Score as predicted by betting agency") +
             ylab("Difference between predicted total score and real total score")
        
        if (input$smooth)
            p <- p + geom_smooth(size=0.5,color="purple")  

        # Display vertical lines according to selected range
        if (!is.null(input$totalRange)) {
            p <- p + geom_vline(xintercept = input$totalRange[1],color="seagreen",size=2) +
                     geom_vline(xintercept = input$totalRange[2],color="seagreen",size=2) +
                geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2),color="seagreen", size=1, data = meanline())
            }
        
        print(p)
        
    }, height=400)

    # And create the table with calculated information
    output$tablevalues <- renderTable({
        # Compose data frame
        
        if (is.null(input$totalRange)) {return()}
        
        data.frame(
            Name = c("Betting Total Score Range",
                     "Avg. Total Score Difference",
                     "# Total Score Over",
                     "# Total Score Under"),
            Team = as.character(c( paste(dataMin()," to ", dataMax()),
                                   round(mean(dataset()$total.diff),2),
                                   sum(dataset()$total.diff > 0),
                                   sum(dataset()$total.diff < 0))), 
            Range = as.character(c(paste(input$totalRange[1]," to ", input$totalRange[2]),
                                   round(rangeMean(),2),
                                   sum(rangeData()$total.diff > 0),
                                   sum(rangeData()$total.diff < 0))), 
            stringsAsFactors=FALSE)
        
        })

    })