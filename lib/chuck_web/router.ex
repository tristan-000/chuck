defmodule ChuckWeb.Router do
  use ChuckWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ChuckWeb do
    pipe_through :api

    get "/jokes", JokesController, :index
    post "/fav", JokesController, :fav
    post "/share", JokesController, :share
  end

end
