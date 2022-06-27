defmodule Typing.Repo.Migrations.CreoAccounts do
  use Ecto.Migration

  def change do
    create table(:core_accounts, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string, null: false)
      add(:email, :string, null: false)
      add(:hashed_password, :string, null: false)

      timestamps()
    end
  end
end
