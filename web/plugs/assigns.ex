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
    {"bearer", token} = Enum.find(headers, fn({key, _val}) -> key == "bearer" end)
    case Phoenix.Token.verify(EngineeringTest.Endpoint, "user", token) do
      {:ok, user_id} ->
        user = Repo.get!(User, user_id)
        assign(conn, :current_user, user)
      _ ->
        conn
    end
  end

  @doc """
  Plug: assigns a `product` record.
  """
  def assign_product(%{params: %{"product_id" => slug}} = conn, _) do
    product = Repo.get_by(Product, slug: slug, merchant_id: conn.assigns.merchant.id)

    conn
    |> assign(:product, product)
  end
end
