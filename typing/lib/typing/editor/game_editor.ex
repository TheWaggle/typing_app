defmodule Typing.Editor.GameEditor do
  defstruct input_char: "",
            display_char: "",
            char_count: 0,
            now_char_count: 0

  def construct() do
    %__MODULE__{
      display_char: "HelloWorld!!",
      char_count: String.length("HelloWorld!!")
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

  def update(%__MODULE__{} = editor, "input_key", %{"key" => key})
      when key not in @exclusion_key do
    if(String.at(editor.display_char, editor.now_char_count) == key) do
      cond do
        editor.now_char_count == editor.char_count - 1 ->
          %{editor | display_char: "クリア", input_char: editor.input_char <> key}

        true ->
          %{editor | input_char: editor.input_char <> key, now_char_count: editor.now_char_count + 1}
      end
    else
      editor
    end
  end

  def update(%__MODULE__{} = editor, "input_key", _params), do: editor
end
