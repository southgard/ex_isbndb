defmodule ExIsbndb.AuthorTest do
  use ExUnit.Case
  import Mock
  alias ExIsbndb.Author

  describe "get/1" do
    @valid_params %{name: "Stephen King", page: 1, page_size: 10}
    @not_name_params %{page: 1, page_size: 10}
    @not_binary_name_params %{name: :name, page: 1, page_size: 10}

    test "Returns a response when the params are valid" do
      with_mock(Finch, [:passthrough],
        request: fn _request, _server ->
          {:ok, %Finch.Response{body: "Author...", headers: [], status: 200}}
        end
      ) do
        assert {:ok, %Finch.Response{}} = Author.get(@valid_params)
      end
    end

    test "Raises an error if name not provided" do
      assert_raise FunctionClauseError, fn -> Author.get(@not_name_params) end
    end

    test "Raises an error if name is not a binary" do
      assert_raise FunctionClauseError, fn -> Author.get(@not_binary_name_params) end
    end
  end

  describe "search/1" do
    @valid_params %{query: "sanderson", page: 1, page_size: 10}
    @not_query_params %{page: 1, page_size: 10}
    @not_binary_query_params %{query: :query, page: 1, page_size: 10}

    test "Returns a response when the params are valid" do
      with_mock(Finch, [:passthrough],
        request: fn _request, _server ->
          {:ok, %Finch.Response{body: "Author...", headers: [], status: 200}}
        end
      ) do
        assert {:ok, %Finch.Response{}} = Author.search(@valid_params)
      end
    end

    test "Raises an error if query not provided" do
      assert_raise FunctionClauseError, fn -> Author.search(@not_query_params) end
    end

    test "Raises an error if query is not a binary" do
      assert_raise FunctionClauseError, fn -> Author.search(@not_binary_query_params) end
    end
  end
end
