defmodule Swarm.Colony.Queen do
  use GenServer

  def create(%Swarm.Nest{} = nest) do
    case GenServer.whereis(ref(nest)) do
      nil ->
        Supervisor.start_child(
          Swarm.Colony.Supervisor,
          Supervisor.Spec.worker(__MODULE__, [nest])
        )
      _ ->
        {:error, :queen_already_exists}
    end
  end

  def start(nest) do
    case GenServer.whereis(ref(nest)) do
      nil ->
        {:error, :queen_does_not_exist}
      queen ->
        send(queen, :process)
    end
  end

  def give_food(nest) do
    case GenServer.whereis(ref(nest)) do
      nil ->
        {:error, :queen_does_not_exist}
      queen ->
        GenServer.cast(queen, :receive_food)
    end
  end

  def start_link(%Swarm.Nest{} = nest) do
    state = %{nest: nest, behavior: Swarm.Colony.Queen.Behaviour.Balanced}
    GenServer.start_link(__MODULE__, state, name: ref(nest))
  end

  def handle_cast(:receive_food, %{nest: nest} = state) do
    {:noreply, %{state | nest: Swarm.Nest.receive_food(nest)}}
  end

  def handle_info(:process, state) do
    new_state = state.behavior.process(state)
    send(self(), :process)
    {:noreply, new_state}
  end

  defp ref(%Swarm.Nest{id: id}), do: {:global, {:queen, id}}
end
