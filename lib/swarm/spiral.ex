defmodule Swarm.Spiral do

  # This works like magic and I haven't found the source of this formula.
  # See http://stackoverflow.com/a/20591835 for original example.
  def get(n) do
    nRoot = trunc(:math.sqrt(n))

    x = (Float.round(nRoot / 2) * :math.pow(-1, nRoot + 1)) +
         (:math.pow(-1, nRoot + 1) *
          (((nRoot * (nRoot + 1)) - n) -
           abs((nRoot * (nRoot + 1)) - n)) / 2)

    y = (Float.round(nRoot / 2) * :math.pow(-1, nRoot)) +
         (:math.pow(-1, nRoot + 1) *
          (((nRoot * (nRoot + 1)) - n) +
           abs((nRoot * (nRoot + 1)) - n)) / 2)

    {trunc(x), trunc(y)}
  end

  def walk({x, y}, radius, step \\ 1) do
    first = {x, y + 1}
  end
end
