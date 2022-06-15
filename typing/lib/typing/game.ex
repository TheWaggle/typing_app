defmodule Typing.Game do
  alias Typing.Repo
  alias Typing.Game

  def get_themes(), do: Repo.all(Game.Theme)
end
