defmodule MentalHealthMatters.Repo.Migrations.MakeEmailsUnique do
  use Ecto.Migration

  def change do
    create unique_index(:account_users, [:email])
  end
end
