if Code.ensure_loaded?(CalendarInterval) do
  defimpl CalendarRecurrence.T, for: CalendarInterval do
    def add(interval, count, _unit) do
      :day = interval.precision
      CalendarInterval.next(interval, count)
    end

    def continue?(interval1, interval2) do
      :day = interval1.precision
      CalendarInterval.relation(interval1, interval2) in [:preceds, :meets, :equal]
    end
  end
end
