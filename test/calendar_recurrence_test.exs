defmodule CalendarRecurrenceTest do
  alias CalendarRecurrence.RRULE
  use ExUnit.Case, async: true
  doctest CalendarRecurrence

  test "enumerable" do
    recurrence = CalendarRecurrence.new(start: ~D[2018-01-01])

    assert Enum.take(recurrence, 3) == [
             ~D[2018-01-01],
             ~D[2018-01-02],
             ~D[2018-01-03]
           ]

    assert Stream.take(recurrence, 3) |> Enum.to_list() == [
             ~D[2018-01-01],
             ~D[2018-01-02],
             ~D[2018-01-03]
           ]

    recurrence =
      CalendarRecurrence.new(
        start: ~U[2018-01-01 10:00:00Z],
        step: 1,
        unit: :day
      )

    assert Enum.take(recurrence, 3) == [
             ~U[2018-01-01 10:00:00Z],
             ~U[2018-01-02 10:00:00Z],
             ~U[2018-01-03 10:00:00Z]
           ]

    assert Stream.take(recurrence, 3) |> Enum.to_list() == [
             ~U[2018-01-01 10:00:00Z],
             ~U[2018-01-02 10:00:00Z],
             ~U[2018-01-03 10:00:00Z]
           ]

    recurrence = RRULE.to_recurrence(%RRULE{freq: :daily, count: 3}, ~U[2019-01-01 10:50:00Z])

    assert recurrence
           |> Stream.take_while(fn occurrence ->
             DateTime.compare(~U[2019-01-05 10:00:00Z], occurrence) in [:gt, :eq]
           end)
           |> Stream.filter(fn occurence ->
             DateTime.compare(~U[2019-01-01 10:00:00Z], occurence) in [:lt, :eq]
           end)
           |> Enum.to_list() == [
             ~U[2019-01-01 10:50:00Z],
             ~U[2019-01-02 10:50:00Z],
             ~U[2019-01-03 10:50:00Z]
           ]
  end

  test "count" do
    assert Enum.count(CalendarRecurrence.new(start: ~D[2018-01-01], stop: {:count, 3})) == 3

    assert Enum.count(CalendarRecurrence.new(start: ~U[2018-01-01 10:00:00Z], stop: {:count, 3})) ==
             3

    assert Enum.count(
             CalendarRecurrence.new(
               start: ~U[2018-01-01 10:00:00Z],
               unit: :hour,
               stop: {:count, 3}
             )
           ) ==
             3

    assert Enum.count(
             CalendarRecurrence.new(start: ~D[2018-01-01], stop: {:until, ~D[2018-01-03]})
           ) == 3

    assert Enum.count(
             CalendarRecurrence.new(
               start: ~U[2018-01-01 10:00:00Z],
               stop: {:until, ~U[2018-01-03 10:00:00Z]}
             )
           ) == 3

    assert Enum.count(
             CalendarRecurrence.new(
               start: ~U[2018-01-01 10:00:00Z],
               stop: {:until, ~U[2018-01-01 16:00:00Z]},
               unit: :hour
             )
           ) == 7

    assert Enum.count(
             CalendarRecurrence.new(
               start: ~D[2018-01-01],
               stop: {:until, ~D[2018-01-10]},
               step: 2
             )
           ) == 5

    assert Enum.count(
             CalendarRecurrence.new(
               start: ~U[2018-01-01 10:00:00Z],
               stop: {:until, ~U[2018-01-10 10:00:00Z]},
               step: 2
             )
           ) == 5
  end
end
