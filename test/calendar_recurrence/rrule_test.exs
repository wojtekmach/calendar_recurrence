defmodule CalendarRecurrence.RRULETest do
  use ExUnit.Case, async: true
  alias CalendarRecurrence.RRULE
  doctest CalendarRecurrence.RRULE

  test "parse/1" do
    {:ok, %RRULE{freq: :daily}} = RRULE.parse("FREQ=DAILY")

    {:ok, %RRULE{freq: :daily, until: ~N[2018-01-02 10:20:30]}} =
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

    # Monthly BYDAY with ordinal prefixes
    {:ok, %RRULE{freq: :monthly, byday: [{1, 1}]}} = RRULE.parse("FREQ=MONTHLY;BYDAY=1MO")
    {:ok, %RRULE{freq: :monthly, byday: [{-1, 5}]}} = RRULE.parse("FREQ=MONTHLY;BYDAY=-1FR")
    {:ok, %RRULE{freq: :monthly, byday: [{2, 7}]}} = RRULE.parse("FREQ=MONTHLY;BYDAY=+2SU")

    {:ok, %RRULE{freq: :monthly, byday: [{1, 1}, {-1, 5}]}} =
      RRULE.parse("FREQ=MONTHLY;BYDAY=1MO,-1FR")

    # Monthly BYDAY without ordinals (plain weekday)
    {:ok, %RRULE{freq: :monthly, byday: [1]}} = RRULE.parse("FREQ=MONTHLY;BYDAY=MO")

    # Monthly BYDAY with multiple plain weekdays
    {:ok, %RRULE{freq: :monthly, byday: [1, 5]}} = RRULE.parse("FREQ=MONTHLY;BYDAY=MO,FR")

    # Weekly BYDAY regression
    {:ok, %RRULE{freq: :weekly, byday: [1, 2]}} = RRULE.parse("FREQ=WEEKLY;BYDAY=MO,TU")

    # BYDAY ordinal boundary values (valid)
    {:ok, %RRULE{byday: [{5, 1}]}} = RRULE.parse("FREQ=MONTHLY;BYDAY=5MO")
    {:ok, %RRULE{byday: [{-5, 5}]}} = RRULE.parse("FREQ=MONTHLY;BYDAY=-5FR")

    # BYDAY ordinal out of range
    {:error, "invalid BYDAY ordinal 6" <> _} = RRULE.parse("FREQ=MONTHLY;BYDAY=6TU")
    {:error, "invalid BYDAY ordinal 9" <> _} = RRULE.parse("FREQ=MONTHLY;BYDAY=9WE")
    {:error, "invalid BYDAY ordinal 0" <> _} = RRULE.parse("FREQ=MONTHLY;BYDAY=0TH")
    {:error, "invalid BYDAY ordinal -6" <> _} = RRULE.parse("FREQ=MONTHLY;BYDAY=-6FR")
  end

  test "to_string/1" do
    assert "FREQ=DAILY" = to_string(%RRULE{freq: :daily})

    assert "FREQ=DAILY;INTERVAL=2;COUNT=10" =
             to_string(%RRULE{freq: :daily, count: 10, interval: 2})

    assert "FREQ=DAILY;UNTIL=20180102" =
             to_string(%RRULE{freq: :daily, until: ~D[2018-01-02]})

    assert "FREQ=DAILY;UNTIL=20180102T102030" =
             to_string(%RRULE{freq: :daily, until: ~N[2018-01-02 10:20:30Z]})

    assert "FREQ=DAILY;UNTIL=20180102T102030" =
             to_string(%RRULE{freq: :daily, until: ~U[2018-01-02 10:20:30Z]})

    assert "FREQ=DAILY;BYSECOND=5,10" = to_string(%RRULE{freq: :daily, bysecond: [5, 10]})
    assert "FREQ=DAILY;BYMINUTE=5,10" = to_string(%RRULE{freq: :daily, byminute: [5, 10]})
    assert "FREQ=WEEKLY;BYDAY=MO,TU" = to_string(%RRULE{freq: :weekly, byday: [1, 2]})

    assert "FREQ=MONTHLY" = to_string(%RRULE{freq: :monthly})

    assert "FREQ=MONTHLY;BYMONTHDAY=5;BYMONTH=1,3,4" =
             to_string(%RRULE{freq: :monthly, bymonthday: [5], bymonth: [1, 3, 4]})

    # Monthly BYDAY with ordinals
    assert "FREQ=MONTHLY;BYDAY=1MO" = to_string(%RRULE{freq: :monthly, byday: [{1, 1}]})
    assert "FREQ=MONTHLY;BYDAY=-1FR" = to_string(%RRULE{freq: :monthly, byday: [{-1, 5}]})

    assert "FREQ=MONTHLY;BYDAY=1MO,-1FR" =
             to_string(%RRULE{freq: :monthly, byday: [{1, 1}, {-1, 5}]})

    # Plain monthly BYDAY
    assert "FREQ=MONTHLY;BYDAY=MO" = to_string(%RRULE{freq: :monthly, byday: [1]})

    # Parse -> to_string -> parse round-trip
    {:ok, rrule} = RRULE.parse("FREQ=MONTHLY;BYDAY=1MO,-1FR")
    assert {:ok, ^rrule} = RRULE.parse(to_string(rrule))
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

    # Per https://datatracker.ietf.org/doc/html/rfc5545#page-132, invalid dates like Feb 31 are ignored.
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

    # multiple bymonthday
    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, bymonthday: [15, 20], count: 5},
               ~D[2024-12-31]
             )
           ) ==
             [
               ~D[2024-12-31],
               ~D[2025-01-15],
               ~D[2025-01-20],
               ~D[2025-02-15],
               ~D[2025-02-20]
             ]

    # bymonthday and bymonth
    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, bymonthday: [15], bymonth: [1, 3, 4], count: 5},
               ~D[2024-12-31]
             )
           ) ==
             [
               ~D[2024-12-31],
               ~D[2025-01-15],
               ~D[2025-03-15],
               ~D[2025-04-15],
               ~D[2026-01-15]
             ]

    # bymonth
    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, bymonth: [1, 3, 4], count: 5},
               ~D[2024-12-31]
             )
           ) ==
             [
               ~D[2024-12-31],
               ~D[2025-01-01],
               ~D[2025-03-01],
               ~D[2025-04-01],
               ~D[2026-01-01]
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

    # Monthly BYDAY: first Monday of every month
    assert Enum.take(
             RRULE.to_recurrence(%RRULE{freq: :monthly, byday: [{1, 1}]}, ~D[2024-01-01]),
             4
           ) == [
             ~D[2024-01-01],
             ~D[2024-02-05],
             ~D[2024-03-04],
             ~D[2024-04-01]
           ]

    # Monthly BYDAY: first Monday with DateTime
    assert Enum.take(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, byday: [{1, 1}]},
               ~U[2024-01-01 10:00:00Z]
             ),
             3
           ) == [
             ~U[2024-01-01 10:00:00Z],
             ~U[2024-02-05 10:00:00Z],
             ~U[2024-03-04 10:00:00Z]
           ]

    # Monthly BYDAY: first Monday with NaiveDateTime
    assert Enum.take(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, byday: [{1, 1}]},
               ~N[2024-01-01 09:00:00]
             ),
             3
           ) == [
             ~N[2024-01-01 09:00:00],
             ~N[2024-02-05 09:00:00],
             ~N[2024-03-04 09:00:00]
           ]

    # Monthly BYDAY: last Friday of every month
    assert Enum.take(
             RRULE.to_recurrence(%RRULE{freq: :monthly, byday: [{-1, 5}]}, ~D[2024-01-26]),
             4
           ) == [
             ~D[2024-01-26],
             ~D[2024-02-23],
             ~D[2024-03-29],
             ~D[2024-04-26]
           ]

    # Monthly BYDAY: second-to-last Friday (-2)
    assert Enum.take(
             RRULE.to_recurrence(%RRULE{freq: :monthly, byday: [{-2, 5}]}, ~D[2024-01-19]),
             4
           ) == [
             ~D[2024-01-19],
             ~D[2024-02-16],
             ~D[2024-03-22],
             ~D[2024-04-19]
           ]

    # Monthly BYDAY: first Monday every 2 months
    assert Enum.take(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, interval: 2, byday: [{1, 1}]},
               ~D[2024-01-01]
             ),
             4
           ) == [
             ~D[2024-01-01],
             ~D[2024-03-04],
             ~D[2024-05-06],
             ~D[2024-07-01]
           ]

    # Monthly BYDAY: 5th Monday (skips months without a 5th Monday)
    assert Enum.take(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, byday: [{5, 1}], count: 3},
               ~D[2024-01-29]
             ),
             3
           ) == [
             ~D[2024-01-29],
             ~D[2024-04-29],
             ~D[2024-07-29]
           ]

    # Monthly BYDAY: year boundary crossing
    assert Enum.take(
             RRULE.to_recurrence(%RRULE{freq: :monthly, byday: [{1, 1}]}, ~D[2024-12-02]),
             3
           ) == [
             ~D[2024-12-02],
             ~D[2025-01-06],
             ~D[2025-02-03]
           ]

    # Monthly BYDAY: ordinal with count
    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, byday: [{1, 1}], count: 4},
               ~D[2024-01-01]
             )
           ) == [
             ~D[2024-01-01],
             ~D[2024-02-05],
             ~D[2024-03-04],
             ~D[2024-04-01]
           ]

    # Monthly BYDAY: ordinal with until
    assert Enum.to_list(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, byday: [{1, 1}], until: ~D[2024-03-04]},
               ~D[2024-01-01]
             )
           ) == [
             ~D[2024-01-01],
             ~D[2024-02-05],
             ~D[2024-03-04]
           ]

    # Monthly BYDAY: every Monday of every month (plain, no ordinal)
    assert Enum.take(
             RRULE.to_recurrence(%RRULE{freq: :monthly, byday: [1]}, ~D[2024-01-01]),
             6
           ) == [
             ~D[2024-01-01],
             ~D[2024-01-08],
             ~D[2024-01-15],
             ~D[2024-01-22],
             ~D[2024-01-29],
             ~D[2024-02-05]
           ]

    # Monthly BYDAY: every Monday with DateTime
    assert Enum.take(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, byday: [1]},
               ~U[2024-01-01 10:00:00Z]
             ),
             3
           ) == [
             ~U[2024-01-01 10:00:00Z],
             ~U[2024-01-08 10:00:00Z],
             ~U[2024-01-15 10:00:00Z]
           ]

    # Monthly BYDAY: every Monday and Friday of every month
    assert Enum.take(
             RRULE.to_recurrence(%RRULE{freq: :monthly, byday: [1, 5]}, ~D[2024-01-01]),
             6
           ) == [
             ~D[2024-01-01],
             ~D[2024-01-05],
             ~D[2024-01-08],
             ~D[2024-01-12],
             ~D[2024-01-15],
             ~D[2024-01-19]
           ]

    # Monthly BYDAY: every Monday every 2 months (plain with interval)
    assert Enum.take(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, interval: 2, byday: [1]},
               ~D[2024-01-29]
             ),
             3
           ) == [
             ~D[2024-01-29],
             ~D[2024-03-04],
             ~D[2024-03-11]
           ]

    # Monthly BYDAY: plain BYDAY year boundary
    assert Enum.take(
             RRULE.to_recurrence(%RRULE{freq: :monthly, byday: [1]}, ~D[2024-12-30]),
             3
           ) == [
             ~D[2024-12-30],
             ~D[2025-01-06],
             ~D[2025-01-13]
           ]

    # Monthly BYDAY: multiple ordinal entries (first Monday and last Friday)
    assert Enum.take(
             RRULE.to_recurrence(
               %RRULE{freq: :monthly, byday: [{1, 1}, {-1, 5}]},
               ~D[2024-01-01]
             ),
             6
           ) == [
             ~D[2024-01-01],
             ~D[2024-01-26],
             ~D[2024-02-05],
             ~D[2024-02-23],
             ~D[2024-03-04],
             ~D[2024-03-29]
           ]

    # Parse and recurrence round-trip
    assert Enum.take(RRULE.to_recurrence("FREQ=MONTHLY;BYDAY=1MO", ~D[2024-01-01]), 3) == [
             ~D[2024-01-01],
             ~D[2024-02-05],
             ~D[2024-03-04]
           ]

    # FREQ=MONTHLY;BYDAY=-1FR → last Friday of every month (string round-trip)
    assert Enum.take(RRULE.to_recurrence("FREQ=MONTHLY;BYDAY=-1FR", ~D[2024-01-26]), 4) == [
             ~D[2024-01-26],
             ~D[2024-02-23],
             ~D[2024-03-29],
             ~D[2024-04-26]
           ]

    # FREQ=MONTHLY;BYDAY=MO → every Monday of every month (string round-trip)
    assert Enum.take(RRULE.to_recurrence("FREQ=MONTHLY;BYDAY=MO", ~D[2024-01-01]), 6) == [
             ~D[2024-01-01],
             ~D[2024-01-08],
             ~D[2024-01-15],
             ~D[2024-01-22],
             ~D[2024-01-29],
             ~D[2024-02-05]
           ]

    # Monthly BYDAY: start date doesn't match the rule (DTSTART is always emitted per RFC 5545)
    # 2024-01-15 is a Monday but the 3rd Monday, not the 1st — start date is still included
    assert Enum.take(
             RRULE.to_recurrence(%RRULE{freq: :monthly, byday: [{1, 1}]}, ~D[2024-01-15]),
             4
           ) == [
             ~D[2024-01-15],
             ~D[2024-02-05],
             ~D[2024-03-04],
             ~D[2024-04-01]
           ]
  end

  test "yearly BYDAY with BYMONTH (e.g., 2nd Sunday of March)" do
    # FREQ=YEARLY;BYMONTH=3;BYDAY=2SU → second Sunday of March every year
    {:ok, rrule} = RRULE.parse("FREQ=YEARLY;BYMONTH=3;BYDAY=2SU")
    assert %RRULE{freq: :yearly, bymonth: [3], byday: [{2, 7}]} = rrule

    assert Enum.take(RRULE.to_recurrence(rrule, ~D[2024-03-10]), 3) == [
             ~D[2024-03-10],
             ~D[2025-03-09],
             ~D[2026-03-08]
           ]
  end
end
