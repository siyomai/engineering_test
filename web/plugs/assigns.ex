defmodule EngineeringTest.Plug.Assigns do
  import Plug.Conn
  import Ecto.Query

  alias EngineeringTest.{
    Repo,
    User
  }

  @doc """
  Plug: authenticate by token
  """
  def authenticate_by_token(%{req_headers: headers} = conn, _) do
    if Enum.find(headers, fn({key, _val}) -> key == "bearer" end) do
      {"bearer", token} = Enum.find(headers, fn({key, _val}) -> key == "bearer" end)
      case Phoenix.Token.verify(EngineeringTest.Endpoint, "user", token) do
        {:ok, user_id} ->
          user = Repo.get!(User, user_id)
          assign(conn, :current_user, user)
        _ ->
          assign(conn, :error, "Invalid token.")
      end
    else
      assign(conn, :error, "No token provided.")
    end
  end
end
