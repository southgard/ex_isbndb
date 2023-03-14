defmodule ExIsbndb.Search do
  @moduledoc """
  The `ExIsbndb.Search` module contains an endpoint that is able
  to search anything inside the ISBNdb database.

  The available function needs to receive a map with params, but only those
  needed for the endpoint will be taken.
  """

  alias ExIsbndb.Client

  @valid_indexes ["subjects", "publishers", "authors", "books"]

  @doc """
  Returns all the results related to a topic that match the given params.

  No empty or nil values are permitted in this query.

  Params required:

  * index (string) - the topic where the search will be focused on
    * valid values - `"subjects"`, `"publishers"`, `"authors"`, `"books"`

  Params available:

  * page (integer) - page number of the results
  * page_size(integer) - number of results per page
  * isbn (string) - an ISBN 10
  * isbn13 (string) - an ISBN 13
  * author (string) - the name of the author
  * text (string) - a string to search in the determinated index topic
  * subject (string) - a subject
  * publisher (string) - the name of the publisher
  * format (string) -  the desired format of the response

  Any other parameters will be ignored.

  ## Examples

      iex> ExIsbndb.Search.all(%{index: "authors", page: 1, page_size: 5, author: "Stephen King"})
      {:ok, %Finch.Response{body: "...", headers: [...], status: 200}}

  """
  @spec all(map()) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def all(%{index: index} = params) when index in @valid_indexes do
    params =
      %{
        page: params[:page],
        pageSize: params[:page_size],
        isbn: params[:isbn],
        isbn13: params[:isbn13],
        author: params[:author],
        text: params[:text],
        subject: params[:subject],
        publisher: params[:publisher],
        format: params[:format]
      }
      # |> Map.filter(fn {_key, val} -> not is_nil(val) and val != "" end)
      # We are only able to use Map.filter/2 from Elixir 1.13
      # so we are using another solution to get more compatibility
      |> Map.to_list()
      |> Enum.filter(fn {_key, val} -> not is_nil(val) and val != "" end)
      |> Map.new()

    Client.request(:get, "search/#{index}", params)
  end
end
