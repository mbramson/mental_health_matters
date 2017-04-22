defmodule MentalHealthMatters.Repo.Migrations.CreateSessionAvailabilities do
  use Ecto.Migration

  def change do
    create table(:session_availabilities) do
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :coach_id, references(:account_users, on_delete: :delete_all)

      timestamps()
    end
  end
end
