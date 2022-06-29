defmodule Typing.Repo.Migrations.AdminAccounts do
  use Ecto.Migration

  def change do
    create table(:admin_accounts, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)
      add(:email, :string, null: false)
      add(:hashed_password, :string, null: false)
      add(:authority_status, :integer, null: false)

      timestamps()
    end
  end
end
