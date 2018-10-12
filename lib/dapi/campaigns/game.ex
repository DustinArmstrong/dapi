defmodule Dapi.Campaigns.Game do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dapi.Accounts.User
  alias Dapi.Campaigns.{Game, Player}

  schema "games" do
    field :name, :string
    field :summary, :string
    belongs_to :user, User
    has_many :players, Player

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :summary, :user_id])
    |> validate_required([:name, :summary, :user_id])
  end
end
