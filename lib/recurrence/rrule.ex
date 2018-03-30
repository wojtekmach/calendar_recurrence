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
end
