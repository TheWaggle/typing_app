defmodule Typing.Game do
  alias Typing.Repo
  alias Typing.Game

  @doc """
  お題を全て取得します。
  """
  @spec get_themes() :: [Game.Theme.t()] | []
  def get_themes(), do: Repo.all(Game.Theme)
end
