defmodule Typing.Core.AccountToken do
  use Ecto.Schema
  alias Typing.Core

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "core_account_tokens" do
    field(:token, :binary)
    field(:context, :string)

    timestamps(update_at: false)

    belongs_to(:account, Core.Account)
  end
end
