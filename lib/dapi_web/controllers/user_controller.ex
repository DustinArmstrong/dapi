defmodule DapiWeb.UserController do
  use DapiWeb, :controller

  alias Dapi.Accounts
  alias Dapi.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    user_types =
      Accounts.list_user_types()
        |> Enum.map(&{&1.name, &1.id})
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset, user_types: user_types)
  end

  def create(conn, %{"user" => user_params}) do
    user_types =
      Accounts.list_user_types()
        |> Enum.map(&{&1.name, &1.id})
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, user_types: user_types)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    user_types =
      Accounts.list_user_types()
        |> Enum.map(&{&1.name, &1.id})
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset, user_types: user_types)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
