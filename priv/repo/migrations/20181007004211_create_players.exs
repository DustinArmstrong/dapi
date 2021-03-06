defmodule Dapi.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :is_active, :boolean, default: true, null: false
      add :game_id, references(:games, on_delete: :delete_all),
                    null: false
      add :character_id, references(:characters, on_delete: :delete_all),
                    null: false

      timestamps()
    end

    create index(:players, [:game_id, :character_id])
    create unique_index(:players, :character_id)
  end
end
