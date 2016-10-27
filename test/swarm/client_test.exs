defmodule Swarm.ClientTest do
  use ExUnit.Case, async: true

  alias Swarm.Client

  test "it joins with a team name" do
    assert Client.join("name") == "http://url/join/name"
  end

  test "it creates an ant" do
    nest_id = 5
    assert Client.create(nest_id) == "http://url/#{nest_id}/spawn"
  end

  test "it moves an ant" do
    ant_id = 2
    direction = :n
    assert Client.move(ant_id, direction) == "http://url/#{ant_id}/move/n"
  end

  test "it looks around an ant" do
    ant_id = 3
    assert Client.look(ant_id) == "http://url/#{ant_id}/look"
  end

  test "it gets info about an object" do
    id = 10
    assert Client.info(id) == "http://url/#{id}/info"
  end
end
