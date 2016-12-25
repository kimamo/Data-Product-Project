 
library(shiny)
library(shinydashboard)
library(htmlwidgets)
library(rworldmap)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- shinyUI( 
 
  
  fluidPage(
   
   # Application title
    dashboardHeader(title = "Data Products Project Dec 25th 2016 : World Map with shinyUI"),
      # Show the plot  
       mainPanel(bootstrapPage(
        div(
          class = "outer",
          tags$style(
            type = "text/css",
            ".outer {position: fixed; top: 120px; left: 0; right: 0; bottom: 0; overflow: hidden; padding: 0}"
          ),
          
          plotOutput("worldMapPlot", width = "100%", height = "100%" ),
          absolutePanel(
            top = 60,
            right = 10,
            draggable = TRUE 
          )
        )
      )) 
      
   #)
))

# draw the map
server <- shinyServer(function(input, output) {
   
   output$worldMapPlot <- renderPlot({ 
      
      worldMap <- map_data(map="world")
      
      worldMap$name_len <- nchar(worldMap$region) + sample(nrow(worldMap))
      
      gg <- ggplot()
      gg <- gg + theme(legend.position="none")
      gg <- gg + ggtitle(expression("World Countries")) 
      gg <- gg + geom_map(data=worldMap, map=worldMap, aes(map_id=region, x=long, y=lat, fill=name_len))
      
      gg <- gg + scale_fill_gradient(low = "green", high = "brown3", guide = "colourbar")
      gg <- gg + coord_equal()
      gg
      
      
   })
})

# Run the application 
shinyApp(ui = ui, server = server)

