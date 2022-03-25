defmodule ExIsbndb.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_isbndb,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Coveralls
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.github": :test
      ],

      # Docs
      name: "ExIsbndb",
      source_url: "https://github.com/southgard/ex_isbndb",
      docs: [
        main: "readme",
        extras: ["README.md"],
        authors: ["Guillem Acero", "Xavi Rodríguez"]
      ]
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

      # Client testing
      {:mock, "~> 0.3", only: :test},

      # Testing coverage
      {:excoveralls, "~> 0.14", only: :test},

      # Static code analisis
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},

      # Documentation
      {:ex_doc, "~> 0.28", only: :dev, runtime: false}
    ]
  end
end
