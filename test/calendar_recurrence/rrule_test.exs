defmodule CalendarRecurrence.RRULETest do
  use ExUnit.Case, async: true
  alias CalendarRecurrence.RRULE
  doctest CalendarRecurrence.RRULE

  test "parse/1" do
    {:ok, %RRULE{freq: :daily}} = RRULE.parse("FREQ=DAILY")

    {:ok, %RRULE{freq: :daily, until: ~U[2018-01-02 10:20:30Z]}} =
      RRULE.parse("FREQ=DAILY;UNTIL=20180102T102030")

    {:ok, %RRULE{freq: :daily, until: ~D[2018-01-02]}} = RRULE.parse("FREQ=DAILY;UNTIL=20180102")

    {:ok, %RRULE{freq: :daily, count: 10}} = RRULE.parse("FREQ=DAILY;COUNT=10")

    {:ok, %RRULE{freq: :daily, count: 10, interval: 2}} =
      RRULE.parse("FREQ=DAILY;COUNT=10;INTERVAL=2")

    {:ok, %RRULE{freq: :daily, bysecond: [5]}} = RRULE.parse("FREQ=DAILY;BYSECOND=5")

    {:ok, %RRULE{freq: :daily, bysecond: [5, 10]}} = RRULE.parse("FREQ=DAILY;BYSECOND=5,10")

    {:ok, %RRULE{freq: :daily, byminute: [5, 10]}} = RRULE.parse("FREQ=DAILY;BYMINUTE=5,10")

    {:ok, %RRULE{freq: :daily, byhour: [5, 10]}} = RRULE.parse("FREQ=DAILY;BYHOUR=5,10")

    {:ok, %RRULE{freq: :weekly, byday: [1, 2]}} = RRULE.parse("FREQ=WEEKLY;BYDAY=MO,TU")

    {:ok, %RRULE{freq: :monthly}} = RRULE.parse("FREQ=MONTHLY")

    {:ok, %RRULE{freq: :monthly, bymonthday: [-1]}} = RRULE.parse("FREQ=MONTHLY;BYMONTHDAY=-1")

    {:ok, %RRULE{freq: :monthly, bymonthday: [5]}} = RRULE.parse("FREQ=MONTHLY;BYMONTHDAY=5")

    {:ok, %RRULE{freq: :monthly, bymonthday: [-15]}} = RRULE.parse("FREQ=MONTHLY;BYMONTHDAY=-15")

    # test 15 evaluated before 1
    {:ok, %RRULE{freq: :monthly, bymonthday: [15]}} = RRULE.parse("FREQ=MONTHLY;BYMONTHDAY=15")

    {:ok, %RRULE{freq: :monthly, bymonthday: [5], bymonth: [1, 3, 4]}} =
      RRULE.parse("FREQ=MONTHLY;BYMONTHDAY=5;BYMONTH=1,3,4")

    {:ok, %RRULE{freq: :monthly, bymonthday: [15], bymonth: [1, 3, 4]}} =
      RRULE.parse("FREQ=MONTHLY;BYMONTHDAY=15;BYMONTH=1,3,4")

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

    assert Enum.take(RRULE.to_recurrence("FREQ=MONTHLY", ~D[2018-01-15]), 3) == [
             ~D[2018-01-15],
             ~D[2018-02-15],
             ~D[2018-03-15]
           ]

    assert Enum.take(RRULE.to_recurrence("FREQ=MONTHLY", ~D[2018-01-31]), 3) == [
             ~D[2018-01-31],
             ~D[2018-03-31],
             ~D[2018-05-31]
           ]

    # with interval
    assert Enum.take(RRULE.to_recurrence(%RRULE{freq: :monthly, interval: 2}, ~D[2018-01-15]), 3) ==
             [
               ~D[2018-01-15],
               ~D[2018-03-15],
               ~D[2018-05-15]
             ]

    # with DateTime
    assert Enum.take(RRULE.to_recurrence(%RRULE{freq: :monthly}, ~U[2018-01-31 10:00:00Z]), 3) ==
             [
               ~U[2018-01-31 10:00:00Z],
               ~U[2018-03-31 10:00:00Z],
               ~U[2018-05-31 10:00:00Z]
             ]

    # with NaiveDateTime
    assert Enum.take(RRULE.to_recurrence(%RRULE{freq: :monthly}, ~N[2018-01-31 10:00:00]), 3) == [
             ~N[2018-01-31 10:00:00],
             ~N[2018-03-31 10:00:00],
             ~N[2018-05-31 10:00:00]
           ]

    # bymonthday
    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, bymonthday: [-2], count: 4},
               ~D[2024-12-31]
             )
           ) ==
             [
               ~D[2024-12-31],
               ~D[2025-01-30],
               ~D[2025-02-27],
               ~D[2025-03-30]
             ]

    # bymonthday
    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, bymonthday: [-1], count: 4},
               ~D[2024-12-31]
             )
           ) ==
             [
               ~D[2024-12-31],
               ~D[2025-01-31],
               ~D[2025-02-28],
               ~D[2025-03-31]
             ]

    # bymonthday
    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, bymonthday: [15], count: 5},
               ~D[2024-12-31]
             )
           ) ==
             [
               ~D[2024-12-31],
               ~D[2025-01-15],
               ~D[2025-02-15],
               ~D[2025-03-15],
               ~D[2025-04-15]
             ]

    # bymonthday and bymonth
    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, bymonthday: [15], bymonth: [1,3,4], count: 4},
               ~D[2024-12-31]
             )
           ) ==
             [
               ~D[2024-12-31],
               ~D[2025-01-15],
               ~D[2025-02-15],
               ~D[2025-03-15],
             ]

    # with count
    assert Enum.to_list(RRULE.to_recurrence(%RRULE{freq: :monthly, count: 3}, ~D[2018-12-31])) ==
             [
               ~D[2018-12-31],
               ~D[2019-01-31],
               ~D[2019-03-31]
             ]

    # with until date
    assert Enum.to_list(
             RRULE.to_recurrence(%RRULE{freq: :monthly, until: ~D[2019-02-28]}, ~D[2018-12-31])
           ) == [
             ~D[2018-12-31],
             ~D[2019-01-31]
           ]

    # with leap year
    assert Enum.take(RRULE.to_recurrence("FREQ=MONTHLY", ~D[2024-01-29]), 3) == [
             ~D[2024-01-29],
             ~D[2024-02-29],
             ~D[2024-03-29]
           ]

    # crossing year boundary
    assert Enum.take(RRULE.to_recurrence(%RRULE{freq: :monthly, interval: 3}, ~D[2018-11-30]), 3) ==
             [
               ~D[2018-11-30],
               ~D[2019-03-30],
               ~D[2019-06-30]
             ]
  end
end
