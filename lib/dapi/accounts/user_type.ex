defmodule Dapi.Accounts.UserType do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dapi.Accounts.User

  schema "user_types" do
    field :actions, {:array, :string}
    field :name, :string
    has_many :users, User

    timestamps()
  end

  @doc false
  def changeset(user_type, attrs) do
    user_type
    |> cast(attrs, [:name, :actions])
    |> validate_required([:name, :actions])
    |> unique_constraint(:name)
  end
end
