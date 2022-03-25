defmodule ExIsbndb.ClientTest do
  use ExUnit.Case
  import Mock
  alias ExIsbndb.Client

  describe "request/3" do
    @valid_path "author/brandon"
    @invalid_path :path

    @valid_get_method :get
    @valid_post_method :post
    @invalid_method "GET"

    @valid_params %{page: 1, page_length: 10}
    @invalid_params [1, 2, 3]

    test "Returns a response when valid params are introduced in a get response" do
      with_mock Finch, [:passthrough],
        request: fn _request, _server ->
          {:ok, %Finch.Response{body: "", headers: [], status: 200}}
        end do
        assert {:ok, %Finch.Response{status: 200}} =
                 Client.request(@valid_get_method, @valid_path, @valid_params)
      end
    end

    test "Returns a response when valid params are introduced in a post response" do
      with_mock Finch, [:passthrough],
        request: fn _request, _server ->
          {:ok, %Finch.Response{body: "", headers: [], status: 200}}
        end do
        assert {:ok, %Finch.Response{status: 200}} =
                 Client.request(@valid_post_method, @valid_path, @valid_params)
      end
    end

    test "Raises an error if method not valid" do
      assert_raise ArgumentError, fn ->
        Client.request(@invalid_method, @valid_path, @valid_params)
      end
    end

    test "Raises an error if path is not a binary" do
      assert_raise FunctionClauseError, fn ->
        Client.request(@valid_get_method, @invalid_path, @valid_params)
      end
    end

    test "Raises an error if params are not a map" do
      assert_raise FunctionClauseError, fn ->
        Client.request(@valid_get_method, @valid_path, @invalid_params)
      end
    end

    test "Raises an error if API Key not set in config" do
      Application.delete_env(:ex_isbndb, :api_key)

      assert_raise ArgumentError, fn ->
        Client.request(@valid_get_method, @valid_path, @valid_params)
      end

      Application.put_env(:ex_isbndb, :api_key, "API_KEY")
    end

    test "Raises an error if ISBNdb plan not set in config" do
      Application.delete_env(:ex_isbndb, :plan)

      assert_raise ArgumentError, fn ->
        Client.request(@valid_get_method, @valid_path, @valid_params)
      end

      Application.put_env(:ex_isbndb, :plan, :basic)
    end

    test "Raises an error if api_key is not valid" do
      Application.put_env(:ex_isbndb, :api_key, :invalid_api)

      assert_raise KeyError, fn ->
        Client.request(@valid_get_method, @valid_path, @valid_params)
      end

      Application.put_env(:ex_isbndb, :api_key, "APY_KEY")
    end

    test "Raises an error if ISBNdb plan is not valid" do
      Application.put_env(:ex_isbndb, :plan, "CUSTOM PLAN")

      assert_raise KeyError, fn ->
        Client.request(@valid_get_method, @valid_path, @valid_params)
      end

      Application.put_env(:ex_isbndb, :plan, :basic)
    end
  end
end
