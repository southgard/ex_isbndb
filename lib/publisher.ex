defmodule ExIsbndb.Publisher do
  @moduledoc """
  The `ExIsbndb.Publisher` module contains all the available endpoints for Publishers.

  All functions need to receive a map with params, but only those
  needed for the endpoint will be taken.
  """

  alias ExIsbndb.Client

  @doc """
  Returns the Publisher's details and a list of published Books.

  Params required:

  * name (string) - name of the Publisher

  Params available:

  * page (integer) - page number of the Books to be retrieved
  * page_size(integer) - number of Books to be retrieved per page

  Any other parameters will be ignored.

  ## Examples

      iex> ExIsbndb.Publisher.get(%{name: "Pearson", page: 1, page_size: 5})
      {:ok, %Finch.Response{body: "...", headers: [...], status: 200}}

  """
  @spec get(map()) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def get(%{name: name} = params) when is_binary(name) do
    params = %{page: params[:page], pageSize: params[:page_size]}

    Client.request(:get, "publisher/#{URI.encode(name)}", params)
  end

  @doc """
  Returns all the Publishers that match the given query.

  Params required:

  * query (string) - string used to search

  Params available:

  * page (integer) - page number of the Publishers to be searched
  * page_size (integer) - number of Publishers to be searched per page

  Any other parameters will be ignored.

  ## Examples

      iex> ExIsbndb.Publisher.search(%{query: "oxford", page: 1, page_size: 5})
      {:ok, %Finch.Response{body: "...", headers: [...], status: 200}}

  """
  @spec search(map()) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def search(%{query: query} = params) when is_binary(query) do
    params = %{page: params[:page], pageSize: params[:page_size]}

    Client.request(:get, "publishers/#{URI.encode(query)}", params)
  end
end
