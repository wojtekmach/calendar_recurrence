# Generated from lib/calendar_recurrence/rrule_parser.ex.exs, do not edit.
# Generated at 2024-06-20 01:16:37Z.

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
    parse__83(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__3(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__4(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__3(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"FREQ\", followed by string \"=\", followed by string \"SECONDLY\" or string \"MINUTELY\" or string \"HOURLY\" or string \"DAILY\" or string \"WEEKLY\" or string \"MONTHLY\" or string \"YEARLY\" or string \"UNTIL\", followed by string \"=\", followed by datetime or date or string \"COUNT\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"INTERVAL\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYSECOND\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYMINUTE\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYHOUR\", followed by string \"=\", followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYDAY\", followed by string \"=\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\"",
     rest, context, line, offset}
  end

  defp parse__4(rest, acc, stack, context, line, offset) do
    parse__5(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__5(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__6(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__5(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"FREQ\", followed by string \"=\", followed by string \"SECONDLY\" or string \"MINUTELY\" or string \"HOURLY\" or string \"DAILY\" or string \"WEEKLY\" or string \"MONTHLY\" or string \"YEARLY\" or string \"UNTIL\", followed by string \"=\", followed by datetime or date or string \"COUNT\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"INTERVAL\", followed by string \"=\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or string \"BYSECOND\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYMINUTE\", followed by string \"=\", followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"59\" or string \"58\" or string \"57\" or string \"56\" or string \"55\" or string \"54\" or string \"53\" or string \"52\" or string \"51\" or string \"50\" or string \"49\" or string \"48\" or string \"47\" or string \"46\" or string \"45\" or string \"44\" or string \"43\" or string \"42\" or string \"41\" or string \"40\" or string \"39\" or string \"38\" or string \"37\" or string \"36\" or string \"35\" or string \"34\" or string \"33\" or string \"32\" or string \"31\" or string \"30\" or string \"29\" or string \"28\" or string \"27\" or string \"26\" or string \"25\" or string \"24\" or string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYHOUR\", followed by string \"=\", followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\", followed by ,, followed by string \"23\" or string \"22\" or string \"21\" or string \"20\" or string \"19\" or string \"18\" or string \"17\" or string \"16\" or string \"15\" or string \"14\" or string \"13\" or string \"12\" or string \"11\" or string \"10\" or string \"9\" or string \"8\" or string \"7\" or string \"6\" or string \"5\" or string \"4\" or string \"3\" or string \"2\" or string \"1\" or string \"0\" or string \"BYDAY\", followed by string \"=\", followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\", followed by ,, followed by string \"SU\" or string \"MO\" or string \"TU\" or string \"WE\" or string \"TH\" or string \"FR\" or string \"SA\"",
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

  defp parse__9(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__9(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__10(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__14(<<"BYHOUR", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__15(rest, ["BYHOUR"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__14(rest, acc, stack, context, line, offset) do
    parse__13(rest, acc, stack, context, line, offset)
  end

  defp parse__15(rest, acc, stack, context, line, offset) do
    parse__16(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__16(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
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

  defp parse__20(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
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

  defp parse__25(<<"BYMINUTE", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__26(rest, ["BYMINUTE"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__25(rest, acc, stack, context, line, offset) do
    parse__24(rest, acc, stack, context, line, offset)
  end

  defp parse__26(rest, acc, stack, context, line, offset) do
    parse__27(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__27(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__27(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__27(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__27(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__27(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__27(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__27(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__27(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__27(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__27(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
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

  defp parse__31(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__31(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__31(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__31(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__31(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__31(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__31(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__31(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__31(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__31(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
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

  defp parse__36(<<"BYSECOND", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__37(rest, ["BYSECOND"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__36(rest, acc, stack, context, line, offset) do
    parse__35(rest, acc, stack, context, line, offset)
  end

  defp parse__37(rest, acc, stack, context, line, offset) do
    parse__38(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__38(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__42(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__47(<<"INTERVAL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__48(rest, ["INTERVAL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__47(rest, acc, stack, context, line, offset) do
    parse__46(rest, acc, stack, context, line, offset)
  end

  defp parse__48(rest, acc, stack, context, line, offset) do
    parse__49(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__49(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__50(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__49(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__46(rest, acc, stack, context, line, offset)
  end

  defp parse__50(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__52(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__50(rest, acc, stack, context, line, offset) do
    parse__51(rest, acc, stack, context, line, offset)
  end

  defp parse__52(rest, acc, stack, context, line, offset) do
    parse__50(rest, acc, stack, context, line, offset)
  end

  defp parse__51(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__53(
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

  defp parse__53(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__54(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__47(rest, [], stack, context, line, offset)
  end

  defp parse__55(<<"COUNT", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__56(rest, ["COUNT"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__55(rest, acc, stack, context, line, offset) do
    parse__54(rest, acc, stack, context, line, offset)
  end

  defp parse__56(rest, acc, stack, context, line, offset) do
    parse__57(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__57(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__58(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__57(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__54(rest, acc, stack, context, line, offset)
  end

  defp parse__58(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__60(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__58(rest, acc, stack, context, line, offset) do
    parse__59(rest, acc, stack, context, line, offset)
  end

  defp parse__60(rest, acc, stack, context, line, offset) do
    parse__58(rest, acc, stack, context, line, offset)
  end

  defp parse__59(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__61(
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

  defp parse__61(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__62(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__55(rest, [], stack, context, line, offset)
  end

  defp parse__63(<<"UNTIL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__64(rest, ["UNTIL"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__63(rest, acc, stack, context, line, offset) do
    parse__62(rest, acc, stack, context, line, offset)
  end

  defp parse__64(rest, acc, stack, context, line, offset) do
    parse__65(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__65(rest, acc, stack, context, line, offset) do
    parse__72(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__67(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__68(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__67(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__62(rest, acc, stack, context, line, offset)
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

  defp parse__68(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__62(rest, acc, stack, context, line, offset)
  end

  defp parse__69(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__62(rest, acc, stack, context, line, offset)
  end

  defp parse__70(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__66(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__71(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__67(rest, [], stack, context, line, offset)
  end

  defp parse__72(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__73(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__72(rest, acc, stack, context, line, offset) do
    parse__71(rest, acc, stack, context, line, offset)
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

  defp parse__73(rest, acc, stack, context, line, offset) do
    parse__71(rest, acc, stack, context, line, offset)
  end

  defp parse__74(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(rest, acc, stack, context, line, offset) do
    parse__71(rest, acc, stack, context, line, offset)
  end

  defp parse__75(<<"T", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__76(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__75(rest, acc, stack, context, line, offset) do
    parse__71(rest, acc, stack, context, line, offset)
  end

  defp parse__76(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(rest, acc, stack, context, line, offset) do
    parse__71(rest, acc, stack, context, line, offset)
  end

  defp parse__77(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(rest, acc, stack, context, line, offset) do
    parse__71(rest, acc, stack, context, line, offset)
  end

  defp parse__78(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(rest, acc, stack, context, line, offset) do
    parse__71(rest, acc, stack, context, line, offset)
  end

  defp parse__79(<<"Z", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, ["Z"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__79(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__80(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__80(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__66(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__66(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__81(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__81(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__82(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__63(rest, [], stack, context, line, offset)
  end

  defp parse__83(<<"FREQ", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ["FREQ"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__83(rest, acc, stack, context, line, offset) do
    parse__82(rest, acc, stack, context, line, offset)
  end

  defp parse__84(<<"SECONDLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__85(rest, ["SECONDLY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__84(<<"MINUTELY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__85(rest, ["MINUTELY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__84(<<"HOURLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__85(rest, ["HOURLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__84(<<"DAILY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__85(rest, ["DAILY"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__84(<<"WEEKLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__85(rest, ["WEEKLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__84(<<"MONTHLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__85(rest, ["MONTHLY"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__84(<<"YEARLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__85(rest, ["YEARLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__84(rest, acc, stack, context, line, offset) do
    parse__82(rest, acc, stack, context, line, offset)
  end

  defp parse__85(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__2(rest, acc, stack, context, line, offset) do
    parse__87(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__87(<<";", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__88(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__87(rest, acc, stack, context, line, offset) do
    parse__86(rest, acc, stack, context, line, offset)
  end

  defp parse__88(rest, acc, stack, context, line, offset) do
    parse__170(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__90(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__91(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__90(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse__86(rest, acc, stack, context, line, offset)
  end

  defp parse__91(rest, acc, stack, context, line, offset) do
    parse__92(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__92(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__93(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__92(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__93(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__92(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__93(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__92(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__93(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__92(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__93(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__92(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__93(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__92(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__93(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__92(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__86(rest, acc, stack, context, line, offset)
  end

  defp parse__93(rest, acc, stack, context, line, offset) do
    parse__95(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__95(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__95(rest, acc, stack, context, line, offset) do
    parse__94(rest, acc, stack, context, line, offset)
  end

  defp parse__96(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__97(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__96(rest, acc, stack, context, line, offset) do
    parse__94(rest, acc, stack, context, line, offset)
  end

  defp parse__94(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__98(rest, acc, stack, context, line, offset)
  end

  defp parse__97(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__95(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__98(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__99(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__99(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__89(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__100(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__90(rest, [], stack, context, line, offset)
  end

  defp parse__101(<<"BYHOUR", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__102(rest, ["BYHOUR"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__101(rest, acc, stack, context, line, offset) do
    parse__100(rest, acc, stack, context, line, offset)
  end

  defp parse__102(rest, acc, stack, context, line, offset) do
    parse__103(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__103(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__103(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__103(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__103(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__103(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__103(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__103(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__103(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__103(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__103(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__103(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__104(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__103(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__100(rest, acc, stack, context, line, offset)
  end

  defp parse__104(rest, acc, stack, context, line, offset) do
    parse__106(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__106(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__106(rest, acc, stack, context, line, offset) do
    parse__105(rest, acc, stack, context, line, offset)
  end

  defp parse__107(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__107(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__107(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__107(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__107(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__107(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__107(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__107(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__107(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__107(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__107(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__108(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__107(rest, acc, stack, context, line, offset) do
    parse__105(rest, acc, stack, context, line, offset)
  end

  defp parse__105(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__109(rest, acc, stack, context, line, offset)
  end

  defp parse__108(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__106(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__109(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__110(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__110(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__89(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__111(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__101(rest, [], stack, context, line, offset)
  end

  defp parse__112(
         <<"BYMINUTE", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__113(rest, ["BYMINUTE"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__112(rest, acc, stack, context, line, offset) do
    parse__111(rest, acc, stack, context, line, offset)
  end

  defp parse__113(rest, acc, stack, context, line, offset) do
    parse__114(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__114(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__114(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__115(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__114(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__111(rest, acc, stack, context, line, offset)
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

  defp parse__118(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__118(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__118(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__119(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
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
    parse__89(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__122(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__112(rest, [], stack, context, line, offset)
  end

  defp parse__123(
         <<"BYSECOND", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__124(rest, ["BYSECOND"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__123(rest, acc, stack, context, line, offset) do
    parse__122(rest, acc, stack, context, line, offset)
  end

  defp parse__124(rest, acc, stack, context, line, offset) do
    parse__125(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__125(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__125(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__125(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__126(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
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

  defp parse__132(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__89(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__133(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__123(rest, [], stack, context, line, offset)
  end

  defp parse__134(
         <<"INTERVAL", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__135(rest, ["INTERVAL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__134(rest, acc, stack, context, line, offset) do
    parse__133(rest, acc, stack, context, line, offset)
  end

  defp parse__135(rest, acc, stack, context, line, offset) do
    parse__136(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__136(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__137(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__136(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__133(rest, acc, stack, context, line, offset)
  end

  defp parse__137(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__139(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__137(rest, acc, stack, context, line, offset) do
    parse__138(rest, acc, stack, context, line, offset)
  end

  defp parse__139(rest, acc, stack, context, line, offset) do
    parse__137(rest, acc, stack, context, line, offset)
  end

  defp parse__138(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__140(
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

  defp parse__140(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__89(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__141(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__134(rest, [], stack, context, line, offset)
  end

  defp parse__142(<<"COUNT", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__143(rest, ["COUNT"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__142(rest, acc, stack, context, line, offset) do
    parse__141(rest, acc, stack, context, line, offset)
  end

  defp parse__143(rest, acc, stack, context, line, offset) do
    parse__144(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__144(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__145(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__144(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__141(rest, acc, stack, context, line, offset)
  end

  defp parse__145(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__147(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__145(rest, acc, stack, context, line, offset) do
    parse__146(rest, acc, stack, context, line, offset)
  end

  defp parse__147(rest, acc, stack, context, line, offset) do
    parse__145(rest, acc, stack, context, line, offset)
  end

  defp parse__146(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__148(
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

  defp parse__148(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__89(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__149(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__142(rest, [], stack, context, line, offset)
  end

  defp parse__150(<<"UNTIL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__151(rest, ["UNTIL"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__150(rest, acc, stack, context, line, offset) do
    parse__149(rest, acc, stack, context, line, offset)
  end

  defp parse__151(rest, acc, stack, context, line, offset) do
    parse__152(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__152(rest, acc, stack, context, line, offset) do
    parse__159(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__154(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__155(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__154(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__149(rest, acc, stack, context, line, offset)
  end

  defp parse__155(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
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
    [_, _, acc | stack] = stack
    parse__149(rest, acc, stack, context, line, offset)
  end

  defp parse__156(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__157(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__156(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__149(rest, acc, stack, context, line, offset)
  end

  defp parse__157(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__153(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__158(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__154(rest, [], stack, context, line, offset)
  end

  defp parse__159(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__160(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__159(rest, acc, stack, context, line, offset) do
    parse__158(rest, acc, stack, context, line, offset)
  end

  defp parse__160(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(rest, acc, stack, context, line, offset) do
    parse__158(rest, acc, stack, context, line, offset)
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

  defp parse__161(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__161(rest, acc, stack, context, line, offset) do
    parse__158(rest, acc, stack, context, line, offset)
  end

  defp parse__162(<<"T", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__162(rest, acc, stack, context, line, offset) do
    parse__158(rest, acc, stack, context, line, offset)
  end

  defp parse__163(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(rest, acc, stack, context, line, offset) do
    parse__158(rest, acc, stack, context, line, offset)
  end

  defp parse__164(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(rest, acc, stack, context, line, offset) do
    parse__158(rest, acc, stack, context, line, offset)
  end

  defp parse__165(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"\r" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"\e" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c" " ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"!" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c'"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"#" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"$" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"%" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"&" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"'" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"(" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c")" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"*" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"+" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"," ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"-" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"." ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"/" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"0" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"1" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"2" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"3" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"4" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"5" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"6" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"7" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"8" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c"9" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c":" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__166(rest, ~c";" ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__165(rest, acc, stack, context, line, offset) do
    parse__158(rest, acc, stack, context, line, offset)
  end

  defp parse__166(<<"Z", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, ["Z"] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__166(<<rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__167(rest, [] ++ acc, stack, context, comb__line, comb__offset)
  end

  defp parse__167(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__153(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__153(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__168(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__168(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__89(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__169(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__150(rest, [], stack, context, line, offset)
  end

  defp parse__170(<<"FREQ", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__171(rest, ["FREQ"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__170(rest, acc, stack, context, line, offset) do
    parse__169(rest, acc, stack, context, line, offset)
  end

  defp parse__171(<<"SECONDLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__172(rest, ["SECONDLY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__171(<<"MINUTELY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__172(rest, ["MINUTELY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__171(<<"HOURLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__172(rest, ["HOURLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__171(<<"DAILY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__172(rest, ["DAILY"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__171(<<"WEEKLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__172(rest, ["WEEKLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__171(<<"MONTHLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__172(rest, ["MONTHLY"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__171(<<"YEARLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__172(rest, ["YEARLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__171(rest, acc, stack, context, line, offset) do
    parse__169(rest, acc, stack, context, line, offset)
  end

  defp parse__172(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__89(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__86(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__173(rest, acc, stack, context, line, offset)
  end

  defp parse__89(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__87(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__173(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__174(rest, [to_map(:lists.reverse(user_acc))] ++ acc, stack, context, line, offset)
  end

  defp parse__174(rest, acc, _stack, context, line, offset) do
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

  defp cast_value(_, value), do: value

  defp cast_byday("SU"), do: 7
  defp cast_byday("MO"), do: 1
  defp cast_byday("TU"), do: 2
  defp cast_byday("WE"), do: 3
  defp cast_byday("TH"), do: 4
  defp cast_byday("FR"), do: 5
  defp cast_byday("SA"), do: 6
end
