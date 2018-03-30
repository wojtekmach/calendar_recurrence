defmodule RecurrenceTest do
  use ExUnit.Case, async: true
  doctest Recurrence

  test "enumerable" do
    recurrence = Recurrence.new(start: ~D[2018-01-01])

    assert Enum.take(recurrence, 3) == [
             ~D[2018-01-01],
             ~D[2018-01-02],
             ~D[2018-01-03]
           ]
  end

  test "count" do
    assert Enum.count(Recurrence.new(start: ~D[2018-01-01], stop: {:count, 3})) == 3

    assert Enum.count(Recurrence.new(start: ~D[2018-01-01], stop: {:until, ~D[2018-01-03]})) == 3

    assert Enum.count(
             Recurrence.new(start: ~D[2018-01-01], stop: {:until, ~D[2018-01-10]}, step: 2)
           ) == 5
  end
end
