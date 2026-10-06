test_that("rejects an unknown data source", {
  expect_error(aqiGet("bogus"))
  expect_error(aqiGet(Linkoping))
})

test_that("sample mode returns one timestamp/value table per city", {
  pm10 <- aqiGet()
  expect_type(pm10, "list")
  expect_length(pm10, 6)
  for (city_data in pm10) {
    expect_named(city_data, c("timestamp", "value"))
    expect_gt(nrow(city_data), 0)
    expect_true(all(city_data$value > 0))
  }
})

test_that("live mode parses the API's JSON response", {
  body <- '{"values":[{"timestamp":1632614400000,"value":12.5},{"timestamp":1632618000000,"value":null}]}'
  local_mocked_bindings(fetch_raw = function(url) {
    list(status = 200L, type = "application/json", body = body)
  })
  pm10 <- aqiGet("live", base_url = "https://example.org/api/v1")
  expect_length(pm10, 6)
  expect_equal(pm10[[1]]$value, 12.5)   # missing readings are dropped
})

test_that("live mode explains a non-JSON response instead of failing to parse", {
  local_mocked_bindings(fetch_raw = function(url) {
    list(status = 200L, type = "text/html", body = "<!doctype html><html></html>")
  })
  expect_error(aqiGet("live"), "did not return JSON")
})
