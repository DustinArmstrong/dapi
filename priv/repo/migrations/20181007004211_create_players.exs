defmodule Dapi.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :active, :boolean, default: true, null: false
      add :game_id, references(:games, on_delete: :delete_all),
                    null: false
      add :character_id, references(:players, on_delete: :delete_all),
                    null: false

      timestamps()
    end

    create index(:players, :game_id)
    create unique_index(:players, :character_id)
  end
end
