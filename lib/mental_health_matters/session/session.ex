defmodule MentalHealthMatters.Session do
  @moduledoc """
  The boundary for the Session system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias MentalHealthMatters.Repo

  alias MentalHealthMatters.Session.Meeting
  alias MentalHealthMatters.Session.Availability

  def list_meetings do
    Repo.all(Meeting) |> Repo.preload([:client, :coach])
  end

  def list_users_upcoming_meetings(user) do
    user_id = user.id
    now = NaiveDateTime.utc_now()
    query = from meeting in Meeting,
      where: meeting.meeting_time > ^now,
      where: meeting.client_id == ^user_id
    Repo.all(query) |> Repo.preload([:client, :coach])
  end

  def get_meeting!(id) do
    Repo.get!(Meeting, id) |> Repo.preload([:client, :coach])
  end

  def create_meeting(attrs \\ %{}) do
    %Meeting{}
    |> meeting_changeset(attrs)
    |> Repo.insert()
    |> case do
      {:error, _} = error -> error
      {:ok, meeting} ->
        {:ok, meeting |> Repo.preload([:client, :coach])}
    end
  end

  def update_meeting(%Meeting{} = meeting, attrs) do
    meeting
    |> meeting_changeset(attrs)
    |> Repo.update()
    |> case do
      {:error, _} = error -> error
      {:ok, meeting} ->
        {:ok, meeting |> Repo.preload([:client, :coach])}
    end
  end

  def delete_meeting(%Meeting{} = meeting) do
    Repo.delete(meeting)
  end

  def change_meeting(%Meeting{} = meeting) do
    meeting_changeset(meeting, %{})
  end

  @changeset_attrs [:meeting_time, :client_id, :coach_id]
  @required_attrs [:meeting_time, :client_id, :coach_id]

  defp meeting_changeset(%Meeting{} = meeting, attrs) do
    meeting
    |> cast(attrs, @changeset_attrs)
    |> validate_required(@required_attrs)
  end

  def list_availabilities do
    Repo.all(Availability) |> Repo.preload(:coach)
  end

  def list_upcoming_availabilities do
    now = NaiveDateTime.utc_now()
    query = from availability in Availability,
      where: availability.end_time > ^now
    Repo.all(query) |> Repo.preload(:coach)
  end

  def get_availability!(id) do
    Repo.get!(Availability, id) |> Repo.preload(:coach)
  end

  def create_availability(attrs \\ %{}) do
    %Availability{}
    |> availability_changeset(attrs)
    |> Repo.insert()
    |> case do
      {:error, _} = error -> error
      {:ok, availability} ->
        {:ok, availability |> Repo.preload(:coach)}
    end
  end

  @changeset_attrs [:start_time, :end_time, :coach_id]
  @required_attrs [:start_time, :end_time, :coach_id]

  def availability_changeset(%Availability{} = availability, attrs) do
    availability
    |> cast(attrs, @changeset_attrs)
    |> validate_required(@required_attrs)
  end
end
