defmodule MentalHealthMatters.Repo.Migrations.AddUserTypes do
  use Ecto.Migration

  def change do
    alter table(:account_users) do
      modify :name, :string, null: false
      modify :email, :string, null: false
      add :is_client, :boolean, null: false, default: false
      add :is_coach, :boolean, null: false, default: false
      add :is_manager, :boolean, null: false, default: false
    end
  end
end
