defmodule EngineeringTest.StoreTest do
  use EngineeringTest.ModelCase

  alias EngineeringTest.Store

  @valid_attrs %{is_open: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Store.changeset(%Store{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Store.changeset(%Store{}, @invalid_attrs)
    refute changeset.valid?
  end
end
