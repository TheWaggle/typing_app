defmodule Typing.Game.Theme do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          theme: String.t(),
          description: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "game_themes" do
    field(:theme, :string)
    field(:description, :string)

    timestamps()
  end

  @required_fileds [
    :theme,
    :description
  ]

  @doc """
  Game.Themeのチェンジセットを作成します。
  """
  def build_changeset(), do: cast(%__MODULE__{}, %{}, [])

  @doc """
  Game.Themeのバリデーションをチェックします。
  """
  def changeset(theme, attrs \\ %{}) do
    theme
    |> cast(attrs, @required_fileds)
    |> validate_required(@required_fileds)
  end
end
