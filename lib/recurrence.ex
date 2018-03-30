defmodule Recurrence do
  @moduledoc """
  Stream of recurring dates.

  ## Examples

      iex> recurrence = Recurrence.new(start: ~D[2018-01-01])
      iex> Enum.take(recurrence, 3)
      [~D[2018-01-01], ~D[2018-01-02], ~D[2018-01-03]]

      iex> recurrence = Recurrence.new(start: ~D[2018-01-01], stop: {:count, 3})
      iex> Enum.to_list(recurrence)
      [~D[2018-01-01], ~D[2018-01-02], ~D[2018-01-03]]

      iex> recurrence = Recurrence.new(start: ~D[2018-01-01], stop: {:until, ~D[2018-01-03]})
      iex> Enum.to_list(recurrence)
      [~D[2018-01-01], ~D[2018-01-02], ~D[2018-01-03]]

      iex> recurrence = Recurrence.new(start: ~D[2018-01-01], step: fn _ -> 2 end)
      iex> Enum.take(recurrence, 3)
      [~D[2018-01-01], ~D[2018-01-03], ~D[2018-01-05]]

  """

  @enforce_keys [:start]

  defstruct [
    start: nil,
    step: 1,
    stop: :never
  ]

  @type date() :: Date.t() | Recurrence.T.t()

  @type stepper() :: (current :: date() -> pos_integer())

  @type t() :: %Recurrence{
          start: Date.t(),
          stop: :never | {:until, date()} | {:count, non_neg_integer()},
          step: pos_integer() | stepper()
        }

  @spec new(keyword()) :: t()
  def new(opts) when is_list(opts) do
    struct!(__MODULE__, opts)
  end

  defimpl Enumerable do
    def count(_), do: {:error, __MODULE__}

    def member?(_, _), do: {:error, __MODULE__}

    def reduce(recurrence, acc, fun) do
      do_reduce(recurrence.start, 1, recurrence, acc, fun)
    end

    def slice(_), do: {:error, __MODULE__}

    defp do_reduce(_start, _count, _recurrence, {:halt, acc}, _fun) do
      {:halted, acc}
    end

    defp do_reduce(_start, _count, _recurrence, {:suspend, acc}, _fun) do
      {:suspended, acc}
    end

    defp do_reduce(current, count, recurrence, {:cont, acc}, fun) do
      if continue?(current, count, recurrence) do
        next = Recurrence.T.add(current, step(recurrence, current))
        do_reduce(next, count + 1, recurrence, fun.(current, acc), fun)
      else
        {:halt, acc}
      end
    end

    defp step(%Recurrence{step: step}, _current) when is_integer(step),
      do: step
    defp step(%Recurrence{step: stepper}, current) when is_function(stepper, 1),
      do: stepper.(current)

    defp continue?(_current, _count, %Recurrence{stop: :never}),
      do: true
    defp continue?(_current, count, %Recurrence{stop: {:count, max}}) when max >= 0,
      do: count <= max
    defp continue?(current, _count, %Recurrence{stop: {:until, date}}),
      do: Recurrence.T.continue?(current, date)
  end
end

defprotocol Recurrence.T do
  def continue?(t1, t2)

  def add(t, count)
end

defimpl Recurrence.T, for: Date do
  def continue?(date1, date2) do
    Date.compare(date1, date2) in [:lt, :eq]
  end

  defdelegate add(date, step), to: Date
end
