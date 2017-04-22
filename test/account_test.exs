defmodule MentalHealthMatters.AccountTest do
  use MentalHealthMatters.DataCase

  alias MentalHealthMatters.Account
  alias MentalHealthMatters.Account.User

  @create_attrs %{email: "some email",
                  name: "some name",
                  password: "password",
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
    original_user = fixture(:user)
    assert [user] = Account.list_users()
    assert original_user.id == user.id
  end

  test "get_user! returns the user with given id" do
    user = fixture(:user)
    assert Account.get_user!(user.id).id == user.id
  end

  test "create_user/1 with valid data creates a user" do
    assert {:ok, %User{} = user} = Account.create_user(@create_attrs)
    assert user.email == "some email"
    assert user.name == "some name"
    assert user.password_hash != nil
    assert user.is_client == false
    assert user.is_coach == false
    assert user.is_manager == false
  end

  test "create_user/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
  end

  test "update_user/2 with valid data updates the user" do
    original_user = fixture(:user)
    assert {:ok, user} = Account.update_user(original_user, @update_attrs)
    assert %User{} = user
    assert user.email == "some updated email"
    assert user.name == "some updated name"
    assert user.password_hash == original_user.password_hash
    assert user.is_client == true
    assert user.is_coach == true
    assert user.is_manager == true
  end

  test "update_user/2 with invalid data returns error changeset" do
    user = fixture(:user)
    assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
    assert user.id == Account.get_user!(user.id).id
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
