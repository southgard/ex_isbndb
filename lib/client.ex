defmodule ExIsbndb.Client do
  @moduledoc """
  The `Client` module is in charge of creating and sending
  requests to the ISBNdb API.
  """
  @base_url %{
    basic: "https://api2.isbndb.com/",
    premium: "https://api.premium.isbndb.com/",
    pro: "https://api.pro.isbndb.com/"
  }

  @doc """
  Builds and sends a request to the ISBNdb API.

  Accepts `:get` and `:post` methods.

  Example
  ```
  iex> ExIsbndb.Client.request(:get, "author/{author_name}")
  {:ok, %Finch.Reponse{body: "json_string", headers: [...], status: 200}}
  ```
  """
  @spec request(:get | :post, binary(), map()) :: {:ok, Finch.Response.t()} | {:error, any()}
  def request(method, path, params \\ %{}) when is_map(params) and is_binary(path) do
    method
    |> build_request(path, params)
    |> Finch.request(IsbnFinch)
  end

  ##########
  ## PRIV ##
  ##########

  # Builds the Finch request
  defp build_request(:get, path, params),
    do: Finch.build(:get, build_url(path, params), headers())

  defp build_request(:post, path, params),
    do: Finch.build(:post, build_url(path), headers(), Jason.encode_to_iodata!(params))

  defp build_request(method, _path, _params),
    do:
      raise(
        ArgumentError,
        "unsupported method #{inspect(method)}. Supported methods `:get`, `:post`"
      )

  # Builds the URL with the query params if needed
  defp build_url(path), do: base_url() <> path
  defp build_url(path, params), do: base_url() <> path <> "?" <> URI.encode_query(params)

  # Returns the required HTTP headers
  defp headers, do: [{"Authorization", api_key()}]

  # Fetches the ISBNdb API key
  defp api_key do
    case Application.fetch_env!(:ex_isbndb, :api_key) do
      key when is_binary(key) ->
        key

      key ->
        raise KeyError,
              "unsupported API Key #{inspect(key)}. Must be a binary value."
    end
  end

  # Returns the base URL based on the ISBNdb plan
  defp base_url do
    plan = Application.fetch_env!(:ex_isbndb, :plan)

    case Map.fetch(@base_url, plan) do
      :error ->
        raise KeyError,
              "unsupported plan #{inspect(plan)}. Supported plans `:basic`, `:premium`, `:pro`"

      {:ok, url} ->
        url
    end
  end
end
