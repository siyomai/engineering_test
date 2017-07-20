defmodule Engineeringtest.Plug.AssignsTest do
  use EngineeringTest.ConnCase, async: true

  alias EngineeringTest.{
    User,
    Repo
  }

  setup do
    user =
      %User{}
      |> User.create_changeset(%{email: "samp@samp.com", password: "qwerty123", password_confirmation: "qwerty123"})
      |> Repo.insert!

    conn =
      build_conn()
      |> put_req_header("accept", "application/json")
      |> put_req_header("bearer", Phoenix.Token.sign(EngineeringTest.Endpoint, "user", user.id))

    {:ok, conn: conn, user: user}
  end

  test "authenticate_by_token", %{conn: conn, user: user} do
    conn = EngineeringTest.Plug.Assigns.authenticate_by_token(conn, [])

    assert conn.assigns.current_user.id == user.id
  end


end
