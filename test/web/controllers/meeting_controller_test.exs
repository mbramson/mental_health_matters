defmodule MentalHealthMatters.Web.MeetingControllerTest do
  use MentalHealthMatters.Web.ConnCase

  alias MentalHealthMatters.Session.Meeting

  @create_attrs %{meeting_time: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{meeting_time: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{meeting_time: nil}

  def fixture(:meeting) do
    insert(:meeting)
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, meeting_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates meeting and renders meeting when data is valid", %{conn: conn} do
    client = insert(:user_client)
    coach = insert(:user_coach)
    attrs = Map.merge(@create_attrs, %{client_id: client.id, coach_id: coach.id})
    conn = post conn, meeting_path(conn, :create), meeting: attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, meeting_path(conn, :show, id)
    client_id = client.id
    coach_id = coach.id
    json_response_data = json_response(conn, 200)["data"]
    assert id == json_response_data["id"]
    assert "2010-04-17T14:00:00.000000" == json_response_data["meeting_time"]
    assert client_id == json_response_data["client"]["id"]
    assert coach_id == json_response_data["coach"]["id"]
  end

  test "does not create meeting and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, meeting_path(conn, :create), meeting: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen meeting and renders meeting when data is valid", %{conn: conn} do
    %Meeting{id: id} = meeting = fixture(:meeting)
    conn = put conn, meeting_path(conn, :update, meeting), meeting: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, meeting_path(conn, :show, id)
    client_id = meeting.client.id
    coach_id = meeting.coach.id
    assert %{ "id" => ^id,
              "meeting_time" => "2011-05-18T15:01:01.000000",
              "client" => %{"id" => ^client_id},
              "coach" => %{"id" => ^coach_id}} = json_response(conn, 200)["data"]
  end

  test "does not update chosen meeting and renders errors when data is invalid", %{conn: conn} do
    meeting = fixture(:meeting)
    conn = put conn, meeting_path(conn, :update, meeting), meeting: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen meeting", %{conn: conn} do
    meeting = fixture(:meeting)
    conn = delete conn, meeting_path(conn, :delete, meeting)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, meeting_path(conn, :show, meeting)
    end
  end
end
