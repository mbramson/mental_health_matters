defmodule MentalHealthMatters.Web.AvailabilityControllerTest do
  use MentalHealthMatters.Web.ConnCase

  alias MentalHealthMatters.Session.Availability

  @create_attrs %{start_time: ~N[2010-04-17 14:00:00.000000], end_time: ~N[2010-04-17 16:00:00.000000]}
  @invalid_attrs %{start_time: nil, end_time: nil}

  def fixture(:availability) do
    insert(:availability)
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists no entries on index when there are none", %{conn: conn} do
    conn = get conn, availability_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "lists all entries on index", %{conn: conn} do
    original_availability = insert(:availability)
    conn = get conn, availability_path(conn, :index)
    assert [availability] = json_response(conn, 200)["data"]
    assert original_availability.id == availability["id"]
  end

  test "creates meeting and renders meeting when data is valid", %{conn: conn} do
    coach = insert(:user_coach)
    attrs = Map.merge(@create_attrs, %{coach_id: coach.id})
    conn = post conn, availability_path(conn, :create), availability: attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, availability_path(conn, :show, id)
    coach_id = coach.id
    json_response_data = json_response(conn, 200)["data"]
    assert id == json_response_data["id"]
    assert "2010-04-17T14:00:00.000000" == json_response_data["start_time"]
    assert "2010-04-17T16:00:00.000000" == json_response_data["end_time"]
    assert coach_id == json_response_data["coach"]["id"]
  end

  test "does not create meeting and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, availability_path(conn, :create), availability: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end
end
