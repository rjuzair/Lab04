# SMHI timeseries ids for PM10 at one station per city, in the order returned
# by aqiGet(): Linkoping (Hamngatan), Stockholm (Hornsgatan), Malmo, Gothenburg,
# Lulea and Umea.
stations <- data.frame(
  city = c("Linkoping", "Stockholm", "Malmo", "Gothenburg", "Lulea", "Umea"),
  timeseries_id = c(5714, 59, 4470, 481, 179, 4335),
  stringsAsFactors = FALSE
)

#' PM10 air quality for six Swedish cities
#'
#' Returns PM10 particulate-matter readings for Linkoping, Stockholm, Malmo,
#' Gothenburg, Lulea and Umea.
#'
#' By default the function returns the bundled, **simulated** dataset
#' [pm10_sample], so examples, tests and the Shiny app work offline. The
#' original data source, SMHI's 52North REST API at
#' `https://datavardluft.smhi.se/52North/api/v1`, no longer returns data
#' there. To fetch live data, set `source = "live"` and point `base_url` (or
#' the option `swedishairquality.base_url`) at a working 52North timeseries
#' API.
#'
#' @param source `"sample"` (default) for the bundled simulated data, or
#'   `"live"` to download from the API.
#' @param months Number of months of history to request in live mode.
#' @param end_date Last date to request in live mode.
#' @param base_url Base URL of a 52North timeseries REST API (live mode).
#' @return A list of six data frames (Linkoping, Stockholm, Malmo, Gothenburg,
#'   Lulea, Umea), each with columns `timestamp` and `value` (PM10, ug/m3).
#' @references
#' https://www.naturvardsverket.se/amnesomraden/luft/statistik--utslapp-och-halter/luftkvaliteten-i-realtid-och-preliminar-statistik/webbtjanster-luftkvalitetsdata
#' @examples
#' pm10 <- aqiGet()
#' head(pm10[[1]])   # Linkoping
#' @export
aqiGet <- function(source = c("sample", "live"),
                   months = 3,
                   end_date = Sys.Date(),
                   base_url = getOption("swedishairquality.base_url",
                                        "https://datavardluft.smhi.se/52North/api/v1")) {
  source <- match.arg(source)

  if (source == "sample") {
    data <- swedishairquality::pm10_sample
    return(lapply(stations$city, function(city) {
      city_data <- data[data$city == city, c("timestamp", "value")]
      rownames(city_data) <- NULL
      city_data
    }))
  }

  lapply(stations$timeseries_id, fetch_timeseries,
         months = months, end_date = end_date, base_url = base_url)
}

# Download one timeseries and return a data frame of timestamp and value.
fetch_timeseries <- function(timeseries_id, months, end_date, base_url) {
  url <- paste0(base_url, "/timeseries/", timeseries_id,
                "/getData?timespan=P", months, "M/", end_date)
  response <- fetch_raw(url)

  if (response$status != 200 || !grepl("json", response$type, fixed = TRUE)) {
    stop("The air quality API did not return JSON for timeseries ", timeseries_id,
         " (HTTP ", response$status, ", ", response$type, "). ",
         "The endpoint may have moved: set options(swedishairquality.base_url = ...) ",
         "or use aqiGet(source = \"sample\").", call. = FALSE)
  }

  values <- as.data.frame(jsonlite::fromJSON(response$body)$values)
  stats::na.omit(values)
}

# Thin wrapper around httr so tests can replace the network call.
fetch_raw <- function(url) {
  response <- httr::GET(url)
  list(status = httr::status_code(response),
       type = httr::http_type(response),
       body = httr::content(response, as = "text", encoding = "UTF-8"))
}
