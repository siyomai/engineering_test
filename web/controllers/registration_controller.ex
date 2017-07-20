defmodule EngineeringTest.RegistrationController do
  use EngineeringTest.Web, :controller

  alias EngineeringTest.User

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EngineeringTest.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
