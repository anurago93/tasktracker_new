defmodule Tasktracker.TracktimeTest do
  use Tasktracker.DataCase

  alias Tasktracker.Tracktime

  describe "timeblocks" do
    alias Tasktracker.Tracktime.Timeblock

    @valid_attrs %{start: ~N[2010-04-17 14:00:00.000000], stop: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{start: ~N[2011-05-18 15:01:01.000000], stop: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{start: nil, stop: nil}

    def timeblock_fixture(attrs \\ %{}) do
      {:ok, timeblock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracktime.create_timeblock()

      timeblock
    end

    test "list_timeblocks/0 returns all timeblocks" do
      timeblock = timeblock_fixture()
      assert Tracktime.list_timeblocks() == [timeblock]
    end

    test "get_timeblock!/1 returns the timeblock with given id" do
      timeblock = timeblock_fixture()
      assert Tracktime.get_timeblock!(timeblock.id) == timeblock
    end

    test "create_timeblock/1 with valid data creates a timeblock" do
      assert {:ok, %Timeblock{} = timeblock} = Tracktime.create_timeblock(@valid_attrs)
      assert timeblock.start == ~N[2010-04-17 14:00:00.000000]
      assert timeblock.stop == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_timeblock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracktime.create_timeblock(@invalid_attrs)
    end

    test "update_timeblock/2 with valid data updates the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, timeblock} = Tracktime.update_timeblock(timeblock, @update_attrs)
      assert %Timeblock{} = timeblock
      assert timeblock.start == ~N[2011-05-18 15:01:01.000000]
      assert timeblock.stop == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_timeblock/2 with invalid data returns error changeset" do
      timeblock = timeblock_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracktime.update_timeblock(timeblock, @invalid_attrs)
      assert timeblock == Tracktime.get_timeblock!(timeblock.id)
    end

    test "delete_timeblock/1 deletes the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, %Timeblock{}} = Tracktime.delete_timeblock(timeblock)
      assert_raise Ecto.NoResultsError, fn -> Tracktime.get_timeblock!(timeblock.id) end
    end

    test "change_timeblock/1 returns a timeblock changeset" do
      timeblock = timeblock_fixture()
      assert %Ecto.Changeset{} = Tracktime.change_timeblock(timeblock)
    end
  end
end
