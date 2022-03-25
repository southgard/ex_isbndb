defmodule ExIsbndb.Subject do
  @moduledoc """
  The `ExIsbndb.Subject` module contains all the available endpoints for Subjects.
  """

  alias ExIsbndb.Client

  @doc """
  Returns details of a Subject and a list of Books that belong to it.

  Params required:

  * name (string) - name of the Subject

  ## Examples

      iex> ExIsbndb.Subject.get("drama")
      {:ok, %Finch.Response{body: "...", headers: [...], status: 200}}

  """
  @spec get(binary()) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def get(name) when is_binary(name), do: Client.request(:get, "subject/#{URI.encode(name)}")

  @doc """
  Returns all the Subjects that match the given query.

  Params required:

  * query (string) - string used to search

  Params available:

  * page (integer) - page number of the Subjects to be searched
  * page_size (integer) - number of Subjects to be searched per page

  Any other parameters will be ignored.

  ## Examples

      iex> ExIsbndb.Subject.search(%{query: "epic", page: 1, page_size: 5})
      {:ok, %Finch.Response{body: "...", headers: [...], status: 200}}

  """
  @spec search(map()) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def search(%{query: query} = params) when is_binary(query) do
    params = %{page: params[:page], pageSize: params[:page_size]}

    Client.request(:get, "subjects/#{URI.encode(query)}", params)
  end
end
