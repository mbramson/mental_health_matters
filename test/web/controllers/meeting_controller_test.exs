defmodule MentalHealthMatters.Web.MeetingControllerTest do
  use MentalHealthMatters.Web.ConnCase

  alias MentalHealthMatters.Session
  alias MentalHealthMatters.Session.Meeting

  @create_attrs %{meeting_time: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{meeting_time: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{meeting_time: nil}

  def fixture(:meeting) do
    {:ok, meeting} = Session.create_meeting(@create_attrs)
    meeting
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, meeting_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates meeting and renders meeting when data is valid", %{conn: conn} do
    conn = post conn, meeting_path(conn, :create), meeting: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, meeting_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "meeting_time" => ~N[2010-04-17 14:00:00.000000]}
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
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "meeting_time" => ~N[2011-05-18 15:01:01.000000]}
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
