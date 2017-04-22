defmodule MentalHealthMatters.Web.AvailabilityView do
  use MentalHealthMatters.Web, :view
  alias MentalHealthMatters.Web.AvailabilityView
  alias MentalHealthMatters.Web.UserView

  def render("index.json", %{availabilities: availabilities}) do
    %{data: render_many(availabilities, AvailabilityView, "availability.json")}
  end

  def render("show.json", %{availability: availability}) do
    %{data: render_one(availability, AvailabilityView, "availability.json")}
  end

  def render("availability.json", %{availability: availability}) do
    %{id: availability.id,
      start_time: availability.start_time,
      end_time: availability.end_time,
      coach: render_one(availability.coach, UserView, "user.json") }
  end
end
