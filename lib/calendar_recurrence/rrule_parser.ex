# Generated from lib/calendar_recurrence/rrule_parser.ex.exs, do not edit.
# Generated at 2025-10-03 22:32:27Z.

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
    parse__116(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
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
     "expected string \"FREQ\", followed by string \"=\", followed by string \"SECONDLY\" or string \"MINUTELY\" or string \"HOURLY\" or string \"DAILY\" or string \"WEEKLY\" or string \"MONTHLY\" or string \"YEARLY\" or string \"UNTIL\", followed by string \"=\", followed by datetime or date or string \"COUNT\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"INTERVAL\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYSECOND\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYMINUTE\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYHOUR\", followed by string \"=\", followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYDAY\", followed by string \"=\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"BYDAY\", followed by string \"=\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"BYMONTH\", followed by string \"=\", followed by string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\" or string \"10\" or string \"11\" or string \"12\", followed by ,, followed by string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\" or string \"10\" or string \"11\" or string \"12\" or string \"BYMONTHDAY\", followed by string \"=\", followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\", followed by ,, followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\"",
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
     "expected string \"FREQ\", followed by string \"=\", followed by string \"SECONDLY\" or string \"MINUTELY\" or string \"HOURLY\" or string \"DAILY\" or string \"WEEKLY\" or string \"MONTHLY\" or string \"YEARLY\" or string \"UNTIL\", followed by string \"=\", followed by datetime or date or string \"COUNT\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"INTERVAL\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYSECOND\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYMINUTE\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYHOUR\", followed by string \"=\", followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYDAY\", followed by string \"=\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"BYDAY\", followed by string \"=\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\" or string \"BYMONTH\", followed by string \"=\", followed by string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\" or string \"10\" or string \"11\" or string \"12\", followed by ,, followed by string \"1\" or string \"2\" or string \"3\" or string \"4\" or string \"5\" or string \"6\" or string \"7\" or string \"8\" or string \"9\" or string \"10\" or string \"11\" or string \"12\" or string \"BYMONTHDAY\", followed by string \"=\", followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\", followed by ,, followed by string \"-31\" or string \"-30\" or string \"-29\" or string \"-28\" or string \"-27\" or string \"-26\" or string \"-25\" or string \"-24\" or string \"-23\" or string \"-22\" or string \"-21\" or string \"-20\" or string \"-19\" or string \"-18\" or string \"-17\" or string \"-16\" or string \"-15\" or string \"-14\" or string \"-13\" or string \"-12\" or string \"-11\" or string \"-10\" or string \"-9\" or string \"-8\" or string \"-7\" or string \"-6\" or string \"-5\" or string \"-4\" or string \"-3\" or string \"-2\" or string \"-1\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\"",
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

  defp parse__36(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__37(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__36(rest, acc, stack, context, line, offset) do
    parse__35(rest, acc, stack, context, line, offset)
  end

  defp parse__37(rest, acc, stack, context, line, offset) do
    parse__38(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__38(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__42(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__47(<<"BYHOUR", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ["BYHOUR"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__47(rest, acc, stack, context, line, offset) do
    parse__46(rest, acc, stack, context, line, offset)
  end

  defp parse__48(rest, acc, stack, context, line, offset) do
    parse__49(rest, [], [acc | stack], context, line, offset)
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

  defp parse__58(<<"BYMINUTE", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__59(rest, ["BYMINUTE"] ++ acc, stack, context, comb__line, comb__offset + 9)
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

  defp parse__69(<<"BYSECOND", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, ["BYSECOND"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__69(rest, acc, stack, context, line, offset) do
    parse__68(rest, acc, stack, context, line, offset)
  end

  defp parse__70(rest, acc, stack, context, line, offset) do
    parse__71(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__71(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__71(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__71(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__71(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__71(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__71(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__71(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__71(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__71(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__71(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__71(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__72(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__71(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__68(rest, acc, stack, context, line, offset)
  end

  defp parse__72(rest, acc, stack, context, line, offset) do
    parse__74(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__74(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__74(rest, acc, stack, context, line, offset) do
    parse__73(rest, acc, stack, context, line, offset)
  end

  defp parse__75(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__75(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__75(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__75(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__75(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__75(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__75(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__75(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__75(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__75(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__75(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__75(rest, acc, stack, context, line, offset) do
    parse__73(rest, acc, stack, context, line, offset)
  end

  defp parse__73(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__77(rest, acc, stack, context, line, offset)
  end

  defp parse__76(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__74(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__77(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__78(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__78(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__79(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__69(rest, [], stack, context, line, offset)
  end

  defp parse__80(<<"INTERVAL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__81(rest, ["INTERVAL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__80(rest, acc, stack, context, line, offset) do
    parse__79(rest, acc, stack, context, line, offset)
  end

  defp parse__81(rest, acc, stack, context, line, offset) do
    parse__82(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__82(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__83(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__82(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__79(rest, acc, stack, context, line, offset)
  end

  defp parse__83(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__85(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__83(rest, acc, stack, context, line, offset) do
    parse__84(rest, acc, stack, context, line, offset)
  end

  defp parse__85(rest, acc, stack, context, line, offset) do
    parse__83(rest, acc, stack, context, line, offset)
  end

  defp parse__84(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__86(
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

  defp parse__86(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__87(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__80(rest, [], stack, context, line, offset)
  end

  defp parse__88(<<"COUNT", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__89(rest, ["COUNT"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__88(rest, acc, stack, context, line, offset) do
    parse__87(rest, acc, stack, context, line, offset)
  end

  defp parse__89(rest, acc, stack, context, line, offset) do
    parse__90(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__90(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__91(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__90(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__87(rest, acc, stack, context, line, offset)
  end

  defp parse__91(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__93(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__91(rest, acc, stack, context, line, offset) do
    parse__92(rest, acc, stack, context, line, offset)
  end

  defp parse__93(rest, acc, stack, context, line, offset) do
    parse__91(rest, acc, stack, context, line, offset)
  end

  defp parse__92(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__94(
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

  defp parse__94(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__95(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__88(rest, [], stack, context, line, offset)
  end

  defp parse__96(<<"UNTIL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ["UNTIL"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__96(rest, acc, stack, context, line, offset) do
    parse__95(rest, acc, stack, context, line, offset)
  end

  defp parse__97(rest, acc, stack, context, line, offset) do
    parse__98(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__98(rest, acc, stack, context, line, offset) do
    parse__105(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__100(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__101(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__100(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__95(rest, acc, stack, context, line, offset)
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

  defp parse__101(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__95(rest, acc, stack, context, line, offset)
  end

  defp parse__102(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__95(rest, acc, stack, context, line, offset)
  end

  defp parse__103(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__99(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__104(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__100(rest, [], stack, context, line, offset)
  end

  defp parse__105(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__106(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__105(rest, acc, stack, context, line, offset) do
    parse__104(rest, acc, stack, context, line, offset)
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

  defp parse__106(rest, acc, stack, context, line, offset) do
    parse__104(rest, acc, stack, context, line, offset)
  end

  defp parse__107(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(rest, acc, stack, context, line, offset) do
    parse__104(rest, acc, stack, context, line, offset)
  end

  defp parse__108(<<"T", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__109(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__108(rest, acc, stack, context, line, offset) do
    parse__104(rest, acc, stack, context, line, offset)
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

  defp parse__109(rest, acc, stack, context, line, offset) do
    parse__104(rest, acc, stack, context, line, offset)
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
    parse__104(rest, acc, stack, context, line, offset)
  end

  defp parse__111(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__112(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__111(rest, acc, stack, context, line, offset) do
    parse__104(rest, acc, stack, context, line, offset)
  end

  defp parse__112(<<"Z", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__113(rest, ["Z"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__112(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__113(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__113(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__99(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__99(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__114(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__114(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__115(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__96(rest, [], stack, context, line, offset)
  end

  defp parse__116(<<"FREQ", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__117(rest, ["FREQ"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__116(rest, acc, stack, context, line, offset) do
    parse__115(rest, acc, stack, context, line, offset)
  end

  defp parse__117(<<"SECONDLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, ["SECONDLY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__117(<<"MINUTELY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, ["MINUTELY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__117(<<"HOURLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, ["HOURLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__117(<<"DAILY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, ["DAILY"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__117(<<"WEEKLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, ["WEEKLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__117(<<"MONTHLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, ["MONTHLY"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__117(<<"YEARLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, ["YEARLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__117(rest, acc, stack, context, line, offset) do
    parse__115(rest, acc, stack, context, line, offset)
  end

  defp parse__118(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__2(rest, acc, stack, context, line, offset) do
    parse__120(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__120(<<";", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__121(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__120(rest, acc, stack, context, line, offset) do
    parse__119(rest, acc, stack, context, line, offset)
  end

  defp parse__121(rest, acc, stack, context, line, offset) do
    parse__236(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__123(
         <<"BYMONTHDAY", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__124(rest, ["BYMONTHDAY"] ++ acc, stack, context, comb__line, comb__offset + 11)
  end

  defp parse__123(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse__119(rest, acc, stack, context, line, offset)
  end

  defp parse__124(rest, acc, stack, context, line, offset) do
    parse__125(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__125(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-31"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-30"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-29"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-28"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-27"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-26"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-25"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-24"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-23"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-22"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-21"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-20"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-19"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-18"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-17"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-16"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-15"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-14"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-13"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-12"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-11"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-10"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__125(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-9"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-8"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-7"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-6"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-5"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-4"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-3"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-2"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["-1"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["31"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["30"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["29"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["28"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["27"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["26"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["25"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["24"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["23"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["22"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["21"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["20"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["19"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["18"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["17"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["16"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["15"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["14"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["13"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["12"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["11"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["10"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["9"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["8"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["7"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["6"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["5"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["4"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["3"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["2"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ["1"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__119(rest, acc, stack, context, line, offset)
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
    parse__130(rest, ["-31"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-30"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-29"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-28"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-27"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-26"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-25"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-24"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-23"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-22"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-21"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-20"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-19"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-18"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-17"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-16"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-15"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-14"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-13"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-12"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-11"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-10"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__129(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-9"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-8"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-7"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-6"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-5"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-4"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-3"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-2"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["-1"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["31"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["30"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["29"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["28"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["27"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["26"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["25"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["24"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["23"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["22"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["21"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["20"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["19"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["18"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["17"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["16"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["15"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["14"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["13"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["12"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["11"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["10"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["9"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["8"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["7"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["6"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["5"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["4"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["3"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["2"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ["1"] ++ acc, stack, context, comb__line, comb__offset + 1)
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
    parse__122(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__133(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__123(rest, [], stack, context, line, offset)
  end

  defp parse__134(<<"BYMONTH", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__135(rest, ["BYMONTH"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__134(rest, acc, stack, context, line, offset) do
    parse__133(rest, acc, stack, context, line, offset)
  end

  defp parse__135(rest, acc, stack, context, line, offset) do
    parse__136(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__136(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__136(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__136(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__136(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__136(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__136(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__136(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__136(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__136(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__136(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__136(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__136(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__137(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__140(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__140(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__140(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__140(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__140(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__140(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__140(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__140(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__140(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__140(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__140(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__140(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__141(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__122(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__144(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__134(rest, [], stack, context, line, offset)
  end

  defp parse__145(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__146(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__145(rest, acc, stack, context, line, offset) do
    parse__144(rest, acc, stack, context, line, offset)
  end

  defp parse__146(rest, acc, stack, context, line, offset) do
    parse__147(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__147(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__147(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__148(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__151(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__151(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__152(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__122(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__155(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__145(rest, [], stack, context, line, offset)
  end

  defp parse__156(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__156(rest, acc, stack, context, line, offset) do
    parse__155(rest, acc, stack, context, line, offset)
  end

  defp parse__157(rest, acc, stack, context, line, offset) do
    parse__158(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__158(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__158(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__159(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__162(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__122(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__166(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__156(rest, [], stack, context, line, offset)
  end

  defp parse__167(<<"BYHOUR", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__168(rest, ["BYHOUR"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__167(rest, acc, stack, context, line, offset) do
    parse__166(rest, acc, stack, context, line, offset)
  end

  defp parse__168(rest, acc, stack, context, line, offset) do
    parse__169(rest, [], [acc | stack], context, line, offset)
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
    parse__122(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__177(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__167(rest, [], stack, context, line, offset)
  end

  defp parse__178(
         <<"BYMINUTE", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__179(rest, ["BYMINUTE"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__178(rest, acc, stack, context, line, offset) do
    parse__177(rest, acc, stack, context, line, offset)
  end

  defp parse__179(rest, acc, stack, context, line, offset) do
    parse__180(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__180(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__180(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__180(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__180(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__180(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__180(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__180(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__180(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__180(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__180(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__180(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__181(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__180(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__177(rest, acc, stack, context, line, offset)
  end

  defp parse__181(rest, acc, stack, context, line, offset) do
    parse__183(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__183(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__183(rest, acc, stack, context, line, offset) do
    parse__182(rest, acc, stack, context, line, offset)
  end

  defp parse__184(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__184(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__184(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__184(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__184(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__184(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__184(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__184(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__184(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__184(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__184(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__185(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__184(rest, acc, stack, context, line, offset) do
    parse__182(rest, acc, stack, context, line, offset)
  end

  defp parse__182(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__186(rest, acc, stack, context, line, offset)
  end

  defp parse__185(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__183(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__186(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__187(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__187(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__122(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__188(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__178(rest, [], stack, context, line, offset)
  end

  defp parse__189(
         <<"BYSECOND", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__190(rest, ["BYSECOND"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__189(rest, acc, stack, context, line, offset) do
    parse__188(rest, acc, stack, context, line, offset)
  end

  defp parse__190(rest, acc, stack, context, line, offset) do
    parse__191(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__191(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__191(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__192(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__191(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__188(rest, acc, stack, context, line, offset)
  end

  defp parse__192(rest, acc, stack, context, line, offset) do
    parse__194(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__194(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__194(rest, acc, stack, context, line, offset) do
    parse__193(rest, acc, stack, context, line, offset)
  end

  defp parse__195(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__195(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__195(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__195(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__195(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__195(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__195(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__195(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__195(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__195(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__195(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__196(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__195(rest, acc, stack, context, line, offset) do
    parse__193(rest, acc, stack, context, line, offset)
  end

  defp parse__193(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__197(rest, acc, stack, context, line, offset)
  end

  defp parse__196(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__194(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__197(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__198(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__198(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__122(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__199(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__189(rest, [], stack, context, line, offset)
  end

  defp parse__200(
         <<"INTERVAL", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__201(rest, ["INTERVAL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__200(rest, acc, stack, context, line, offset) do
    parse__199(rest, acc, stack, context, line, offset)
  end

  defp parse__201(rest, acc, stack, context, line, offset) do
    parse__202(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__202(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__203(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__202(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__199(rest, acc, stack, context, line, offset)
  end

  defp parse__203(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__205(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__203(rest, acc, stack, context, line, offset) do
    parse__204(rest, acc, stack, context, line, offset)
  end

  defp parse__205(rest, acc, stack, context, line, offset) do
    parse__203(rest, acc, stack, context, line, offset)
  end

  defp parse__204(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__206(
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

  defp parse__206(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__122(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__207(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__200(rest, [], stack, context, line, offset)
  end

  defp parse__208(<<"COUNT", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__209(rest, ["COUNT"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__208(rest, acc, stack, context, line, offset) do
    parse__207(rest, acc, stack, context, line, offset)
  end

  defp parse__209(rest, acc, stack, context, line, offset) do
    parse__210(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__210(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__211(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__210(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__207(rest, acc, stack, context, line, offset)
  end

  defp parse__211(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__213(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__211(rest, acc, stack, context, line, offset) do
    parse__212(rest, acc, stack, context, line, offset)
  end

  defp parse__213(rest, acc, stack, context, line, offset) do
    parse__211(rest, acc, stack, context, line, offset)
  end

  defp parse__212(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__214(
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

  defp parse__214(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__122(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__215(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__208(rest, [], stack, context, line, offset)
  end

  defp parse__216(<<"UNTIL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__217(rest, ["UNTIL"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__216(rest, acc, stack, context, line, offset) do
    parse__215(rest, acc, stack, context, line, offset)
  end

  defp parse__217(rest, acc, stack, context, line, offset) do
    parse__218(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__218(rest, acc, stack, context, line, offset) do
    parse__225(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__220(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__221(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__220(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__215(rest, acc, stack, context, line, offset)
  end

  defp parse__221(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__215(rest, acc, stack, context, line, offset)
  end

  defp parse__222(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__223(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__222(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__215(rest, acc, stack, context, line, offset)
  end

  defp parse__223(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__219(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__224(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__220(rest, [], stack, context, line, offset)
  end

  defp parse__225(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__226(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__225(rest, acc, stack, context, line, offset) do
    parse__224(rest, acc, stack, context, line, offset)
  end

  defp parse__226(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(rest, acc, stack, context, line, offset) do
    parse__224(rest, acc, stack, context, line, offset)
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

  defp parse__227(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__227(rest, acc, stack, context, line, offset) do
    parse__224(rest, acc, stack, context, line, offset)
  end

  defp parse__228(<<"T", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__229(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__228(rest, acc, stack, context, line, offset) do
    parse__224(rest, acc, stack, context, line, offset)
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

  defp parse__229(rest, acc, stack, context, line, offset) do
    parse__224(rest, acc, stack, context, line, offset)
  end

  defp parse__230(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__231(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__230(rest, acc, stack, context, line, offset) do
    parse__224(rest, acc, stack, context, line, offset)
  end

  defp parse__231(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"\"" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__232(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__231(rest, acc, stack, context, line, offset) do
    parse__224(rest, acc, stack, context, line, offset)
  end

  defp parse__232(<<"Z", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__233(rest, ["Z"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__232(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__233(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__233(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__219(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__219(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__234(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__234(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__122(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__235(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__216(rest, [], stack, context, line, offset)
  end

  defp parse__236(<<"FREQ", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__237(rest, ["FREQ"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__236(rest, acc, stack, context, line, offset) do
    parse__235(rest, acc, stack, context, line, offset)
  end

  defp parse__237(<<"SECONDLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__238(rest, ["SECONDLY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__237(<<"MINUTELY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__238(rest, ["MINUTELY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__237(<<"HOURLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__238(rest, ["HOURLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__237(<<"DAILY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__238(rest, ["DAILY"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__237(<<"WEEKLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__238(rest, ["WEEKLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__237(<<"MONTHLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__238(rest, ["MONTHLY"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__237(<<"YEARLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__238(rest, ["YEARLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__237(rest, acc, stack, context, line, offset) do
    parse__235(rest, acc, stack, context, line, offset)
  end

  defp parse__238(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__122(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__119(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__239(rest, acc, stack, context, line, offset)
  end

  defp parse__122(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__120(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__239(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__240(rest, [to_map(:lists.reverse(user_acc))] ++ acc, stack, context, line, offset)
  end

  defp parse__240(rest, acc, _stack, context, line, offset) do
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

  defp cast_value("UNTIL", [year, month, day, hour, minute, second | _utc_suffix]) do
    {:ok, naive_datetime} = NaiveDateTime.new(year, month, day, hour, minute, second)
    {:ok, datetime} = DateTime.from_naive(naive_datetime, "Etc/UTC")

    datetime
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
