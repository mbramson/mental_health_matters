defmodule MentalHealthMatters.Repo.Migrations.CreateMentalHealthMatters.Account.User do
  use Ecto.Migration

  def change do
    create table(:account_users) do
      add :name, :string
      add :email, :string
      add :password_hash, :string

      timestamps()
    end

  end
end
