defmodule DapiWeb.Router do
  use DapiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Dapi.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DapiWeb do
    pipe_through :browser # Use the default browser stack
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true

    get "/", PageController, :index
  end

  scope "/characters", DapiWeb.Characters do
    pipe_through [:browser, :authenticate_user]

    resources "/", CharacterController
  end

  scope "/campaigns", DapiWeb.Campaigns do
    pipe_through [:browser, :authenticate_user]

    resources "/", GameController do
      resources "/players", Game.PlayerController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", DapiWeb do
  #   pipe_through :api
  # end
  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id ->
        assign(conn, :current_user, Dapi.Accounts.get_user!(user_id))
    end
  end
end
