testthat::skip_if_not_installed("httptest2")
library(httptest2)

# Test request construction and dry run
test_that("deepseek function constructs a correct request and dry runs it", {
  llm <- llm_message("Write a poem about a (stochastic) parrot")
  
  request <- llm |> chat(deepseek, .dry_run = TRUE)
  dry_run <- request |> httr2::req_dry_run(redact_headers = TRUE, quiet = TRUE)
  
  expect_type(dry_run, "list")
  expect_named(dry_run, c("method", "path", "headers"))
  expect_equal(dry_run$method, "POST")
  expect_true(grepl("/chat/completions", dry_run$path))
  
  headers <- dry_run$headers
  expect_type(headers, "list")
  expect_true("authorization" %in% names(headers))
  expect_true("content-type" %in% names(headers))
  expect_equal(headers$`content-type`, "application/json")
  
  body_json <- request$body |> jsonlite::toJSON() |> as.character()
  expect_true(grepl("deepseek-chat", body_json))
})

