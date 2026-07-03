# CalendarRecurrence

[![CI](https://github.com/wojtekmach/calendar_recurrence/actions/workflows/ci.yml/badge.svg)](https://github.com/wojtekmach/calendar_recurrence/actions/workflows/ci.yml)

CalendarRecurrence is an Elixir library for working with recurring dates.

## Examples

```elixir
iex> recurrence = CalendarRecurrence.new(start: ~D[2018-01-01], step: 2)
iex> Enum.take(recurrence, 3)
[~D[2018-01-01], ~D[2018-01-03], ~D[2018-01-05]]
```

CalendarRecurrence additionally includes a RRULE parser:

```elixir
iex> alias CalendarRecurrence.RRULE

iex> RRULE.parse("FREQ=DAILY;COUNT=10")
iex> {:ok, %RRULE{freq: :daily, count: 10}}
```

```elixir
iex> RRULE.to_recurrence("FREQ=WEEKLY;COUNT=4;BYDAY=MO,WE", ~D[2018-01-01]) |> Enum.to_list()
[~D[2018-01-01], ~D[2018-01-03], ~D[2018-01-08], ~D[2018-01-10]]
```

Monthly BYDAY with ordinal prefixes is supported per RFC 5545. For example, "first Monday of every month":

```elixir
iex> RRULE.to_recurrence("FREQ=MONTHLY;BYDAY=1MO", ~D[2024-01-01]) |> Enum.take(4)
[~D[2024-01-01], ~D[2024-02-05], ~D[2024-03-04], ~D[2024-04-01]]
```

Negative ordinals count from the end of the month. "Last Friday of every month":

```elixir
iex> RRULE.to_recurrence("FREQ=MONTHLY;BYDAY=-1FR", ~D[2024-01-26]) |> Enum.take(4)
[~D[2024-01-26], ~D[2024-02-23], ~D[2024-03-29], ~D[2024-04-26]]
```

It also implements the `String.Chars` protocol:

```elixir
iex> %RRULE{freq: :daily, bysecond: [5, 10]} |> to_string()
iex> "FREQ=DAILY;BYSECOND=5,10"
```

Currently a small subset of RRULE grammar is implemented, more support coming soon.

## Installation

Add to `mix.exs`:

```elixir
defp deps do
  [
    {:calendar_recurrence, "~> 0.2.0"}
  ]
end
```

## License

Copyright 2018 Wojciech Mach

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
