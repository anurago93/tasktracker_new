defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Tracker
  alias Tasktracker.Accounts

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
  	tasks = Tracker.list_tasks() 
    newTasks = get_in(tasks, [Access.filter(fn a -> a.user_id == conn.assigns[:current_user].id end)])
  	new_task = %Tasktracker.Tracker.Task{ user_id: conn.assigns[:current_user].id }
  	changeset = Tracker.change_task(new_task)
  	underlings = Accounts.get_underling_users(conn.assigns[:current_user].id)
    render conn, "feed.html", tasks: newTasks, changeset: changeset, assigned_to: underlings
  end

  def profile(conn, _params) do
    underlings = Accounts.get_underling_users(conn.assigns[:current_user].id)
    render conn, "profile.html", assigned_to: underlings
  end
end
