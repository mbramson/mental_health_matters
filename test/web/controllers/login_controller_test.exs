defmodule MentalHealthMatters.Web.LoginControllerTest do
  use MentalHealthMatters.Web.ConnCase

  alias MentalHealthMatters.Account
  alias MentalHealthMatters.Account.User

  @create_attrs %{email: "some email", name: "some name", password: "password",
                  is_client: false, is_coach: false, is_manager: false}

  def fixture(:user) do
    {:ok, user} = Account.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create/2" do
    test "returns an ok status and the user when supplied correct credentials", %{conn: conn} do
      user = fixture(:user)
      login_attrs = %{email: user.email, password: @create_attrs[:password]}
      conn = post conn, login_path(conn, :create), user: login_attrs

      json_response_data =  json_response(conn, 200)["data"]
      assert json_response_data["status"] == "ok"
    end

    test "returns a 401 when supplied invalid credentials", %{conn: conn} do
      user = fixture(:user)
      login_attrs = %{email: user.email, password: "wrong_password"}
      conn = post conn, login_path(conn, :create), user: login_attrs

      assert json_response(conn, 401)
    end
  end
end
