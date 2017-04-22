defmodule MentalHealthMatters.Account.User do
  use Ecto.Schema

  schema "account_users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :is_client, :boolean, default: false
    field :is_coach, :boolean, default: false
    field :is_manager, :boolean, default: false

    timestamps()
  end
end
