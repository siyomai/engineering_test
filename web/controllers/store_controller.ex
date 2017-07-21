defmodule EngineeringTest.StoreController do
  use EngineeringTest.Web, :controller
  import EngineeringTest.Plug.Assigns

  alias EngineeringTest.Store

  plug :authenticate_by_token

  def index(%{assigns: %{current_user: current_user}} = conn, _params) do
    stores =
      from(s in Store, where: s.user_id == ^current_user.id)
      |> Repo.all

    render(conn, "index.json", stores: stores)
  end
  def index(%{assigns: %{error: error}} = conn, _params) do
    render(conn, EngineeringTest.ErrorView, "error.json", error: error)
  end

  def create(%{assigns: %{current_user: current_user}} = conn, store_params) do
    store_params = Map.put(store_params, "user_id", current_user.id)
    changeset = Store.changeset(%Store{}, store_params)

    case Repo.insert(changeset) do
      {:ok, store} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", store_path(conn, :show, store))
        |> render("show.json", store: store)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EngineeringTest.ChangesetView, "error.json", changeset: changeset)
    end
  end
  def create(%{assigns: %{error: error}} = conn, _params) do
    render(conn, EngineeringTest.ErrorView, "error.json", error: error)
  end

  def show(%{assigns: %{current_user: current_user}} = conn, %{"id" => id}) do
    store = Repo.get!(Store, id)
    render(conn, "show.json", store: store)
  end
  def show(%{assigns: %{error: error}} = conn, _params) do
    render(conn, EngineeringTest.ErrorView, "error.json", error: error)
  end

  def update(%{assigns: %{current_user: current_user}} = conn, store_params) do
    store = Repo.get!(Store, store_params["id"])
    changeset = Store.changeset(store, store_params)

    case Repo.update(changeset) do
      {:ok, store} ->
        render(conn, "show.json", store: store)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EngineeringTest.ChangesetView, "error.json", changeset: changeset)
    end
  end
  def update(%{assigns: %{error: error}} = conn, _params) do
    render(conn, EngineeringTest.ErrorView, "error.json", error: error)
  end
end
