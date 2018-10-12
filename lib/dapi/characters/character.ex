defmodule Dapi.Characters.Character do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dapi.Accounts.User
  alias Dapi.Campaigns.Player

  schema "characters" do
    field :name, :string
    belongs_to :user, User
    belongs_to :player, Player

    timestamps()
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :user_id, :player_id])
    |> validate_required([:name, :user_id])
  end
end
