# Generated from lib/calendar_recurrence/rrule_parser.ex.exs, do not edit.
# Generated at 2023-06-16 16:44:47Z.

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
    parse__82(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
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
    parse__17(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__16(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__16(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__17(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 1)
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
    parse__21(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__20(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__20(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__21(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 1)
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
    parse__28(rest, ';' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ':' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '9' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '8' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '7' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '6' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '5' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '4' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '3' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '2' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '1' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '0' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '/' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '.' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '-' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ',' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '+' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '*' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ')' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '(' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '\'' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '&' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '%' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '$' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '#' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '!' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, ' ' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__28(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__28(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__27(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__27(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__27(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__28(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 1)
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
    parse__32(rest, ';' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ':' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '9' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '8' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '7' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '6' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '5' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '4' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '3' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '2' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '1' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '0' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '/' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '.' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '-' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ',' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '+' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '*' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ')' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '(' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '\'' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '&' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '%' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '$' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '#' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '!' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, ' ' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__32(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__32(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__31(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__31(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__31(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__32(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 1)
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
    parse__39(rest, ';' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ':' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '9' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '8' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '7' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '6' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '5' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '4' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '3' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '2' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '1' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '0' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '/' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '.' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '-' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ',' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '+' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '*' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ')' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '(' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '\'' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '&' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '%' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '$' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '#' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '!' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, ' ' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__39(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__39(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__38(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__38(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__39(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 1)
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
    parse__43(rest, ';' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ':' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '9' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '8' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '7' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '6' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '5' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '4' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '3' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '2' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '1' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '0' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '/' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '.' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '-' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ',' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '+' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '*' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ')' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '(' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '\'' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '&' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '%' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '$' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '#' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '!' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, ' ' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__43(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__43(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__42(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__42(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__43(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 1)
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
    parse__69(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__68(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__69(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__70(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__69(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__70(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__70(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__74(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__73(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__74(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__75(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__74(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__75(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__75(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__77(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__76(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__77(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__78(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__78(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__78(rest, ' ' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '!' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '#' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '$' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '%' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '&' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '\'' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '(' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ')' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '*' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '+' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ',' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '-' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '.' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '/' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '0' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '1' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '2' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '3' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '4' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '5' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '6' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '7' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '8' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, '9' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ':' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__77(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__78(rest, ';' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__79(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__79(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__79(rest, ' ' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '!' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '#' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '$' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '%' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '&' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '\'' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '(' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ')' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '*' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '+' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ',' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '-' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '.' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '/' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '0' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '1' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '2' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '3' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '4' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '5' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '6' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '7' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '8' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, '9' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ':' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__79(rest, ';' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__78(rest, acc, stack, context, line, offset) do
    parse__71(rest, acc, stack, context, line, offset)
  end

  defp parse__79(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__66(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__66(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__80(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__80(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__81(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__63(rest, [], stack, context, line, offset)
  end

  defp parse__82(<<"FREQ", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__83(rest, ["FREQ"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__82(rest, acc, stack, context, line, offset) do
    parse__81(rest, acc, stack, context, line, offset)
  end

  defp parse__83(<<"SECONDLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ["SECONDLY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__83(<<"MINUTELY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ["MINUTELY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__83(<<"HOURLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ["HOURLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__83(<<"DAILY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ["DAILY"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__83(<<"WEEKLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ["WEEKLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__83(<<"MONTHLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ["MONTHLY"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__83(<<"YEARLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__84(rest, ["YEARLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__83(rest, acc, stack, context, line, offset) do
    parse__81(rest, acc, stack, context, line, offset)
  end

  defp parse__84(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__2(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__2(rest, acc, stack, context, line, offset) do
    parse__86(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__86(<<";", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__87(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__86(rest, acc, stack, context, line, offset) do
    parse__85(rest, acc, stack, context, line, offset)
  end

  defp parse__87(rest, acc, stack, context, line, offset) do
    parse__168(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__89(<<"BYDAY", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__90(rest, ["BYDAY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__89(rest, _acc, stack, context, line, offset) do
    [_, acc | stack] = stack
    parse__85(rest, acc, stack, context, line, offset)
  end

  defp parse__90(rest, acc, stack, context, line, offset) do
    parse__91(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__91(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__92(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__91(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__85(rest, acc, stack, context, line, offset)
  end

  defp parse__92(rest, acc, stack, context, line, offset) do
    parse__94(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__94(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__95(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__94(rest, acc, stack, context, line, offset) do
    parse__93(rest, acc, stack, context, line, offset)
  end

  defp parse__95(<<"SU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ["SU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"MO", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ["MO"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"TU", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ["TU"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"WE", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ["WE"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"TH", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ["TH"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"FR", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ["FR"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(<<"SA", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__96(rest, ["SA"] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__95(rest, acc, stack, context, line, offset) do
    parse__93(rest, acc, stack, context, line, offset)
  end

  defp parse__93(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__97(rest, acc, stack, context, line, offset)
  end

  defp parse__96(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__94(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__97(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__98(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__98(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__88(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__99(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__89(rest, [], stack, context, line, offset)
  end

  defp parse__100(<<"BYHOUR", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__101(rest, ["BYHOUR"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__100(rest, acc, stack, context, line, offset) do
    parse__99(rest, acc, stack, context, line, offset)
  end

  defp parse__101(rest, acc, stack, context, line, offset) do
    parse__102(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__102(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__102(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__102(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__102(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__102(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__102(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__102(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__102(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__102(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__102(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__102(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__103(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__102(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__99(rest, acc, stack, context, line, offset)
  end

  defp parse__103(rest, acc, stack, context, line, offset) do
    parse__105(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__105(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__106(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__105(rest, acc, stack, context, line, offset) do
    parse__104(rest, acc, stack, context, line, offset)
  end

  defp parse__106(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__106(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__106(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__106(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__106(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__106(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__106(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__106(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__106(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__106(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__106(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__107(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__106(rest, acc, stack, context, line, offset) do
    parse__104(rest, acc, stack, context, line, offset)
  end

  defp parse__104(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__108(rest, acc, stack, context, line, offset)
  end

  defp parse__107(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__105(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__108(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__109(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__109(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__88(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__110(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__100(rest, [], stack, context, line, offset)
  end

  defp parse__111(
         <<"BYMINUTE", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__112(rest, ["BYMINUTE"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__111(rest, acc, stack, context, line, offset) do
    parse__110(rest, acc, stack, context, line, offset)
  end

  defp parse__112(rest, acc, stack, context, line, offset) do
    parse__113(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__113(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, ';' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, ':' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '9' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '8' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '7' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '6' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '5' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '4' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '3' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '2' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '1' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '0' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '/' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '.' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '-' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, ',' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '+' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '*' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, ')' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '(' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '\'' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '&' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '%' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '$' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '#' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '!' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, ' ' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__113(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__113(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__113(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__113(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__113(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__113(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__113(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__113(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__113(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__113(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__114(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__113(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__110(rest, acc, stack, context, line, offset)
  end

  defp parse__114(rest, acc, stack, context, line, offset) do
    parse__116(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__116(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__117(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__116(rest, acc, stack, context, line, offset) do
    parse__115(rest, acc, stack, context, line, offset)
  end

  defp parse__117(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, ';' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, ':' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '9' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '8' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '7' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '6' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '5' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '4' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '3' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '2' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '1' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '0' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '/' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '.' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '-' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, ',' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '+' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '*' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, ')' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '(' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '\'' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '&' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '%' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '$' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '#' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '!' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, ' ' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__117(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__117(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__117(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__117(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__117(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__117(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__117(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__117(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__117(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__117(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__118(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__117(rest, acc, stack, context, line, offset) do
    parse__115(rest, acc, stack, context, line, offset)
  end

  defp parse__115(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__119(rest, acc, stack, context, line, offset)
  end

  defp parse__118(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__116(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__119(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__120(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__120(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__88(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__121(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__111(rest, [], stack, context, line, offset)
  end

  defp parse__122(
         <<"BYSECOND", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__123(rest, ["BYSECOND"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__122(rest, acc, stack, context, line, offset) do
    parse__121(rest, acc, stack, context, line, offset)
  end

  defp parse__123(rest, acc, stack, context, line, offset) do
    parse__124(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__124(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ';' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ':' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '9' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '8' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '7' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '6' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '5' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '4' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '3' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '2' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '1' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '0' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '/' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '.' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '-' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ',' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '+' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '*' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ')' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '(' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '\'' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '&' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '%' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '$' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '#' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '!' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, ' ' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__124(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__125(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__124(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__121(rest, acc, stack, context, line, offset)
  end

  defp parse__125(rest, acc, stack, context, line, offset) do
    parse__127(rest, [], [{rest, acc, context, line, offset} | stack], context, line, offset)
  end

  defp parse__127(<<",", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__128(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__127(rest, acc, stack, context, line, offset) do
    parse__126(rest, acc, stack, context, line, offset)
  end

  defp parse__128(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ';' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ':' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '9' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '8' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '7' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '6' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '5' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '4' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '3' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '2' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '1' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '0' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '/' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '.' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '-' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ',' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '+' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '*' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ')' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '(' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '\'' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '&' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '%' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '$' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '#' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '!' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, ' ' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__128(<<"9", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"8", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"7", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"6", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"5", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"4", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"3", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"2", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"1", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(<<"0", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__129(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__128(rest, acc, stack, context, line, offset) do
    parse__126(rest, acc, stack, context, line, offset)
  end

  defp parse__126(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__130(rest, acc, stack, context, line, offset)
  end

  defp parse__129(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__127(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__130(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__131(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__131(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__88(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__132(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__122(rest, [], stack, context, line, offset)
  end

  defp parse__133(
         <<"INTERVAL", "=", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       ) do
    parse__134(rest, ["INTERVAL"] ++ acc, stack, context, comb__line, comb__offset + 9)
  end

  defp parse__133(rest, acc, stack, context, line, offset) do
    parse__132(rest, acc, stack, context, line, offset)
  end

  defp parse__134(rest, acc, stack, context, line, offset) do
    parse__135(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__135(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__136(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__135(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__132(rest, acc, stack, context, line, offset)
  end

  defp parse__136(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__138(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__136(rest, acc, stack, context, line, offset) do
    parse__137(rest, acc, stack, context, line, offset)
  end

  defp parse__138(rest, acc, stack, context, line, offset) do
    parse__136(rest, acc, stack, context, line, offset)
  end

  defp parse__137(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__139(
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

  defp parse__139(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__88(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__140(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__133(rest, [], stack, context, line, offset)
  end

  defp parse__141(<<"COUNT", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__142(rest, ["COUNT"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__141(rest, acc, stack, context, line, offset) do
    parse__140(rest, acc, stack, context, line, offset)
  end

  defp parse__142(rest, acc, stack, context, line, offset) do
    parse__143(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__143(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__144(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__143(rest, _acc, stack, context, line, offset) do
    [acc | stack] = stack
    parse__140(rest, acc, stack, context, line, offset)
  end

  defp parse__144(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    parse__146(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__144(rest, acc, stack, context, line, offset) do
    parse__145(rest, acc, stack, context, line, offset)
  end

  defp parse__146(rest, acc, stack, context, line, offset) do
    parse__144(rest, acc, stack, context, line, offset)
  end

  defp parse__145(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    parse__147(
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

  defp parse__147(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__88(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__148(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__141(rest, [], stack, context, line, offset)
  end

  defp parse__149(<<"UNTIL", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__150(rest, ["UNTIL"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__149(rest, acc, stack, context, line, offset) do
    parse__148(rest, acc, stack, context, line, offset)
  end

  defp parse__150(rest, acc, stack, context, line, offset) do
    parse__151(rest, [], [acc | stack], context, line, offset)
  end

  defp parse__151(rest, acc, stack, context, line, offset) do
    parse__158(rest, [], [{rest, context, line, offset}, acc | stack], context, line, offset)
  end

  defp parse__153(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__154(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__153(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__148(rest, acc, stack, context, line, offset)
  end

  defp parse__154(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__155(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__154(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__148(rest, acc, stack, context, line, offset)
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
    parse__156(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__156(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__155(rest, _acc, stack, context, line, offset) do
    [_, _, acc | stack] = stack
    parse__148(rest, acc, stack, context, line, offset)
  end

  defp parse__156(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__152(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__157(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__153(rest, [], stack, context, line, offset)
  end

  defp parse__158(<<x0, x1, x2, x3, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) do
    parse__159(
      rest,
      [x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 4
    )
  end

  defp parse__158(rest, acc, stack, context, line, offset) do
    parse__157(rest, acc, stack, context, line, offset)
  end

  defp parse__159(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__160(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__159(rest, acc, stack, context, line, offset) do
    parse__157(rest, acc, stack, context, line, offset)
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
    parse__161(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__161(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__160(rest, acc, stack, context, line, offset) do
    parse__157(rest, acc, stack, context, line, offset)
  end

  defp parse__161(<<"T", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__162(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp parse__161(rest, acc, stack, context, line, offset) do
    parse__157(rest, acc, stack, context, line, offset)
  end

  defp parse__162(<<"00", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [0] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"01", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"02", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"03", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"04", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"05", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"06", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"07", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"14", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [14] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"15", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [15] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"16", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [16] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"17", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [17] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"18", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [18] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"19", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [19] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"20", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [20] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"21", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [21] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"22", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [22] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(<<"23", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__163(rest, [23] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__162(rest, acc, stack, context, line, offset) do
    parse__157(rest, acc, stack, context, line, offset)
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
    parse__164(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
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

  defp parse__163(<<"24", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [24] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"25", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [25] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"26", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [26] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"27", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"28", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [28] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"29", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [29] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"30", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [30] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"31", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, [31] ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"32", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, ' ' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '!' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '#' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '$' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '%' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '&' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '\'' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '(' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, ')' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '*' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '+' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, ',' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '-' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '.' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '/' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '0' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '1' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '2' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '3' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '4' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '5' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '6' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '7' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '8' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, '9' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, ':' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__164(rest, ';' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__163(rest, acc, stack, context, line, offset) do
    parse__157(rest, acc, stack, context, line, offset)
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
    parse__165(rest, '\a' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"08", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '\b' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"09", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '\t' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"10", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '\n' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"11", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '\v' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"12", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '\f' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"13", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '\r' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__165(rest, '\e' ++ acc, stack, context, comb__line, comb__offset + 2)
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
    parse__165(rest, ' ' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"33", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '!' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"34", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '"' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"35", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '#' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"36", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '$' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"37", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '%' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"38", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '&' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"39", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '\'' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"40", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '(' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"41", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ')' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"42", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '*' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"43", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '+' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"44", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ',' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"45", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '-' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"46", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '.' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"47", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '/' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"48", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '0' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"49", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '1' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"50", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '2' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"51", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '3' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"52", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '4' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"53", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '5' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"54", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '6' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"55", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '7' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"56", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '8' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"57", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, '9' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"58", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ':' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(<<"59", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__165(rest, ';' ++ acc, stack, context, comb__line, comb__offset + 2)
  end

  defp parse__164(rest, acc, stack, context, line, offset) do
    parse__157(rest, acc, stack, context, line, offset)
  end

  defp parse__165(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__152(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__152(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__166(rest, [:lists.reverse(user_acc)] ++ acc, stack, context, line, offset)
  end

  defp parse__166(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__88(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__167(_, _, [{rest, context, line, offset} | _] = stack, _, _, _) do
    parse__149(rest, [], stack, context, line, offset)
  end

  defp parse__168(<<"FREQ", "=", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__169(rest, ["FREQ"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__168(rest, acc, stack, context, line, offset) do
    parse__167(rest, acc, stack, context, line, offset)
  end

  defp parse__169(<<"SECONDLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ["SECONDLY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__169(<<"MINUTELY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ["MINUTELY"] ++ acc, stack, context, comb__line, comb__offset + 8)
  end

  defp parse__169(<<"HOURLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ["HOURLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__169(<<"DAILY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ["DAILY"] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp parse__169(<<"WEEKLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ["WEEKLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__169(<<"MONTHLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ["MONTHLY"] ++ acc, stack, context, comb__line, comb__offset + 7)
  end

  defp parse__169(<<"YEARLY", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    parse__170(rest, ["YEARLY"] ++ acc, stack, context, comb__line, comb__offset + 6)
  end

  defp parse__169(rest, acc, stack, context, line, offset) do
    parse__167(rest, acc, stack, context, line, offset)
  end

  defp parse__170(rest, acc, [_, previous_acc | stack], context, line, offset) do
    parse__88(rest, acc ++ previous_acc, stack, context, line, offset)
  end

  defp parse__85(_, _, [{rest, acc, context, line, offset} | stack], _, _, _) do
    parse__171(rest, acc, stack, context, line, offset)
  end

  defp parse__88(
         inner_rest,
         inner_acc,
         [{rest, acc, context, line, offset} | stack],
         inner_context,
         inner_line,
         inner_offset
       ) do
    _ = {rest, acc, context, line, offset}

    parse__86(
      inner_rest,
      [],
      [{inner_rest, inner_acc ++ acc, inner_context, inner_line, inner_offset} | stack],
      inner_context,
      inner_line,
      inner_offset
    )
  end

  defp parse__171(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc
    parse__172(rest, [to_map(:lists.reverse(user_acc))] ++ acc, stack, context, line, offset)
  end

  defp parse__172(rest, acc, _stack, context, line, offset) do
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
