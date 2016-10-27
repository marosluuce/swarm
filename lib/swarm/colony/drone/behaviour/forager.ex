defmodule Swarm.Colony.Drone.Behavior.Forager do
  alias Swarm.Ant
  alias Swarm.Nest

  @max_radius 50

  def initial_state(%Ant{} = ant, %Nest{} = nest) do
    %{
      ant: ant,
      behavior: __MODULE__,
      target: ant.location,
      nest: nest,
      n: 0
    }
  end

  def process(%{ant: ant} = state) do
    if outside_bounds(ant) do
      Swarm.Colony.Drone.become_gatherer(ant)
    else
      ant.location
      |> Swarm.Move.calculate(state.target)
      |> move_towards_target(state)
    end
  end

  defp move_towards_target(:same, state) do
    new_n = state.n + 1
    {x, y} = Swarm.Spiral.get(new_n)
    %{state | target: {x * 2, y * 2}, n: new_n}
  end
  defp move_towards_target(direction, state) do
    updated_ant = Swarm.Command.move_ant(state.ant.id, direction)
    %{state | ant: updated_ant}
  end

  defp outside_bounds(ant) do
    {x, y} = ant.location
    abs(x) > @max_radius || abs(y) > @max_radius
  end
end
