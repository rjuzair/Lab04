# swedishairquality

An R client for the [SMHI air quality API](https://datavardluft.smhi.se/52North/api/v1/) that downloads recent **PM10** particulate-matter measurements for six Swedish cities — Linköping, Stockholm, Malmö, Gothenburg, Luleå and Umeå — plus a **Shiny** dashboard to explore them.

```r
remotes::install_github("rjuzair/statistical-computing-with-r", subdir = "packages/swedish-air-quality")
library(swedishairquality)

pm10 <- aqiGet()   # list of 6 data frames (timestamp, value)
run_app()          # launch the interactive Shiny dashboard
```

PM10 is particulate matter with a diameter of 10 µm or less (smoke, dust, soot, salts, acids, metals). Timestamps follow ISO 8601.
