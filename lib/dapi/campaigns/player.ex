defmodule Dapi.Campaigns.Player do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dapi.Characters.Character
  alias Dapi.Campaigns.{Game, Player}

  schema "players" do
    field :is_active, :boolean, default: true
    belongs_to :character, Character
    belongs_to :game, Game

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:is_active, :game_id, :character_id])
    |> validate_required([:is_active, :game_id, :character_id])
    |> unique_constraint(:character_id, name: :players_character_id_index, message: "Character is already in another game")
  end
end
