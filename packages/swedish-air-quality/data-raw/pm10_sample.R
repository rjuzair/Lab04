# Generates data/pm10_sample.rda: SIMULATED hourly PM10 readings.
#
# The SMHI endpoint the package was written against no longer returns data,
# so the package ships this simulated dataset to keep its examples, tests and
# Shiny app working offline. The values are NOT real measurements: they are
# drawn from a log-normal AR(1) process with a daily traffic cycle, around
# city-level means chosen to be in a plausible range for Swedish urban PM10.

set.seed(2021)

cities <- c("Linkoping", "Stockholm", "Malmo", "Gothenburg", "Lulea", "Umea")
mean_level <- c(14, 18, 17, 16, 11, 10)   # ug/m3, illustrative only
timestamps <- seq(as.POSIXct("2021-06-27 00:00", tz = "UTC"),
                  as.POSIXct("2021-09-24 23:00", tz = "UTC"), by = "hour")

simulate_city <- function(city, level) {
  n <- length(timestamps)
  noise <- as.numeric(stats::arima.sim(list(ar = 0.9), n = n, sd = 0.2))
  hour <- as.integer(format(timestamps, "%H"))
  daily_cycle <- 0.15 * sin((hour - 8) / 24 * 2 * pi)
  data.frame(
    city = city,
    timestamp = timestamps,
    value = round(level * exp(noise + daily_cycle), 1),
    stringsAsFactors = FALSE
  )
}

pm10_sample <- do.call(rbind, Map(simulate_city, cities, mean_level))
rownames(pm10_sample) <- NULL
save(pm10_sample, file = "data/pm10_sample.rda", compress = "xz")
