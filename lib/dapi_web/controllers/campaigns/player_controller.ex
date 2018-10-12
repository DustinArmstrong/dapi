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
    # game = Campaigns.get_game!(game_id)
    render(conn, "index.html", game: game)
  end

  def new(conn, _params, game) do
    characters =
      Characters.list_characters()
        |> Enum.map(&{&1.name, &1.id})
    changeset = Campaigns.change_player(%Player{})
    render(conn, "new.html", changeset: changeset, characters: characters, game: game)
  end

  def create(conn, %{"player" => player_params}, game) do
    IEx.pry
    case Campaigns.create_player(game, player_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: game_player_path(conn, :index, game))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Campaigns.get_game!(id)
    render(conn, "show.html", game: game)
  end

  def edit(conn, %{"id" => id}) do
    game = Campaigns.get_game!(id)
    changeset = Campaigns.change_game(game)
    render(conn, "edit.html", game: game, changeset: changeset)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Campaigns.get_game!(id)

    case Campaigns.update_game(game, game_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game updated successfully.")
        |> redirect(to: game_path(conn, :show, game))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", game: game, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Campaigns.get_game!(id)
    {:ok, _game} = Campaigns.delete_game(game)

    conn
    |> put_flash(:info, "Game deleted successfully.")
    |> redirect(to: game_path(conn, :index))
  end

  # defp store_game(conn, game) do
  #   assign(conn, :game, game)
  # end
end
