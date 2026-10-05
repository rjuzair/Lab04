library(shiny)
library(swedishairquality)

server <- function(input, output, session) {

    city_data <- reactive({
        as.data.frame(aqiGet()[[as.numeric(input$city)]])
    })

    output$Plot <- renderPlot({
        df <- city_data()
        plot(df, col = "blue", xlab = "Time", ylab = "PM10 (µg/m³)")
        abline(h = mean(df$value), col = "red")
    })
}
