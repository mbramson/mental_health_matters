defmodule MentalHealthMatters.Session do
  @moduledoc """
  The boundary for the Session system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias MentalHealthMatters.Repo

  alias MentalHealthMatters.Session.Meeting

  @doc """
  Returns the list of meetings.

  ## Examples

      iex> list_meetings()
      [%Meeting{}, ...]

  """
  def list_meetings do
    Repo.all(Meeting) |> Repo.preload([:client, :coach])
  end

  @doc """
  Gets a single meeting.

  Raises `Ecto.NoResultsError` if the Meeting does not exist.

  ## Examples

      iex> get_meeting!(123)
      %Meeting{}

      iex> get_meeting!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meeting!(id) do 
    Repo.get!(Meeting, id) |> Repo.preload([:client, :coach])
  end

  @doc """
  Creates a meeting.

  ## Examples

      iex> create_meeting(%{field: value})
      {:ok, %Meeting{}}

      iex> create_meeting(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
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

  @doc """
  Updates a meeting.

  ## Examples

      iex> update_meeting(meeting, %{field: new_value})
      {:ok, %Meeting{}}

      iex> update_meeting(meeting, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
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

  @doc """
  Deletes a Meeting.

  ## Examples

      iex> delete_meeting(meeting)
      {:ok, %Meeting{}}

      iex> delete_meeting(meeting)
      {:error, %Ecto.Changeset{}}

  """
  def delete_meeting(%Meeting{} = meeting) do
    Repo.delete(meeting)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meeting changes.

  ## Examples

      iex> change_meeting(meeting)
      %Ecto.Changeset{source: %Meeting{}}

  """
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
end
