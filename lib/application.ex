defmodule ExIsbndb.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Finch, name: IsbnFinch}
    ]

    opts = [strategy: :one_for_one, name: ExIsbndb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
