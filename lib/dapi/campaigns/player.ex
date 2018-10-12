defmodule Dapi.Campaigns.Player do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dapi.Characters.Character
  alias Dapi.Campaigns.{Game, Player}

  schema "players" do
    field :active, :boolean, default: false
    has_one :character, Character
    belongs_to :game, Game

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:active, :game_id])
    #|> cast(attrs, [:active])
    |> validate_required([:active, :game_id])
  end
end
