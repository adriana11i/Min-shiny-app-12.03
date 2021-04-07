library(shiny)
library(shinythemes)
library(tidyverse)
library(readxl)

passat <- read_excel("passat.xlsx")


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Dataanalyse 2021", title = div(img(height = 100, width = 125, src = "Dania logo.jpg"))),
    
    theme = shinytheme("cosmo"),
    
    headerPanel("Dette er vores web app"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        
        sidebarPanel("",
                     selectInput("xaxis", label = "Vælg x-akse", choices = names(passat), selected = "km_per_liter", TRUE, multiple = FALSE),
                     selectInput("yaxis", label = "Vælg y-akse", choices = names(passat), multiple = FALSE),
                     selectInput("data_input", label = "Vælg datasæt", choices = c("mtcars", "faithful", "iris"))),
           
        # Show a plot of the generated distribution
        mainPanel("",
                  
                  tabsetPanel(id = "tabs",
                              tabPanel("Plot", plotOutput("plot")),
                              tabPanel("Tabel", tableOutput("tabel"))))
    
    )
    )

# Define server logic required to draw a histogram
server <- function(input, output, session) {

    output$plot <- renderPlot({
        
     ggplot(passat, aes_string(x = as.name(input$xaxis), y = as.name(input$yaxis))) +
            geom_point()
    
     })
    
    getdata <- reactive({
        
        get(input$data_input, "package:datasets")
        
    })
    
    output$tabel <- renderTable({head(getdata())})
    
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)


