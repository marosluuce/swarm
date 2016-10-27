defmodule Swarm.Colony.Drone.Behavior.Gatherer do
  alias Swarm.Ant
  alias Swarm.Nest

  def initial_state(%Ant{} = ant, %Nest{} = nest) do
    %{
      ant: ant,
      behavior: __MODULE__,
      target: ant.location,
      nest: nest,
    }
  end

  def process(%{ant: %Ant{has_food: true}} = state) do
    state.ant.location
    |> Swarm.Move.calculate({0, 0})
    |> move_towards_target(state)
  end
  def process(state) do
    best_target = find_best_target(state.ant, state.target)

    state.ant.location
    |> Swarm.Move.calculate(best_target)
    |> move_towards_target(state)
  end

  def find_best_target(ant, target) do
    case closest_food_to(ant) do
      [h | _] -> h
      _ -> target
    end
  end

  defp move_towards_target(:same, state) do
    %{state | target: new_target()}
  end
  defp move_towards_target(direction, state) do
    updated_ant = Swarm.Command.move_ant(state.ant.id, direction)
    %{state | ant: updated_ant}
  end

  defp new_target() do
    Location.random(25)
  end

  defp closest_food_to(ant) do
    Swarm.Colony.FoodStore.fetch_all_locations()
    |> Enum.sort_by(&Location.distance_squared(&1, ant.location))
  end
end
