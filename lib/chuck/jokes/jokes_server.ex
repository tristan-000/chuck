defmodule JokesServer do
  @moduledoc false
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: process_name(name))
  end

  defp process_name(name) do
    # this is used to avoid having to implement user identification/authentication system for this demo
    # in any real world application this would not be the way!
    String.to_atom(name)
  end

  def init(_opts) do
    jokes = get_jokes()
    state =  %{:random => jokes, :fav => [], shared: []}
    {:ok, state}
  end

  def handle_call(:jokes, _from, jokes) do
    {:reply, jokes, jokes}
  end

  def handle_call({:fav, id}, _from, jokes) do
    fav = Enum.find(jokes.random, fn joke -> joke["id"] == id end)
    exists = Enum.find(jokes.fav, fn joke -> joke["id"] == id end)
    newFavs = case {fav, exists} do
      {f, nil} when not is_nil(f)-> jokes.fav ++ [fav]
      {_, _} -> jokes.fav
    end
    newState = %{jokes | :fav => newFavs}
    {:reply, newFavs, newState}
  end

  def handle_call({:share, id, with}, _from, jokes) do
    favs = jokes.fav
    joke = Enum.find(favs, fn joke -> joke["id"] == id end)
    pname = process_name(with)
    pid = Process.whereis(pname)
    case {pid, joke} do
      {nil, _} -> {:reply, :unknown_receiver, jokes}
      {_, nil} -> {:reply, :unknown_joke, jokes}
      _ -> GenServer.cast(pname, {:receive, joke})
           {:reply, :ok, jokes}
    end
  end

  def handle_cast({:receive, joke}, jokes) do
    shared = jokes.shared
    new_state = %{jokes | :shared => shared ++ [joke]}
    {:noreply, new_state}
  end

  def handle_cast(_msg, state) do
    {:noreply, state}
  end

  def jokes_list(name) do
    pname = process_name(name)
    GenServer.call(pname, :jokes)
  end

  def fav_joke(name, id) do
    pname = process_name(name)
    GenServer.call(pname, {:fav, id})
  end

  def share_joke(name, with, id) do
    pname = process_name(name)
    GenServer.call(pname, {:share, id, with})
  end

  defp get_joke() do
    url = "https://api.chucknorris.io/jokes/random"
    res = HTTPoison.get!(url)
    Poison.decode!(res.body)
  end

  defp get_jokes() do
    get_jokes([])
  end

  defp get_jokes(jokes) when length(jokes) < 3 do
    joke = get_joke()
    get_jokes(jokes ++ [joke])
  end

  defp get_jokes(jokes) do
    jokes
  end


end
