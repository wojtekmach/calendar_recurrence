defmodule CalendarRecurrence.RRULETest do
  use ExUnit.Case, async: true
  alias CalendarRecurrence.RRULE
  doctest CalendarRecurrence.RRULE

  test "parse/1" do
    {:ok, %RRULE{freq: :daily}} = RRULE.parse("FREQ=DAILY")

    {:ok, %RRULE{freq: :daily, until: ~U[2018-01-02 10:20:30Z]}} =
      RRULE.parse("FREQ=DAILY;UNTIL=20180102T102030")

    {:ok, %RRULE{freq: :daily, until: ~U[2018-01-02 10:20:30Z]}} =
      RRULE.parse("FREQ=DAILY;UNTIL=20180102T102030Z")

    {:ok, %RRULE{freq: :daily, until: ~D[2018-01-02]}} = RRULE.parse("FREQ=DAILY;UNTIL=20180102")

    {:ok, %RRULE{freq: :daily, count: 10}} = RRULE.parse("FREQ=DAILY;COUNT=10")

    {:ok, %RRULE{freq: :daily, count: 10, interval: 2}} =
      RRULE.parse("FREQ=DAILY;COUNT=10;INTERVAL=2")

    {:ok, %RRULE{freq: :daily, bysecond: [5]}} = RRULE.parse("FREQ=DAILY;BYSECOND=5")

    {:ok, %RRULE{freq: :daily, bysecond: [5, 10]}} = RRULE.parse("FREQ=DAILY;BYSECOND=5,10")

    {:ok, %RRULE{freq: :daily, byminute: [5, 10]}} = RRULE.parse("FREQ=DAILY;BYMINUTE=5,10")

    {:ok, %RRULE{freq: :daily, byhour: [5, 10]}} = RRULE.parse("FREQ=DAILY;BYHOUR=5,10")

    {:ok, %RRULE{freq: :weekly, byday: [1, 2]}} = RRULE.parse("FREQ=WEEKLY;BYDAY=MO,TU")

    {:error, :missing_freq} = RRULE.parse("COUNT=10")

    {:error, :until_or_count} = RRULE.parse("FREQ=DAILY;UNTIL=20180101;COUNT=10")

    {:error, "expected string \"FREQ\", followed by" <> _} = RRULE.parse("bad")

    {:error, {:leftover, "foobar"}} = RRULE.parse("FREQ=DAILYfoobar")
  end

  test "to_recurrence/1" do
    assert Enum.take(RRULE.to_recurrence("FREQ=DAILY", ~D[2018-01-01]), 3) == [
             ~D[2018-01-01],
             ~D[2018-01-02],
             ~D[2018-01-03]
           ]

    assert Enum.take(RRULE.to_recurrence(%RRULE{freq: :daily}, ~D[2018-01-01]), 3) == [
             ~D[2018-01-01],
             ~D[2018-01-02],
             ~D[2018-01-03]
           ]

    assert Enum.to_list(RRULE.to_recurrence(%RRULE{freq: :daily, count: 3}, ~D[2018-01-01])) == [
             ~D[2018-01-01],
             ~D[2018-01-02],
             ~D[2018-01-03]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(%RRULE{freq: :daily, until: ~D[2018-01-03]}, ~D[2018-01-01])
           ) == [
             ~D[2018-01-01],
             ~D[2018-01-02],
             ~D[2018-01-03]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :daily, until: ~D[2018-01-03]},
               ~N[2018-01-01 10:00:00]
             )
           ) == [
             ~N[2018-01-01 10:00:00],
             ~N[2018-01-02 10:00:00],
             ~N[2018-01-03 10:00:00]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :daily, until: ~D[2018-01-03]},
               ~U[2018-01-01 10:00:00Z]
             )
           ) == [
             ~U[2018-01-01 10:00:00Z],
             ~U[2018-01-02 10:00:00Z],
             ~U[2018-01-03 10:00:00Z]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :daily, until: ~N[2018-01-03 10:00:00]},
               ~N[2018-01-01 10:00:00]
             )
           ) == [
             ~N[2018-01-01 10:00:00],
             ~N[2018-01-02 10:00:00],
             ~N[2018-01-03 10:00:00]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :daily, until: ~N[2018-01-03 10:00:00]},
               ~D[2018-01-01]
             )
           ) == [
             ~D[2018-01-01],
             ~D[2018-01-02],
             ~D[2018-01-03]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :daily, until: ~N[2018-01-03 10:00:00]},
               ~U[2018-01-01 10:00:00Z]
             )
           ) == [
             ~U[2018-01-01 10:00:00Z],
             ~U[2018-01-02 10:00:00Z],
             ~U[2018-01-03 10:00:00Z]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :daily, until: ~U[2018-01-03 10:00:00Z]},
               ~U[2018-01-01 10:00:00Z]
             )
           ) == [
             ~U[2018-01-01 10:00:00Z],
             ~U[2018-01-02 10:00:00Z],
             ~U[2018-01-03 10:00:00Z]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :daily, until: ~U[2018-01-03 10:00:00Z]},
               ~N[2018-01-01 10:00:00]
             )
           ) == [
             ~N[2018-01-01 10:00:00],
             ~N[2018-01-02 10:00:00],
             ~N[2018-01-03 10:00:00]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :daily, until: ~U[2018-01-03 10:00:00Z]},
               ~D[2018-01-01]
             )
           ) == [
             ~D[2018-01-01],
             ~D[2018-01-02],
             ~D[2018-01-03]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(%RRULE{freq: :daily, count: 3, interval: 2}, ~D[2018-01-01])
           ) == [
             ~D[2018-01-01],
             ~D[2018-01-03],
             ~D[2018-01-05]
           ]

    assert Enum.to_list(RRULE.to_recurrence(%RRULE{freq: :weekly, count: 3}, ~D[2018-01-01])) == [
             ~D[2018-01-01],
             ~D[2018-01-08],
             ~D[2018-01-15]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(%RRULE{freq: :weekly, byday: [1, 2], count: 3}, ~D[2018-01-01])
           ) == [
             ~D[2018-01-01],
             ~D[2018-01-02],
             ~D[2018-01-08]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(%RRULE{freq: :weekly, count: 3}, ~U"2018-01-01 10:00:00Z")
           ) ==
             [
               ~U"2018-01-01 10:00:00Z",
               ~U"2018-01-08 10:00:00Z",
               ~U"2018-01-15 10:00:00Z"
             ]

    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :weekly, byday: [1, 2], count: 3},
               ~U"2018-01-01 10:00:00Z"
             )
           ) == [
             ~U[2018-01-01 10:00:00Z],
             ~U[2018-01-02 10:00:00Z],
             ~U[2018-01-08 10:00:00Z]
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(%RRULE{freq: :daily, count: 3}, ~U"2018-01-01 10:00:00Z")
           ) ==
             [
               ~U"2018-01-01 10:00:00Z",
               ~U"2018-01-02 10:00:00Z",
               ~U"2018-01-03 10:00:00Z"
             ]

    assert Enum.to_list(
             RRULE.to_recurrence(%RRULE{freq: :hourly, count: 3}, ~U"2018-01-01 10:00:00Z")
           ) == [
             ~U"2018-01-01 10:00:00Z",
             ~U"2018-01-01 11:00:00Z",
             ~U"2018-01-01 12:00:00Z"
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(%RRULE{freq: :minutely, count: 3}, ~U"2018-01-01 10:00:00Z")
           ) == [
             ~U"2018-01-01 10:00:00Z",
             ~U"2018-01-01 10:01:00Z",
             ~U"2018-01-01 10:02:00Z"
           ]

    assert Enum.to_list(
             RRULE.to_recurrence(%RRULE{freq: :secondly, count: 3}, ~U"2018-01-01 10:00:00Z")
           ) == [
             ~U"2018-01-01 10:00:00Z",
             ~U"2018-01-01 10:00:01Z",
             ~U"2018-01-01 10:00:02Z"
           ]
  end
end
