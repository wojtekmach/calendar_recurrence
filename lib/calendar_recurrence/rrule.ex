defmodule CalendarRecurrence.RRULE do
  @moduledoc """
  RFC 5545 RRULE parser and recurrence generator.

  Parses RRULE strings into `%RRULE{}` structs, converts them back to strings
  via `String.Chars`, and generates recurring date streams via `to_recurrence/2`.

  ## Supported RRULE properties

    * `FREQ` — `SECONDLY`, `MINUTELY`, `HOURLY`, `DAILY`, `WEEKLY`, `MONTHLY`
    * `INTERVAL` — repeat interval (default 1)
    * `COUNT` — maximum number of occurrences
    * `UNTIL` — end date (Date, NaiveDateTime, or DateTime with `Z` suffix)
    * `BYDAY` — day-of-week filter, with optional ordinal prefix for `MONTHLY`:
      - Plain: `MO`, `TU`, `WE`, `TH`, `FR`, `SA`, `SU`
      - Ordinal: `1MO` (first Monday), `-1FR` (last Friday), `+2SU` (second Sunday)
    * `BYMONTHDAY` — day-of-month (1–31 or -1–-31 for counting from end)
    * `BYMONTH` — month filter (1–12)
    * `BYHOUR`, `BYMINUTE`, `BYSECOND` — time components

  ## BYDAY with MONTHLY frequency

  When `FREQ=MONTHLY`, `BYDAY` supports two modes:

    * **With ordinal prefix** — selects a specific occurrence of a weekday in each
      month. For example, `BYDAY=1MO` means "the first Monday of every month" and
      `BYDAY=-1FR` means "the last Friday of every month". Months that lack the
      requested occurrence (e.g., a 5th Monday) are skipped.

    * **Without ordinal prefix** — selects every occurrence of the weekday in each
      month. For example, `BYDAY=MO` means "every Monday of every month".

  ## Examples

      iex> RRULE.parse!("FREQ=MONTHLY;BYDAY=1MO")
      %RRULE{freq: :monthly, byday: [{1, 1}]}

      iex> RRULE.parse!("FREQ=MONTHLY;BYDAY=-1FR")
      %RRULE{freq: :monthly, byday: [{-1, 5}]}

      iex> to_string(%RRULE{freq: :monthly, byday: [{1, 1}]})
      "FREQ=MONTHLY;BYDAY=1MO"

  See <https://tools.ietf.org/html/rfc5545#section-3.3.10>
  """

  defstruct freq: nil,
            interval: 1,
            until: nil,
            count: nil,
            bysecond: [],
            byminute: [],
            byhour: [],
            byday: [],
            bymonthday: [],
            byyearday: [],
            # byweekno: [],
            bymonth: []

  # bysetpos: nil
  # wkst: nil

  @type t() :: %__MODULE__{
          freq: :yearly | :monthly | :weekly | :daily | :hourly | :minutely | :secondly | nil,
          interval: pos_integer(),
          until: CalendarRecurrence.date() | nil,
          count: non_neg_integer() | nil
          # bysecond: [0..59],
          # byminute: [0..59],
          # byhour: [0..59],
          # byday: [1..7 | {integer(), 1..7}],
          # bymonthday: [-31..-1 | 1..31],
          # byyearday: ,
          # byweekno:
          # bymonth: [1..12]
          # bysetpos: ,
          # wkst:
        }

  alias __MODULE__

  @doc """
  Parses an RRULE string into a `%RRULE{}` struct.

  ## Examples

      iex> RRULE.parse("FREQ=DAILY;COUNT=10")
      {:ok, %RRULE{freq: :daily, count: 10}}

      iex> RRULE.parse("FREQ=WEEKLY;BYDAY=MO,TU")
      {:ok, %RRULE{freq: :weekly, byday: [1, 2]}}

      iex> RRULE.parse("FREQ=MONTHLY;BYDAY=1MO")
      {:ok, %RRULE{freq: :monthly, byday: [{1, 1}]}}

      iex> RRULE.parse("FREQ=MONTHLY;BYDAY=-1FR")
      {:ok, %RRULE{freq: :monthly, byday: [{-1, 5}]}}

  Weekdays are represented as integers 1 (Monday) through 7 (Sunday).
  Ordinal BYDAY values are tuples `{ordinal, weekday}` where positive
  ordinals count from the start of the month and negative from the end.
  """
  @spec parse(String.t()) :: {:ok, t()} | {:error, term()}
  def parse(binary) do
    case CalendarRecurrence.RRULE.Parser.parse(binary) do
      {:ok, [map], "", _, _, _} ->
        with :ok <- validate_freq(map),
             :ok <- validate_until_count(map),
             :ok <- validate_byday(map) do
          {:ok, struct!(__MODULE__, map)}
        end

      {:ok, _, rest, _, _, _} ->
        {:error, {:leftover, rest}}

      {:error, message, _rest, _, _, _} ->
        {:error, message}
    end
  end

  @spec parse!(String.t()) :: t() | no_return()
  def parse!(binary) do
    case parse(binary) do
      {:ok, rrule} -> rrule
      {:error, reason} -> raise ArgumentError, "parse error: #{inspect(reason)}"
    end
  end

  defp validate_freq(map) do
    if Map.has_key?(map, :freq), do: :ok, else: {:error, :missing_freq}
  end

  defp validate_until_count(map) do
    if Map.has_key?(map, :until) && Map.has_key?(map, :count),
      do: {:error, :until_or_count},
      else: :ok
  end

  defp validate_byday(%{byday: days}) do
    Enum.reduce_while(days, :ok, fn
      {ordinal, weekday}, :ok ->
        cond do
          weekday not in 1..7 ->
            {:halt, {:error, "invalid BYDAY weekday #{weekday}, must be 1 (MO) through 7 (SU)"}}

          ordinal == 0 or ordinal > 5 or ordinal < -5 ->
            {:halt,
             {:error,
              "invalid BYDAY ordinal #{ordinal}, must be between -5 and 5 (excluding 0), e.g. 1MO (first Monday) or -1FR (last Friday)"}}

          true ->
            {:cont, :ok}
        end

      weekday, :ok when is_integer(weekday) ->
        if weekday in 1..7,
          do: {:cont, :ok},
          else:
            {:halt, {:error, "invalid BYDAY weekday #{weekday}, must be 1 (MO) through 7 (SU)"}}
    end)
  end

  defp validate_byday(_map), do: :ok

  @doc """
  Converts `rrule` into a recurrence starting at given `start` date.

  Accepts an `%RRULE{}` struct or a raw RRULE string. The `start` date can be
  a `Date`, `NaiveDateTime`, or `DateTime`.

  ## Examples

      iex> RRULE.to_recurrence(%RRULE{freq: :daily}, ~D[2018-01-01]) |> Enum.take(3)
      [
        ~D[2018-01-01],
        ~D[2018-01-02],
        ~D[2018-01-03]
      ]

  First Monday of every month:

      iex> RRULE.to_recurrence("FREQ=MONTHLY;BYDAY=1MO", ~D[2024-01-01]) |> Enum.take(3)
      [
        ~D[2024-01-01],
        ~D[2024-02-05],
        ~D[2024-03-04]
      ]

  Last Friday of every month:

      iex> RRULE.to_recurrence("FREQ=MONTHLY;BYDAY=-1FR", ~D[2024-01-26]) |> Enum.take(3)
      [
        ~D[2024-01-26],
        ~D[2024-02-23],
        ~D[2024-03-29]
      ]

  """
  @spec to_recurrence(t() | String.t(), CalendarRecurrence.date()) :: CalendarRecurrence.t()
  def to_recurrence(%RRULE{} = rrule, %DateTime{} = start) do
    CalendarRecurrence.new(
      start: start,
      stop: stop(rrule, start),
      step: step(rrule),
      unit: :second
    )
  end

  def to_recurrence(%RRULE{} = rrule, start) do
    CalendarRecurrence.new(start: start, stop: stop(rrule, start), step: step(rrule))
  end

  def to_recurrence(string, start) when is_binary(string) do
    string |> parse!() |> to_recurrence(start)
  end

  defp stop(rrule, start) do
    cond do
      rrule.count -> {:count, rrule.count}
      rrule.until -> {:until, convert_date_type(rrule, start)}
      true -> :never
    end
  end

  defp convert_date_type(%RRULE{until: %Date{} = until}, %NaiveDateTime{}) do
    NaiveDateTime.new!(until, ~T[23:59:59])
  end

  defp convert_date_type(%RRULE{until: %Date{} = until}, %DateTime{}) do
    DateTime.new!(until, ~T[23:59:59], "Etc/UTC")
  end

  defp convert_date_type(%RRULE{until: %NaiveDateTime{} = until}, %Date{}) do
    NaiveDateTime.to_date(until)
  end

  defp convert_date_type(%RRULE{until: %NaiveDateTime{} = until}, %DateTime{}) do
    DateTime.from_naive!(until, "Etc/UTC")
  end

  defp convert_date_type(%RRULE{until: %DateTime{} = until}, %Date{}) do
    DateTime.to_date(until)
  end

  defp convert_date_type(%RRULE{until: %DateTime{} = until}, %NaiveDateTime{}) do
    DateTime.to_naive(until)
  end

  defp convert_date_type(%RRULE{until: until}, _), do: until

  defp step(%RRULE{freq: :monthly, byday: [], bymonthday: [], bymonth: months})
       when is_list(months) and length(months) > 0 do
    months = Enum.sort(months)

    fn
      %DateTime{} = current ->
        next_month = Enum.find(months, &(&1 > current.month))

        next =
          if next_month do
            %{current | month: next_month, day: 1}
          else
            next_month = List.first(months)
            %{current | year: current.year + 1, month: next_month, day: 1}
          end

        DateTime.diff(next, current, :second)

      current ->
        next_month = Enum.find(months, &(&1 > current.month))

        if next_month do
          Date.diff(%{current | month: next_month, day: 1}, current)
        else
          next_month = List.first(months)
          Date.diff(%{current | year: current.year + 1, month: next_month, day: 1}, current)
        end
    end
  end

  defp step(%RRULE{freq: :monthly, byday: [], bymonthday: days, bymonth: months})
       when is_list(days) and is_list(months) and length(months) > 0 do
    months = Enum.sort(months)
    days = List.first(days)

    fn
      %DateTime{} = current ->
        next_month = Enum.find(months, &(&1 > current.month))

        next =
          if next_month do
            %{current | month: next_month, day: days}
          else
            next_month = List.first(months)
            %{current | year: current.year + 1, month: next_month, day: days}
          end

        DateTime.diff(next, current, :second)

      current ->
        next_month = Enum.find(months, &(&1 > current.month))

        if next_month do
          Date.diff(%{current | month: next_month, day: days}, current)
        else
          next_month = List.first(months)
          Date.diff(%{current | year: current.year + 1, month: next_month, day: days}, current)
        end
    end
  end

  # Monthly BYDAY with ordinal prefixes (e.g., BYDAY=1MO,-1FR)
  defp step(%RRULE{
         freq: :monthly,
         interval: interval,
         byday: [{_, _} | _] = byday,
         bymonthday: []
       }) do
    fn
      %DateTime{} = current ->
        next = next_monthly_ordinal_byday(current, byday, interval)
        DateTime.diff(next, current, :second)

      current ->
        next = next_monthly_ordinal_byday(current, byday, interval)
        Date.diff(next, current)
    end
  end

  # Monthly BYDAY without ordinals (e.g., BYDAY=MO — every Monday of every month)
  defp step(%RRULE{freq: :monthly, interval: interval, byday: [d | _] = byday, bymonthday: []})
       when is_integer(d) do
    days_of_week = Enum.sort(byday)

    fn
      %DateTime{} = current ->
        next = next_monthly_plain_byday(current, days_of_week, interval)
        DateTime.diff(next, current, :second)

      current ->
        next = next_monthly_plain_byday(current, days_of_week, interval)
        Date.diff(next, current)
    end
  end

  defp step(%RRULE{freq: :monthly, interval: interval, byday: [], bymonthday: []}) do
    fn
      %DateTime{} = current ->
        next = add_months(current, interval)
        DateTime.diff(next, current, :second)

      current ->
        # if Date or NaiveDateTime, return days until next occurrence
        next = add_months(current, interval)
        Date.diff(next, current)
    end
  end

  defp step(%RRULE{freq: :monthly, interval: interval, byday: [], bymonthday: days})
       when is_list(days) do
    days = Enum.sort(days)

    fn
      %DateTime{} = current ->
        next = next_monthday(current, days, interval)
        DateTime.diff(next, current, :second)

      current ->
        next = next_monthday(current, days, interval)
        Date.diff(next, current)
    end
  end

  # Yearly BYDAY with BYMONTH (e.g., FREQ=YEARLY;BYMONTH=3;BYDAY=2SU)
  defp step(%RRULE{
         freq: :yearly,
         interval: interval,
         bymonth: months,
         byday: [{_, _} | _] = byday,
         bymonthday: []
       })
       when is_list(months) and length(months) > 0 do
    months = Enum.sort(months)

    fn
      %DateTime{} = current ->
        next = next_yearly_ordinal_byday(current, months, byday, interval)
        DateTime.diff(next, current, :second)

      current ->
        next = next_yearly_ordinal_byday(current, months, byday, interval)
        Date.diff(next, current)
    end
  end

  defp step(%RRULE{freq: :weekly, byday: [], interval: interval}),
    do: fn
      %DateTime{} = date ->
        DateTime.add(date, interval * 7, :day) |> DateTime.diff(date, :second)

      _date ->
        7 * interval
    end

  defp step(%RRULE{freq: :weekly, byday: days_of_week, interval: interval}) do
    days_of_week = Enum.sort(days_of_week)

    fn
      %DateTime{} = current ->
        current_day_of_week = Date.day_of_week(current)
        next_day_of_week = Enum.find(days_of_week, &(&1 > current_day_of_week))

        if next_day_of_week do
          DateTime.add(current, next_day_of_week - current_day_of_week, :day)
          |> DateTime.diff(current, :second)
        else
          DateTime.add(current, interval * 7 - current_day_of_week + hd(days_of_week), :day)
          |> DateTime.diff(current, :second)
        end

      current ->
        current_day_of_week = Date.day_of_week(current)
        next_day_of_week = Enum.find(days_of_week, &(&1 > current_day_of_week))

        if next_day_of_week do
          next_day_of_week - current_day_of_week
        else
          interval * 7 - current_day_of_week + hd(days_of_week)
        end
    end
  end

  defp step(%RRULE{freq: :daily, interval: interval}),
    do: fn
      %DateTime{} = date ->
        DateTime.add(date, interval, :day) |> DateTime.diff(date, :second)

      _date ->
        interval
    end

  defp step(%RRULE{freq: :hourly, interval: interval}),
    do: fn date -> DateTime.add(date, interval, :hour) |> DateTime.diff(date, :second) end

  defp step(%RRULE{freq: :minutely, interval: interval}),
    do: fn date ->
      DateTime.add(date, interval, :minute) |> DateTime.diff(date, :second)
    end

  defp step(%RRULE{freq: :secondly, interval: interval}),
    do: fn date ->
      DateTime.add(date, interval, :second) |> DateTime.diff(date, :second)
    end

  defp add_months(date, interval), do: adjust_months(date, interval)

  defp adjust_months(date, interval) do
    original_day = date.day
    new_month = date.month + interval
    years_to_add = div(new_month - 1, 12)
    final_month = rem(new_month - 1, 12) + 1

    days_in_new_month = :calendar.last_day_of_the_month(date.year + years_to_add, final_month)

    if original_day > days_in_new_month do
      # Skip to next month if this would create an invalid date
      adjust_months(date, interval + 1)
    else
      new_day =
        cond do
          # -1 in bymonthday
          original_day < 0 -> days_in_new_month
          true -> original_day
        end

      %{date | year: date.year + years_to_add, month: final_month, day: new_day}
    end
  end

  defp next_monthday(current, days, interval) do
    current_month_days =
      days
      |> Enum.map(fn day ->
        # -1, -2 etc
        if day < 0 do
          # get next occurrence
          :calendar.last_day_of_the_month(current.year, current.month) + day + 1
        else
          day
        end
      end)
      |> Enum.filter(fn day ->
        day <= :calendar.last_day_of_the_month(current.year, current.month) &&
          %{current | day: day} |> Date.compare(current) == :gt
      end)

    case current_month_days do
      [] ->
        # no valid days in current month, move to next month
        new_month = current.month + interval

        next_month =
          cond do
            new_month > 12 ->
              years_to_add = div(new_month - 1, 12)
              remaining_month = rem(new_month - 1, 12) + 1
              %{current | year: current.year + years_to_add, month: remaining_month}

            true ->
              %{current | month: new_month}
          end

        # now take the bymonthday days from the next month
        next_day =
          days
          |> Enum.map(fn day ->
            if day < 0 do
              :calendar.last_day_of_the_month(next_month.year, next_month.month) + day + 1
            else
              day
            end
          end)
          |> Enum.filter(fn day ->
            day <= :calendar.last_day_of_the_month(next_month.year, next_month.month)
          end)
          |> Enum.sort()
          |> List.first()

        %{next_month | day: next_day}

      [next_day | _] ->
        %{current | day: next_day}
    end
  end

  defp nth_weekday_of_month(year, month, weekday, ordinal) when ordinal > 0 do
    first_day_dow = :calendar.day_of_the_week(year, month, 1)
    days_until = rem(weekday - first_day_dow + 7, 7)
    target_day = days_until + 1 + (ordinal - 1) * 7
    last_day = :calendar.last_day_of_the_month(year, month)
    if target_day <= last_day, do: target_day, else: nil
  end

  defp nth_weekday_of_month(year, month, weekday, ordinal) when ordinal < 0 do
    last_day = :calendar.last_day_of_the_month(year, month)
    last_day_dow = :calendar.day_of_the_week(year, month, last_day)
    days_back = rem(last_day_dow - weekday + 7, 7)
    last_occurrence = last_day - days_back
    target_day = last_occurrence + (ordinal + 1) * 7
    if target_day >= 1, do: target_day, else: nil
  end

  defp next_monthly_ordinal_byday(current, byday, interval) do
    matching_days =
      byday
      |> Enum.map(fn {ordinal, weekday} ->
        nth_weekday_of_month(current.year, current.month, weekday, ordinal)
      end)
      |> Enum.reject(&is_nil/1)
      |> Enum.filter(&(&1 > current.day))
      |> Enum.sort()

    case matching_days do
      [next_day | _] ->
        %{current | day: next_day}

      [] ->
        next_month_start = advance_month(current, interval)
        find_first_ordinal_byday(next_month_start, byday, interval)
    end
  end

  defp find_first_ordinal_byday(date, byday, interval, attempts \\ 0) do
    if attempts >= 12 do
      raise ArgumentError,
            "no matching BYDAY occurrence found within #{12 * interval} months of #{Date.to_iso8601(date)}"
    end

    matching_days =
      byday
      |> Enum.map(fn {ordinal, weekday} ->
        nth_weekday_of_month(date.year, date.month, weekday, ordinal)
      end)
      |> Enum.reject(&is_nil/1)
      |> Enum.sort()

    case matching_days do
      [first_day | _] ->
        %{date | day: first_day}

      [] ->
        find_first_ordinal_byday(advance_month(date, interval), byday, interval, attempts + 1)
    end
  end

  defp next_monthly_plain_byday(current, days_of_week, interval) do
    last_day = :calendar.last_day_of_the_month(current.year, current.month)
    current_dow = :calendar.day_of_the_week(current.year, current.month, current.day)

    candidates =
      days_of_week
      |> Enum.flat_map(fn dow ->
        diff = rem(dow - current_dow + 7, 7)
        diff = if diff == 0, do: 7, else: diff
        next_day = current.day + diff
        if next_day <= last_day, do: [next_day], else: []
      end)
      |> Enum.sort()

    case candidates do
      [next_day | _] ->
        %{current | day: next_day}

      [] ->
        next_month_start = advance_month(current, interval)
        find_first_plain_byday(next_month_start, days_of_week)
    end
  end

  defp find_first_plain_byday(date, days_of_week) do
    first_day_dow = :calendar.day_of_the_week(date.year, date.month, 1)

    first_day =
      days_of_week
      |> Enum.map(fn dow ->
        diff = rem(dow - first_day_dow + 7, 7)
        diff + 1
      end)
      |> Enum.sort()
      |> List.first()

    %{date | day: first_day}
  end

  defp advance_month(date, interval) do
    new_month = date.month + interval
    years_to_add = div(new_month - 1, 12)
    remaining_month = rem(new_month - 1, 12) + 1
    %{date | year: date.year + years_to_add, month: remaining_month, day: 1}
  end

  defp next_yearly_ordinal_byday(current, months, byday, interval) do
    matching_dates =
      for month <- months,
          {ordinal, weekday} <- byday,
          day = nth_weekday_of_month(current.year, month, weekday, ordinal),
          day != nil,
          month > current.month or (month == current.month and day > current.day) do
        {month, day}
      end
      |> Enum.sort()

    case matching_dates do
      [{month, day} | _] ->
        %{current | month: month, day: day}

      [] ->
        find_first_yearly_ordinal_byday(current, current.year + interval, months, byday, interval)
    end
  end

  defp find_first_yearly_ordinal_byday(current, year, months, byday, interval, attempts \\ 0) do
    if attempts >= 10 do
      raise ArgumentError,
            "no matching yearly BYDAY occurrence found within 10 years of #{year}"
    end

    matching_dates =
      for month <- months,
          {ordinal, weekday} <- byday,
          day = nth_weekday_of_month(year, month, weekday, ordinal),
          day != nil do
        {month, day}
      end
      |> Enum.sort()

    case matching_dates do
      [{month, day} | _] ->
        %{current | year: year, month: month, day: day}

      [] ->
        find_first_yearly_ordinal_byday(
          current,
          year + interval,
          months,
          byday,
          interval,
          attempts + 1
        )
    end
  end

  defimpl String.Chars do
    @doc """
    Converts `%RRULE{}` into a rrule string.

    ## Examples

        iex> to_string(%RRULE{freq: :daily, count: 2})
        "FREQ=DAILY;COUNT=2"

    """
    @spec to_string(CalendarRecurrence.RRULE.t()) :: binary()
    def to_string(rrule) do
      rrule = Map.from_struct(rrule)

      [
        :freq,
        :interval,
        :until,
        :count,
        :bysecond,
        :byminute,
        :byhour,
        :byday,
        :bymonthday,
        :byyearday,
        :bymonth
      ]
      |> Enum.reduce([], fn key, acc -> [add_part(key, rrule[key]) | acc] end)
      |> Enum.reverse()
      |> Enum.reject(&is_nil/1)
      |> Enum.intersperse(";")
      |> IO.iodata_to_binary()
    end

    @weekdays %{
      1 => "MO",
      2 => "TU",
      3 => "WE",
      4 => "TH",
      5 => "FR",
      6 => "SA",
      7 => "SU"
    }

    defp add_part(_key, nil), do: nil
    defp add_part(_key, []), do: nil
    defp add_part(:interval, 1), do: nil

    defp add_part(:until = key, %DateTime{} = value) do
      key_value(key, DateTime.to_naive(value) |> NaiveDateTime.to_iso8601(:basic))
    end

    defp add_part(:until = key, %NaiveDateTime{} = value) do
      key_value(key, NaiveDateTime.to_iso8601(value, :basic))
    end

    defp add_part(:until = key, %Date{} = value) do
      key_value(key, Date.to_iso8601(value, :basic))
    end

    defp add_part(:byday = key, value) do
      days =
        Enum.map_join(value, ",", fn
          {ordinal, day} -> "#{ordinal}#{@weekdays[day]}"
          day -> @weekdays[day]
        end)

      key_value(key, days)
    end

    defp add_part(key, value) when is_list(value) do
      values = value |> Enum.join(",")
      key_value(key, values)
    end

    defp add_part(key, value) when is_integer(value) or is_atom(value) do
      key_value(key, upcase(value))
    end

    defp key_value(key, value) do
      [upcase(key), "=", value]
    end

    defp upcase(value) do
      String.Chars.to_string(value) |> String.upcase()
    end
  end
end
