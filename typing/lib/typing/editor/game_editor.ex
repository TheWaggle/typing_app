defmodule Typing.Editor.GameEditor do
  import Typing.Utils.KeysDecision
  alias Typing.Utils.Execution

  defstruct input_char: "",
            display_char: "",
            char_count: 0,
            now_char_count: 0,
            failure_count: 0,
            game_status: 0,
            char_list: [],
            clear_count: 0,
            result: nil

  # game_status
  # 0・・・ゲーム停止
  # 1・・・ゲーム実行中
  # 2・・・Enter入力待ち

  def construct() do
    char_list =
      [
        "Enum.map([1, 2, 3], fn a -> a * 2 end)",
        "Enum.shuffle([1, 2, 3])",
        "Enum.reverse([1, 2, 3])",
        "Enum.map([1, 2, 3])",
        "Map.put(%{a: \"a\", b: \"b\", c: \"c\"}, :d, \"b\")",
        "Enum.map([1, 2, 3], fn a -> a * 2 end)|> Enum.shuffle()"
      ]

    display_char = hd(char_list)

    %__MODULE__{
      display_char: display_char,
      char_count: String.length(display_char),
      game_status: 1,
      char_list: char_list
    }
  end

  @exclusion_key ~w(
    Tab
    Control
    Shift
    CapsLock
    Alt
    Meta
    Eisu
    KanjiMode
    Backspace
    Enter
    Escape
    ArrowLeft
    ArrowRight
    ArrowUp
    ArrowDown
  )

  def update(%__MODULE__{display_char: char, now_char_count: count} = editor, "input_key", %{"key" => key})
      when key not in @exclusion_key and key_check(char, count, key) and editor.game_status == 1 do
    cond do
      editor.now_char_count == editor.char_count - 1 ->
        display_result(editor, key)

      true ->
        %{editor | input_char: editor.input_char <> key, now_char_count: editor.now_char_count + 1}
    end
  end

  def update(%__MODULE__{} = editor, "input_key", %{"key" => key})
      when key not in @exclusion_key and editor.game_status == 1 do
    %{editor | failure_count: editor.failure_count + 1}
  end

  def update(%__MODULE__{} = editor, "input_key", %{"key" => key})
      when key == "Enter" and editor.game_status == 2 do
    next_char(editor, key)
  end

  def update(%__MODULE__{} = editor, "input_key", _params), do: editor

  # 次の表示文字を割り当てます。その際リストに文字列がなければゲームクリアの状態にします。
  defp next_char(editor, key) do
    char_list = List.delete(editor.char_list, editor.display_char)

    case length(char_list) do
      0 ->
        %{
          editor
          | char_list: char_list,
            display_char: "クリア",
            input_char: editor.input_char <> key,
            game_status: 0,
            result: nil
        }

      _num ->
        display_char = hd(char_list)

        %{
          editor
          | char_list: char_list,
            display_char: display_char,
            input_char: "",
            char_count: String.length(display_char),
            now_char_count: 0,
            game_status: 1,
            result: nil
        }
    end
  end

  defp display_result(editor, key) do
    result =
      case Execution.execution(editor.display_char) do
        {r, _} -> r
        error -> error
      end
    %{
      editor
      | result: result,
        game_status: 2,
        input_char: editor.input_char <> key,
        clear_count: editor.clear_count + 1
    }
  end
end
