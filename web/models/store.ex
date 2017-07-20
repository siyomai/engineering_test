defmodule EngineeringTest.Store do
  use EngineeringTest.Web, :model

  schema "stores" do
    field :name, :string
    field :is_open, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :is_open])
    |> validate_required([:name, :is_open])
  end
end
