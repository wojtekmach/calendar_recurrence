defmodule CalendarRecurrence.MixProject do
  use Mix.Project

  def project() do
    [
      app: :calendar_recurrence,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      source_url: "https://github.com/wojtekmach/calendar_recurrence"
    ]
  end

  def application() do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps() do
    [
      {:nimble_parsec, "~> 1.3", only: [:dev, :test]},
      {:calendar_interval, "~> 0.2.0", optional: true}
    ]
  end

  defp aliases() do
    [
      "compile.rrule": ["nimble_parsec.compile lib/calendar_recurrence/rrule_parser.ex.exs"]
    ]
  end
end
