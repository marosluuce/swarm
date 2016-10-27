defmodule Swarm.Command do

  def join(name, client \\ Swarm.Client) do
    case client.join(name) do
      {:ok, data} -> process(data)
    end
  end

  def create_ant(nest_id, client \\ Swarm.Client) do
    case client.create(nest_id) do
      {:ok, data} -> process(data)
    end
  end

  def move_ant(ant_id, direction, client \\ Swarm.Client) do
    case client.move(ant_id, direction) do
      {:ok, data} -> process(data)
    end
  end

  defp process(%{"type" => "nest"} = data), do: convert_to_nest(data)
  defp process(%{"type" => "ant"} = data) do
    surroundings = data["surroundings"] |> Map.values |> List.flatten
    spawn(Swarm.Colony.FoodStore, :examine, [surroundings])
    convert_to_ant(data)
  end

  defp convert_to_nest(data) do
    %Swarm.Nest{
      id: data["id"],
      name: data["team"],
      location: data["location"] |> List.to_tuple,
      food: data["food"],
      ants: data["ants"]
    }
  end

  defp convert_to_ant(data) do
    %Swarm.Ant{
      id: data["id"],
      nest_id: data["nest"],
      location: data["location"] |> List.to_tuple,
      has_food: data["got_food"]
    }
  end
end
