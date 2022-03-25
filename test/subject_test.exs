defmodule ExIsbndb.SubjectTest do
  use ExUnit.Case
  import Mock
  alias ExIsbndb.Subject

  describe "get/1" do
    @valid_name "drama"
    @not_binary_name :drama

    test "Returns a response when the name is valid" do
      with_mock(Finch, [:passthrough],
        request: fn _request, _server ->
          {:ok, %Finch.Response{body: "Subject...", headers: [], status: 200}}
        end
      ) do
        assert {:ok, %Finch.Response{}} = Subject.get(@valid_name)
      end
    end

    test "Raises an error if the name is not a binary" do
      assert_raise FunctionClauseError, fn -> Subject.get(@not_binary_name) end
    end
  end

  describe "search/1" do
    @valid_params %{query: "epic", page: 1, page_size: 10}
    @not_query_params %{page: 1, page_size: 10}
    @not_binary_query_params %{query: :query, page: 1, page_size: 10}

    test "Returns a response when the params are valid" do
      with_mock(Finch, [:passthrough],
        request: fn _request, _server ->
          {:ok, %Finch.Response{body: "Subject...", headers: [], status: 200}}
        end
      ) do
        assert {:ok, %Finch.Response{}} = Subject.search(@valid_params)
      end
    end

    test "Raises an error if query not provided" do
      assert_raise FunctionClauseError, fn -> Subject.search(@not_query_params) end
    end

    test "Raises an error if query is not a binary" do
      assert_raise FunctionClauseError, fn -> Subject.search(@not_binary_query_params) end
    end
  end
end
