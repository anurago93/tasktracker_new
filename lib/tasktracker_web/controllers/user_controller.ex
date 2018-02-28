defmodule TasktrackerWeb.UserController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})

    if(Accounts.list_users() != []) do
      managed_by = Accounts.list_users() |> Enum.map(&({&1.name, &1.id}))
    else
      managed_by = [{"No users available in the system", nil}]
    end
    render(conn, "new.html", changeset: changeset, managed_by: managed_by)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        managed_by = Accounts.list_users() |> Enum.map(&({&1.name, &1.id}))
        render(conn, "new.html", changeset: changeset, managed_by: managed_by)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    if(user.manager_id) do
      manager = Accounts.get_user!(user.manager_id)
    else
      manager = %User{name: "No Manager Available"}
    end
    render(conn, "show.html", user: user, manager: manager)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    underlings = Accounts.get_underlings(id)
    changeset = Accounts.change_user(user)
    userTuple = [{user.name, user.id}]
    managed_by = Accounts.list_users() |> Enum.map(&({&1.name, &1.id}))
    managed_by = managed_by -- userTuple
    managed_by = managed_by -- underlings
    render(conn, "edit.html", user: user, changeset: changeset, managed_by: managed_by)
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
