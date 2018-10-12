# https://medium.brianemory.com/elixir-phoenix-creating-an-app-part-5-setting-a-current-user-43b90c7468d5
defmodule Dapi.Plugs.SetUser do
  require IEx
  import Plug.Conn
  import Phoenix.Controller

  alias Dapi.Repo
  alias Dapi.Accounts.User

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:current_user] do
      conn
    else
      user_id = get_session(conn, :user_id)

      cond do
        user = user_id && Repo.get(User, user_id) ->
          assign(conn, :current_user, user)
        true ->
          assign(conn, :current_user, nil)
      end
    end
  end
end
