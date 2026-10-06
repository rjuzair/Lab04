# swedishairquality

PM10 particulate-matter data for six Swedish cities — Linköping, Stockholm, Malmö, Gothenburg, Luleå and Umeå — with a **Shiny** dashboard to explore it.

```r
remotes::install_github("rjuzair/statistical-computing-with-r", subdir = "packages/swedish-air-quality")
library(swedishairquality)

pm10 <- aqiGet()   # list of 6 data frames (timestamp, value)
run_app()          # launch the interactive Shiny dashboard
```

> **Data note.** The package was built on SMHI's 52North air-quality REST API, which no longer returns data at its original address. `aqiGet()` therefore defaults to **`pm10_sample`, a bundled simulated dataset** (not real measurements; see `data-raw/pm10_sample.R`). Live downloads still work against any 52North timeseries API:
>
> ```r
> options(swedishairquality.base_url = "https://<host>/52North/api/v1")
> aqiGet("live", months = 3)
> ```
> If the API returns something other than JSON, `aqiGet()` stops with a clear message instead of a parse error.

PM10 is particulate matter with a diameter of 10 µm or less (smoke, dust, soot, salts, acids, metals). Timestamps are hourly, in UTC.
