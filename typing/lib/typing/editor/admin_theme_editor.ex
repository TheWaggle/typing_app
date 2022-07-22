defmodule Typing.Editor.AdminThemeEditor do
  alias Typing.Admin
  alias Typing.Game

  defstruct account: nil,
            mode: :summary,
            themes: [],
            theme: nil

  @type t :: %__MODULE__{
          account: Admin.Account.t(),
          mode: :summary,
          themes: [Game.Theme.t()] | [],
          theme: Game.Theme.t() | nil
  }

  def construct(%Admin.Account{} = account) do
    %__MODULE__{
      account: account,
      themes: Game.get_themes()
    }
  end

  def update(%__MODULE__{} = editor, "show", %{"id" => id}) do
    %{editor | theme: Game.get_theme(id), mode: :show}
  end

  def update(%__MODULE__{} = editor, "delete", %{"id" => id}) do
    id
    |> Game.get_theme()
    |> Game.delete_theme()

    %{editor | theme: nil, themes: Game.get_themes(), mode: :summary}
  end
end
