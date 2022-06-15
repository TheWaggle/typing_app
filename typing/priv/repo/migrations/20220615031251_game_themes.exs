defmodule Typing.Repo.Migrations.GameThemes do
  use Ecto.Migration

  def change do
    create table(:game_themes, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:theme, :string, null: false)
      add(:description, :text, null: false)

      timestamps()
    end
  end
end
