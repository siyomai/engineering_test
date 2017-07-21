defmodule EngineeringTest.AuthControllerTest do
  use EngineeringTest.ConnCase

  alias EngineeringTest.User

  setup %{conn: conn} do
    user =
      %User{}
      |> User.create_changeset(%{email: "samp@samp.com", password: "qwerty123", password_confirmation: "qwerty123"})
      |> Repo.insert!

    conn =
      conn
      |> put_req_header("accept", "application/json")
    {:ok, conn: conn, user: user}
  end

  describe "User authentication" do
    test "user logs in succesfully and returns a token", %{conn: conn, user: user} do
      params = %{
        "email" => "samp@samp.com",
        "password" => "qwerty123"
      }
      conn = post conn, auth_path(conn, :create), params
      assert json_response(conn, 201)["data"]["email"] == user.email
      assert json_response(conn, 201)["data"]["token"]
    end

    test "user logs in unsuccesfully using invalid parameters", %{conn: conn} do
      params = %{
        "email" => "samp@samp.com",
        "password" => "sdasdasd"
      }
      conn = post conn, auth_path(conn, :create), params
      assert json_response(conn, 422)["errors"]["password"] == ["Invalid credentials."]
    end
  end
end
