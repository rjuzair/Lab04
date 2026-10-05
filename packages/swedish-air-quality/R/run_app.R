#' Launch the air quality Shiny app
#'
#' Opens an interactive dashboard that plots recent PM10 measurements for a
#' selected Swedish city, with the period mean shown as a reference line.
#'
#' @return Called for its side effect of starting a Shiny app.
#' @export
#' @examples
#' \dontrun{
#' run_app()
#' }
run_app <- function() {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("Package 'shiny' is required to run the app.")
  }
  shiny::runApp(system.file("app", package = "swedishairquality"), display.mode = "normal")
}
