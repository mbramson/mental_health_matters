defmodule MentalHealthMatters.Session.Meeting do
  use Ecto.Schema

  schema "session_meetings" do
    field :meeting_time, :naive_datetime
    belongs_to :client, MentalHealthMatters.Account.User
    belongs_to :coach, MentalHealthMatters.Account.User

    timestamps()
  end
end
