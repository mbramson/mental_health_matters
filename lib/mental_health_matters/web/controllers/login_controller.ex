defmodule MentalHealthMatters.Web.LoginController do
  use MentalHealthMatters.Web, :controller

  alias MentalHealthMatters.Account
  alias MentalHealthMatters.Account.User

  action_fallback MentalHealthMatters.Web.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.login_user(user_params) do
      conn
      |> put_status(:ok)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("success.json", user: user)
    end
  end
end
