defmodule ExIsbndb.SearchTest do
  use ExUnit.Case
  import Mock
  alias ExIsbndb.Search

  describe "all/1" do
    @valid_params %{index: "books", author: "Stephen King", page: 1, page_size: 5}
    @not_index_params %{author: "Stephen King", page: 1, page_size: 5}
    @not_valid_index_params %{index: "random_index"}

    test "Returns a response when the params are valid" do
      with_mock(Finch, [:passthrough],
        request: fn _request, _server ->
          {:ok, %Finch.Response{body: "Search...", headers: [], status: 200}}
        end
      ) do
        assert {:ok, %Finch.Response{}} = Search.all(@valid_params)
      end
    end

    test "Raises an error if index not provided" do
      assert_raise FunctionClauseError, fn -> Search.all(@not_index_params) end
    end

    test "Raises an error if index is not any of the accepted" do
      assert_raise FunctionClauseError, fn -> Search.all(@not_valid_index_params) end
    end
  end
end
