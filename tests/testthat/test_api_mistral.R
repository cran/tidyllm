testthat::skip_if_not_installed("httptest2")
library(httptest2)

test_that("mistral function constructs a correct request and dry runs it", {
  # Call mistral with .dry_run = TRUE and perform the dry run
  request <- llm_message("Write a poem about the Gallic Rooster") |> 
    chat(mistral,.dry_run = TRUE)
  
  dry_run <- request |>
    httr2::req_dry_run(redact_headers = TRUE, quiet = TRUE)
  
  # Check the structure of the returned dry run object
  expect_type(dry_run, "list")
  expect_named(dry_run, c("method", "path", "headers"))
  
  # Check that the method is POST
  expect_equal(dry_run$method, "POST")
  
  # Check that the path is correct
  expect_equal(dry_run$path, "/v1/chat/completions")
  
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
  
  expected_json <- "{\"data\":{\"model\":[\"mistral-large-latest\"],\"messages\":[{\"role\":[\"user\"],\"content\":[\"Write a poem about the Gallic Rooster \"]}],\"safe_prompt\":[false],\"temperature\":[0.7],\"top_p\":[1]},\"type\":[\"json\"],\"content_type\":[\"application/json\"],\"params\":{\"auto_unbox\":[true],\"digits\":[22],\"null\":[\"null\"]}}"
  # Check if the JSON matches the expected JSON
  expect_equal(body_json, expected_json)
})


test_that("send_batch creates correct JSONL for batch requests", {
  # Generate batch of messages
  messages <- glue::glue("Write a haiku about {x}",
                         x = c("Mannheim", "Stuttgart", "Heidelberg")) |>
    purrr::map(llm_message)
  
  jsonl_lines <- send_batch(messages, mistral, .model = "mistral_large", .dry_run = TRUE)
  
  
  # Check that we have 3 lines (one for each request)
  expect_equal(length(jsonl_lines), 3)
  
  # Parse each line as JSON
  parsed_lines <- lapply(jsonl_lines, jsonlite::fromJSON)
  
  # Verify structure and content of each line
  purrr::iwalk(parsed_lines, function(x,y){
    expect_equal(x$custom_id, paste0("tidyllm_mistral_req_", y))
    expect_equal(x$method, "POST")
    expect_equal(x$url, "/v1/chat/completions")
    expect_equal(x$body$model, "mistral_large")
    expect_equal(x$body$messages$role, c("user"))
    expect_equal(x$body$messages$role[1], "user")
  })
  
  content_lines <- parsed_lines  |>
    purrr::map_chr(~.x$body$messages$content[1])
  
  expect_true(stringr::str_detect(content_lines[1],"Mannheim"))
  expect_true(stringr::str_detect(content_lines[2],"Stuttgart"))
  expect_true(stringr::str_detect(content_lines[3],"Heidelberg"))
})
