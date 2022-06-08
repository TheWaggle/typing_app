defmodule Typing.Core.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @goreign_key_type :binary_id
  schema "core_accounts" do
    field(:name, :string)
    field(:email, :string)
    field(:hashed_password, :string, redact: true)

    timestamps()

    field(:password, :string, virtual: true, redact: true)
  end
end
