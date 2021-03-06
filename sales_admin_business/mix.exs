defmodule SalesAdmin.MixProject do
  use Mix.Project

  def project do
    [
      app: :sales_admin,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SalesAdmin.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_csv, "~> 0.6"},
      {:decimal, "1.8.1"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"}
    ]
  end

  # Aliases
  defp aliases do
    [ 
     test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
