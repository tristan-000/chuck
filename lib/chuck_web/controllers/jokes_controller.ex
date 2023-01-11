defmodule ChuckWeb.JokesController do
  @moduledoc false
  use ChuckWeb, :controller

  def index(conn, params) do
    name = Map.get(params, "name")
    JokesSupervisor.start_session(name)
    jokes = JokesServer.jokes_list(name)
    json(conn, %{jokes: jokes})
  end

  def fav(conn, params) do
    name = Map.get(params, "name")
    id = Map.get(params, "id")
    favs = JokesServer.fav_joke(name, id)
    json(conn, %{favs: favs})
  end

  def share(conn, params) do
    name = Map.get(params, "name")
    id = Map.get(params, "id")
    share_with = Map.get(params, "share_with")
    JokesServer.share_joke(name, share_with, id)
    json(conn, %{})
  end

end
