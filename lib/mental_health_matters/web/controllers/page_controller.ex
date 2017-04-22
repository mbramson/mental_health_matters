defmodule MentalHealthMatters.Web.PageController do
  use MentalHealthMatters.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
