defmodule MentalHealthMatters.Web.SigninController do
  @moduledoc """
  Handles logging into an account and logging out.
  """
  use MentalHealthMatters.Web, :controller

  alias MentalHealthMatters.Account
  alias MentalHealthMatters.Account.User

  plug :scrub_params, "user" when action in [:create]

  @spec new(%Plug.Conn{}, map()) :: %Plug.Conn{}
  def new(conn, _params) do
    changeset = Account.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  @spec create(%Plug.Conn{}, map()) :: %Plug.Conn{}
  def create(conn, %{"user" => user_params}) do
    case Account.login_user(user_params) do
      {:ok, user} ->
        conn
        |> Plug.Conn.put_session(:current_user, user)
        |> put_flash(:info, "Successfully logged in!")
        |> redirect(to: "/")
      _ ->
        conn
        |> put_flash(:info, "Invalid Credentials")
        |> render(conn, "new.html", changeset: Account.change_user(%User{}))
    end
  end

  def delete(conn, _) do
    conn
    |> Plug.Conn.delete_session(:current_user)
    |> put_flash(:info, "Logged out!")
    |> redirect(to: signin_path(conn, :new))
  end
end
