defmodule HotelWeb.Router do
  use HotelWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug(HotelWeb.Context)
  end

  scope "/", HotelWeb do
    #use the default browser stack
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
   scope "/" do
    pipe_through :api

    forward(
      "/api", Absinthe.Plug,
      schema: HotelWeb.Schema,
      socket: HotelWeb.UserSocket
    )

    forward(
      "/graphiql", Absinthe.Plug.GraphiQL,
      schema: HotelWeb.Schema,
      socket: HotelWeb.UserSocket,
      interface: :playground
    )
   end
end
