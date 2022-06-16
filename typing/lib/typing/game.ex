defmodule Typing.Game do
  import Ecto.Query
  alias Typing.Repo
  alias Typing.Game

  @doc """
  idでgame_themeを取得します。
  """
  @spec get_theme(Ecto.UUID.t()) :: Game.Theme.t() | nil
  def get_theme(<<_::288>> = id) do
    query =
      from(t in Game.Theme,
        where: t.id == ^id
      )

    Repo.one(query)
  end

  def get_theme(_id), do: nil

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

  @doc """
  game_themeを更新します。
  """
  @spec update_theme(Game.Theme.t(), %{}) :: {:ok, Game.Theme.t()} | {:error, Ecto.Changeset.t()}
  def update_theme(%Game.Theme{} = theme, attrs) do
    cs = Game.Theme.changeset(theme, attrs)
    Repo.update(cs)
  end

  @doc """
  game_themeを削除します。
  """
  def delete_theme(%Game.Theme{} = theme) do
    nil
  end
end
