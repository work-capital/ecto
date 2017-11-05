defmodule Ecto.Mixfile do
  use Mix.Project

  @version "3.0.0-dev"

  def project do
    [app: :ecto,
     version: @version,
     elixir: "~> 1.4",
     deps: deps(),
     build_per_environment: false,
     consolidate_protocols: false,

     # Hex
     description: "A database wrapper and language integrated query for Elixir",
     package: package(),

     # Docs
     name: "Ecto",
     docs: docs()]
  end

  def application do
    [
      applications: [:logger, :decimal, :crypto]
    ]
  end

  defp deps do
    [
      {:decimal, "~> 1.2"},

      # Optional
      {:poison, "~> 2.2 or ~> 3.0", optional: true},

      # Docs
      {:ex_doc, "~> 0.17", only: :docs},
      {:inch_ex, ">= 0.0.0", only: :docs}
    ]
  end

  defp package do
    [
      maintainers: ["Eric Meadows-Jönsson", "José Valim", "James Fish", "Michał Muskała"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/elixir-ecto/ecto"},
      files: ~w(mix.exs README.md CHANGELOG.md lib) ++
             ~w(integration_test/cases integration_test/sql integration_test/support)
    ]
  end

  defp docs do
    [
      main: "Ecto",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/ecto",
      logo: "guides/images/e.png",
      source_url: "https://github.com/elixir-ecto/ecto",
      extras: [
        "guides/Getting Started.md",
        "guides/Associations.md"
      ],
      groups_for_modules: [
        # Ecto,
        # Ecto.Changeset,
        # Ecto.Migration,
        # Ecto.Migrator,
        # Ecto.Multi,
        # Ecto.Schema,
        # Ecto.Schema.Metadata,
        # Ecto.Type,
        # Ecto.UUID,

        "Repo and Queries": [
          Ecto.LogEntry,
          Ecto.Repo,
          Ecto.Query,
          Ecto.Query.API,
          Ecto.Queryable,
          Ecto.SubQuery
        ],

        "Adapters": [
          Ecto.Adapters.MySQL,
          Ecto.Adapters.Postgres,
          Ecto.Adapters.SQL,
          Ecto.Adapters.SQL.Connection,
          Ecto.Adapters.SQL.Sandbox,
        ],

        "Adapter specification": [
          Ecto.Adapter,
          Ecto.Adapter.Migration,
          Ecto.Adapter.Storage,
          Ecto.Adapter.Structure,
          Ecto.Adapter.Transaction,
        ],

        "Association structs": [
          Ecto.Association.BelongsTo,
          Ecto.Association.Has,
          Ecto.Association.HasThrough,
          Ecto.Association.ManyToMany,
          Ecto.Association.NotLoaded,
        ],

        "Migration structs": [
          Ecto.Migration.Command,
          Ecto.Migration.Constraint,
          Ecto.Migration.Index,
          Ecto.Migration.Reference,
          Ecto.Migration.Table,
        ]
      ]
    ]
  end
end
