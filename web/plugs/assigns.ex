defmodule EngineeringTest.Plug.Assigns do
  import Plug.Conn
  import Ecto.Query
  alias Engineeringtest.{
    Repo,
    User
  }

  @doc """
  Plug: authenticate by token
  """
  def authenticate_by_token(%{params: %{token: token}} = conn, _) do
    case Repo.get_by(User, api_token: token) do
      user ->
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
