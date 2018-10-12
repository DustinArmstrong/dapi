defmodule Dapi.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :player_id, references(:players, on_delete: :delete_all)

      timestamps()
    end

    create index(:characters, [:user_id])
    create index(:characters, [:player_id])
  end
end
