defmodule MentalHealthMatters.Web.AssessmentController do
  use MentalHealthMatters.Web, :controller

  alias MentalHealthMatters.Account
  alias MentalHealthMatters.Account.User

  plug :scrub_params, "user" when action in [:create]

  def index(conn, _params) do
    render(conn, "assessment.html")
  end
end
