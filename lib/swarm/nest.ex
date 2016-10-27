defmodule Swarm.Nest do
  defstruct id: nil,
            name: nil,
            location: {0, 0},
            food: 0,
            ants: 0

  def create_ant(%Swarm.Nest{} = nest) do
    nest
    |> decrement_food
    |> increment_ants
  end

  def receive_food(%Swarm.Nest{} = nest) do
    update_in(nest.food, &(&1 + 1))
  end

  defp decrement_food(nest) do
    update_in(nest.food, &max(&1 - 1, 0))
  end

  defp increment_ants(nest) do
    update_in(nest.ants, &(&1 + 1))
  end
end
