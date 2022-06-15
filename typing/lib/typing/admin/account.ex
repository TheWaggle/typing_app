defmodule Typing.Admin.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          name: String.t(),
          email: String.t(),
          hashed_password: String.t(),
          authority_status: integer(),
          password: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
  }

  # authority_status
  # 0・・・閲覧のみ
  # 1・・・編集者
  # 2・・・管理者
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "admin_accounts" do
    field(:name, :string)
    field(:email, :string)
    field(:hashed_password, :string, redact: true)
    field(:authority_status, :integer, defalut: 0)

    timestamps()

    field(:password, :string, virtual: true, redact: true)
  end

  @doc """
  Admin.Accountのチェンジセットを作成します。
  """
  def build_changeset(), do: cast(%__MODULE__{}, %{}, [])
end