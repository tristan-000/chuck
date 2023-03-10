defmodule JokesSupervisor do
  @moduledoc false
  require Logger
  use DynamicSupervisor

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, [name: __MODULE__])
  end

  @impl true
  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_session(name) do
    pid = Process.whereis(String.to_atom(name))
    case pid do
      nil -> DynamicSupervisor.start_child(__MODULE__, {JokesServer, name})
      _ -> {:ok, pid}
    end

  end
end
