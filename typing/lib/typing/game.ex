defmodule Typing.Game do
  alias Typing.Repo
  alias Typing.Game

  @doc """
  idでお題を取得します。
  """
  @spec get_theme(Ecto.UUID.t()) :: Game.Theme.t() | nil
  def get_theme(<<_::288>> = id) do
    Repo.get(Game.Theme, id)
  end

  def get_theme(_id), do: nil

  @doc """
  お題を全て取得します。
  """
  @spec get_themes() :: [Game.Theme.t()] | []
  def get_themes(), do: Repo.all(Game.Theme)

  @doc """
  game_themeを登録する
  """
  @spec create_theme(%{}) :: {:ok, Game.Theme.t()} | {:error, Ecto.Changeset.t()}
  def create_theme(attrs) do
    %Game.Theme{}
    |> Game.Theme.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  game_themeの情報を更新します。
  """
  @spec update_theme(Game.Theme.t(), %{}) :: {:ok, Game.Theme.t()} | {:error, Ecto.Changeset.t()}
  def update_theme(%Game.Theme{} = theme, attrs) do
    theme
    |> Game.Theme.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  game_themeを削除します。
  """
  @spec delete_theme(Game.Theme.t()) :: {:ok, Game.Theme.t()} | nil
  def delete_theme(%Game.Theme{} = theme) do
    Repo.delete(theme)
  end

  def delete_theme(_theme), do: nil
end
