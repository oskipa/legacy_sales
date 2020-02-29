defmodule SalesAdminWeb.Router do
  use SalesAdminWeb, :router

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

  scope "/", SalesAdminWeb do
    pipe_through :browser


    post "/sales/legacy_import", SalesController, :process_legacy_import
    get "/sales/legacy_import", SalesController, :legacy_import
    get "/sales", SalesController, :index
    get "/", SalesController, :index
    #get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SalesAdminWeb do
  #   pipe_through :api
  # end
end
