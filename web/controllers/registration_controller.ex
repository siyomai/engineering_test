defmodule EngineeringTest.RegistrationController do
  use EngineeringTest.Web, :controller

  alias EngineeringTest.User

  def create(conn, user_params) do
    changeset = User.create_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render(EngineeringTest.UserView, "show.json", user: user, token: Phoenix.Token.sign(conn, "user", user.id))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EngineeringTest.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
