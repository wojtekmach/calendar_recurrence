defmodule CalendarRecurrence.RRULE.ParserHelpers do
  @moduledoc false

  import NimbleParsec

  def part(name, combinator) do
    string(name)
    |> ignore(string("="))
    |> concat(combinator)
  end

  def with_separator(combinator, separator_string) do
    separator = separator_string |> string() |> ignore() |> label(separator_string)
    concat(separator, combinator)
  end

  def non_empty_list(combinator, separator_string \\ ",") do
    combinator
    |> repeat(with_separator(combinator, separator_string))
    |> wrap()
  end

  def any_of(enumerable, fun) when is_function(fun, 1) do
    enumerable
    |> Enum.map(&replace(fun.(&1), &1))
    |> choice()
  end

  def zero_pad(val, count) when val >= 0 do
    num = Integer.to_string(val)
    :binary.copy("0", count - byte_size(num)) <> num
  end

  def zero_pad(val, count) do
    "-" <> zero_pad(-val, count)
  end
end

defmodule CalendarRecurrence.RRULE.Parser do
  @moduledoc false

  # parsec:CalendarRecurrence.RRULE.Parser
  import NimbleParsec
  import CalendarRecurrence.RRULE.ParserHelpers

  freqs = ~w(SECONDLY MINUTELY HOURLY DAILY WEEKLY MONTHLY YEARLY)

  year = integer(4)
  month = any_of(1..12, &string(zero_pad(&1, 2)))
  day = any_of(1..31, &string(zero_pad(&1, 2)))
  hour = any_of(0..23, &string(zero_pad(&1, 2)))
  minute = any_of(0..59, &string(zero_pad(&1, 2)))
  second = any_of(0..59, &string(zero_pad(&1, 2)))

  date =
    year
    |> concat(month)
    |> concat(day)
    |> label("date")

  time =
    hour
    |> concat(minute)
    |> concat(second)
    |> label("time")

  datetime =
    date
    |> ignore(string("T"))
    |> concat(time)
    |> label("datetime")

  freq = part("FREQ", any_of(freqs, &string/1))

  until = part("UNTIL", wrap(choice([datetime, date])))

  count = part("COUNT", integer(min: 1))

  interval = part("INTERVAL", integer(min: 1))

  seconds = any_of(59..0, &string(to_string(&1)))
  bysecond = part("BYSECOND", non_empty_list(seconds))

  minutes = any_of(59..0, &string(to_string(&1)))
  byminute = part("BYMINUTE", non_empty_list(minutes))

  hours = any_of(23..0, &string(to_string(&1)))
  byhour = part("BYHOUR", non_empty_list(hours))

  days = any_of(~w(SU MO TU WE TH FR SA), &string(to_string(&1)))
  byday = part("BYDAY", non_empty_list(days))

  part =
    choice([
      freq,
      until,
      count,
      interval,
      bysecond,
      byminute,
      byhour,
      byday
    ])

  defparsec(
    :parse,
    part
    |> repeat(with_separator(part, ";"))
    |> reduce(:to_map)
  )

  # parsec:CalendarRecurrence.RRULE.Parser

  defp to_map(args) do
    args
    |> Enum.chunk_every(2)
    |> Enum.into(%{}, fn [k, v] -> {word_to_atom(k), cast_value(k, v)} end)
  end

  defp word_to_atom(string) do
    string |> String.downcase() |> String.to_atom()
  end

  defp cast_value("FREQ", value), do: word_to_atom(value)

  defp cast_value("UNTIL", [year, month, day]) do
    {:ok, date} = Date.new(year, month, day)
    date
  end

  defp cast_value("UNTIL", [year, month, day, hour, minute, second]) do
    {:ok, naive_datetime} = NaiveDateTime.new(year, month, day, hour, minute, second)
    naive_datetime
  end

  defp cast_value("BYDAY", days), do: Enum.map(days, &cast_byday/1)

  defp cast_value(_, value), do: value

  defp cast_byday("SU"), do: 7
  defp cast_byday("MO"), do: 1
  defp cast_byday("TU"), do: 2
  defp cast_byday("WE"), do: 3
  defp cast_byday("TH"), do: 4
  defp cast_byday("FR"), do: 5
  defp cast_byday("SA"), do: 6
end
