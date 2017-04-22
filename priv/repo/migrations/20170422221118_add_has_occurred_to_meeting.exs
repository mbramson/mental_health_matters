defmodule MentalHealthMatters.Repo.Migrations.AddHasOccurredToMeeting do
  use Ecto.Migration

  def change do
    alter table(:session_meetings) do
      add :has_occurred, :boolean, null: false, default: false
    end
  end
end
