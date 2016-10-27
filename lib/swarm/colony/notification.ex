defmodule Swarm.Colony.Notification do
  alias Swarm.Ant

  def notify_queen(%Ant{has_food: true}, %Ant{location: {0, 0}}, nest) do
    Swarm.Colony.Queen.give_food(nest)
  end
  def notify_queen(_, _, _), do: :ok

  def notify_food_store(%Ant{has_food: false}, %Ant{has_food: true} = ant) do
    Swarm.Colony.FoodStore.take_one_food_from(ant.location)
  end
  def notify_food_store(_, _), do: :ok
end
