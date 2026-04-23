library(shiny)
# other libraries here

# data loading and one-time processing here
tomato <- read_csv("Tomato.csv")

# Pivot tomato dataset, extracting the variables and values that we need
tomato.long <- tomato[c("species", "totleng", "petleng", "leafleng", "leafwid", "leafnum")] %>%
  pivot_longer(c(totleng, petleng, leafleng, leafwid, leafnum),
               names_to = "trait",
               values_to = "value"
  )

data(tomato.long)
# Define UI for application 

ui <- fluidPage( #create the overall page
    #UI code here
  
    titlePanel("Tomatooooo"),
    
    helpText("This application creates a violin plot to visualize the distribution of the data collected for different traits in different tomato plants."),
    
    sidebarLayout(
      sidebarPanel(
        selectInput("Species","Choose a Species:",
                  choices = c("S. pennellii","S. peruvianum","S. chilense","S. chmielewskii","S. habrochaites")),
      
        radioButtons("trait","Choose a trait to display:",
                     c("totleng",
                     "petleng",
                     "leafleng",
                     "leafwid",
                     "leafnum")),
    ),
    
    mainPanel(plotOutput("violinPlot")
      )
    )
  )
# Define server logic 
server <- function(input, output) {
  # Expression that generates a violin plot
  output$violinPlot <- renderPlot({
    plotSpecies <- as.name(input$Species)
    plotTrait <- as.name(input$trait)
   
     # Set up the plot
    tomato.long %>%
      filter(species == plotSpecies) %>%
      filter(trait == plotTrait )%>%
      ggplot(
        aes(x= trait, y= value, fill=trait)
      ) +
      geom_violin()
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
