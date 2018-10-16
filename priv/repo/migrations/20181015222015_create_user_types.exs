defmodule Dapi.Repo.Migrations.CreateUserTypes do
  use Ecto.Migration

  def change do
    create table(:user_types) do
      add :name, :string
      add :actions, {:array, :string}

      timestamps()
    end

    create unique_index(:user_types, [:name])
  end
end
