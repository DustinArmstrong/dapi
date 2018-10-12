defmodule Dapi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dapi.Accounts.{User, Credential}
  alias Dapi.Campaigns.Game
  # alias Dapi.Characters.Character


  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential
    has_many :games, Game
    # has_many :characters, Character

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> unique_constraint(:username)
  end
end
