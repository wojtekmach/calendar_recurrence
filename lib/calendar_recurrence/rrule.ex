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
          freq: :daily,
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
end
