defmodule EngineeringTest.Repo.Migrations.CreateStore do
  use Ecto.Migration

  def change do
    create table(:stores, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :is_open, :boolean, default: false, null: false

      timestamps()
    end

  end
end
