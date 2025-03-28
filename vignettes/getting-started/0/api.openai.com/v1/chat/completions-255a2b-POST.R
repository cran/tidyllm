structure(list(method = "POST", url = "https://api.openai.com/v1/chat/completions", 
    status_code = 200L, headers = structure(list(date = "Wed, 16 Oct 2024 00:51:41 GMT", 
        `content-type` = "application/json", `access-control-expose-headers` = "X-Request-ID", 
        `openai-organization` = "user-j2dlcmauhfkzofrqjehceoc7", 
        `openai-processing-ms` = "754", `openai-version` = "2020-10-01", 
        `x-ratelimit-limit-requests` = "5000", `x-ratelimit-limit-tokens` = "80000", 
        `x-ratelimit-remaining-requests` = "4999", `x-ratelimit-remaining-tokens` = "78939", 
        `x-ratelimit-reset-requests` = "12ms", `x-ratelimit-reset-tokens` = "795ms", 
        `x-request-id` = "req_b8d107b9a41b1b85cb73cac2620f1305", 
        `strict-transport-security` = "max-age=31536000; includeSubDomains; preload", 
        `cf-cache-status` = "DYNAMIC", `set-cookie` = "REDACTED", 
        `x-content-type-options` = "nosniff", `set-cookie` = "REDACTED", 
        server = "cloudflare", `cf-ray` = "8d340fd1aaa1dc68-FRA", 
        `content-encoding` = "gzip", `alt-svc` = "h3=\":443\"; ma=86400"), class = "httr2_headers"), 
    body = charToRaw("{\n  \"id\": \"chatcmpl-AImYG5bv8QAitb0aR8EiK2PDDMmup\",\n  \"object\": \"chat.completion\",\n  \"created\": 1729039900,\n  \"model\": \"gpt-4-0613\",\n  \"choices\": [\n    {\n      \"index\": 0,\n      \"message\": {\n        \"role\": \"assistant\",\n        \"content\": \"A famous landmark in Paris is the Eiffel Tower.\",\n        \"refusal\": null\n      },\n      \"logprobs\": null,\n      \"finish_reason\": \"stop\"\n    }\n  ],\n  \"usage\": {\n    \"prompt_tokens\": 51,\n    \"completion_tokens\": 12,\n    \"total_tokens\": 63,\n    \"prompt_tokens_details\": {\n      \"cached_tokens\": 0\n    },\n    \"completion_tokens_details\": {\n      \"reasoning_tokens\": 0\n    }\n  },\n  \"system_fingerprint\": null\n}\n"), 
    cache = new.env(parent = emptyenv())), class = "httr2_response")
