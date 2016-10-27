defmodule Swarm.SpiralTest do
  use ExUnit.Case, async: true

  test "walks with radius 1" do
    assert [
      {0, 1},
      {-1, 1},
      {-1, 0},
      {-1, -1},
      {0, -1},
      {1, -1},
      {1, 0},
      {1, 1}
    ] == Swarm.Spiral.walk({0, 0}, 1)
  end
end

