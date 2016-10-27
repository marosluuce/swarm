defmodule Location do
  def random(radius) do
    x = trunc(:rand.uniform(radius * 2) - radius)
    y = trunc(:rand.uniform(radius * 2) - radius)

    {x, y}
  end

  def distance_squared({x1, y1}, {x2, y2}) do
    dx = x1 - x2
    dy = y1 - y2

    dx * dx + dy * dy
  end
end
