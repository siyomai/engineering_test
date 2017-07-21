defmodule EngineeringTest.Repo.Migrations.AddFieldsToStore do
  use Ecto.Migration

  def change do
    alter table(:stores) do
      add :tags, :string
      add :description, :string
      add :location, :map
    end
  end
end
