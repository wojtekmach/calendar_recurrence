defmodule Recurrence.RRULE do
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
          until: Recurrence.date() | nil,
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
    case Recurrence.RRULE.Parser.parse(binary) do
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
  @spec to_recurrence(t() | String.t(), Recurrence.date()) :: Recurrence.t()
  def to_recurrence(%RRULE{} = rrule, start) do
    Recurrence.new(start: start, stop: stop(rrule), step: step(rrule))
  end

  def to_recurrence(string, start) when is_binary(string) do
    string |> parse!() |> to_recurrence(start)
  end

  defp stop(rrule) do
    cond do
      rrule.count -> {:count, rrule.count}
      rrule.until -> {:until, rrule.until}
      true -> :never
    end
  end

  defp step(%RRULE{freq: :daily, interval: interval}),
    do: interval

  defp step(%RRULE{freq: :weekly, byday: [], interval: interval}),
    do: 7 * interval

  defp step(%RRULE{freq: :weekly, byday: days_of_week, interval: interval}) do
    fn current ->
      current_day_of_week = Date.day_of_week(current)
      next_day_of_week = Enum.find(days_of_week, & &1 > current_day_of_week)

      if next_day_of_week do
        next_day_of_week - current_day_of_week
      else
        (interval * 7) - current_day_of_week + hd(days_of_week)
      end
    end
  end
end
