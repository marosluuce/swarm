defmodule Swarm.CommandTest do
  use ExUnit.Case, async: true

  defmodule FakeClient do
    def join(name) do
      {:ok, %{"id" => 1, "name" => name, "location" => [0, 0], "food" => 3}}
    end

    def create(nest_id) do
      {:ok, %{"id" => 1, "nest_id" => nest_id, "location" => [1, 3], "has_food" => true}}
    end

    def move(ant_id, _) do
      {:ok, %{"id" => ant_id, "nest_id" => 1, "location" => [4, 2], "has_food" => true}}
    end
  end

  test "joining with a team name" do
    name = "team"

    assert %Swarm.Nest{
      id: _,
      name: ^name,
      location: {0, 0},
      food: 3
    } = Swarm.Command.join(FakeClient, name)
  end

  test "creating an ant" do
    nest_id = 2

    assert %Swarm.Ant{
      id: _,
      nest_id: ^nest_id,
      location: {1, 3},
      has_food: true
    } = Swarm.Command.create_ant(FakeClient, nest_id)
  end

  test "moving an ant" do
    ant_id = 3

    assert %Swarm.Ant{
      id: _,
      nest_id: 1,
      location: {4, 2},
      has_food: true
    } = Swarm.Command.move_ant(FakeClient, ant_id, :n)
  end
end
