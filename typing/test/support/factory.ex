defmodule Typing.Factory do
  alias Typing.Repo
  alias Typing.Game

  # Factories
  defp build(:game_themes, attrs) do
    theme = Map.get(attrs, :theme, "Enum.shuffle([1, 2, 3])")
    description = Map.get(attrs, :description, "シャッフルされた要素を含むリストを返します。")

    %Game.Theme{
      theme: theme,
      description: description
    }
  end

  # Convenience API
  def insert!(factory_name, attrs \\ %{}) do
    factory_name |> build(attrs) |> Repo.insert!()
  end
end
