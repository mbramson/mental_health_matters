defmodule MentalHealthMatters.Account.User do
  use Ecto.Schema

  schema "account_users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string

    timestamps()
  end
end
