defmodule MentalHealthMatters.Repo.Migrations.CreateMentalHealthMatters.Session.Meeting do
  use Ecto.Migration

  def change do
    create table(:session_meetings) do
      add :meeting_time, :naive_datetime
      add :client_id, references(:account_users, on_delete: :nilify_all)
      add :coach_id, references(:account_users, on_delete: :nilify_all)

      timestamps()
    end

  end
end
