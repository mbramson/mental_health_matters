defmodule MentalHealthMatters.Account.User do
  use Ecto.Schema

  schema "account_users" do
    field :email, :string
    field :name, :string
    field :student_id, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :is_client, :boolean, default: false
    field :is_coach, :boolean, default: false
    field :is_manager, :boolean, default: false

    timestamps()
  end
end
