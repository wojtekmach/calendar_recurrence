defmodule Recurrence.RRULETest do
  use ExUnit.Case, async: true
  alias Recurrence.RRULE
  doctest Recurrence.RRULE

  test "parse/1" do
    {:ok, %RRULE{freq: :daily}} = RRULE.parse("FREQ=DAILY")

    {:ok, %RRULE{freq: :daily, until: ~N[2018-01-02 10:20:30]}} = RRULE.parse("FREQ=DAILY;UNTIL=20180102T102030")

    {:ok, %RRULE{freq: :daily, until: ~D[2018-01-02]}} = RRULE.parse("FREQ=DAILY;UNTIL=20180102")

    {:ok, %RRULE{freq: :daily, count: 10}} = RRULE.parse("FREQ=DAILY;COUNT=10")

    {:ok, %RRULE{freq: :daily, count: 10, interval: 2}} = RRULE.parse("FREQ=DAILY;COUNT=10;INTERVAL=2")

    {:ok, %RRULE{freq: :daily, bysecond: [5]}} = RRULE.parse("FREQ=DAILY;BYSECOND=5")

    {:ok, %RRULE{freq: :daily, bysecond: [5, 10]}} = RRULE.parse("FREQ=DAILY;BYSECOND=5,10")

    {:ok, %RRULE{freq: :daily, byminute: [5, 10]}} = RRULE.parse("FREQ=DAILY;BYMINUTE=5,10")

    {:ok, %RRULE{freq: :daily, byhour: [5, 10]}} = RRULE.parse("FREQ=DAILY;BYHOUR=5,10")

    {:error, :missing_freq} = RRULE.parse("COUNT=10")

    {:error, :until_or_count} = RRULE.parse("FREQ=DAILY;UNTIL=20180101;COUNT=10")

    {:error, "expected string \"FREQ\", followed by" <> _} = RRULE.parse("bad")

    {:error, {:leftover, "foobar"}} = RRULE.parse("FREQ=DAILYfoobar")
  end
end