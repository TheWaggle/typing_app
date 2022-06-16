defmodule Typing.Editor.AdminThemeEditor do
  alias Typing.Admin
  alias Typing.Game

  defstruct account: nil,
            mode: :summary,
            themes: [],
            theme: nil,
            theme_changeset: nil

  @type t :: %__MODULE__{
          account: Admin.Account.t(),
          mode: :summary,
          themes: [Game.Theme.t()] | nil,
          theme: Game.Theme.t() | nil,
          theme_changeset: Ecto.Changeset.t() | nil
  }

  def construct(%Admin.Account{} = account) do
    %__MODULE__{
      account: account,
      themes: Game.get_themes()
    }
  end

  def update(%__MODULE__{} = editor, "summary", _params) do
    %{editor | theme: nil, mode: :summary}
  end

  def update(%__MODULE__{} = editor, "show", %{"id" => id}) do
    %{editor | theme: Game.get_theme(id), mode: :show}
  end

  def update(%__MODULE__{} = editor, "edit", %{"id" => id}) do
    theme = Game.get_theme(id)
    cs = Game.Theme.changeset(theme)
    %{editor | theme: theme, theme_changeset: cs, mode: :edit}
  end

  def update(%__MODULE__{} = editor, "delete_theme", %{"id" => id}) do
    id
    |> Game.get_theme()
    |> Game.delete_theme()

    %{editor | theme: nil, themes: Game.get_themes(), mode: :summary}
  end

  def sync(%__MODULE__{} = editor, "edit_theme", %{"theme" => attrs}) do
    cs = Game.Theme.changeset(editor.theme, attrs)
    %{editor | theme_changeset: cs}
  end

  def save(%__MODULE__{} = editor, "edit_theme", %{"theme" => attrs}) do
    case Game.update_theme(editor.theme, attrs) do
      {:ok, %Game.Theme{} = theme} ->
        %{editor | theme: theme, theme_changeset: nil, mode: :show}

      {:error, cs} ->
        %{editor | theme_changeset: cs}
    end
  end
end