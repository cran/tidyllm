## ----eval= FALSE, echo=TRUE---------------------------------------------------
#  # Install devtools if not already installed
#  if (!requireNamespace("devtools", quietly = TRUE)) {
#    install.packages("devtools")
#  }
#  
#  # Install tidyllm from GitHub
#  devtools::install_github("edubruell/tidyllm")

## ----eval= FALSE, echo=TRUE---------------------------------------------------
#  Sys.setenv(ANTHROPIC_API_KEY = "YOUR-ANTHROPIC-API-KEY")

## ----eval= FALSE, echo=TRUE---------------------------------------------------
#  Sys.setenv(OPENAI_API_KEY = "YOUR-OPENAI-API-KEY")

## ----eval= FALSE, echo=TRUE---------------------------------------------------
#  Sys.setenv(GROQ_API_KEY = "YOUR-GROQ-API-KEY")

## ----eval= FALSE, echo=TRUE---------------------------------------------------
#  ANTHROPIC_API_KEY="XX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

## ----firsttry,  eval=FALSE, echo=TRUE-----------------------------------------
#  library(tidyllm)
#  
#  # Start a conversation with Claude
#  conversation <- llm_message("What is the capital of France?") |>
#    claude()
#  
#  #Standard way that llm_messages are printed
#  conversation
#  
#  # Get the last reply
#  last_reply(conversation)
#  
#  # Continue the conversation with ChatGPT
#  conversation <- conversation |>
#    llm_message("What's a famous landmark in this city?") |>
#    chatgpt()
#  
#  # Get the last reply
#  last_reply(conversation)

## ----images,  eval=FALSE, echo=TRUE-------------------------------------------
#  # Describe an image using a llava model on ollama
#  image_description <- llm_message("Describe this image",
#                                   .imagefile = "https://raw.githubusercontent.com/edubruell/tidyllm/refs/heads/main/tidyllm.png") |>
#    ollama(.model = "llava")
#  
#  # Get the last reply
#  last_reply(image_description)

## ----routputs,  eval=FALSE, echo=TRUE-----------------------------------------
#  library(tidyverse)
#  
#  # Example data
#  example_data <- tibble(
#    x = rnorm(100),
#    y = 2 * x + rnorm(100)
#  )
#  
#  # Create a plot
#  ggplot(example_data, aes(x, y)) +
#    geom_point() +
#    geom_smooth(method = "lm")
#  
#  # Send the plot and data summary to a language model
#  analysis <- llm_message("Analyze this plot and data summary:",
#                          .capture_plot = TRUE,
#                          .f = ~{summary(example_data)}) |>
#    claude()
#  
#  last_reply(analysis)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  install.packages("pdftools")

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  llm_message("Please summarize the key points from the provided PDF document.",
#       .pdf = "https://pdfobject.com/pdf/sample.pdf") |>
#       ollama()

## ----temperature,  eval=FALSE, echo=TRUE--------------------------------------
#  temp_example <- llm_message("Explain how temperature parameters work in large language models.")
#  
#  #per default it is non-zero
#  temp_example |> ollama()
#  
#  #Temperature sets the randomness of the answer
#  #0 is one extreme where the output becomes fully deterministic.
#  #Else the next token is allways sampled from a list of the most likely tokens. Here only the most likely token is used every time.
#  temp_example |> ollama(.temperature=0) |> last_reply()
#  temp_example |> ollama(.temperature=0) |> last_reply()# Same answer

