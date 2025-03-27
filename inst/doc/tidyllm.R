## ----eval= FALSE, echo=TRUE---------------------------------------------------
# install.packages("tidyllm")

## ----eval= FALSE, echo=TRUE---------------------------------------------------
# # Install devtools if not already installed
# if (!requireNamespace("devtools", quietly = TRUE)) {
#   install.packages("devtools")
# }
# 
# # Install TidyLLM from GitHub
# devtools::install_github("edubruell/tidyllm")

## ----eval=FALSE---------------------------------------------------------------
# Sys.setenv(OPENAI_API_KEY = "YOUR-OPENAI-API-KEY")

## ----eval=FALSE---------------------------------------------------------------
# ANTHROPIC_API_KEY="YOUR-ANTHROPIC-API-KEY"

## ----eval=FALSE---------------------------------------------------------------
# ollama_download_model("deepscaler")

## ----convo1,  eval=FALSE, echo=TRUE-------------------------------------------
# library(tidyllm)
# 
# # Start a conversation with Claude
# conversation <- llm_message("What is the capital of France?") |>
#   chat(claude())
# 
# #Standard way that llm_messages are printed
# conversation

## ----convo1_out,  eval=TRUE, echo=FALSE,message=FALSE-------------------------
library(tidyllm)

#Easier than mocking. httptest2 caused a few issues with my vignette
conversation <- llm_message("What is the capital of France?") |>
  llm_message("The capital of France is Paris.",.role="assistant")

conversation

## ----convo2,  eval=FALSE, echo=TRUE-------------------------------------------
# # Continue the conversation with ChatGPT
# conversation <- conversation |>
#   llm_message("What's a famous landmark in this city?") |>
#   chat(openai)
# 
# get_reply(conversation)

## ----convo2_out,  eval=TRUE, echo=FALSE---------------------------------------
c("A famous landmark in Paris is the Eiffel Tower.")

## ----echo=FALSE, out.width="70%", fig.alt="A photograhp showing lake Garda and the scenery near Torbole, Italy."----
knitr::include_graphics("picture.jpeg")

## ----images,  eval=FALSE, echo=TRUE-------------------------------------------
# # Describe an image using a llava model on ollama
# image_description <- llm_message("Describe this picture? Can you guess where it was made?",
#                                  .imagefile = "picture.jpeg") |>
#   chat(openai(.model = "gpt-4o"))
# 
# # Get the last reply
# get_reply(image_description)

## ----images_out,  eval=TRUE, echo=FALSE---------------------------------------
c("The picture shows a beautiful landscape with a lake, mountains, and a town nestled below. The sun is shining brightly, casting a serene glow over the water. The area appears lush and green, with agricultural fields visible. \n\nThis type of scenery is reminiscent of northern Italy, particularly around Lake Garda, which features similar large mountains, picturesque water, and charming towns.")

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# install.packages("pdftools")

## ----pdf,  eval=FALSE, echo=TRUE----------------------------------------------
# llm_message("Please summarize the key points from the provided PDF document.",
#      .pdf = "die_verwandlung.pdf") |>
#      chat(openai(.model = "gpt-4o-mini"))

## ----pdf_out,  eval=TRUE, echo=FALSE------------------------------------------
  llm_message("Please summarize the key points from the provided PDF document.", 
              .pdf="die_verwandlung.pdf") |>
    llm_message("Here are the key points from the provided PDF document 'Die Verwandlung' by Franz Kafka:

1. The story centers around Gregor Samsa, who wakes up one morning to find that he has been transformed into a giant insect-like creature.

2. Gregor's transformation causes distress and disruption for his family. They struggle to come to terms with the situation and how to deal with Gregor in his new state.

3. Gregor's family, especially his sister Grete, initially tries to care for him, but eventually decides they need to get rid of him. They lock him in his room and discuss finding a way to remove him.

4. Gregor becomes increasingly isolated and neglected by his family. He becomes weaker and less mobile due to his injuries and lack of proper care.

5. Eventually, Gregor dies, and his family is relieved. They then begin to make plans to move to a smaller, more affordable apartment and start looking for new jobs and opportunities.",.role="assistant")

## ----routputs_base,  eval=TRUE, echo=TRUE, message=FALSE----------------------
library(tidyverse)

# Create a plot for the mtcars example data
ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  geom_smooth(method = "lm", formula = 'y ~ x') +
  labs(x="Weight",y="Miles per gallon")

## ----routputs_base_out,  eval=FALSE, echo=TRUE--------------------------------
# library(tidyverse)
# llm_message("Analyze this plot and data summary:",
#                   .capture_plot = TRUE, #Send the plot pane to a model
#                   .f = ~{summary(mtcars)}) |> #Run summary(data) and send the output
#   chat(claude())

## ----routputs_base_rq,  eval=TRUE, echo=FALSE---------------------------------
# Create a plot for the mtcars example data

llm_message("Analyze this plot and data summary:", 
                  .imagefile = "file1568f6c1b4565.png", #Send the plot pane to a model
                  .f = ~{summary(mtcars)}) |> #Run summary(data) and send the output
  llm_message("Based on the plot and data summary provided, here's an analysis:\n\n1. Relationship between Weight and MPG:\n   The scatter plot shows a clear negative correlation between weight (wt) and miles per gallon (mpg). As the weight of the car increases, the fuel efficiency (mpg) decreases.\n\n2. Linear Trend:\n   The blue line in the plot represents a linear regression fit. The downward slope confirms the negative relationship between weight and mpg.\n\n3. Data Distribution:\n   - The weight of cars in the dataset ranges from 1.513 to 5.424 (likely in thousands of pounds).\n   - The mpg values range from 10.40 to 33.90.\n\n4. Variability:\n   There's some scatter around the regression line, indicating that while weight is a strong predictor of mpg, other factors also influence fuel efficiency.\n\n5. Other Variables:\n   While not shown in the plot, the summary statistics provide information on other variables:\n   - Cylinder count (cyl) ranges from 4 to 8, with a median of 6.\n   - Horsepower (hp) ranges from 52 to 335, with a mean of 146.7.\n   - Transmission type (am) is binary (0 or 1), likely indicating automatic vs. manual.\n\n6. Model Fit:\n   The grey shaded area around the regression line represents the confidence interval. It widens at the extremes of the weight range, indicating less certainty in predictions for very light or very heavy vehicles.\n\n7. Outliers:\n   There are a few potential outliers, particularly at the lower and higher ends of the weight spectrum, that deviate from the general trend.\n\nIn conclusion, this analysis strongly suggests that weight is a significant factor in determining a car's fuel efficiency, with heavier cars generally having lower mpg. However, the presence of scatter in the data indicates that other factors (possibly related to engine characteristics, transmission type, or aerodynamics) also play a role in determining fuel efficiency.",.role="assistant")

## ----eval=FALSE,echo=TRUE-----------------------------------------------------
# conversation <- llm_message("Imagine a German adress.") |>
#      chat(groq()) |>
#      llm_message("Imagine another address") |>
#      chat(claude())
# 
# conversation

## ----eval=TRUE,echo=FALSE-----------------------------------------------------
conversation <-  llm_message("Imagine a German adress.") |>
  llm_message("Let's imagine a German address: \n\nHerr Müller\nMusterstraße 12\n53111 Bonn",
              .role="assistant") |>
  llm_message("Imagine another address") |>
  llm_message("Let's imagine another German address:\n\nFrau Schmidt\nFichtenweg 78\n42103 Wuppertal",
            .role="assistant")
conversation

## ----standard_last_reply,  eval=TRUE, echo=TRUE-------------------------------
#Getting the first reply
conversation |> get_reply(1)
#By default it gets the last reply
conversation |> get_reply()

## ----as_tibble,  eval=TRUE, echo=TRUE-----------------------------------------
conversation |> as_tibble()

## ----get_metadata,  eval=FALSE, echo=TRUE-------------------------------------
# conversation |> get_metadata()

## ----get_metadata_out,  eval=TRUE, echo=FALSE---------------------------------
tibble::tibble(
  model = c("groq-lamma3-11b", "claude-3-5-sonnet"),
  timestamp = as.POSIXct(c("2024-11-08 14:25:43", "2024-11-08 14:26:02")),
  prompt_tokens = c(20, 80),
  completion_tokens = c(45, 40),
  total_tokens = prompt_tokens + completion_tokens,
  api_specific = list(list(name1 = "",name2=20,name=30))
) |>
  print(width=60)

## ----schema,  eval=FALSE, echo=TRUE-------------------------------------------
# person_schema <- tidyllm_schema(
#   first_name = field_chr("A male first name"),
#   last_name = field_chr("A common last name"),
#   occupation = field_chr("A quirky occupation"),
#   address = field_object(
#     "The persons home address",
#     street = field_chr("A common street name in the city"),
#     number = field_dbl("A house number"),
#     city = field_chr("A large city"),
#     zip = field_dbl("A zip code for the address"),
#     country = field_fct("Either Germany or France",.levels = c("Germany","France"))
#   )
# )
# 
# profile <- llm_message("Imagine an person profile that matches the schema.") |>
#   chat(openai(),.json_schema = person_schema)
# 
# profile

## ----schema_out,  eval=TRUE, echo=FALSE---------------------------------------
profile <- llm_message("Imagine an person profile that matches the schema.") |>
 llm_message("{\"first_name\":\"Julien\",\"last_name\":\"Martin\",\"occupation\":\"Gondola Repair Specialist\",\"address\":{\"street\":\"Rue de Rivoli\",\"number\":112,\"city\":\"Paris\",\"zip\":75001,\"country\":\"France\"}}",.role="assistant")
profile@message_history[[3]]$json <- TRUE
profile

## ----get_reply_data-----------------------------------------------------------
profile |> get_reply_data() |> str()

## ----fobj, eval=FALSE, echo=TRUE----------------------------------------------
# llm_message("Imagine five people") |>
#   chat(openai,.json_schema =
#          tidyllm_schema(
#             person = field_object(
#               first_name = field_chr(),
#               last_name = field_chr(),
#               occupation = field_chr(),
#               .vector = TRUE
#               )
#          )
#        ) |>
#   get_reply_data() |>
#   bind_rows()

## ----fobjout, echo=FALSE, eval=TRUE-------------------------------------------
data.frame(first_name = c("Alice","Robert","Maria","Liam","Sophia"),
           last_name = c("Johnson","Anderson","Gonzalez","O'Connor","Lee"),
           occupation = c("Software Developer","Graphic Designer","Data Scientist","Mechanical Engineer","Content Writer")
           )

## ----temperature,  eval=FALSE, echo=TRUE--------------------------------------
#   temp_example <- llm_message("Explain how temperature parameters work
# in large language models and why temperature 0 gives you deterministic outputs
# in one sentence.")
# 
#   #per default it is non-zero
#   temp_example |> chat(ollama,.temperature=0)

## ----temperature_out,  eval=TRUE, echo=FALSE----------------------------------
  temp_example <- llm_message("Explain how temperature parameters work 
in large language models  and why temperature 0 gives you deterministic
outputs in one sentence.")

  temp_example |>
    llm_message("In large language models, temperature parameters control the randomness of generated text by scaling the output probabilities, with higher temperatures introducing more uncertainty and lower temperatures favoring more likely outcomes; specifically, setting temperature to 0 effectively eliminates all randomness, resulting in deterministic outputs because it sets the probability of each token to its maximum likelihood value.",
                .role="assistant")

## ----temp2,  eval=FALSE, echo=TRUE--------------------------------------------
#   #Retrying with .temperature=0
#   temp_example |> chat(ollama,.temperature=0)

## ----temp2_out,  eval=TRUE, echo=FALSE----------------------------------------
  temp_example |>
    llm_message("In large language models, temperature parameters control the randomness of generated text by scaling the output probabilities, with higher temperatures introducing more uncertainty and lower temperatures favoring more likely outcomes; specifically, setting temperature to 0 effectively eliminates all randomness, resulting in deterministic outputs because it sets the probability of each token to its maximum likelihood value.",
                .role="assistant")

## ----eval=FALSE---------------------------------------------------------------
# conversation <- llm_message("Hello") |>
#   chat(ollama(.ollama_server = "http://localhost:11434"),
#        .temperature = 0)

## ----eval=FALSE---------------------------------------------------------------
# #This uses GPT-4o
# conversation <- llm_message("Hello") |>
#   chat(openai(.model="gpt-4o-mini"),
#        .model="gpt-4o")

## ----eval = FALSE-------------------------------------------------------------
# address <- llm_message("Imagine an address in JSON format that matches the schema.") |>
#         chat(groq(),.json_schema = address_schema)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# get_current_time <- function(tz, format = "%Y-%m-%d %H:%M:%S") {
#   format(Sys.time(), tz = tz, format = format, usetz = TRUE)
# }
# 
# time_tool <- tidyllm_tool(
#   .f = get_current_time,
#   .description = "Returns the current time in a specified timezone. Use this to determine the current time in any location.",
#   tz = field_chr("The time zone identifier (e.g., 'Europe/Berlin', 'America/New_York', 'Asia/Tokyo', 'UTC'). Required."),
#   format = field_chr("Format string for the time output. Default is '%Y-%m-%d %H:%M:%S'.")
# )
# 
# 
# llm_message("What's the exact time in Stuttgart?") |>
#   chat(openai,.tools=time_tool)

## ----eval=TRUE, echo=FALSE----------------------------------------------------
llm_message("What's the exact time in Stuttgart?") |>
   llm_message('The current time in Stuttgart (Europe/Berlin timezone) is 2025-03-03 09:51:22 CET.',.role="assistant")

## ----embed, eval=FALSE, echo=TRUE---------------------------------------------
# c("What is the meaning of life?",
#   "How much wood would a woodchuck chuck?",
#   "How does the brain work?") |>
#   embed(ollama)

## ----embed_output, eval=TRUE, echo=FALSE--------------------------------------
tibble::tibble(
  input = c("What is the meaning of life?",
            "How much wood would a woodchuck chuck?",
            "How does the brain work?") ,
  embeddings = purrr::map(1:3,~{runif(min = -1,max=1,n=384)}))

## ----eval=FALSE---------------------------------------------------------------
# #Create a message batch and save it to disk to fetch it later
# glue("Write a poem about {x}", x=c("cats","dogs","hamsters")) |>
#   purrr::map(llm_message) |>
#   send_batch(claude()) |>
#   saveRDS("claude_batch.rds")

## ----eval=FALSE---------------------------------------------------------------
# #Check the status of the batch
# readRDS("claude_batch.rds") |>
#    check_batch(claude())

## ----echo=FALSE---------------------------------------------------------------
tribble(
  ~batch_id,                         ~status, ~created_at,           ~expires_at,           ~req_succeeded, ~req_errored, ~req_expired, ~req_canceled,
  "msgbatch_02A1B2C3D4E5F6G7H8I9J",  "ended", as.POSIXct("2024-11-01 10:30:00"), as.POSIXct("2024-11-02 10:30:00"), 3, 0, 0, 0
)

## ----eval=FALSE---------------------------------------------------------------
# conversations <- readRDS("claude_batch.rds") |>
#   fetch_batch(claude())
# 
# poems <- map_chr(conversations, get_reply)

## ----eval=FALSE---------------------------------------------------------------
# llm_message("Write a lengthy magazine advertisement for an R package called tidyllm") |>
#   chat(claude,.stream=TRUE)

## ----eval=FALSE---------------------------------------------------------------
# llm_message("What is tidyllm and who maintains this package?") |>
#   gemini_chat(.grounding_threshold = 0.3)

## ----eval=FALSE---------------------------------------------------------------
# #Upload a file for use with gemini
# upload_info <- gemini_upload_file("example.mp3")
# 
# #Make the file available during a Gemini API call
# llm_message("Summarize this speech") |>
#   chat(gemini(.fileid = upload_info$name))
# 
# #Delte the file from the Google servers after you are done
# gemini_delete_file(upload_info$name)

## ----eval=FALSE---------------------------------------------------------------
# list("tidyllm", img(here::here("docs", "logo.png"))) |>
#   embed(voyage)
# #> # A tibble: 2 × 2
# #>   input          embeddings
# #>   <chr>          <list>
# #> 1 tidyllm        <dbl [1,024]>
# #> 2 [IMG] logo.png <dbl [1,024]>

## ----eval=FALSE---------------------------------------------------------------
# my_provider <- openai(.model="llama3.2:90b",
#           .api_url="http://localhost:11434",
#           .compatible = TRUE,
#           .api_path = "/v1/chat/custom/"
#           )
# 
# llm_message("Hi there") |>
#   chat(my_provider)

## ----eval=FALSE---------------------------------------------------------------
# # Set default providers
# #chat provider
# options(tidyllm_chat_default = openai(.model = "gpt-4o"))
# #embedding provider
# options(tidyllm_embed_default = ollama(.model = "all-minilm"))
# #send batch provider
# options(tidyllm_sbatch_default = claude(.temperature=0))
# #check batch provider
# options(tidyllm_cbatch_default = claude())
# #fetch batch provider
# options(tidyllm_fbatch_default = claude())
# #List batches provider
# options(tidyllm_lbatch_default = claude())
# 
# # Now you can use chat() or embed() without explicitly specifying a provider
# conversation <- llm_message("Hello, what is the weather today?") |>
#   chat()
# 
# embeddings <- c("What is AI?", "Define machine learning.") |>
#   embed()
# 
# # Now you can use batch functions without explicitly specifying a provider
# batch_messages <- list(
#   llm_message("Write a poem about the sea."),
#   llm_message("Summarize the theory of relativity."),
#   llm_message("Invent a name for a new genre of music.")
# )
# 
# # Send batch using default for send_batch()
# batch_results <- batch_messages |> send_batch()
# 
# # Check batch status using default for check_batch()
# status <- check_batch(batch_results)
# 
# # Fetch completed results using default for fetch_batch()
# completed_results <- fetch_batch(batch_results)
# 
# # List all batches using default for list_batches()
# all_batches <- list_batches()

