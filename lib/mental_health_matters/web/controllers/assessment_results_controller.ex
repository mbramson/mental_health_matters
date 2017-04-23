defmodule MentalHealthMatters.Web.AssessmentResultsController do
  use MentalHealthMatters.Web, :controller

  alias MentalHealthMatters.Account
  alias MentalHealthMatters.Account.User

  plug :scrub_params, "user" when action in [:create]

  def index(conn, _params) do
    render(conn, "results.html")
  end
end
