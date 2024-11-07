structure(list(method = "POST", url = "http://localhost:11434/api/chat", 
    status_code = 200L, headers = structure(list(`Content-Type` = "application/json; charset=utf-8", 
        Date = "Wed, 16 Oct 2024 00:52:07 GMT", `Content-Length` = "438"), class = "httr2_headers"), 
    body = charToRaw("{\"model\":\"llama3\",\"created_at\":\"2024-10-16T00:52:07.446423Z\",\"message\":{\"role\":\"assistant\",\"content\":\"{\\n\\\"street\\\": \\\"Mühlenstraße\\\",\\n\\\"houseNumber\\\": \\\"12-14\\\",\\n\\\"city\\\": \\\"Berlin\\\",\\n\\\"postalcode\\\": \\\"10117\\\",\\n\\\"country\\\": \\\"Deutschland\\\"\\n}\"},\"done_reason\":\"stop\",\"done\":true,\"total_duration\":4540468000,\"load_duration\":39213083,\"prompt_eval_count\":24,\"prompt_eval_duration\":2674874000,\"eval_count\":43,\"eval_duration\":1825018000}"), 
    cache = new.env(parent = emptyenv())), class = "httr2_response")
