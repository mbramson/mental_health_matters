defmodule MentalHealthMatters.Plug.AssignCurrentUser do
  import Plug.Conn

  alias MentalHealthMatters.Account.User

  @spec init(keyword()) :: keyword()
  def init(opts) do
    opts
  end

  @spec call(%Plug.Conn{}, keyword()) :: %Plug.Conn{}
  def call(conn, _opts) do
    assign_current_user(conn)
  end

  @spec assign_current_user(%Plug.Conn{}) :: %Plug.Conn{}
  defp assign_current_user(conn = %Plug.Conn{}) do
    current_user = conn.assigns[:current_user] || Plug.Conn.get_session(conn, :current_user)
    assign_current_user(conn, current_user)
  end

  @spec assign_current_user(%Plug.Conn{}, any()) :: %Plug.Conn{}
  defp assign_current_user(conn, user = %User{}) do
    assign(conn, :current_user, user)
  end
  defp assign_current_user(conn, _), do: conn
end
