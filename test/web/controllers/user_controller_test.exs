defmodule MentalHealthMatters.Web.UserControllerTest do
  use MentalHealthMatters.Web.ConnCase

  alias MentalHealthMatters.Account
  alias MentalHealthMatters.Account.User

  @create_attrs %{email: "some email", name: "some name", password: "password",
                  student_id: "ABC1234",
                  is_client: false, is_coach: false, is_manager: false}
  @update_attrs %{email: "some updated email", name: "some updated name", password_hash: "some updated password_hash",
                  student_id: "4321CBA",
                  is_client: false, is_coach: false, is_manager: false}
  @invalid_attrs %{email: nil, name: nil, password_hash: nil}

  def fixture(:user) do
    {:ok, user} = Account.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates user and renders user when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, user_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "email" => "some email",
      "name" => "some name",
      "student_id" => "ABC1234",
      "is_client" => false,
      "is_coach" => false,
      "is_manager" => false}
  end

  test "does not create user if email is already taken", %{conn: conn} do
    user = insert(:user_client)
    attrs = Map.merge(params_for(:user_client), %{email: user.email, password: "password"})
    conn = post conn, user_path(conn, :create), user: attrs

    json_response_error = json_response(conn, 422)["errors"]
    assert %{"email" => ["has already been taken"]} = json_response_error
  end

  test "does not create user and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen user and renders user when data is valid", %{conn: conn} do
    %User{id: id} = user = fixture(:user)
    conn = put conn, user_path(conn, :update, user), user: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, user_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "email" => "some updated email",
      "name" => "some updated name",
      "student_id" => "4321CBA",
      "is_client" => false,
      "is_coach" => false,
      "is_manager" => false}
  end

  test "does not update chosen user and renders errors when data is invalid", %{conn: conn} do
    user = fixture(:user)
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen user", %{conn: conn} do
    user = fixture(:user)
    conn = delete conn, user_path(conn, :delete, user)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, user)
    end
  end
end
