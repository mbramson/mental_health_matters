defmodule MentalHealthMatters.Web.ScheduleAvailabilityController do
  use MentalHealthMatters.Web, :controller

  alias MentalHealthMatters.Account
  alias MentalHealthMatters.Account.User
  alias MentalHealthMatters.Session
  alias MentalHealthMatters.Session.Availability

  def new(conn, _params) do
    if conn.assigns.current_user.is_coach do
      changeset = Session.availability_changeset(%Availability{}, %{})
      render(conn, "new.html", changeset: changeset)
    else
      conn
      |> put_flash(:error, "You must be a coach to access this")
      |> redirect(to: "/")
    end
  end

  def create(conn, %{"schedule_appointment" => params}) do
    case Session.create_availability(params) do
      {:ok, availability} ->
        conn
        |> put_flash(:info, "Availability scheduled successfully.")
        |> redirect(to: "/upcoming_appointments")
      _ ->
        conn
        |> put_flash(:error, "Error scheduling availability")
        |> redirect(to: "/")
    end
  end
end
