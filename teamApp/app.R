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
    #UI code here:
  
    #Create title for our app
    titlePanel("Explore Tomato Traits in Different Species:)"),
    
    #some helpful information for user 
    helpText("This application creates a violin plot to visualize the distribution of the data collected for different traits in different tomato plants."),
    
    #sidebar setup: 2 types:1. pull down for select species. 2. radiobox to select trait. 
    sidebarLayout(
      sidebarPanel(
        #first pull down for species selection
        selectInput("Species","Choose a Species:", 
                  choices = c("S. pennellii","S. peruvianum","S. chilense","S. chmielewskii","S. habrochaites")),
        #radio box for trait selection 
        radioButtons("trait","Choose a trait to display:",
                     c("totleng",
                     "petleng",
                     "leafleng",
                     "leafwid",
                     "leafnum")),
    ),
    #show violin plot for selected species and traits. 
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
