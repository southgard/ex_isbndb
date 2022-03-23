defmodule ExIsbndb.Client do
  @base_url %{
    basic: "https://api2.isbndb.com/",
    premium: "https://api.premium.isbndb.com/",
    pro: "https://api.pro.isbndb.com/"
  }

  @spec request(:get | :post, binary(), map()) :: {:ok, Finch.Response.t()} | {:error, any()}
  def request(method, path, params) when is_map(params) and is_binary(path)do
    method
    |> build_request(path, params)
    |> case do
      {:error, error} -> {:error, error}

      req -> Finch.request(req, IsbnFinch)
    end
  end

  ### PRIV
  defp build_request(:get, path, params),
    do: Finch.build(:get, build_url(path, params), headers())

  defp build_request(:post, path, params), do:
  Finch.build(:post, build_url(path), headers(), Jason.encode_to_iodata!(params))

  defp build_request(_, _, _), do: {:error, :method_not_supported}

  defp build_url(path), do: base_url() <> path

  defp build_url(path, params), do: base_url() <> path <> "?" <> URI.encode_query(params)

  defp headers, do: [{"Authorization", api_key()}]

  defp api_key, do: Application.fetch_env!(:ex_isbndb, :api_key)

  defp base_url, do: Map.fetch!(@base_url, Application.fetch_env!(:ex_isbndb, :plan))
end
