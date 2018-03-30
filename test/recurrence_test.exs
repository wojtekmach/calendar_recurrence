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
end
