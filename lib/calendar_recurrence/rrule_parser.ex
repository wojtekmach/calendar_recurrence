# Generated from lib/calendar_recurrence/rrule_parser.ex.exs, do not edit.
# Generated at 2026-10-28 22:12:25Z.

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
    parse__105(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
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
     "expected string \"FREQ\", followed by string \"=\", followed by string \"SECONDLY\" or string \"MINUTELY\" or string \"HOURLY\" or string \"DAILY\" or string \"WEEKLY\" or string \"MONTHLY\" or string \"YEARLY\" or string \"UNTIL\", followed by string \"=\", followed by datetime or date or string \"COUNT\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"INTERVAL\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYSECOND\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYMINUTE\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYHOUR\", followed by string \"=\", followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYDAY\", followed by string \"=\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"BYMONTH\", followed by string \"=\", followed by string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\" or string \"10\" or string \"11\" or string \"12\", followed by ,, followed by string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\" or string \"10\" or string \"11\" or string \"12\" or string \"BYMONTHDAY\", followed by string \"=\", followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\", followed by ,, followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\"",
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
     "expected string \"FREQ\", followed by string \"=\", followed by string \"SECONDLY\" or string \"MINUTELY\" or string \"HOURLY\" or string \"DAILY\" or string \"WEEKLY\" or string \"MONTHLY\" or string \"YEARLY\" or string \"UNTIL\", followed by string \"=\", followed by datetime or date or string \"COUNT\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"INTERVAL\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYSECOND\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYMINUTE\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYHOUR\", followed by string \"=\", followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYDAY\", followed by string \"=\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"BYMONTH\", followed by string \"=\", followed by string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\" or string \"10\" or string \"11\" or string \"12\", followed by ,, followed by string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\" or string \"10\" or string \"11\" or string \"12\" or string \"BYMONTHDAY\", followed by string \"=\", followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\", followed by ,, followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\"",
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

  defp parse__27(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__24(rest, acc, stack, context, line, offset)
  end

  defp parse__28(rest, acc, stack, context, line, offset) do
    parse__30(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__30(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__31(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__30(rest, acc, stack, context, line, offset) do
    parse__29(rest, acc, stack, context, line, offset)
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

  defp parse__31(rest, acc, stack, context, line, offset) do
    parse__29(rest, acc, stack, context, line, offset)
  end

  defp parse__29(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__33(rest, acc, stack, context, line, offset)
  end

  defp parse__32(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__30(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__33(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__34(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__34(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__35(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__25(rest, [], stack, context, line, offset)
  end

  defp parse__36(<<"BYHOUR", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__37(rest, ["BYHOUR"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__36(rest, acc, stack, context, line, offset) do
    parse__35(rest, acc, stack, context, line, offset)
  end

  defp parse__37(rest, acc, stack, context, line, offset) do
    parse__38(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__38(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__35(rest, acc, stack, context, line, offset)
  end

  defp parse__39(rest, acc, stack, context, line, offset) do
    parse__41(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__41(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__42(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__41(rest, acc, stack, context, line, offset) do
    parse__40(rest, acc, stack, context, line, offset)
  end

  defp parse__42(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(rest, acc, stack, context, line, offset) do
    parse__40(rest, acc, stack, context, line, offset)
  end

  defp parse__40(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__44(rest, acc, stack, context, line, offset)
  end

  defp parse__43(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__41(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__44(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__45(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__45(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__46(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__36(rest, [], stack, context, line, offset)
  end

  defp parse__47(<<"BYMINUTE", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ["BYMINUTE"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__47(rest, acc, stack, context, line, offset) do
    parse__46(rest, acc, stack, context, line, offset)
  end

  defp parse__48(rest, acc, stack, context, line, offset) do
    parse__49(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__49(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__49(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__49(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__49(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__49(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__49(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__49(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__49(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__49(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__49(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__49(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__50(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__49(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__46(rest, acc, stack, context, line, offset)
  end

  defp parse__50(rest, acc, stack, context, line, offset) do
    parse__52(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__52(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__53(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__52(rest, acc, stack, context, line, offset) do
    parse__51(rest, acc, stack, context, line, offset)
  end

  defp parse__53(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__53(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__53(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__53(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__53(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__53(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__53(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__53(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__53(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__53(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__53(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__54(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__53(rest, acc, stack, context, line, offset) do
    parse__51(rest, acc, stack, context, line, offset)
  end

  defp parse__51(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__55(rest, acc, stack, context, line, offset)
  end

  defp parse__54(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__52(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__55(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__56(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__56(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__57(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__47(rest, [], stack, context, line, offset)
  end

  defp parse__58(<<"BYSECOND", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__59(rest, ["BYSECOND"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__58(rest, acc, stack, context, line, offset) do
    parse__57(rest, acc, stack, context, line, offset)
  end

  defp parse__59(rest, acc, stack, context, line, offset) do
    parse__60(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__60(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__60(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__61(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__60(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__57(rest, acc, stack, context, line, offset)
  end

  defp parse__61(rest, acc, stack, context, line, offset) do
    parse__63(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__63(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__64(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__63(rest, acc, stack, context, line, offset) do
    parse__62(rest, acc, stack, context, line, offset)
  end

  defp parse__64(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__64(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__64(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__64(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__64(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__64(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__64(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__64(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__64(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__64(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__64(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__65(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__64(rest, acc, stack, context, line, offset) do
    parse__62(rest, acc, stack, context, line, offset)
  end

  defp parse__62(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__66(rest, acc, stack, context, line, offset)
  end

  defp parse__65(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__63(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__66(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__67(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__67(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__68(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__58(rest, [], stack, context, line, offset)
  end

  defp parse__69(<<"INTERVAL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, ["INTERVAL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__69(rest, acc, stack, context, line, offset) do
    parse__68(rest, acc, stack, context, line, offset)
  end

  defp parse__70(rest, acc, stack, context, line, offset) do
    parse__71(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__71(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__72(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__71(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__68(rest, acc, stack, context, line, offset)
  end

  defp parse__72(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__74(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__72(rest, acc, stack, context, line, offset) do
    parse__73(rest, acc, stack, context, line, offset)
  end

  defp parse__74(rest, acc, stack, context, line, offset) do
    parse__72(rest, acc, stack, context, line, offset)
  end

  defp parse__73(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__75(
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

  defp parse__75(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__76(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__69(rest, [], stack, context, line, offset)
  end

  defp parse__77(<<"COUNT", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ["COUNT"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__77(rest, acc, stack, context, line, offset) do
    parse__76(rest, acc, stack, context, line, offset)
  end

  defp parse__78(rest, acc, stack, context, line, offset) do
    parse__79(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__79(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__80(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__79(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__76(rest, acc, stack, context, line, offset)
  end

  defp parse__80(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__82(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__80(rest, acc, stack, context, line, offset) do
    parse__81(rest, acc, stack, context, line, offset)
  end

  defp parse__82(rest, acc, stack, context, line, offset) do
    parse__80(rest, acc, stack, context, line, offset)
  end

  defp parse__81(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__83(
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

  defp parse__83(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__84(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__77(rest, [], stack, context, line, offset)
  end

  defp parse__85(<<"UNTIL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__86(rest, ["UNTIL"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__85(rest, acc, stack, context, line, offset) do
    parse__84(rest, acc, stack, context, line, offset)
  end

  defp parse__86(rest, acc, stack, context, line, offset) do
    parse__87(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__87(rest, acc, stack, context, line, offset) do
    parse__94(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__89(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__90(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__89(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__84(rest, acc, stack, context, line, offset)
  end

  defp parse__90(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__90(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__84(rest, acc, stack, context, line, offset)
  end

  defp parse__91(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__84(rest, acc, stack, context, line, offset)
  end

  defp parse__92(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__88(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__93(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__89(rest, [], stack, context, line, offset)
  end

  defp parse__94(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__95(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__94(rest, acc, stack, context, line, offset) do
    parse__93(rest, acc, stack, context, line, offset)
  end

  defp parse__95(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(rest, acc, stack, context, line, offset) do
    parse__93(rest, acc, stack, context, line, offset)
  end

  defp parse__96(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(rest, acc, stack, context, line, offset) do
    parse__93(rest, acc, stack, context, line, offset)
  end

  defp parse__97(<<"T", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__98(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__97(rest, acc, stack, context, line, offset) do
    parse__93(rest, acc, stack, context, line, offset)
  end

  defp parse__98(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__99(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__98(rest, acc, stack, context, line, offset) do
    parse__93(rest, acc, stack, context, line, offset)
  end

  defp parse__99(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__100(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__99(rest, acc, stack, context, line, offset) do
    parse__93(rest, acc, stack, context, line, offset)
  end

  defp parse__100(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__100(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__100(rest, acc, stack, context, line, offset) do
    parse__93(rest, acc, stack, context, line, offset)
  end

  defp parse__101(<<"Z", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, ["Z"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__101(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__102(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__88(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__88(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__103(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__103(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__104(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__85(rest, [], stack, context, line, offset)
  end

  defp parse__105(<<"FREQ", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, ["FREQ"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__105(rest, acc, stack, context, line, offset) do
    parse__104(rest, acc, stack, context, line, offset)
  end

  defp parse__106(<<"SECONDLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ["SECONDLY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__106(<<"MINUTELY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ["MINUTELY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__106(<<"HOURLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ["HOURLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__106(<<"DAILY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ["DAILY"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__106(<<"WEEKLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ["WEEKLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__106(<<"MONTHLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ["MONTHLY"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__106(<<"YEARLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, ["YEARLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__106(rest, acc, stack, context, line, offset) do
    parse__104(rest, acc, stack, context, line, offset)
  end

  defp parse__107(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__2(rest, acc, stack, context, line, offset) do
    parse__109(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__109(<<";", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__110(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__109(rest, acc, stack, context, line, offset) do
    parse__108(rest, acc, stack, context, line, offset)
  end

  defp parse__110(rest, acc, stack, context, line, offset) do
    parse__214(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__112(
         <<"BYMONTHDAY", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__113(rest, ["BYMONTHDAY"] ++ acc, stack, context, comb__line, comb__offset + 11)
  end

  defp parse__112(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse__108(rest, acc, stack, context, line, offset)
  end

  defp parse__113(rest, acc, stack, context, line, offset) do
    parse__114(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__114(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-31"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-30"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-29"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-28"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-27"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-26"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-25"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-24"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-23"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-22"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-21"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-20"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-19"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-18"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-17"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-16"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-15"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-14"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-13"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-12"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-11"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-10"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__114(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-9"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-8"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-7"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-6"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-5"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-4"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-3"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-2"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["-1"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["31"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["30"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["29"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["28"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["27"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["26"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["25"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["24"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["23"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["22"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["21"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["20"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["19"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["18"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["17"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["16"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["15"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["14"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["13"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["12"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["11"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["10"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["9"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["8"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["7"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["6"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["5"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["4"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["3"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["2"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ["1"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__108(rest, acc, stack, context, line, offset)
  end

  defp parse__115(rest, acc, stack, context, line, offset) do
    parse__117(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__117(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__117(rest, acc, stack, context, line, offset) do
    parse__116(rest, acc, stack, context, line, offset)
  end

  defp parse__118(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-31"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-30"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-29"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-28"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-27"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-26"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-25"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-24"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-23"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-22"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-21"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-20"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-19"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-18"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-17"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-16"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-15"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-14"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-13"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-12"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-11"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-10"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__118(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-9"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-8"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-7"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-6"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-5"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-4"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-3"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-2"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["-1"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["31"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["30"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["29"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["28"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["27"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["26"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["25"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["24"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["23"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["22"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["21"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["20"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["19"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["18"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["17"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["16"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["15"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["14"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["13"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["12"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["11"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["10"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["9"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["8"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["7"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["6"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["5"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["4"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["3"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["2"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ["1"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(rest, acc, stack, context, line, offset) do
    parse__116(rest, acc, stack, context, line, offset)
  end

  defp parse__116(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__120(rest, acc, stack, context, line, offset)
  end

  defp parse__119(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__117(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__120(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__121(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__121(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__111(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__122(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__112(rest, [], stack, context, line, offset)
  end

  defp parse__123(<<"BYMONTH", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__124(rest, ["BYMONTH"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__123(rest, acc, stack, context, line, offset) do
    parse__122(rest, acc, stack, context, line, offset)
  end

  defp parse__124(rest, acc, stack, context, line, offset) do
    parse__125(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__125(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
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

  defp parse__125(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__122(rest, acc, stack, context, line, offset)
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

  defp parse__129(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(rest, acc, stack, context, line, offset) do
    parse__127(rest, acc, stack, context, line, offset)
  end

  defp parse__127(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__131(rest, acc, stack, context, line, offset)
  end

  defp parse__130(
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

  defp parse__131(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__132(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__132(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__111(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__133(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__123(rest, [], stack, context, line, offset)
  end

  defp parse__134(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__135(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__134(rest, acc, stack, context, line, offset) do
    parse__133(rest, acc, stack, context, line, offset)
  end

  defp parse__135(rest, acc, stack, context, line, offset) do
    parse__136(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__136(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__136(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__136(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__136(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__136(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__136(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__136(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__136(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__133(rest, acc, stack, context, line, offset)
  end

  defp parse__137(rest, acc, stack, context, line, offset) do
    parse__139(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__139(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__139(rest, acc, stack, context, line, offset) do
    parse__138(rest, acc, stack, context, line, offset)
  end

  defp parse__140(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__140(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__140(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__140(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__140(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__140(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__140(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__140(rest, acc, stack, context, line, offset) do
    parse__138(rest, acc, stack, context, line, offset)
  end

  defp parse__138(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__142(rest, acc, stack, context, line, offset)
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

  defp parse__142(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__143(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__143(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__111(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__144(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__134(rest, [], stack, context, line, offset)
  end

  defp parse__145(<<"BYHOUR", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__146(rest, ["BYHOUR"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__145(rest, acc, stack, context, line, offset) do
    parse__144(rest, acc, stack, context, line, offset)
  end

  defp parse__146(rest, acc, stack, context, line, offset) do
    parse__147(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__147(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__147(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__147(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__147(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__147(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__147(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__147(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__147(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__147(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__147(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__147(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__144(rest, acc, stack, context, line, offset)
  end

  defp parse__148(rest, acc, stack, context, line, offset) do
    parse__150(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__150(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__151(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__150(rest, acc, stack, context, line, offset) do
    parse__149(rest, acc, stack, context, line, offset)
  end

  defp parse__151(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__151(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__151(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__151(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__151(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__151(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__151(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__151(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__151(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__151(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__151(rest, acc, stack, context, line, offset) do
    parse__149(rest, acc, stack, context, line, offset)
  end

  defp parse__149(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__153(rest, acc, stack, context, line, offset)
  end

  defp parse__152(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__150(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__153(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__154(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__154(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__111(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__155(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__145(rest, [], stack, context, line, offset)
  end

  defp parse__156(
         <<"BYMINUTE", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__157(rest, ["BYMINUTE"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__156(rest, acc, stack, context, line, offset) do
    parse__155(rest, acc, stack, context, line, offset)
  end

  defp parse__157(rest, acc, stack, context, line, offset) do
    parse__158(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__158(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__158(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__158(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__158(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__158(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__158(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__158(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__158(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__158(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__158(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__158(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__155(rest, acc, stack, context, line, offset)
  end

  defp parse__159(rest, acc, stack, context, line, offset) do
    parse__161(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__161(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__161(rest, acc, stack, context, line, offset) do
    parse__160(rest, acc, stack, context, line, offset)
  end

  defp parse__162(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__162(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__162(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__162(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__162(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__162(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__162(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__162(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__162(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__162(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__162(rest, acc, stack, context, line, offset) do
    parse__160(rest, acc, stack, context, line, offset)
  end

  defp parse__160(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__164(rest, acc, stack, context, line, offset)
  end

  defp parse__163(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__161(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__164(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__165(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__165(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__111(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__166(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__156(rest, [], stack, context, line, offset)
  end

  defp parse__167(
         <<"BYSECOND", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__168(rest, ["BYSECOND"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__167(rest, acc, stack, context, line, offset) do
    parse__166(rest, acc, stack, context, line, offset)
  end

  defp parse__168(rest, acc, stack, context, line, offset) do
    parse__169(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__169(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__169(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__169(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__169(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__169(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__169(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__169(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__169(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__169(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__169(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__169(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__169(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__166(rest, acc, stack, context, line, offset)
  end

  defp parse__170(rest, acc, stack, context, line, offset) do
    parse__172(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__172(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(rest, acc, stack, context, line, offset) do
    parse__171(rest, acc, stack, context, line, offset)
  end

  defp parse__173(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__173(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__173(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__173(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__173(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__173(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__173(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__173(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__173(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__173(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__173(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__174(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__173(rest, acc, stack, context, line, offset) do
    parse__171(rest, acc, stack, context, line, offset)
  end

  defp parse__171(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__175(rest, acc, stack, context, line, offset)
  end

  defp parse__174(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__172(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__175(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__176(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__176(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__111(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__177(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__167(rest, [], stack, context, line, offset)
  end

  defp parse__178(
         <<"INTERVAL", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__179(rest, ["INTERVAL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__178(rest, acc, stack, context, line, offset) do
    parse__177(rest, acc, stack, context, line, offset)
  end

  defp parse__179(rest, acc, stack, context, line, offset) do
    parse__180(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__180(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__181(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__180(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__177(rest, acc, stack, context, line, offset)
  end

  defp parse__181(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__183(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__181(rest, acc, stack, context, line, offset) do
    parse__182(rest, acc, stack, context, line, offset)
  end

  defp parse__183(rest, acc, stack, context, line, offset) do
    parse__181(rest, acc, stack, context, line, offset)
  end

  defp parse__182(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__184(
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

  defp parse__184(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__111(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__185(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__178(rest, [], stack, context, line, offset)
  end

  defp parse__186(<<"COUNT", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__187(rest, ["COUNT"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__186(rest, acc, stack, context, line, offset) do
    parse__185(rest, acc, stack, context, line, offset)
  end

  defp parse__187(rest, acc, stack, context, line, offset) do
    parse__188(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__188(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__189(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__188(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__185(rest, acc, stack, context, line, offset)
  end

  defp parse__189(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__191(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__189(rest, acc, stack, context, line, offset) do
    parse__190(rest, acc, stack, context, line, offset)
  end

  defp parse__191(rest, acc, stack, context, line, offset) do
    parse__189(rest, acc, stack, context, line, offset)
  end

  defp parse__190(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__192(
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

  defp parse__192(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__111(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__193(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__186(rest, [], stack, context, line, offset)
  end

  defp parse__194(<<"UNTIL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ["UNTIL"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__194(rest, acc, stack, context, line, offset) do
    parse__193(rest, acc, stack, context, line, offset)
  end

  defp parse__195(rest, acc, stack, context, line, offset) do
    parse__196(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__196(rest, acc, stack, context, line, offset) do
    parse__203(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__198(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__199(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__198(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__193(rest, acc, stack, context, line, offset)
  end

  defp parse__199(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__200(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__199(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__193(rest, acc, stack, context, line, offset)
  end

  defp parse__200(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__201(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__200(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__193(rest, acc, stack, context, line, offset)
  end

  defp parse__201(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__197(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__202(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__198(rest, [], stack, context, line, offset)
  end

  defp parse__203(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__204(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__203(rest, acc, stack, context, line, offset) do
    parse__202(rest, acc, stack, context, line, offset)
  end

  defp parse__204(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__205(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__204(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__205(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__204(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__205(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__204(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__205(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__204(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__205(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__204(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__205(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__204(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__205(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__204(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__205(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__204(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__205(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__204(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__205(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__204(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__205(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__204(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__205(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__204(rest, acc, stack, context, line, offset) do
    parse__202(rest, acc, stack, context, line, offset)
  end

  defp parse__205(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__206(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__205(rest, acc, stack, context, line, offset) do
    parse__202(rest, acc, stack, context, line, offset)
  end

  defp parse__206(<<"T", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__207(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__206(rest, acc, stack, context, line, offset) do
    parse__202(rest, acc, stack, context, line, offset)
  end

  defp parse__207(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__207(rest, acc, stack, context, line, offset) do
    parse__202(rest, acc, stack, context, line, offset)
  end

  defp parse__208(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__208(rest, acc, stack, context, line, offset) do
    parse__202(rest, acc, stack, context, line, offset)
  end

  defp parse__209(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__210(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__209(rest, acc, stack, context, line, offset) do
    parse__202(rest, acc, stack, context, line, offset)
  end

  defp parse__210(<<"Z", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__211(rest, ["Z"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__210(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__211(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__211(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__197(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__197(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__212(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__212(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__111(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__213(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__194(rest, [], stack, context, line, offset)
  end

  defp parse__214(<<"FREQ", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__215(rest, ["FREQ"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__214(rest, acc, stack, context, line, offset) do
    parse__213(rest, acc, stack, context, line, offset)
  end

  defp parse__215(<<"SECONDLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__216(rest, ["SECONDLY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__215(<<"MINUTELY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__216(rest, ["MINUTELY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__215(<<"HOURLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__216(rest, ["HOURLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__215(<<"DAILY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__216(rest, ["DAILY"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__215(<<"WEEKLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__216(rest, ["WEEKLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__215(<<"MONTHLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__216(rest, ["MONTHLY"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__215(<<"YEARLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__216(rest, ["YEARLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__215(rest, acc, stack, context, line, offset) do
    parse__213(rest, acc, stack, context, line, offset)
  end

  defp parse__216(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__111(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__108(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__217(rest, acc, stack, context, line, offset)
  end

  defp parse__111(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__109(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__217(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__218(rest, [to_map(:lists.reverse(user_acc))] ++ acc, stack, context, line, offset)
  end

  defp parse__218(rest, acc, _stack, context, line, offset) do
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

  defp cast_byday("SU"), do: 7
  defp cast_byday("MO"), do: 1
  defp cast_byday("TU"), do: 2
  defp cast_byday("WE"), do: 3
  defp cast_byday("TH"), do: 4
  defp cast_byday("FR"), do: 5
  defp cast_byday("SA"), do: 6
end
