# CHANGELOG

## v0.3.0 (2026-11-27)

### Changed

- Require Elixir ~> 1.15

### Fixed

- Fix parsing of two-digit and zero-padded RRULE numbers (#20)
- Fix `to_string/1` dropping the UTC zone from a DateTime UNTIL (#20)

## v0.2.0 (2025-11-12)

- [CalendarRecurrence.RRULE](https://hexdocs.pm/calendar_recurrence/CalendarRecurrence.RRULE.html) add `String.Chars` protocol (#16)
- [CalendarRecurrence.RRULE](https://hexdocs.pm/calendar_recurrence/CalendarRecurrence.RRULE.html) allow optional UTC suffix in UNTIL rule (#8)

This is potentially a **breaking change** as before we would coerce the UNTIL rule to a UTC DateTime

## v0.1.0 (2025-05-12)

- Initial release
