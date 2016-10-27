defmodule Swarm.Move do

  def calculate({x1, y1}, {x2, y2}) do
    dx = x2 - x1
    dy = y2 - y1

    to_direction({dx, dy})
  end

  defp to_direction({x, 0}) when x > 0, do: :e
  defp to_direction({x, 0}) when x < 0, do: :w
  defp to_direction({0, y}) when y > 0, do: :n
  defp to_direction({0, y}) when y < 0, do: :s
  defp to_direction({x, y}) do
    cond do
      x > 0 && y > 0 -> :ne
      x < 0 && y > 0 -> :nw
      x > 0 && y < 0 -> :se
      x < 0 && y < 0 -> :sw
      true -> :same
    end
  end
end
