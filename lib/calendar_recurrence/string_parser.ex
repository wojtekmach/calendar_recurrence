defmodule CalendarRecurrence.RRULE.StringParser do
  alias CalendarRecurrence.RRULE

  defimpl String.Chars, for: RRULE do
    @doc """
    Converts `%RRULE{}` into a rrule string.

    ## Examples

        iex> to_string(%RRULE{freq: :daily, count: 2})
        "FREQ=DAILY;COUNT=2"

    """
    @spec to_string(CalendarRecurrence.RRULE.t()) :: binary()
    def to_string(rrule) do
      %CalendarRecurrence.RRULE{
        freq: freq,
        interval: interval,
        until: until,
        count: count,
        bysecond: bysecond,
        byminute: byminute,
        byhour: byhour,
        byday: byday,
        bymonthday: bymonthday,
        byyearday: byyearday,
        bymonth: bymonth
      } = rrule

      rule_parts = []

      rule_parts = add_part(rule_parts, "FREQ", freq)
      rule_parts = add_part(rule_parts, "INTERVAL", interval)
      rule_parts = add_part_until(rule_parts, "UNTIL", until)
      rule_parts = add_part(rule_parts, "COUNT", count)
      rule_parts = add_part(rule_parts, "BYSECOND", bysecond)
      rule_parts = add_part(rule_parts, "BYMINUTE", byminute)
      rule_parts = add_part(rule_parts, "BYHOUR", byhour)
      rule_parts = add_part_byday(rule_parts, "BYDAY", byday)
      rule_parts = add_part(rule_parts, "BYMONTHDAY", bymonthday)
      rule_parts = add_part(rule_parts, "BYYEARDAY", byyearday)
      rule_parts = add_part(rule_parts, "BYMONTH", bymonth)
      rule_parts |> Enum.drop(-1) |> IO.iodata_to_binary()
    end

    defp add_part(rule_parts, _key, nil), do: rule_parts
    defp add_part(rule_parts, _key, []), do: rule_parts
    defp add_part(rule_parts, "INTERVAL", 1), do: rule_parts

    defp add_part(rule_parts, key, value) when is_atom(value),
      do: rule_parts ++ [key, "=", Atom.to_string(value) |> String.upcase(), ";"]

    defp add_part(rule_parts, key, value) when is_integer(value),
      do: rule_parts ++ [key, "=", Integer.to_string(value) |> String.upcase(), ";"]

    defp add_part(rule_parts, key, value) when is_list(value) do
      if Enum.all?(value, &is_integer/1) do
        joined =
          Enum.flat_map(value, fn value -> [Integer.to_string(value), ","] end) |> Enum.drop(-1)

        rule_parts ++ [key, "=", joined, ";"]
      end
    end

    defp add_part_byday(rule_parts, _key, []), do: rule_parts

    defp add_part_byday(rule_parts, key, value) when is_list(value) do
      if Enum.all?(value, &is_integer/1) do
        bydays =
          Enum.flat_map(value, fn day_index ->
            mapped =
              case day_index do
                1 -> "MO"
                2 -> "TU"
                3 -> "WE"
                4 -> "TH"
                5 -> "FR"
                6 -> "SA"
                7 -> "SU"
              end

            [mapped, ","]
          end)
          |> Enum.drop(-1)

        rule_parts ++ [key, "=", bydays, ";"]
      end
    end

    defp add_part_until(rule_parts, _key, nil),
      do: rule_parts

    defp add_part_until(rule_parts, key, value),
      do:
        rule_parts ++
          [
            key,
            "=",
            DateTime.to_naive(value) |> NaiveDateTime.to_iso8601(:basic),
            ";"
          ]
  end
end
