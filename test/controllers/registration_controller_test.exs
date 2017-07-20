defmodule EngineeringTest.RegistrationControllerTest do
  use EngineeringTest.ConnCase

  alias EngineeringTest.User

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  describe "User registration" do
    test "when user signs up succesfully and returns a token", %{conn: conn} do
      params = %{
        "user" => %{
          "email" => "samp@samp.com",
          "password" => "qwerty123",
          "password_confirmation" => "qwerty123"
        }
      }
      conn = post conn, auth_path(conn, :create), params
      user = Repo.get_by(User, email: "samp@samp.com")

      assert json_response(conn, 201)["data"]["email"] == "samp@samp.com"
      assert user
      assert json_response(conn, 201)["data"]["token"]
    end

    test "when user signs up unsuccesfully using invalid parameters", %{conn: conn} do
      params = %{
        "user" => %{
          "email" => "samp@samp.com",
          "password" => "sdasdasd",
          "password" => "something_else"
        }
      }
      conn = post conn, auth_path(conn, :create), params
      assert json_response(conn, 422)["errors"]["password"] == ["Invalid credentials."]
    end
  end
end
