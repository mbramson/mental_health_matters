defmodule MentalHealthMatters.Web.UserView do
  use MentalHealthMatters.Web, :view
  alias MentalHealthMatters.Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      is_client: user.is_client,
      is_coach: user.is_coach,
      is_manager: user.is_manager}
  end
end
