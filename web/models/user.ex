defmodule EngineeringTest.User do
  use EngineeringTest.Web, :model
  alias Authsense.Service, as: Auth

  schema "users" do
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :stores, EngineeringTest.Store

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password, :password_confirmation])
  end

  def auth_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> validate_required([:email, :password])
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, ~r/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    |> validate_confirmation(:password, message: "password confirmation doesn't match")
    |> unique_constraint(:email)
    |> Auth.generate_hashed_password(Persistence.User)
  end

end
