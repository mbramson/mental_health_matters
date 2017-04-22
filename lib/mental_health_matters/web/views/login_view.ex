defmodule MentalHealthMatters.Web.LoginView do
  use MentalHealthMatters.Web, :view
  alias MentalHealthMatters.Web.LoginView
  alias MentalHealthMatters.Web.UserView

  def render("success.json", %{user: user}) do
    %{data: %{
        status: "ok",
        user: render_one(user, UserView, "user.json")}
     }
  end
end
