## ----eval=FALSE---------------------------------------------------------------
# install.packages("tidyllm")

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("edubruell/tidyllm")

## ----eval=FALSE---------------------------------------------------------------
# Sys.setenv(OPENAI_API_KEY = "your-key-here")

## ----eval=FALSE---------------------------------------------------------------
# ollama_download_model("qwen3.5:4b")

## ----convo1, eval=FALSE-------------------------------------------------------
# library(tidyllm)
# 
# conversation <- llm_message("What is the capital of France?") |>
#   chat(claude())
# 
# conversation

## ----convo1_out, eval=TRUE, echo=FALSE, message=FALSE-------------------------
library(tidyllm)

conversation <- llm_message("What is the capital of France?") |>
  llm_message("The capital of France is Paris.", .role = "assistant")

conversation

## ----convo2, eval=FALSE-------------------------------------------------------
# # Continue the conversation with a different provider
# conversation <- conversation |>
#   llm_message("What's a famous landmark in this city?") |>
#   chat(openai())
# 
# get_reply(conversation)

## ----convo2_out, eval=TRUE, echo=FALSE----------------------------------------
c("A famous landmark in Paris is the Eiffel Tower.")

## ----echo=FALSE, out.width="70%", fig.alt="A photograph showing lake Garda and the scenery near Torbole, Italy."----
knitr::include_graphics("picture.jpeg")

## ----images, eval=FALSE-------------------------------------------------------
# # Single image
# image_description <- llm_message("Describe this picture. Can you guess where it was taken?",
#                                   .media = img("picture.jpeg")) |>
#   chat(openai(.model = "gpt-5.6-terra"))
# 
# get_reply(image_description)

## ----images_out, eval=TRUE, echo=FALSE----------------------------------------
c("The picture shows a beautiful landscape with a lake, mountains, and a town nestled below. The area appears lush and green, with agricultural fields visible. This scenery is reminiscent of northern Italy, particularly around Lake Garda.")

## ----eval=FALSE---------------------------------------------------------------
# llm_message("Compare these two charts.",
#             .media = list(img("chart_a.png"), img("chart_b.png"))) |>
#   chat(claude())
# 
# # Mixed types in one message
# llm_message("Does this figure match the results described in the paper?",
#             .media = list(img("figure.png"), pdf_file("paper.pdf", pages = 1:5))) |>
#   chat(gemini())

## ----eval=FALSE---------------------------------------------------------------
# # Audio transcription or analysis
# llm_message("Transcribe and summarise this recording.",
#             .media = audio_file("interview.mp3")) |>
#   chat(gemini())
# 
# # Video understanding
# llm_message("Describe what happens in this clip.",
#             .media = video_file("demo.mp4")) |>
#   chat(gemini())

## ----pdf, eval=FALSE----------------------------------------------------------
# llm_message("Summarize the key points from this document.",
#             .media = pdf_file("die_verwandlung.pdf")) |>
#   chat(claude())

## ----pdf_out, eval=TRUE, echo=FALSE-------------------------------------------
llm_message("Summarize the key points from this document.",
            .media = pdf_file("die_verwandlung.pdf")) |>
  llm_message("The story centres on Gregor Samsa, who wakes up transformed into a giant insect. Unable to work, he becomes isolated while his family struggles. Eventually Gregor dies, and his relieved family looks ahead to a better future.",
              .role = "assistant")

## ----eval=FALSE---------------------------------------------------------------
# pdf_file("report.pdf", pages = 1:5)

## ----eval=FALSE---------------------------------------------------------------
# report <- upload_file(claude(), .path = "annual_report.pdf")
# 
# llm_message("What are the key risks mentioned?", .files = report) |>
#   chat(claude())
# 
# # Manage uploaded files
# list_files(claude())
# file_info(claude(), report)
# delete_file(claude(), report)

## ----routputs_base, eval=TRUE, echo=TRUE, message=FALSE, fig.alt="Scatter plot of car weight (x-axis) versus miles per gallon (y-axis) from the mtcars dataset, with a fitted linear regression line showing a negative relationship between weight and fuel efficiency."----
library(tidyverse)

ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  geom_smooth(method = "lm", formula = "y ~ x") +
  labs(x = "Weight", y = "Miles per gallon")

## ----routputs_base_out, eval=FALSE--------------------------------------------
# llm_message("Analyze this plot and data summary:",
#             .capture_plot = TRUE,
#             .f = ~{summary(mtcars)}) |>
#   chat(claude())

## ----routputs_fake, eval=TRUE, echo=FALSE-------------------------------------
llm_message("Analyze this plot and data summary:",
            .imagefile = "file1568f6c1b4565.png",
            .f = ~{summary(mtcars)}) |>
  llm_message("The scatter plot shows a clear negative correlation between weight and fuel efficiency. Heavier cars consistently achieve lower mpg, with the linear trend confirming this relationship. Variability around the line suggests other factors, engine size and transmission, also play a role.", .role = "assistant")

## ----eval=FALSE---------------------------------------------------------------
# conversation <- llm_message("Imagine a German address.") |>
#   chat(groq()) |>
#   llm_message("Imagine another address.") |>
#   chat(claude())
# 
# conversation

## ----eval=TRUE, echo=FALSE----------------------------------------------------
conversation <- llm_message("Imagine a German address.") |>
  llm_message("Herr Müller\nMusterstraße 12\n53111 Bonn", .role = "assistant") |>
  llm_message("Imagine another address.") |>
  llm_message("Frau Schmidt\nFichtenweg 78\n42103 Wuppertal", .role = "assistant")
conversation

## ----standard_last_reply, eval=TRUE-------------------------------------------
conversation |> get_reply(1)   # first reply
conversation |> get_reply()    # last reply (default)

## ----as_tibble, eval=TRUE-----------------------------------------------------
conversation |> as_tibble()

## ----get_metadata, eval=FALSE-------------------------------------------------
# conversation |> get_metadata()

## ----get_metadata_out, eval=TRUE, echo=FALSE----------------------------------
tibble::tibble(
  model             = c("groq-model", "claude-sonnet-5"),
  timestamp         = as.POSIXct(c("2026-07-08 14:25:43", "2026-07-08 14:26:02")),
  prompt_tokens     = c(20L, 80L),
  completion_tokens = c(45L, 40L),
  total_tokens      = c(65L, 120L),
  api_specific      = list(list(), list())
) |> print(width = 60)

## ----list_models, eval=FALSE--------------------------------------------------
# list_models(openai())
# list_models(openrouter())   # 300+ models across providers
# list_models(ollama())       # models installed locally

## ----schema, eval=FALSE-------------------------------------------------------
# person_schema <- tidyllm_schema(
#   first_name = field_chr("A male first name"),
#   last_name  = field_chr("A common last name"),
#   occupation = field_chr("A quirky occupation"),
#   address    = field_object(
#     "The person's home address",
#     street  = field_chr("Street name"),
#     number  = field_dbl("House number"),
#     city    = field_chr("A large city"),
#     zip     = field_dbl("Postal code"),
#     country = field_fct("Country", .levels = c("Germany", "France"))
#   )
# )
# 
# profile <- llm_message("Imagine a person profile matching the schema.") |>
#   chat(openai(), .json_schema = person_schema)
# 
# profile

## ----schema_out, eval=TRUE, echo=FALSE----------------------------------------
profile <- llm_message("Imagine a person profile matching the schema.") |>
  llm_message("{\"first_name\":\"Julien\",\"last_name\":\"Martin\",\"occupation\":\"Gondola Repair Specialist\",\"address\":{\"street\":\"Rue de Rivoli\",\"number\":112,\"city\":\"Paris\",\"zip\":75001,\"country\":\"France\"}}",
              .role = "assistant")
profile@message_history[[3]]$json <- TRUE
profile

## ----get_reply_data-----------------------------------------------------------
profile |> get_reply_data() |> str()

## ----fobj, eval=FALSE---------------------------------------------------------
# llm_message("Imagine five people.") |>
#   chat(openai(),
#        .json_schema = tidyllm_schema(
#          person = field_object(
#            first_name = field_chr(),
#            last_name  = field_chr(),
#            occupation = field_chr(),
#            .vector    = TRUE
#          )
#        )) |>
#   get_reply_data() |>
#   bind_rows()

## ----fobjout, echo=FALSE, eval=TRUE-------------------------------------------
data.frame(
  first_name = c("Alice", "Robert", "Maria", "Liam", "Sophia"),
  last_name  = c("Johnson", "Anderson", "Gonzalez", "O'Connor", "Lee"),
  occupation = c("Software Developer", "Graphic Designer", "Data Scientist",
                 "Mechanical Engineer", "Content Writer")
)

## ----temperature, eval=FALSE--------------------------------------------------
# # Common args in the verb
# llm_message("Write a haiku about tidyllm.") |>
#   chat(ollama(), .temperature = 0)
# 
# # Provider-specific args in the provider
# llm_message("Hello") |>
#   chat(ollama(.ollama_server = "http://my-server:11434"), .temperature = 0)

## ----eval=FALSE---------------------------------------------------------------
# get_current_time <- function(tz, format = "%Y-%m-%d %H:%M:%S") {
#   format(Sys.time(), tz = tz, format = format, usetz = TRUE)
# }
# 
# time_tool <- tidyllm_tool(
#   .f          = get_current_time,
#   .description = "Returns the current time in a specified timezone.",
#   tz     = field_chr("The timezone identifier, e.g. 'Europe/Berlin'."),
#   format = field_chr("strftime format string. Default: '%Y-%m-%d %H:%M:%S'.")
# )
# 
# llm_message("What time is it in Stuttgart right now?") |>
#   chat(openai(), .tools = time_tool)

## ----eval=TRUE, echo=FALSE----------------------------------------------------
llm_message("What time is it in Stuttgart right now?") |>
  llm_message("The current time in Stuttgart (Europe/Berlin) is 2025-03-03 09:51:22 CET.",
              .role = "assistant")

## ----eval=FALSE---------------------------------------------------------------
# library(ellmer)
# btw_tool <- ellmer_tool(btw::btw_tool_files_list_files)
# llm_message("List files in the R/ folder.") |>
#   chat(claude(), .tools = btw_tool)

## ----embed, eval=FALSE--------------------------------------------------------
# c("What is the meaning of life?",
#   "How much wood would a woodchuck chuck?",
#   "How does the brain work?") |>
#   embed(ollama())

## ----embed_output, eval=TRUE, echo=FALSE--------------------------------------
tibble::tibble(
  input      = c("What is the meaning of life?",
                 "How much wood would a woodchuck chuck?",
                 "How does the brain work?"),
  embeddings = purrr::map(1:3, ~runif(min = -1, max = 1, n = 384))
)

## ----eval=FALSE---------------------------------------------------------------
# list("tidyllm logo", img("docs/logo.png")) |>
#   embed(voyage())

## ----eval=FALSE---------------------------------------------------------------
# voyage_rerank(
#   "best R package for LLMs",
#   c("tidyllm", "ellmer", "httr2", "rvest")
# )

## ----eval=FALSE---------------------------------------------------------------
# # Submit a batch and save the job handle to disk
# glue::glue("Write a poem about {x}", x = c("cats", "dogs", "hamsters")) |>
#   purrr::map(llm_message) |>
#   send_batch(claude()) |>
#   saveRDS("claude_batch.rds")

## ----eval=FALSE---------------------------------------------------------------
# # Check status
# readRDS("claude_batch.rds") |>
#   check_batch(claude())

## ----echo=FALSE---------------------------------------------------------------
tibble::tribble(
  ~batch_id,                          ~status, ~created_at,                      ~expires_at,                      ~req_succeeded, ~req_errored, ~req_expired, ~req_canceled,
  "msgbatch_02A1B2C3D4E5F6G7H8I9J",   "ended", as.POSIXct("2025-11-01 10:30:00"), as.POSIXct("2025-11-02 10:30:00"), 3L,             0L,           0L,           0L
)

## ----eval=FALSE---------------------------------------------------------------
# # Fetch completed results
# conversations <- readRDS("claude_batch.rds") |>
#   fetch_batch(claude())
# 
# poems <- purrr::map_chr(conversations, get_reply)

## ----eval=FALSE---------------------------------------------------------------
# # Blocking: waits for completion, returns an LLMMessage
# result <- llm_message("Compare Rust and Go for systems programming in 2025.") |>
#   deep_research(perplexity())
# 
# get_reply(result)
# get_metadata(result)$api_specific[[1]]$citations

## ----eval=FALSE---------------------------------------------------------------
# # Background mode: returns a job handle immediately
# job <- llm_message("Summarise recent EU AI Act developments.") |>
#   deep_research(perplexity(), .background = TRUE)
# 
# check_job(job)           # poll status
# result <- fetch_job(job) # retrieve when complete

## ----eval=FALSE---------------------------------------------------------------
# llm_message("Write a short poem about R.") |>
#   chat(claude(), .stream = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# options(tidyllm_chat_default   = openai(.model = "gpt-5.6-terra"))
# options(tidyllm_embed_default  = ollama())
# options(tidyllm_sbatch_default = claude(.temperature = 0))
# options(tidyllm_cbatch_default = claude())
# options(tidyllm_fbatch_default = claude())
# options(tidyllm_lbatch_default = claude())
# 
# # Now the provider argument can be omitted
# llm_message("Hello!") |> chat()
# 
# c("text one", "text two") |> embed()

