defmodule GithubStatusChat.GithubTest do
  use GithubStatusChat.DataCase

  alias GithubStatusChat.Github

  describe "status_calls" do
    alias GithubStatusChat.Github.StatusCall

    @valid_attrs %{message: "some message", status_code: 42, time: "some time"}
    @update_attrs %{message: "some updated message", status_code: 43, time: "some updated time"}
    @invalid_attrs %{message: nil, status_code: nil, time: nil}

    def status_call_fixture(attrs \\ %{}) do
      {:ok, status_call} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Github.create_status_call()

      status_call
    end

    test "list_status_calls/0 returns all status_calls" do
      status_call = status_call_fixture()
      assert Github.list_status_calls() == [status_call]
    end

    test "get_status_call!/1 returns the status_call with given id" do
      status_call = status_call_fixture()
      assert Github.get_status_call!(status_call.id) == status_call
    end

    test "create_status_call/1 with valid data creates a status_call" do
      assert {:ok, %StatusCall{} = status_call} = Github.create_status_call(@valid_attrs)
      assert status_call.message == "some message"
      assert status_call.status_code == 42
      assert status_call.time == "some time"
    end

    test "create_status_call/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Github.create_status_call(@invalid_attrs)
    end

    test "update_status_call/2 with valid data updates the status_call" do
      status_call = status_call_fixture()
      assert {:ok, status_call} = Github.update_status_call(status_call, @update_attrs)
      assert %StatusCall{} = status_call
      assert status_call.message == "some updated message"
      assert status_call.status_code == 43
      assert status_call.time == "some updated time"
    end

    test "update_status_call/2 with invalid data returns error changeset" do
      status_call = status_call_fixture()
      assert {:error, %Ecto.Changeset{}} = Github.update_status_call(status_call, @invalid_attrs)
      assert status_call == Github.get_status_call!(status_call.id)
    end

    test "delete_status_call/1 deletes the status_call" do
      status_call = status_call_fixture()
      assert {:ok, %StatusCall{}} = Github.delete_status_call(status_call)
      assert_raise Ecto.NoResultsError, fn -> Github.get_status_call!(status_call.id) end
    end

    test "change_status_call/1 returns a status_call changeset" do
      status_call = status_call_fixture()
      assert %Ecto.Changeset{} = Github.change_status_call(status_call)
    end
  end
end
