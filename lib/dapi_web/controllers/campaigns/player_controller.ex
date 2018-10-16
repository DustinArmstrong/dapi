defmodule DapiWeb.Campaigns.Game.PlayerController do
  use DapiWeb, :controller

  require IEx
  alias Dapi.Repo

  alias Dapi.Campaigns
  alias Dapi.Campaigns.{Game, Player}

  alias Dapi.Characters
  alias Dapi.Characters.Character


  def action(conn, opts) do
    case action_name(conn) do
      action when action in [:index, :new, :create, :show, :edit, :update, :delete] ->
        game = Campaigns.get_game!(conn.params["game_id"])
        apply(__MODULE__, action, [conn, conn.params, game])

      _action -> super(conn, opts)
    end
  end

  def index(conn, _params, game) do
    players =
      Campaigns.list_players()
    render(conn, "index.html", players: players, game: game)
  end

  def new(conn, _params, game) do
    characters =
      Characters.list_characters(conn.assigns.current_user)
        |> Enum.map(&{&1.name, &1.id})
    changeset = Campaigns.change_player(%Player{})
    render(conn, "new.html", changeset: changeset, characters: characters, game: game)
  end

  def create(conn, %{"player" => player_params}, game) do
    characters =
      Characters.list_characters(conn.assigns.current_user)
        |> Enum.map(&{&1.name, &1.id})
    case Campaigns.create_player(game, player_params) do
      {:ok, player} ->
        conn
        |> put_flash(:info, "Player created successfully.")
        |> redirect(to: game_player_path(conn, :index, game.id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, characters: characters, game: game)
    end
  end

  def show(conn, %{"id" => id}, game) do
    player = Campaigns.get_player!(id)
    render(conn, "show.html", player: player, game: game)
  end

  def edit(conn, %{"id" => id}, game) do
    player = Campaigns.get_player!(id)
    changeset = Campaigns.change_player(player)
    render(conn, "edit.html", player: player, game: game, changeset: changeset)
  end

  def update(conn, %{"id" => id, "player" => player_params}, game) do
    player = Campaigns.get_player!(id)

    case Campaigns.update_player(player, player_params) do
      {:ok, player} ->
        conn
        |> put_flash(:info, "Player updated successfully.")
        |> redirect(to: game_player_path(conn, :show, game.id, player.id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", player: player, game: game, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, game) do
    player = Campaigns.get_player!(id)
    {:ok, _player} = Campaigns.delete_player(player)

    conn
    |> put_flash(:info, "Player deleted successfully.")
    |> redirect(to: game_path(conn, :show, game.id))
  end

  # defp store_game(conn, game) do
  #   assign(conn, :game, game)
  # end
end
