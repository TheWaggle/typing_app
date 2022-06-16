defmodule Typing.Game do
  alias Typing.Repo
  alias Typing.Game

  @doc """
  登録されている全てのgame_themeを取得します。
  """
  @spec get_themes() :: [Game.Theme.t()] | []
  def get_themes(), do: Repo.all(Game.Theme)

  @doc """
  game_themeを登録する
  """
  @spec create_theme(%{}) :: {:ok, Game.Theme.t()} | {:error, Ecto.Changeset.t()}
  def create_theme(attrs) do
    Game.Theme.changeset(%Game.Theme{}, attrs)
    |> Repo.insert()
  end
end
