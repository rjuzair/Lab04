library(shiny)
library(swedishairquality)

server <- function(input, output, session) {

    pm10 <- aqiGet()

    city_data <- reactive({
        pm10[[as.numeric(input$city)]]
    })

    output$Plot <- renderPlot({
        df <- city_data()
        plot(df, col = "blue", xlab = "Time", ylab = "PM10 (µg/m³)")
        abline(h = mean(df$value), col = "red")
    })
}
