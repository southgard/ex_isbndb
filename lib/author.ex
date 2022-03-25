defmodule ExIsbndb.Author do
  @moduledoc """
  The `ExIsbndb.Author` module contains all the available endpoints for Authors.

  All functions need to receive a map with params, but only those
  needed for the endpoint will be taken.
  """

  alias ExIsbndb.Client

  @doc """
  Returns an Author and a list of its Books.

  Params required:

  * name (string) - name of the Author

  Params available:

  * page (integer) - page number of the Books to be retrieved
  * page_size(integer) - number of Books to be retrieved per page

  Any other parameters will be ignored.

  ## Examples

      iex> ExIsbndb.Author.get(%{name: "Stephen King", page: 1, page_size: 5})
      {:ok, %Finch.Response{body: "...", headers: [...], status: 200}}

  """
  @spec get(map()) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def get(%{name: name} = params) when is_binary(name) do
    params = %{page: params[:page], pageSize: params[:page_size]}

    Client.request(:get, "author/#{URI.encode(name)}", params)
  end

  @doc """
  Returns all the Authors that match the given query.

  Params required:

  * query (string) - string used to search

  Params available:

  * page (integer) - page number of the Authors to be searched
  * page_size (integer) - number of Authors to be searched per page

  Any other parameters will be ignored.

  ## Examples

      iex> ExIsbndb.Author.search(%{query: "sanderson", page: 1, page_size: 5})
      {:ok, %Finch.Response{body: "...", headers: [...], status: 200}}

  """
  @spec search(map()) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def search(%{query: query} = params) when is_binary(query) do
    params = %{page: params[:page], pageSize: params[:page_size]}

    Client.request(:get, "authors/#{URI.encode(query)}", params)
  end
end
