defmodule EngineeringTest.StoreControllerTest do
  use EngineeringTest.ConnCase

  alias EngineeringTest.Store
  @valid_attrs %{is_open: true, name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
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

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, store_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, store_path(conn, :create), store: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Store, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, store_path(conn, :create), store: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    store = Repo.insert! %Store{}
    conn = put conn, store_path(conn, :update, store), store: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Store, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    store = Repo.insert! %Store{}
    conn = put conn, store_path(conn, :update, store), store: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    store = Repo.insert! %Store{}
    conn = delete conn, store_path(conn, :delete, store)
    assert response(conn, 204)
    refute Repo.get(Store, store.id)
  end
end
