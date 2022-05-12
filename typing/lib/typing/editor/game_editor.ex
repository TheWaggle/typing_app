defmodule Typing.Editor.GameEditor do
  defstruct input_char: "",
            display_char: ""

  def construct() do
    %__MODULE__{
      display_char: "HelloWorld!!"
    }
  end

  def update(%__MODULE__{} = editor, "input_key", %{"key" => key}) do
    %{editor | input_char: editor.input_char <> key}
  end
end
