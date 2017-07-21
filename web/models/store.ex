defmodule EngineeringTest.Store do
  use EngineeringTest.Web, :model

  defmodule Location do
    use Ecto.Schema

    embedded_schema do
      field :longitude, :float, default: 0.0
      field :latitude, :float, default: 0.0
    end

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:longitude, :latitude])
    end
  end

  schema "stores" do
    field :name, :string
    field :is_open, :boolean, default: false
    field :tags, :string
    field :description, :string
    embeds_one :location, Location

    belongs_to :user, EngineeringTest.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :is_open, :tags, :description, :user_id])
    |> validate_required([:name, :is_open])
    |> cast_embed(:location)
  end
end
