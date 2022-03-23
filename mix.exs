defmodule ExIsbndb.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_isbndb,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {ExIsbndb.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Client
      {:jason, "~> 1.3"},
      {:finch, "~> 0.10"},

      # Static code analisis
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},

      # Documentation
      {:ex_doc, "~> 0.28"}
    ]
  end
end
