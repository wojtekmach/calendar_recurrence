defmodule CalendarRecurrence.RRULE do
  @moduledoc """
  RRULE parser.

  See https://tools.ietf.org/html/rfc5545#section-3.3.10
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
          freq: :monthly | :weekly | :daily | :hourly | :minutely | :secondly | nil,
          interval: pos_integer(),
          until: CalendarRecurrence.date() | nil,
          count: non_neg_integer() | nil
          # bysecond: [0..59],
          # byminute: [0..59],
          # byhour: [0..59],
          # byday: [1..31],
          # bymonthday: ,
          # byyearday: ,
          # byweekno:
          # bymonth: [1..12]
          # bysetpos: ,
          # wkst:
        }

  alias __MODULE__

  @spec parse(String.t()) :: {:ok, t()} | {:error, term()}
  def parse(binary) do
    case CalendarRecurrence.RRULE.Parser.parse(binary) do
      {:ok, [map], "", _, _, _} ->
        if Map.has_key?(map, :freq) do
          if Map.has_key?(map, :until) && Map.has_key?(map, :count) do
            {:error, :until_or_count}
          else
            {:ok, struct!(__MODULE__, map)}
          end
        else
          {:error, :missing_freq}
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

  @doc """
  Converts `rrule` into a recurrence starting at given `start` date.

  ## Examples

      iex> RRULE.to_recurrence(%RRULE{freq: :daily}, ~D[2018-01-01]) |> Enum.take(3)
      [
        ~D[2018-01-01],
        ~D[2018-01-02],
        ~D[2018-01-03]
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

  defp step(%RRULE{freq: :monthly, bymonthday: [], bymonth: months})
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

  defp step(%RRULE{freq: :monthly, bymonthday: days, bymonth: months})
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

  defp step(%RRULE{freq: :monthly, interval: interval, bymonthday: []}) do
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

  defp step(%RRULE{freq: :monthly, interval: interval, bymonthday: days}) when is_list(days) do
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

  defp add_months(%DateTime{} = date, interval) do
    adjust_months(date, interval)
  end

  defp add_months(%Date{} = date, interval) do
    adjust_months(date, interval)
  end

  defp add_months(%NaiveDateTime{} = date, interval) do
    adjust_months(date, interval)
  end

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
end
