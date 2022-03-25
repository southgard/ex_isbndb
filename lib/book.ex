defmodule ExIsbndb.Book do
  @moduledoc """
  The `ExIsbndb.Book` module contains all the available endpoints for Books.

  All functions need to receive a map with params, but only those
  needed for the endpoint will be taken.
  """

  alias ExIsbndb.Client

  @valid_column_values ["", "title", "author", "date_published"]

  @doc """
  Returns an instance of Book

  ## Examples

      iex> ExIsbndb.Book.get(1234567789)
      {:ok, %Finch.Response{body: "...", headers: [...], status: 200}}

  """
  @spec get(map()) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def get(isbn13) when is_binary(isbn13) do
    Client.request(:get, "book/#{isbn13}", %{})
  end

  @doc """
  Returns all the Books that match the given query.

  Params required:

  * query (string) - string used to search

  Params available:

  * page (integer) - page number of the Books to be searched
  * page_size (integer) - number of Books to be searched per page
  * column(string) - Search limited to this column with values: ['', title, author, date_published]

  Any other parameters will be ignored.

  ## Examples

      iex> ExIsbndb.Book.search(%{query: "Stormlight", page: 1, page_size: 5, column: ""})
      {:ok, %Finch.Response{body: "...", headers: [...], status: 200}}

  """
  @spec search(map()) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def search(%{query: query} = params) when is_binary(query) do
    params = %{page: params[:page], pageSize: params[:page_size], column: validate_column(params[:page_size])}

    Client.request(:get, "books/#{URI.encode(query)}", params)
  end

  ### PRIV

  defp validate_column(col) when col in @valid_column_values, do: col
  defp validate_column(_), do: ""
end