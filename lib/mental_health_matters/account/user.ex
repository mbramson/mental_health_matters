defmodule MentalHealthMatters.Account.User do
  use Ecto.Schema

  schema "account_users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :is_client, :boolean
    field :is_coach, :boolean
    field :is_manager, :boolean

    timestamps()
  end
end
