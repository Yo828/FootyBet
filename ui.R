library(shiny)
library(ggplot2)
library(dplyr)
library(readxl)
library(markdown)

# Read the data here so that the teamlist can be created
dAfl <- read_excel(path = "./data/aflApp.xlsx", sheet = "Data", skip = 0)
teamlist <- sort(unique(dAfl$team))

shinyUI(navbarPage(title = "Exploring AFL Total Score betting",
    
   tabPanel("About",
            fluidRow(
                column(6,offset = 3,
                       includeMarkdown("about.md"))
            )),  
                   
   tabPanel("Chart", 
       sidebarPanel(
            selectInput('team', 'Select Team', teamlist),
            br(), br(),
            checkboxInput('smooth', 'Add Smoother'),
            br(), br(),
            uiOutput("rangeSelector")
        ),
    
        mainPanel(
            plotOutput('plot'), br(), br(),
            tableOutput('tablevalues')
        )
      )
))


                                       