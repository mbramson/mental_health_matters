defmodule MentalHealthMatters.Repo.Migrations.AddStudentIdToUser do
  use Ecto.Migration

  def change do
    alter table(:account_users) do
      add :student_id, :string
    end
  end
end
