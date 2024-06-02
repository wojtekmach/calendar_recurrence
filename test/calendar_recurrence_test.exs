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

  describe "timezones" do
    setup do
      Calendar.put_time_zone_database(Tzdata.TimeZoneDatabase)
    end

    test "wall clock time stays the same while switching to DST" do
      dt = DateTime.new!(~D[2024-03-30], ~T[12:00:00], "Europe/Berlin")

      [datetime1, datetime2] =
        CalendarRecurrence.new(start: dt, stop: {:count, 2})
        |> Enum.to_list()

      assert DateTime.compare(
               datetime1,
               DateTime.new!(~D[2024-03-30], ~T[12:00:00], "Europe/Berlin")
             ) == :eq

      assert DateTime.compare(
               datetime2,
               DateTime.new!(~D[2024-03-31], ~T[12:00:00], "Europe/Berlin")
             ) == :eq
    end

    @doc """
    Recurrence rules may generate recurrence instances with an invalid
    date (e.g., February 30) or nonexistent local time (e.g., 1:30 AM
    on a day where the local time is moved forward by an hour at 1:00
    AM).  Such recurrence instances MUST be ignored and MUST NOT be
    counted as part of the recurrence set.

    https://datatracker.ietf.org/doc/html/rfc5545#section-3.3.10
    """
    test "skip non exisiting time from DST change" do
      dt = DateTime.new!(~D[2024-03-30], ~T[02:00:00], "Europe/Berlin")

      [datetime1, datetime2] =
        CalendarRecurrence.new(start: dt, stop: {:count, 2})
        |> Enum.to_list()

      assert DateTime.compare(
               datetime1,
               DateTime.new!(~D[2024-03-30], ~T[02:00:00], "Europe/Berlin")
             ) == :eq

      assert DateTime.compare(
               datetime2,
               DateTime.new!(~D[2024-04-01], ~T[02:00:00], "Europe/Berlin")
             ) == :eq
    end

    @doc """
    If the computed local start time of a recurrence instance does not
    exist, or occurs more than once, for the specified time zone, the
    time of the recurrence instance is interpreted in the same manner
    as an explicit DATE-TIME value describing that date and time, as
    specified in Section 3.3.5.

    ###3.3.5

    If, based on the definition of the referenced time zone, the local
    time described occurs more than once (when changing from daylight
    to standard time), the DATE-TIME value refers to the first
    occurrence of the referenced time.  Thus, TZID=America/
    New_York:20071104T013000 indicates November 4, 2007 at 1:30 A.M.
    EDT (UTC-04:00).  If the local time described does not occur (when
    changing from standard to daylight time), the DATE-TIME value is
    interpreted using the UTC offset before the gap in local times.
    Thus, TZID=America/New_York:20070311T023000 indicates March 11,
    2007 at 3:30 A.M. EDT (UTC-04:00), one hour after 1:30 A.M. EST
    (UTC-05:00).
    https://stackoverflow.com/questions/68617234/how-are-nonexistant-timestamps-due-to-dst-handled-in-icalendar-recurrence-rules
    """

    test "on ambiguous date choose first datetime" do
      dt = DateTime.new!(~D[2024-10-26], ~T[02:00:00], "Europe/Berlin")

      [datetime1, datetime2] =
        CalendarRecurrence.new(start: dt, stop: {:count, 2})
        |> Enum.to_list()

      assert DateTime.compare(
               datetime1,
               DateTime.new!(~D[2024-10-26], ~T[02:00:00], "Europe/Berlin")
             ) == :eq

      {:ambiguous, first_dt, second_dt} =
        DateTime.new(~D[2024-10-27], ~T[02:00:00], "Europe/Berlin")

      assert DateTime.compare(datetime2, first_dt) == :eq
      assert DateTime.compare(datetime2, second_dt) != :eq
    end
  end
end
