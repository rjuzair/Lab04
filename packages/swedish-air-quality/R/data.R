#' Simulated hourly PM10 readings for six Swedish cities
#'
#' **These values are simulated, not real measurements.** They were generated
#' (see `data-raw/pm10_sample.R`) from a log-normal autoregressive process with
#' a daily cycle, around city-level means in a plausible range for Swedish urban
#' PM10, so that the package works offline after its original data source,
#' SMHI's 52North API, stopped returning data.
#'
#' @format A data frame with 12,960 rows (90 days x 24 hours x 6 cities) and
#'   3 columns:
#' \describe{
#'   \item{city}{Linkoping, Stockholm, Malmo, Gothenburg, Lulea or Umea}
#'   \item{timestamp}{Hourly timestamp (UTC), 2021-06-27 to 2021-09-24}
#'   \item{value}{Simulated PM10 concentration in ug/m3}
#' }
"pm10_sample"
