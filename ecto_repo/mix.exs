defmodule Ecto.Repo.MixProject do
  use Mix.Project

  @adapters [:pg, :mysql]

  def project do
    [
      app: :ecto_repo,
      version: "0.1.0",
      elixir: "~> 1.6-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_paths: test_paths(Mix.env),

     xref: [exclude: [Mariaex, Ecto.Adapters.MySQL.Connection,
                      Postgrex, Ecto.Adapters.Postgres.Connection,
                      DBConnection, DBConnection.Ownership]],


      # Custom testing
      aliases: ["test.all": ["test", "test.adapters"],
                "test.adapters": &test_adapters/1],
      preferred_cli_env: ["test.all": :test],
    ]
  end

  def application do
    [
      applications: [:logger, :decimal, :poolboy, :crypto],
      env: [postgres_map_type: "jsonb"],
      mod: {Ecto.Repo.Application, []}
    ]
  end

  defp deps do
    [
      {:ecto, path: "../ecto"},
      {:poolboy, "~> 1.5"},

      # Drivers
      {:db_connection, "~> 1.1", optional: true},
      {:postgrex, "~> 0.14.0-dev", optional: true, github: "elixir-ecto/postgrex"},
      {:mariaex, "~> 0.9.0-dev", optional: true, github: "xerions/mariaex"},

      # Optional
      {:sbroker, "~> 1.0", optional: true},
      {:poison, "~> 2.2 or ~> 3.0", optional: true}
    ]
  end

  defp test_paths(adapter) when adapter in @adapters, do: ["integration_test/#{adapter}"]
  defp test_paths(_), do: ["test/ecto", "test/mix"]

  defp test_adapters(args) do
    for env <- @adapters, do: env_run(env, args)
  end

  defp env_run(env, args) do
    args = if IO.ANSI.enabled?, do: ["--color"|args], else: ["--no-color"|args]

    IO.puts "==> Running tests for MIX_ENV=#{env} mix test"
    {_, res} = System.cmd "mix", ["test"|args],
                          into: IO.binstream(:stdio, :line),
                          env: [{"MIX_ENV", to_string(env)}]

    if res > 0 do
      System.at_exit(fn _ -> exit({:shutdown, 1}) end)
    end
  end
end
