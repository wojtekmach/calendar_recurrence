# Generated from lib/calendar_recurrence/rrule_parser.ex.exs, do not edit.
# Generated at 2026-02-19 00:12:47Z.

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
    parse__135(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
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
     "expected string \"FREQ\", followed by string \"=\", followed by string \"SECONDLY\" or string \"MINUTELY\" or string \"HOURLY\" or string \"DAILY\" or string \"WEEKLY\" or string \"MONTHLY\" or string \"YEARLY\" or string \"UNTIL\", followed by string \"=\", followed by datetime or date or string \"COUNT\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"INTERVAL\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYSECOND\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYMINUTE\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYHOUR\", followed by string \"=\", followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYDAY\", followed by string \"=\", followed by string \"-\" or string \"+\" or nothing, followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"-\" or string \"+\" or nothing, followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"BYMONTH\", followed by string \"=\", followed by string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\" or string \"10\" or string \"11\" or string \"12\", followed by ,, followed by string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\" or string \"10\" or string \"11\" or string \"12\" or string \"BYMONTHDAY\", followed by string \"=\", followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\", followed by ,, followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\"",
     rest, context, line, offset}
  end

  defp parse__4(rest, acc, stack, context, line, offset) do
    parse__5(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__5(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-31"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-30"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-29"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-28"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-27"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-26"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-25"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-24"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-23"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-22"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-21"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-20"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-19"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-18"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-17"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-16"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-15"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-14"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-13"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-12"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-11"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-10"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__5(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-9"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-8"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-7"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-6"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-5"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-4"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-3"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-2"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["-1"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["31"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["30"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["29"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["28"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["27"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["26"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["25"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["24"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["23"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["22"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["21"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["20"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["19"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["18"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["17"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["16"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["15"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["14"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["13"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["12"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["11"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["10"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["9"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["8"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["7"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["6"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["5"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["4"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["3"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["2"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["1"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__5(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"FREQ\", followed by string \"=\", followed by string \"SECONDLY\" or string \"MINUTELY\" or string \"HOURLY\" or string \"DAILY\" or string \"WEEKLY\" or string \"MONTHLY\" or string \"YEARLY\" or string \"UNTIL\", followed by string \"=\", followed by datetime or date or string \"COUNT\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"INTERVAL\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYSECOND\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYMINUTE\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYHOUR\", followed by string \"=\", followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYDAY\", followed by string \"=\", followed by string \"-\" or string \"+\" or nothing, followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"-\" or string \"+\" or nothing, followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"BYMONTH\", followed by string \"=\", followed by string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\" or string \"10\" or string \"11\" or string \"12\", followed by ,, followed by string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\" or string \"10\" or string \"11\" or string \"12\" or string \"BYMONTHDAY\", followed by string \"=\", followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\", followed by ,, followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\"",
     rest, context, line, offset}
  end

  defp parse__6(rest, acc, stack, context, line, offset) do
    parse__8(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__8(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__9(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__8(rest, acc, stack, context, line, offset) do
    parse__7(rest, acc, stack, context, line, offset)
  end

  defp parse__9(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-31"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-30"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-29"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-28"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-27"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-26"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-25"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-24"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-23"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-22"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-21"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-20"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-19"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-18"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-17"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-16"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-15"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-14"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-13"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-12"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-11"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-10"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__9(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-9"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-8"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-7"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-6"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-5"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-4"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-3"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-2"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["-1"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["31"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["30"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["29"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["28"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["27"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["26"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["25"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["24"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["23"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["22"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["21"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["20"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["19"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["18"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["17"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["16"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["15"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["14"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["13"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["12"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["11"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["10"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["9"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__9(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["8"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__9(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["7"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__9(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["6"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__9(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["5"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__9(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["4"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__9(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["3"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__9(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["2"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__9(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["1"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__9(rest, acc, stack, context, line, offset) do
    parse__7(rest, acc, stack, context, line, offset)
  end

  defp parse__7(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__11(rest, acc, stack, context, line, offset)
  end

  defp parse__10(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__8(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__11(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__12(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__12(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__13(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__3(rest, [], stack, context, line, offset)
  end

  defp parse__14(<<"BYMONTH", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__15(rest, ["BYMONTH"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__14(rest, acc, stack, context, line, offset) do
    parse__13(rest, acc, stack, context, line, offset)
  end

  defp parse__15(rest, acc, stack, context, line, offset) do
    parse__16(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__16(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__13(rest, acc, stack, context, line, offset)
  end

  defp parse__17(rest, acc, stack, context, line, offset) do
    parse__19(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__19(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__20(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__19(rest, acc, stack, context, line, offset) do
    parse__18(rest, acc, stack, context, line, offset)
  end

  defp parse__20(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(rest, acc, stack, context, line, offset) do
    parse__18(rest, acc, stack, context, line, offset)
  end

  defp parse__18(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__22(rest, acc, stack, context, line, offset)
  end

  defp parse__21(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__19(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__22(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__23(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__23(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__24(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__14(rest, [], stack, context, line, offset)
  end

  defp parse__25(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__26(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__25(rest, acc, stack, context, line, offset) do
    parse__24(rest, acc, stack, context, line, offset)
  end

  defp parse__26(rest, acc, stack, context, line, offset) do
    parse__27(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__27(rest, acc, stack, context, line, offset) do
    parse__32(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__29(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__30(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__29(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__30(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__29(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__30(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__29(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__30(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__29(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__30(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__29(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__30(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__29(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__30(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__29(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__24(rest, acc, stack, context, line, offset)
  end

  defp parse__30(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__28(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__31(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__29(rest, [], stack, context, line, offset)
  end

  defp parse__32(rest, acc, stack, context, line, offset) do
    parse__33(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__33(<<"-", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__34(rest, ["-"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__33(<<"+", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__34(rest, ["+"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__33(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__34(rest, ["+"] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__33(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__31(rest, acc, stack, context, line, offset)
  end

  defp parse__34(rest, acc, stack, context, line, offset) do
    parse__35(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__35(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__36(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__35(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse__31(rest, acc, stack, context, line, offset)
  end

  defp parse__36(rest, acc, stack, context, line, offset) do
    parse__38(rest, acc, [1 | stack], context, line, offset)
  end

  defp parse__38(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__39(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(rest, acc, stack, context, line, offset) do
    parse__37(rest, acc, stack, context, line, offset)
  end

  defp parse__37(rest, acc, [_ | stack], context, line, offset) do
    parse__40(rest, acc, stack, context, line, offset)
  end

  defp parse__39(rest, acc, [1 | stack], context, line, offset) do
    parse__40(rest, acc, stack, context, line, offset)
  end

  defp parse__39(rest, acc, [count | stack], context, line, offset) do
    parse__38(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp parse__40(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__41(
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

  defp parse__41(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__42(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__41(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__42(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__41(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__42(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__41(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__42(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__41(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__42(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__41(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__42(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__41(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__42(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__41(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__31(rest, acc, stack, context, line, offset)
  end

  defp parse__42(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__43(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__43(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__28(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__28(rest, acc, stack, context, line, offset) do
    parse__45(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__45(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__46(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__45(rest, acc, stack, context, line, offset) do
    parse__44(rest, acc, stack, context, line, offset)
  end

  defp parse__46(rest, acc, stack, context, line, offset) do
    parse__51(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__48(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__49(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__48(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__49(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__48(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__49(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__48(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__49(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__48(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__49(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__48(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__49(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__48(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__49(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__48(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse__44(rest, acc, stack, context, line, offset)
  end

  defp parse__49(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__47(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__50(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__48(rest, [], stack, context, line, offset)
  end

  defp parse__51(rest, acc, stack, context, line, offset) do
    parse__52(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__52(<<"-", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__53(rest, ["-"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__52(<<"+", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__53(rest, ["+"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__52(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__53(rest, ["+"] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__52(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__50(rest, acc, stack, context, line, offset)
  end

  defp parse__53(rest, acc, stack, context, line, offset) do
    parse__54(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__54(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__55(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__54(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse__50(rest, acc, stack, context, line, offset)
  end

  defp parse__55(rest, acc, stack, context, line, offset) do
    parse__57(rest, acc, [1 | stack], context, line, offset)
  end

  defp parse__57(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__58(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__57(rest, acc, stack, context, line, offset) do
    parse__56(rest, acc, stack, context, line, offset)
  end

  defp parse__56(rest, acc, [_ | stack], context, line, offset) do
    parse__59(rest, acc, stack, context, line, offset)
  end

  defp parse__58(rest, acc, [1 | stack], context, line, offset) do
    parse__59(rest, acc, stack, context, line, offset)
  end

  defp parse__58(rest, acc, [count | stack], context, line, offset) do
    parse__57(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp parse__59(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__60(
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

  defp parse__60(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__50(rest, acc, stack, context, line, offset)
  end

  defp parse__61(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__62(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__62(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__47(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__44(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__63(rest, acc, stack, context, line, offset)
  end

  defp parse__47(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__45(
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
    parse__25(rest, [], stack, context, line, offset)
  end

  defp parse__66(<<"BYHOUR", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__67(rest, ["BYHOUR"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__66(rest, acc, stack, context, line, offset) do
    parse__65(rest, acc, stack, context, line, offset)
  end

  defp parse__67(rest, acc, stack, context, line, offset) do
    parse__68(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__68(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__68(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__65(rest, acc, stack, context, line, offset)
  end

  defp parse__69(rest, acc, stack, context, line, offset) do
    parse__71(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__71(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__71(rest, acc, stack, context, line, offset) do
    parse__70(rest, acc, stack, context, line, offset)
  end

  defp parse__72(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__72(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__72(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__72(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__72(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__72(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__72(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__72(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__72(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__72(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__72(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__73(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__72(rest, acc, stack, context, line, offset) do
    parse__70(rest, acc, stack, context, line, offset)
  end

  defp parse__70(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__74(rest, acc, stack, context, line, offset)
  end

  defp parse__73(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__71(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__74(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__75(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__75(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__76(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__66(rest, [], stack, context, line, offset)
  end

  defp parse__77(<<"BYMINUTE", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ["BYMINUTE"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__77(rest, acc, stack, context, line, offset) do
    parse__76(rest, acc, stack, context, line, offset)
  end

  defp parse__78(rest, acc, stack, context, line, offset) do
    parse__79(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__79(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__79(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__79(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__79(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__79(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__79(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__79(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__79(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__79(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__79(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__79(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__79(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__76(rest, acc, stack, context, line, offset)
  end

  defp parse__80(rest, acc, stack, context, line, offset) do
    parse__82(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__82(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__83(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__82(rest, acc, stack, context, line, offset) do
    parse__81(rest, acc, stack, context, line, offset)
  end

  defp parse__83(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__83(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__83(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__83(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__83(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__83(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__83(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__83(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__83(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__83(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__83(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__83(rest, acc, stack, context, line, offset) do
    parse__81(rest, acc, stack, context, line, offset)
  end

  defp parse__81(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__85(rest, acc, stack, context, line, offset)
  end

  defp parse__84(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__82(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__85(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__86(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__86(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__87(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__77(rest, [], stack, context, line, offset)
  end

  defp parse__88(<<"BYSECOND", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__89(rest, ["BYSECOND"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__88(rest, acc, stack, context, line, offset) do
    parse__87(rest, acc, stack, context, line, offset)
  end

  defp parse__89(rest, acc, stack, context, line, offset) do
    parse__90(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__90(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__90(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__90(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__90(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__90(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__90(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__90(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__90(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__90(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__90(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__90(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__87(rest, acc, stack, context, line, offset)
  end

  defp parse__91(rest, acc, stack, context, line, offset) do
    parse__93(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__93(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__94(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__93(rest, acc, stack, context, line, offset) do
    parse__92(rest, acc, stack, context, line, offset)
  end

  defp parse__94(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__94(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__94(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__94(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__94(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__94(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__94(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__94(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__94(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__94(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__94(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__94(rest, acc, stack, context, line, offset) do
    parse__92(rest, acc, stack, context, line, offset)
  end

  defp parse__92(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__96(rest, acc, stack, context, line, offset)
  end

  defp parse__95(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__93(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__96(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__97(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__97(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__98(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__88(rest, [], stack, context, line, offset)
  end

  defp parse__99(<<"INTERVAL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ["INTERVAL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__99(rest, acc, stack, context, line, offset) do
    parse__98(rest, acc, stack, context, line, offset)
  end

  defp parse__100(rest, acc, stack, context, line, offset) do
    parse__101(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__101(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__102(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__101(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__98(rest, acc, stack, context, line, offset)
  end

  defp parse__102(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__104(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__102(rest, acc, stack, context, line, offset) do
    parse__103(rest, acc, stack, context, line, offset)
  end

  defp parse__104(rest, acc, stack, context, line, offset) do
    parse__102(rest, acc, stack, context, line, offset)
  end

  defp parse__103(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__105(
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

  defp parse__105(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__106(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__99(rest, [], stack, context, line, offset)
  end

  defp parse__107(<<"COUNT", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ["COUNT"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__107(rest, acc, stack, context, line, offset) do
    parse__106(rest, acc, stack, context, line, offset)
  end

  defp parse__108(rest, acc, stack, context, line, offset) do
    parse__109(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__109(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__110(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__109(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__106(rest, acc, stack, context, line, offset)
  end

  defp parse__110(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__112(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__110(rest, acc, stack, context, line, offset) do
    parse__111(rest, acc, stack, context, line, offset)
  end

  defp parse__112(rest, acc, stack, context, line, offset) do
    parse__110(rest, acc, stack, context, line, offset)
  end

  defp parse__111(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__113(
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

  defp parse__113(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__114(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__107(rest, [], stack, context, line, offset)
  end

  defp parse__115(<<"UNTIL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__116(rest, ["UNTIL"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__115(rest, acc, stack, context, line, offset) do
    parse__114(rest, acc, stack, context, line, offset)
  end

  defp parse__116(rest, acc, stack, context, line, offset) do
    parse__117(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__117(rest, acc, stack, context, line, offset) do
    parse__124(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__119(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__120(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__119(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__114(rest, acc, stack, context, line, offset)
  end

  defp parse__120(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__120(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__120(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__120(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__120(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__120(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__120(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__120(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__120(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__120(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__120(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__120(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__120(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__114(rest, acc, stack, context, line, offset)
  end

  defp parse__121(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__122(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__121(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__114(rest, acc, stack, context, line, offset)
  end

  defp parse__122(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__118(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__123(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__119(rest, [], stack, context, line, offset)
  end

  defp parse__124(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__125(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__124(rest, acc, stack, context, line, offset) do
    parse__123(rest, acc, stack, context, line, offset)
  end

  defp parse__125(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(rest, acc, stack, context, line, offset) do
    parse__123(rest, acc, stack, context, line, offset)
  end

  defp parse__126(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__127(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__126(rest, acc, stack, context, line, offset) do
    parse__123(rest, acc, stack, context, line, offset)
  end

  defp parse__127(<<"T", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__128(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__127(rest, acc, stack, context, line, offset) do
    parse__123(rest, acc, stack, context, line, offset)
  end

  defp parse__128(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(rest, acc, stack, context, line, offset) do
    parse__123(rest, acc, stack, context, line, offset)
  end

  defp parse__129(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__129(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(rest, acc, stack, context, line, offset) do
    parse__123(rest, acc, stack, context, line, offset)
  end

  defp parse__130(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__131(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__130(rest, acc, stack, context, line, offset) do
    parse__123(rest, acc, stack, context, line, offset)
  end

  defp parse__131(<<"Z", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__132(rest, ["Z"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__131(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__132(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__132(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__118(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__118(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__133(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__133(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__134(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__115(rest, [], stack, context, line, offset)
  end

  defp parse__135(<<"FREQ", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, ["FREQ"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__135(rest, acc, stack, context, line, offset) do
    parse__134(rest, acc, stack, context, line, offset)
  end

  defp parse__136(<<"SECONDLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["SECONDLY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__136(<<"MINUTELY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["MINUTELY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__136(<<"HOURLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["HOURLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__136(<<"DAILY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["DAILY"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__136(<<"WEEKLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["WEEKLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__136(<<"MONTHLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["MONTHLY"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__136(<<"YEARLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["YEARLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__136(rest, acc, stack, context, line, offset) do
    parse__134(rest, acc, stack, context, line, offset)
  end

  defp parse__137(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__2(rest, acc, stack, context, line, offset) do
    parse__139(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__139(<<";", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__139(rest, acc, stack, context, line, offset) do
    parse__138(rest, acc, stack, context, line, offset)
  end

  defp parse__140(rest, acc, stack, context, line, offset) do
    parse__274(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__142(
         <<"BYMONTHDAY", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__143(rest, ["BYMONTHDAY"] ++ acc, stack, context, comb__line, comb__offset + 11)
  end

  defp parse__142(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse__138(rest, acc, stack, context, line, offset)
  end

  defp parse__143(rest, acc, stack, context, line, offset) do
    parse__144(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__144(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-31"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-30"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-29"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-28"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-27"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-26"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-25"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-24"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-23"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-22"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-21"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-20"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-19"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-18"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-17"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-16"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-15"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-14"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-13"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-12"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-11"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-10"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__144(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-9"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-8"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-7"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-6"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-5"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-4"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-3"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-2"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["-1"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["31"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["30"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["29"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["28"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["27"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["26"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["25"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["24"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["23"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["22"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["21"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["20"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["19"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["18"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["17"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["16"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["15"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["14"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["13"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["12"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["11"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["10"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__144(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["9"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__144(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["8"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__144(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["7"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__144(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["6"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__144(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["5"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__144(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["4"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__144(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["3"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__144(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["2"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__144(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["1"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__144(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__138(rest, acc, stack, context, line, offset)
  end

  defp parse__145(rest, acc, stack, context, line, offset) do
    parse__147(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__147(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__147(rest, acc, stack, context, line, offset) do
    parse__146(rest, acc, stack, context, line, offset)
  end

  defp parse__148(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-31"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-30"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-29"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-28"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-27"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-26"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-25"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-24"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-23"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-22"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-21"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-20"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-19"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-18"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-17"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-16"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-15"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-14"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-13"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-12"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-11"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-10"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__148(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-9"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-8"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-7"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-6"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-5"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-4"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-3"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-2"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["-1"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["31"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["30"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["29"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["28"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["27"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["26"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["25"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["24"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["23"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["22"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["21"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["20"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["19"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["18"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["17"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["16"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["15"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["14"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["13"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["12"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["11"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["10"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__148(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["9"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__148(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["8"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__148(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["7"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__148(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["6"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__148(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["5"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__148(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["4"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__148(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["3"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__148(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["2"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__148(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__149(rest, ["1"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__148(rest, acc, stack, context, line, offset) do
    parse__146(rest, acc, stack, context, line, offset)
  end

  defp parse__146(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__150(rest, acc, stack, context, line, offset)
  end

  defp parse__149(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__147(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__150(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__151(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__151(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__141(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__152(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__142(rest, [], stack, context, line, offset)
  end

  defp parse__153(<<"BYMONTH", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__154(rest, ["BYMONTH"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__153(rest, acc, stack, context, line, offset) do
    parse__152(rest, acc, stack, context, line, offset)
  end

  defp parse__154(rest, acc, stack, context, line, offset) do
    parse__155(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__155(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__155(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__155(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__155(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__155(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__155(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__155(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__155(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__155(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__155(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__152(rest, acc, stack, context, line, offset)
  end

  defp parse__156(rest, acc, stack, context, line, offset) do
    parse__158(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__158(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__158(rest, acc, stack, context, line, offset) do
    parse__157(rest, acc, stack, context, line, offset)
  end

  defp parse__159(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__159(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__159(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__159(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__159(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__159(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__159(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__159(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__159(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__159(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(rest, acc, stack, context, line, offset) do
    parse__157(rest, acc, stack, context, line, offset)
  end

  defp parse__157(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__161(rest, acc, stack, context, line, offset)
  end

  defp parse__160(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__158(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__161(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__162(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__162(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__141(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__163(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__153(rest, [], stack, context, line, offset)
  end

  defp parse__164(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__164(rest, acc, stack, context, line, offset) do
    parse__163(rest, acc, stack, context, line, offset)
  end

  defp parse__165(rest, acc, stack, context, line, offset) do
    parse__166(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__166(rest, acc, stack, context, line, offset) do
    parse__171(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__168(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__163(rest, acc, stack, context, line, offset)
  end

  defp parse__169(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__167(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__170(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__168(rest, [], stack, context, line, offset)
  end

  defp parse__171(rest, acc, stack, context, line, offset) do
    parse__172(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__172(<<"-", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, ["-"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(<<"+", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, ["+"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, ["+"] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__172(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__170(rest, acc, stack, context, line, offset)
  end

  defp parse__173(rest, acc, stack, context, line, offset) do
    parse__174(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__174(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__175(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__174(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse__170(rest, acc, stack, context, line, offset)
  end

  defp parse__175(rest, acc, stack, context, line, offset) do
    parse__177(rest, acc, [1 | stack], context, line, offset)
  end

  defp parse__177(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__178(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__177(rest, acc, stack, context, line, offset) do
    parse__176(rest, acc, stack, context, line, offset)
  end

  defp parse__176(rest, acc, [_ | stack], context, line, offset) do
    parse__179(rest, acc, stack, context, line, offset)
  end

  defp parse__178(rest, acc, [1 | stack], context, line, offset) do
    parse__179(rest, acc, stack, context, line, offset)
  end

  defp parse__178(rest, acc, [count | stack], context, line, offset) do
    parse__177(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp parse__179(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__180(
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

  defp parse__180(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__170(rest, acc, stack, context, line, offset)
  end

  defp parse__181(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__182(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__182(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__167(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__167(rest, acc, stack, context, line, offset) do
    parse__184(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__184(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__184(rest, acc, stack, context, line, offset) do
    parse__183(rest, acc, stack, context, line, offset)
  end

  defp parse__185(rest, acc, stack, context, line, offset) do
    parse__190(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__187(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__188(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__187(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse__183(rest, acc, stack, context, line, offset)
  end

  defp parse__188(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__186(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__189(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__187(rest, [], stack, context, line, offset)
  end

  defp parse__190(rest, acc, stack, context, line, offset) do
    parse__191(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__191(<<"-", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ["-"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(<<"+", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ["+"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ["+"] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__191(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__189(rest, acc, stack, context, line, offset)
  end

  defp parse__192(rest, acc, stack, context, line, offset) do
    parse__193(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__193(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__194(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__193(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse__189(rest, acc, stack, context, line, offset)
  end

  defp parse__194(rest, acc, stack, context, line, offset) do
    parse__196(rest, acc, [1 | stack], context, line, offset)
  end

  defp parse__196(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__197(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__196(rest, acc, stack, context, line, offset) do
    parse__195(rest, acc, stack, context, line, offset)
  end

  defp parse__195(rest, acc, [_ | stack], context, line, offset) do
    parse__198(rest, acc, stack, context, line, offset)
  end

  defp parse__197(rest, acc, [1 | stack], context, line, offset) do
    parse__198(rest, acc, stack, context, line, offset)
  end

  defp parse__197(rest, acc, [count | stack], context, line, offset) do
    parse__196(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp parse__198(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__199(
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

  defp parse__199(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__189(rest, acc, stack, context, line, offset)
  end

  defp parse__200(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__201(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__201(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__186(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__183(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__202(rest, acc, stack, context, line, offset)
  end

  defp parse__186(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__184(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__202(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__203(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__203(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__141(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__204(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__164(rest, [], stack, context, line, offset)
  end

  defp parse__205(<<"BYHOUR", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, ["BYHOUR"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__205(rest, acc, stack, context, line, offset) do
    parse__204(rest, acc, stack, context, line, offset)
  end

  defp parse__206(rest, acc, stack, context, line, offset) do
    parse__207(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__207(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__207(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__207(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__207(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__207(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__207(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__207(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__207(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__207(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__207(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__207(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__204(rest, acc, stack, context, line, offset)
  end

  defp parse__208(rest, acc, stack, context, line, offset) do
    parse__210(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__210(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__211(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__210(rest, acc, stack, context, line, offset) do
    parse__209(rest, acc, stack, context, line, offset)
  end

  defp parse__211(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__211(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__211(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__211(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__211(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__211(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__211(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__211(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__211(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__211(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__211(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__212(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__211(rest, acc, stack, context, line, offset) do
    parse__209(rest, acc, stack, context, line, offset)
  end

  defp parse__209(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__213(rest, acc, stack, context, line, offset)
  end

  defp parse__212(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__210(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__213(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__214(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__214(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__141(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__215(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__205(rest, [], stack, context, line, offset)
  end

  defp parse__216(
         <<"BYMINUTE", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__217(rest, ["BYMINUTE"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__216(rest, acc, stack, context, line, offset) do
    parse__215(rest, acc, stack, context, line, offset)
  end

  defp parse__217(rest, acc, stack, context, line, offset) do
    parse__218(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__218(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__218(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__218(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__218(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__218(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__218(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__218(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__218(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__218(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__218(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__218(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__219(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__218(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__215(rest, acc, stack, context, line, offset)
  end

  defp parse__219(rest, acc, stack, context, line, offset) do
    parse__221(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__221(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__221(rest, acc, stack, context, line, offset) do
    parse__220(rest, acc, stack, context, line, offset)
  end

  defp parse__222(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__222(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__222(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__222(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__222(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__222(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__222(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__222(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__222(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__222(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__222(rest, acc, stack, context, line, offset) do
    parse__220(rest, acc, stack, context, line, offset)
  end

  defp parse__220(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__224(rest, acc, stack, context, line, offset)
  end

  defp parse__223(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__221(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__224(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__225(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__225(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__141(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__226(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__216(rest, [], stack, context, line, offset)
  end

  defp parse__227(
         <<"BYSECOND", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__228(rest, ["BYSECOND"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__227(rest, acc, stack, context, line, offset) do
    parse__226(rest, acc, stack, context, line, offset)
  end

  defp parse__228(rest, acc, stack, context, line, offset) do
    parse__229(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__229(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__229(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__229(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__229(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__229(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__229(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__229(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__229(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__229(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__229(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__229(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__230(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__229(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__226(rest, acc, stack, context, line, offset)
  end

  defp parse__230(rest, acc, stack, context, line, offset) do
    parse__232(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__232(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__233(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__232(rest, acc, stack, context, line, offset) do
    parse__231(rest, acc, stack, context, line, offset)
  end

  defp parse__233(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__233(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__233(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__233(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__233(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__233(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__233(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__233(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__233(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__233(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__233(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__234(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__233(rest, acc, stack, context, line, offset) do
    parse__231(rest, acc, stack, context, line, offset)
  end

  defp parse__231(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__235(rest, acc, stack, context, line, offset)
  end

  defp parse__234(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__232(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__235(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__236(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__236(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__141(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__237(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__227(rest, [], stack, context, line, offset)
  end

  defp parse__238(
         <<"INTERVAL", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__239(rest, ["INTERVAL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__238(rest, acc, stack, context, line, offset) do
    parse__237(rest, acc, stack, context, line, offset)
  end

  defp parse__239(rest, acc, stack, context, line, offset) do
    parse__240(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__240(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__241(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__240(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__237(rest, acc, stack, context, line, offset)
  end

  defp parse__241(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__243(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__241(rest, acc, stack, context, line, offset) do
    parse__242(rest, acc, stack, context, line, offset)
  end

  defp parse__243(rest, acc, stack, context, line, offset) do
    parse__241(rest, acc, stack, context, line, offset)
  end

  defp parse__242(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__244(
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

  defp parse__244(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__141(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__245(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__238(rest, [], stack, context, line, offset)
  end

  defp parse__246(<<"COUNT", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__247(rest, ["COUNT"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__246(rest, acc, stack, context, line, offset) do
    parse__245(rest, acc, stack, context, line, offset)
  end

  defp parse__247(rest, acc, stack, context, line, offset) do
    parse__248(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__248(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__249(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__248(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__245(rest, acc, stack, context, line, offset)
  end

  defp parse__249(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__251(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__249(rest, acc, stack, context, line, offset) do
    parse__250(rest, acc, stack, context, line, offset)
  end

  defp parse__251(rest, acc, stack, context, line, offset) do
    parse__249(rest, acc, stack, context, line, offset)
  end

  defp parse__250(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__252(
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

  defp parse__252(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__141(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__253(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__246(rest, [], stack, context, line, offset)
  end

  defp parse__254(<<"UNTIL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__255(rest, ["UNTIL"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__254(rest, acc, stack, context, line, offset) do
    parse__253(rest, acc, stack, context, line, offset)
  end

  defp parse__255(rest, acc, stack, context, line, offset) do
    parse__256(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__256(rest, acc, stack, context, line, offset) do
    parse__263(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__258(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__259(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__258(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__253(rest, acc, stack, context, line, offset)
  end

  defp parse__259(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__260(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__259(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__260(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__259(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__260(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__259(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__260(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__259(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__260(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__259(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__260(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__259(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__260(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__259(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__260(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__259(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__260(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__259(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__260(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__259(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__260(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__259(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__260(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__259(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__253(rest, acc, stack, context, line, offset)
  end

  defp parse__260(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__261(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__260(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__253(rest, acc, stack, context, line, offset)
  end

  defp parse__261(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__257(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__262(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__258(rest, [], stack, context, line, offset)
  end

  defp parse__263(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__264(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__263(rest, acc, stack, context, line, offset) do
    parse__262(rest, acc, stack, context, line, offset)
  end

  defp parse__264(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__265(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__264(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__265(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__264(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__265(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__264(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__265(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__264(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__265(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__264(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__265(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__264(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__265(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__264(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__265(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__264(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__265(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__264(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__265(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__264(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__265(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__264(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__265(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__264(rest, acc, stack, context, line, offset) do
    parse__262(rest, acc, stack, context, line, offset)
  end

  defp parse__265(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__266(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__265(rest, acc, stack, context, line, offset) do
    parse__262(rest, acc, stack, context, line, offset)
  end

  defp parse__266(<<"T", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__267(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__266(rest, acc, stack, context, line, offset) do
    parse__262(rest, acc, stack, context, line, offset)
  end

  defp parse__267(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__268(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__267(rest, acc, stack, context, line, offset) do
    parse__262(rest, acc, stack, context, line, offset)
  end

  defp parse__268(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__269(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__268(rest, acc, stack, context, line, offset) do
    parse__262(rest, acc, stack, context, line, offset)
  end

  defp parse__269(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__270(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__269(rest, acc, stack, context, line, offset) do
    parse__262(rest, acc, stack, context, line, offset)
  end

  defp parse__270(<<"Z", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__271(rest, ["Z"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__270(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__271(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__271(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__257(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__257(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__272(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__272(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__141(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__273(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__254(rest, [], stack, context, line, offset)
  end

  defp parse__274(<<"FREQ", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__275(rest, ["FREQ"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__274(rest, acc, stack, context, line, offset) do
    parse__273(rest, acc, stack, context, line, offset)
  end

  defp parse__275(<<"SECONDLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__276(rest, ["SECONDLY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__275(<<"MINUTELY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__276(rest, ["MINUTELY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__275(<<"HOURLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__276(rest, ["HOURLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__275(<<"DAILY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__276(rest, ["DAILY"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__275(<<"WEEKLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__276(rest, ["WEEKLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__275(<<"MONTHLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__276(rest, ["MONTHLY"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__275(<<"YEARLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__276(rest, ["YEARLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__275(rest, acc, stack, context, line, offset) do
    parse__273(rest, acc, stack, context, line, offset)
  end

  defp parse__276(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__141(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__138(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__277(rest, acc, stack, context, line, offset)
  end

  defp parse__141(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__139(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__277(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__278(rest, [to_map(:lists.reverse(user_acc))] ++ acc, stack, context, line, offset)
  end

  defp parse__278(rest, acc, _stack, context, line, offset) do
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
  defp cast_value("BYMONTHDAY", days) when is_list(days), do: Enum.map(days, &String.to_integer/1)
  defp cast_value("BYMONTHDAY", day), do: [String.to_integer(day)]

  defp cast_value("BYMONTH", months) when is_list(months), do: months
  defp cast_value("BYMONTH", month), do: [month]

  defp cast_value(_, value), do: value

  defp cast_byday(["+", n, day]), do: {n, cast_byday(day)}
  defp cast_byday(["-", n, day]), do: {-n, cast_byday(day)}
  defp cast_byday("SU"), do: 7
  defp cast_byday("MO"), do: 1
  defp cast_byday("TU"), do: 2
  defp cast_byday("WE"), do: 3
  defp cast_byday("TH"), do: 4
  defp cast_byday("FR"), do: 5
  defp cast_byday("SA"), do: 6
end
