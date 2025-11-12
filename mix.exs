defmodule CalendarRecurrence.MixProject do
  use Mix.Project

  @version "0.2.0"
  @source_url "https://github.com/wojtekmach/calendar_recurrence"

  def project do
    [
      app: :calendar_recurrence,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      package: [
        description: "CalendarRecurrence is an Elixir library for working with recurring dates.",
        licenses: ["Apache-2.0"],
        links: %{
          "GitHub" => @source_url,
          "Changelog" => "https://hexdocs.pm/calendar_recurrence/changelog.html"
        }
      ],
      docs: [
        source_url: @source_url,
        source_ref: "v#{@version}"
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def cli do
    [
      preferred_envs: [
        docs: :docs,
        "hex.publish": :docs
      ]
    ]
  end

  defp deps do
    [
      {:nimble_parsec, "~> 1.3", only: [:dev, :docs, :test]},
      {:calendar_interval, "~> 0.2.0", optional: true},
      {:ex_doc, "~> 0.31", only: :docs, runtime: false},
      {:zoneinfo, "~> 0.1.8", only: [:test]}
    ]
  end

  defp aliases do
    [
      "compile.rrule": ["nimble_parsec.compile lib/calendar_recurrence/rrule_parser.ex.exs"]
    ]
  end
end
