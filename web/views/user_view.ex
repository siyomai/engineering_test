defmodule EngineeringTest.UserView do
  use EngineeringTest.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, EngineeringTest.UserView, "user.json")}
  end

  def render("show.json", %{user: user, token: token}) do
    %{
      data: %{
        email: user.email,
        token: token
      }
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
    }
  end
end
