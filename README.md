# CalendarRecurrence

![Build Status](https://github.com/wojtekmach/calendar_recurrence/actions/workflows/ci/badge.svg)

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

Currently a small subset of RRULE grammar is implemented, more support coming soon.

## Installation

Add to `mix.exs`:

```elixir
defp deps() do
  [
    {:calendar_recurrence, github: "wojtekmach/calendar_recurrence"}
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
