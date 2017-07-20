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

  def create(conn, %{"store" => store_params}) do
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

  def show(conn, %{"id" => id}) do
    store = Repo.get!(Store, id)
    render(conn, "show.json", store: store)
  end

  def update(conn, %{"id" => id, "store" => store_params}) do
    store = Repo.get!(Store, id)
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

  def delete(conn, %{"id" => id}) do
    store = Repo.get!(Store, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(store)

    send_resp(conn, :no_content, "")
  end
end
