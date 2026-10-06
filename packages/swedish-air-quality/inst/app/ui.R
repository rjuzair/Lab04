library(shiny)
shinyUI(fluidPage(
    
    # Application title
    titlePanel("PM10 air quality in Swedish cities"),
    
    sidebarLayout(
        sidebarPanel(
            radioButtons("city",
                         "Select City",
                         choices = c( "Linkoping" = "1", "Stockholm" = "2", "Malmo" = "3",
                                      "Gothenburg" = "4", "Lulea" = "5", "Umea" = "6"),
                         selected = ("Linkoping" = "1")
            )
        ),
        
        mainPanel(
            plotOutput("Plot"),
            helpText("Showing the bundled simulated sample data (not real measurements).")
        )
    )
))
