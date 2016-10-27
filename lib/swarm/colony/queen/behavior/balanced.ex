defmodule Swarm.Colony.Queen.Behaviour.Balanced do
  @num_foragerers 1
  @threshold 3
  @ratio 1.2

  def process(%{nest: nest} = state) do
    if good_ratio_of_food_to_ants(nest) do
        ant = Swarm.Command.create_ant(nest.id)
        Swarm.Colony.Drone.create(ant, nest)

        if should_become_forager(nest) do
          Swarm.Colony.Drone.become_forager(ant)
        end

        Swarm.Colony.Drone.start(ant)

        %{state | nest: Swarm.Nest.create_ant(nest)}
    else
      state
    end
  end

  defp should_become_forager(%Swarm.Nest{ants: ants}) when ants < @num_foragerers, do: true
  defp should_become_forager(_), do: false

  defp good_ratio_of_food_to_ants(%Swarm.Nest{ants: ants}) when ants < @threshold, do: true
  defp good_ratio_of_food_to_ants(nest) do
    :math.log(nest.food) / :math.log(nest.ants) >= @ratio
  end
end
