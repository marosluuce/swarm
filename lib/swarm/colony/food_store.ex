defmodule Swarm.Colony.FoodStore do
  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def examine(surroundings) do
    updated_store = surroundings
    |> Enum.filter(fn s -> s["type"] == "food" end)
    |> Enum.reduce(%{}, fn(s, acc) ->
      location = s["location"] |> List.to_tuple
      Map.put(acc, location, s["quantity"])
    end)

    Agent.update(__MODULE__, &Map.merge(updated_store, &1))
  end

  def fetch_all_locations do
    Agent.get(__MODULE__, &(&1))
    |> Enum.filter_map(fn {_, amount} -> amount > 1 end,
                       fn {location, _} -> location end)
  end

  def take_one_food_from(location) do
    Agent.update(__MODULE__, &Map.update!(&1, location, fn n -> n - 1 end))
  end
end
