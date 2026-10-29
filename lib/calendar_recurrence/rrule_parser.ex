# Generated from lib/calendar_recurrence/rrule_parser.ex.exs, do not edit.
# Generated at 2026-10-29 20:17:10Z.

if Code.ensure_loaded?(NimbleParsec) do
  defmodule CalendarRecurrence.RRULE.ParserHelpers do
    @moduledoc false

    import NimbleParsec

    def part(name, combinator) do
      string(name)
      |> ignore(string("="))
      |> concat(combinator)
    end

    def with_separator(combinator, separator_string) do
      separator = separator_string |> string() |> ignore() |> label(separator_string)
      concat(separator, combinator)
    end

    def non_empty_list(combinator, separator_string \\ ",") do
      combinator
      |> repeat(with_separator(combinator, separator_string))
      |> wrap()
    end

    def any_of(enumerable, fun) when is_function(fun, 1) do
      enumerable
      |> Enum.map(&replace(fun.(&1), &1))
      |> choice()
    end

    # RFC 5545 numeric values are 1*2DIGIT, so both "5" and "05" are valid.
    # Longer alternatives come first so "10" is not consumed as "1".
    def integer_in(range) do
      range
      |> Enum.flat_map(&[{Integer.to_string(&1), &1}, {zero_pad(&1, 2), &1}])
      |> Enum.uniq()
      |> Enum.sort_by(fn {string, _value} -> byte_size(string) end, :desc)
      |> Enum.map(fn {string, value} -> replace(string(string), value) end)
      |> choice()
      |> lookahead_not(ascii_char([?0..?9]))
    end

    def zero_pad(val, count) when val >= 0 do
      num = Integer.to_string(val)
      :binary.copy("0", count - byte_size(num)) <> num
    end

    def zero_pad(val, count) do
      "-" <> zero_pad(-val, count)
    end
  end
end

defmodule CalendarRecurrence.RRULE.Parser do
  @moduledoc false

  @doc """
  Parses the given `binary` as parse.

  Returns `{:ok, [token], rest, context, position, byte_offset}` or
  `{:error, reason, rest, context, line, byte_offset}` where `position`
  describes the location of the parse (start position) as `{line, offset_to_start_of_line}`.

  To column where the error occurred can be inferred from `byte_offset - offset_to_start_of_line`.

  ## Options

    * `:byte_offset` - the byte offset for the whole binary, defaults to 0
    * `:line` - the line and the byte offset into that line, defaults to `{1, byte_offset}`
    * `:context` - the initial context value. It will be converted to a map

  """
  @spec parse(binary, keyword) ::
          {:ok, [term], rest, context, line, byte_offset}
          | {:error, reason, rest, context, line, byte_offset}
        when line: {pos_integer, byte_offset},
             byte_offset: non_neg_integer,
             rest: binary,
             reason: String.t(),
             context: map
  def parse(binary, opts \\ []) when is_binary(binary) do
    context = Map.new(Keyword.get(opts, :context, []))
    byte_offset = Keyword.get(opts, :byte_offset, 0)

    line =
      case Keyword.get(opts, :line, 1) do
        {_, _} = line -> line
        line -> {line, byte_offset}
      end

    case parse__0(binary, [], [], context, line, byte_offset) do
      {:ok, acc, rest, context, line, offset} ->
        {:ok, :lists.reverse(acc), rest, context, line, offset}

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp parse__0(rest, acc, stack, context, line, offset) do
    parse__1(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__1(rest, acc, stack, context, line, offset) do
    parse__115(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__3(
         <<"BYMONTHDAY", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__4(rest, ["BYMONTHDAY"] ++ acc, stack, context, comb__line, comb__offset + 11)
  end

  defp parse__3(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"FREQ\", followed by string \"=\", followed by string \"SECONDLY\" or string \"MINUTELY\" or string \"HOURLY\" or string \"DAILY\" or string \"WEEKLY\" or string \"MONTHLY\" or string \"YEARLY\" or string \"UNTIL\", followed by string \"=\", followed by datetime or date or string \"COUNT\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"INTERVAL\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYSECOND\", followed by string \"=\", followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"32\" or string \"33\" or string \"34\" or string \"35\" or string \"36\" or string \"37\" or string \"38\" or string \"39\" or string \"40\" or string \"41\" or string \"42\" or string \"43\" or string \"44\" or string \"45\" or string \"46\" or string \"47\" or string \"48\" or string \"49\" or string \"50\" or string \"51\" or string \"52\" or string \"53\" or string \"54\" or string \"55\" or string \"56\" or string \"57\" or string \"58\" or string \"59\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"32\" or string \"33\" or string \"34\" or string \"35\" or string \"36\" or string \"37\" or string \"38\" or string \"39\" or string \"40\" or string \"41\" or string \"42\" or string \"43\" or string \"44\" or string \"45\" or string \"46\" or string \"47\" or string \"48\" or string \"49\" or string \"50\" or string \"51\" or string \"52\" or string \"53\" or string \"54\" or string \"55\" or string \"56\" or string \"57\" or string \"58\" or string \"59\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYMINUTE\", followed by string \"=\", followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"32\" or string \"33\" or string \"34\" or string \"35\" or string \"36\" or string \"37\" or string \"38\" or string \"39\" or string \"40\" or string \"41\" or string \"42\" or string \"43\" or string \"44\" or string \"45\" or string \"46\" or string \"47\" or string \"48\" or string \"49\" or string \"50\" or string \"51\" or string \"52\" or string \"53\" or string \"54\" or string \"55\" or string \"56\" or string \"57\" or string \"58\" or string \"59\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"32\" or string \"33\" or string \"34\" or string \"35\" or string \"36\" or string \"37\" or string \"38\" or string \"39\" or string \"40\" or string \"41\" or string \"42\" or string \"43\" or string \"44\" or string \"45\" or string \"46\" or string \"47\" or string \"48\" or string \"49\" or string \"50\" or string \"51\" or string \"52\" or string \"53\" or string \"54\" or string \"55\" or string \"56\" or string \"57\" or string \"58\" or string \"59\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYHOUR\", followed by string \"=\", followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYDAY\", followed by string \"=\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"BYMONTH\", followed by string \"=\", followed by string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYMONTHDAY\", followed by string \"=\", followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-09\" or string \"-08\" or string \"-07\" or string \"-06\" or string \"-05\" or string \"-04\" or string \"-03\" or string \"-02\" or string \"-01\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-09\" or string \"-08\" or string \"-07\" or string \"-06\" or string \"-05\" or string \"-04\" or string \"-03\" or string \"-02\" or string \"-01\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\"",
     rest, context, line, offset}
  end

  defp parse__4(rest, acc, stack, context, line, offset) do
    parse__5(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__5(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-31] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-30] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-29] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-28] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-27] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-26] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-25] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-24] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-23] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-22] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-21] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-20] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-19] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-18] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-17] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-16] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-15] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-14] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-13] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-12] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-11] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-10] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-9] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-8] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-7] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-6] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-5] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-4] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-3] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-2] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-1] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-9] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-8] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-7] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [-1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"FREQ\", followed by string \"=\", followed by string \"SECONDLY\" or string \"MINUTELY\" or string \"HOURLY\" or string \"DAILY\" or string \"WEEKLY\" or string \"MONTHLY\" or string \"YEARLY\" or string \"UNTIL\", followed by string \"=\", followed by datetime or date or string \"COUNT\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"INTERVAL\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYSECOND\", followed by string \"=\", followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"32\" or string \"33\" or string \"34\" or string \"35\" or string \"36\" or string \"37\" or string \"38\" or string \"39\" or string \"40\" or string \"41\" or string \"42\" or string \"43\" or string \"44\" or string \"45\" or string \"46\" or string \"47\" or string \"48\" or string \"49\" or string \"50\" or string \"51\" or string \"52\" or string \"53\" or string \"54\" or string \"55\" or string \"56\" or string \"57\" or string \"58\" or string \"59\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"32\" or string \"33\" or string \"34\" or string \"35\" or string \"36\" or string \"37\" or string \"38\" or string \"39\" or string \"40\" or string \"41\" or string \"42\" or string \"43\" or string \"44\" or string \"45\" or string \"46\" or string \"47\" or string \"48\" or string \"49\" or string \"50\" or string \"51\" or string \"52\" or string \"53\" or string \"54\" or string \"55\" or string \"56\" or string \"57\" or string \"58\" or string \"59\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYMINUTE\", followed by string \"=\", followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"32\" or string \"33\" or string \"34\" or string \"35\" or string \"36\" or string \"37\" or string \"38\" or string \"39\" or string \"40\" or string \"41\" or string \"42\" or string \"43\" or string \"44\" or string \"45\" or string \"46\" or string \"47\" or string \"48\" or string \"49\" or string \"50\" or string \"51\" or string \"52\" or string \"53\" or string \"54\" or string \"55\" or string \"56\" or string \"57\" or string \"58\" or string \"59\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"32\" or string \"33\" or string \"34\" or string \"35\" or string \"36\" or string \"37\" or string \"38\" or string \"39\" or string \"40\" or string \"41\" or string \"42\" or string \"43\" or string \"44\" or string \"45\" or string \"46\" or string \"47\" or string \"48\" or string \"49\" or string \"50\" or string \"51\" or string \"52\" or string \"53\" or string \"54\" or string \"55\" or string \"56\" or string \"57\" or string \"58\" or string \"59\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYHOUR\", followed by string \"=\", followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYDAY\", followed by string \"=\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"BYMONTH\", followed by string \"=\", followed by string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYMONTHDAY\", followed by string \"=\", followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-09\" or string \"-08\" or string \"-07\" or string \"-06\" or string \"-05\" or string \"-04\" or string \"-03\" or string \"-02\" or string \"-01\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-09\" or string \"-08\" or string \"-07\" or string \"-06\" or string \"-05\" or string \"-04\" or string \"-03\" or string \"-02\" or string \"-01\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\"",
     rest, context, line, offset}
  end

  defp parse__6(<<x0, _::binary>> = rest, _acc, _stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    {:error,
     "did not expect string \"FREQ\", followed by string \"=\", followed by string \"SECONDLY\" or string \"MINUTELY\" or string \"HOURLY\" or string \"DAILY\" or string \"WEEKLY\" or string \"MONTHLY\" or string \"YEARLY\" or string \"UNTIL\", followed by string \"=\", followed by datetime or date or string \"COUNT\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"INTERVAL\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYSECOND\", followed by string \"=\", followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"32\" or string \"33\" or string \"34\" or string \"35\" or string \"36\" or string \"37\" or string \"38\" or string \"39\" or string \"40\" or string \"41\" or string \"42\" or string \"43\" or string \"44\" or string \"45\" or string \"46\" or string \"47\" or string \"48\" or string \"49\" or string \"50\" or string \"51\" or string \"52\" or string \"53\" or string \"54\" or string \"55\" or string \"56\" or string \"57\" or string \"58\" or string \"59\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"32\" or string \"33\" or string \"34\" or string \"35\" or string \"36\" or string \"37\" or string \"38\" or string \"39\" or string \"40\" or string \"41\" or string \"42\" or string \"43\" or string \"44\" or string \"45\" or string \"46\" or string \"47\" or string \"48\" or string \"49\" or string \"50\" or string \"51\" or string \"52\" or string \"53\" or string \"54\" or string \"55\" or string \"56\" or string \"57\" or string \"58\" or string \"59\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYMINUTE\", followed by string \"=\", followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"32\" or string \"33\" or string \"34\" or string \"35\" or string \"36\" or string \"37\" or string \"38\" or string \"39\" or string \"40\" or string \"41\" or string \"42\" or string \"43\" or string \"44\" or string \"45\" or string \"46\" or string \"47\" or string \"48\" or string \"49\" or string \"50\" or string \"51\" or string \"52\" or string \"53\" or string \"54\" or string \"55\" or string \"56\" or string \"57\" or string \"58\" or string \"59\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"32\" or string \"33\" or string \"34\" or string \"35\" or string \"36\" or string \"37\" or string \"38\" or string \"39\" or string \"40\" or string \"41\" or string \"42\" or string \"43\" or string \"44\" or string \"45\" or string \"46\" or string \"47\" or string \"48\" or string \"49\" or string \"50\" or string \"51\" or string \"52\" or string \"53\" or string \"54\" or string \"55\" or string \"56\" or string \"57\" or string \"58\" or string \"59\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYHOUR\", followed by string \"=\", followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"00\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"0\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYDAY\", followed by string \"=\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"BYMONTH\", followed by string \"=\", followed by string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYMONTHDAY\", followed by string \"=\", followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-09\" or string \"-08\" or string \"-07\" or string \"-06\" or string \"-05\" or string \"-04\" or string \"-03\" or string \"-02\" or string \"-01\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ,, followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-09\" or string \"-08\" or string \"-07\" or string \"-06\" or string \"-05\" or string \"-04\" or string \"-03\" or string \"-02\" or string \"-01\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"01\" or string \"02\" or string \"03\" or string \"04\" or string \"05\" or string \"06\" or string \"07\" or string \"08\" or string \"09\" or string \"10\" or string \"11\" or string \"12\" or string \"13\" or string \"14\" or string \"15\" or string \"16\" or string \"17\" or string \"18\" or string \"19\" or string \"20\" or string \"21\" or string \"22\" or string \"23\" or string \"24\" or string \"25\" or string \"26\" or string \"27\" or string \"28\" or string \"29\" or string \"30\" or string \"31\" or string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\", followed by ASCII character in the range \"0\" to \"9\"",
     rest, context, line, offset}
  end

  defp parse__6(rest, acc, stack, context, line, offset) do
    parse__7(rest, acc, stack, context, line, offset)
  end

  defp parse__7(rest, acc, stack, context, line, offset) do
    parse__9(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__9(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__9(rest, acc, stack, context, line, offset) do
    parse__8(rest, acc, stack, context, line, offset)
  end

  defp parse__10(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-31] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-30] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-29] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-28] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-27] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-26] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-25] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-24] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-23] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-22] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-21] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-20] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-19] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-18] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-17] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-16] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-15] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-14] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-13] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-12] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-11] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-10] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-9] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-8] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-7] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-6] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-5] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-4] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-3] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-2] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-1] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__10(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-9] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-8] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-7] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [-1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__10(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__10(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__10(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__10(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__10(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__10(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__10(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__10(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__10(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__11(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__10(rest, acc, stack, context, line, offset) do
    parse__8(rest, acc, stack, context, line, offset)
  end

  defp parse__11(<<x0, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    parse__8(rest, acc, stack, context, line, offset)
  end

  defp parse__11(rest, acc, stack, context, line, offset) do
    parse__12(rest, acc, stack, context, line, offset)
  end

  defp parse__8(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__13(rest, acc, stack, context, line, offset)
  end

  defp parse__12(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__9(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__13(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__14(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__14(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__15(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__3(rest, [], stack, context, line, offset)
  end

  defp parse__16(<<"BYMONTH", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ["BYMONTH"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__16(rest, acc, stack, context, line, offset) do
    parse__15(rest, acc, stack, context, line, offset)
  end

  defp parse__17(rest, acc, stack, context, line, offset) do
    parse__18(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__18(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__18(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__18(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__18(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__18(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__18(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__18(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__18(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__18(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__18(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__18(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__18(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__18(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__18(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__18(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__18(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__18(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__18(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__18(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__18(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__18(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__19(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__18(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__15(rest, acc, stack, context, line, offset)
  end

  defp parse__19(<<x0, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    [acc | stack] = stack
    parse__15(rest, acc, stack, context, line, offset)
  end

  defp parse__19(rest, acc, stack, context, line, offset) do
    parse__20(rest, acc, stack, context, line, offset)
  end

  defp parse__20(rest, acc, stack, context, line, offset) do
    parse__22(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__22(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__23(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__22(rest, acc, stack, context, line, offset) do
    parse__21(rest, acc, stack, context, line, offset)
  end

  defp parse__23(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__23(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__23(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__23(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__23(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__23(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__23(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__23(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__23(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__23(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__23(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__23(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__23(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__23(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__23(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__23(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__23(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__23(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__23(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__23(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__23(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__24(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__23(rest, acc, stack, context, line, offset) do
    parse__21(rest, acc, stack, context, line, offset)
  end

  defp parse__24(<<x0, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    parse__21(rest, acc, stack, context, line, offset)
  end

  defp parse__24(rest, acc, stack, context, line, offset) do
    parse__25(rest, acc, stack, context, line, offset)
  end

  defp parse__21(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__26(rest, acc, stack, context, line, offset)
  end

  defp parse__25(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__22(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__26(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__27(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__27(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__28(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__16(rest, [], stack, context, line, offset)
  end

  defp parse__29(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__30(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__29(rest, acc, stack, context, line, offset) do
    parse__28(rest, acc, stack, context, line, offset)
  end

  defp parse__30(rest, acc, stack, context, line, offset) do
    parse__31(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__31(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__28(rest, acc, stack, context, line, offset)
  end

  defp parse__32(rest, acc, stack, context, line, offset) do
    parse__34(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__34(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__35(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__34(rest, acc, stack, context, line, offset) do
    parse__33(rest, acc, stack, context, line, offset)
  end

  defp parse__35(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__36(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__35(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__36(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__35(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__36(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__35(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__36(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__35(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__36(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__35(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__36(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__35(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__36(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__35(rest, acc, stack, context, line, offset) do
    parse__33(rest, acc, stack, context, line, offset)
  end

  defp parse__33(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__37(rest, acc, stack, context, line, offset)
  end

  defp parse__36(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__34(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__37(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__38(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__38(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__39(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__29(rest, [], stack, context, line, offset)
  end

  defp parse__40(<<"BYHOUR", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__41(rest, ["BYHOUR"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__40(rest, acc, stack, context, line, offset) do
    parse__39(rest, acc, stack, context, line, offset)
  end

  defp parse__41(rest, acc, stack, context, line, offset) do
    parse__42(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__42(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__39(rest, acc, stack, context, line, offset)
  end

  defp parse__43(<<x0, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    [acc | stack] = stack
    parse__39(rest, acc, stack, context, line, offset)
  end

  defp parse__43(rest, acc, stack, context, line, offset) do
    parse__44(rest, acc, stack, context, line, offset)
  end

  defp parse__44(rest, acc, stack, context, line, offset) do
    parse__46(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__46(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__47(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__46(rest, acc, stack, context, line, offset) do
    parse__45(rest, acc, stack, context, line, offset)
  end

  defp parse__47(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__47(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__47(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__47(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__47(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__47(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__47(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__47(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__47(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__47(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__47(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__47(rest, acc, stack, context, line, offset) do
    parse__45(rest, acc, stack, context, line, offset)
  end

  defp parse__48(<<x0, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    parse__45(rest, acc, stack, context, line, offset)
  end

  defp parse__48(rest, acc, stack, context, line, offset) do
    parse__49(rest, acc, stack, context, line, offset)
  end

  defp parse__45(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__50(rest, acc, stack, context, line, offset)
  end

  defp parse__49(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__46(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__50(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__51(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__51(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__52(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__40(rest, [], stack, context, line, offset)
  end

  defp parse__53(<<"BYMINUTE", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ["BYMINUTE"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__53(rest, acc, stack, context, line, offset) do
    parse__52(rest, acc, stack, context, line, offset)
  end

  defp parse__54(rest, acc, stack, context, line, offset) do
    parse__55(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__55(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__55(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__55(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__55(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__55(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__55(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__55(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__55(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__55(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__55(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__55(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__55(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__52(rest, acc, stack, context, line, offset)
  end

  defp parse__56(<<x0, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    [acc | stack] = stack
    parse__52(rest, acc, stack, context, line, offset)
  end

  defp parse__56(rest, acc, stack, context, line, offset) do
    parse__57(rest, acc, stack, context, line, offset)
  end

  defp parse__57(rest, acc, stack, context, line, offset) do
    parse__59(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__59(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__60(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__59(rest, acc, stack, context, line, offset) do
    parse__58(rest, acc, stack, context, line, offset)
  end

  defp parse__60(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(rest, acc, stack, context, line, offset) do
    parse__58(rest, acc, stack, context, line, offset)
  end

  defp parse__61(<<x0, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    parse__58(rest, acc, stack, context, line, offset)
  end

  defp parse__61(rest, acc, stack, context, line, offset) do
    parse__62(rest, acc, stack, context, line, offset)
  end

  defp parse__58(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__63(rest, acc, stack, context, line, offset)
  end

  defp parse__62(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__59(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__63(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__64(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__64(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__65(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__53(rest, [], stack, context, line, offset)
  end

  defp parse__66(<<"BYSECOND", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__67(rest, ["BYSECOND"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__66(rest, acc, stack, context, line, offset) do
    parse__65(rest, acc, stack, context, line, offset)
  end

  defp parse__67(rest, acc, stack, context, line, offset) do
    parse__68(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__68(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__65(rest, acc, stack, context, line, offset)
  end

  defp parse__69(<<x0, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    [acc | stack] = stack
    parse__65(rest, acc, stack, context, line, offset)
  end

  defp parse__69(rest, acc, stack, context, line, offset) do
    parse__70(rest, acc, stack, context, line, offset)
  end

  defp parse__70(rest, acc, stack, context, line, offset) do
    parse__72(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__72(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__72(rest, acc, stack, context, line, offset) do
    parse__71(rest, acc, stack, context, line, offset)
  end

  defp parse__73(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__73(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__73(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__73(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__73(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__73(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__73(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__73(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__73(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__73(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__73(rest, acc, stack, context, line, offset) do
    parse__71(rest, acc, stack, context, line, offset)
  end

  defp parse__74(<<x0, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    parse__71(rest, acc, stack, context, line, offset)
  end

  defp parse__74(rest, acc, stack, context, line, offset) do
    parse__75(rest, acc, stack, context, line, offset)
  end

  defp parse__71(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__76(rest, acc, stack, context, line, offset)
  end

  defp parse__75(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__72(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__76(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__77(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__77(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__78(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__66(rest, [], stack, context, line, offset)
  end

  defp parse__79(<<"INTERVAL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ["INTERVAL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__79(rest, acc, stack, context, line, offset) do
    parse__78(rest, acc, stack, context, line, offset)
  end

  defp parse__80(rest, acc, stack, context, line, offset) do
    parse__81(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__81(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__82(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__81(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__78(rest, acc, stack, context, line, offset)
  end

  defp parse__82(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__84(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__82(rest, acc, stack, context, line, offset) do
    parse__83(rest, acc, stack, context, line, offset)
  end

  defp parse__84(rest, acc, stack, context, line, offset) do
    parse__82(rest, acc, stack, context, line, offset)
  end

  defp parse__83(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__85(
      rest,
      (
        [head | tail] = :lists.reverse(user_acc)
        [:lists.foldl(fn x, acc -> x - 48 + acc * 10 end, head, tail)]
      ) ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse__85(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__86(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__79(rest, [], stack, context, line, offset)
  end

  defp parse__87(<<"COUNT", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__88(rest, ["COUNT"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__87(rest, acc, stack, context, line, offset) do
    parse__86(rest, acc, stack, context, line, offset)
  end

  defp parse__88(rest, acc, stack, context, line, offset) do
    parse__89(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__89(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__90(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__89(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__86(rest, acc, stack, context, line, offset)
  end

  defp parse__90(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__92(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__90(rest, acc, stack, context, line, offset) do
    parse__91(rest, acc, stack, context, line, offset)
  end

  defp parse__92(rest, acc, stack, context, line, offset) do
    parse__90(rest, acc, stack, context, line, offset)
  end

  defp parse__91(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__93(
      rest,
      (
        [head | tail] = :lists.reverse(user_acc)
        [:lists.foldl(fn x, acc -> x - 48 + acc * 10 end, head, tail)]
      ) ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse__93(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__94(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__87(rest, [], stack, context, line, offset)
  end

  defp parse__95(<<"UNTIL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ["UNTIL"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__95(rest, acc, stack, context, line, offset) do
    parse__94(rest, acc, stack, context, line, offset)
  end

  defp parse__96(rest, acc, stack, context, line, offset) do
    parse__97(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__97(rest, acc, stack, context, line, offset) do
    parse__104(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__99(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__100(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__99(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__94(rest, acc, stack, context, line, offset)
  end

  defp parse__100(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__94(rest, acc, stack, context, line, offset)
  end

  defp parse__101(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__101(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__94(rest, acc, stack, context, line, offset)
  end

  defp parse__102(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__98(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__103(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__99(rest, [], stack, context, line, offset)
  end

  defp parse__104(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__105(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__104(rest, acc, stack, context, line, offset) do
    parse__103(rest, acc, stack, context, line, offset)
  end

  defp parse__105(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__105(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__105(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__105(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__105(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__105(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__105(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__105(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__105(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__105(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__105(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__105(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__105(rest, acc, stack, context, line, offset) do
    parse__103(rest, acc, stack, context, line, offset)
  end

  defp parse__106(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(rest, acc, stack, context, line, offset) do
    parse__103(rest, acc, stack, context, line, offset)
  end

  defp parse__107(<<"T", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__107(rest, acc, stack, context, line, offset) do
    parse__103(rest, acc, stack, context, line, offset)
  end

  defp parse__108(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__108(rest, acc, stack, context, line, offset) do
    parse__103(rest, acc, stack, context, line, offset)
  end

  defp parse__109(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__109(rest, acc, stack, context, line, offset) do
    parse__103(rest, acc, stack, context, line, offset)
  end

  defp parse__110(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__111(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__110(rest, acc, stack, context, line, offset) do
    parse__103(rest, acc, stack, context, line, offset)
  end

  defp parse__111(<<"Z", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ["Z"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__111(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__112(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__98(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__98(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__113(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__113(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__114(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__95(rest, [], stack, context, line, offset)
  end

  defp parse__115(<<"FREQ", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__116(rest, ["FREQ"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__115(rest, acc, stack, context, line, offset) do
    parse__114(rest, acc, stack, context, line, offset)
  end

  defp parse__116(<<"SECONDLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__117(rest, ["SECONDLY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__116(<<"MINUTELY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__117(rest, ["MINUTELY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__116(<<"HOURLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__117(rest, ["HOURLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__116(<<"DAILY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__117(rest, ["DAILY"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__116(<<"WEEKLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__117(rest, ["WEEKLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__116(<<"MONTHLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__117(rest, ["MONTHLY"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__116(<<"YEARLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__117(rest, ["YEARLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__116(rest, acc, stack, context, line, offset) do
    parse__114(rest, acc, stack, context, line, offset)
  end

  defp parse__117(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__2(rest, acc, stack, context, line, offset) do
    parse__119(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__119(<<";", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__120(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__119(rest, acc, stack, context, line, offset) do
    parse__118(rest, acc, stack, context, line, offset)
  end

  defp parse__120(rest, acc, stack, context, line, offset) do
    parse__234(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__122(
         <<"BYMONTHDAY", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__123(rest, ["BYMONTHDAY"] ++ acc, stack, context, comb__line, comb__offset + 11)
  end

  defp parse__122(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse__118(rest, acc, stack, context, line, offset)
  end

  defp parse__123(rest, acc, stack, context, line, offset) do
    parse__124(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__124(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-31] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-30] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-29] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-28] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-27] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-26] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-25] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-24] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-23] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-22] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-21] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-20] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-19] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-18] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-17] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-16] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-15] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-14] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-13] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-12] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-11] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-10] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-9] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-8] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-7] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-6] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-5] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-4] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-3] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-2] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-1] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-9] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-8] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-7] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [-1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__118(rest, acc, stack, context, line, offset)
  end

  defp parse__125(<<x0, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    [_, _, acc | stack] = stack
    parse__118(rest, acc, stack, context, line, offset)
  end

  defp parse__125(rest, acc, stack, context, line, offset) do
    parse__126(rest, acc, stack, context, line, offset)
  end

  defp parse__126(rest, acc, stack, context, line, offset) do
    parse__128(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__128(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(rest, acc, stack, context, line, offset) do
    parse__127(rest, acc, stack, context, line, offset)
  end

  defp parse__129(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-31] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-30] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-29] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-28] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-27] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-26] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-25] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-24] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-23] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-22] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-21] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-20] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-19] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-18] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-17] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-16] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-15] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-14] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-13] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-12] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-11] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-10] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-9] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-8] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-7] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-6] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-5] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-4] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-3] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-2] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-1] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-9] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-8] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-7] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [-1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(rest, acc, stack, context, line, offset) do
    parse__127(rest, acc, stack, context, line, offset)
  end

  defp parse__130(<<x0, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    parse__127(rest, acc, stack, context, line, offset)
  end

  defp parse__130(rest, acc, stack, context, line, offset) do
    parse__131(rest, acc, stack, context, line, offset)
  end

  defp parse__127(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__132(rest, acc, stack, context, line, offset)
  end

  defp parse__131(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__128(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__132(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__133(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__133(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__134(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__122(rest, [], stack, context, line, offset)
  end

  defp parse__135(<<"BYMONTH", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, ["BYMONTH"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__135(rest, acc, stack, context, line, offset) do
    parse__134(rest, acc, stack, context, line, offset)
  end

  defp parse__136(rest, acc, stack, context, line, offset) do
    parse__137(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__137(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__137(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__137(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__137(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__137(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__137(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__137(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__137(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__137(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__137(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__137(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__137(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__137(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__137(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__137(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__137(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__137(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__137(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__137(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__137(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__137(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__138(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__137(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__134(rest, acc, stack, context, line, offset)
  end

  defp parse__138(<<x0, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    [acc | stack] = stack
    parse__134(rest, acc, stack, context, line, offset)
  end

  defp parse__138(rest, acc, stack, context, line, offset) do
    parse__139(rest, acc, stack, context, line, offset)
  end

  defp parse__139(rest, acc, stack, context, line, offset) do
    parse__141(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__141(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__142(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__141(rest, acc, stack, context, line, offset) do
    parse__140(rest, acc, stack, context, line, offset)
  end

  defp parse__142(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__142(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__142(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__142(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__142(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__142(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__142(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__142(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__142(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__142(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__142(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__142(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__142(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__142(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__142(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__142(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__142(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__142(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__142(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__142(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__142(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__142(rest, acc, stack, context, line, offset) do
    parse__140(rest, acc, stack, context, line, offset)
  end

  defp parse__143(<<x0, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    parse__140(rest, acc, stack, context, line, offset)
  end

  defp parse__143(rest, acc, stack, context, line, offset) do
    parse__144(rest, acc, stack, context, line, offset)
  end

  defp parse__140(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__145(rest, acc, stack, context, line, offset)
  end

  defp parse__144(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__141(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__145(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__146(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__146(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__147(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__135(rest, [], stack, context, line, offset)
  end

  defp parse__148(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__148(rest, acc, stack, context, line, offset) do
    parse__147(rest, acc, stack, context, line, offset)
  end

  defp parse__149(rest, acc, stack, context, line, offset) do
    parse__150(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__150(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__151(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__150(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__151(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__150(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__151(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__150(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__151(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__150(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__151(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__150(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__151(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__150(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__151(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__150(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__147(rest, acc, stack, context, line, offset)
  end

  defp parse__151(rest, acc, stack, context, line, offset) do
    parse__153(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__153(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__154(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__153(rest, acc, stack, context, line, offset) do
    parse__152(rest, acc, stack, context, line, offset)
  end

  defp parse__154(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(rest, acc, stack, context, line, offset) do
    parse__152(rest, acc, stack, context, line, offset)
  end

  defp parse__152(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__156(rest, acc, stack, context, line, offset)
  end

  defp parse__155(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__153(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__156(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__157(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__157(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__158(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__148(rest, [], stack, context, line, offset)
  end

  defp parse__159(<<"BYHOUR", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, ["BYHOUR"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__159(rest, acc, stack, context, line, offset) do
    parse__158(rest, acc, stack, context, line, offset)
  end

  defp parse__160(rest, acc, stack, context, line, offset) do
    parse__161(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__161(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__161(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__161(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__161(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__161(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__161(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__161(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__161(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__161(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__161(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__161(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__158(rest, acc, stack, context, line, offset)
  end

  defp parse__162(<<x0, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    [acc | stack] = stack
    parse__158(rest, acc, stack, context, line, offset)
  end

  defp parse__162(rest, acc, stack, context, line, offset) do
    parse__163(rest, acc, stack, context, line, offset)
  end

  defp parse__163(rest, acc, stack, context, line, offset) do
    parse__165(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__165(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__165(rest, acc, stack, context, line, offset) do
    parse__164(rest, acc, stack, context, line, offset)
  end

  defp parse__166(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__166(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__166(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__166(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__166(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__166(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__166(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__166(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__166(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__166(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__166(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__166(rest, acc, stack, context, line, offset) do
    parse__164(rest, acc, stack, context, line, offset)
  end

  defp parse__167(<<x0, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    parse__164(rest, acc, stack, context, line, offset)
  end

  defp parse__167(rest, acc, stack, context, line, offset) do
    parse__168(rest, acc, stack, context, line, offset)
  end

  defp parse__164(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__169(rest, acc, stack, context, line, offset)
  end

  defp parse__168(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__165(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__169(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__170(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__170(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__171(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__159(rest, [], stack, context, line, offset)
  end

  defp parse__172(
         <<"BYMINUTE", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__173(rest, ["BYMINUTE"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__172(rest, acc, stack, context, line, offset) do
    parse__171(rest, acc, stack, context, line, offset)
  end

  defp parse__173(rest, acc, stack, context, line, offset) do
    parse__174(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__174(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__174(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__174(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__174(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__174(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__174(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__174(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__174(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__174(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__174(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__174(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__175(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__174(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__171(rest, acc, stack, context, line, offset)
  end

  defp parse__175(<<x0, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    [acc | stack] = stack
    parse__171(rest, acc, stack, context, line, offset)
  end

  defp parse__175(rest, acc, stack, context, line, offset) do
    parse__176(rest, acc, stack, context, line, offset)
  end

  defp parse__176(rest, acc, stack, context, line, offset) do
    parse__178(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__178(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__179(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__178(rest, acc, stack, context, line, offset) do
    parse__177(rest, acc, stack, context, line, offset)
  end

  defp parse__179(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(rest, acc, stack, context, line, offset) do
    parse__177(rest, acc, stack, context, line, offset)
  end

  defp parse__180(<<x0, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    parse__177(rest, acc, stack, context, line, offset)
  end

  defp parse__180(rest, acc, stack, context, line, offset) do
    parse__181(rest, acc, stack, context, line, offset)
  end

  defp parse__177(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__182(rest, acc, stack, context, line, offset)
  end

  defp parse__181(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__178(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__182(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__183(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__183(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__184(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__172(rest, [], stack, context, line, offset)
  end

  defp parse__185(
         <<"BYSECOND", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__186(rest, ["BYSECOND"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__185(rest, acc, stack, context, line, offset) do
    parse__184(rest, acc, stack, context, line, offset)
  end

  defp parse__186(rest, acc, stack, context, line, offset) do
    parse__187(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__187(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__187(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__187(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__187(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__187(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__187(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__187(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__187(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__187(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__187(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__187(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__184(rest, acc, stack, context, line, offset)
  end

  defp parse__188(<<x0, _::binary>> = rest, _acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    [acc | stack] = stack
    parse__184(rest, acc, stack, context, line, offset)
  end

  defp parse__188(rest, acc, stack, context, line, offset) do
    parse__189(rest, acc, stack, context, line, offset)
  end

  defp parse__189(rest, acc, stack, context, line, offset) do
    parse__191(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__191(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(rest, acc, stack, context, line, offset) do
    parse__190(rest, acc, stack, context, line, offset)
  end

  defp parse__192(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__192(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__192(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__192(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__192(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__192(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__192(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__192(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__192(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__192(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__192(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__193(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__192(rest, acc, stack, context, line, offset) do
    parse__190(rest, acc, stack, context, line, offset)
  end

  defp parse__193(<<x0, _::binary>> = rest, acc, stack, context, line, offset)
       when x0 >= 48 and x0 <= 57 do
    parse__190(rest, acc, stack, context, line, offset)
  end

  defp parse__193(rest, acc, stack, context, line, offset) do
    parse__194(rest, acc, stack, context, line, offset)
  end

  defp parse__190(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__195(rest, acc, stack, context, line, offset)
  end

  defp parse__194(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__191(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__195(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__196(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__196(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__197(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__185(rest, [], stack, context, line, offset)
  end

  defp parse__198(
         <<"INTERVAL", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__199(rest, ["INTERVAL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__198(rest, acc, stack, context, line, offset) do
    parse__197(rest, acc, stack, context, line, offset)
  end

  defp parse__199(rest, acc, stack, context, line, offset) do
    parse__200(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__200(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__201(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__200(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__197(rest, acc, stack, context, line, offset)
  end

  defp parse__201(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__203(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__201(rest, acc, stack, context, line, offset) do
    parse__202(rest, acc, stack, context, line, offset)
  end

  defp parse__203(rest, acc, stack, context, line, offset) do
    parse__201(rest, acc, stack, context, line, offset)
  end

  defp parse__202(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__204(
      rest,
      (
        [head | tail] = :lists.reverse(user_acc)
        [:lists.foldl(fn x, acc -> x - 48 + acc * 10 end, head, tail)]
      ) ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse__204(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__205(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__198(rest, [], stack, context, line, offset)
  end

  defp parse__206(<<"COUNT", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__207(rest, ["COUNT"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__206(rest, acc, stack, context, line, offset) do
    parse__205(rest, acc, stack, context, line, offset)
  end

  defp parse__207(rest, acc, stack, context, line, offset) do
    parse__208(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__208(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__209(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__208(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__205(rest, acc, stack, context, line, offset)
  end

  defp parse__209(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__211(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__209(rest, acc, stack, context, line, offset) do
    parse__210(rest, acc, stack, context, line, offset)
  end

  defp parse__211(rest, acc, stack, context, line, offset) do
    parse__209(rest, acc, stack, context, line, offset)
  end

  defp parse__210(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__212(
      rest,
      (
        [head | tail] = :lists.reverse(user_acc)
        [:lists.foldl(fn x, acc -> x - 48 + acc * 10 end, head, tail)]
      ) ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp parse__212(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__213(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__206(rest, [], stack, context, line, offset)
  end

  defp parse__214(<<"UNTIL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__215(rest, ["UNTIL"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__214(rest, acc, stack, context, line, offset) do
    parse__213(rest, acc, stack, context, line, offset)
  end

  defp parse__215(rest, acc, stack, context, line, offset) do
    parse__216(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__216(rest, acc, stack, context, line, offset) do
    parse__223(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__218(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__219(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__218(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__213(rest, acc, stack, context, line, offset)
  end

  defp parse__219(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__220(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__219(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__220(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__219(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__220(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__219(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__220(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__219(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__220(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__219(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__220(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__219(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__220(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__219(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__220(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__219(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__220(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__219(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__220(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__219(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__220(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__219(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__220(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__219(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__213(rest, acc, stack, context, line, offset)
  end

  defp parse__220(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__221(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__220(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__213(rest, acc, stack, context, line, offset)
  end

  defp parse__221(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__217(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__222(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__218(rest, [], stack, context, line, offset)
  end

  defp parse__223(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__224(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__223(rest, acc, stack, context, line, offset) do
    parse__222(rest, acc, stack, context, line, offset)
  end

  defp parse__224(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__225(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__224(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__225(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__224(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__225(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__224(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__225(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__224(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__225(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__224(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__225(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__224(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__225(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__224(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__225(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__224(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__225(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__224(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__225(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__224(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__225(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__224(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__225(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__224(rest, acc, stack, context, line, offset) do
    parse__222(rest, acc, stack, context, line, offset)
  end

  defp parse__225(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__226(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__225(rest, acc, stack, context, line, offset) do
    parse__222(rest, acc, stack, context, line, offset)
  end

  defp parse__226(<<"T", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__226(rest, acc, stack, context, line, offset) do
    parse__222(rest, acc, stack, context, line, offset)
  end

  defp parse__227(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(rest, acc, stack, context, line, offset) do
    parse__222(rest, acc, stack, context, line, offset)
  end

  defp parse__228(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__228(rest, acc, stack, context, line, offset) do
    parse__222(rest, acc, stack, context, line, offset)
  end

  defp parse__229(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(rest, acc, stack, context, line, offset) do
    parse__222(rest, acc, stack, context, line, offset)
  end

  defp parse__230(<<"Z", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ["Z"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__230(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__231(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__217(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__217(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__232(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__232(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__233(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__214(rest, [], stack, context, line, offset)
  end

  defp parse__234(<<"FREQ", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__235(rest, ["FREQ"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__234(rest, acc, stack, context, line, offset) do
    parse__233(rest, acc, stack, context, line, offset)
  end

  defp parse__235(<<"SECONDLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__236(rest, ["SECONDLY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__235(<<"MINUTELY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__236(rest, ["MINUTELY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__235(<<"HOURLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__236(rest, ["HOURLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__235(<<"DAILY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__236(rest, ["DAILY"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__235(<<"WEEKLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__236(rest, ["WEEKLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__235(<<"MONTHLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__236(rest, ["MONTHLY"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__235(<<"YEARLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__236(rest, ["YEARLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__235(rest, acc, stack, context, line, offset) do
    parse__233(rest, acc, stack, context, line, offset)
  end

  defp parse__236(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__118(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__237(rest, acc, stack, context, line, offset)
  end

  defp parse__121(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__119(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__237(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__238(rest, [to_map(:lists.reverse(user_acc))] ++ acc, stack, context, line, offset)
  end

  defp parse__238(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end

  defp to_map(args) do
    args
    |> Enum.chunk_every(2)
    |> Enum.into(%{}, fn [k, v] -> {word_to_atom(k), cast_value(k, v)} end)
  end

  defp word_to_atom(string) do
    string |> String.downcase() |> String.to_atom()
  end

  defp cast_value("FREQ", value), do: word_to_atom(value)

  defp cast_value("UNTIL", [year, month, day]) do
    {:ok, date} = Date.new(year, month, day)
    date
  end

  defp cast_value("UNTIL", [year, month, day, hour, minute, second]) do
    NaiveDateTime.new!(year, month, day, hour, minute, second)
  end

  defp cast_value("UNTIL", [year, month, day, hour, minute, second, "Z"]) do
    NaiveDateTime.new!(year, month, day, hour, minute, second)
    |> DateTime.from_naive!("Etc/UTC")
  end

  defp cast_value("BYDAY", days), do: Enum.map(days, &cast_byday/1)
  defp cast_value("BYMONTHDAY", days) when is_list(days), do: days
  defp cast_value("BYMONTHDAY", day), do: [day]

  defp cast_value("BYMONTH", months) when is_list(months), do: months
  defp cast_value("BYMONTH", month), do: [month]

  defp cast_value(_, value), do: value

  defp cast_byday("SU"), do: 7
  defp cast_byday("MO"), do: 1
  defp cast_byday("TU"), do: 2
  defp cast_byday("WE"), do: 3
  defp cast_byday("TH"), do: 4
  defp cast_byday("FR"), do: 5
  defp cast_byday("SA"), do: 6
end
