defmodule MentalHealthMatters.Web.PageControllerTest do
  use MentalHealthMatters.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Blueline"
  end
end
