defmodule MentalHealthMatters.SessionTest do
  use MentalHealthMatters.DataCase

  alias MentalHealthMatters.Session
  alias MentalHealthMatters.Session.Meeting
  alias MentalHealthMatters.Session.Availability

  @create_attrs %{meeting_time: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{meeting_time: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{meeting_time: nil}

  def fixture(:meeting, _attrs \\ @create_attrs) do
    insert(:meeting)
  end

  test "list_meetings/1 returns all meetings" do
    meeting = fixture(:meeting)
    assert Session.list_meetings() == [meeting]
  end

  test "list_users_upcoming_meetings/1 returns only future meetings" do
    current_user = insert(:user_client)
    _past_meeting = insert(:meeting, %{client: current_user, meeting_time: ~N[2000-01-01 12:00:00.000000]})
    future_meeting = insert(:meeting, %{client: current_user, meeting_time: ~N[2100-01-01 12:00:00.000000]})
     assert Session.list_users_upcoming_meetings(current_user) == [future_meeting]
  end

  test "get_meeting! returns the meeting with given id" do
    meeting = fixture(:meeting)
    assert Session.get_meeting!(meeting.id) == meeting
  end

  test "create_meeting/1 with valid data creates a meeting" do
    client = insert(:user_client)
    coach = insert(:user_coach)
    attrs = Map.merge(@create_attrs, %{client_id: client.id, coach_id: coach.id})
    assert {:ok, %Meeting{} = meeting} = Session.create_meeting(attrs)
    assert meeting.meeting_time == ~N[2010-04-17 14:00:00.000000]
    assert meeting.client.id == client.id
    assert meeting.coach.id == coach.id
  end

  test "create_meeting/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Session.create_meeting(@invalid_attrs)
  end

  test "update_meeting/2 with valid data updates the meeting" do
    meeting = fixture(:meeting)
    assert {:ok, meeting} = Session.update_meeting(meeting, @update_attrs)
    assert %Meeting{} = meeting
    assert meeting.meeting_time == ~N[2011-05-18 15:01:01.000000]
  end

  test "update_meeting/2 with invalid data returns error changeset" do
    meeting = fixture(:meeting)
    assert {:error, %Ecto.Changeset{}} = Session.update_meeting(meeting, @invalid_attrs)
    assert meeting == Session.get_meeting!(meeting.id)
  end

  test "delete_meeting/1 deletes the meeting" do
    meeting = fixture(:meeting)
    assert {:ok, %Meeting{}} = Session.delete_meeting(meeting)
    assert_raise Ecto.NoResultsError, fn -> Session.get_meeting!(meeting.id) end
  end

  test "change_meeting/1 returns a meeting changeset" do
    meeting = fixture(:meeting)
    assert %Ecto.Changeset{} = Session.change_meeting(meeting)
  end

  test "list_availabilies/1 returns all availabilities" do
    availability = insert(:availability)
    assert Session.list_availabilities() == [availability]
  end

  test "get_availability! returns the meeting with given id" do
    availability = insert(:availability)
    assert Session.get_availability!(availability.id) == availability
  end

  test "create_availability/1 with valid data creates a availability" do
    coach = insert(:user_coach)
    start_time = ~N[2010-04-17 14:00:00.000000]
    end_time = ~N[2010-04-17 16:00:00.000000]
    attrs = %{coach_id: coach.id, start_time: start_time, end_time: end_time}
    assert {:ok, %Availability{} = availability} = Session.create_availability(attrs)
    assert availability.start_time == start_time
    assert availability.end_time == end_time
    assert availability.coach.id == coach.id
  end

  test "create_availability/1 with invalid data returns error changeset" do
    invalid_attrs = %{coach_id: nil, start_time: nil, end_time: nil}
    assert {:error, %Ecto.Changeset{}} = Session.create_availability(invalid_attrs)
  end

end
