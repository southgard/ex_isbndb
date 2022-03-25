defmodule ExIsbndb.Stats do
  @moduledoc """
  The `ExIsbndb.Stats` module contains all endpoints related to the
  stats of the ISBNdb database.
  """

  alias ExIsbndb.Client

  @doc """
  Returns the stats information about the ISBNdb database.

  The response contains:

  * number of books in the database
  * number of authors in the database
  * number of publishers in the database

  This is a good endpoint to test if the API works, as it doesn't need
  any parameter to work.

  ## Examples

      iex> ExIsbndb.Stats.stats()
      {:ok, %Finch.Response{body: "...", headers: [...], status: 200}}

  """
  @spec stats() :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def stats, do: Client.request(:get, "stats/")
end
