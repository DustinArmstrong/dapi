defmodule Dapi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dapi.Accounts.{User, Credential}
  alias Dapi.Campaigns.Game

  schema "users" do
    field :name, :string
    field :username, :string
    field :is_admin, :boolean, default: false
    has_one :credential, Credential
    has_many :games, Game

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username, :is_admin])
    |> validate_required([:name, :username, :is_admin])
    |> unique_constraint(:username)
  end
end
