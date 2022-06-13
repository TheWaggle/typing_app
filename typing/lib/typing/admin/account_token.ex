defmodule Typing.Admin.AccountToken do
  use Ecto.Schema
  alias Typing.Admin

  @type t :: %__MODULE__{
          id: Ecto.UUID.t(),
          token: binary(),
          context: String.t(),
          inserted_at: DateTime.t(),
          account: Core.Account.t()
  }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "admin_account_tokens" do
    field(:token, :binary)
    field(:context, :string)

    timestamps(update_at: false)

    belongs_to(:account, Admin.Account)
  end
end
