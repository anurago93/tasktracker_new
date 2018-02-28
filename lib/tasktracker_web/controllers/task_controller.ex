defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Tracker
  alias Tasktracker.Tracker.Task
  alias Tasktracker.Accounts
  alias Tasktracker.Accounts.User
  alias Tasktracker.Tracktime
  alias Tasktracker.Tracktime.Timeblock

  def index(conn, _params) do
    tasks = Tracker.list_tasks_underlings(conn.assigns[:current_user].id)
    tasks = List.flatten(tasks)
    underlings = Accounts.get_underlings(Integer.to_string(conn.assigns[:current_user].id))
    render(conn, "index.html", tasks: tasks, assigned_to: underlings)
  end

  def new(conn, _params) do
    new_task = %Task{ user_id: conn.assigns[:current_user].id }
    changeset = Tracker.change_task(new_task)
    underlings = Accounts.get_underlings(Integer.to_string(conn.assigns[:current_user].id))
    render(conn, "new.html", changeset: changeset, assigned_to: underlings)
  end

  def create(conn, %{"task" => task_params}) do
    case Tracker.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tracker.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tracker.get_task!(id)
    changeset = Tracker.change_task(task)
    if(task.user_id == conn.assigns[:current_user].id) do
      underlings = [{task.user.name, task.user_id}]
    else
      underlings = Accounts.get_underlings(Integer.to_string(conn.assigns[:current_user].id))
    end
    timeblocks = Tracktime.list_task_timeblocks(id)
    render(conn, "edit.html", task: task, changeset: changeset, assigned_to: underlings, timeblocks: timeblocks)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tracker.get_task!(id)

    case Tracker.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tracker.get_task!(id)
    {:ok, _task} = Tracker.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: "/feed")
  end
end
