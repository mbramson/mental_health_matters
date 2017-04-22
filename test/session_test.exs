defmodule MentalHealthMatters.SessionTest do
  use MentalHealthMatters.DataCase

  alias MentalHealthMatters.Session
  alias MentalHealthMatters.Session.Meeting

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
end
