defmodule MentalHealthMatters.Web.AvailabilityController do
  use MentalHealthMatters.Web, :controller

  alias MentalHealthMatters.Session
  alias MentalHealthMatters.Session.Availability

  action_fallback MentalHealthMatters.Web.FallbackController

  def index(conn, _params) do
    availabilities = Session.list_availabilities()
    render(conn, "index.json", availabilities: availabilities)
  end

  def create(conn, %{"availability" => availability_params}) do
    with {:ok, %Availability{} = availability} <- Session.create_availability(availability_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", availability_path(conn, :show, availability))
      |> render("show.json", availability: availability)
    end
  end

  def show(conn, %{"id" => id}) do
    availability = Session.get_availability!(id)
    render(conn, "show.json", availability: availability)
  end
end
