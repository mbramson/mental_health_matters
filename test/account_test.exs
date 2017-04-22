defmodule MentalHealthMatters.AccountTest do
  use MentalHealthMatters.DataCase

  alias MentalHealthMatters.Account
  alias MentalHealthMatters.Account.User

  @create_attrs %{email: "some email",
                  name: "some name",
                  password_hash: "some password_hash",
                  is_client: false,
                  is_coach: false,
                  is_manager: false}
  @update_attrs %{email: "some updated email",
                  name: "some updated name",
                  password_hash: "some updated password_hash",
                  is_client: true,
                  is_coach: true,
                  is_manager: true}
  @invalid_attrs %{email: nil, name: nil, password_hash: nil}

  def fixture(:user, attrs \\ @create_attrs) do
    {:ok, user} = Account.create_user(attrs)
    user
  end

  test "list_users/1 returns all users" do
    user = fixture(:user)
    assert Account.list_users() == [user]
  end

  test "get_user! returns the user with given id" do
    user = fixture(:user)
    assert Account.get_user!(user.id) == user
  end

  test "create_user/1 with valid data creates a user" do
    assert {:ok, %User{} = user} = Account.create_user(@create_attrs)
    assert user.email == "some email"
    assert user.name == "some name"
    assert user.password_hash == "some password_hash"
  end

  test "create_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
  end

  test "update_user/2 with valid data updates the user" do
    user = fixture(:user)
    assert {:ok, user} = Account.update_user(user, @update_attrs)
    assert %User{} = user
    assert user.email == "some updated email"
    assert user.name == "some updated name"
    assert user.password_hash == "some updated password_hash"
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = fixture(:user)
    assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
    assert user == Account.get_user!(user.id)
  end

  test "delete_user/1 deletes the user" do
    user = fixture(:user)
    assert {:ok, %User{}} = Account.delete_user(user)
    assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
  end

  test "change_user/1 returns a user changeset" do
    user = fixture(:user)
    assert %Ecto.Changeset{} = Account.change_user(user)
  end
end
