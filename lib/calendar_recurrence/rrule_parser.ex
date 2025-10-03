# Generated from lib/calendar_recurrence/rrule_parser.ex.exs, do not edit.
# Generated at 2025-01-22 02:32:50Z.

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
             byte_offset: pos_integer,
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
    parse__61(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__65(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__72(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__76(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__103(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__105(rest, acc, stack, context, line, offset)
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
    parse__111(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__112(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__112(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__99(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__99(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__113(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__113(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__114(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__96(rest, [], stack, context, line, offset)
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
    parse__122(rest, acc, stack, context, line, offset)
  end

  defp parse__124(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-31"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-30"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-29"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-28"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-27"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-26"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-25"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-24"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-23"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-22"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-21"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-20"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-19"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-18"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-17"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-16"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-15"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-14"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-13"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-12"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-11"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-10"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__124(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-9"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-8"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-7"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-6"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-5"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-4"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-3"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-2"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["-1"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["31"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["30"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["29"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["28"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["27"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["26"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["25"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["24"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["23"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["22"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["21"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["20"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["19"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["18"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["17"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["16"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["15"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["14"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["13"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["12"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["11"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["10"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["9"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["8"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["7"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["6"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["5"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["4"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["3"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["2"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ["1"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__118(rest, acc, stack, context, line, offset)
  end

  defp parse__126(rest, acc, stack, context, line, offset) do
    parse__128(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__127(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__128(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__127(rest, acc, stack, context, line, offset) do
    parse__126(rest, acc, stack, context, line, offset)
  end

  defp parse__128(<<"-31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-31"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-30"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-29"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-28"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-27"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-26"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-25"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-24"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-23"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-22"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-21"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-20"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-19"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-18"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-17"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-16"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-15"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-14"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-13"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-12"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-11"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-10"] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp parse__128(<<"-9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-9"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"-8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-8"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"-7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-7"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"-6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-6"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"-5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-5"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"-4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-4"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"-3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-3"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"-2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-2"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"-1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["-1"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["31"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["30"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["29"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["28"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["27"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["26"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["25"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["24"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["23"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["22"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["21"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["20"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["19"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["18"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["17"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["16"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["15"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["14"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["13"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["12"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["11"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["10"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["9"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["8"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["7"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["6"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["5"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["4"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["3"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["2"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ["1"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(rest, acc, stack, context, line, offset) do
    parse__127(rest, acc, stack, context, line, offset)
  end

  defp parse__129(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__129(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__129(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__130(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
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

  defp parse__131(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__133(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__123(rest, [], stack, context, line, offset)
  end

  defp parse__133(<<"BYMONTH", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__134(rest, ["BYMONTH"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__133(rest, acc, stack, context, line, offset) do
    parse__132(rest, acc, stack, context, line, offset)
  end

  defp parse__134(rest, acc, stack, context, line, offset) do
    parse__133(rest, acc, stack, context, line, offset)
  end

  defp parse__135(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__135(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__135(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__135(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__135(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__135(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__135(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__135(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__135(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__135(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__135(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__135(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__136(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__135(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__132(rest, acc, stack, context, line, offset)
  end

  defp parse__136(rest, acc, stack, context, line, offset) do
    parse__138(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__138(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__139(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__138(rest, acc, stack, context, line, offset) do
    parse__137(rest, acc, stack, context, line, offset)
  end

  defp parse__139(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__139(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__139(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__139(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__139(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__139(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__139(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__139(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__139(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__139(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__139(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__139(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__140(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__139(rest, acc, stack, context, line, offset) do
    parse__137(rest, acc, stack, context, line, offset)
  end

  defp parse__137(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__141(rest, acc, stack, context, line, offset)
  end

  defp parse__140(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__138(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__141(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__142(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__142(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__143(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__133(rest, [], stack, context, line, offset)
  end

  defp parse__144(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__145(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__144(rest, acc, stack, context, line, offset) do
    parse__143(rest, acc, stack, context, line, offset)
  end

  defp parse__145(rest, acc, stack, context, line, offset) do
    parse__146(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__146(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__147(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__146(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__147(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__146(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__147(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__146(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__147(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__146(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__147(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__146(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__147(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__146(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__147(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__146(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__143(rest, acc, stack, context, line, offset)
  end

  defp parse__147(rest, acc, stack, context, line, offset) do
    parse__149(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__149(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__150(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__149(rest, acc, stack, context, line, offset) do
    parse__148(rest, acc, stack, context, line, offset)
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

  defp parse__150(rest, acc, stack, context, line, offset) do
    parse__148(rest, acc, stack, context, line, offset)
  end

  defp parse__148(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__152(rest, acc, stack, context, line, offset)
  end

  defp parse__151(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__149(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__152(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__153(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__153(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__154(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__144(rest, [], stack, context, line, offset)
  end

  defp parse__155(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__155(rest, acc, stack, context, line, offset) do
    parse__154(rest, acc, stack, context, line, offset)
  end

  defp parse__156(rest, acc, stack, context, line, offset) do
    parse__157(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__157(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__158(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__157(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__158(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__157(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__158(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__157(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__158(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__157(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__158(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__157(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__158(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__157(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__158(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__157(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__154(rest, acc, stack, context, line, offset)
  end

  defp parse__158(rest, acc, stack, context, line, offset) do
    parse__160(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__160(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__160(rest, acc, stack, context, line, offset) do
    parse__159(rest, acc, stack, context, line, offset)
  end

  defp parse__161(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(rest, acc, stack, context, line, offset) do
    parse__159(rest, acc, stack, context, line, offset)
  end

  defp parse__159(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__163(rest, acc, stack, context, line, offset)
  end

  defp parse__162(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__160(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__163(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__164(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__164(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__165(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__155(rest, [], stack, context, line, offset)
  end

  defp parse__166(<<"BYHOUR", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, ["BYHOUR"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__166(rest, acc, stack, context, line, offset) do
    parse__165(rest, acc, stack, context, line, offset)
  end

  defp parse__167(rest, acc, stack, context, line, offset) do
    parse__168(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__168(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__168(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__168(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__168(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__168(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__168(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__168(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__168(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__168(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__168(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__168(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__168(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__165(rest, acc, stack, context, line, offset)
  end

  defp parse__169(rest, acc, stack, context, line, offset) do
    parse__171(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__171(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__172(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__171(rest, acc, stack, context, line, offset) do
    parse__170(rest, acc, stack, context, line, offset)
  end

  defp parse__172(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__172(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__173(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__172(rest, acc, stack, context, line, offset) do
    parse__170(rest, acc, stack, context, line, offset)
  end

  defp parse__170(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__174(rest, acc, stack, context, line, offset)
  end

  defp parse__173(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__171(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__174(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__175(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__175(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__176(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__166(rest, [], stack, context, line, offset)
  end

  defp parse__177(
         <<"BYMINUTE", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__178(rest, ["BYMINUTE"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__177(rest, acc, stack, context, line, offset) do
    parse__176(rest, acc, stack, context, line, offset)
  end

  defp parse__178(rest, acc, stack, context, line, offset) do
    parse__179(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__179(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__179(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__180(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__179(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__176(rest, acc, stack, context, line, offset)
  end

  defp parse__180(rest, acc, stack, context, line, offset) do
    parse__182(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__182(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__183(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__182(rest, acc, stack, context, line, offset) do
    parse__181(rest, acc, stack, context, line, offset)
  end

  defp parse__183(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__183(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__183(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__183(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__183(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__183(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__183(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__183(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__183(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__183(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__183(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__184(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__183(rest, acc, stack, context, line, offset) do
    parse__181(rest, acc, stack, context, line, offset)
  end

  defp parse__181(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__185(rest, acc, stack, context, line, offset)
  end

  defp parse__184(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__182(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__185(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__186(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__186(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__187(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__177(rest, [], stack, context, line, offset)
  end

  defp parse__188(
         <<"BYSECOND", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__189(rest, ["BYSECOND"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__188(rest, acc, stack, context, line, offset) do
    parse__187(rest, acc, stack, context, line, offset)
  end

  defp parse__189(rest, acc, stack, context, line, offset) do
    parse__190(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__190(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__190(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__190(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__190(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__190(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__190(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__190(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__190(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__190(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__190(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__190(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__191(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__190(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__187(rest, acc, stack, context, line, offset)
  end

  defp parse__191(rest, acc, stack, context, line, offset) do
    parse__193(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__193(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__194(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__193(rest, acc, stack, context, line, offset) do
    parse__192(rest, acc, stack, context, line, offset)
  end

  defp parse__194(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__194(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__194(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__194(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__194(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__194(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__194(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__194(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__194(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__194(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__194(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__195(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__194(rest, acc, stack, context, line, offset) do
    parse__192(rest, acc, stack, context, line, offset)
  end

  defp parse__192(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__196(rest, acc, stack, context, line, offset)
  end

  defp parse__195(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__193(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__196(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__197(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__197(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__198(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__188(rest, [], stack, context, line, offset)
  end

  defp parse__199(
         <<"INTERVAL", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__200(rest, ["INTERVAL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__199(rest, acc, stack, context, line, offset) do
    parse__198(rest, acc, stack, context, line, offset)
  end

  defp parse__200(rest, acc, stack, context, line, offset) do
    parse__201(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__201(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__202(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__201(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__198(rest, acc, stack, context, line, offset)
  end

  defp parse__202(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__204(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__202(rest, acc, stack, context, line, offset) do
    parse__203(rest, acc, stack, context, line, offset)
  end

  defp parse__204(rest, acc, stack, context, line, offset) do
    parse__202(rest, acc, stack, context, line, offset)
  end

  defp parse__203(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__205(
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

  defp parse__205(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__206(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__199(rest, [], stack, context, line, offset)
  end

  defp parse__207(<<"COUNT", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__208(rest, ["COUNT"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__207(rest, acc, stack, context, line, offset) do
    parse__206(rest, acc, stack, context, line, offset)
  end

  defp parse__208(rest, acc, stack, context, line, offset) do
    parse__209(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__209(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__210(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__209(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__206(rest, acc, stack, context, line, offset)
  end

  defp parse__210(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__212(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__210(rest, acc, stack, context, line, offset) do
    parse__211(rest, acc, stack, context, line, offset)
  end

  defp parse__212(rest, acc, stack, context, line, offset) do
    parse__210(rest, acc, stack, context, line, offset)
  end

  defp parse__211(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__213(
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

  defp parse__213(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__214(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__207(rest, [], stack, context, line, offset)
  end

  defp parse__215(<<"UNTIL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__216(rest, ["UNTIL"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__215(rest, acc, stack, context, line, offset) do
    parse__214(rest, acc, stack, context, line, offset)
  end

  defp parse__216(rest, acc, stack, context, line, offset) do
    parse__217(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__217(rest, acc, stack, context, line, offset) do
    parse__224(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__219(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__220(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__219(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__214(rest, acc, stack, context, line, offset)
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

  defp parse__220(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__214(rest, acc, stack, context, line, offset)
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

  defp parse__221(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__222(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__221(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__214(rest, acc, stack, context, line, offset)
  end

  defp parse__222(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__218(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__223(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__219(rest, [], stack, context, line, offset)
  end

  defp parse__224(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__225(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__224(rest, acc, stack, context, line, offset) do
    parse__223(rest, acc, stack, context, line, offset)
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

  defp parse__225(rest, acc, stack, context, line, offset) do
    parse__223(rest, acc, stack, context, line, offset)
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

  defp parse__226(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__227(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__226(rest, acc, stack, context, line, offset) do
    parse__223(rest, acc, stack, context, line, offset)
  end

  defp parse__227(<<"T", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__228(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__227(rest, acc, stack, context, line, offset) do
    parse__223(rest, acc, stack, context, line, offset)
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

  defp parse__228(rest, acc, stack, context, line, offset) do
    parse__223(rest, acc, stack, context, line, offset)
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
    parse__230(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__223(rest, acc, stack, context, line, offset)
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
    parse__231(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__223(rest, acc, stack, context, line, offset)
  end

  defp parse__231(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__218(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__218(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__232(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__232(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__121(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__233(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__215(rest, [], stack, context, line, offset)
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
