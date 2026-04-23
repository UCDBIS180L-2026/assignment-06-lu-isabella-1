library(shiny)
# other libraries here

# data loading and one-time processing here
tomato <- read_csv("Tomato.csv")

# Define UI for application 
ui <- fluidPage( #create the overall page
    #UI code here
  )


# Define server logic 
server <- function(input, output) {
  # server code here
}

# Run the application 
shinyApp(ui = ui, server = server)
