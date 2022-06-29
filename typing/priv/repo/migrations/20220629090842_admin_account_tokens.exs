defmodule Typing.Repo.Migrations.AdminAccountTokens do
  use Ecto.Migration

  def change do
    create table(:admin_account_tokens, primary_key: false) do
      add(:id, :binary_id, primary_key: false)
      add(:account_id, references(:admin_accounts, type: :binary_id, on_delete: :delete_all), null: false)
      add(:token, :binary, null: false)
      add(:context, :string, null: false)

      timestamps(update_at: false)
    end

    create index(:admin_account_tokens, [:account_id])
    create unique_index(:admin_account_tokens, [:token, :context])
  end
end
