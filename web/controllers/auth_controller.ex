defmodule EngineeringTest.AuthController do
  use EngineeringTest.Web, :controller
  import Authsense.Plug

  alias EngineeringTest.User
  alias Authsense.Service, as: Auth
  alias Authsense.Plug, as: AuthPlug

  def create(conn, user_params) do
    changeset = User.auth_changeset(%User{}, user_params)
    case Auth.authenticate(changeset, User) do
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
