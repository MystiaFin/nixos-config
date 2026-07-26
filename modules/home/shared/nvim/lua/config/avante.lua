require("avante").setup({
  provider = "gemini",
  providers = {
    gemini = {
      endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
      model = "gemini-3.5-flash",
      extra_request_body = {
        temperature = 0,
        max_tokens = 8192,
      },
    },
  },
  behaviour = {
    auto_suggestions = false,
  },
})
