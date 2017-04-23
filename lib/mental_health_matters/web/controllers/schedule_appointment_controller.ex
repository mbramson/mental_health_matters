defmodule MentalHealthMatters.Web.ScheduleAppointmentController do
  use MentalHealthMatters.Web, :controller

  alias MentalHealthMatters.Account
  alias MentalHealthMatters.Account.User
  alias MentalHealthMatters.Session
  alias MentalHealthMatters.Session.Meeting

  def new(conn, _params) do
    availabilities = Session.list_upcoming_availabilities()
    changeset = Session.change_meeting(%Meeting{})
    coaches = Account.list_coaches
    IO.inspect availabilities
    render(conn, "new.html", availabilities: availabilities, changeset: changeset, coaches: coaches)
  end

  def create(conn, %{"meeting" => params}) do
    params = Map.merge(params, %{"client_id" => conn.assigns.current_user.id})
    case Session.create_meeting(params) do
      {:ok, meeting} ->
        conn
        |> put_flash(:info, "Appointment scheduled successfully.")
        |> redirect(to: "/upcoming_appointments")
      _ ->
        conn
        |> put_flash(:error, "Error scheduling appointment")
        |> redirect(to: "/schedule_appointment/new")
    end
  end
end
