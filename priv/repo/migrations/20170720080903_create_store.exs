defmodule EngineeringTest.Repo.Migrations.CreateStore do
  use Ecto.Migration

  def change do
    create table(:stores) do
      add :name, :string
      add :is_open, :boolean, default: false, null: false

      timestamps()
    end

  end
end
