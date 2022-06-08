defmodule Typing.Editor.GameEditor do
  import Typing.Utils.KeysDecision
  alias Typing.Utils.Execution

  defstruct input_char: "",
            display_char: "",
            char_count: 0,
            now_char_count: 0,
            failure_counts: 0,
            game_status: 0,
            char_list: [],
            clear_count: 0,
            result: nil,
            mode: :select,
            timer: 0,
            input_time: 0,
            failure_count: 0,
            results: []

  # mode
  #:select・・・モード選択
  #:training・・・練習モード
  #:game・・・ゲームモード（タイムアタック）
  #:result・・・ゲーム結果

  # game_status
  # 0・・・ゲーム停止
  # 1・・・ゲーム実行中
  # 2・・・Enter入力待ち
  # 3・・・ゲームクリア

  def construct() do
    char_list =
      [
        "Enum.map([1, 2, 3], fn a -> a * 2 end)",
        "Enum.shuffle([1, 2, 3])",
        "Enum.map([1, 2, 3])"
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

  # @exclusion_key以外かつ入力判定がtrueかつgame_statusが1の場合はここがよばれる
  def update(%__MODULE__{display_char: char, now_char_count: count} = editor, "input_key", %{"key" => key})
      when key not in @exclusion_key and key_check(char, count, key) and editor.game_status == 1 do
    cond do
      editor.now_char_count == editor.char_count - 1 ->
        display_result(editor, key)

      true ->
        %{editor | input_char: editor.input_char <> key, now_char_count: editor.now_char_count + 1}
    end
  end

  # @exclusion_key以外かつgame_statusが1の場合はここがよばれる
  # 間違ったキーを入力した場合
  def update(%__MODULE__{} = editor, "input_key", %{"key" => key})
      when key not in @exclusion_key and editor.game_status == 1 do
    %{editor | failure_counts: editor.failure_counts + 1, failure_count: editor.failure_count + 1}
  end

  # game_statusが2でEnterキーが入力された場合にここがよばれる
  def update(%__MODULE__{} = editor, "input_key", %{"key" => key})
      when key == "Enter" and editor.game_status == 2 do
    next_char(editor, key)
  end

  # どのガードにもマッチしなかった場合にここがよばれる
  def update(%__MODULE__{} = editor, "input_key", _params), do: editor

  # gameを割り当てる
  def update(%__MODULE__{} = editor, "select_mode", %{"mode" => "game"}) do
    %{editor | mode: :game, timer: 60, game_status: 1}
  end

  # trainigを割り当てる
  def update(%__MODULE__{} = editor, "select_mode", %{"mode" => mode})
      when mode in ["training", "result"] do
    timer =
      if mode == "result", do: editor.timer, else: 0

    %{editor | mode: String.to_atom(mode), timer: timer, game_status: 1}
  end

  # game, training どちらでもない場合は select を割り当てる
  def update(%__MODULE__{} = editor, "select_mode", _params) do
    char_list =
      [
        "Enum.map([1, 2, 3], fn a -> a * 2 end)",
        "Enum.shuffle([1, 2, 3])",
        "Enum.map([1, 2, 3])"
      ]

    %{
      editor
      | mode: :select,
        failure_counts: 0,
        failure_count: 0,
        game_status: 0,
        clear_count: 0,
        timer: 0,
        results: [],
        char_list: char_list,
        display_char: hd(char_list),
        char_count: String.length(hd(char_list)),
        input_char: "",
        now_char_count: 0,
        input_time: 0
    }
  end

  # mode が game
  # game_status が 1（プレイ中）
  # timer が 0以下
  # 上記の場合はこっちを呼ぶ
  def update(%__MODULE__{} = editor, "timer")
      when editor.mode == :game and editor.game_status == 1 and editor.timer <= 0 do
    %{
      editor
      | display_char: "終了",
        game_status: 3,
        result: nil,
        failure_count: 0
    }
  end

  def update(%__MODULE__{} = editor, "timer")
      when editor.mode == :game and editor.game_status == 1 do
    %{editor | timer: editor.timer - 1, input_time: editor.input_time + 1}
  end

  #モードが :traingin だった場合にここを呼ぶ
  def update(%__MODULE__{} = editor, "timer")
      when editor.mode == :training and editor.game_status == 1 do
    %{editor | timer: editor.timer + 1, input_time: editor.input_time + 1}
  end

  def update(%__MODULE__{} = editor, "timer"), do: editor

  # 次の表示文字を割り当てます。その際リストに文字列がなければゲームクリアの状態にします。
  defp next_char(editor, key) do
    char_list = List.delete(editor.char_list, editor.display_char)

    char_list =
      if length(char_list) == 0 and editor.mode == :game do
        list =
          [
            "Enum.map([1, 2, 3])",
            "Enum.map([1, 2, 3], fn a -> a * 2 end)",
            "Enum.shuffile([1, 2, 3])"
          ]

        Enum.shuffle(list)
      else
        char_list
      end

    timer =
      if editor.mode == :game, do: editor.timer + 2, else: editor.timer

    case length(char_list) do
      0 ->
        %{
          editor
          | char_list: char_list,
            display_char: "クリア",
            input_char: editor.input_char <> key,
            game_status: 3,
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
            result: nil,
            timer: timer,
            input_time: 0
        }
    end
  end

  # display_char の値（関数）を実行して、その結果をresultに割り当てます。
  defp display_result(editor, key) do
    result =
      case Execution.execution(editor.display_char) do
        {r, _} -> r

        error -> error
      end

    results =
      %{
        display_char: editor.display_char,
        time: editor.input_time,
        result: result,
        failure_count: editor.failure_count
      }

    %{
      editor
      | result: result,
        game_status: 2,
        input_char: editor.input_char <> key,
        clear_count: editor.clear_count + 1,
        results: List.insert_at(editor.results, -1, results)
    }
  end
end
