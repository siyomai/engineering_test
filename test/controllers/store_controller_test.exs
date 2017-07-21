defmodule EngineeringTest.StoreControllerTest do
  use EngineeringTest.ConnCase

  alias EngineeringTest.{
    Store,
    User
  }

  @valid_attrs %{is_open: true, name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    user =
      %User{}
      |> User.create_changeset(%{email: "samp@samp.com", password: "qwerty123", password_confirmation: "qwerty123"})
      |> Repo.insert!

    conn =
      build_conn()
      |> put_req_header("accept", "application/json")
      |> put_req_header("bearer", Phoenix.Token.sign(EngineeringTest.Endpoint, "user", user.id))
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, store_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    store = Repo.insert! %Store{}
    conn = get conn, store_path(conn, :show, store)
    assert json_response(conn, 200)["data"] == %{"id" => store.id,
      "name" => store.name,
      "is_open" => store.is_open}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, store_path(conn, :create), @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Store, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, store_path(conn, :create), @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    store = Repo.insert! %Store{}
    conn = put conn, store_path(conn, :update, store), @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Store, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    store = Repo.insert! %Store{}
    conn = put conn, store_path(conn, :update, store), @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end
end
