defmodule MentalHealthMatters.Session.Availability do
  use Ecto.Schema

  schema "session_availabilities" do
    field :start_time, :naive_datetime
    field :end_time, :naive_datetime
    belongs_to :coach, MentalHealthMatters.Account.User

    timestamps()
  end
end
