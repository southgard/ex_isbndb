ExUnit.start()

# Needed config for the tests
Application.put_env(:ex_isbndb, :plan, :basic)
Application.put_env(:ex_isbndb, :api_key, "API_KEY")
