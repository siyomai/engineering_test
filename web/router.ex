defmodule EngineeringTest.Router do
  use EngineeringTest.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EngineeringTest do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", EngineeringTest do
    pipe_through :api

    resources "/stores", StoreController, except: [:new, :edit]
  end
end
