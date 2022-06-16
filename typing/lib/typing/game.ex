defmodule Typing.Game do
  alias Typing.Repo
  alias Typing.Game

  @doc """
  登録されている全てのgame_themeを取得します。
  """
  @spec get_themes() :: [Game.Theme.t()] | []
  def get_themes(), do: Repo.all(Game.Theme)

  def create_theme(attrs) do
    nil
  end
end
