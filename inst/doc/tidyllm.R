## ----eval= FALSE, echo=TRUE---------------------------------------------------
#  install.packages("tidyllm")

## ----eval= FALSE, echo=TRUE---------------------------------------------------
#  # Install devtools if not already installed
#  if (!requireNamespace("devtools", quietly = TRUE)) {
#    install.packages("devtools")
#  }
#  
#  # Install TidyLLM from GitHub
#  devtools::install_github("edubruell/tidyllm")

## ----eval= FALSE, echo=TRUE---------------------------------------------------
#  Sys.setenv(ANTHROPIC_API_KEY = "YOUR-ANTHROPIC-API-KEY")

## ----eval= FALSE, echo=TRUE---------------------------------------------------
#  Sys.setenv(OPENAI_API_KEY = "YOUR-OPENAI-API-KEY")

## ----eval= FALSE, echo=TRUE---------------------------------------------------
#  Sys.setenv(GROQ_API_KEY = "YOUR-GROQ-API-KEY")

## ----eval= FALSE, echo=TRUE---------------------------------------------------
#  ANTHROPIC_API_KEY="YOUR-ANTHROPIC-API-KEY"

## ----convo1,  eval=FALSE, echo=TRUE-------------------------------------------
#  library(tidyllm)
#  
#  # Start a conversation with Claude
#  conversation <- llm_message("What is the capital of France?") |>
#    claude()
#  
#  #Standard way that llm_messages are printed
#  conversation

## ----convo1_out,  eval=TRUE, echo=FALSE---------------------------------------
library(tidyllm)

#Easier than mocking. httptest2 caused a few issues with my vignette
conversation <- llm_message("What is the capital of France?") |>
  llm_message("The capital of France is Paris.",.role="assistant")

conversation

## ----convo2,  eval=FALSE, echo=TRUE-------------------------------------------
#  # Continue the conversation with ChatGPT
#  conversation <- conversation |>
#    llm_message("What's a famous landmark in this city?") |>
#    openai()
#  
#  get_reply(conversation)

## ----convo2_out,  eval=TRUE, echo=FALSE---------------------------------------
c("A famous landmark in Paris is the Eiffel Tower.")

## ----echo=FALSE, out.width="70%"----------------------------------------------
knitr::include_graphics("picture.jpeg")

## ----images,  eval=FALSE, echo=TRUE-------------------------------------------
#  # Describe an image using a llava model on ollama
#  image_description <- llm_message("Describe this picture? Can you guess where it was made?",
#                                   .imagefile = "picture.jpeg") |>
#    openai(.model = "gpt-4o")
#  
#  # Get the last reply
#  get_reply(image_description)

## ----images_out,  eval=TRUE, echo=FALSE---------------------------------------
c("The picture shows a beautiful landscape with a lake, mountains, and a town nestled below. The sun is shining brightly, casting a serene glow over the water. The area appears lush and green, with agricultural fields visible. \n\nThis type of scenery is reminiscent of northern Italy, particularly around Lake Garda, which features similar large mountains, picturesque water, and charming towns.")

## ----eval=FALSE, echo=TRUE----------------------------------------------------
#  install.packages("pdftools")

## ----pdf,  eval=FALSE, echo=TRUE----------------------------------------------
#  llm_message("Please summarize the key points from the provided PDF document.",
#       .pdf = "die_verwandlung.pdf") |>
#       openai(.model = "gpt-4o-mini")

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
#  library(tidyverse)
#  llm_message("Analyze this plot and data summary:",
#                    .capture_plot = TRUE, #Send the plot pane to a model
#                    .f = ~{summary(mtcars)}) |> #Run summary(data) and send the output
#    claude()

## ----routputs_base_rq,  eval=TRUE, echo=FALSE---------------------------------
# Create a plot for the mtcars example data

llm_message("Analyze this plot and data summary:", 
                  .imagefile = "file1568f6c1b4565.png", #Send the plot pane to a model
                  .f = ~{summary(mtcars)}) |> #Run summary(data) and send the output
  llm_message("Based on the plot and data summary provided, here's an analysis:\n\n1. Relationship between Weight and MPG:\n   The scatter plot shows a clear negative correlation between weight (wt) and miles per gallon (mpg). As the weight of the car increases, the fuel efficiency (mpg) decreases.\n\n2. Linear Trend:\n   The blue line in the plot represents a linear regression fit. The downward slope confirms the negative relationship between weight and mpg.\n\n3. Data Distribution:\n   - The weight of cars in the dataset ranges from 1.513 to 5.424 (likely in thousands of pounds).\n   - The mpg values range from 10.40 to 33.90.\n\n4. Variability:\n   There's some scatter around the regression line, indicating that while weight is a strong predictor of mpg, other factors also influence fuel efficiency.\n\n5. Other Variables:\n   While not shown in the plot, the summary statistics provide information on other variables:\n   - Cylinder count (cyl) ranges from 4 to 8, with a median of 6.\n   - Horsepower (hp) ranges from 52 to 335, with a mean of 146.7.\n   - Transmission type (am) is binary (0 or 1), likely indicating automatic vs. manual.\n\n6. Model Fit:\n   The grey shaded area around the regression line represents the confidence interval. It widens at the extremes of the weight range, indicating less certainty in predictions for very light or very heavy vehicles.\n\n7. Outliers:\n   There are a few potential outliers, particularly at the lower and higher ends of the weight spectrum, that deviate from the general trend.\n\nIn conclusion, this analysis strongly suggests that weight is a significant factor in determining a car's fuel efficiency, with heavier cars generally having lower mpg. However, the presence of scatter in the data indicates that other factors (possibly related to engine characteristics, transmission type, or aerodynamics) also play a role in determining fuel efficiency.",.role="assistant")

## ----eval=FALSE,echo=TRUE-----------------------------------------------------
#  conversation <- llm_message("Imagine a German adress.") |>
#       groq() |>
#       llm_message("Imagine another address") |>
#       groq()
#  
#  conversation

## ----eval=TRUE,echo=FALSE-----------------------------------------------------
conversation <-  llm_message("Imagine a German adress.") |>
  llm_message("Let's imagine a German address: \n\nHerr Müller\nMusterstraße 12\n53111 Bonn",
              .role="assistant") |>
  llm_message("Imagine another address") |>
  llm_message("Let's imagine another German address:\n\nFrau Schmidt\nFichtenweg 78\n42103 Wuppertal",
            .role="assistant")
conversation

## ----standard_last_reply,  eval=TRUE, echo=TRUE-------------------------------
#Getting the first 
conversation |> get_reply(1)
#By default it gets the last reply
conversation |> get_reply()
#Or if you can more easily remember last_reply this works too
conversation |> last_reply()

## ----schema,  eval=FALSE, echo=TRUE-------------------------------------------
#  address_schema <- tidyllm_schema(
#    name = "AddressSchema",
#    street = "character",
#    houseNumber = "numeric",
#    postcode = "character",
#    city = "character",
#    region = "character",
#    country = "factor(Germany,France)"
#  )
#  address <- llm_message("Imagine an address in JSON format that matches the schema.") |>
#          openai(.json_schema = address_schema)
#  address

## ----schema_out,  eval=TRUE, echo=FALSE---------------------------------------
address_base <- llm_message("Imagine an address in JSON format that matches the schema.") 
address <- address_base$add_message(role = "assistant",
                           content = '{"street":"Hauptstraße","houseNumber":123,"postcode":"10115","city":"Berlin","region":"Berlin","country":"Germany"}',
                           media = NULL,
                           json = TRUE) 

address

## ----get_reply_data-----------------------------------------------------------
address |> get_reply_data() |> str()

## ----temperature,  eval=FALSE, echo=TRUE--------------------------------------
#    temp_example <- llm_message("Explain how temperature parameters work in large language models  and why temperature 0 gives you deterministic outputs in one sentence.")
#  
#    #per default it is non-zero
#    temp_example |> ollama(.temperature=0)

## ----temperature_out,  eval=TRUE, echo=FALSE----------------------------------
  temp_example <- llm_message("Explain how temperature parameters work in large language models  and why temperature 0 gives you deterministic outputs in one sentence.")

  temp_example |>
    llm_message("In large language models, temperature parameters control the randomness of generated text by scaling the output probabilities, with higher temperatures introducing more uncertainty and lower temperatures favoring more likely outcomes; specifically, setting temperature to 0 effectively eliminates all randomness, resulting in deterministic outputs because it sets the probability of each token to its maximum likelihood value.",
                .role="assistant")

## ----temp2,  eval=FALSE, echo=TRUE--------------------------------------------
#    #Retrying with .temperature=0
#    temp_example |> ollama(.temperature=0)

## ----temp2_out,  eval=TRUE, echo=FALSE----------------------------------------
  temp_example |>
    llm_message("In large language models, temperature parameters control the randomness of generated text by scaling the output probabilities, with higher temperatures introducing more uncertainty and lower temperatures favoring more likely outcomes; specifically, setting temperature to 0 effectively eliminates all randomness, resulting in deterministic outputs because it sets the probability of each token to its maximum likelihood value.",
                .role="assistant")

## ----eval=FALSE---------------------------------------------------------------
#  #Create a message batch and save it to disk to fetch it later
#  glue("Write a poem about {x}", x=c("cats","dogs","hamsters")) |>
#    purrr::map(llm_message) |>
#    send_claude_batch() |>
#    saveRDS("claude_batch.rds")

## ----eval=FALSE---------------------------------------------------------------
#  #Create a message batch and save it to disk to fetch it later
#  glue("Write a poem about {x}", x=c("cats","dogs","hamsters")) |>
#    purrr::map(llm_message) |>
#    send_claude_batch() |>
#    saveRDS("claude_batch.rds")

## ----eval=FALSE---------------------------------------------------------------
#  #Check the status of the batch
#  readRDS("claude_batch.rds") |>
#     check_claude_batch()

## ----echo=FALSE---------------------------------------------------------------
tribble(
  ~batch_id,                         ~status, ~created_at,           ~expires_at,           ~req_succeeded, ~req_errored, ~req_expired, ~req_canceled,
  "msgbatch_02A1B2C3D4E5F6G7H8I9J",  "ended", as.POSIXct("2024-11-01 10:30:00"), as.POSIXct("2024-11-02 10:30:00"), 3, 0, 0, 0
)

## ----eval=FALSE---------------------------------------------------------------
#  conversations <- readRDS("claude_batch.rds") |>
#    fetch_claude_batch()
#  
#  poems <- map_chr(conversations, get_reply)

