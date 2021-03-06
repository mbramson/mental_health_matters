defmodule MentalHealthMatters.Web.RegistrationController do
  @moduledoc """
  Handles Users registering for accounts and also logging in when they succeed
  at doing so.
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
    case Account.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> Plug.Conn.put_session(:current_user, user)
        |> redirect(to: "/upcoming_appointments")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
