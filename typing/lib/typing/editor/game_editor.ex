defmodule Typing.Editor.GameEditor do
  import Typing.Utils.KeysDecision

  defstruct input_char: "",
            display_char: "",
            char_count: 0,
            now_char_count: 0,
            failure_count: 0,
            game_status: 0,
            char_list: [],
            clear_count: 0,
            timer: 0

  # game_status
  # 0・・・ゲーム停止
  # 1・・・ゲーム実行中

  def construct() do
    char_list = ~w(HelloWorld!! Elixir Phoenix Docker Windows)
    display_char = hd(char_list)

    %__MODULE__{
      display_char: display_char,
      char_count: String.length(display_char),
      game_status: 1,
      char_list: char_list,
      timer: 60
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
  ) ++ [" "]

  def update(%__MODULE__{display_char: char, now_char_count: count} = editor, "input_key", %{"key" => key})
      when key not in @exclusion_key and key_check(char, count, key) and editor.game_status == 1 do
    cond do
      editor.now_char_count == editor.char_count - 1 ->
        next_char(editor, key)

      true ->
        %{editor | input_char: editor.input_char <> key, now_char_count: editor.now_char_count + 1}
    end
  end

  # タイプミスした時
  def update(%__MODULE__{} = editor, "input_key", %{"key" => key})
      when key not in @exclusion_key and editor.game_status == 1 do
    timer = if editor.timer - 2 < 0, do: 0, else: editor.timer - 2
    %{editor | failure_count: editor.failure_count + 1, timer: timer}
  end

  def update(%__MODULE__{} = editor, "input_key", _params), do: editor


  # タイマー処理（1秒ごとに呼ばれる）
  def update(%__MODULE__{} = editor, "timer")
      when editor.game_status == 1 and editor.timer > 0 do
    %{editor | timer: editor.timer - 1}
  end

  # タイマーが0秒になったら呼ばれる
  def update(%__MODULE__{} = editor, "timer")
      when editor.game_status == 1 and editor.timer <= 0 do
    %{editor | display_char: "終了", game_status: 0}
  end

  def update(%__MODULE__{} = editor, "timer"), do: editor

  # 次の表示文字を割り当てます。その際リストに文字列がなければゲームクリアの状態にします。
  defp next_char(editor, key) do
    char_list = List.delete(editor.char_list, editor.display_char)

    char_list =
      if length(char_list) == 0 do
        Enum.shuffle(~w(HelloWorld!! Elixir Phoenix Docker Windows))
      else
        char_list
      end

    display_char = hd(char_list)

    # case length(char_list) do
    #   0 ->
    #     char_list = Enum.shuffle(~w(HelloWorld!! Elixir Phoenix Docker Windows))
    #     display_char = hd(char_list)
    #     %{
    #       editor
    #       | char_list: char_list,
    #         display_char: display_char,
    #         input_char: "",
    #         char_count: String.length(display_char),
    #         now_char_count: 0,
    #         clear_count: editor.clear_count + 1,
    #         timer: editor.timer + 5
    #     }
    #
    #   _num ->
    #     display_char = hd(char_list)
    #
    #     %{
    #       editor
    #       | char_list: char_list,
    #         display_char: display_char,
    #         input_char: "",
    #         char_count: String.length(display_char),
    #         now_char_count: 0,
    #         clear_count: editor.clear_count + 1,
    #         timer: editor.timer + 5
    #     }
    # end
    %{
      editor
      | char_list: char_list,
        display_char: display_char,
        input_char: "",
        char_count: String.length(display_char),
        now_char_count: 0,
        clear_count: editor.clear_count + 1,
        timer: editor.timer + 2
    }
  end
end
