defmodule EngineeringTest.Repo.Migrations.AddUserToStore do
  use Ecto.Migration

  def change do
    alter table(:stores) do
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
    end
  end
end
