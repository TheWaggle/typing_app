defmodule Typing.Core.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          name: String.t(),
          email: String.t(),
          hashed_password: String.t(),
          password: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "core_accounts" do
    field(:name, :string)
    field(:email, :string)
    field(:hashed_password, :string, redact: true)

    timestamps()

    field(:password, :string, virtual: true, redact: true)
  end

  @doc """
  Core.Accountのチェンジセットを作成します。
  """
  def build_changeset(), do: cast(%__MODULE__{}, %{}, [])
end
