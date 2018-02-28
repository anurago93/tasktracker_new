defmodule Tasktracker.Tracktime.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Tracktime.Timeblock


  schema "timeblocks" do
    field :start, :naive_datetime
    field :stop, :naive_datetime
    belongs_to :task, Tasktracker.Tracker.Task, foreign_key: :block_id

    timestamps()
  end

  @doc false
  def changeset(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start, :stop, :block_id])
    |> validate_required([:start, :stop, :block_id])
  end
end
