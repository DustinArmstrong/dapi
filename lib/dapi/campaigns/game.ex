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
    has_many :characters, through: [:players, :character]

    timestamps()
  end

  @doc false
  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [:name, :summary, :user_id])
    |> validate_required([:name, :summary, :user_id])
  end
end
