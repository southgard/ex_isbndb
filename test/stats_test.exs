defmodule ExIsbndb.StatsTest do
  use ExUnit.Case
  import Mock
  alias ExIsbndb.Stats

  describe "stats/1" do
    test "Returns a response" do
      with_mock(Finch, [:passthrough],
        request: fn _request, _server ->
          {:ok, %Finch.Response{body: "Stats...", headers: [], status: 200}}
        end
      ) do
        assert {:ok, %Finch.Response{}} = Stats.stats()
      end
    end
  end
end
