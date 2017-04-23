defmodule MentalHealthMatters.Web.UpcomingAppointmentController do
  @moduledoc """
  Handles Users registering for accounts and also logging in when they succeed
  at doing so.
  """
  use MentalHealthMatters.Web, :controller

  alias MentalHealthMatters.Account.User
  alias MentalHealthMatters.Session
  alias MentalHealthMatters.Session.Meeting

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    meetings = Session.list_users_upcoming_meetings(current_user)
    render(conn, "index.html", meetings: meetings)
  end
end
