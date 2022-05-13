defmodule Typing.Editor.GameEditor do
  defstruct input_char: "",
            display_char: ""

  def construct() do
    %__MODULE__{
      display_char: "HelloWorld!!"
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
    %{editor | input_char: editor.input_char <> key}
  end

  def update(%__MODULE__{} = editor, "input_key", _params), do: editor
end
