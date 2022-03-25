defmodule ExIsbndb.BookTest do
  use ExUnit.Case
  import Mock
  alias ExIsbndb.Book

  describe "get/1" do
    @valid_isbn "9788466657662"

    test "returns a response when the params are valid" do
      with_mock(Finch, [:passthrough],
        request: fn _request, _server ->
          {:ok, %Finch.Response{body: "Book...", headers: [], status: 200}}
        end
      ) do
        assert {:ok, %Finch.Response{}} = Book.get(@valid_isbn)
      end
    end
  end

  describe "search/1" do
    @valid_params %{query: "StormLight", page: 1, page_size: 10, column: "title"}
    @valid_params_without %{query: "StormLight", page: 1, page_size: 10}
    @not_query_params %{page: 1, page_size: 10}
    @not_binary_query_params %{query: :query, page: 1, page_size: 10}

    test "returns a response when the params are valid" do
      with_mock(Finch, [:passthrough],
        request: fn _request, _server ->
          {:ok, %Finch.Response{body: "Book...", headers: [], status: 200}}
        end
      ) do
        assert {:ok, %Finch.Response{}} = Book.search(@valid_params)
      end
    end

    test "returns a response when the params are valid but column not defined" do
      with_mock(Finch, [:passthrough],
        request: fn _request, _server ->
          {:ok, %Finch.Response{body: "Book...", headers: [], status: 200}}
        end
      ) do
        assert {:ok, %Finch.Response{}} = Book.search(@valid_params_without)
      end
    end

    test "raises an error if query not provided" do
      assert_raise FunctionClauseError, fn -> Book.search(@not_query_params) end
    end

    test "raises an error if query is not a binary" do
      assert_raise FunctionClauseError, fn -> Book.search(@not_binary_query_params) end
    end
  end

  describe "get_by_isbns/1" do
    @isbn_list ["123456789", "987654321"]

    test "returns a response when arguments are valid" do
      with_mock(Finch, [:passthrough],
        request: fn _request, _server ->
          {:ok, %Finch.Response{body: "Book...", headers: [], status: 200}}
        end
      ) do
        assert {:ok, %Finch.Response{}} = Book.get_by_isbns(@isbn_list)
      end
    end

    test "raises an error if isbs are not a list" do
      assert_raise FunctionClauseError, fn -> Book.search("1245566789") end
    end
  end
end
