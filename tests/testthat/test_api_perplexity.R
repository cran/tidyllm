testthat::skip_if_not_installed("httptest2")
library(httptest2)

test_that("perplexity function constructs a correct request and dry runs it", {
  # Create a mock LLMMessage object
  llm <- llm_message("Write a haiku about search indices")
  
  # Call perplexity_chat with .dry_run = TRUE
  request <- llm |> chat(perplexity, .dry_run = TRUE) 
  
  dry_run <- request |> httr2::req_dry_run(redact_headers = TRUE, quiet = TRUE)
  
  # Check the structure of the returned dry run object
  expect_type(dry_run, "list")
  expect_named(dry_run, c("method", "path", "headers"))
  
  # Check that the method is POST
  expect_equal(dry_run$method, "POST")
  
  # Check that the URL path is correct
  expect_true(grepl("/chat/completions", dry_run$path))
  
  # Inspect headers
  headers <- dry_run$headers
  expect_type(headers, "list")
  
  # Check that the required headers are present
  expect_true("authorization" %in% names(headers))
  expect_true("content-type" %in% names(headers))
  
  # Check that the content-type is JSON
  expect_equal(headers$`content-type`, "application/json")
  
  # Now check the body content to ensure the JSON is constructed as expected
  body_json <- request$body |> jsonlite::toJSON() |> as.character()
  
  expected_json <- "{\"data\":{\"model\":[\"sonar\"],\"max_tokens\":[1024],\"messages\":[{\"role\":[\"user\"],\"content\":[\"Write a haiku about search indices \"]}],\"return_images\":[false],\"stream\":[false]},\"type\":[\"json\"],\"content_type\":[\"application/json\"],\"params\":{\"auto_unbox\":[true],\"digits\":[22],\"null\":[\"null\"]}}"
  # Check if the JSON matches the expected JSON
  expect_equal(body_json, expected_json)
})

