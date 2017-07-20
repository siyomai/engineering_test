defmodule EngineeringTest.StoreView do
  use EngineeringTest.Web, :view

  def render("index.json", %{stores: stores}) do
    %{data: render_many(stores, EngineeringTest.StoreView, "store.json")}
  end

  def render("show.json", %{store: store}) do
    %{data: render_one(store, EngineeringTest.StoreView, "store.json")}
  end

  def render("store.json", %{store: store}) do
    %{id: store.id,
      name: store.name,
      is_open: store.is_open}
  end
end