defmodule Dapi.Repo.Migrations.AddUserTypesToUsers do
  use Ecto.Migration

  def change do

    alter table(:users) do
      add :user_type_id, references(:user_types, on_delete: :nothing)
    end

  end
end
