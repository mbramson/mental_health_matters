defmodule MentalHealthMatters.Web.MeetingView do
  use MentalHealthMatters.Web, :view
  alias MentalHealthMatters.Web.MeetingView
  alias MentalHealthMatters.Web.UserView

  def render("index.json", %{meetings: meetings}) do
    %{data: render_many(meetings, MeetingView, "meeting.json")}
  end

  def render("show.json", %{meeting: meeting}) do
    %{data: render_one(meeting, MeetingView, "meeting.json")}
  end

  def render("meeting.json", %{meeting: meeting}) do
    %{id: meeting.id,
      meeting_time: meeting.meeting_time,
      client: render_one(meeting.client, UserView, "user.json"),
      coach: render_one(meeting.coach, UserView, "user.json") }
  end
end
