defmodule Swarm.Colony.Drone do
  use GenServer

  alias Swarm.Ant
  alias Swarm.Nest

  def create(%Ant{} = ant, %Nest{} = nest) do
    if_not_found(ant, &Supervisor.start_child(Swarm.Colony.Drone.Supervisor, [&1, nest]))
  end

  def start(%Ant{} = ant) do
    if_found(ant, &send(&1, :process))
  end

  def become_gatherer(%Ant{} = ant) do
    if_found(ant, &GenServer.cast(&1, {:become, Swarm.Colony.Drone.Behavior.Gatherer}))
  end
  def become_gatherer(ant) when is_pid(ant) do
    GenServer.cast(ant, {:become, Swarm.Colony.Drone.Behavior.Gatherer})
  end

  def become_forager(%Ant{} = ant) do
    if_found(ant, &GenServer.cast(&1, {:become, Swarm.Colony.Drone.Behavior.Forager}))
  end
  def become_forager(ant) when is_pid(ant) do
    GenServer.cast(ant, {:become, Swarm.Colony.Drone.Behavior.Forager})
  end

  def start_link(%Ant{} = ant, %Nest{} = nest) do
    state = Swarm.Colony.Drone.Behavior.Gatherer.initial_state(ant, nest)
    GenServer.start_link(__MODULE__, state, name: ref(ant))
  end

  def handle_cast({:become, module}, state) do
    new_state = module.initial_state(state.ant, state.nest)
    {:noreply, new_state}
  end

  def handle_info(:process, state) do
    new_state = state.behavior.process(state)
    spawn(Swarm.Colony.Notification, :notify_queen, [state.ant, new_state.ant, state.nest])
    spawn(Swarm.Colony.Notification, :notify_food_store, [state.ant, new_state.ant])
    send(self(), :process)
    {:noreply, new_state}
  end

  defp ref(%Ant{id: id}), do: {:global, {:drone, id}}

  defp if_found(ant, callback) do
    case GenServer.whereis(ref(ant)) do
      nil ->
        {:error, :drone_does_not_exist}
      drone ->
        callback.(drone)
    end
  end

  defp if_not_found(ant, callback) do
    case GenServer.whereis(ref(ant)) do
      nil ->
        callback.(ant)
      _ ->
        {:error, :drone_already_exists}
    end
  end
end
