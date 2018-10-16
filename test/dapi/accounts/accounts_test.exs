defmodule Dapi.AccountsTest do
  use Dapi.DataCase

  alias Dapi.Accounts

  describe "user_types" do
    alias Dapi.Accounts.UserType

    @valid_attrs %{actions: [], type: "some type"}
    @update_attrs %{actions: [], type: "some updated type"}
    @invalid_attrs %{actions: nil, type: nil}

    def user_type_fixture(attrs \\ %{}) do
      {:ok, user_type} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user_type()

      user_type
    end

    test "list_user_types/0 returns all user_types" do
      user_type = user_type_fixture()
      assert Accounts.list_user_types() == [user_type]
    end

    test "get_user_type!/1 returns the user_type with given id" do
      user_type = user_type_fixture()
      assert Accounts.get_user_type!(user_type.id) == user_type
    end

    test "create_user_type/1 with valid data creates a user_type" do
      assert {:ok, %UserType{} = user_type} = Accounts.create_user_type(@valid_attrs)
      assert user_type.actions == []
      assert user_type.type == "some type"
    end

    test "create_user_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_type(@invalid_attrs)
    end

    test "update_user_type/2 with valid data updates the user_type" do
      user_type = user_type_fixture()
      assert {:ok, user_type} = Accounts.update_user_type(user_type, @update_attrs)
      assert %UserType{} = user_type
      assert user_type.actions == []
      assert user_type.type == "some updated type"
    end

    test "update_user_type/2 with invalid data returns error changeset" do
      user_type = user_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user_type(user_type, @invalid_attrs)
      assert user_type == Accounts.get_user_type!(user_type.id)
    end

    test "delete_user_type/1 deletes the user_type" do
      user_type = user_type_fixture()
      assert {:ok, %UserType{}} = Accounts.delete_user_type(user_type)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user_type!(user_type.id) end
    end

    test "change_user_type/1 returns a user_type changeset" do
      user_type = user_type_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_type(user_type)
    end
  end
end
