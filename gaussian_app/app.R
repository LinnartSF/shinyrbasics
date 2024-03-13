library(shiny)
library(ggplot2)

# USER INTERFACE --------------------------------------------------------------
ui <- fluidPage(
  titlePanel("Normal Distribution Plot"),
  
  sidebarLayout(
    
    # USER INPUT -----------------
    sidebarPanel(
      numericInput("mu", "Mean (MU):", value = 0),
      numericInput("sigma", "Standard Deviation (SIGMA):", value = 1),
      actionButton("plotButton", "Plot")
    ),
    
    # SIMULATION RESULTS
    mainPanel(
      plotOutput("normalPlot")
    )
  )
)

# SERVER ----------------------------------------------------------------------
server <- function(input, output) {
  output$normalPlot <- renderPlot({
    req(input$plotButton)
    
    x <- seq(-5, 5, length.out = 100)
    y <- dnorm(x, mean = input$mu, sd = input$sigma)
    
    ggplot() +
      geom_line(aes(x, y), color = "blue") +
      labs(title = "Normal Distribution Plot",
           x = "x",
           y = "Density")
  })
}

# APPLICATION -----------------------------------------------------------------
shinyApp(ui = ui, server = server)