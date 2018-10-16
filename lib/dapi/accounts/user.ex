defmodule Dapi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dapi.Accounts.{User, Credential, UserType}
  alias Dapi.Campaigns.Game
  # alias Dapi.Characters.Character


  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential
    has_many :games, Game
    belongs_to :user_type, UserType

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username, :user_type_id])
    |> validate_required([:name, :username])
    |> unique_constraint(:username)
  end
end
